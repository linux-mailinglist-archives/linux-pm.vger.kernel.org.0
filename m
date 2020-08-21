Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF90224CE62
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHUHDF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgHUHDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 03:03:03 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1BAC061386
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2020 00:03:03 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id l184so204350vki.10
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2020 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlOtHCZhTjkTOnIHeVcT4uedUfnkkWitrR4JY7ZgBs8=;
        b=SPXJPhylKpfuB6WJexBw/N2MHPIljRVjFESN3CI9zs4CMkxx0YI7Gw/GK5524t0XLt
         uDi5K46RnV2Z/SvpckTlcCwfhAIZaD9jCT05tMgc7JX/Vygmloh27a5Ikkx3+rfdSO6c
         Qp1W5ACXfhfaekUnx0C+BLks7hWk7+ItJ88wt4D+rUh+CJRpS8O493dN/ZqD7IWL0ZvI
         0SuKqwFH4jwfbJTBgJxEjPHb78It2GZFkm8piqZTnA2wR03RMiMzS//3Ub28/rvfFWXA
         1zVb/AGsUvJRhQepUxvPSQfeKW/jCTuqYrLgLThQiiiCqEQU0J/Lsxgr5mgjM4wBCTTP
         CH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlOtHCZhTjkTOnIHeVcT4uedUfnkkWitrR4JY7ZgBs8=;
        b=szbkgbdQJtpusoNa5VA+RnAQJNqU245fQoI1czmKXnBjM2ZKVUnZcXsyK11EQKgHYG
         ifYnxI6b3FkRamm/ouX5xW36XPWhfqFDw7rmAzscVyqz+9sFwi43YyxEP0/R9l1Boc4i
         wCB1Lxv+IOxFVsjPDhEN5yPn1ixLVy1tY2qgzu6lyIbH35uRbua2dOW7cFAchj267LDq
         CyQOulujBZ8rlYYrANqVQMc6zyKo7cIGL9KVGer5HAR2r9TSnQrHmNLshEKdBnH1Lwdb
         ax5ZLB7mUYv8H6soYZ3eV9CQUbNrXQwZCWrlfcBbnm9SG9yrHQw9chpVFa/4/IhjcVjB
         Tymw==
X-Gm-Message-State: AOAM532V/4/w7Zjv5/ofOSIgmvMZ8nDxZ0otbSsVOU0I2G/sxg28ri53
        iXHh2N86jd9prcIN9lhxYGjFEDXcgaH3cUFApIQBe52sEkaoW/f4
X-Google-Smtp-Source: ABdhPJzNBbKeKvzz93LZ4nUuQZ6yinuX7g4ApvU25n702PhdmBQYK0Kuii3dIyL+bE/CCKuso/edE92BtgQ379oqqKc=
X-Received: by 2002:a1f:36c2:: with SMTP id d185mr854844vka.9.1597993382082;
 Fri, 21 Aug 2020 00:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200821024406.10404-1-zbestahu@gmail.com>
In-Reply-To: <20200821024406.10404-1-zbestahu@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 21 Aug 2020 12:32:51 +0530
Message-ID: <CAHLCerN-MAOHvk6aZX9TRVWpzduSsg-q=8K3nv=UWuG1syka+Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@yulong.com,
        zhangwen@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 21, 2020 at 8:14 AM Yue Hu <zbestahu@gmail.com> wrote:
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
> So, let's use kvzalloc() to avoid the issue, also change kfree -> kvfree.
>
> Suggested-by: Amit Kucheria <amitk@kernel.org>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

 Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/thermal_sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb..d1703ee 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/string.h>
>  #include <linux/jiffies.h>
>
> @@ -919,7 +920,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         var += sizeof(*stats->time_in_state) * states;
>         var += sizeof(*stats->trans_table) * states * states;
>
> -       stats = kzalloc(var, GFP_KERNEL);
> +       stats = kvzalloc(var, GFP_KERNEL);
>         if (!stats)
>                 return;
>
> @@ -938,7 +939,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
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
