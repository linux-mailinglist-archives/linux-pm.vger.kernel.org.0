Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7361050AA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKUKiD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 05:38:03 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41718 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKUKiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 05:38:03 -0500
Received: by mail-oi1-f174.google.com with SMTP id e9so2713976oif.8
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 02:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bG26cZDOEEaFe23+hxA9oCJGNtN+BatYeRMTsPlOEM=;
        b=qg6ss2Y32tAwduHiD5/EsXh9b1UGAxmR0Gw7S7daLorZGkkDNLCSOWi9VE58aURB0+
         nG0pv9IlQ6k5+KF6KENzZ/Ts258EQHozOvTLqJBs2GgHBz8F8Mv60AoHjkjTmDj1T0Fe
         NXqVZj970aEz1bh99fA+HgETqn6aUFwHzUFTHPgQJyiTq2ZfLFe04kmHgcYjhD28G8m6
         ad117XlrN9kFfyur1BMuMQao66uQMw9AGKEtF9b2UnIkdE0cZUmD6x83Cw3aXdkYhdxj
         0kaIaFYIGZMNaSVABLlJlXAezjyH4Oq808S9J5OT2Flyp2WpgsaEmuytmWnie20+CR37
         Ku0Q==
X-Gm-Message-State: APjAAAUnvDm+m/sZDJ1JZSOoykRBbvWKJYlU0OjD6vmdPK7gosdcZX1C
        2o+x/bS7KXWU3uGpW3jBxFn6Ca6WNATGasYowUo=
X-Google-Smtp-Source: APXvYqzJTq/S7Rz5pfUC7neZ2/ySBOO/ASN7vWrw+bRY3BfiXZp0VaUrzRtAXW8oGrybsaXrFJ4VP2i687z/gzXB5Sk=
X-Received: by 2002:aca:1101:: with SMTP id 1mr7133540oir.103.1574332681634;
 Thu, 21 Nov 2019 02:38:01 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
In-Reply-To: <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 11:37:50 +0100
Message-ID: <CAJZ5v0iqcU6A_tMNmxpcr3roEyw268fvM+tTUUg7fn9vALQwtg@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 21, 2019 at 10:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +Rafael and PM list.
>
> Please provide output of following for your platform while I am having a look at
> your problem.
>
> grep . /sys/devices/system/cpu/cpufreq/*/*
>
> On 21-11-19, 09:17, Anson Huang wrote:
> > Hi, Viresh
> > Sorry to bother you directly via mail.
> > We met something wrong with cpufreq governor driver during CPU hot-plug stress
> > test on v5.4-rc7, below is the log, from debug, looks like the irq_work is
> > still pending on a CPU which is already offline,

I'm really not sure if this conclusion can be drawn from the log below.

> > so next CPU being on/off line
> > will call the cpufreq_stop_governor and it will wait for previous irq_work
> > free for use, but since it is pending on an offline CPU, so it will never
> > success. Do you have any idea of it or have any info about it? Thanks a lot in
> > advanced!

So this is just blocked __cpuhp_kick_ap() waiting forever AFAICS.

> >
> > [ 1062.437497] smp_test.sh     D    0   584    477 0x00000200
> > [ 1062.442986] Call trace:
> > [ 1062.445445]  __switch_to+0xb4/0x200
> > [ 1062.448937]  __schedule+0x304/0x5b0
> > [ 1062.452423]  schedule+0x40/0xd0
> > [ 1062.455565]  schedule_timeout+0x16c/0x268
> > [ 1062.459574]  wait_for_completion+0xa0/0x120
> > [ 1062.463758]  __cpuhp_kick_ap+0x54/0x68
> > [ 1062.467506]  cpuhp_kick_ap+0x38/0xa8
> > [ 1062.471079]  bringup_cpu+0xbc/0xe8
> > [ 1062.474480]  cpuhp_invoke_callback+0x88/0x1f8
> > [ 1062.478835]  _cpu_up+0xe8/0x1e0
> > [ 1062.481975]  do_cpu_up+0x98/0xb8
> > [ 1062.485202]  cpu_up+0x10/0x18
> > [ 1062.488172]  cpu_subsys_online+0x48/0xa0
> > [ 1062.492094]  device_online+0x68/0xb0
> > [ 1062.495667]  online_store+0xa8/0xb8
> > [ 1062.499157]  dev_attr_store+0x14/0x28
> > [ 1062.502820]  sysfs_kf_write+0x48/0x58
> > [ 1062.506480]  kernfs_fop_write+0xe0/0x1f8
> > [ 1062.510404]  __vfs_write+0x18/0x40
> > [ 1062.513806]  vfs_write+0x19c/0x1f0
> > [ 1062.517206]  ksys_write+0x64/0xf0
> > [ 1062.520520]  __arm64_sys_write+0x14/0x20
> > [ 1062.524446]  el0_svc_common.constprop.2+0xb0/0x168
> > [ 1062.529236]  el0_svc_handler+0x20/0x80
> > [ 1062.532984]  el0_svc+0x8/0xc
> > [ 1062.535868] kworker/0:2     D    0  5496      2 0x00000228
> > [ 1062.541361] Workqueue: events vmstat_shepherd
> > [ 1062.545717] Call trace:
> > [ 1062.548163]  __switch_to+0xb4/0x200
> > [ 1062.551650]  __schedule+0x304/0x5b0
> > [ 1062.555137]  schedule+0x40/0xd0
> > [ 1062.558278]  rwsem_down_read_slowpath+0x200/0x4c0
> > [ 1062.562984]  __down_read+0x9c/0xc0
> > [ 1062.566385]  __percpu_down_read+0x6c/0xd8
> > [ 1062.570393]  cpus_read_lock+0x70/0x78
> > [ 1062.574054]  vmstat_shepherd+0x30/0xd0
> > [ 1062.577804]  process_one_work+0x1dc/0x370
> > [ 1062.581812]  worker_thread+0x48/0x468
> > [ 1062.585475]  kthread+0xf0/0x120
> > [ 1062.588615]  ret_from_fork+0x10/0x1c
> >
> >   [ 1311.095934] sysrq: Show backtrace of all active CPUs
> > [ 1311.100913] sysrq: CPU0:
> > [ 1311.103450] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc7-03224-g9b510305bd68-dirty #28
> > [ 1311.111972] Hardware name: NXP i.MX8MNano DDR4 EVK board (DT)
> > [ 1311.117717] pstate: 40000005 (nZcv daif -PAN -UAO)
> > [ 1311.122519] pc : arch_cpu_idle+0x10/0x18
> > [ 1311.126445] lr : default_idle_call+0x18/0x30
> > [ 1311.130712] sp : ffff800011f73ec0
> > [ 1311.134024] x29: ffff800011f73ec0 x28: 0000000041dd0018
> > [ 1311.139335] x27: 0000000000000400 x26: 0000000000000000
> > [ 1311.144646] x25: 0000000000000000 x24: ffff800011f7a220
> > [ 1311.149956] x23: ffff800011f79000 x22: ffff800011b42bf8
> > [ 1311.155267] x21: ffff800011f7a000 x20: 0000000000000001
> > [ 1311.160578] x19: ffff800011f7a120 x18: 0000000000000000
> > [ 1311.165888] x17: 0000000000000000 x16: 0000000000000000
> > [ 1311.171198] x15: 0000000000000000 x14: 0000000000000000
> > [ 1311.176508] x13: 0000000000000001 x12: 0000000000000000
> > [ 1311.181819] x11: 0000000000000000 x10: 0000000000000990
> > [ 1311.187129] x9 : ffff800011f73e10 x8 : ffff800011f83ef0
> > [ 1311.192440] x7 : ffff000069b8f6c0 x6 : ffff000069b8ad70
> > [ 1311.197750] x5 : 0000013165fb6700 x4 : 4000000000000000
> > [ 1311.203061] x3 : ffff800011f73eb0 x2 : 0000000000000000
> > [ 1311.208371] x1 : 0000000000095e94 x0 : 00000000000000e0
> > [ 1311.213682] Call trace:
> > [ 1311.216131]  arch_cpu_idle+0x10/0x18
> > [ 1311.219708]  do_idle+0x1c4/0x290
> > [ 1311.222935]  cpu_startup_entry+0x24/0x40
> > [ 1311.226856]  rest_init+0xd4/0xe0
> > [ 1311.230087]  arch_call_rest_init+0xc/0x14
> > [ 1311.234094]  start_kernel+0x430/0x45c
> > [ 1311.243556] sysrq: CPU1:
> > [ 1311.246099] Call trace:
> > [ 1311.248557]  dump_backtrace+0x0/0x158
> > [ 1311.252220]  show_stack+0x14/0x20
> > [ 1311.255537]  showacpu+0x70/0x80
> > [ 1311.258682]  flush_smp_call_function_queue+0x74/0x150
> > [ 1311.263733]  generic_smp_call_function_single_interrupt+0x10/0x18
> > [ 1311.269831]  handle_IPI+0x138/0x168
> > [ 1311.273319]  gic_handle_irq+0x144/0x148
> > [ 1311.277153]  el1_irq+0xb8/0x180
> > [ 1311.280298]  irq_work_sync+0x10/0x18
> > [ 1311.283875]  cpufreq_stop_governor.part.20+0x1c/0x30
> > [ 1311.288839]  cpufreq_online+0x5a0/0x860

And here you have cpufreq_online() calling cpufreq_stop_governor().

The only way that can happen is through cpufreq_add_policy_cpu()
AFAICS, because otherwise policy->governor would be NULL.

So cpufreq_stop_governor() is called from cpufreq_add_policy_cpu() and
it invokes the irq_work_sync() through the governor ->stop callback.
Now, the target irq_work can only be pending on an *online* CPU
sharing the policy with the one in question, so here the CPU going
online is waiting on the other CPU to run the irq_work, but for some
reason it cannot do that.

Note that this is after clearing the update_util pointer for all CPUs
sharing the policy and running synchronize_rcu(), so the irq_work must
have been queued earlier.

> > [ 1311.292673]  cpuhp_cpufreq_online+0xc/0x18
> > [ 1311.296771]  cpuhp_invoke_callback+0x88/0x1f8
> > [ 1311.301127]  cpuhp_thread_fun+0xd8/0x160
> > [ 1311.305051]  smpboot_thread_fn+0x200/0x2a8
> > [ 1311.309151]  kthread+0xf0/0x120
> > [ 1311.312291]  ret_from_fork+0x10/0x1c
