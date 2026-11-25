-- Reference schema; SQLAlchemy models create the initial development schema.
CREATE TABLE IF NOT EXISTS currencies (
  code CHAR(3) PRIMARY KEY CHECK (code IN ('USD','IQD')),
  name_ku VARCHAR(80) NOT NULL
);
INSERT INTO currencies(code,name_ku) VALUES ('USD','دۆلاری ئەمریکی'),('IQD','دیناری عێراقی')
ON CONFLICT (code) DO NOTHING;

CREATE TABLE IF NOT EXISTS exchange_rates (
  id BIGSERIAL PRIMARY KEY,
  base_currency CHAR(3) NOT NULL REFERENCES currencies(code),
  quote_currency CHAR(3) NOT NULL REFERENCES currencies(code),
  rate NUMERIC(20,8) NOT NULL CHECK (rate > 0),
  effective_date DATE NOT NULL,
  source VARCHAR(120),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (base_currency <> quote_currency),
  UNIQUE(base_currency, quote_currency, effective_date)
);
