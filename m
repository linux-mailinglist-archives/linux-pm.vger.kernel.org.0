Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722D4A9ED6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 19:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377490AbiBDSTp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 13:19:45 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:41694 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiBDSTo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 13:19:44 -0500
Received: by mail-yb1-f176.google.com with SMTP id g14so21104755ybs.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 10:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNBN7hN0eC4Os5pP3dI1qWfyTYXrlqLOQvvLhs5YRSw=;
        b=WtvyZp8maWIWMMIuKnoL8FicgZvhwVFC5gVk7iBuqYYqoJleLxShqb6Qw9l+z5yNs9
         FoLwTtNgiz+OaIo4m3lnsJQCoYARtGV6mbuhXQJot0lDa9PVMLRCGpwoGBSbcdpFuA9q
         0SynOsp/pvdKkidRoYov9kWHQvsNzhf8x8LUHN2GvkH2p3upoYA0vCv/8nx34xJbqrAM
         klaygYYNfxYLQBzfIT4Tec3wnzY1CEwFcZZnnf8OakvWiqAZHuOFeiLX3wGUsuXrBbm9
         rfE7XLN1CHVofjvDBUGVcn0hcl6kS02MeOct7Ax0q94FsdPi0Wuqg3rAgX849YvQjSnG
         Rhhg==
X-Gm-Message-State: AOAM531ZWHTjcw/YuYaY3oSAIItIJHp3ExTeHX9voF5PpTISan9QEPOb
        GlNd3cPnW0QfLjjBljhM8aAd1jcVXKOj9MJhOtE=
X-Google-Smtp-Source: ABdhPJwBPPV5IABK6roUjAOp3DE7zmLCW1RcrnUzE2jdZTuo9d/S68yKVDS23iUfZo79eLSwI2CqUhBbQfF6wutJUUQ=
X-Received: by 2002:a25:d1d4:: with SMTP id i203mr431097ybg.272.1643998783520;
 Fri, 04 Feb 2022 10:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20220123124508.463305-1-haokexin@gmail.com> <20220123124508.463305-3-haokexin@gmail.com>
In-Reply-To: <20220123124508.463305-3-haokexin@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 19:19:32 +0100
Message-ID: <CAJZ5v0hPCxNgm4s7OBdM5Zb73onJqSfTVZ+AeNQCTZA5EP+TGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: governor: Use kobject release() method to
 free dbs_data
To:     Kevin Hao <haokexin@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 23, 2022 at 1:49 PM Kevin Hao <haokexin@gmail.com> wrote:
>
> The struct dbs_data embeds a struct gov_attr_set and
> the struct gov_attr_set embeds a kobject. Since every kobject must have
> a release() method and we can't use kfree() to free it directly,
> so introduce cpufreq_dbs_data_release() to release the dbs_data via
> the kobject::release() method. This fixes the calltrace like below:
>   ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x34
>   WARNING: CPU: 12 PID: 810 at lib/debugobjects.c:505 debug_print_object+0xb8/0x100
>   Modules linked in:
>   CPU: 12 PID: 810 Comm: sh Not tainted 5.16.0-next-20220120-yocto-standard+ #536
>   Hardware name: Marvell OcteonTX CN96XX board (DT)
>   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : debug_print_object+0xb8/0x100
>   lr : debug_print_object+0xb8/0x100
>   sp : ffff80001dfcf9a0
>   x29: ffff80001dfcf9a0 x28: 0000000000000001 x27: ffff0001464f0000
>   x26: 0000000000000000 x25: ffff8000090e3f00 x24: ffff80000af60210
>   x23: ffff8000094dfb78 x22: ffff8000090e3f00 x21: ffff0001080b7118
>   x20: ffff80000aeb2430 x19: ffff800009e8f5e0 x18: 0000000000000000
>   x17: 0000000000000002 x16: 00004d62e58be040 x15: 013590470523aff8
>   x14: ffff8000090e1828 x13: 0000000001359047 x12: 00000000f5257d14
>   x11: 0000000000040591 x10: 0000000066c1ffea x9 : ffff8000080d15e0
>   x8 : ffff80000a1765a8 x7 : 0000000000000000 x6 : 0000000000000001
>   x5 : ffff800009e8c000 x4 : ffff800009e8c760 x3 : 0000000000000000
>   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001474ed040
>   Call trace:
>    debug_print_object+0xb8/0x100
>    __debug_check_no_obj_freed+0x1d0/0x25c
>    debug_check_no_obj_freed+0x24/0xa0
>    kfree+0x11c/0x440
>    cpufreq_dbs_governor_exit+0xa8/0xac
>    cpufreq_exit_governor+0x44/0x90
>    cpufreq_set_policy+0x29c/0x570
>    store_scaling_governor+0x110/0x154
>    store+0xb0/0xe0
>    sysfs_kf_write+0x58/0x84
>    kernfs_fop_write_iter+0x12c/0x1c0
>    new_sync_write+0xf0/0x18c
>    vfs_write+0x1cc/0x220
>    ksys_write+0x74/0x100
>    __arm64_sys_write+0x28/0x3c
>    invoke_syscall.constprop.0+0x58/0xf0
>    do_el0_svc+0x70/0x170
>    el0_svc+0x54/0x190
>    el0t_64_sync_handler+0xa4/0x130
>    el0t_64_sync+0x1a0/0x1a4
>   irq event stamp: 189006
>   hardirqs last  enabled at (189005): [<ffff8000080849d0>] finish_task_switch.isra.0+0xe0/0x2c0
>   hardirqs last disabled at (189006): [<ffff8000090667a4>] el1_dbg+0x24/0xa0
>   softirqs last  enabled at (188966): [<ffff8000080106d0>] __do_softirq+0x4b0/0x6a0
>   softirqs last disabled at (188957): [<ffff80000804a618>] __irq_exit_rcu+0x108/0x1a4
>
> Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks for governor tunables")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 20 +++++++++++++-------
>  drivers/cpufreq/cpufreq_governor.h |  1 +
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 63f7c219062b..55c80319d268 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -388,6 +388,15 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
>         gov->free(policy_dbs);
>  }
>
> +static void cpufreq_dbs_data_release(struct kobject *kobj)
> +{
> +       struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
> +       struct dbs_governor *gov = dbs_data->gov;
> +
> +       gov->exit(dbs_data);
> +       kfree(dbs_data);
> +}
> +
>  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  {
>         struct dbs_governor *gov = dbs_governor_of(policy);
> @@ -425,6 +434,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>                 goto free_policy_dbs_info;
>         }
>
> +       dbs_data->gov = gov;
>         gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
>
>         ret = gov->init(dbs_data);
> @@ -447,6 +457,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>         policy->governor_data = policy_dbs;
>
>         gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
> +       gov->kobj_type.release = cpufreq_dbs_data_release;
>         ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
>                                    get_governor_parent_kobj(policy),
>                                    "%s", gov->gov.name);
> @@ -488,13 +499,8 @@ void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy)
>
>         policy->governor_data = NULL;
>
> -       if (!count) {
> -               if (!have_governor_per_policy())
> -                       gov->gdbs_data = NULL;
> -
> -               gov->exit(dbs_data);

Good catch, but it is unclear to me why gov->exit() cannot be called from here.

> -               kfree(dbs_data);
> -       }
> +       if (!count && !have_governor_per_policy())
> +               gov->gdbs_data = NULL;
>
>         free_policy_dbs_info(policy_dbs, gov);
>
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index bab8e6140377..a6de26318abb 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -37,6 +37,7 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
>  /* Governor demand based switching data (per-policy or global). */
>  struct dbs_data {
>         struct gov_attr_set attr_set;
> +       struct dbs_governor *gov;
>         void *tuners;
>         unsigned int ignore_nice_load;
>         unsigned int sampling_rate;
> --
> 2.31.1
>
