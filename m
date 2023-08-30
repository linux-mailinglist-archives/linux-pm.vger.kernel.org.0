Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67678DA77
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjH3SgY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 30 Aug 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbjH3LSf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 07:18:35 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245F122;
        Wed, 30 Aug 2023 04:18:33 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-573128cd77dso791411eaf.0;
        Wed, 30 Aug 2023 04:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693394312; x=1693999112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=949eSJ97UUP4EMRebkVt9sELnd9wzsIRRXBTrdPP/Vg=;
        b=CmQ2Ea+0hvOBla48vcHUJ9P/yZXtJEIkC54+3sE+s+G1FVQp53jQ909oZpxxZINkja
         SVDTE+hvcs0NLJRJMVLDk70GDDQBDFuBgcb3rzzQcDL+3Tu9zOnmb5Qfj0rIANoxGyT2
         LnYrB4UC1UBqDazmaWn8DYCwBJ2Ja7a59eaQkvoLOso+9zZk/9laQJWeoKsXUVMR3vw4
         eTQDAoV7g+ddcFjkCERZnw96ANPpAHz2d18UdF3AXiQdJrQre7fwE33YDR5Bq6dIMQ/p
         Fna5p/xWuVsnSPsBPnAba0xF4pmRKHosZQzNzFXOuit+ixH8B5jWg0nu8aPRs7kLnHWR
         cvKg==
X-Gm-Message-State: AOJu0Yxu0Hhr/KnsTeoD/rkzZrTUzW+qi6Mpj+1ZXlxlOhKje1yMULlf
        svUDY+F3u/1B7llu8y5AETf2EpUkvDz5fc6TuJo=
X-Google-Smtp-Source: AGHT+IGjUB4/qLkUwQwSco0OrxTfj8TU6YnCPhpd7Ezyb2ZaEHPMJ8PMYVYYEhDbnkv8MkkTf++Cgn9x/3KVHXzh8b4=
X-Received: by 2002:a05:6820:1b18:b0:56e:94ed:c098 with SMTP id
 bv24-20020a0568201b1800b0056e94edc098mr1937909oob.0.1693394312326; Wed, 30
 Aug 2023 04:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230829194200.1901988-1-festevam@gmail.com> <20230829194200.1901988-3-festevam@gmail.com>
In-Reply-To: <20230829194200.1901988-3-festevam@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 13:18:19 +0200
Message-ID: <CAJZ5v0jEmCnxGC5NXnxKo27k4QHib5-JoGnySE_QegRODg2=Rg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] thermal: thermal_core: Allow rebooting after
 critical temp
To:     Fabio Estevam <festevam@gmail.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Currently, the default mechanism is to trigger a shutdown after the
> critical temperature is reached.
>
> In some embedded cases, such behavior does not suit well, as the board may
> be unattended in the field and rebooting may be a better approach.
>
> The bootloader may also check the temperature and only allow the boot to
> proceed when the temperature is below a certain threshold.
>
> Introduce support for allowing a reboot to be triggered after the
> critical temperature is reached.
>
> If the "critical-action" devicetree property is not found, fall back to
> the shutdown action to preserve the existing default behavior.
>
> Tested on a i.MX8MM board with the following devicetree changes:
>
>         thermal-zones {
>                 cpu-thermal {
>                         critical-action = "reboot";
>                 };
>         };
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v4:
> - Simplify the logic inside thermal_zone_device_critical(). (Rafael)
> - Declare THERMAL_CRITICAL_ACTION_SHUTDOWN = 0 so it is clear what happens
> on non-DT platforms. (Rafael)
>
>  drivers/thermal/thermal_core.c |  6 +++++-
>  drivers/thermal/thermal_of.c   | 27 +++++++++++++++++++++++++++
>  include/linux/thermal.h        |  6 ++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a59700593d32..062114608667 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -320,11 +320,15 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
>          * Its a must for forced_emergency_poweroff_work to be scheduled.
>          */
>         int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
> +       static const char *msg = "Temperature too high";
>
>         dev_emerg(&tz->device, "%s: critical temperature reached, "
>                   "shutting down\n", tz->type);
>
> -       hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
> +       if (tz->action == THERMAL_CRITICAL_ACTION_REBOOT)
> +               hw_protection_reboot(msg, poweroff_delay_ms);
> +       else
> +               hw_protection_shutdown(msg, poweroff_delay_ms);
>  }
>  EXPORT_SYMBOL(thermal_zone_device_critical);
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 4ca905723429..8bc28cba7406 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -218,6 +218,31 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>         return tz;
>  }
>
> +static const char * const critical_actions[] = {
> +       [THERMAL_CRITICAL_ACTION_SHUTDOWN]      = "shutdown",
> +       [THERMAL_CRITICAL_ACTION_REBOOT]        = "reboot",
> +};
> +
> +static void thermal_of_get_critical_action(struct device_node *np,
> +                                          enum thermal_action *action)
> +{
> +       const char *action_string;
> +       int i, ret;
> +
> +       ret = of_property_read_string(np, "critical-action", &action_string);
> +       if (ret < 0)
> +               goto out_default_action;
> +
> +       for (i = 0; i < ARRAY_SIZE(critical_actions); i++)
> +               if (!strcasecmp(action_string, critical_actions[i])) {
> +                       *action = i;
> +                       return;
> +               }

This looks somewhat artificial and is a bit questionable (the index
variable should arguably start at THERMAL_CRITICAL_ACTION_SHUTDOWN,
for instance, and the "shutdown" item is redundant).

There are only two values and you want to carry out an emergency
shutdown anyway if the value is not "reboot".

I would just do

    if (!strcasecmp(action_string, "reboot")) {
            *action = THERMAL_CRITICAL_ACTION_REBOOT;
            return;
    }

> +
> +out_default_action:
> +       *action = THERMAL_CRITICAL_ACTION_SHUTDOWN;
> +}
> +
>  static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
>  {
>         int ret;
> @@ -516,6 +541,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>                 goto out_kfree_trips;
>         }
>
> +       thermal_of_get_critical_action(np, &tz->action);
> +
>         ret = thermal_zone_device_enable(tz);
>         if (ret) {
>                 pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b449a46766f5..b68e5734823d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -34,6 +34,11 @@ struct thermal_cooling_device;
>  struct thermal_instance;
>  struct thermal_attr;
>
> +enum thermal_action {
> +       THERMAL_CRITICAL_ACTION_SHUTDOWN = 0, /* shutdown when crit temperature is reached */
> +       THERMAL_CRITICAL_ACTION_REBOOT, /* reboot when crit temperature is reached */
> +};
> +
>  enum thermal_trend {
>         THERMAL_TREND_STABLE, /* temperature is stable */
>         THERMAL_TREND_RAISING, /* temperature is raising */
> @@ -187,6 +192,7 @@ struct thermal_zone_device {
>         struct list_head node;
>         struct delayed_work poll_queue;
>         enum thermal_notify_event notify_event;
> +       enum thermal_action action;
>  };
>
>  /**
> --
