Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFF42D7C7
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhJNLKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 07:10:42 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:45633 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhJNLKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 07:10:42 -0400
Received: by mail-oi1-f172.google.com with SMTP id z126so7929957oiz.12;
        Thu, 14 Oct 2021 04:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9ftpAOOn/3SkOG0Uh/Ehyya5a3GdGOs9tqfh+nwzf4=;
        b=VJ9bLBInGlxFE/WOs3BWq3MUVp8upmKSITx8N7WnRC1/i2hU1wEoOzVCsIXtMTVKll
         /+VPU3nPCvsVh70DULUDEMPN80Tw6patiNcVL7zgqPc7cbI8/psZx7eQ7cCgV6Ifz7g1
         LnCMuIfwEWn1AWbIGUON+2rjoxPiBWVul3klJk/+SAjL3JFFhXteLoyL3XkIwC+hHn4H
         /49pNw+JL5X574q2lwd3QhB1N8r6VWjZdGccc/Dcj5j/jsHdwwKeebKtM2P/mnBLRdPT
         vuNdkdBu4dIdrKcwL/TudrhChAAGj1jRXEr/k9OS0cXM1VfB3ylU7aVd85zCAI62c2jT
         peGw==
X-Gm-Message-State: AOAM533NdcOTUS7+Hf0zvcXQvHYr70MagBbJqvwfDcZKe5ZOADM09gZr
        BuvSLNEbks563VtCOI3BYVMISDdW6Iyfdhc6Mxw=
X-Google-Smtp-Source: ABdhPJzM8wn7cMGv3ElXiFrhGs4rh/SuCanTtjIHjSS+xjQfPQThmzmvTNhJbMUFr2AeBFa5tbrPCCDGRg8fOL0VaGU=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr3544428oif.154.1634209717352;
 Thu, 14 Oct 2021 04:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211014084700.202420-1-william.xuanziyang@huawei.com>
In-Reply-To: <20211014084700.202420-1-william.xuanziyang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Oct 2021 13:08:26 +0200
Message-ID: <CAJZ5v0iiSWUN7OCD2CdkHpWOe8WvBAZ+Z+3bFeacnQ8+tsHjtA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: fix a UAF bug in __thermal_cooling_device_register()
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 14, 2021 at 10:47 AM Ziyang Xuan
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
> ---
>  drivers/thermal/thermal_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 97ef9b040b84..ee7453944ccb 100644
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
> @@ -898,10 +898,10 @@ __thermal_cooling_device_register(struct device_node *np,
>         if (!cdev)
>                 return ERR_PTR(-ENOMEM);
>
> -       ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
> -       if (ret < 0)
> +       id = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
> +       if (id < 0)

ret = id;

is missing here.

>                 goto out_kfree_cdev;

However, IMO it would be better to leave the code as is above and do

id = ret;

here.

> -       cdev->id = ret;
> +       cdev->id = id;
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
