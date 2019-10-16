Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F840DA126
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfJPWT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:19:56 -0400
Received: from muru.com ([72.249.23.125]:37624 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfJPWTy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:19:54 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7DD2D8107;
        Wed, 16 Oct 2019 22:20:19 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCHv2] power: supply: cpcap-charger: Limit voltage to 4.2V for battery
Date:   Wed, 16 Oct 2019 15:18:17 -0700
Message-Id: <20191016221817.8501-1-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There have been some cases of droid4 battery bulging that seem to be
related to being left connected to the charger for several weeks.

It is suspected that the 4.35V charge voltage configured for the battery
is too much in the long run, so lets limit the charge voltage to 4.2V.
It could also be that the batteries are just getting old.

We don't really want to just change the charge voltage to 4.2V as Android
may have charged the battery to 4.35V as pointed out by Pavel Machek.

To add checks for battery voltage, the driver needs to understand the
voltage it's charging at, and also needs to better understand it's
charger state. Right now it only understands connect and disconnect,
while now we need to know also a connected state but not charging.

So let's add better charger state handling with help of chrgcurr2 interrupt
for detecting charge full and retry, and add a check for battery voltage
before we start charging. And then we finally can lower the charge voltage
to 4.2V.

Note that we've been using the same register values as the Android distros
on droid4, so it is suspected that the same problem also exists in Android.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Reported-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

If this looks OK, I would appreciate an immutable branch against v5.4-rc1
with just this patch in it for merge conflicts with v5.5 dts changes.

Changes since v1:

- Fix up typos noted by Pavel for 3.51V while it sould be 4.35V

- Updated against v5.4-rc series instead of v5.3 as we do not want to
  apply this for earlier kernels automatically except maybe later on

---
 .../bindings/power/supply/cpcap-charger.txt   |   9 +-
 .../arm/boot/dts/motorola-cpcap-mapphone.dtsi |   6 +-
 drivers/power/supply/cpcap-charger.c          | 132 +++++++++++++++++-
 3 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
--- a/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
@@ -5,7 +5,8 @@ Required properties:
 - interrupts: Interrupt specifier for each name in interrupt-names
 - interrupt-names: Should contain the following entries:
 		   "chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
-		   "rvrs_mode", "chrgcurr1", "vbusvld", "battdetb"
+		   "rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
+		   "battdetb"
 - io-channels: IIO ADC channel specifier for each name in io-channel-names
 - io-channel-names: Should contain the following entries:
 		    "battdetb", "battp", "vbus", "chg_isense", "batti"
@@ -21,11 +22,13 @@ cpcap_charger: charger {
 	compatible = "motorola,mapphone-cpcap-charger";
 	interrupts-extended = <
 		&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
-		&cpcap 22 0 &cpcap 20 0 &cpcap 19 0 &cpcap 54 0
+		&cpcap 22 0 &cpcap 21 0 &cpcap 20 0 &cpcap 19 0
+		&cpcap 54 0
 	>;
 	interrupt-names =
 		"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
-		"rvrs_mode", "chrgcurr1", "vbusvld", "battdetb";
+		"rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
+		"battdetb";
 	mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW
 		      &gpio3 23 GPIO_ACTIVE_LOW>;
 	io-channels = <&cpcap_adc 0 &cpcap_adc 1
diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -43,11 +43,13 @@
 			compatible = "motorola,mapphone-cpcap-charger";
 			interrupts-extended = <
 				&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
-				&cpcap 22 0 &cpcap 20 0 &cpcap 19 0 &cpcap 54 0
+				&cpcap 22 0 &cpcap 21 0 &cpcap 20 0 &cpcap 19 0
+				&cpcap 54 0
 			>;
 			interrupt-names =
 				"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
-				"rvrs_mode", "chrgcurr1", "vbusvld", "battdetb";
+				"rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
+				"battdetb";
 			mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW
 				      &gpio3 23 GPIO_ACTIVE_LOW>;
 			io-channels = <&cpcap_adc 0 &cpcap_adc 1
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -120,6 +120,13 @@ enum {
 	CPCAP_CHARGER_IIO_NR,
 };
 
+enum {
+	CPCAP_CHARGER_DISCONNECTED,
+	CPCAP_CHARGER_DETECTING,
+	CPCAP_CHARGER_CHARGING,
+	CPCAP_CHARGER_DONE,
+};
+
 struct cpcap_charger_ddata {
 	struct device *dev;
 	struct regmap *reg;
@@ -138,6 +145,8 @@ struct cpcap_charger_ddata {
 	atomic_t active;
 
 	int status;
+	int state;
+	int voltage;
 };
 
 struct cpcap_interrupt_desc {
@@ -153,6 +162,7 @@ struct cpcap_charger_ints_state {
 
 	bool chrg_se1b;
 	bool rvrs_mode;
+	bool chrgcurr2;
 	bool chrgcurr1;
 	bool vbusvld;
 
@@ -422,6 +432,7 @@ static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
 
 	s->chrg_se1b = val & BIT(13);
 	s->rvrs_mode = val & BIT(6);
+	s->chrgcurr2 = val & BIT(5);
 	s->chrgcurr1 = val & BIT(4);
 	s->vbusvld = val & BIT(3);
 
@@ -434,6 +445,79 @@ static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
 	return 0;
 }
 
+static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
+				       int state)
+{
+	const char *status;
+
+	if (state > CPCAP_CHARGER_DONE) {
+		dev_warn(ddata->dev, "unknown state: %i\n", state);
+
+		return;
+	}
+
+	ddata->state = state;
+
+	switch (state) {
+	case CPCAP_CHARGER_DISCONNECTED:
+		status = "DISCONNECTED";
+		break;
+	case CPCAP_CHARGER_DETECTING:
+		status = "DETECTING";
+		break;
+	case CPCAP_CHARGER_CHARGING:
+		status = "CHARGING";
+		break;
+	case CPCAP_CHARGER_DONE:
+		status = "DONE";
+		break;
+	default:
+		return;
+	}
+
+	dev_dbg(ddata->dev, "state: %s\n", status);
+}
+
+int cpcap_charger_voltage_to_regval(int voltage)
+{
+	int offset;
+
+	switch (voltage) {
+	case 0 ... 4100000 - 1:
+		return 0;
+	case 4100000 ... 4200000 - 1:
+		offset = 1;
+		break;
+	case 4200000 ... 4300000 - 1:
+		offset = 0;
+		break;
+	case 4300000 ... 4380000 - 1:
+		offset = -1;
+		break;
+	case 4380000 ... 4440000:
+		offset = -2;
+		break;
+	default:
+		return 0;
+	}
+
+	return ((voltage - 4100000) / 20000) + offset;
+}
+
+static void cpcap_charger_disconnect(struct cpcap_charger_ddata *ddata,
+				     int state, unsigned long delay)
+{
+	int error;
+
+	error = cpcap_charger_set_state(ddata, 0, 0, 0);
+	if (error)
+		return;
+
+	cpcap_charger_update_state(ddata, state);
+	power_supply_changed(ddata->usb);
+	schedule_delayed_work(&ddata->detect_work, delay);
+}
+
 static void cpcap_usb_detect(struct work_struct *work)
 {
 	struct cpcap_charger_ddata *ddata;
@@ -447,24 +531,67 @@ static void cpcap_usb_detect(struct work_struct *work)
 	if (error)
 		return;
 
+	/* Just init the state if a charger is connected with no chrg_det set */
+	if (!s.chrg_det && s.chrgcurr1 && s.vbusvld) {
+		cpcap_charger_update_state(ddata, CPCAP_CHARGER_DETECTING);
+
+		return;
+	}
+
+	/*
+	 * If battery voltage is higher than charge voltage, it may have been
+	 * charged to 4.35V by Android. Try again in 10 minutes.
+	 */
+	if (cpcap_charger_get_charge_voltage(ddata) > ddata->voltage) {
+		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DETECTING,
+					 HZ * 60 * 10);
+
+		return;
+	}
+
+	/* Throttle chrgcurr2 interrupt for charger done and retry */
+	switch (ddata->state) {
+	case CPCAP_CHARGER_CHARGING:
+		if (s.chrgcurr2)
+			break;
+		if (s.chrgcurr1 && s.vbusvld) {
+			cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DONE,
+						 HZ * 5);
+			return;
+		}
+		break;
+	case CPCAP_CHARGER_DONE:
+		if (!s.chrgcurr2)
+			break;
+		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DETECTING,
+					 HZ * 5);
+		return;
+	default:
+		break;
+	}
+
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
 		int max_current;
+		int vchrg;
 
 		if (cpcap_charger_battery_found(ddata))
 			max_current = CPCAP_REG_CRM_ICHRG_1A596;
 		else
 			max_current = CPCAP_REG_CRM_ICHRG_0A532;
 
+		vchrg = cpcap_charger_voltage_to_regval(ddata->voltage);
 		error = cpcap_charger_set_state(ddata,
-						CPCAP_REG_CRM_VCHRG_4V35,
+						CPCAP_REG_CRM_VCHRG(vchrg),
 						max_current, 0);
 		if (error)
 			goto out_err;
+		cpcap_charger_update_state(ddata, CPCAP_CHARGER_CHARGING);
 	} else {
 		error = cpcap_charger_set_state(ddata, 0, 0, 0);
 		if (error)
 			goto out_err;
+		cpcap_charger_update_state(ddata, CPCAP_CHARGER_DISCONNECTED);
 	}
 
 	power_supply_changed(ddata->usb);
@@ -524,7 +651,7 @@ static const char * const cpcap_charger_irqs[] = {
 	"chrg_det", "rvrs_chrg",
 
 	/* REG_INT1 */
-	"chrg_se1b", "se0conn", "rvrs_mode", "chrgcurr1", "vbusvld",
+	"chrg_se1b", "se0conn", "rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
 
 	/* REG_INT_3 */
 	"battdetb",
@@ -625,6 +752,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddata->dev = &pdev->dev;
+	ddata->voltage = 4200000;
 
 	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)
-- 
2.23.0
