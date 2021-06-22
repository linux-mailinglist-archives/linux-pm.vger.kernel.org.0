Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C33B05AE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFVNUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:20:16 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40629 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFVNUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 09:20:16 -0400
Received: by mail-oi1-f179.google.com with SMTP id d19so23708220oic.7;
        Tue, 22 Jun 2021 06:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaDJQ0NH97KTO6FGT4cJsOSZD7NPeBBrQGtU0KbIkPk=;
        b=p/Qy52v1vMiIM5wJvnIl9wQqyOxbhP563NRZKqCE7BSDsldGhO700TjtUGFodSGDTe
         eC6SwaQPhrZsAmtnbmkZjeiCVkGvFFYtZL7GOVbLYy+QdcPU7GBl2TrXqH4usFEWiztZ
         LDmnlNoPt4QXf5/cb6a5QTCCSEhkZVpJJDuvAOL5Kl4b1jqsK7OasiL22W++Uu3uLHxZ
         P9WrBoCT/qAu8bL3RDUmDFwQICPjNvjVuhpbPgA9CvrYlb9oBIYNWcIDqsWFHbUrPiUS
         P+COZqthgF4gmJhs8Omq8w80L+wHxR/XuA1QjQiVb5aI0rvYHRJWPKyDdfIJluCbyOGe
         usZQ==
X-Gm-Message-State: AOAM532qAFrxHWxU5qZeKXMSI5FHqgPUzNRGta5+PCMGTgM52JgNDWur
        Au4pSMfxaYEIrIyc162KAca+4ceZjHLEZ0SGRR8=
X-Google-Smtp-Source: ABdhPJy9Ckd+VxKgfCOT7Houxc1X7j/OLvThFwZNNpXpK8b5t+GrcaaH+dvr5Z7z9I8fG6LbO7ncBnpd7MIfsdAGNRg=
X-Received: by 2002:a05:6808:8d9:: with SMTP id k25mr3005369oij.69.1624367876099;
 Tue, 22 Jun 2021 06:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210621201051.3211529-1-swboyd@chromium.org>
In-Reply-To: <20210621201051.3211529-1-swboyd@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 15:17:45 +0200
Message-ID: <CAJZ5v0hTNbpSnEUwCj8Gte7febRxKGXDO_Jnee5_5o_zzECvKw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Shrink locking area of the gpd_list_lock
To:     Stephen Boyd <swboyd@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 10:10 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> On trogdor devices I see the following lockdep splat when stopping
> youtube with lockdep enabled in the kernel.
>
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.13.0-rc2 #71 Not tainted
>  ------------------------------------------------------
>  ThreadPoolSingl/3969 is trying to acquire lock:
>  ffffff80d4d5c080 (&inst->lock#3){+.+.}-{3:3}, at: vdec_buf_cleanup+0x3c/0x17c [venus_dec]
>
>  but task is already holding lock:
>  ffffff80d3c3c4f8 (&q->mmap_lock){+.+.}-{3:3}, at: vb2_core_reqbufs+0xe4/0x390 [videobuf2_common]
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #5 (&q->mmap_lock){+.+.}-{3:3}:
>         __mutex_lock_common+0xcc/0xb88
>         mutex_lock_nested+0x5c/0x68
>         vb2_mmap+0xf4/0x290 [videobuf2_common]
>         v4l2_m2m_fop_mmap+0x44/0x50 [v4l2_mem2mem]
>         v4l2_mmap+0x5c/0xa4
>         mmap_region+0x310/0x5a4
>         do_mmap+0x348/0x43c
>         vm_mmap_pgoff+0xfc/0x178
>         ksys_mmap_pgoff+0x84/0xfc
>         __arm64_compat_sys_aarch32_mmap2+0x2c/0x38
>         invoke_syscall+0x54/0x110
>         el0_svc_common+0x88/0xf0
>         do_el0_svc_compat+0x28/0x34
>         el0_svc_compat+0x24/0x34
>         el0_sync_compat_handler+0xc0/0xf0
>         el0_sync_compat+0x19c/0x1c0
>
>  -> #4 (&mm->mmap_lock){++++}-{3:3}:
>         __might_fault+0x60/0x88
>         filldir64+0x124/0x3a0
>         dcache_readdir+0x7c/0x1ec
>         iterate_dir+0xc4/0x184
>         __arm64_sys_getdents64+0x78/0x170
>         invoke_syscall+0x54/0x110
>         el0_svc_common+0xa8/0xf0
>         do_el0_svc_compat+0x28/0x34
>         el0_svc_compat+0x24/0x34
>         el0_sync_compat_handler+0xc0/0xf0
>         el0_sync_compat+0x19c/0x1c0
>
>  -> #3 (&sb->s_type->i_mutex_key#3){++++}-{3:3}:
>         down_write+0x94/0x1f4
>         start_creating+0xb0/0x174
>         debugfs_create_dir+0x28/0x138
>         opp_debug_register+0x88/0xc0
>         _add_opp_dev+0x84/0x9c
>         _add_opp_table_indexed+0x16c/0x310
>         _of_add_table_indexed+0x70/0xb5c
>         dev_pm_opp_of_add_table_indexed+0x20/0x2c
>         of_genpd_add_provider_onecell+0xc4/0x1c8
>         rpmhpd_probe+0x21c/0x278
>         platform_probe+0xb4/0xd4
>         really_probe+0x140/0x35c
>         driver_probe_device+0x90/0xcc
>         __device_attach_driver+0xa4/0xc0
>         bus_for_each_drv+0x8c/0xd8
>         __device_attach+0xc4/0x150
>         device_initial_probe+0x20/0x2c
>         bus_probe_device+0x40/0xa4
>         device_add+0x22c/0x3fc
>         of_device_add+0x44/0x54
>         of_platform_device_create_pdata+0xb0/0xf4
>         of_platform_bus_create+0x1d0/0x350
>         of_platform_populate+0x80/0xd4
>         devm_of_platform_populate+0x64/0xb0
>         rpmh_rsc_probe+0x378/0x3dc
>         platform_probe+0xb4/0xd4
>         really_probe+0x140/0x35c
>         driver_probe_device+0x90/0xcc
>         __device_attach_driver+0xa4/0xc0
>         bus_for_each_drv+0x8c/0xd8
>         __device_attach+0xc4/0x150
>         device_initial_probe+0x20/0x2c
>         bus_probe_device+0x40/0xa4
>         device_add+0x22c/0x3fc
>         of_device_add+0x44/0x54
>         of_platform_device_create_pdata+0xb0/0xf4
>         of_platform_bus_create+0x1d0/0x350
>         of_platform_bus_create+0x21c/0x350
>         of_platform_populate+0x80/0xd4
>         of_platform_default_populate_init+0xb8/0xd4
>         do_one_initcall+0x1b4/0x400
>         do_initcall_level+0xa8/0xc8
>         do_initcalls+0x5c/0x9c
>         do_basic_setup+0x2c/0x38
>         kernel_init_freeable+0x1a4/0x1ec
>         kernel_init+0x20/0x118
>         ret_from_fork+0x10/0x30
>
>  -> #2 (gpd_list_lock){+.+.}-{3:3}:
>         __mutex_lock_common+0xcc/0xb88
>         mutex_lock_nested+0x5c/0x68
>         __genpd_dev_pm_attach+0x70/0x18c
>         genpd_dev_pm_attach_by_id+0xe4/0x158
>         genpd_dev_pm_attach_by_name+0x48/0x60
>         dev_pm_domain_attach_by_name+0x2c/0x38
>         dev_pm_opp_attach_genpd+0xac/0x160
>         vcodec_domains_get+0x94/0x14c [venus_core]
>         core_get_v4+0x150/0x188 [venus_core]
>         venus_probe+0x138/0x444 [venus_core]
>         platform_probe+0xb4/0xd4
>         really_probe+0x140/0x35c
>         driver_probe_device+0x90/0xcc
>         device_driver_attach+0x58/0x7c
>         __driver_attach+0xc8/0xe0
>         bus_for_each_dev+0x88/0xd4
>         driver_attach+0x30/0x3c
>         bus_add_driver+0x10c/0x1e0
>         driver_register+0x70/0x108
>         __platform_driver_register+0x30/0x3c
>         0xffffffde113e1044
>         do_one_initcall+0x1b4/0x400
>         do_init_module+0x64/0x1fc
>         load_module+0x17f4/0x1958
>         __arm64_sys_finit_module+0xb4/0xf0
>         invoke_syscall+0x54/0x110
>         el0_svc_common+0x88/0xf0
>         do_el0_svc_compat+0x28/0x34
>         el0_svc_compat+0x24/0x34
>         el0_sync_compat_handler+0xc0/0xf0
>         el0_sync_compat+0x19c/0x1c0
>
>  -> #1 (&opp_table->genpd_virt_dev_lock){+.+.}-{3:3}:
>         __mutex_lock_common+0xcc/0xb88
>         mutex_lock_nested+0x5c/0x68
>         _set_required_opps+0x74/0x120
>         _set_opp+0x94/0x37c
>         dev_pm_opp_set_rate+0xa0/0x194
>         core_clks_set_rate+0x28/0x58 [venus_core]
>         load_scale_v4+0x228/0x2b4 [venus_core]
>         session_process_buf+0x160/0x198 [venus_core]
>         venus_helper_vb2_buf_queue+0xcc/0x130 [venus_core]
>         vdec_vb2_buf_queue+0xc4/0x140 [venus_dec]
>         __enqueue_in_driver+0x164/0x188 [videobuf2_common]
>         vb2_core_qbuf+0x13c/0x47c [videobuf2_common]
>         vb2_qbuf+0x88/0xec [videobuf2_v4l2]
>         v4l2_m2m_qbuf+0x84/0x15c [v4l2_mem2mem]
>         v4l2_m2m_ioctl_qbuf+0x24/0x30 [v4l2_mem2mem]
>         v4l_qbuf+0x54/0x68
>         __video_do_ioctl+0x2bc/0x3bc
>         video_usercopy+0x558/0xb04
>         video_ioctl2+0x24/0x30
>         v4l2_ioctl+0x58/0x68
>         v4l2_compat_ioctl32+0x84/0xa0
>         __arm64_compat_sys_ioctl+0x12c/0x140
>         invoke_syscall+0x54/0x110
>         el0_svc_common+0x88/0xf0
>         do_el0_svc_compat+0x28/0x34
>         el0_svc_compat+0x24/0x34
>         el0_sync_compat_handler+0xc0/0xf0
>         el0_sync_compat+0x19c/0x1c0
>
>  -> #0 (&inst->lock#3){+.+.}-{3:3}:
>         __lock_acquire+0x248c/0x2d6c
>         lock_acquire+0x240/0x314
>         __mutex_lock_common+0xcc/0xb88
>         mutex_lock_nested+0x5c/0x68
>         vdec_buf_cleanup+0x3c/0x17c [venus_dec]
>         __vb2_queue_free+0x98/0x204 [videobuf2_common]
>         vb2_core_reqbufs+0x14c/0x390 [videobuf2_common]
>         vb2_reqbufs+0x58/0x74 [videobuf2_v4l2]
>         v4l2_m2m_reqbufs+0x58/0x90 [v4l2_mem2mem]
>         v4l2_m2m_ioctl_reqbufs+0x24/0x30 [v4l2_mem2mem]
>         v4l_reqbufs+0x58/0x6c
>         __video_do_ioctl+0x2bc/0x3bc
>         video_usercopy+0x558/0xb04
>         video_ioctl2+0x24/0x30
>         v4l2_ioctl+0x58/0x68
>         v4l2_compat_ioctl32+0x84/0xa0
>         __arm64_compat_sys_ioctl+0x12c/0x140
>         invoke_syscall+0x54/0x110
>         el0_svc_common+0x88/0xf0
>         do_el0_svc_compat+0x28/0x34
>         el0_svc_compat+0x24/0x34
>         el0_sync_compat_handler+0xc0/0xf0
>         el0_sync_compat+0x19c/0x1c0
>
>  other info that might help us debug this:
>
>  Chain exists of:
>    &inst->lock#3 --> &mm->mmap_lock --> &q->mmap_lock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&q->mmap_lock);
>                                 lock(&mm->mmap_lock);
>                                 lock(&q->mmap_lock);
>    lock(&inst->lock#3);
>
>   *** DEADLOCK ***
>
>  1 lock held by ThreadPoolSingl/3969:
>   #0: ffffff80d3c3c4f8 (&q->mmap_lock){+.+.}-{3:3}, at: vb2_core_reqbufs+0xe4/0x390 [videobuf2_common]
>
>  stack backtrace:
>  CPU: 2 PID: 3969 Comm: ThreadPoolSingl Not tainted 5.13.0-rc2 #71
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>  Call trace:
>   dump_backtrace+0x0/0x1b4
>   show_stack+0x24/0x30
>   dump_stack+0xe0/0x15c
>   print_circular_bug+0x32c/0x388
>   check_noncircular+0x138/0x140
>   __lock_acquire+0x248c/0x2d6c
>   lock_acquire+0x240/0x314
>   __mutex_lock_common+0xcc/0xb88
>   mutex_lock_nested+0x5c/0x68
>   vdec_buf_cleanup+0x3c/0x17c [venus_dec]
>   __vb2_queue_free+0x98/0x204 [videobuf2_common]
>   vb2_core_reqbufs+0x14c/0x390 [videobuf2_common]
>   vb2_reqbufs+0x58/0x74 [videobuf2_v4l2]
>   v4l2_m2m_reqbufs+0x58/0x90 [v4l2_mem2mem]
>   v4l2_m2m_ioctl_reqbufs+0x24/0x30 [v4l2_mem2mem]
>   v4l_reqbufs+0x58/0x6c
>   __video_do_ioctl+0x2bc/0x3bc
>   video_usercopy+0x558/0xb04
>   video_ioctl2+0x24/0x30
>   v4l2_ioctl+0x58/0x68
>   v4l2_compat_ioctl32+0x84/0xa0
>   __arm64_compat_sys_ioctl+0x12c/0x140
>   invoke_syscall+0x54/0x110
>   el0_svc_common+0x88/0xf0
>   do_el0_svc_compat+0x28/0x34
>   el0_svc_compat+0x24/0x34
>   el0_sync_compat_handler+0xc0/0xf0
>   el0_sync_compat+0x19c/0x1c0
>
> The 'gpd_list_lock' is nominally named as such to protect the 'gpd_list'
> from concurrent access and mutation. Unfortunately, holding that mutex
> around various OPP framework calls leads to lockdep splats because now
> we're doing various operations in OPP core such as registering with
> debugfs while holding the list lock. We don't need to hold any list
> mutex while we're calling into OPP, so let's shrink the locking area of
> the 'gpd_list_lock' so that lockdep isn't triggered. This also helps
> reduce contention on this lock, which probably doesn't matter much but
> at least is nice to have.

Ulf and Viresh need to see this.

>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <linux-pm@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/domain.c | 40 ++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b6a782c31613..18063046961c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1984,8 +1984,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>
>         mutex_lock(&gpd_list_lock);
>         list_add(&genpd->gpd_list_node, &gpd_list);
> -       genpd_debug_add(genpd);
>         mutex_unlock(&gpd_list_lock);
> +       genpd_debug_add(genpd);
>
>         return 0;
>  }
> @@ -2162,9 +2162,11 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>         cp->xlate = xlate;
>         fwnode_dev_initialized(&np->fwnode, true);
>
> +       mutex_lock(&gpd_list_lock);
>         mutex_lock(&of_genpd_mutex);
>         list_add(&cp->link, &of_genpd_providers);
>         mutex_unlock(&of_genpd_mutex);
> +       mutex_unlock(&gpd_list_lock);
>         pr_debug("Added domain provider from %pOF\n", np);
>
>         return 0;
> @@ -2172,12 +2174,19 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>
>  static bool genpd_present(const struct generic_pm_domain *genpd)
>  {
> +       bool ret = false;
>         const struct generic_pm_domain *gpd;
>
> -       list_for_each_entry(gpd, &gpd_list, gpd_list_node)
> -               if (gpd == genpd)
> -                       return true;
> -       return false;
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +               if (gpd == genpd) {
> +                       ret = true;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return ret;
>  }
>
>  /**
> @@ -2188,15 +2197,13 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
>  int of_genpd_add_provider_simple(struct device_node *np,
>                                  struct generic_pm_domain *genpd)
>  {
> -       int ret = -EINVAL;
> +       int ret;
>
>         if (!np || !genpd)
>                 return -EINVAL;
>
> -       mutex_lock(&gpd_list_lock);
> -
>         if (!genpd_present(genpd))
> -               goto unlock;
> +               return -EINVAL;
>
>         genpd->dev.of_node = np;
>
> @@ -2207,7 +2214,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
>                         if (ret != -EPROBE_DEFER)
>                                 dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
>                                         ret);
> -                       goto unlock;
> +                       return ret;
>                 }
>
>                 /*
> @@ -2225,16 +2232,13 @@ int of_genpd_add_provider_simple(struct device_node *np,
>                         dev_pm_opp_of_remove_table(&genpd->dev);
>                 }
>
> -               goto unlock;
> +               return ret;
>         }
>
>         genpd->provider = &np->fwnode;
>         genpd->has_provider = true;
>
> -unlock:
> -       mutex_unlock(&gpd_list_lock);
> -
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
>
> @@ -2253,8 +2257,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>         if (!np || !data)
>                 return -EINVAL;
>
> -       mutex_lock(&gpd_list_lock);
> -
>         if (!data->xlate)
>                 data->xlate = genpd_xlate_onecell;
>
> @@ -2294,8 +2296,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>         if (ret < 0)
>                 goto error;
>
> -       mutex_unlock(&gpd_list_lock);
> -
>         return 0;
>
>  error:
> @@ -2314,8 +2314,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                 }
>         }
>
> -       mutex_unlock(&gpd_list_lock);
> -
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
>
> base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
> --
> https://chromeos.dev
>
