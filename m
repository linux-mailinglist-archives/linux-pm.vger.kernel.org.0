Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AB19E354
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 09:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDDHbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 03:31:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40862 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgDDHba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 03:31:30 -0400
Received: by mail-ua1-f65.google.com with SMTP id a10so3627136uad.7
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2020 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWwqrW8wDRdL2ZORfzu8aPleq1ZB6ziGfokJ1el3IDA=;
        b=Gv0RgukIAw4tMQ0NBljFp0duysnq4ESc0TwQj02b36dtHZvHVp8ENeOZEKEBYSVs9Q
         2YRLboMMHQYZGgxdrz5cdDCsh4d/Lhv7uys0SBarv2qVliWaIN5CXmThtYCA8+LikqsG
         +bR3h16X38ZNMG4cYc8064MGEMKVhm+a61Mc86Wl/0YEkVAVXdkhVJE+vdQ6A3sx5kl7
         xN7ls8tNoxVTwi70Jxmp0SkB44brOEi4DS5YJ8xxKoaq+gqnySdwMhwm5SV2zt/LIfis
         lz9MZ82hJZ/Qw/J7idihkmc3P5jIlRoEmSvHq4/bBd+dcfLSYcbv+mC73xtT1hrw7Rx5
         cRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWwqrW8wDRdL2ZORfzu8aPleq1ZB6ziGfokJ1el3IDA=;
        b=N9rAUqTXHN3+0+QcY05iFpTyC3BBPhZBDJDXmkCF1Pksmtlrmfih5DuiVF0bxTjOuo
         CiBJnvTL84sUHruAbmRsAMQDN9kAwFHR0Ih/2qPv742E5/SIOMqKqjcafQB+ns/DjwLW
         UfJvf9X6Y2reTSW/iA8yKBixTgjcMKoOCHebxosmQ6iglVbI32RGdW5WxlQHWuAWYM3d
         ZwlyNS1QBWPlJbG4rall9Gr0nqti6xZ2WoaFYmblgoRcZx0h9ewocFwd+ANzcEe2X1OJ
         BLJhSSHCihaGMTbTo2ZyMdPi2e/PSoQSoFoBwza3sw9iuyx4aKavxphv8glIdlcH4Hr6
         yyyQ==
X-Gm-Message-State: AGi0PuYmKk0XH0UgvyXXuQRv3r35esYoFVA0+a4Gs59tcqLEcNpzkDkp
        PJ6dTyUb2Lmf4MtQVXmUBARwK78YtlgJs2vWP5pBMw==
X-Google-Smtp-Source: APiQypJBEmoxvF/AD4e0Zuvxmkgw8pp1CSkNCmko8hiCECMNb8A9iqGZN6JDYpB3+M97a+O+oSOPrZiziMZPVcGvAp4=
X-Received: by 2002:ab0:608b:: with SMTP id i11mr9120478ual.94.1585985488927;
 Sat, 04 Apr 2020 00:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-5-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-5-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerMVSAtzBc2eRn5Mokyo4qnwX33ux9dFBuoJXzSQbNJL1A@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] thermal: Move get_tz_trend to the internal header
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
>  drivers/thermal/thermal_core.h | 2 ++
>  include/linux/thermal.h        | 4 +---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index d37de708c28a..5fb2bd9c7034 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -72,6 +72,8 @@ struct thermal_trip {
>         enum thermal_trip_type type;
>  };
>
> +int get_tz_trend(struct thermal_zone_device *tz, int trip);
> +
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 7adbfe092281..8006ba5de855 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -414,7 +414,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>
> -int get_tz_trend(struct thermal_zone_device *, int);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
>                 struct thermal_cooling_device *, int);
>  void thermal_cdev_update(struct thermal_cooling_device *);
> @@ -473,8 +472,7 @@ static inline int thermal_zone_get_slope(
>  static inline int thermal_zone_get_offset(
>                 struct thermal_zone_device *tz)
>  { return -ENODEV; }
> -static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
> -{ return -ENODEV; }
> +
>  static inline struct thermal_instance *
>  get_thermal_instance(struct thermal_zone_device *tz,
>         struct thermal_cooling_device *cdev, int trip)
> --
> 2.17.1
>
