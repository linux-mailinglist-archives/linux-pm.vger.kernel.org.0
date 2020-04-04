Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0B19E356
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDDHbo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 03:31:44 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33971 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDDHbo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 03:31:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id b5so6528324vsb.1
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2020 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48bgmIC7P0k4WqoMKtIKT6TqPnKQM4JrqDfrBmPfJWE=;
        b=Fr1/98+ylP6lUUNN0lwT6j0DbCTEZqQvajyZwNhEL46JKpLa9djlu+7gVWNL0ZpF98
         QGjmcGzS3gsIz9cimSB93YZAFsENs/jQsu3sm7X3RWchoFLDlL6FqfW5wRFCbUgfXsqr
         pOgjsqYIivNCC6oyZyK8VbdfpYPkWElbN1fAra8JGznbxVkn4kHmzpeyxlNzymxEz3sp
         XpCZcslb3XDF25E/1KzFhtHp9dkH0l5axGteq6zYJnvrE2LsephNAUvc1vo+R8gFx3An
         Gy4xTUunBTdtBSjlKDJCq2Ivho3il+e7Rb9gQFzeD5w3d2SB3+AWah321MKIirLeIYzd
         ziPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48bgmIC7P0k4WqoMKtIKT6TqPnKQM4JrqDfrBmPfJWE=;
        b=ckYlX3LGA/fQXfbV67Tx2qposQB/95xTolEX2ECoWv5LzWMEWiBUOBAT/K98JWo+Ic
         TSWXVaKG3G8ZYjZFB4lHrTanE3aI+iBOjElA3MfkJGIG0RqSdoYvg2GDw+ZMW3h3hDk4
         SQev0dD7977NatnEbfCyPDrfNizcLAJe1TVPDQVe2QXbpn7bOpzPYKoJMrKKGVdfsTts
         PRicCF+MUj/3B2+Bw3gonmhUSvVKt++7FRkkeBm2CxKl1ZWBzBOAkKcX5drAKv3ElPTr
         L01Vti1t4/Slopk8h6RGUfLX2yhwZqCPlZN7EfrWHKgwUhwajV5BEsa+mIqVo9lmti9K
         69Yg==
X-Gm-Message-State: AGi0PualYW8Y8QHzyvv4UWgeMGgt0uicr1Hd0uVmPWwAQcb0A0Kljp5Q
        yx7QTh7VZvzsgQt4Y/DFvTAEo7u0sk+zlBZXMLXkpw==
X-Google-Smtp-Source: APiQypIBenk0H3x/HRjGTe8kFqJVE/KWTdiRglc5BJjUqOi1TazsAbkmt4wXx5+W2DYekvPzGYaizkRezh8QffmXmzE=
X-Received: by 2002:a67:b147:: with SMTP id z7mr9276115vsl.27.1585985502657;
 Sat, 04 Apr 2020 00:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-6-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-6-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerMXEt1hQtzBLRxsEvWBq75AHdaAOc1b6XgWOTVSPxmDJQ@mail.gmail.com>
Subject: Re: [PATCH V2 6/9] thermal: Move get_thermal_instance to the internal header
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The function is not used any place other than the thermal
> directory. It does not make sense to export its definition in the
> global header as there is no use of it.
>
> Move the definition to the internal header and allow better
> self-encapsulation.
>
> Take the opportunity to add the parameter names to make checkpatch
> happy and remove the pointless stubs.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.h | 5 +++++
>  include/linux/thermal.h        | 6 ------
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 5fb2bd9c7034..c95689586e19 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -74,6 +74,11 @@ struct thermal_trip {
>
>  int get_tz_trend(struct thermal_zone_device *tz, int trip);
>
> +struct thermal_instance *
> +get_thermal_instance(struct thermal_zone_device *tz,
> +                    struct thermal_cooling_device *cdev,
> +                    int trip);
> +
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 8006ba5de855..47e745c5dfca 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -414,8 +414,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>
> -struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
> -               struct thermal_cooling_device *, int);
>  void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
>  #else
> @@ -473,10 +471,6 @@ static inline int thermal_zone_get_offset(
>                 struct thermal_zone_device *tz)
>  { return -ENODEV; }
>
> -static inline struct thermal_instance *
> -get_thermal_instance(struct thermal_zone_device *tz,
> -       struct thermal_cooling_device *cdev, int trip)
> -{ return ERR_PTR(-ENODEV); }
>  static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  { }
>  static inline void thermal_notify_framework(struct thermal_zone_device *tz,
> --
> 2.17.1
>
