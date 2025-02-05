PGDMP         7                x            dev    11.8    11.8 t    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    17823    dev    DATABASE     �   CREATE DATABASE dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE dev;
             doadmin    false            �           0    0    dev    DATABASE PROPERTIES     E   ALTER DATABASE dev SET search_path TO '$user', 'public', 'topology';
                  doadmin    false    4003            
            2615    17824    topology    SCHEMA        CREATE SCHEMA topology;
    DROP SCHEMA topology;
             postgres    false            �           0    0    SCHEMA topology    COMMENT     9   COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';
                  postgres    false    10            �           0    0    SCHEMA topology    ACL     =   GRANT USAGE ON SCHEMA topology TO doadmin WITH GRANT OPTION;
                  postgres    false    10                        3079    17825    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                  false            �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                       false    3                        3079    18825    postgis_topology 	   EXTENSION     F   CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;
 !   DROP EXTENSION postgis_topology;
                  false    10    3            �           0    0    EXTENSION postgis_topology    COMMENT     Y   COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';
                       false    4                        3079    18968 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                  false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                       false    2            �            1259    18979    approval    TABLE       CREATE TABLE public.approval (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    comment character varying,
    "time" timestamp without time zone DEFAULT now() NOT NULL,
    approved boolean NOT NULL,
    "operationGufi" uuid,
    "userUsername" character varying
);
    DROP TABLE public.approval;
       public         doadmin    false    2            �            1259    18987    contingency_plan    TABLE     .  CREATE TABLE public.contingency_plan (
    contingency_id integer NOT NULL,
    contingency_cause text NOT NULL,
    contingency_response character varying NOT NULL,
    contingency_polygon public.geometry NOT NULL,
    loiter_altitude integer NOT NULL,
    relative_preference integer NOT NULL,
    contingency_location_description character varying NOT NULL,
    relevant_operation_volumes text NOT NULL,
    valid_time_begin timestamp without time zone NOT NULL,
    valid_time_end timestamp without time zone NOT NULL,
    free_text character varying
);
 $   DROP TABLE public.contingency_plan;
       public         doadmin    false    3    3    3    3    3    3    3    3            �            1259    18993 #   contingency_plan_contingency_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contingency_plan_contingency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.contingency_plan_contingency_id_seq;
       public       doadmin    false    212            �           0    0 #   contingency_plan_contingency_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.contingency_plan_contingency_id_seq OWNED BY public.contingency_plan.contingency_id;
            public       doadmin    false    213            �            1259    18995    negotiation_agreement    TABLE     �  CREATE TABLE public.negotiation_agreement (
    message_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    negotiation_id character varying,
    uss_name character varying NOT NULL,
    uss_name_of_originator character varying NOT NULL,
    uss_name_of_receiver character varying NOT NULL,
    free_text character varying NOT NULL,
    discovery_reference character varying NOT NULL,
    type character varying NOT NULL,
    "gufiOriginatorGufi" uuid,
    "gufiReceiverGufi" uuid
);
 )   DROP TABLE public.negotiation_agreement;
       public         doadmin    false    2            �            1259    19004    notams    TABLE       CREATE TABLE public.notams (
    message_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    text character varying NOT NULL,
    geography public.geometry,
    effective_time_begin timestamp without time zone NOT NULL,
    effective_time_end timestamp without time zone NOT NULL
);
    DROP TABLE public.notams;
       public         doadmin    false    2    3    3    3    3    3    3    3    3            �            1259    19011 	   operation    TABLE     �  CREATE TABLE public.operation (
    gufi uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    uss_name character varying,
    discovery_reference character varying,
    submit_time timestamp without time zone DEFAULT now() NOT NULL,
    update_time timestamp without time zone DEFAULT now() NOT NULL,
    aircraft_comments character varying,
    flight_comments character varying NOT NULL,
    volumes_description character varying,
    airspace_authorization character varying,
    flight_number character varying,
    state character varying NOT NULL,
    controller_location public.geometry,
    gcs_location public.geometry,
    faa_rule character varying,
    contact character varying,
    contact_phone character varying,
    "creatorUsername" character varying,
    "priorityElementsPriority_level" character varying NOT NULL,
    "priorityElementsPriority_status" character varying NOT NULL
);
    DROP TABLE public.operation;
       public         doadmin    false    2    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3            �            1259    19020 ,   operation_contingency_plans_contingency_plan    TABLE     �   CREATE TABLE public.operation_contingency_plans_contingency_plan (
    "operationGufi" uuid NOT NULL,
    "contingencyPlanContingencyId" integer NOT NULL
);
 @   DROP TABLE public.operation_contingency_plans_contingency_plan;
       public         doadmin    false            �            1259    19023 6   operation_negotiation_agreements_negotiation_agreement    TABLE     �   CREATE TABLE public.operation_negotiation_agreements_negotiation_agreement (
    "operationGufi" uuid NOT NULL,
    "negotiationAgreementMessageId" uuid NOT NULL
);
 J   DROP TABLE public.operation_negotiation_agreements_negotiation_agreement;
       public         doadmin    false            �            1259    19026 '   operation_uas_registrations_vehicle_reg    TABLE     �   CREATE TABLE public.operation_uas_registrations_vehicle_reg (
    "operationGufi" uuid NOT NULL,
    "vehicleRegUvin" uuid NOT NULL
);
 ;   DROP TABLE public.operation_uas_registrations_vehicle_reg;
       public         doadmin    false            �            1259    19029    operation_volume    TABLE       CREATE TABLE public.operation_volume (
    id integer NOT NULL,
    ordinal integer DEFAULT 0 NOT NULL,
    volume_type character varying,
    near_structure boolean,
    effective_time_begin timestamp without time zone NOT NULL,
    effective_time_end timestamp without time zone NOT NULL,
    actual_time_end timestamp without time zone,
    min_altitude numeric NOT NULL,
    max_altitude numeric NOT NULL,
    operation_geography public.geometry,
    beyond_visual_line_of_sight boolean NOT NULL,
    "operationGufi" uuid
);
 $   DROP TABLE public.operation_volume;
       public         doadmin    false    3    3    3    3    3    3    3    3            �            1259    19038    operation_volume_id_seq    SEQUENCE     �   CREATE SEQUENCE public.operation_volume_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.operation_volume_id_seq;
       public       doadmin    false    220            �           0    0    operation_volume_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.operation_volume_id_seq OWNED BY public.operation_volume.id;
            public       doadmin    false    221            �            1259    19043    position    TABLE     �   CREATE TABLE public."position" (
    id integer NOT NULL,
    altitude_gps numeric NOT NULL,
    location public.geometry,
    time_sent timestamp without time zone NOT NULL,
    heading integer,
    "gufiGufi" uuid
);
    DROP TABLE public."position";
       public         doadmin    false    3    3    3    3    3    3    3    3            �            1259    19049    position_id_seq    SEQUENCE     �   CREATE SEQUENCE public.position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.position_id_seq;
       public       doadmin    false    222            �           0    0    position_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.position_id_seq OWNED BY public."position".id;
            public       doadmin    false    223            �            1259    19051    restricted_flight_volume    TABLE     �   CREATE TABLE public.restricted_flight_volume (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    geography public.geometry,
    min_altitude numeric,
    max_altitude numeric,
    comments character varying NOT NULL
);
 ,   DROP TABLE public.restricted_flight_volume;
       public         doadmin    false    2    3    3    3    3    3    3    3    3            �            1259    19058    uas_volume_reservation    TABLE       CREATE TABLE public.uas_volume_reservation (
    message_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    uss_name character varying,
    type character varying,
    permitted_uas text,
    required_support text,
    cause character varying,
    geography public.geometry,
    effective_time_begin timestamp without time zone,
    effective_time_end timestamp without time zone,
    actual_time_end timestamp without time zone,
    min_altitude numeric,
    max_altitude numeric,
    reason character varying
);
 *   DROP TABLE public.uas_volume_reservation;
       public         doadmin    false    2    3    3    3    3    3    3    3    3            �            1259    19065 5   uas_volume_reservation_permitted_operations_operation    TABLE     �   CREATE TABLE public.uas_volume_reservation_permitted_operations_operation (
    "uasVolumeReservationMessageId" uuid NOT NULL,
    "operationGufi" uuid NOT NULL
);
 I   DROP TABLE public.uas_volume_reservation_permitted_operations_operation;
       public         doadmin    false            �            1259    19068    user    TABLE     �  CREATE TABLE public."user" (
    username character varying NOT NULL,
    "firstName" character varying NOT NULL,
    "lastName" character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying DEFAULT 'pilot'::character varying NOT NULL,
    "VolumesOfInterest" public.geometry,
    "statusId" integer,
    "settingsLangauge" character varying DEFAULT 'EN'::character varying NOT NULL
);
    DROP TABLE public."user";
       public         doadmin    false    3    3    3    3    3    3    3    3            �            1259    19076    user_status    TABLE     �   CREATE TABLE public.user_status (
    id integer NOT NULL,
    token character varying DEFAULT ''::character varying NOT NULL,
    status character varying DEFAULT 'unconfirmed'::character varying NOT NULL
);
    DROP TABLE public.user_status;
       public         doadmin    false            �            1259    19084    user_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.user_status_id_seq;
       public       doadmin    false    228            �           0    0    user_status_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.user_status_id_seq OWNED BY public.user_status.id;
            public       doadmin    false    229            �            1259    19086    utm_message    TABLE     �  CREATE TABLE public.utm_message (
    message_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    uss_name character varying NOT NULL,
    discovery_reference character varying,
    time_sent timestamp without time zone NOT NULL,
    severity character varying NOT NULL,
    message_type character varying NOT NULL,
    prev_message_id character varying,
    free_text character varying NOT NULL,
    "operationGufi" uuid
);
    DROP TABLE public.utm_message;
       public         doadmin    false    2            �            1259    19093    vehicle_reg    TABLE       CREATE TABLE public.vehicle_reg (
    uvin uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    "nNumber" character varying,
    "faaNumber" character varying,
    "vehicleName" character varying NOT NULL,
    manufacturer character varying,
    model character varying,
    class character varying NOT NULL,
    "accessType" character varying,
    "vehicleTypeId" character varying,
    "org-uuid" character varying,
    "registeredByUsername" character varying
);
    DROP TABLE public.vehicle_reg;
       public         doadmin    false    2            �           0    0    TABLE layer    ACL     @   GRANT ALL ON TABLE topology.layer TO doadmin WITH GRANT OPTION;
            topology       postgres    false    207            �           0    0    TABLE topology    ACL     C   GRANT ALL ON TABLE topology.topology TO doadmin WITH GRANT OPTION;
            topology       postgres    false    206            �           0    0    SEQUENCE topology_id_seq    ACL     O   GRANT USAGE ON SEQUENCE topology.topology_id_seq TO doadmin WITH GRANT OPTION;
            topology       postgres    false    205            �           2604    19101    contingency_plan contingency_id    DEFAULT     �   ALTER TABLE ONLY public.contingency_plan ALTER COLUMN contingency_id SET DEFAULT nextval('public.contingency_plan_contingency_id_seq'::regclass);
 N   ALTER TABLE public.contingency_plan ALTER COLUMN contingency_id DROP DEFAULT;
       public       doadmin    false    213    212            �           2604    19102    operation_volume id    DEFAULT     z   ALTER TABLE ONLY public.operation_volume ALTER COLUMN id SET DEFAULT nextval('public.operation_volume_id_seq'::regclass);
 B   ALTER TABLE public.operation_volume ALTER COLUMN id DROP DEFAULT;
       public       doadmin    false    221    220            �           2604    19103    position id    DEFAULT     l   ALTER TABLE ONLY public."position" ALTER COLUMN id SET DEFAULT nextval('public.position_id_seq'::regclass);
 <   ALTER TABLE public."position" ALTER COLUMN id DROP DEFAULT;
       public       doadmin    false    223    222            �           2604    19104    user_status id    DEFAULT     p   ALTER TABLE ONLY public.user_status ALTER COLUMN id SET DEFAULT nextval('public.user_status_id_seq'::regclass);
 =   ALTER TABLE public.user_status ALTER COLUMN id DROP DEFAULT;
       public       doadmin    false    229    228            �          0    18979    approval 
   TABLE DATA               b   COPY public.approval (id, comment, "time", approved, "operationGufi", "userUsername") FROM stdin;
    public       doadmin    false    211   S�       �          0    18987    contingency_plan 
   TABLE DATA               	  COPY public.contingency_plan (contingency_id, contingency_cause, contingency_response, contingency_polygon, loiter_altitude, relative_preference, contingency_location_description, relevant_operation_volumes, valid_time_begin, valid_time_end, free_text) FROM stdin;
    public       doadmin    false    212   p�       �          0    18995    negotiation_agreement 
   TABLE DATA               �   COPY public.negotiation_agreement (message_id, negotiation_id, uss_name, uss_name_of_originator, uss_name_of_receiver, free_text, discovery_reference, type, "gufiOriginatorGufi", "gufiReceiverGufi") FROM stdin;
    public       doadmin    false    214   ��       �          0    19004    notams 
   TABLE DATA               g   COPY public.notams (message_id, text, geography, effective_time_begin, effective_time_end) FROM stdin;
    public       doadmin    false    215   ��       �          0    19011 	   operation 
   TABLE DATA               f  COPY public.operation (gufi, uss_name, discovery_reference, submit_time, update_time, aircraft_comments, flight_comments, volumes_description, airspace_authorization, flight_number, state, controller_location, gcs_location, faa_rule, contact, contact_phone, "creatorUsername", "priorityElementsPriority_level", "priorityElementsPriority_status") FROM stdin;
    public       doadmin    false    216   ǩ       �          0    19020 ,   operation_contingency_plans_contingency_plan 
   TABLE DATA               w   COPY public.operation_contingency_plans_contingency_plan ("operationGufi", "contingencyPlanContingencyId") FROM stdin;
    public       doadmin    false    217   �       �          0    19023 6   operation_negotiation_agreements_negotiation_agreement 
   TABLE DATA               �   COPY public.operation_negotiation_agreements_negotiation_agreement ("operationGufi", "negotiationAgreementMessageId") FROM stdin;
    public       doadmin    false    218   �       �          0    19026 '   operation_uas_registrations_vehicle_reg 
   TABLE DATA               d   COPY public.operation_uas_registrations_vehicle_reg ("operationGufi", "vehicleRegUvin") FROM stdin;
    public       doadmin    false    219   �       �          0    19029    operation_volume 
   TABLE DATA               �   COPY public.operation_volume (id, ordinal, volume_type, near_structure, effective_time_begin, effective_time_end, actual_time_end, min_altitude, max_altitude, operation_geography, beyond_visual_line_of_sight, "operationGufi") FROM stdin;
    public       doadmin    false    220   ;�       �          0    19043    position 
   TABLE DATA               `   COPY public."position" (id, altitude_gps, location, time_sent, heading, "gufiGufi") FROM stdin;
    public       doadmin    false    222   X�       �          0    19051    restricted_flight_volume 
   TABLE DATA               g   COPY public.restricted_flight_volume (id, geography, min_altitude, max_altitude, comments) FROM stdin;
    public       doadmin    false    224   u�       �          0    18130    spatial_ref_sys 
   TABLE DATA               X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public       postgres    false    201   ��       �          0    19058    uas_volume_reservation 
   TABLE DATA               �   COPY public.uas_volume_reservation (message_id, uss_name, type, permitted_uas, required_support, cause, geography, effective_time_begin, effective_time_end, actual_time_end, min_altitude, max_altitude, reason) FROM stdin;
    public       doadmin    false    225   ��       �          0    19065 5   uas_volume_reservation_permitted_operations_operation 
   TABLE DATA               �   COPY public.uas_volume_reservation_permitted_operations_operation ("uasVolumeReservationMessageId", "operationGufi") FROM stdin;
    public       doadmin    false    226   ̪       �          0    19068    user 
   TABLE DATA               �   COPY public."user" (username, "firstName", "lastName", email, password, role, "VolumesOfInterest", "statusId", "settingsLangauge") FROM stdin;
    public       doadmin    false    227   �       �          0    19076    user_status 
   TABLE DATA               8   COPY public.user_status (id, token, status) FROM stdin;
    public       doadmin    false    228   f�       �          0    19086    utm_message 
   TABLE DATA               �   COPY public.utm_message (message_id, uss_name, discovery_reference, time_sent, severity, message_type, prev_message_id, free_text, "operationGufi") FROM stdin;
    public       doadmin    false    230   ��       �          0    19093    vehicle_reg 
   TABLE DATA               �   COPY public.vehicle_reg (uvin, date, "nNumber", "faaNumber", "vehicleName", manufacturer, model, class, "accessType", "vehicleTypeId", "org-uuid", "registeredByUsername") FROM stdin;
    public       doadmin    false    231   ��       �          0    18828    topology 
   TABLE DATA               G   COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
    topology       postgres    false    206   ʫ       �          0    18841    layer 
   TABLE DATA               �   COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
    topology       postgres    false    207   �       �           0    0 #   contingency_plan_contingency_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.contingency_plan_contingency_id_seq', 41, true);
            public       doadmin    false    213            �           0    0    operation_volume_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.operation_volume_id_seq', 42, true);
            public       doadmin    false    221            �           0    0    position_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.position_id_seq', 2637, true);
            public       doadmin    false    223            �           0    0    user_status_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.user_status_id_seq', 25, true);
            public       doadmin    false    229            �           2606    19106 /   contingency_plan PK_020f9382c5aff5281d54c12f14d 
   CONSTRAINT     {   ALTER TABLE ONLY public.contingency_plan
    ADD CONSTRAINT "PK_020f9382c5aff5281d54c12f14d" PRIMARY KEY (contingency_id);
 [   ALTER TABLE ONLY public.contingency_plan DROP CONSTRAINT "PK_020f9382c5aff5281d54c12f14d";
       public         doadmin    false    212            �           2606    19108 4   negotiation_agreement PK_054ea176954f84c2bdb15cd5946 
   CONSTRAINT     |   ALTER TABLE ONLY public.negotiation_agreement
    ADD CONSTRAINT "PK_054ea176954f84c2bdb15cd5946" PRIMARY KEY (message_id);
 `   ALTER TABLE ONLY public.negotiation_agreement DROP CONSTRAINT "PK_054ea176954f84c2bdb15cd5946";
       public         doadmin    false    214            �           2606    19110 F   operation_uas_registrations_vehicle_reg PK_25c26a40a75de39b87b55402746 
   CONSTRAINT     �   ALTER TABLE ONLY public.operation_uas_registrations_vehicle_reg
    ADD CONSTRAINT "PK_25c26a40a75de39b87b55402746" PRIMARY KEY ("operationGufi", "vehicleRegUvin");
 r   ALTER TABLE ONLY public.operation_uas_registrations_vehicle_reg DROP CONSTRAINT "PK_25c26a40a75de39b87b55402746";
       public         doadmin    false    219    219            �           2606    19112 *   vehicle_reg PK_3ef4d8d2686a65d08bbce9c0d5d 
   CONSTRAINT     l   ALTER TABLE ONLY public.vehicle_reg
    ADD CONSTRAINT "PK_3ef4d8d2686a65d08bbce9c0d5d" PRIMARY KEY (uvin);
 V   ALTER TABLE ONLY public.vehicle_reg DROP CONSTRAINT "PK_3ef4d8d2686a65d08bbce9c0d5d";
       public         doadmin    false    231            �           2606    19114 5   uas_volume_reservation PK_4a0f40ea6a1269f8be4454fbddd 
   CONSTRAINT     }   ALTER TABLE ONLY public.uas_volume_reservation
    ADD CONSTRAINT "PK_4a0f40ea6a1269f8be4454fbddd" PRIMARY KEY (message_id);
 a   ALTER TABLE ONLY public.uas_volume_reservation DROP CONSTRAINT "PK_4a0f40ea6a1269f8be4454fbddd";
       public         doadmin    false    225            �           2606    19116 U   operation_negotiation_agreements_negotiation_agreement PK_6e23b38c23db73ca286622a24c9 
   CONSTRAINT     �   ALTER TABLE ONLY public.operation_negotiation_agreements_negotiation_agreement
    ADD CONSTRAINT "PK_6e23b38c23db73ca286622a24c9" PRIMARY KEY ("operationGufi", "negotiationAgreementMessageId");
 �   ALTER TABLE ONLY public.operation_negotiation_agreements_negotiation_agreement DROP CONSTRAINT "PK_6e23b38c23db73ca286622a24c9";
       public         doadmin    false    218    218            �           2606    19118 /   operation_volume PK_6f8d7a4f746c0dae8122a6c66ef 
   CONSTRAINT     o   ALTER TABLE ONLY public.operation_volume
    ADD CONSTRAINT "PK_6f8d7a4f746c0dae8122a6c66ef" PRIMARY KEY (id);
 [   ALTER TABLE ONLY public.operation_volume DROP CONSTRAINT "PK_6f8d7a4f746c0dae8122a6c66ef";
       public         doadmin    false    220            �           2606    19120 K   operation_contingency_plans_contingency_plan PK_70108fb0c583ad15fca2c75f64c 
   CONSTRAINT     �   ALTER TABLE ONLY public.operation_contingency_plans_contingency_plan
    ADD CONSTRAINT "PK_70108fb0c583ad15fca2c75f64c" PRIMARY KEY ("operationGufi", "contingencyPlanContingencyId");
 w   ALTER TABLE ONLY public.operation_contingency_plans_contingency_plan DROP CONSTRAINT "PK_70108fb0c583ad15fca2c75f64c";
       public         doadmin    false    217    217            �           2606    19122 #   user PK_78a916df40e02a9deb1c4b75edb 
   CONSTRAINT     k   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_78a916df40e02a9deb1c4b75edb" PRIMARY KEY (username);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "PK_78a916df40e02a9deb1c4b75edb";
       public         doadmin    false    227            �           2606    19124 *   user_status PK_892a2061d6a04a7e2efe4c26d6f 
   CONSTRAINT     j   ALTER TABLE ONLY public.user_status
    ADD CONSTRAINT "PK_892a2061d6a04a7e2efe4c26d6f" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.user_status DROP CONSTRAINT "PK_892a2061d6a04a7e2efe4c26d6f";
       public         doadmin    false    228            �           2606    19126 *   utm_message PK_95acb7ef6451933c387a0b76d06 
   CONSTRAINT     r   ALTER TABLE ONLY public.utm_message
    ADD CONSTRAINT "PK_95acb7ef6451933c387a0b76d06" PRIMARY KEY (message_id);
 V   ALTER TABLE ONLY public.utm_message DROP CONSTRAINT "PK_95acb7ef6451933c387a0b76d06";
       public         doadmin    false    230            �           2606    19128 '   approval PK_97bfd1cd9dff3c1302229da6b5c 
   CONSTRAINT     g   ALTER TABLE ONLY public.approval
    ADD CONSTRAINT "PK_97bfd1cd9dff3c1302229da6b5c" PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.approval DROP CONSTRAINT "PK_97bfd1cd9dff3c1302229da6b5c";
       public         doadmin    false    211            �           2606    19130 7   restricted_flight_volume PK_a21f5363c7193ae3df374f4d838 
   CONSTRAINT     w   ALTER TABLE ONLY public.restricted_flight_volume
    ADD CONSTRAINT "PK_a21f5363c7193ae3df374f4d838" PRIMARY KEY (id);
 c   ALTER TABLE ONLY public.restricted_flight_volume DROP CONSTRAINT "PK_a21f5363c7193ae3df374f4d838";
       public         doadmin    false    224            �           2606    19132 '   position PK_b7f483581562b4dc62ae1a5b7e2 
   CONSTRAINT     i   ALTER TABLE ONLY public."position"
    ADD CONSTRAINT "PK_b7f483581562b4dc62ae1a5b7e2" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public."position" DROP CONSTRAINT "PK_b7f483581562b4dc62ae1a5b7e2";
       public         doadmin    false    222            �           2606    19134 %   notams PK_bec37853b8ff45ee4321c4d1c7c 
   CONSTRAINT     m   ALTER TABLE ONLY public.notams
    ADD CONSTRAINT "PK_bec37853b8ff45ee4321c4d1c7c" PRIMARY KEY (message_id);
 Q   ALTER TABLE ONLY public.notams DROP CONSTRAINT "PK_bec37853b8ff45ee4321c4d1c7c";
       public         doadmin    false    215            �           2606    19136 (   operation PK_e1bda9c1cfec0b07d241b467f89 
   CONSTRAINT     j   ALTER TABLE ONLY public.operation
    ADD CONSTRAINT "PK_e1bda9c1cfec0b07d241b467f89" PRIMARY KEY (gufi);
 T   ALTER TABLE ONLY public.operation DROP CONSTRAINT "PK_e1bda9c1cfec0b07d241b467f89";
       public         doadmin    false    216            �           2606    19138 T   uas_volume_reservation_permitted_operations_operation PK_f62daf49f753b4b9c974caa3049 
   CONSTRAINT     �   ALTER TABLE ONLY public.uas_volume_reservation_permitted_operations_operation
    ADD CONSTRAINT "PK_f62daf49f753b4b9c974caa3049" PRIMARY KEY ("uasVolumeReservationMessageId", "operationGufi");
 �   ALTER TABLE ONLY public.uas_volume_reservation_permitted_operations_operation DROP CONSTRAINT "PK_f62daf49f753b4b9c974caa3049";
       public         doadmin    false    226    226            �           2606    19140 '   approval REL_cfc2d5c0cbf49ceadd5e6018b0 
   CONSTRAINT     o   ALTER TABLE ONLY public.approval
    ADD CONSTRAINT "REL_cfc2d5c0cbf49ceadd5e6018b0" UNIQUE ("operationGufi");
 S   ALTER TABLE ONLY public.approval DROP CONSTRAINT "REL_cfc2d5c0cbf49ceadd5e6018b0";
       public         doadmin    false    211            �           2606    19142 #   user REL_dc18daa696860586ba4667a9d3 
   CONSTRAINT     h   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "REL_dc18daa696860586ba4667a9d3" UNIQUE ("statusId");
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "REL_dc18daa696860586ba4667a9d3";
       public         doadmin    false    227            �           2606    19144 #   user UQ_e12875dfb3b1d92d7d7c5377e22 
   CONSTRAINT     c   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22";
       public         doadmin    false    227            �           1259    19145    IDX_0dcc87797ce589d4f263a5b64b    INDEX     �   CREATE INDEX "IDX_0dcc87797ce589d4f263a5b64b" ON public.uas_volume_reservation_permitted_operations_operation USING btree ("operationGufi");
 4   DROP INDEX public."IDX_0dcc87797ce589d4f263a5b64b";
       public         doadmin    false    226            �           1259    19146    IDX_59a0a1ef60908a502ecbf3b968    INDEX     �   CREATE INDEX "IDX_59a0a1ef60908a502ecbf3b968" ON public.operation_contingency_plans_contingency_plan USING btree ("contingencyPlanContingencyId");
 4   DROP INDEX public."IDX_59a0a1ef60908a502ecbf3b968";
       public         doadmin    false    217            �           1259    19147    IDX_6a53a0b3ef2b9a6cac6203f4bf    INDEX     �   CREATE INDEX "IDX_6a53a0b3ef2b9a6cac6203f4bf" ON public.operation_negotiation_agreements_negotiation_agreement USING btree ("operationGufi");
 4   DROP INDEX public."IDX_6a53a0b3ef2b9a6cac6203f4bf";
       public         doadmin    false    218            �           1259    19148    IDX_804f83cd102175169b156c5a94    INDEX     �   CREATE INDEX "IDX_804f83cd102175169b156c5a94" ON public.operation_uas_registrations_vehicle_reg USING btree ("vehicleRegUvin");
 4   DROP INDEX public."IDX_804f83cd102175169b156c5a94";
       public         doadmin    false    219            �           1259    19149    IDX_bd244ee4acb7f76fcba3131b61    INDEX     �   CREATE INDEX "IDX_bd244ee4acb7f76fcba3131b61" ON public.operation_contingency_plans_contingency_plan USING btree ("operationGufi");
 4   DROP INDEX public."IDX_bd244ee4acb7f76fcba3131b61";
       public         doadmin    false    217            �           1259    19150    IDX_c66cf93ac9e62ffe25cc6e343a    INDEX     �   CREATE INDEX "IDX_c66cf93ac9e62ffe25cc6e343a" ON public.operation_negotiation_agreements_negotiation_agreement USING btree ("negotiationAgreementMessageId");
 4   DROP INDEX public."IDX_c66cf93ac9e62ffe25cc6e343a";
       public         doadmin    false    218            �           1259    19151    IDX_d7c158bedf316f32723220f223    INDEX     �   CREATE INDEX "IDX_d7c158bedf316f32723220f223" ON public.uas_volume_reservation_permitted_operations_operation USING btree ("uasVolumeReservationMessageId");
 4   DROP INDEX public."IDX_d7c158bedf316f32723220f223";
       public         doadmin    false    226            �           1259    19152    IDX_e4ecef635b791fc446ce7525c6    INDEX        CREATE INDEX "IDX_e4ecef635b791fc446ce7525c6" ON public.operation_uas_registrations_vehicle_reg USING btree ("operationGufi");
 4   DROP INDEX public."IDX_e4ecef635b791fc446ce7525c6";
       public         doadmin    false    219            	           2606    19153 *   utm_message FK_00ae4b88e7efffa6c14b675346d    FK CONSTRAINT     �   ALTER TABLE ONLY public.utm_message
    ADD CONSTRAINT "FK_00ae4b88e7efffa6c14b675346d" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi);
 V   ALTER TABLE ONLY public.utm_message DROP CONSTRAINT "FK_00ae4b88e7efffa6c14b675346d";
       public       doadmin    false    3796    216    230                       2606    19158 T   uas_volume_reservation_permitted_operations_operation FK_0dcc87797ce589d4f263a5b64b1    FK CONSTRAINT     �   ALTER TABLE ONLY public.uas_volume_reservation_permitted_operations_operation
    ADD CONSTRAINT "FK_0dcc87797ce589d4f263a5b64b1" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.uas_volume_reservation_permitted_operations_operation DROP CONSTRAINT "FK_0dcc87797ce589d4f263a5b64b1";
       public       doadmin    false    226    3796    216            �           2606    19163 K   operation_contingency_plans_contingency_plan FK_59a0a1ef60908a502ecbf3b968b    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_contingency_plans_contingency_plan
    ADD CONSTRAINT "FK_59a0a1ef60908a502ecbf3b968b" FOREIGN KEY ("contingencyPlanContingencyId") REFERENCES public.contingency_plan(contingency_id) ON DELETE CASCADE;
 w   ALTER TABLE ONLY public.operation_contingency_plans_contingency_plan DROP CONSTRAINT "FK_59a0a1ef60908a502ecbf3b968b";
       public       doadmin    false    212    3790    217            �           2606    19168 (   operation FK_69664a82786e4d23205aae9c56a    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation
    ADD CONSTRAINT "FK_69664a82786e4d23205aae9c56a" FOREIGN KEY ("creatorUsername") REFERENCES public."user"(username);
 T   ALTER TABLE ONLY public.operation DROP CONSTRAINT "FK_69664a82786e4d23205aae9c56a";
       public       doadmin    false    216    227    3822                       2606    19173 U   operation_negotiation_agreements_negotiation_agreement FK_6a53a0b3ef2b9a6cac6203f4bfa    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_negotiation_agreements_negotiation_agreement
    ADD CONSTRAINT "FK_6a53a0b3ef2b9a6cac6203f4bfa" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.operation_negotiation_agreements_negotiation_agreement DROP CONSTRAINT "FK_6a53a0b3ef2b9a6cac6203f4bfa";
       public       doadmin    false    216    3796    218                       2606    19178 /   operation_volume FK_7e9ebea6ba70766e8e2be5246a0    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_volume
    ADD CONSTRAINT "FK_7e9ebea6ba70766e8e2be5246a0" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.operation_volume DROP CONSTRAINT "FK_7e9ebea6ba70766e8e2be5246a0";
       public       doadmin    false    220    3796    216                       2606    19183 F   operation_uas_registrations_vehicle_reg FK_804f83cd102175169b156c5a946    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_uas_registrations_vehicle_reg
    ADD CONSTRAINT "FK_804f83cd102175169b156c5a946" FOREIGN KEY ("vehicleRegUvin") REFERENCES public.vehicle_reg(uvin) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.operation_uas_registrations_vehicle_reg DROP CONSTRAINT "FK_804f83cd102175169b156c5a946";
       public       doadmin    false    3832    231    219                       2606    19188 '   position FK_8b93d789b2323e437390fc8330c    FK CONSTRAINT     �   ALTER TABLE ONLY public."position"
    ADD CONSTRAINT "FK_8b93d789b2323e437390fc8330c" FOREIGN KEY ("gufiGufi") REFERENCES public.operation(gufi);
 U   ALTER TABLE ONLY public."position" DROP CONSTRAINT "FK_8b93d789b2323e437390fc8330c";
       public       doadmin    false    222    3796    216            �           2606    19193 '   approval FK_9b119f185663014d3a93b667437    FK CONSTRAINT     �   ALTER TABLE ONLY public.approval
    ADD CONSTRAINT "FK_9b119f185663014d3a93b667437" FOREIGN KEY ("userUsername") REFERENCES public."user"(username);
 S   ALTER TABLE ONLY public.approval DROP CONSTRAINT "FK_9b119f185663014d3a93b667437";
       public       doadmin    false    3822    211    227            
           2606    19198 *   vehicle_reg FK_acaa7cf68714e73fc17dcdac6d6    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehicle_reg
    ADD CONSTRAINT "FK_acaa7cf68714e73fc17dcdac6d6" FOREIGN KEY ("registeredByUsername") REFERENCES public."user"(username);
 V   ALTER TABLE ONLY public.vehicle_reg DROP CONSTRAINT "FK_acaa7cf68714e73fc17dcdac6d6";
       public       doadmin    false    227    231    3822            �           2606    19203 K   operation_contingency_plans_contingency_plan FK_bd244ee4acb7f76fcba3131b61c    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_contingency_plans_contingency_plan
    ADD CONSTRAINT "FK_bd244ee4acb7f76fcba3131b61c" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi) ON DELETE CASCADE;
 w   ALTER TABLE ONLY public.operation_contingency_plans_contingency_plan DROP CONSTRAINT "FK_bd244ee4acb7f76fcba3131b61c";
       public       doadmin    false    217    216    3796                        2606    19208 U   operation_negotiation_agreements_negotiation_agreement FK_c66cf93ac9e62ffe25cc6e343ac    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_negotiation_agreements_negotiation_agreement
    ADD CONSTRAINT "FK_c66cf93ac9e62ffe25cc6e343ac" FOREIGN KEY ("negotiationAgreementMessageId") REFERENCES public.negotiation_agreement(message_id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.operation_negotiation_agreements_negotiation_agreement DROP CONSTRAINT "FK_c66cf93ac9e62ffe25cc6e343ac";
       public       doadmin    false    214    218    3792            �           2606    19213 '   approval FK_cfc2d5c0cbf49ceadd5e6018b00    FK CONSTRAINT     �   ALTER TABLE ONLY public.approval
    ADD CONSTRAINT "FK_cfc2d5c0cbf49ceadd5e6018b00" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi);
 S   ALTER TABLE ONLY public.approval DROP CONSTRAINT "FK_cfc2d5c0cbf49ceadd5e6018b00";
       public       doadmin    false    216    211    3796                       2606    19218 T   uas_volume_reservation_permitted_operations_operation FK_d7c158bedf316f32723220f2235    FK CONSTRAINT     �   ALTER TABLE ONLY public.uas_volume_reservation_permitted_operations_operation
    ADD CONSTRAINT "FK_d7c158bedf316f32723220f2235" FOREIGN KEY ("uasVolumeReservationMessageId") REFERENCES public.uas_volume_reservation(message_id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.uas_volume_reservation_permitted_operations_operation DROP CONSTRAINT "FK_d7c158bedf316f32723220f2235";
       public       doadmin    false    3816    225    226            �           2606    19223 4   negotiation_agreement FK_d91a0ab35a030cf4edb6fc66e0b    FK CONSTRAINT     �   ALTER TABLE ONLY public.negotiation_agreement
    ADD CONSTRAINT "FK_d91a0ab35a030cf4edb6fc66e0b" FOREIGN KEY ("gufiReceiverGufi") REFERENCES public.operation(gufi);
 `   ALTER TABLE ONLY public.negotiation_agreement DROP CONSTRAINT "FK_d91a0ab35a030cf4edb6fc66e0b";
       public       doadmin    false    216    214    3796                       2606    19228 #   user FK_dc18daa696860586ba4667a9d31    FK CONSTRAINT     �   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "FK_dc18daa696860586ba4667a9d31" FOREIGN KEY ("statusId") REFERENCES public.user_status(id);
 Q   ALTER TABLE ONLY public."user" DROP CONSTRAINT "FK_dc18daa696860586ba4667a9d31";
       public       doadmin    false    227    228    3828            �           2606    19233 4   negotiation_agreement FK_df77c63d732afe42e0be743fe8f    FK CONSTRAINT     �   ALTER TABLE ONLY public.negotiation_agreement
    ADD CONSTRAINT "FK_df77c63d732afe42e0be743fe8f" FOREIGN KEY ("gufiOriginatorGufi") REFERENCES public.operation(gufi);
 `   ALTER TABLE ONLY public.negotiation_agreement DROP CONSTRAINT "FK_df77c63d732afe42e0be743fe8f";
       public       doadmin    false    214    216    3796                       2606    19238 F   operation_uas_registrations_vehicle_reg FK_e4ecef635b791fc446ce7525c61    FK CONSTRAINT     �   ALTER TABLE ONLY public.operation_uas_registrations_vehicle_reg
    ADD CONSTRAINT "FK_e4ecef635b791fc446ce7525c61" FOREIGN KEY ("operationGufi") REFERENCES public.operation(gufi) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.operation_uas_registrations_vehicle_reg DROP CONSTRAINT "FK_e4ecef635b791fc446ce7525c61";
       public       doadmin    false    3796    216    219            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   m   x�KL����tD"A�CJQ~^Zfj�^r~.��Q������o��K�{q�G�oTRXD���o��yIz�k�~b`@�e�K�AXH�c��{JF�S��;�<�?NCNW?�=... �)$Z      �      x�3��L��K�,�MM����� 0��      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     