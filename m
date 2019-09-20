Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17DEB9152
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfITODV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 10:03:21 -0400
Received: from muru.com ([72.249.23.125]:33928 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbfITODV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Sep 2019 10:03:21 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A819180AA;
        Fri, 20 Sep 2019 14:03:49 +0000 (UTC)
Date:   Fri, 20 Sep 2019 07:03:15 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/3] power: supply: cpcap-charger: Limit voltage to 4.2V
 for battery
Message-ID: <20190920140315.GJ5610@atomide.com>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-2-tony@atomide.com>
 <20190919090539.GA9644@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919090539.GA9644@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [190919 09:06]:
> On Tue 2019-09-17 14:34:59, Tony Lindgren wrote:
> > From: Pavel Machek <pavel@ucw.cz>
> > 
> > There have been some cases of droid4 battery bulging that seem to
> > be related to being left connected to the charger for several weeks.
> > 
> > It is suspected that the 4.35V charge voltage configured for the battery
> > is too much in the long run, so lets limit the charge voltage to 4.2V.
> 
> 4.35V is known to make lifetime of battery shorter, but it provides
> 10% more capacity.
> 
> Disadvantage of this approach is that if droid is rebooted between
> mainline and android, battery will go 4.35V->4.2V->4.35V... while on
> charger.

Yeah that's a valid concern, we can handle that in the driver
though, see below.

> I guess this patch still makes sense, I just wanted to make sure
> disadvantages are mentioned.

Well how about the following as a fix instead?

It's a bit intrusive for a fix, but I think it gets us where we
want to be with with charger state and voltage detection with
help of chrgcurr2 interrupt.

And it makes adding user configurable voltages trivial.

Regards,

Tony

8< -------------------
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
@@ -117,6 +117,13 @@ enum {
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
@@ -134,6 +141,8 @@ struct cpcap_charger_ddata {
 	atomic_t active;
 
 	int status;
+	int state;
+	int voltage;
 };
 
 struct cpcap_interrupt_desc {
@@ -149,6 +158,7 @@ struct cpcap_charger_ints_state {
 
 	bool chrg_se1b;
 	bool rvrs_mode;
+	bool chrgcurr2;
 	bool chrgcurr1;
 	bool vbusvld;
 
@@ -406,6 +416,7 @@ static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
 
 	s->chrg_se1b = val & BIT(13);
 	s->rvrs_mode = val & BIT(6);
+	s->chrgcurr2 = val & BIT(5);
 	s->chrgcurr1 = val & BIT(4);
 	s->vbusvld = val & BIT(3);
 
@@ -418,6 +429,79 @@ static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
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
@@ -431,23 +515,63 @@ static void cpcap_usb_detect(struct work_struct *work)
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
+	 * charged to 3.51V by Android. Try again in 10 minutes.
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
+		cpcap_charger_disconnect(ddata, CPCAP_CHARGER_DONE,
+					 HZ * 5);
+		return;
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
 	if (cpcap_charger_vbus_valid(ddata) && s.chrgcurr1) {
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
@@ -507,7 +631,7 @@ static const char * const cpcap_charger_irqs[] = {
 	"chrg_det", "rvrs_chrg",
 
 	/* REG_INT1 */
-	"chrg_se1b", "se0conn", "rvrs_mode", "chrgcurr1", "vbusvld",
+	"chrg_se1b", "se0conn", "rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
 
 	/* REG_INT_3 */
 	"battdetb",
@@ -608,6 +732,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddata->dev = &pdev->dev;
+	ddata->voltage = 4200000;
 
 	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)
-- 
2.23.0
