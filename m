Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B741745321A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhKPM3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:29:04 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46990 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbhKPM3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:29:01 -0500
Received: by mail-lf1-f41.google.com with SMTP id b1so46840558lfs.13;
        Tue, 16 Nov 2021 04:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cAXGZZ6nd6Kr3NLJSibWSA76ESUyMzTBbvb3SIYaImo=;
        b=TNOSPIT/o0WF2kMhCfxh9WlCzxF3PUchXP+4g+2HzgNLze5l+31z42b10I1iI1q5Hm
         Dz8bDBOKB/mupLXFrD84WZA9Zjac+WD1ipiuQok5e2DK8kjCV/rfJA8H2FG9fcA0HaT1
         UN+AQP4lLdcDx4MLEKhHJSZF/TRhfUBzP6i/MLXHHl1hO2FASRznNqiuCcjEgldcDl0Y
         qc7Ws7DSNS3NhT0kxJZc40EiL7662Q0tfyUwQTw1nF6My3mZOql0Jc0GNEgdlBAduUdq
         jQis/TveZGn1acuIQbEwCmiiyecZ1Y5gyZSVIYm613DNZ4VHP7RJG2ec62TuKBOTBPJc
         n28Q==
X-Gm-Message-State: AOAM533qVvTz7k+6eBH9ZGGf7NVxYhmfumuzIJn/4UcSVbDI2eDoDJq7
        vwlV/I71ONZcXzhIFoiSTaI=
X-Google-Smtp-Source: ABdhPJyMSv1GDEU5VDePN/B7WoOYnoIAsywv3Qg7QWaujWOdhjXMNHWtaDTFfMfRbTYMjrDi1MYYwA==
X-Received: by 2002:a05:6512:20d4:: with SMTP id u20mr6321919lfr.339.1637065562990;
        Tue, 16 Nov 2021 04:26:02 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id n4sm1938734lfu.70.2021.11.16.04.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:26:02 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:25:53 +0200
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
Subject: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Message-ID: <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLUEf2HJJ9/4dy8v"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SLUEf2HJJ9/4dy8v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support obtaining the "capacity degradation by temperature" - tables
=66rom device-tree to batinfo.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
RFCv3:
 - rename simple_gauge_temp_degr to power_supply_temp_degr
---
 drivers/power/supply/power_supply_core.c | 53 ++++++++++++++++++++++++
 include/linux/power_supply.h             | 26 ++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index 295672165836..1a21f692ab81 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -562,10 +562,12 @@ struct power_supply *devm_power_supply_get_by_phandle=
(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
=20
+#define POWER_SUPPLY_TEMP_DGRD_MAX_VALUES 100
 int power_supply_get_battery_info(struct power_supply *psy,
 				  struct power_supply_battery_info *info)
 {
 	struct power_supply_resistance_temp_table *resist_table;
+	u32 *dgrd_table;
 	struct device_node *battery_np;
 	const char *value;
 	int err, len, index;
@@ -588,6 +590,8 @@ int power_supply_get_battery_info(struct power_supply *=
psy,
 	info->temp_max                       =3D INT_MAX;
 	info->factory_internal_resistance_uohm  =3D -EINVAL;
 	info->resist_table =3D NULL;
+	info->temp_dgrd_values =3D 0;
+	info->temp_dgrd =3D NULL;
=20
 	for (index =3D 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       =3D NULL;
@@ -677,6 +681,55 @@ int power_supply_get_battery_info(struct power_supply =
*psy,
 	of_property_read_u32_index(battery_np, "operating-range-celsius",
 				   1, &info->temp_max);
=20
+	len =3D of_property_count_u32_elems(battery_np, "temp-degrade-table");
+	if (len =3D=3D -EINVAL)
+		len =3D 0;
+	if (len < 0) {
+		err =3D len;
+		goto out_put_node;
+	}
+	/* table should consist of value pairs - maximum of 100 pairs */
+	if (len % 3 || len / 3 > POWER_SUPPLY_TEMP_DGRD_MAX_VALUES) {
+		dev_warn(&psy->dev,
+			 "bad amount of temperature-capacity degrade values\n");
+		err =3D -EINVAL;
+		goto out_put_node;
+	}
+	info->temp_dgrd_values =3D len / 3;
+	if (info->temp_dgrd_values) {
+		info->temp_dgrd =3D devm_kcalloc(&psy->dev,
+					       info->temp_dgrd_values,
+					       sizeof(*info->temp_dgrd),
+					       GFP_KERNEL);
+		if (!info->temp_dgrd) {
+			err =3D -ENOMEM;
+			goto out_put_node;
+		}
+		dgrd_table =3D kcalloc(len, sizeof(*dgrd_table), GFP_KERNEL);
+		if (!dgrd_table) {
+			err =3D -ENOMEM;
+			goto out_put_node;
+		}
+		err =3D of_property_read_u32_array(battery_np,
+						 "temp-degrade-table",
+						 dgrd_table, len);
+		if (err) {
+			dev_warn(&psy->dev,
+				 "bad temperature - capacity degrade values %d\n", err);
+			kfree(dgrd_table);
+			info->temp_dgrd_values =3D 0;
+			goto out_put_node;
+		}
+		for (index =3D 0; index < info->temp_dgrd_values; index++) {
+			struct power_supply_temp_degr *d =3D &info->temp_dgrd[index];
+
+			d->temp_degrade_1C =3D dgrd_table[index * 3];
+			d->degrade_at_set =3D dgrd_table[index * 3 + 1];
+			d->temp_set_point =3D dgrd_table[index * 3 + 2];
+		}
+		kfree(dgrd_table);
+	}
+
 	len =3D of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
 	if (len < 0 && len !=3D -EINVAL) {
 		err =3D len;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index fa8cf434f7e3..fbc07d403f41 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -214,6 +214,30 @@ union power_supply_propval {
 struct device_node;
 struct power_supply;
=20
+/**
+ * struct power_supply_temp_degr - impact of temperature to battery capaci=
ty
+ *
+ * Usually temperature impacts on battery capacity. For systems where it is
+ * sufficient to describe capacity change as a series of temperature ranges
+ * where the change is linear (Eg delta cap =3D temperature_change * const=
ant +
+ * offset) can be described by this structure.
+ *
+ * Please note - in order to avoid unnecessary rounding errors the change
+ * of capacity (uAh) is per change of temperature degree C while the tempe=
rature
+ * range floor is in tenths of degree C
+ *
+ * @temp_set_point:	Temperature where cap change is as given in
+ *			degrade_at_set. Units are 0.1 degree C
+ * @degrade_at_set:	Capacity difference (from ideal) at temp_set_point
+ *			temperature
+ * @temp_degrade_1C:	Capacity change / temperature change (uAh / degree C)
+ */
+struct power_supply_temp_degr {
+	int temp_set_point;
+	int degrade_at_set;
+	int temp_degrade_1C;
+};
+
 /* Run-time specific power supply configuration */
 struct power_supply_config {
 	struct device_node *of_node;
@@ -377,6 +401,8 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
+	int temp_dgrd_values;
+	struct power_supply_temp_degr *temp_dgrd;
 };
=20
 extern struct atomic_notifier_head power_supply_notifier;
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

--SLUEf2HJJ9/4dy8v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTo1EACgkQeFA3/03a
ocUtbwgAhegggZgHQYp/o8soKWrtAmmW6qsGKn+As9B/L35RG6G7qdcD71G0gzhK
aAxuxa/60rpdPK2q9BY+FGcC7jZNrGamY+YXNzhUtZHywlUKOF6xbUYwLoBsW92j
mBCx+s+mnUbMF/S09u83m3+COi82AZ/8wMohp5IDirLcgEsLJJusBla9z0yqA0r4
MgyO/HwziI7feI+pzIdNnyjARgBe0rN8+8Sqi5cpJmDuna/CakZoh2zbxgihrpAR
CwZ/uuXGdWWAVO3ePxxkmgIrLSZtPy/KGPBiVi5AHo3PR/ODnVkCOWmXT2VnB+Ol
3O++sRBQPgvyJohgXLSpkP15wZxAPg==
=pJiG
-----END PGP SIGNATURE-----

--SLUEf2HJJ9/4dy8v--
