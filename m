Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9869249B82
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgHSLRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 07:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgHSLRg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Aug 2020 07:17:36 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C509120882
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597835832;
        bh=S4JeXgaIYqH870icTp/ZF+VXZdF6R8JasYiuW19iz/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qqbxZGtYZgxgtLMF2wfe3l7F3tyKjqeYOD1nS4d+9S/xGf/FYUZCi600jppnY9Xb5
         MOjB7nF64kGjPnpUXHS1kZtdzQCzw//AoAr8n4rd7c2YSnuv/y7S+1UFz8STxzjvla
         VSd4lnXmqszm4PBjoEg0FMyEG3Me3HMRWUfnr8ic=
Received: by mail-ua1-f42.google.com with SMTP id s29so6767891uae.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 04:17:12 -0700 (PDT)
X-Gm-Message-State: AOAM532IeNDAuB3Plw8JQgOAMo9SwUTJU2oZ1E/oT6FmyIOLthzekU/7
        6zT0HkpVie6lNwB0iS1euYKQoynkDTYST9aKKNTvOA==
X-Google-Smtp-Source: ABdhPJz8VEY5TV0a9IZK1zYmrdjhB3ILc5ouUTn29PK0y6mVGHfn0sueCIWIdxukuNZdEWXc9pIB+X/WCqZJ1cIhL2E=
X-Received: by 2002:a9f:226b:: with SMTP id 98mr13208054uad.94.1597835831911;
 Wed, 19 Aug 2020 04:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200818063005.13828-1-zbestahu@gmail.com>
In-Reply-To: <20200818063005.13828-1-zbestahu@gmail.com>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Wed, 19 Aug 2020 16:47:01 +0530
X-Gmail-Original-Message-ID: <CAHLCerPpsFoy=MZSQiHyCCoHLU2X=pT=NR6b0pkX93C+cd5uCg@mail.gmail.com>
Message-ID: <CAHLCerPpsFoy=MZSQiHyCCoHLU2X=pT=NR6b0pkX93C+cd5uCg@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling device's statistics
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@yulong.com,
        zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 18, 2020 at 12:00 PM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We observed warning about kzalloc() when register thermal cooling device
> in backlight_device_register(). backlight display can be a cooling device
> since reducing screen brightness will can help reduce temperature.
>
> However, ->get_max_state of backlight will assign max brightness of 1024
> to states. The memory size can be getting 1MB+ due to states * states.
> That is so large to trigger kmalloc() warning.
>
> So, let's remove it and try vzalloc() if kzalloc() fails.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb..9bae0b6 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -16,6 +16,8 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
>  #include <linux/string.h>
>  #include <linux/jiffies.h>
>
> @@ -919,7 +921,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         var += sizeof(*stats->time_in_state) * states;
>         var += sizeof(*stats->trans_table) * states * states;
>
> -       stats = kzalloc(var, GFP_KERNEL);
> +       stats = kzalloc(var, GFP_KERNEL | __GFP_NOWARN);
> +       if (!stats)
> +               stats = vzalloc(var);

Couldn't this be replaced by kvzalloc()?

>         if (!stats)
>                 return;
>
> @@ -938,7 +942,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>
>  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
>  {
> -       kfree(cdev->stats);
> +       kvfree(cdev->stats);
>         cdev->stats = NULL;
>  }
>
> --
> 1.9.1
>
