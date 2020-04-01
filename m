Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCF19A715
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgDAIUV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 04:20:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39889 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDAIUT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 04:20:19 -0400
Received: by mail-ua1-f66.google.com with SMTP id z7so4362765uai.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfx+WzxfTIw9109h9/F+uN5ZdtC4CUJc38PHSbeeBtM=;
        b=kFTdCWCnXWL/FxLIRizE+7P10KR+ftxEYZsICf8C8mqGdKrRQEscI/64vPCXWOyuC9
         hv1fmKVvX9YZAvVuJ3eM8o3RuurUlQ5aquTKQh0S2A6ICZHE7hjgbois3NK3d53co6sq
         7nciOYPmbIhWZIv6ATsF1xoYIr0T6KhPhl0VmA4WURRS/qkDk74rO3sf8FvomTCCOcuq
         POSpjXZ0TQg9bAZVoaz+Xz/k2lCOWOBMBhWHOpRAtpnYuFgPGAxqJ5UKABKMW18QIPIW
         wHo700tX4cbbOuvDpdRuVG2o3DeYGmjQ6XbVJpMNSdPca0p5LK3UF4iWM61Mu8qz8srV
         8UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfx+WzxfTIw9109h9/F+uN5ZdtC4CUJc38PHSbeeBtM=;
        b=Be/SU5K7oBLMVloRykEi/xqF0rE4t5H65fviwkV9JDz/jaZvC0RdB5fldMl5Cf6uQT
         q2naSIMOXRyqmFFrRBWNKit+uPXG3BSMwrf2p50n9ezY1NCIja9Mmdt3xP6mGmO8XIRM
         vu4WaIEm6uhaf3OTUFkAILX7ZQnpI0NhqjO4JTfqJ6KX4hvQCEPYrc83zSpVXUlckI0P
         VqVWl18SjSdLZzRTTZ/HY9HaM8hhrHbe7H5XGc+xNqmqhCzOcvASc1zWyr7nOi+pw8D8
         26j6qipxHTbNQwVT0fM16FcO78CQAP9SWNg9flFxVhT0Yv+Cr4L/LtsUr5jw/egYB8Ma
         Yd+w==
X-Gm-Message-State: AGi0PuakMnTUcNEgIQUWkQj32kPIWjqzAkefd7FDUC3eo/dgbpvv+5dn
        mMUWbV6EpMSZ6qWia70/aoU8IZk192MYBrjJelTdHQ==
X-Google-Smtp-Source: APiQypJ0UixfKiD4USaplcV9xofH2gdUQll0ySr4YPXyUtqi0iouiSejQj3sS2nAegAhi7IEFT63GHFPOW6QMhDyJRw=
X-Received: by 2002:ab0:608b:: with SMTP id i11mr14498961ual.94.1585729217782;
 Wed, 01 Apr 2020 01:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200331165449.30355-1-daniel.lezcano@linaro.org> <20200331165449.30355-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200331165449.30355-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 1 Apr 2020 13:50:06 +0530
Message-ID: <CAHLCerOqyy+2H0hsrFZGD87aYpr6-fjimhKXasn=JCTK8An+qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: core: Remove pointless debug traces
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 10:27 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The last temperature and the current temperature are show via a
> dev_debug. The line before, those temperature are also traced.
>
> It is pointless to duplicate the traces for the temperatures,
> remove the dev_dbg traces.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9a321dc548c8..c06550930979 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -447,12 +447,6 @@ static void update_temperature(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>
>         trace_thermal_temperature(tz);
> -       if (tz->last_temperature == THERMAL_TEMP_INVALID)
> -               dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
> -                       tz->temperature);
> -       else
> -               dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
> -                       tz->last_temperature, tz->temperature);
>  }
>
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> --
> 2.17.1
>
