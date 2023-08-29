Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341EE78CC21
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjH2Sb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 29 Aug 2023 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbjH2SbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 14:31:20 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B752CD9;
        Tue, 29 Aug 2023 11:31:14 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5711d5dac14so1122191eaf.0;
        Tue, 29 Aug 2023 11:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693333874; x=1693938674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04jRexBH37zEH8Sj3vb5eNPzV7vueteNNrFCmhZo3H0=;
        b=A82g6VhaCl0+jUJfZebdHdGIn//vUu3wpqTPy5G0fPFJ+SAepv1ie9i5JnbKvhyV+3
         R0q6ikFiDsVeRaqKjEOgB9Nn/Fnj5dJyh07m/aoA7vRi3RAztMViIkbEZt8hiP1TRrMS
         QiqC5ZbngFd8F9rWQViVfZBWyp+eJF8bBp3Mfyz3ZJK8x1KqJGw7AAdkVaDqqhG8SI59
         kWOC3Fprh1uVkyuaFOdu+Tw/0mHloyLIpXsYatIvMkQ6unK5CFaLUMEDFGOFw15Hm8Y7
         twHkdGzgp60y1/F7st+vDUapc8gmQH8YdLQZGDjdd1M9vs5hPhvHIwHoUZcQAWMYxOvq
         VX9g==
X-Gm-Message-State: AOJu0YwSkP6YYjMAZvmYgsBTahbUxkh25WUFesjRvBlBaV/M+A60TAC8
        zaWKNclph6xKX+3TZg2bjenk1NW+vaLkLxuDYwo=
X-Google-Smtp-Source: AGHT+IEaD5yNtndpwU4QXqG5DyL1f17KOO2HAro4HGkSZdC+7y0/GvhhSQFaUPTEcb68AyRt5jtiplYvVtoX6qbh2/Y=
X-Received: by 2002:a4a:c3cb:0:b0:573:2a32:6567 with SMTP id
 e11-20020a4ac3cb000000b005732a326567mr14938793ooq.0.1693333873851; Tue, 29
 Aug 2023 11:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230829120924.1711175-1-festevam@gmail.com> <20230829120924.1711175-3-festevam@gmail.com>
In-Reply-To: <20230829120924.1711175-3-festevam@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 20:31:02 +0200
Message-ID: <CAJZ5v0iJ0xvdep2G1_s3C7XmmAb5JabDsA0BvOisPGc3Udj9nA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] thermal: thermal_core: Allow rebooting after
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

On Tue, Aug 29, 2023 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:
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
> Changes since v3:
> - None.
>
>  drivers/thermal/thermal_core.c |  8 +++++++-
>  drivers/thermal/thermal_of.c   | 27 +++++++++++++++++++++++++++
>  include/linux/thermal.h        |  6 ++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a59700593d32..f69e1667acb1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -320,11 +320,17 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
>          * Its a must for forced_emergency_poweroff_work to be scheduled.
>          */
>         int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
> +       void (*hw_protection_action)(const char *reason, int ms_until_forced);
>
>         dev_emerg(&tz->device, "%s: critical temperature reached, "
>                   "shutting down\n", tz->type);
>
> -       hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
> +       hw_protection_action = hw_protection_shutdown;
> +
> +       if (tz->action == THERMAL_CRITICAL_ACTION_REBOOT)
> +               hw_protection_action = hw_protection_reboot;
> +
> +       hw_protection_action("Temperature too high", poweroff_delay_ms);

Why not define

        static const char *msg = "Temperature too high";

and then

        if (tz->action == THERMAL_CRITICAL_ACTION_REBOOT)
                hw_protection_reboot(msg, poweroff_delay_ms);
        else
               hw_protection_shutdown((msg, poweroff_delay_ms);
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
> index b449a46766f5..08854f640db9 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -34,6 +34,11 @@ struct thermal_cooling_device;
>  struct thermal_instance;
>  struct thermal_attr;
>
> +enum thermal_action {
> +       THERMAL_CRITICAL_ACTION_SHUTDOWN, /* shutdown when crit temperature is reached */

      THERMAL_CRITICAL_ACTION_SHUTDOWN = 0,

so it is clear what will happen on non-DT platforms.

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
