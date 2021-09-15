Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F7B40C473
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhIOLkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 07:40:47 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36563 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhIOLkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 07:40:47 -0400
Received: by mail-ot1-f54.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso3134612otv.3;
        Wed, 15 Sep 2021 04:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYTcbA5Ahjo9KtFVWxFzGGm1rNBsd0oQUD/2RAww7fw=;
        b=13lL98XgskriqN0U7RXU3197vmRKwQ0F5OMzxaBhgJD0IAjnq7Rk+4LQ7GcLq027Wj
         yQ16HxMnYSjjOawxKOEJjXPcxYFsuzWpBzg+gXmyYXGtwgmSW9CmFfk3Br+cWCklTv9e
         kpSgmg1B2ok3PuVdEMi//KHViWipE714+S1UWG7+PoMZn2DjZdFUyD/woXMZHkYIGD28
         ebUhOhg/sqImKKNVGcv/KfpoKK5ssbKr8VCcfZRwbh79cTPkQJ/6PM++8igv/iAlw+DU
         +9x0ocbDrxML0jGhvsidCYDd18+wrxRu+ub4lMx5hQayvbvkcD/51CDS90d8uRROyvuR
         7DDQ==
X-Gm-Message-State: AOAM532feF2Hk6xoaJuRDjb7tRRPN1Xswrk56GOoHEdTzSpPCcqAQztS
        jgpWZH+xIgzpqEdtksQwIreVf4RKWgtYbZIDi3g=
X-Google-Smtp-Source: ABdhPJw8lqagZSxQ5o/v6kd3Z8ZkZOOo/1H5yVKfA6fYLvkHbV1+E4AnwXBYhL0DcqGTlpLmBMLv9pph4/P3LqGxKp4=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr19175818ote.319.1631705967964;
 Wed, 15 Sep 2021 04:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210914203542.209-1-quic_qiancai@quicinc.com>
In-Reply-To: <20210914203542.209-1-quic_qiancai@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Sep 2021 13:39:15 +0200
Message-ID: <CAJZ5v0jkZCLrw47vrNcn4pcJV8UuQJbYxU9xdCurSTVjeQv4Lw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix an use-after-free in gov_attr_set_put
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hao <haokexin@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 14, 2021 at 10:37 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> A recent commit started to call sugov_tunables_free() in
> kobject_release() which results in an use-after-free when
> mutex_destroy() is called later in gov_attr_set_put(). Fixed it by
> calling mutex_destroy() before kobject_put().
>
> BUG: KASAN: use-after-free in mutex_is_locked+0x24/0x60
> Read of size 8 at addr ffff000877717950 by task cpuhp/0/15
>
> Call trace:
>  dump_backtrace+0x0/0x3b8
>  show_stack+0x20/0x30
>  dump_stack_lvl+0x8c/0xb8
>  print_address_description.constprop.0+0x74/0x3c8
>  kasan_report+0x1f0/0x208
>  kasan_check_range+0x100/0x1b8
>  __kasan_check_read+0x34/0x60
>  mutex_is_locked+0x24/0x60
>  mutex_destroy+0x7c/0xf8
>  gov_attr_set_put+0x140/0x1b0
>  sugov_exit+0x7c/0x198
>  cpufreq_exit_governor+0x78/0x178
>  cpufreq_offline+0x2f8/0x6f8
>  cpuhp_cpufreq_offline+0x18/0x28
>  cpuhp_invoke_callback+0x51c/0x2ab8
>  cpuhp_thread_fun+0x204/0x588
>  smpboot_thread_fn+0x3f0/0xc40
>  kthread+0x3bc/0x470
>  ret_from_fork+0x10/0x20
>
> Allocated by task 638:
>  kasan_save_stack+0x28/0x58
>  __kasan_kmalloc+0x8c/0xb0
>  kmem_cache_alloc_trace+0x21c/0x358
>  sugov_init+0x478/0x768
>  cpufreq_init_governor+0x11c/0x318
>  cpufreq_set_policy+0x5d0/0xd88
>  cpufreq_online+0x72c/0x1938
>  cpufreq_add_dev+0x154/0x1a8
>  subsys_interface_register+0x218/0x360
>  cpufreq_register_driver+0x2a4/0x4c0
>  0xffff8000098d0348
>  do_one_initcall+0x160/0xb48
>  do_init_module+0x18c/0x648
>  load_module+0x2614/0x3238
>  __do_sys_finit_module+0x118/0x1a8
>  __arm64_sys_finit_module+0x74/0xa8
>  invoke_syscall.constprop.0+0xdc/0x1d8
>  do_el0_svc+0x1f8/0x298
>  el0_svc+0x64/0x130
>  el0t_64_sync_handler+0xb0/0xb8
>  el0t_64_sync+0x180/0x184
>
> Freed by task 15:
>  kasan_save_stack+0x28/0x58
>  kasan_set_track+0x28/0x40
>  kasan_set_free_info+0x28/0x50
>  __kasan_slab_free+0xfc/0x150
>  slab_free_freelist_hook+0x108/0x200
>  kfree+0x13c/0x3b8
>  sugov_tunables_free+0x18/0x28
>  kobject_release+0xe4/0x360
>  kobject_put+0x7c/0x138
>  gov_attr_set_put+0x138/0x1b0
>  sugov_exit+0x7c/0x198
>  cpufreq_exit_governor+0x78/0x178
>  cpufreq_offline+0x2f8/0x6f8
>  cpuhp_cpufreq_offline+0x18/0x28
>  cpuhp_invoke_callback+0x51c/0x2ab8
>  cpuhp_thread_fun+0x204/0x588
>  smpboot_thread_fn+0x3f0/0xc40
>  kthread+0x3bc/0x470
>  ret_from_fork+0x10/0x20
>
> The buggy address belongs to the object at ffff000877717900
>                 which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 80 bytes inside of
>                 256-byte region [ffff000877717900, ffff000877717a00)
> The buggy address belongs to the page:
> page:ffffffc0021ddc40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8f771
> flags: 0x7ffff800000200(slab|node=0|zone=0|lastcpupid=0xfffff)
> raw: 007ffff800000200 ffffffc0021a6508 ffffffc0022bd488 ffff000012910980
> raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000877717800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff000877717880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff000877717900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                  ^
>  ffff000877717980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff000877717a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> Fixes: e5c6b312ce3c ("cpufreq: schedutil: Use kobject release() method to free sugov_tunables")
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  drivers/cpufreq/cpufreq_governor_attr_set.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor_attr_set.c b/drivers/cpufreq/cpufreq_governor_attr_set.c
> index 66b05a326910..a6f365b9cc1a 100644
> --- a/drivers/cpufreq/cpufreq_governor_attr_set.c
> +++ b/drivers/cpufreq/cpufreq_governor_attr_set.c
> @@ -74,8 +74,8 @@ unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *l
>         if (count)
>                 return count;
>
> -       kobject_put(&attr_set->kobj);
>         mutex_destroy(&attr_set->update_lock);
> +       kobject_put(&attr_set->kobj);

Another patch fixing this issue has been queued up already:
https://patchwork.kernel.org/project/linux-pm/patch/20210914165623.18972-1-james.morse@arm.com/

Thanks!

>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(gov_attr_set_put);
> --
> 2.25.1
>
