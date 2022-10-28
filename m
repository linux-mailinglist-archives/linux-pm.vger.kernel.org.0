Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6606119A0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ1RvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1RvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 13:51:12 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3646772EF3
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 10:51:11 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id j21so3909473qkk.9
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 10:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwLbVyCHpeoUl2n6bydmVhbfkQylsgv+UGSFppXPI/w=;
        b=gS5e9MQSmbyCVVwU+D5C2AQqrCc/IBJUYp51RZwTTr3YZiz1x4+VXQ5ISpvkNlx8X/
         7CoexBsm2HRCW47K5Y1JMuVQ+ZoPoAyZ4EB7NkCsr8n3r/wZfUDNbmqjHU2551k8zZdj
         58I99VELS0vQ2jd+c+LhuUBIe8vk+2XIVPrw5NAqnVLw5McEOAu1wX9HwihmuY1J44ny
         IPZauMvBetBG5bDOvjfwDGxC6mqgST8aVmXB3Ody/AJIoL44U0TUjoWAcucHBPbnyr8u
         SKgwv2fXNZPCy0/EWador38HArELmwekb3j9PjiB1hvvQs3xHF1WK5Qf1eyhC1GemwA6
         ACEg==
X-Gm-Message-State: ACrzQf0ftM0mqwvSaPhAdhjlwLe9Ra+5ZuQHkKhLwvC8riquURfQoECc
        iRFE8ouvnFNMVd7ohDasshI1tE91QN20oiI7C98=
X-Google-Smtp-Source: AMsMyM69bgB87sQ1K2vOjb+uP3T0M9lR/icJhNhqelUd77f7jafTC69brMZxajPsLDldpIKFt0R/I0ybAAJsWq/zm9k=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr303639qkl.443.1666979470373; Fri, 28 Oct
 2022 10:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221028114433.51839-1-linus.walleij@linaro.org>
In-Reply-To: <20221028114433.51839-1-linus.walleij@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 19:50:59 +0200
Message-ID: <CAJZ5v0gVSZo2J2TO_0cL01P4EGLDOQ8ZkzZi=zLjPrO03WMP7g@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Accept but warn about TZ without trip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 28, 2022 at 1:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> The thermal OF core used to accept the creation of thermal zones
> without trip points, but recent changes made it error out as
> thermal zones should according to specification have trip
> points.
>
> Relax the requirements so we still create those thermal zones
> but make a request to update the DTS in the kernel log.
>
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/thermal/thermal_of.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index d4b6335ace15..f683cbb4a72a 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -592,8 +592,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>         struct thermal_zone_params *tzp;
>         struct thermal_zone_device_ops *of_ops;
>         struct device_node *np;
> -       int delay, pdelay;
> -       int ntrips, mask;
> +       int delay = 0, pdelay = 0;
> +       int ntrips = 0, mask = 0;
>         int ret;
>
>         of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> @@ -610,7 +610,9 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>         trips = thermal_of_trips_init(np, &ntrips);
>         if (IS_ERR(trips)) {
>                 pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> -               return ERR_CAST(trips);
> +               pr_err("Trip points are compulsory for thermal zones, please add them to the DTS\n");
> +               trips = NULL;
> +               goto out_register;
>         }
>
>         ret = thermal_of_monitor_init(np, &delay, &pdelay);
> @@ -636,6 +638,7 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>
>         mask = GENMASK_ULL((ntrips) - 1, 0);
>
> +out_register:
>         tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>                                                      mask, data, of_ops, tzp,
>                                                      pdelay, delay);
> --

Applied, but I'll push it for -rc4.

Thanks!
