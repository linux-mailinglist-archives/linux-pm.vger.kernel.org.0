Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A860B2DC933
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 23:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgLPWqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 16 Dec 2020 17:46:24 -0500
Received: from piie.net ([80.82.223.85]:57438 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgLPWqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Dec 2020 17:46:23 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 17:46:22 EST
Received: from mail.piie.net (_gateway [172.17.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 04BFC3226FC;
        Wed, 16 Dec 2020 23:35:55 +0100 (CET)
MIME-Version: 1.0
Date:   Wed, 16 Dec 2020 22:35:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.14.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <00766bd10b90c0c3bebf25738b782ec9@piie.net>
Subject: Re: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Thara Gopinath" <thara.gopinath@linaro.org>,
        "Lukasz Luba" <lukasz.luba@arm.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <mgross@linux.intel.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        "Eduardo Valentin" <edubezval@gmail.com>,
        "Keerthy" <j-keerthy@ti.com>, platform-driver-x86@vger.kernel.org,
        linux-omap@vger.kernel.org
In-Reply-To: <20201216220337.839878-3-daniel.lezcano@linaro.org>
References: <20201216220337.839878-3-daniel.lezcano@linaro.org>
 <20201216220337.839878-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16. Dezember 2020 23:04, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:

> The code does no longer use the ms unit based fields to set the
> delays as they are replaced by the jiffies.
> 
> Remove them and replace their user to use the jiffies version instead.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> drivers/platform/x86/acerhdf.c | 3 ++-

Reviewed-by: Peter Kästle <peter@piie.net>


> drivers/thermal/da9062-thermal.c | 4 ++--
> drivers/thermal/gov_power_allocator.c | 2 +-
> drivers/thermal/thermal_core.c | 4 +---
> drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
> include/linux/thermal.h | 7 -------
> 6 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index b6aa6e5514f4..6b8b3ab8db48 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -336,7 +336,8 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
> pr_notice("interval changed to: %d\n", interval);
> 
> if (thermal)
> - thermal->polling_delay = interval*1000;
> + thermal->polling_delay_jiffies =
> + round_jiffies(msecs_to_jiffies(interval * 1000));
> 
> prev_interval = interval;
> }
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index 4d74994f160a..180edec34e07 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
> thermal_zone_device_update(thermal->zone,
> THERMAL_EVENT_UNSPECIFIED);
> 
> - delay = msecs_to_jiffies(thermal->zone->passive_delay);
> + delay = thermal->zone->passive_delay_jiffies;
> queue_delayed_work(system_freezable_wq, &thermal->work, delay);
> return;
> }
> @@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
> 
> dev_dbg(&pdev->dev,
> "TJUNC temperature polling period set at %d ms\n",
> - thermal->zone->passive_delay);
> + jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
> 
> ret = platform_get_irq_byname(pdev, "THERMAL");
> if (ret < 0) {
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 7a4170a0b51f..f8c3d1e40b86 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
> * power being applied, slowing down the controller)
> */
> d = mul_frac(tz->tzp->k_d, err - params->prev_err);
> - d = div_frac(d, tz->passive_delay);
> + d = div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
> params->prev_err = err;
> 
> power_range = p + i + d;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d96c515af3cb..b2615449b18f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -313,7 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
> 
> if (!stop && tz->passive)
> thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
> - else if (!stop && tz->polling_delay)
> + else if (!stop && tz->polling_delay_jiffies)
> thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
> else
> thermal_zone_device_set_polling(tz, 0);
> @@ -1307,8 +1307,6 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> tz->device.class = &thermal_class;
> tz->devdata = devdata;
> tz->trips = trips;
> - tz->passive_delay = passive_delay;
> - tz->polling_delay = polling_delay;
> 
> thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
> thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 2ce4b19f312a..f84375865c97 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -166,6 +166,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
> char *domain)
> {
> struct ti_thermal_data *data;
> + int interval;
> 
> data = ti_bandgap_get_sensor_data(bgp, id);
> 
> @@ -183,9 +184,10 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
> return PTR_ERR(data->ti_thermal);
> }
> 
> + interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
> +
> ti_bandgap_set_sensor_data(bgp, id, data);
> - ti_bandgap_write_update_interval(bgp, data->sensor_id,
> - data->ti_thermal->polling_delay);
> + ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
> 
> return 0;
> }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index d1b82c70de69..1e686404951b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -115,13 +115,8 @@ struct thermal_cooling_device {
> * @devdata: private pointer for device private data
> * @trips: number of trip points the thermal zone supports
> * @trips_disabled; bitmap for disabled trips
> - * @passive_delay: number of milliseconds to wait between polls when
> - * performing passive cooling.
> * @passive_delay_jiffies: number of jiffies to wait between polls when
> * performing passive cooling.
> - * @polling_delay: number of milliseconds to wait between polls when
> - * checking whether trip points have been crossed (0 for
> - * interrupt driven systems)
> * @polling_delay_jiffies: number of jiffies to wait between polls when
> * checking whether trip points have been crossed (0 for
> * interrupt driven systems)
> @@ -162,8 +157,6 @@ struct thermal_zone_device {
> unsigned long trips_disabled; /* bitmap for disabled trips */
> unsigned long passive_delay_jiffies;
> unsigned long polling_delay_jiffies;
> - int passive_delay;
> - int polling_delay;
> int temperature;
> int last_temperature;
> int emul_temperature;
> -- 
> 2.25.1
