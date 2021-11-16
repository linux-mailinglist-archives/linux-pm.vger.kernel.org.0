Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFD453217
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhKPM2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:28:32 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45647 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbhKPM2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:28:32 -0500
Received: by mail-lf1-f42.google.com with SMTP id m27so28340076lfj.12;
        Tue, 16 Nov 2021 04:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WRFZ9VTjiWEB6JeEorrAKAYQgvA2HAsGTHlfXpHVoY=;
        b=P8XIKHkEG7wV7FH5SFlBLb2N/Hlm+AdDOhMdFF3Z2u9s+gg22UC7ygZGclKDhvTY2C
         oMatuZp/vjpgydbKducZIbd+Cjd3OeTOa1nim5ZSEwaiKpYGf7oleQ/7jQi6so0jlBCe
         TlbVrU7YGNrzq465vkpOlbOGwKxg66+zKeKVRdoJNSsS6tpAffjAW4dq3OpK1IURFlvL
         tsO+NCNSFIjabCfyKle3k2dc8Sxq3mA7b8vdWn4tDtUWck1CyI58ODiR60KiTwIdh/rs
         ng8O5Dy6hx/RLz8lshFxF7bjmHtDHs8qnnXLUd8mb3fW/3xLO5O/qy/FqVHlhO5hBk1b
         Iejg==
X-Gm-Message-State: AOAM533gsu40xhLfuXQsjCT89KdHcIeBopgfyL/INQIL7KOc8RJB5t8G
        ioWelCHIlRRcWLTe+2tFqx/T86Dx2aM=
X-Google-Smtp-Source: ABdhPJyr+pHVzUU8nxYhtR5y3GtUCUKJqDylMndPFm6NlnXqESbFAJ8Ri30tuv2QeT2WLX1z+5ABbQ==
X-Received: by 2002:ac2:4c85:: with SMTP id d5mr6394851lfl.452.1637065533851;
        Tue, 16 Nov 2021 04:25:33 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id x40sm1938781lfa.130.2021.11.16.04.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:25:33 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:25:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH v3 2/9] power: supply: add cap2ocv batinfo helper
Message-ID: <20cfdc60b148646a0473640a8efdb056b207c56e.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UEBZoF6nR/AJ1d6"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--1UEBZoF6nR/AJ1d6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The power-supply core supports concept of OCV (Open Circuit Voltage) =3D>
SOC (State Of Charge) conversion tables. Usually these tables are used
to estimate SOC based on OCV. Some systems use so called "Zero Adjust"
where at the near end-of-battery condition the SOC from coulomb counter
is used to retrieve the OCV - and OCV and VSYS difference is used to
re-estimate the battery capacity.

Add helper to do look-up the other-way around and also get the OCV
based on SOC

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
RFC v3:
 - Kerneldoc fixes
---
 drivers/power/supply/power_supply_core.c | 69 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  5 ++
 2 files changed, 74 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index fc12a4f407f4..295672165836 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -806,6 +806,48 @@ int power_supply_temp2resist_simple(struct power_suppl=
y_resistance_temp_table *t
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
=20
+/**
+ * power_supply_dcap2ocv_simple() - find the battery OCV by capacity
+ * @table: Pointer to battery OCV/CAP lookup table
+ * @table_len: OCV/CAP table length
+ * @cap: Current cap value in units of 0.1%
+ *
+ * OCV (Open Circuit Voltage) is often used to estimate the battery SOC (S=
tate
+ * Of Charge). Usually conversion tables are used to store the correspondi=
ng
+ * OCV and SOC. Systems which use so called "Zero Adjust" where at the near
+ * end-of-battery condition the SOC from coulomb counter is used to retrie=
ve
+ * the OCV - and OCV and VSYS difference is used to re-estimate the battery
+ * capacity. This helper function can be used to look up battery OCV accor=
ding
+ * to current capacity value from one OCV table, and the OCV table must be
+ * ordered descending.
+ *
+ * Return: the battery OCV in uV.
+ */
+int power_supply_dcap2ocv_simple(struct power_supply_battery_ocv_table *ta=
ble,
+				int table_len, int dcap)
+{
+	int i, ocv, tmp;
+
+	for (i =3D 0; i < table_len; i++)
+		if (dcap > table[i].capacity * 10)
+			break;
+
+	if (i > 0 && i < table_len) {
+		tmp =3D (table[i - 1].ocv - table[i].ocv) *
+		      (dcap - table[i].capacity * 10);
+
+		tmp /=3D (table[i - 1].capacity - table[i].capacity) * 10;
+		ocv =3D tmp + table[i].ocv;
+	} else if (i =3D=3D 0) {
+		ocv =3D table[0].ocv;
+	} else {
+		ocv =3D table[table_len - 1].ocv;
+	}
+
+	return ocv;
+}
+EXPORT_SYMBOL_GPL(power_supply_dcap2ocv_simple);
+
 /**
  * power_supply_ocv2cap_simple() - find the battery capacity
  * @table: Pointer to battery OCV lookup table
@@ -866,6 +908,33 @@ power_supply_find_ocv2cap_table(struct power_supply_ba=
ttery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_find_ocv2cap_table);
=20
+/**
+ * power_supply_batinfo_dcap2ocv() - Compute OCV based on SOC
+ * @info: Pointer to battery information.
+ * @dcao: Battery capacity in units of 0.1%
+ * @temp: Temperatur in Celsius
+ *
+ * Compute the open circuit voltage at given temperature matching given
+ * capacity for a battery described by given battery info. Computation is
+ * done based on tables of known capacity - open circuit voltage value pai=
rs.
+ * Requires the OCV tables being populated in the battery info.
+ *
+ * Return: The battery OCV in uV or -EINVAL if OCV table is not available.
+ */
+int power_supply_batinfo_dcap2ocv(struct power_supply_battery_info *info,
+				 int dcap, int temp)
+{
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+
+	table =3D power_supply_find_ocv2cap_table(info, temp, &table_len);
+	if (!table)
+		return -EINVAL;
+
+	return power_supply_dcap2ocv_simple(table, table_len, dcap);
+}
+EXPORT_SYMBOL_GPL(power_supply_batinfo_dcap2ocv);
+
 int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 				 int ocv, int temp)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..fa8cf434f7e3 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -410,11 +410,16 @@ extern void power_supply_put_battery_info(struct powe=
r_supply *psy,
 					  struct power_supply_battery_info *info);
 extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_tab=
le *table,
 				       int table_len, int ocv);
+int power_supply_dcap2ocv_simple(struct power_supply_battery_ocv_table *ta=
ble,
+				int table_len, int dcap);
+
 extern struct power_supply_battery_ocv_table *
 power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 				int temp, int *table_len);
 extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *=
info,
 					int ocv, int temp);
+int power_supply_batinfo_dcap2ocv(struct power_supply_battery_info *info,
+				 int dcap, int temp);
 extern int
 power_supply_temp2resist_simple(struct power_supply_resistance_temp_table =
*table,
 				int table_len, int temp);
--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--1UEBZoF6nR/AJ1d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTozUACgkQeFA3/03a
ocXhBgf/VVsbouHYdDkgz8aMEqsELrqFzmYzQQPlY5CfKc/hd38aIThS1dTXXpGq
R+xYuNC2r6AWp4nTpdDENs1C5ysUFw18pXMLfAKQZvdCekMJL136LfwVWHpOeKJ+
nRNMSD6yBtHtQ6CNb6Tf1GRyIcRotu0PthIE2UGIxxoOJyIQC2Z/FTxY9JR9gZom
fVa0XztgQ9qO/A5nc+q4ZUXpC9i9/QFoDQCguSOmD5TFjDp1/ZE4RDTpY+VqvH4n
y9dUhJEj8ioBBwoVDdMx7XcbTbZlnUYLIbXq04JIUtbWwGZz1tP7QS1ildMetUH6
WYk+ysjtESMF77Sb3IlELU5NyfYRMQ==
=tJuY
-----END PGP SIGNATURE-----

--1UEBZoF6nR/AJ1d6--
