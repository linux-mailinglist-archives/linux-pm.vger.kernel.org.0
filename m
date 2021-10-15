Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F942F0B5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhJOM1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:27:21 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34715 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhJOM1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:27:21 -0400
Received: by mail-ot1-f54.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so12597421otb.1;
        Fri, 15 Oct 2021 05:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+FJSF2aUqnp4JnahjPPraJRIER8Ss0fZqzyewPOdxw=;
        b=EW3v1KVNZd2R9lxH4k5dPjnV3OU3qhnpqI9uuGyMEMZgmkEn2SH5QBEoEOOV38L1nN
         zGpv2hrGcnpuYV2wuSlCyhrNo/+Al5zvasaM4hVWRxAQqHg62cgBbnDb3U0wwtDw3A4T
         Qgq1pvbis+WfaXMLeO+gl+EmkX3GwmXLLe/suKqb0YfR2V655LmAUsPp1RGYUeh3xRgO
         6UuTWroSaPEI9WIEyBzQO8hSFxImPTAf3QeCtD+Q94G9VlRGlOeOniv4zhaXfXC4aP8x
         RHvjeX8QTpV90sMsmkMDPtt8c4HvdYpOF5McyEg8iQfF7MHuK+UkTQzN7t2E/ypIOp/R
         S1aA==
X-Gm-Message-State: AOAM530jNBNwzwE9X04hpTKjVdl/jHpWEm5HzakJ2nHdUUOkmz6GKTPG
        wI8IfouN/WYiz+HKmp2fvSgMhI18j7YFVZFVmjE=
X-Google-Smtp-Source: ABdhPJzpvYsJ5DJ8Ndb1O60aAq9rYn4j18kammzbD1H0cXoBb64cvv3HURFg9ZcXvkn9GrV9ZqkCi38FC78xu40vhVA=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr7364319oth.198.1634300714380;
 Fri, 15 Oct 2021 05:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211015024504.947520-1-william.xuanziyang@huawei.com>
In-Reply-To: <20211015024504.947520-1-william.xuanziyang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Oct 2021 14:25:03 +0200
Message-ID: <CAJZ5v0h5-P+br-+44hv82jKdd=5Y-46daXMWLwsg9WDoEfG17g@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/core: fix a UAF bug in __thermal_cooling_device_register()
To:     Ziyang Xuan <william.xuanziyang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 15, 2021 at 4:46 AM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> When device_register() return failed, program will goto out_kfree_type
> to release 'cdev->device' by put_device(). That will call thermal_release()
> to free 'cdev'. But the follow-up processes access 'cdev' continually.
> That trggers the UAF bug.
>
> ====================================================================
> BUG: KASAN: use-after-free in __thermal_cooling_device_register+0x75b/0xa90
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  dump_stack_lvl+0xe2/0x152
>  print_address_description.constprop.0+0x21/0x140
>  ? __thermal_cooling_device_register+0x75b/0xa90
>  kasan_report.cold+0x7f/0x11b
>  ? __thermal_cooling_device_register+0x75b/0xa90
>  __thermal_cooling_device_register+0x75b/0xa90
>  ? memset+0x20/0x40
>  ? __sanitizer_cov_trace_pc+0x1d/0x50
>  ? __devres_alloc_node+0x130/0x180
>  devm_thermal_of_cooling_device_register+0x67/0xf0
>  max6650_probe.cold+0x557/0x6aa
> ......
>
> Freed by task 258:
>  kasan_save_stack+0x1b/0x40
>  kasan_set_track+0x1c/0x30
>  kasan_set_free_info+0x20/0x30
>  __kasan_slab_free+0x109/0x140
>  kfree+0x117/0x4c0
>  thermal_release+0xa0/0x110
>  device_release+0xa7/0x240
>  kobject_put+0x1ce/0x540
>  put_device+0x20/0x30
>  __thermal_cooling_device_register+0x731/0xa90
>  devm_thermal_of_cooling_device_register+0x67/0xf0
>  max6650_probe.cold+0x557/0x6aa [max6650]
>
> Do not use 'cdev' again after put_device() to fix the problem like doing
> in thermal_zone_device_register().
>
> Fixes: 584837618100 ("thermal/drivers/core: Use a char pointer for the cooling device name")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 97ef9b040b84..d2c196b298c1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -888,7 +888,7 @@ __thermal_cooling_device_register(struct device_node *np,
>  {
>         struct thermal_cooling_device *cdev;
>         struct thermal_zone_device *pos = NULL;
> -       int ret;
> +       int id, ret;
>
>         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
>             !ops->set_cur_state)
> @@ -901,7 +901,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
>         if (ret < 0)
>                 goto out_kfree_cdev;
> -       cdev->id = ret;
> +       cdev->id = id = ret;

I'd prefer this to be two statements, but I can fix it up.

Daniel, would there be any issues if I applied it?

>
>         cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
>         if (!cdev->type) {
> @@ -942,8 +942,9 @@ __thermal_cooling_device_register(struct device_node *np,
>  out_kfree_type:
>         kfree(cdev->type);
>         put_device(&cdev->device);
> +       cdev = NULL;
>  out_ida_remove:
> -       ida_simple_remove(&thermal_cdev_ida, cdev->id);
> +       ida_simple_remove(&thermal_cdev_ida, id);
>  out_kfree_cdev:
>         kfree(cdev);
>         return ERR_PTR(ret);
> --
> 2.25.1
>
