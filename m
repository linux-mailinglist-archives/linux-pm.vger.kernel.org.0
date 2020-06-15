Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F11F9996
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgFOOF7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 10:05:59 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37018 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgFOOF7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 10:05:59 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CC4281C0BD2; Mon, 15 Jun 2020 16:05:57 +0200 (CEST)
Date:   Mon, 15 Jun 2020 16:05:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, linux-pm@vger.kernel.org
Subject: [RFC] Limiting charge current on Droid 4 (and N900)
Message-ID: <20200615140557.GA22781@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Droid 4 has same problem as N900: it is often neccessary to manually
tweak current draw from USB, for example when using thin charging cable.

N900 creates unique attribute by hand, but I believe
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT looks suitable. (Should N900 be
converted?)

Comments? Would the patch be acceptable after fixing whitespace?

Best regards,
									Pavel

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cp=
cap-battery.c
index b16848cfb58c..39a00716372f 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
  *
- * Some parts of the code based on earlie Motorola mapphone Linux kernel
+ * Some parts of the code based on earlier Motorola mapphone Linux kernel
  * drivers:
  *
  * Copyright (C) 2009-2010 Motorola, Inc.
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cp=
cap-charger.c
index cf1e05b511d9..292d7a31c663 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -89,6 +89,8 @@
  * CPCAP_REG_CRM charge currents. These seem to match MC13783UG.pdf
  * values in "Table 8-3. Charge Path Regulator Current Limit
  * Characteristics" for the nominal values.
+ *
+ * Except 70mA and 1.596A and unlimited, these are simply 88.7mA / step.
  */
 #define CPCAP_REG_CRM_ICHRG(val)	(((val) & 0xf) << 0)
 #define CPCAP_REG_CRM_ICHRG_0A000	CPCAP_REG_CRM_ICHRG(0x0)
@@ -147,6 +149,8 @@ struct cpcap_charger_ddata {
 	int status;
 	int state;
 	int voltage;
+	int limit_current;
+
 	int last_current;
 	int last_current_retries;
 };
@@ -175,6 +179,7 @@ static enum power_supply_property cpcap_charger_props[]=
 =3D {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
@@ -238,6 +243,9 @@ static int cpcap_charger_get_property(struct power_supp=
ly *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval =3D ddata->status;
 		break;
+  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval =3D ddata->limit_current;
+		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		val->intval =3D ddata->voltage;
 		break;
@@ -308,6 +316,25 @@ cpcap_charger_get_bat_const_charge_voltage(struct cpca=
p_charger_ddata *ddata)
 	return voltage;
 }
=20
+static int cpcap_charger_current_to_regval(int microamp)
+{
+	int miliamp =3D microamp/1000;
+	int res;
+	if (miliamp < 0)
+		return -EINVAL;
+	if (miliamp < 70)
+		return CPCAP_REG_CRM_ICHRG(0x0);
+	if (miliamp < 177)
+		return CPCAP_REG_CRM_ICHRG(0x1);
+	if (miliamp > 1596)
+		return CPCAP_REG_CRM_ICHRG(0xe);
+
+	res =3D microamp / 88666;
+	if (res > 0xd)
+		res =3D 0xd;
+	return CPCAP_REG_CRM_ICHRG(res);
+}
+
 static int cpcap_charger_set_property(struct power_supply *psy,
 				      enum power_supply_property psp,
 				      const union power_supply_propval *val)
@@ -316,6 +343,12 @@ static int cpcap_charger_set_property(struct power_sup=
ply *psy,
 	int voltage, batvolt;
=20
 	switch (psp) {
+  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (cpcap_charger_current_to_regval(val->intval) < 0)
+			return -EINVAL;
+		ddata->limit_current =3D val->intval;
+		schedule_delayed_work(&ddata->detect_work, 0);
+		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		voltage =3D cpcap_charger_match_voltage(val->intval);
 		batvolt =3D cpcap_charger_get_bat_const_charge_voltage(ddata);
@@ -335,6 +368,7 @@ static int cpcap_charger_property_is_writeable(struct p=
ower_supply *psy,
 					       enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		return 1;
 	default:
@@ -657,23 +691,21 @@ static void cpcap_usb_detect(struct work_struct *work)
=20
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
-		int max_current;
-		int vchrg;
+		int max_current =3D 532000;
+		int vchrg, ichrg;
=20
 		if (cpcap_charger_battery_found(ddata))
-			max_current =3D CPCAP_REG_CRM_ICHRG_1A596;
-		else
-			max_current =3D CPCAP_REG_CRM_ICHRG_0A532;
+			max_current =3D 1596000;
=20
 		switch (ddata->state) {
 		case CPCAP_CHARGER_DETECTING:
 			ddata->last_current_retries =3D 0;
 			break;
 		case CPCAP_CHARGER_DISCONNECTED:
-			if (ddata->last_current > CPCAP_REG_CRM_ICHRG_0A532) {
+			if (ddata->last_current > 532000) {
 				/* Attempt current 3 times before lowering */
 				if (ddata->last_current_retries++ >=3D 3) {
-					ddata->last_current--;
+					ddata->last_current -=3D 100000;
 					ddata->last_current_retries =3D 0;
 					/* Wait a bit for voltage to ramp up */
 					usleep_range(40000, 50000);
@@ -688,11 +720,16 @@ static void cpcap_usb_detect(struct work_struct *work)
 			break;
 		}
=20
+		if (max_current > ddata->limit_current)
+			max_current =3D ddata->limit_current;
+
 		ddata->last_current =3D max_current;
+
+		ichrg =3D cpcap_charger_current_to_regval(max_current);
 		vchrg =3D cpcap_charger_voltage_to_regval(ddata->voltage);
 		error =3D cpcap_charger_set_state(ddata,
 						CPCAP_REG_CRM_VCHRG(vchrg),
-						max_current, 0);
+						ichrg, 0);
 		if (error)
 			goto out_err;
 		cpcap_charger_update_state(ddata, CPCAP_CHARGER_CHARGING);
@@ -864,6 +901,7 @@ static int cpcap_charger_probe(struct platform_device *=
pdev)
=20
 	ddata->dev =3D &pdev->dev;
 	ddata->voltage =3D 4200000;
+	ddata->limit_current =3D 532000;
=20
 	ddata->reg =3D dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXueARQAKCRAw5/Bqldv6
8r/sAJ46iCoAwzi+b8D09i52j6yXo5rYVgCggxr+sue70dpus3LswQUr8Ki7lSM=
=YnOL
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
