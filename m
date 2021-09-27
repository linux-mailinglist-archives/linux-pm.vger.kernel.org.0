Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86A41925B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 12:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhI0Kn2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhI0Kn2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 06:43:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CDC061575
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 03:41:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so76314wmb.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BD475v3p+g9oOuPMKJRj1m/d6tqu9uwT7VpH5H5OMKI=;
        b=G/g6W28xR0H4xcy7Zd4LUXWoJ5AwTqQfirqzGwUuJCFrkOmC5yk5SoJgOZ1+T2xy53
         D68UUtgSJO01KIwL8qPeAi7OH6la5xHefsKzogsAHfb1oXWStKwMsRhSTfVbrDcpvh33
         1amY+Ygbmh2zZpGVLBG6dtutNZM4hopkp+oGKXqk7GBTmMDQFzYlEYpY8lI3xbcQUUTD
         ZJ4E8SB82a9OXZy5Ir0SFd+L5/N7aKPW2AhD+QouItvarXP4qHxvf6uIoMeYDJAg3Rto
         slvDoQpIq5XFwJqCWt0O6CFL5LU/kOowgQOBOu1QGmsAyH4m8U5uJNU89R5TthFubjmk
         Epyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BD475v3p+g9oOuPMKJRj1m/d6tqu9uwT7VpH5H5OMKI=;
        b=BV5ghAvnTSlOfuSF+QAJvJulFtb26zL4V0CA9hFwQER8Xp2gDfcuj922LW3wxeo3Dc
         ReqEJ4Qsdhyfj51h/REnMzZX2c7Yj9BUJj4IgeL4K+vHtGcJQnEee7/I2IcbfhrBiOe4
         mjMFLX7QKHPnUOlUFlQRf54gfTLvj8AC3Itm6T1f6G/oDFiOumbtou2Yqy+m25EIRXgI
         c3Fs6sg350ukgwyI2+8/QyhL5cc5ZtUWosy+AvfKLotryHGuLozTBDEVkuBhS69SzYt9
         vCn4SbkELxc7lpncLQ4ucb7bwezD5OLgQjPe7gu8tlyFbiT3kZJFzbsyAkH3xkordq0r
         VdlQ==
X-Gm-Message-State: AOAM532MPT9R2qRrEmQFbSSkTBROGhAribcOei5rBcIIRo6nloVX1Gjl
        /d8CrbGkxzTdyssUVp02/KiWfiuvXRr1WQ==
X-Google-Smtp-Source: ABdhPJxkLTtH66QKqEq5OCvMdH/0Ijs41+KtkPuacXarIi7a2DxBUlTg7cfJaZy0Zu7AN0oRLqv4cQ==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr14965564wmm.172.1632739308801;
        Mon, 27 Sep 2021 03:41:48 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b8ba:f606:a9ed:a3b? ([2a01:e34:ed2f:f020:b8ba:f606:a9ed:a3b])
        by smtp.googlemail.com with ESMTPSA id o7sm20443072wro.45.2021.09.27.03.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:41:48 -0700 (PDT)
Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
 update for configuration operation
To:     Vadim Pasternak <vadimp@nvidia.com>, rui.zhang@intel.com
Cc:     =idosch@nvidia.com, linux-pm@vger.kernel.org
References: <20210927082421.2358851-1-vadimp@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9aca37cb-1629-5c67-1895-1fdc45c0244e@linaro.org>
Date:   Mon, 27 Sep 2021 12:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927082421.2358851-1-vadimp@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Vadim,


On 27/09/2021 10:24, Vadim Pasternak wrote:
> The thermal subsystem maintains a transition table between states that
> is allocated according to the maximum state supported by the cooling
> device.
> 
> When the table needs to be updated, the thermal subsystem does not
> validate that the new state does not exceed the maximum state,
> leading to out-of-bounds memory accesses [1].

Actually, thermal_cooling_device_stats_update() is called if the
set_cur_state is successful.

With a state greater than the max state, the set_cur_state should fail
and thermal_cooling_device_stats_update() is not called.

Perhaps the problem is in mlxsw_thermal_set_cur_state() ?

> Fix this by validating the new state before updating the table.
> 
> Some thermal drivers allow user space to configure such states to limit
> the minimum fan speed. See, for example:
> commit a421ce088ac8 ("mlxsw: core: Extend cooling device with cooling levels")
> 
> In any case, the thermal subsystem needs to validate the state before
> using it as an index into the transition table.
> 
> [1]
> [  156.703153] ==================================================================
> [  156.710613] BUG: KASAN: slab-out-of-bounds in thermal_cooling_device_stats_update+0x7d/0xb0
> [  156.719227] Read of size 4 at addr ffff88811f63e840 by task hw-management.s/2300
> [  156.726816]
> [  156.728369] CPU: 1 PID: 2300 Comm: hw-management.s Not tainted 5.15.0-rc2-dvs-00320-ga3b397b4fffb #1
> [  156.737766] Hardware name: Mellanox Technologies Ltd. MSN2410/VMOD0001, BIOS 4.6.5 09/13/2018
> [  156.746561] Call Trace:
> [  156.749093]  dump_stack_lvl+0x44/0x57
> [  156.752890]  print_address_description.constprop.9+0x21/0x150
> [  156.758824]  ? thermal_cooling_device_stats_update+0x7d/0xb0
> [  156.764675]  ? thermal_cooling_device_stats_update+0x7d/0xb0
> [  156.770521]  kasan_report.cold.14+0x83/0xdf
> [  156.774835]  ? thermal_cooling_device_stats_update+0x7d/0xb0
> [  156.780654]  thermal_cooling_device_stats_update+0x7d/0xb0
> [  156.786314]  __thermal_cdev_update+0xc0/0x200
> [  156.790818]  thermal_cdev_update+0x4e/0x70
> [  156.795064]  step_wise_throttle+0x426/0x6f0
> [  156.799408]  ? devm_thermal_add_hwmon_sysfs+0x80/0x80
> [  156.804628]  ? thermal_zone_get_temp+0xa0/0xa0
> [  156.809185]  ? netlink_broadcast+0xa/0x10
> [  156.813353]  ? thermal_genl_sampling_temp+0x16a/0x200
> [  156.818563]  ? thermal_genl_cmd_doit+0x290/0x290
> [  156.823332]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [  156.827900]  thermal_zone_device_update+0x39e/0x850
> [  156.832954]  ? trace_event_raw_event_thermal_zone_trip+0x1f0/0x1f0
> [  156.839349]  ? wait_for_completion+0x190/0x190
> [  156.843944]  ? devm_thermal_of_cooling_device_register+0xa0/0xa0
> [  156.850148]  ? snprintf+0x91/0xc0
> [  156.853594]  ? vsprintf+0x10/0x10
> [  156.857039]  thermal_zone_device_set_mode+0x81/0xf0
> [  156.862079]  mlxsw_thermal_modules_init+0x48f/0x590 [mlxsw_core]
> [  156.868392]  ? mlxsw_thermal_set_cur_state+0x590/0x590 [mlxsw_core]
> [  156.874954]  ? netlink_broadcast+0xa/0x10
> [  156.879090]  ? thermal_genl_send_event+0x117/0x1a0
> [  156.884039]  ? thermal_notify_tz_create+0x7d/0xb0
> [  156.888903]  ? thermal_genl_sampling_temp+0x200/0x200
> [  156.894147]  ? do_init_timer+0x6c/0x80
> [  156.898009]  ? thermal_zone_device_register+0x8af/0x9a0
> [  156.903438]  ? __thermal_cooling_device_register+0x4f2/0x500
> [  156.909272]  mlxsw_thermal_init+0x763/0x880 [mlxsw_core]
> [  156.914882]  ? mlxsw_thermal_gearboxes_init.isra.8+0x460/0x460 [mlxsw_core]
> [  156.922214]  __mlxsw_core_bus_device_register+0xa0c/0xca0 [mlxsw_core]
> [  156.929093]  ? dev_printk_emit+0x90/0xb6
> [  156.933136]  ? dev_vprintk_emit+0x208/0x208
> [  156.937462]  ? mlxsw_devlink_info_get+0x490/0x490 [mlxsw_core]
> [  156.943580]  ? do_raw_spin_lock+0x1d0/0x1d0
> [  156.947906]  ? lockdep_hardirqs_on_prepare+0xe/0x230
> [  156.953041]  ? __dev_printk+0x9e/0xd6
> [  156.956818]  ? _dev_info+0xc8/0xf6
> [  156.960339]  ? _dev_notice+0x84/0xf6
> [  156.964047]  ? mark_wakeup_next_waiter+0x1b0/0x1b0
> [  156.968988]  mlxsw_core_bus_device_register+0x3e/0x60 [mlxsw_core]
> [  156.975492]  mlxsw_i2c_probe.cold.8+0x159/0x283 [mlxsw_i2c]
> [  156.981259]  ? mlxsw_i2c_wait_go_bit.isra.3+0x1c0/0x1c0 [mlxsw_i2c]
> [  156.987701]  ? lock_release+0x50/0x6c0
> [  156.991555]  ? devres_open_group+0x13d/0x180
> [  156.995936]  ? lock_downgrade+0x3a0/0x3a0
> [  157.000108]  ? lock_contended+0x710/0x710
> [  157.004229]  ? devres_open_group+0x59/0x180
> [  157.008539]  ? devres_log+0x11a/0x180
> [  157.012309]  ? trace_hardirqs_on+0x1c/0x110
> [  157.016630]  ? preempt_count_sub+0xf/0xb0
> [  157.020781]  ? mlxsw_i2c_wait_go_bit.isra.3+0x1c0/0x1c0 [mlxsw_i2c]
> [  157.027255]  ? i2c_device_probe+0x30e/0x370
> [  157.031573]  i2c_device_probe+0x30e/0x370
> [  157.035746]  really_probe+0x149/0x3c0
> [  157.039535]  ? driver_allows_async_probing+0x80/0x80
> [  157.044629]  __driver_probe_device+0xc3/0x130
> [  157.049127]  driver_probe_device+0x45/0x100
> [  157.053486]  __device_attach_driver+0xd6/0x100
> [  157.058069]  bus_for_each_drv+0xe7/0x150
> [  157.062122]  ? bus_rescan_devices+0x10/0x10
> [  157.066444]  ? lockdep_hardirqs_on_prepare+0xe/0x230
> [  157.071587]  ? trace_hardirqs_on+0x1c/0x110
> [  157.075891]  ? preempt_count_sub+0xf/0xb0
> [  157.080050]  ? _raw_spin_unlock_irqrestore+0x36/0x50
> [  157.085193]  __device_attach+0x185/0x210
> [  157.089231]  ? device_bind_driver+0x70/0x70
> [  157.093569]  ? kobject_uevent_env+0x287/0x940
> [  157.098091]  bus_probe_device+0xf9/0x120
> [  157.102159]  device_add+0x623/0xeb0
> [  157.105746]  ? static_obj+0x32/0x80
> [  157.109348]  ? lockdep_init_map_type+0xd9/0x360
> [  157.114062]  ? __fw_devlink_link_to_suppliers+0x270/0x270
> [  157.119619]  ? __raw_spin_lock_init+0x71/0x80
> [  157.124134]  i2c_new_client_device+0x277/0x3a0
> [  157.128715]  new_device_store+0x13c/0x270
> [  157.132847]  ? copyin+0x6b/0x80
> [  157.136090]  ? i2c_new_ancillary_device+0x20/0x20
> [  157.140946]  ? lock_acquire+0xc0/0x3f0
> [  157.144830]  ? lock_release+0x6c0/0x6c0
> [  157.148833]  ? sysfs_file_ops+0x6b/0x90
> [  157.152808]  ? sysfs_file_ops+0x90/0x90
> [  157.156774]  kernfs_fop_write_iter+0x1af/0x250
> [  157.161346]  new_sync_write+0x25a/0x380
> [  157.165327]  ? new_sync_read+0x370/0x370
> [  157.169384]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [  157.173973]  ? rcu_read_lock_held_common+0x12/0x50
> [  157.178911]  ? irq_migrate_all_off_this_cpu+0xf0/0x300
> [  157.184208]  ? lock_release+0x6c0/0x6c0
> [  157.188149]  ? rcu_read_lock_sched_held+0x5a/0xd0
> [  157.192995]  ? rcu_read_lock_held+0xb0/0xb0
> [  157.197310]  vfs_write+0x33d/0x530
> [  157.200839]  ksys_write+0xbb/0x150
> [  157.204359]  ? __ia32_sys_read+0x40/0x40
> [  157.208410]  ? set_load_weight+0xd1/0x110
> [  157.212557]  do_syscall_64+0x3a/0x80
> [  157.216256]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  157.221457] RIP: 0033:0x7fa80bd47970
> [  157.225131] Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
> [  157.244407] RSP: 002b:00007fff14b2c648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  157.252196] RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007fa80bd47970
> [  157.259528] RDX: 0000000000000013 RSI: 0000000000ede408 RDI: 0000000000000001
> [  157.266868] RBP: 0000000000ede408 R08: 00007fa80c007760 R09: 00007fa80c653700
> [  157.274219] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000013
> [  157.281564] R13: 0000000000000001 R14: 00007fa80c006600 R15: 0000000000000013
> [  157.288933]
> [  157.290484] Allocated by task 2300:
> [  157.294054]  kasan_save_stack+0x19/0x40
> [  157.298024]  __kasan_kmalloc+0x7f/0xa0
> [  157.301914]  __kmalloc+0x18f/0x2c0
> [  157.305417]  thermal_cooling_device_setup_sysfs+0xf9/0x1a0
> [  157.311075]  __thermal_cooling_device_register+0x1b5/0x500
> [  157.316734]  mlxsw_thermal_init+0x7e4/0x880 [mlxsw_core]
> [  157.322325]  __mlxsw_core_bus_device_register+0xa0c/0xca0 [mlxsw_core]
> [  157.329154]  mlxsw_core_bus_device_register+0x3e/0x60 [mlxsw_core]
> [  157.335656]  mlxsw_i2c_probe.cold.8+0x159/0x283 [mlxsw_i2c]
> [  157.341373]  i2c_device_probe+0x30e/0x370
> [  157.345524]  really_probe+0x149/0x3c0
> [  157.349330]  __driver_probe_device+0xc3/0x130
> [  157.353815]  driver_probe_device+0x45/0x100
> [  157.358117]  __device_attach_driver+0xd6/0x100
> [  157.362712]  bus_for_each_drv+0xe7/0x150
> [  157.366768]  __device_attach+0x185/0x210
> [  157.370823]  bus_probe_device+0xf9/0x120
> [  157.374897]  device_add+0x623/0xeb0
> [  157.378512]  i2c_new_client_device+0x277/0x3a0
> [  157.383094]  new_device_store+0x13c/0x270
> [  157.387222]  kernfs_fop_write_iter+0x1af/0x250
> [  157.391797]  new_sync_write+0x25a/0x380
> [  157.395765]  vfs_write+0x33d/0x530
> [  157.399267]  ksys_write+0xbb/0x150
> [  157.402795]  do_syscall_64+0x3a/0x80
> [  157.406496]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  157.411686]
> [  157.413236] The buggy address belongs to the object at ffff88811f63e400
> [  157.413236]  which belongs to the cache kmalloc-1k of size 1024
> [  157.426135] The buggy address is located 64 bytes to the right of
> [  157.426135]  1024-byte region [ffff88811f63e400, ffff88811f63e800)
> [  157.438710] The buggy address belongs to the page:
> [  157.443640] page:ffffea00047d8e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811f63c000 pfn:0x11f638
> [  157.454579] head:ffffea00047d8e00 order:3 compound_mapcount:0 compound_pincount:0
> [  157.462281] flags: 0x200000000010200(slab|head|node=0|zone=2)
> [  157.468220] raw: 0200000000010200 ffffea000863a808 ffffea00045ab208 ffff888100043bc0
> [  157.476205] raw: ffff88811f63c000 00000000000a0002 00000001ffffffff 0000000000000000
> [  157.484185] page dumped because: kasan: bad access detected
> [  157.489895]
> [  157.491445] Memory state around the buggy address:
> [  157.496373]  ffff88811f63e700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  157.503809]  ffff88811f63e780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  157.511235] >ffff88811f63e800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  157.518641]                                            ^
> [  157.524113]  ffff88811f63e880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  157.531571]  ffff88811f63e900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  157.538980] ==================================================================
> 
> Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
> Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 1c4aac8464a7..80b38b180140 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -673,10 +673,14 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>  					 unsigned long new_state)
>  {
>  	struct cooling_dev_stats *stats = cdev->stats;
> +	unsigned long max_state;
>  
>  	if (!stats)
>  		return;
>  
> +	if (cdev->ops->get_max_state(cdev, &max_state) || new_state > max_state)
> +		return;
> +
>  	spin_lock(&stats->lock);
>  
>  	if (stats->state == new_state)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
