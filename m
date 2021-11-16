Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCC45322C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhKPMar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:30:47 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34527 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbhKPMaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:30:46 -0500
Received: by mail-lj1-f180.google.com with SMTP id k23so14776263lje.1;
        Tue, 16 Nov 2021 04:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmTMfd20hULSCl+7yMqqQJbPyDaNAZmbbo2TAAoDw2E=;
        b=zwDfv9DjngjH3j/ctAG9XXDQxX5b3WQaTyedkk6RPrYag0foN0g5jiJFOfjK51zGfw
         UGvP5dKtm1QsBWi9/KQcPMQ0vmmcXWDZCtNkszuWyfOwu8GsXrC3ONBTwiC4RVMJEQ/K
         e1DdXrAHd/VyyGUXT3Y2S6n7qReZctOBg/IjA6nvbnnYqjRX6oOSN8bx8bgbc1jPXVEV
         GXS5lgqWGHgb/+XDbNhNOpsuJhNbzr0CmKks3q3zbwrOOsmMUNycOWK4DE+DBZrKZTXJ
         t6CojzlOHbFHX5G9vLIQ8b7bdLkgRxgJiMfk61HM/oTkkJdwhyDVTT3bnES0MealhXDZ
         ASMA==
X-Gm-Message-State: AOAM530eMxGt/d+36oB7OpQAlDgaWFEWrt6KgimDifdgVvCLYexXNd/w
        dGfk3EN6mtYvKe0NqAnTyGI=
X-Google-Smtp-Source: ABdhPJwwHvXfBpPHnGHb13uz+BAtjbE6+rk2VK8KQ9qO8unppGwXzMBU9/0JniLgBGOKl44xj+/byg==
X-Received: by 2002:a05:651c:905:: with SMTP id e5mr6684944ljq.238.1637065668414;
        Tue, 16 Nov 2021 04:27:48 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id w36sm1751324lfu.81.2021.11.16.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:27:47 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:27:40 +0200
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
Subject: [RFC PATCH v3 6/9] power: supply: Add batinfo functions for OCV to
 SOC with 0.1% accuracy
Message-ID: <392c7aa891d466bc4df06a076090150319e0e7dc.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3tObPVaWIpRkTkET"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3tObPVaWIpRkTkET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The battery info functions computing the state-of-charge (SOC) based
on open-circuit-voltage (OCV) are returning SOC using units of 1%.

Some capacity estimation computations require higher accuracy. Add
functions that return SOC using units of 0.1% to reduce rounding error.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---

RFCv3 changes:
 - Kerneldoc fixes
---
 drivers/power/supply/power_supply_core.c | 65 ++++++++++++++++++++++++
 include/linux/power_supply.h             |  4 ++
 2 files changed, 69 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index ebc961b5aa45..62ea113db3b4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1003,6 +1003,45 @@ int power_supply_ocv2cap_simple(struct power_supply_=
battery_ocv_table *table,
 }
 EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
=20
+/**
+ * power_supply_ocv2dcap_simple() - find the battery capacity at 0.1% accu=
racy
+ * @table: Pointer to battery OCV lookup table
+ * @table_len: OCV table length
+ * @ocv: Current OCV value
+ *
+ * This helper function is used to look up battery capacity according to
+ * current OCV value from one OCV table, and the OCV table must be ordered
+ * descending. Return the SOC in the units of 0.1% for improved accuracy.
+ *
+ * Return: the battery capacity using the unit 0.1%.
+ */
+int power_supply_ocv2dcap_simple(struct power_supply_battery_ocv_table *ta=
ble,
+				int table_len, int ocv)
+{
+	int i, cap, tmp;
+
+	for (i =3D 0; i < table_len; i++)
+		if (ocv > table[i].ocv)
+			break;
+
+	if (i > 0 && i < table_len) {
+		tmp =3D (table[i - 1].capacity - table[i].capacity) *
+			(ocv - table[i].ocv) * 10;
+		tmp /=3D table[i - 1].ocv - table[i].ocv;
+		cap =3D tmp + table[i].capacity * 10;
+	} else if (i =3D=3D 0) {
+		cap =3D table[0].capacity * 10;
+	} else {
+		cap =3D table[table_len - 1].capacity * 10;
+	}
+
+	if (cap < 0)
+		cap =3D 0;
+
+	return cap;
+}
+EXPORT_SYMBOL_GPL(power_supply_ocv2dcap_simple);
+
 struct power_supply_battery_ocv_table *
 power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
 				int temp, int *table_len)
@@ -1054,6 +1093,32 @@ int power_supply_batinfo_dcap2ocv(struct power_suppl=
y_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_batinfo_dcap2ocv);
=20
+/**
+ * power_supply_batinfo_ocv2dcap - compute SOC based on OCV and temperature
+ * @info:	pointer to battery information
+ * @ocv:	Open circuit voltage in uV
+ * @temp:	Temperature in Celsius
+ *
+ * Use OCV tables in battery info to compute the battery capacity based on
+ * provided open circuit voltage at given and temperature.
+ *
+ * Return: battery capacity correspondinggiven OCV and temperature at 0.1%.
+ *         -EINVAL if OCV table is not present.
+ */
+int power_supply_batinfo_ocv2dcap(struct power_supply_battery_info *info,
+				  int ocv, int temp)
+{
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+
+	table =3D power_supply_find_ocv2cap_table(info, temp, &table_len);
+	if (!table)
+		return -EINVAL;
+
+	return power_supply_ocv2dcap_simple(table, table_len, ocv);
+}
+EXPORT_SYMBOL_GPL(power_supply_batinfo_ocv2dcap);
+
 int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 				 int ocv, int temp)
 {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c5118265b3ab..5e6575e97492 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -444,6 +444,10 @@ extern int power_supply_ocv2cap_simple(struct power_su=
pply_battery_ocv_table *ta
 				       int table_len, int ocv);
 int power_supply_dcap2ocv_simple(struct power_supply_battery_ocv_table *ta=
ble,
 				int table_len, int dcap);
+int power_supply_ocv2dcap_simple(struct power_supply_battery_ocv_table *ta=
ble,
+				 int table_len, int ocv);
+int power_supply_batinfo_ocv2dcap(struct power_supply_battery_info *info,
+				  int ocv, int temp);
=20
 extern struct power_supply_battery_ocv_table *
 power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
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

--3tObPVaWIpRkTkET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTo7wACgkQeFA3/03a
ocWLdwf9EQemQb6UhDWFpC/rJcybWqthF39EqbhRYnTKvpw+X4m8LQNpa8tuMaYC
ZO4zWFs2/3ZQk97qqmvkU2q7ODH3Acu6RHxU0g8ZB6LaR5cFGV+nBd60bBUkK0oq
1WBXQIEvm+wGEDwZjzYsyWMzI3HH5E+Aa3kVoMNBUZuUFwj/FMzurHJ963lQJsOL
HXf365RbvoO/rqYylAaEMW3AL2lk8fCChAZJJkWFSa7b689un2XTEsUhygC3Qf3q
LiUJrlsncgJsobz8f7U3U5dUXhXlx9rRZqb3UMzXGPWUh3yh+5yBsOZST6L4qWUC
sIqTBLnl/sWxhL2h9zhKOm6WaRGw8A==
=US7X
-----END PGP SIGNATURE-----

--3tObPVaWIpRkTkET--
