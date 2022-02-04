CREATE TABLE adults (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    nutritional_value INT NOT NULL,
    nutritional_monitoring BOOLEAN DEFAULT false NOT NULL,
    blood_pressure_systolic INT NOT NULL,
    blood_pressure_diastolic INT NOT NULL,
    blood_pressure_monitoring BOOLEAN DEFAULT false NOT NULL,
    diabetes INT NOT NULL,
    glucose_monitoring BOOLEAN DEFAULT false NOT NULL,
    diabetes_treatment INT NOT NULL,
    lipid_disorder INT NOT NULL,
    lipid_disorder_monitoring BOOLEAN DEFAULT false NOT NULL,
    lipid_disorder_treatment BOOLEAN DEFAULT false NOT NULL,
    immunization INT NOT NULL,
    smoking_cessation INT NOT NULL,
    date TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    patient UUID NOT NULL
);
CREATE TABLE gynecologies (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    cevicouterino_tracking INT NOT NULL,
    last_pap_result INT NOT NULL,
    contraception INT NOT NULL,
    tracking_its INT NOT NULL,
    teen_boarding BOOLEAN DEFAULT false NOT NULL,
    hpv_immunization INT NOT NULL,
    date TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    patient UUID NOT NULL
);
CREATE TABLE pediatrics (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    immunization INT NOT NULL,
    breastfeeding INT NOT NULL,
    date TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    patient UUID NOT NULL,
    breastfeeding_promotion BOOLEAN DEFAULT false NOT NULL,
    nutritional_promotion BOOLEAN DEFAULT false NOT NULL,
    nutritional_status INT NOT NULL,
    accident_prevention_promotion INT NOT NULL,
    oral_health INT NOT NULL,
    oral_health_promotion BOOLEAN DEFAULT false NOT NULL,
    track_ophthalmological_problems INT NOT NULL,
    track_hearing_problems INT NOT NULL,
    track_metabolic_problems INT NOT NULL,
    mental_health INT NOT NULL
);
CREATE TABLE obstetrics (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    date TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    patient UUID NOT NULL,
    psychoprophylaxis INT NOT NULL,
    nutritional_status INT NOT NULL,
    nutritional_status_treatment BOOLEAN DEFAULT false NOT NULL,
    physical_activity_prescription INT NOT NULL,
    immunization INT NOT NULL,
    perinatal_investigations INT NOT NULL,
    breastfeeding INT NOT NULL,
    its_promotion BOOLEAN DEFAULT false NOT NULL,
    problematic_consumption INT NOT NULL
);
