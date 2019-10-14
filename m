Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08362D6339
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 15:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfJNNBZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 09:01:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38155 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfJNNBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 09:01:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so16562646ljj.5;
        Mon, 14 Oct 2019 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QLWyLzhnVPrb1x7YKwNBPlM2SXgwhHVOnjlCQL1qRyg=;
        b=p76BhQLTJ1F0aQ9rIs14XLwi+8O7Nhh67xw017YENAW/+GxZ4fECXokH0Y7x+LYtUU
         xgjRcdr6wcPNWbLM0bKy07vebQ25PjdnXxahI1Om2etdD9jB28GaoB815gTp0tdqSHc7
         ohIg59qi0BmTWNd+MRg00v9XAkCFmPkYRkhOfF7P5lLKCJTZvndzm9gCwZ9Yqpzqorc1
         F/hJSn02eH2LkkTcToRg7Nin425hnLmb+4hCaFcIhCC57rcUZfn/LuCuXHRSrFOw4NNB
         W8kLtcs6Oh4gkM4akmVp4CcaEDF9LO2BP6aUF7DjsHRqCogX9YJuMETsNEfNWAl8jk7N
         XHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLWyLzhnVPrb1x7YKwNBPlM2SXgwhHVOnjlCQL1qRyg=;
        b=TXpGiW9c+j3sufv9hJ6/jh46u3UOloCBfv9t/EN/Um6McYkYR5ZEbO60aYmmxKAkbb
         cIZEitDaLkzgn8vq3RpwH+Z9npX6P5Onk7fSbpiuPZ0/S/LPvIjGNxs5RJmtmGOY82rk
         Vtg3FFvl2Z3XY8IsNOVfriVmdA8lE2X47xp6FVQKUM7NMcLVu5om+c+OCUXNIvHyr2iL
         iPcG6lc5hx1H3zIkpfYUzEAghnLmepqfAVrwYfposu58N3oikZD5uZ1dVyzVo5WQ5aoR
         Qy6RlA4M3s3S14aycrc1RsbMK+tHbz3CWipOfTpOgc+bg8T8gt0crlzgmqi4lOcuZWVz
         n3Dg==
X-Gm-Message-State: APjAAAUPwEEVIudRRX0xnbgFu4Gz0JdanjF1mw241nCOof+WMz0HraVl
        duTcry8Pb1QTJX96mbgjyWdS13yS
X-Google-Smtp-Source: APXvYqzPIxmhOAnWeITeISqaEvu5pccliF3amD+PDseFz9ZhuXzB2dVKNdtiPxp4dc9SiFBYRmm1pA==
X-Received: by 2002:a2e:501c:: with SMTP id e28mr18763949ljb.204.1571058080896;
        Mon, 14 Oct 2019 06:01:20 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id t3sm4385942lfd.92.2019.10.14.06.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 06:01:20 -0700 (PDT)
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS
 framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        ulf.hansson@linaro.org, sfr@canb.auug.org.au, pavel@ucw.cz,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
 <20191014094215.kb6q32chgb5sd2nb@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ff60c519-a177-a17e-352c-718028689fab@gmail.com>
Date:   Mon, 14 Oct 2019 16:01:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014094215.kb6q32chgb5sd2nb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.10.2019 12:42, Viresh Kumar пишет:
> On 22-09-19, 23:12, Dmitry Osipenko wrote:
>> This patch causes use-after-free on a cpufreq driver module reload. Please take a look, thanks in advance.
>>
>>
>> [   87.952369] ==================================================================
>> [   87.953259] BUG: KASAN: use-after-free in notifier_chain_register+0x4f/0x9c
>> [   87.954031] Read of size 4 at addr e6abbd0c by task modprobe/243
> 
> Hi Dmitry,
> 
> I tried to reproduce it on my ubuntu on ARM64 setup and I couldn't hit
> these issues on v5.4-rc1 with Kasan built in.
> 
> I then enabled Kasan (tried both inline and outline instrumentation)
> but I couldn't get past the issues with module insertion. It fails
> like this for me:
> 
> root@linaro-developer:~/work# insmod cpufreq-dt.ko 
> [   72.985974] cpufreq_dt: Unknown symbol __asan_report_load1_noabort (err -2)
> [   72.993164] cpufreq_dt: Unknown symbol __asan_report_load4_noabort (err -2)
> [   73.000307] cpufreq_dt: Unknown symbol __asan_report_load8_noabort (err -2)
> [   73.007451] cpufreq_dt: Unknown symbol __asan_report_store1_noabort (err -2)
> [   73.014643] cpufreq_dt: Unknown symbol __asan_register_globals (err -2)
> [   73.021409] cpufreq_dt: Unknown symbol __asan_unregister_globals (err -2)
> [   73.028349] cpufreq_dt: Unknown symbol __asan_report_store8_noabort (err -2)
> [   73.035543] cpufreq_dt: Unknown symbol __asan_report_store4_noabort (err -2)
> insmod: ERROR: could not insert module cpufreq-dt.ko: Unknown symbol in module
> 
> I tried to search for these errors but couldn't find why I am getting
> these and why the symbols are missing here. Can you suggest something
> here ?
> 

Sorry, I don't know what's wrong with ARM64. There is no KASAN on ARM32 in upstream yet, I'm using
the WIP patches [1].

[1] https://lkml.org/lkml/2019/6/17/1562

BTW, I moved tegra20-cpufreq to use cpufreq-dt recently and the problem presents with the cpufreq-dt:

# rmmod cpufreq_dt
# modprobe cpufreq_dt

[   31.259483] ==================================================================
[   31.260321] BUG: KASAN: use-after-free in notifier_chain_register+0x2b/0x7c
[   31.261026] Read of size 4 at addr cc30250c by task modprobe/218

[   31.262067] CPU: 1 PID: 218 Comm: modprobe Tainted: G        W
5.4.0-rc2-next-20191011-00194-g02f44e30b215-dirty #2645
[   31.263347] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   31.264154] [<c011116d>] (unwind_backtrace) from [<c010bb05>] (show_stack+0x11/0x14)
[   31.264960] [<c010bb05>] (show_stack) from [<c0d749ad>] (dump_stack+0x89/0x98)
[   31.265804] [<c0d749ad>] (dump_stack) from [<c02c72dd>]
(print_address_description.constprop.0+0x3d/0x340)
[   31.266830] [<c02c72dd>] (print_address_description.constprop.0) from [<c02c7767>]
(__kasan_report+0xe3/0x12c)
[   31.267865] [<c02c7767>] (__kasan_report) from [<c014eabb>] (notifier_chain_register+0x2b/0x7c)
[   31.268755] [<c014eabb>] (notifier_chain_register) from [<c014eb89>]
(blocking_notifier_chain_register+0x29/0x3c)
[   31.269842] [<c014eb89>] (blocking_notifier_chain_register) from [<c072cc11>]
(dev_pm_qos_add_notifier+0x79/0xf8)
[   31.270948] [<c072cc11>] (dev_pm_qos_add_notifier) from [<c095ec71>] (cpufreq_online+0x5e1/0x8a4)
[   31.271922] [<c095ec71>] (cpufreq_online) from [<c095efbd>] (cpufreq_add_dev+0x79/0x80)
[   31.272889] [<c095efbd>] (cpufreq_add_dev) from [<c0720213>] (subsys_interface_register+0xc3/0x100)
[   31.273894] [<c0720213>] (subsys_interface_register) from [<c095d83f>]
(cpufreq_register_driver+0x13b/0x1ec)
[   31.274912] [<c095d83f>] (cpufreq_register_driver) from [<bf800475>] (dt_cpufreq_probe+0x89/0xe0
[cpufreq_dt])
[   31.275924] [<bf800475>] (dt_cpufreq_probe [cpufreq_dt]) from [<c0723e31>]
(platform_drv_probe+0x49/0x88)
[   31.276889] [<c0723e31>] (platform_drv_probe) from [<c0721ad9>] (really_probe+0x109/0x378)
[   31.277715] [<c0721ad9>] (really_probe) from [<c0721e93>] (driver_probe_device+0x57/0x15c)
[   31.278537] [<c0721e93>] (driver_probe_device) from [<c0722145>] (device_driver_attach+0x61/0x64)
[   31.279425] [<c0722145>] (device_driver_attach) from [<c0722191>] (__driver_attach+0x49/0xa0)
[   31.280273] [<c0722191>] (__driver_attach) from [<c071fe6d>] (bus_for_each_dev+0x69/0x94)
[   31.281087] [<c071fe6d>] (bus_for_each_dev) from [<c0720f71>] (bus_add_driver+0x179/0x1e8)
[   31.281909] [<c0720f71>] (bus_add_driver) from [<c0722cf7>] (driver_register+0x8f/0x130)
[   31.282734] [<c0722cf7>] (driver_register) from [<bf805017>] (dt_cpufreq_platdrv_init+0x17/0x1000
[cpufreq_dt])
[   31.283761] [<bf805017>] (dt_cpufreq_platdrv_init [cpufreq_dt]) from [<c0102f69>]
(do_one_initcall+0x4d/0x280)
[   31.284759] [<c0102f69>] (do_one_initcall) from [<c01c70a9>] (do_init_module+0xb9/0x28c)
[   31.285561] [<c01c70a9>] (do_init_module) from [<c01c9ba9>] (load_module+0x2895/0x2c04)
[   31.286347] [<c01c9ba9>] (load_module) from [<c01ca0d7>] (sys_finit_module+0x7b/0x8c)
[   31.287117] [<c01ca0d7>] (sys_finit_module) from [<c0101001>] (ret_fast_syscall+0x1/0x26)
[   31.287901] Exception stack(0xcabb3fa8 to 0xcabb3ff0)
[   31.288406] 3fa0:                   0003f348 00000001 00000003 0002b744 00000000 b6b31e74
[   31.289200] 3fc0: 0003f348 00000001 94ccfd00 0000017b 0003f3f0 00000000 0003f348 00040010
[   31.290029] 3fe0: b6b31df8 b6b31de8 00022534 aec752f0

[   31.290698] Allocated by task 181:
[   31.291065]  __kasan_kmalloc.constprop.0+0x7b/0x84
[   31.291565]  cpufreq_online+0x55f/0x8a4
[   31.291959]  cpufreq_add_dev+0x79/0x80
[   31.292351]  subsys_interface_register+0xc3/0x100
[   31.292830]  cpufreq_register_driver+0x13b/0x1ec
[   31.293335]  dt_cpufreq_probe+0x89/0xe0 [cpufreq_dt]
[   31.293832]  platform_drv_probe+0x49/0x88
[   31.294245]  really_probe+0x109/0x378
[   31.294623]  driver_probe_device+0x57/0x15c
[   31.295048]  device_driver_attach+0x61/0x64
[   31.295472]  __driver_attach+0x49/0xa0
[   31.295854]  bus_for_each_dev+0x69/0x94
[   31.296244]  bus_add_driver+0x179/0x1e8
[   31.296636]  driver_register+0x8f/0x130
[   31.297047]  dt_cpufreq_platdrv_init+0x17/0x1000 [cpufreq_dt]
[   31.297616]  do_one_initcall+0x4d/0x280
[   31.298013]  do_init_module+0xb9/0x28c
[   31.298397]  load_module+0x2895/0x2c04
[   31.298780]  sys_finit_module+0x7b/0x8c
[   31.299167]  ret_fast_syscall+0x1/0x26
[   31.299548]  0xb6c2ac60

[   31.299967] Freed by task 214:
[   31.300288]  __kasan_slab_free+0xb7/0xe0
[   31.300686]  kfree+0x71/0x1f4
[   31.301001]  subsys_interface_unregister+0xad/0xf0
[   31.338959]  cpufreq_unregister_driver+0x2f/0x7c
[   31.377102]  dt_cpufreq_remove+0x15/0x18 [cpufreq_dt]
[   31.414885]  platform_drv_remove+0x27/0x34
[   31.452644]  device_release_driver_internal+0xdf/0x1a8
[   31.490404]  driver_detach+0x85/0xf8
[   31.527682]  bus_remove_driver+0x53/0xb0
[   31.564827]  dt_cpufreq_platdrv_exit+0x9/0xb28 [cpufreq_dt]
[   31.601736]  sys_delete_module+0x117/0x1a4
[   31.638575]  ret_fast_syscall+0x1/0x26
[   31.675041]  0xb6cafff4

[   31.746517] The buggy address belongs to the object at cc302400
                which belongs to the cache kmalloc-512 of size 512
[   31.817855] The buggy address is located 268 bytes inside of
                512-byte region [cc302400, cc302600)
[   31.888496] The buggy address belongs to the page:
[   31.923247] page:d291a000 refcount:1 mapcount:0 mapping:ce001a00 index:0x0 compound_mapcount: 0
[   31.958247] flags: 0x10200(slab|head)
[   31.992944] raw: 00010200 00000100 00000122 ce001a00 00000000 00100010 ffffffff 00000001
[   32.027763] page dumped because: kasan: bad access detected

[   32.095965] Memory state around the buggy address:
[   32.129904]  cc302400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   32.163593]  cc302480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   32.196538] >cc302500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   32.229052]               ^
[   32.260939]  cc302580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   32.292881]  cc302600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   32.324296] ==================================================================
[   32.355594] Disabling lock debugging due to kernel taint
[   32.462151] ------------[ cut here ]------------
[   32.492881] WARNING: CPU: 1 PID: 218 at lib/refcount.c:156 dev_pm_opp_of_add_table+0x59/0x128
[   32.523741] refcount_t: increment on 0; use-after-free.
[   32.554329] Modules linked in: cpufreq_dt(+) tegra30_devfreq [last unloaded: cpufreq_dt]
[   32.585233] CPU: 1 PID: 218 Comm: modprobe Tainted: G    B   W
5.4.0-rc2-next-20191011-00194-g02f44e30b215-dirty #2645
[   32.646692] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   32.677493] [<c011116d>] (unwind_backtrace) from [<c010bb05>] (show_stack+0x11/0x14)
[   32.708460] [<c010bb05>] (show_stack) from [<c0d749ad>] (dump_stack+0x89/0x98)
[   32.739392] [<c0d749ad>] (dump_stack) from [<c0127713>] (__warn+0x10f/0x110)
[   32.770049] [<c0127713>] (__warn) from [<c0127a09>] (warn_slowpath_fmt+0x61/0x78)
[   32.800656] [<c0127a09>] (warn_slowpath_fmt) from [<c095afc5>] (dev_pm_opp_of_add_table+0x59/0x128)
[   32.860732] [<c095afc5>] (dev_pm_opp_of_add_table) from [<c095b0c5>]
(dev_pm_opp_of_cpumask_add_table+0x31/0x88)
[   32.921247] [<c095b0c5>] (dev_pm_opp_of_cpumask_add_table) from [<bf800245>]
(cpufreq_init+0xd9/0x280 [cpufreq_dt])
[   32.982732] [<bf800245>] (cpufreq_init [cpufreq_dt]) from [<c095ea0f>] (cpufreq_online+0x37f/0x8a4)
[   33.045107] [<c095ea0f>] (cpufreq_online) from [<c095efbd>] (cpufreq_add_dev+0x79/0x80)
[   33.077037] [<c095efbd>] (cpufreq_add_dev) from [<c0720213>] (subsys_interface_register+0xc3/0x100)
[   33.140128] [<c0720213>] (subsys_interface_register) from [<c095d83f>]
(cpufreq_register_driver+0x13b/0x1ec)
[   33.204911] [<c095d83f>] (cpufreq_register_driver) from [<bf800475>] (dt_cpufreq_probe+0x89/0xe0
[cpufreq_dt])
[   33.271766] [<bf800475>] (dt_cpufreq_probe [cpufreq_dt]) from [<c0723e31>]
(platform_drv_probe+0x49/0x88)
[   33.340156] [<c0723e31>] (platform_drv_probe) from [<c0721ad9>] (really_probe+0x109/0x378)
[   33.375275] [<c0721ad9>] (really_probe) from [<c0721e93>] (driver_probe_device+0x57/0x15c)
[   33.410559] [<c0721e93>] (driver_probe_device) from [<c0722145>] (device_driver_attach+0x61/0x64)
[   33.446244] [<c0722145>] (device_driver_attach) from [<c0722191>] (__driver_attach+0x49/0xa0)
[   33.482238] [<c0722191>] (__driver_attach) from [<c071fe6d>] (bus_for_each_dev+0x69/0x94)
[   33.518513] [<c071fe6d>] (bus_for_each_dev) from [<c0720f71>] (bus_add_driver+0x179/0x1e8)
[   33.555099] [<c0720f71>] (bus_add_driver) from [<c0722cf7>] (driver_register+0x8f/0x130)
[   33.592015] [<c0722cf7>] (driver_register) from [<bf805017>] (dt_cpufreq_platdrv_init+0x17/0x1000
[cpufreq_dt])
[   33.666547] [<bf805017>] (dt_cpufreq_platdrv_init [cpufreq_dt]) from [<c0102f69>]
(do_one_initcall+0x4d/0x280)
[   33.742553] [<c0102f69>] (do_one_initcall) from [<c01c70a9>] (do_init_module+0xb9/0x28c)
[   33.781507] [<c01c70a9>] (do_init_module) from [<c01c9ba9>] (load_module+0x2895/0x2c04)
[   33.820735] [<c01c9ba9>] (load_module) from [<c01ca0d7>] (sys_finit_module+0x7b/0x8c)
[   33.860308] [<c01ca0d7>] (sys_finit_module) from [<c0101001>] (ret_fast_syscall+0x1/0x26)
[   33.900121] Exception stack(0xcabb3fa8 to 0xcabb3ff0)
[   33.940062] 3fa0:                   0003f348 00000001 00000003 0002b744 00000000 b6b31e74
[   33.980876] 3fc0: 0003f348 00000001 94ccfd00 0000017b 0003f3f0 00000000 0003f348 00040010
[   34.021838] 3fe0: b6b31df8 b6b31de8 00022534 aec752f0
[   34.062931] ---[ end trace f68728a0d3053b54 ]---
