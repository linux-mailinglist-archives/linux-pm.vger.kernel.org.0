Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C64719C6
	for <lists+linux-pm@lfdr.de>; Sun, 12 Dec 2021 12:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhLLLUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Dec 2021 06:20:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhLLLUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Dec 2021 06:20:39 -0500
Date:   Sun, 12 Dec 2021 11:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639308038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5M2p72hq1EIWsiulnir1rMFxhX+yTlpLnGBjP3qRNfY=;
        b=XlYEZqgIUvLCmw48QOoVoKdAORvjEWtW3AScszKSEwY0g7vly6YS7ZH9XWsG/3AKcGJcDs
        gNYX4DQzH2t4y+5XWAE1vhQshpDxUdTd49TBT08rdPPRTemEnw34ZZPSsxTp15GLVkL93B
        RiKTlPTOap/QCE1p8FYOJSMEj0TDIQvXsLIa4W0DU1+MHDXSZAEzr8oec5w4/VN1DYKCaL
        VbNpedngh1AdjzTGI4v4xeytUy5r7Z4xa2+f7EC5ho1SimNdFNLoQ29VIHr8cG789Qww99
        Nwc+Crhx6GI1Xd3A+iFRavGUUjdntb7OIdcvHAC2b+Qm5w+o4Adc1rdOvKVKqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639308038;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5M2p72hq1EIWsiulnir1rMFxhX+yTlpLnGBjP3qRNfY=;
        b=Yjb5HfIQ112/BfHnl2RyLtWZJ3MKpU2w5D0/QWnDv7PttW8tVSTISEEtl+OblE3AnzMDnX
        qisf4b6cfHufWbAw==
From:   "thermal-bot for Oleksij Rempel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx: Implement runtime PM support
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, petr.benes@ysoft.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211117103426.81813-1-o.rempel@pengutronix.de>
References: <20211117103426.81813-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Message-ID: <163930803764.23020.7309669870056201273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4cf2ddf16e175ee18c5c29865c32da7d6269cf44
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//4cf2ddf16e175ee18c5c29865c32da7d6269cf44
Author:        Oleksij Rempel <o.rempel@pengutronix.de>
AuthorDate:    Wed, 17 Nov 2021 11:34:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 30 Nov 2021 15:42:28 +01:00

thermal/drivers/imx: Implement runtime PM support

Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
data to decide whether to run a measurement") this driver stared using
irq_enabled flag to make decision to power on/off the thermal
core. This triggered a regression, where after reaching critical
temperature, alarm IRQ handler set irq_enabled to false, disabled
thermal core and was not able read temperature and disable cooling
sequence.

In case the cooling device is "CPU/GPU freq", the system will run with
reduce performance until next reboot.

To solve this issue, we need to move all parts implementing hand made
runtime power management and let it handle actual runtime PM framework.

Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether=
 to run a measurement")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Tested-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>
Link: https://lore.kernel.org/r/20211117103426.81813-1-o.rempel@pengutronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 145 ++++++++++++++++++++-------------
 1 file changed, 91 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2c7473d..1666337 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -15,6 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/pm_runtime.h>
=20
 #define REG_SET		0x4
 #define REG_CLR		0x8
@@ -194,6 +195,7 @@ static struct thermal_soc_data thermal_imx7d_data =3D {
 };
=20
 struct imx_thermal_data {
+	struct device *dev;
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *cdev;
@@ -252,44 +254,15 @@ static int imx_get_temp(struct thermal_zone_device *tz,=
 int *temp)
 	const struct thermal_soc_data *soc_data =3D data->socdata;
 	struct regmap *map =3D data->tempmon;
 	unsigned int n_meas;
-	bool wait, run_measurement;
 	u32 val;
+	int ret;
=20
-	run_measurement =3D !data->irq_enabled;
-	if (!run_measurement) {
-		/* Check if a measurement is currently in progress */
-		regmap_read(map, soc_data->temp_data, &val);
-		wait =3D !(val & soc_data->temp_valid_mask);
-	} else {
-		/*
-		 * Every time we measure the temperature, we will power on the
-		 * temperature sensor, enable measurements, take a reading,
-		 * disable measurements, power off the temperature sensor.
-		 */
-		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
-			    soc_data->power_down_mask);
-		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
-			    soc_data->measure_temp_mask);
-
-		wait =3D true;
-	}
-
-	/*
-	 * According to the temp sensor designers, it may require up to ~17us
-	 * to complete a measurement.
-	 */
-	if (wait)
-		usleep_range(20, 50);
+	ret =3D pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
=20
 	regmap_read(map, soc_data->temp_data, &val);
=20
-	if (run_measurement) {
-		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
-			     soc_data->measure_temp_mask);
-		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
-			     soc_data->power_down_mask);
-	}
-
 	if ((val & soc_data->temp_valid_mask) =3D=3D 0) {
 		dev_dbg(&tz->device, "temp measurement never finished\n");
 		return -EAGAIN;
@@ -328,6 +301,8 @@ static int imx_get_temp(struct thermal_zone_device *tz, i=
nt *temp)
 		enable_irq(data->irq);
 	}
=20
+	pm_runtime_put(data->dev);
+
 	return 0;
 }
=20
@@ -335,24 +310,16 @@ static int imx_change_mode(struct thermal_zone_device *=
tz,
 			   enum thermal_device_mode mode)
 {
 	struct imx_thermal_data *data =3D tz->devdata;
-	struct regmap *map =3D data->tempmon;
-	const struct thermal_soc_data *soc_data =3D data->socdata;
=20
 	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
-		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
-			     soc_data->power_down_mask);
-		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
-			     soc_data->measure_temp_mask);
+		pm_runtime_get(data->dev);
=20
 		if (!data->irq_enabled) {
 			data->irq_enabled =3D true;
 			enable_irq(data->irq);
 		}
 	} else {
-		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
-			     soc_data->measure_temp_mask);
-		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
-			     soc_data->power_down_mask);
+		pm_runtime_put(data->dev);
=20
 		if (data->irq_enabled) {
 			disable_irq(data->irq);
@@ -393,6 +360,11 @@ static int imx_set_trip_temp(struct thermal_zone_device =
*tz, int trip,
 			     int temp)
 {
 	struct imx_thermal_data *data =3D tz->devdata;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
=20
 	/* do not allow changing critical threshold */
 	if (trip =3D=3D IMX_TRIP_CRITICAL)
@@ -406,6 +378,8 @@ static int imx_set_trip_temp(struct thermal_zone_device *=
tz, int trip,
=20
 	imx_set_alarm_temp(data, temp);
=20
+	pm_runtime_put(data->dev);
+
 	return 0;
 }
=20
@@ -681,6 +655,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
=20
+	data->dev =3D &pdev->dev;
+
 	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
 	if (IS_ERR(map)) {
 		ret =3D PTR_ERR(map);
@@ -800,6 +776,16 @@ static int imx_thermal_probe(struct platform_device *pde=
v)
 		     data->socdata->power_down_mask);
 	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
 		     data->socdata->measure_temp_mask);
+	/* After power up, we need a delay before first access can be done. */
+	usleep_range(20, 50);
+
+	/* the core was configured and enabled just before */
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(data->dev);
+
+	ret =3D pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		goto disable_runtime_pm;
=20
 	data->irq_enabled =3D true;
 	ret =3D thermal_zone_device_enable(data->tz);
@@ -814,10 +800,15 @@ static int imx_thermal_probe(struct platform_device *pd=
ev)
 		goto thermal_zone_unregister;
 	}
=20
+	pm_runtime_put(data->dev);
+
 	return 0;
=20
 thermal_zone_unregister:
 	thermal_zone_device_unregister(data->tz);
+disable_runtime_pm:
+	pm_runtime_put_noidle(data->dev);
+	pm_runtime_disable(data->dev);
 clk_disable:
 	clk_disable_unprepare(data->thermal_clk);
 legacy_cleanup:
@@ -829,13 +820,9 @@ legacy_cleanup:
 static int imx_thermal_remove(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
-	struct regmap *map =3D data->tempmon;
=20
-	/* Disable measurements */
-	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
-		     data->socdata->power_down_mask);
-	if (!IS_ERR(data->thermal_clk))
-		clk_disable_unprepare(data->thermal_clk);
+	pm_runtime_put_noidle(data->dev);
+	pm_runtime_disable(data->dev);
=20
 	thermal_zone_device_unregister(data->tz);
 	imx_thermal_unregister_legacy_cooling(data);
@@ -858,29 +845,79 @@ static int __maybe_unused imx_thermal_suspend(struct de=
vice *dev)
 	ret =3D thermal_zone_device_disable(data->tz);
 	if (ret)
 		return ret;
+
+	return pm_runtime_force_suspend(data->dev);
+}
+
+static int __maybe_unused imx_thermal_resume(struct device *dev)
+{
+	struct imx_thermal_data *data =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D pm_runtime_force_resume(data->dev);
+	if (ret)
+		return ret;
+	/* Enabled thermal sensor after resume */
+	return thermal_zone_device_enable(data->tz);
+}
+
+static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
+{
+	struct imx_thermal_data *data =3D dev_get_drvdata(dev);
+	const struct thermal_soc_data *socdata =3D data->socdata;
+	struct regmap *map =3D data->tempmon;
+	int ret;
+
+	ret =3D regmap_write(map, socdata->sensor_ctrl + REG_CLR,
+			   socdata->measure_temp_mask);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(map, socdata->sensor_ctrl + REG_SET,
+			   socdata->power_down_mask);
+	if (ret)
+		return ret;
+
 	clk_disable_unprepare(data->thermal_clk);
=20
 	return 0;
 }
=20
-static int __maybe_unused imx_thermal_resume(struct device *dev)
+static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
 {
 	struct imx_thermal_data *data =3D dev_get_drvdata(dev);
+	const struct thermal_soc_data *socdata =3D data->socdata;
+	struct regmap *map =3D data->tempmon;
 	int ret;
=20
 	ret =3D clk_prepare_enable(data->thermal_clk);
 	if (ret)
 		return ret;
-	/* Enabled thermal sensor after resume */
-	ret =3D thermal_zone_device_enable(data->tz);
+
+	ret =3D regmap_write(map, socdata->sensor_ctrl + REG_CLR,
+			   socdata->power_down_mask);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(map, socdata->sensor_ctrl + REG_SET,
+			   socdata->measure_temp_mask);
 	if (ret)
 		return ret;
=20
+	/*
+	 * According to the temp sensor designers, it may require up to ~17us
+	 * to complete a measurement.
+	 */
+	usleep_range(20, 50);
+
 	return 0;
 }
=20
-static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
-			 imx_thermal_suspend, imx_thermal_resume);
+static const struct dev_pm_ops imx_thermal_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume)
+	SET_RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
+			   imx_thermal_runtime_resume, NULL)
+};
=20
 static struct platform_driver imx_thermal =3D {
 	.driver =3D {
