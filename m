Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23C443371A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJSNeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 09:34:05 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41775 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJSNeF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 09:34:05 -0400
Received: by mail-ot1-f53.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so1923209ote.8;
        Tue, 19 Oct 2021 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6dyuKoKqnraomZVjHNySnHy0G4MecFaWtG9OL7iF/g=;
        b=3YMVKJa+WR1/8HWqiOksdsdTyYyuB3CqmZdYCrYn5nptGhBQgqp0BLyBpXIm4A4Gt6
         JHobrktXBvgrtPMtrPAKvTYvRQhOudS3zveoGE65qYarLPEeEDqrE/Kz4J9Nq+JD5Qh0
         5vpDuBF68pnbFJXwrVGFiqqr7AhtLDOxTMG42ZWk6maJtnm0b14yo5nNQF0lJ2eATEZs
         m3/ncGMECkUDN9WUlAn6QV37o8gYdRKlMbvILAr1cHVir9TObaiu4HJMzRGLzJrHCMFC
         JizPWaTUaGGdaeokBP0D8aswqmhkHgOsvj0uVuifuzeA+6ggeCMRmzTWd1GD3i1G0PDk
         DWfg==
X-Gm-Message-State: AOAM532jAa82K5/M3HNUA3JPaAFt3aBI2NWhJ90zQPyCuixg/LMuVvzj
        B6LWiUtKqqrFFBqf9Vzn8srouOjlU/86Y7LXj/Y=
X-Google-Smtp-Source: ABdhPJzA4KeA+we+cX9bD7GpWwMAux6IBCf3UUSiJNx5IcLvLkWmjiGrhbC/PTFmD5I/fjtqTzbSrvcJ5P2MisoO0V0=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr5364765ott.254.1634650312053;
 Tue, 19 Oct 2021 06:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211019132211.2792475-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 15:31:40 +0200
Message-ID: <CAJZ5v0hBZ9R8LO340uY62bcMJK0KKi2RkX3p_SYPrkWJ-Qd8xQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/core: Make the userspace governor deprecated
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 3:22 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The userspace governor is sending temperature when polling is active
> and trip point crossed events. Nothing else.
>
> AFAICT, this governor is used with custom kernels making the userspace
> governor co-existing with another governor on the same thermal zone
> because there was no notification mechanism.
>
> The new netlink thermal notification is able to provide more
> information than the userspace governor and give the opportunity to
> the users of this governor to replace it by a dedicated notification
> framework.
>
> The userspace governor will be removed as its usage is no longer
> needed.
>
> Add a warning message to tell the userspace governor is deprecated.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/gov_user_space.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
> index 82a7198bbe71..95d6d3d6b8f7 100644
> --- a/drivers/thermal/gov_user_space.c
> +++ b/drivers/thermal/gov_user_space.c
> @@ -15,6 +15,14 @@
>
>  #include "thermal_core.h"
>
> +static int user_space_bind(struct thermal_zone_device *tz)
> +{
> +       WARN(1, "Userspace governor deprecated: use thermal netlink "   \
> +            "notification instead\n");

This is really aggressive, because this becomes BUG() in certain
kernel configurations.

pr_warn() should be sufficient IMO.

> +
> +       return 0;
> +}
> +
>  /**
>   * notify_user_space - Notifies user space about thermal events
>   * @tz: thermal_zone_device
> @@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
>  static struct thermal_governor thermal_gov_user_space = {
>         .name           = "user_space",
>         .throttle       = notify_user_space,
> +       .bind_to_tz     = user_space_bind,
>  };
>  THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> --
