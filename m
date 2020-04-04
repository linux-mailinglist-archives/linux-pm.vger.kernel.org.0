Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20E219E34C
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDDHbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 03:31:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41693 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgDDHbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 03:31:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id a63so6462931vsa.8
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2020 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYYENpUenW1mOBtwvfCGSxitkk6MXuBt0h7Pv0y2XUQ=;
        b=ilFI7CUrtJSEbObp2HesFPiTB4AR1aiGuk3EnDSRgtX/hwzeXMsExL2JaxO3jukIrv
         bcZq/X+c6g5rUrI0WibAck/3jqs7Lsf1ZO3RkQvy9GlgeUr5NBsDVaRSokXfeErqJH/m
         +ypokOKM2lLOG/f/i0r0id7QKcV/EZzcTzyro6x2KQdl8zo6UolTEDgOaM+6WpvSVgzX
         ZeSQPU4Z26g/Fubo9b6HdX/srMgQOQNwie9R8i31ifBU5Nt7PFmCPlJ9DO/mZB4wZvoy
         kGzWQpdQVSZ+Kza8C6OzMgT6xItrCu/zTyGVdqZHbSsA/36e69UeMiLIWjBfw+zVeYKr
         2vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYYENpUenW1mOBtwvfCGSxitkk6MXuBt0h7Pv0y2XUQ=;
        b=uWqT/6HaZtF2EhzaMDYxITjpuiUZc7usLEEU+RM2E5xwn+O5LYtrxkEXlnycxgsS6h
         QBsxZ7IUn+clCnE2I+iNFAFKfoJk1TcMmr5Z41ArM4q7ptsAabol5rLMTciRFnXskEia
         GChjwl7zZOxqNaspTv9hx1FliTBs/ruv8rD9u8weBvdEFXJhIht1gaUrcYL8bXr3KQRd
         0HkmEG1Yyt5XHzPseHe3S8U9ZhSZlzJQ6vfm2YTSS7wabsKJgZb5zFeSgN9/ssA74E5M
         dk7WcW+0nwJGc9gafVK6MWm0ypAuA8bkj+2V7tMx8uy8x6dIi0I1kVNXcdBcjP64+r0b
         0ADA==
X-Gm-Message-State: AGi0PuZdpE28jrcmSsEUGlJJ8Pj74vR5ckwlFIUe2UqOumVpMMhkKg0R
        uAVM6M9aTqjIT6ta3CqcMDHaiMipF8sWN/5K+XO8Yg==
X-Google-Smtp-Source: APiQypIwudVuiXe/LMRHhc+8ubP3TRukmM9WaTm2+ZWP9jINOT+vAJPzu1MSDfRi5eRWTsLpXV+EashporgRQZI943w=
X-Received: by 2002:a05:6102:104b:: with SMTP id h11mr9409688vsq.182.1585985482961;
 Sat, 04 Apr 2020 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-8-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-8-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerMD5fJR1nEeXPhX-=5WfTZ681KuLswcY5xXw2jfTXskWA@mail.gmail.com>
Subject: Re: [PATCH V2 8/9] thermal: Remove stubs for thermal_zone_[un]bind_cooling_device
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
> All callers of the functions depends on THERMAL, it is pointless to
> define stubs. Remove them.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/thermal.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 12df9ff0182d..7b3dbfe15b59 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -426,16 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
>  static inline void thermal_zone_device_unregister(
>         struct thermal_zone_device *tz)
>  { }
> -static inline int thermal_zone_bind_cooling_device(
> -       struct thermal_zone_device *tz, int trip,
> -       struct thermal_cooling_device *cdev,
> -       unsigned long upper, unsigned long lower,
> -       unsigned int weight)
> -{ return -ENODEV; }
> -static inline int thermal_zone_unbind_cooling_device(
> -       struct thermal_zone_device *tz, int trip,
> -       struct thermal_cooling_device *cdev)
> -{ return -ENODEV; }
>  static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                               enum thermal_notify_event event)
>  { }
> --
> 2.17.1
>
