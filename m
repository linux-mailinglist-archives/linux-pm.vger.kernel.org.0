Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869112FC267
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbhASVd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:33:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbhASV2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:12 -0500
Date:   Tue, 19 Jan 2021 21:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goY/Yo86sa+hMVBiCVIoSh1NmfraF7cBBZ0MXKcKy6A=;
        b=Qz1+QFdzLmoU4QLFeLYtTsBaD3FImyOVvds+Mp3Vp8u8StpeeaQtUKSv5ir32pqk6tbwOH
        7OSx1WBp90B8AoQlSaIJ5Qu4XnXET4DpJQLSc7EDtny8b3wlqQsUI4ydsWy+zHmSUhyhHN
        W9/U33B2j3qJHBzzSvV63Wtis3niQ3V1sckZrpzC4H2WGVynTkhnz8AX5yk0zRQ815ad8d
        cHGyNWlFBbJTYHj6WxQDH4VsAXuETIdbOQmxKsWeYr8+XfrOvGjswgTMYAcPjypsgHSDz+
        xk4FDsdER6NQv/7HHjboi6wzV4plWfdgbz4M4zaEeQcWbtkV1ewTFVIYws26og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goY/Yo86sa+hMVBiCVIoSh1NmfraF7cBBZ0MXKcKy6A=;
        b=jQ+CQd1gN6qoWZmi6GWLdW8GrkwegJzj0YLiprmycXjk8d/pv+QJ/btR7GrVUYM+lAhPkd
        vQbFpNCYKvOOtRAQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove ms based delay fields
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, peter@piie.net,
        Hans de Goede <hdegoede@redhat.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201216220337.839878-3-daniel.lezcano@linaro.org>
References: <20201216220337.839878-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164553.414.13150618075076695374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b39d2dd5b5ed08d15711aefd5afd72bd87387c64
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//b39d2dd5b5ed08d15711aefd5afd72bd87387c64
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 16 Dec 2020 23:03:37 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:49 +01:00

thermal/core: Remove ms based delay fields

The code does no longer use the ms unit based fields to set the
delays as they are replaced by the jiffies.

Remove them and replace their user to use the jiffies version instead.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Peter K=C3=A4stle <peter@piie.net>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20201216220337.839878-3-daniel.lezcano@linaro=
.org
---
 drivers/platform/x86/acerhdf.c                     | 3 ++-
 drivers/thermal/da9062-thermal.c                   | 4 ++--
 drivers/thermal/gov_power_allocator.c              | 2 +-
 drivers/thermal/thermal_core.c                     | 4 +---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
 include/linux/thermal.h                            | 7 -------
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index b6aa6e5..6b8b3ab 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -336,7 +336,8 @@ static void acerhdf_check_param(struct thermal_zone_devic=
e *thermal)
 			pr_notice("interval changed to: %d\n", interval);
=20
 		if (thermal)
-			thermal->polling_delay =3D interval*1000;
+			thermal->polling_delay_jiffies =3D
+				round_jiffies(msecs_to_jiffies(interval * 1000));
=20
 		prev_interval =3D interval;
 	}
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-therma=
l.c
index 4d74994..180edec 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		thermal_zone_device_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
=20
-		delay =3D msecs_to_jiffies(thermal->zone->passive_delay);
+		delay =3D thermal->zone->passive_delay_jiffies;
 		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
@@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *p=
dev)
=20
 	dev_dbg(&pdev->dev,
 		"TJUNC temperature polling period set at %d ms\n",
-		thermal->zone->passive_delay);
+		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
=20
 	ret =3D platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0) {
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_powe=
r_allocator.c
index 7a4170a..f8c3d1e 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 * power being applied, slowing down the controller)
 	 */
 	d =3D mul_frac(tz->tzp->k_d, err - params->prev_err);
-	d =3D div_frac(d, tz->passive_delay);
+	d =3D div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
 	params->prev_err =3D err;
=20
 	power_range =3D p + i + d;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d96c515..b261544 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,7 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_devi=
ce *tz)
=20
 	if (!stop && tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
-	else if (!stop && tz->polling_delay)
+	else if (!stop && tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
@@ -1307,8 +1307,6 @@ thermal_zone_device_register(const char *type, int trip=
s, int mask,
 	tz->device.class =3D &thermal_class;
 	tz->devdata =3D devdata;
 	tz->trips =3D trips;
-	tz->passive_delay =3D passive_delay;
-	tz->polling_delay =3D polling_delay;
=20
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/the=
rmal/ti-soc-thermal/ti-thermal-common.c
index 2ce4b19..f843758 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -166,6 +166,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int =
id,
 			     char *domain)
 {
 	struct ti_thermal_data *data;
+	int interval;
=20
 	data =3D ti_bandgap_get_sensor_data(bgp, id);
=20
@@ -183,9 +184,10 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int=
 id,
 		return PTR_ERR(data->ti_thermal);
 	}
=20
+	interval =3D jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
+
 	ti_bandgap_set_sensor_data(bgp, id, data);
-	ti_bandgap_write_update_interval(bgp, data->sensor_id,
-					data->ti_thermal->polling_delay);
+	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
=20
 	return 0;
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d1b82c7..1e68640 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -115,13 +115,8 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
- * @passive_delay:	number of milliseconds to wait between polls when
- *			performing passive cooling.
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
- * @polling_delay:	number of milliseconds to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
  * @polling_delay_jiffies: number of jiffies to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
@@ -162,8 +157,6 @@ struct thermal_zone_device {
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
-	int passive_delay;
-	int polling_delay;
 	int temperature;
 	int last_temperature;
 	int emul_temperature;
