Return-Path: <linux-pm+bounces-29488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC550AE7DF3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40C13BA2A9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA332BEFE4;
	Wed, 25 Jun 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8TgYHHG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AA29AAF7
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844668; cv=none; b=agQ50YmHFLY7MI2TOmeHN4xPDEPDijN8FQLNhxLJTXcHGlLaI4TgrmrsqLyVkR1GKGqV7yTRwdDVVhVVd0jEK25B5OSvW9cHwptHvxyEDOb/7sTQiTKRvrv4EcZvXXrmP4WPfaHPIVRaleYXd9Kd1OsI6qbxOSWSkRsFty5iBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844668; c=relaxed/simple;
	bh=4xqPX0HvYW8mDC2vQs1MJP35KAP81yDSWPxe4Vmp0q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feHeGEJrvN+5UmJ0PdX64x/FlC3tOq9XEZKrg5LDMA1+1jPJKYNEmZO2ToF9h6Utw37qkdo9tYIJc96b0DGQkYm+2n92KGrRCHTOdxfflgydqU9kTp6vX4ATS0jKgiQNoK342PU4IRkG/j32orRkDDY+gnNeAbTbmxvQz0NSE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8TgYHHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06569C4CEEA;
	Wed, 25 Jun 2025 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750844668;
	bh=4xqPX0HvYW8mDC2vQs1MJP35KAP81yDSWPxe4Vmp0q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I8TgYHHGkzGx2P+BAnDounnj899VrF47gee2nGqrGPgzfFnaEGULGSvGCb6OrVW9p
	 uT6e2kEoIvN8ypIyiuUssf10/9Cue/Dz3bta6t1quDPDYlCMPGHRrFiBSLsCrDMkx1
	 3s+Tl0IXu0l9HC3WOkZ5FpAj13ajZJMzPyvrGuyeiOCJIefMET0gEm4n9XXJ4eDwrt
	 UEmHVuit5q3VxDoEChYT0I89u3bo0z9W04rm3xPYNFqJxBHXS4ZCUSrV/mKoO8JT+e
	 qZKBRt71gLAYv0ilwhhPIWVyQq4ruuktLNS2K/fOiSCxLDTri03vENLWofCX550uol
	 8fB4IhUtLZp3Q==
Message-ID: <4225e2d2-4fd8-49ee-b0e2-97cd5737423b@kernel.org>
Date: Wed, 25 Jun 2025 11:44:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: use a custom lock class for intel
 x86_pkg_temp
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Benjamin Berg <benjamin.berg@intel.com>
References: <20250624132406.1485407-1-benjamin@sipsolutions.net>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250624132406.1485407-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Benjamin,

On 24-Jun-25 3:24 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The intel driver has code paths that will take the tz->lock while the
> cpuhp_state-up lock is held. As the cpuhp_state-up lock is used in other
> code paths, it may happen that lockdep detects possible deadlocks
> through unrelated thermal zone devices.
> 
> Fix these false positives by using a separate lockdep class for the
> x86_pkg_temp thermal device.
> 
> Reported-by: Hans de Goede <hansg@kernel.org>
> Closes: https://lore.kernel.org/linux-pm/e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org/
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Thank you for trying to fix this, the fix does get rid of cpuhp_state-up
in the lockdep report, only for it to be replaced with the thermal_list_lock
unfortunately (full lockdep report below).

It seems that the real issue is trying to lock wiphy.mtx while holding
tz->lock.

Or maybe we need this patch + a patch to not hold wiphy.mtx while
registering the thermalzone ?

Regards,

Hans






[   19.759432] ======================================================
[   19.759434] WARNING: possible circular locking dependency detected
[   19.759436] 6.16.0-rc3+ #11 Not tainted
[   19.759439] ------------------------------------------------------
[   19.759440] modprobe/881 is trying to acquire lock:
[   19.759442] ffff897b4c940768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.759485] 
               but task is already holding lock:
[   19.759486] ffff897b0204e708 (&tz->lock){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x20/0xa0
[   19.759498] 
               which lock already depends on the new lock.

[   19.759500] 
               the existing dependency chain (in reverse order) is:
[   19.759501] 
               -> #5 (&tz->lock){+.+.}-{4:4}:
[   19.759506]        __mutex_lock+0x9f/0xed0
[   19.759513]        thermal_zone_device_register_with_trips+0x573/0x640
[   19.759517]        thermal_tripless_zone_device_register+0x1b/0x30
[   19.759521]        int3400_thermal_probe+0x21d/0x4f0 [int3400_thermal]
[   19.759526]        platform_probe+0x3f/0xa0
[   19.759531]        really_probe+0xdb/0x340
[   19.759535]        __driver_probe_device+0x78/0x140
[   19.759539]        driver_probe_device+0x1f/0xa0
[   19.759542]        __driver_attach+0xcb/0x1e0
[   19.759546]        bus_for_each_dev+0x63/0xa0
[   19.759549]        bus_add_driver+0x10a/0x1f0
[   19.759552]        driver_register+0x71/0xe0
[   19.759556]        do_one_initcall+0x54/0x390
[   19.759561]        do_init_module+0x62/0x240
[   19.759565]        __do_sys_init_module+0x164/0x190
[   19.759568]        do_syscall_64+0x94/0x3d0
[   19.759571]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.759574] 
               -> #4 (thermal_list_lock){+.+.}-{4:4}:
[   19.759578]        __mutex_lock+0x9f/0xed0
[   19.759581]        __thermal_cooling_device_register.part.0+0x16e/0x2a0
[   19.759585]        acpi_processor_thermal_init+0x24/0xb0
[   19.759591]        acpi_soft_cpu_online+0xa7/0x140
[   19.759593]        cpuhp_invoke_callback+0x1ab/0x660
[   19.759599]        cpuhp_thread_fun+0x187/0x270
[   19.759602]        smpboot_thread_fn+0x12a/0x2e0
[   19.759607]        kthread+0x108/0x240
[   19.759612]        ret_from_fork+0x232/0x2a0
[   19.759617]        ret_from_fork_asm+0x1a/0x30
[   19.759621] 
               -> #3 (cpuhp_state-up){+.+.}-{0:0}:
[   19.759625]        cpuhp_thread_fun+0x99/0x270
[   19.759628]        smpboot_thread_fn+0x12a/0x2e0
[   19.759631]        kthread+0x108/0x240
[   19.759635]        ret_from_fork+0x232/0x2a0
[   19.759638]        ret_from_fork_asm+0x1a/0x30
[   19.759642] 
               -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[   19.759645]        cpus_read_lock+0x3c/0xe0
[   19.759649]        static_key_slow_inc+0x12/0x30
[   19.759656]        __nf_register_net_hook+0xb7/0x210
[   19.759662]        nf_register_net_hook+0x2d/0x90
[   19.759665]        nf_tables_addchain.constprop.0+0x2dd/0x6f0 [nf_tables]
[   19.759686]        nf_tables_newchain+0x78f/0xb10 [nf_tables]
[   19.759701]        nfnetlink_rcv_batch+0x7a5/0xc50 [nfnetlink]
[   19.759705]        nfnetlink_rcv+0x12d/0x150 [nfnetlink]
[   19.759708]        netlink_unicast+0x1bf/0x2b0
[   19.759712]        netlink_sendmsg+0x211/0x430
[   19.759714]        ____sys_sendmsg+0x373/0x3b0
[   19.759719]        ___sys_sendmsg+0x7d/0xc0
[   19.759722]        __sys_sendmsg+0x5e/0xb0
[   19.759724]        do_syscall_64+0x94/0x3d0
[   19.759727]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.759729] 
               -> #1 (&nft_net->commit_mutex){+.+.}-{4:4}:
[   19.759733]        __mutex_lock+0x9f/0xed0
[   19.759735]        nf_tables_netdev_event+0x59/0xc0 [nf_tables]
[   19.759751]        notifier_call_chain+0x3d/0x100
[   19.759755]        register_netdevice+0x731/0x8f0
[   19.759759]        cfg80211_register_netdevice+0x4c/0xf0 [cfg80211]
[   19.759828]        ieee80211_if_add+0x475/0x740 [mac80211]
[   19.759921]        ieee80211_register_hw+0xd6b/0xdb0 [mac80211]
[   19.759967]        iwl_op_mode_mld_start+0x438/0x4b0 [iwlmld]
[   19.759989]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.760012]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.760028]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.760043]        do_one_initcall+0x54/0x390
[   19.760046]        do_init_module+0x62/0x240
[   19.760049]        __do_sys_init_module+0x164/0x190
[   19.760052]        do_syscall_64+0x94/0x3d0
[   19.760055]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.760057] 
               -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
[   19.760061]        __lock_acquire+0x1481/0x2270
[   19.760067]        lock_acquire+0xc9/0x2c0
[   19.760070]        __mutex_lock+0x9f/0xed0
[   19.760074]        iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.760098]        __thermal_zone_get_temp+0x29/0x90
[   19.760102]        __thermal_zone_device_update+0x69/0x480
[   19.760106]        thermal_zone_device_set_mode+0x52/0xa0
[   19.760110]        iwl_mld_thermal_zone_register+0x144/0x1d0 [iwlmld]
[   19.760126]        iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.760140]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.760157]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.760173]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.760187]        do_one_initcall+0x54/0x390
[   19.760190]        do_init_module+0x62/0x240
[   19.760193]        __do_sys_init_module+0x164/0x190
[   19.760196]        do_syscall_64+0x94/0x3d0
[   19.760198]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.760201] 
               other info that might help us debug this:

[   19.760202] Chain exists of:
                 &rdev->wiphy.mtx --> thermal_list_lock --> &tz->lock

[   19.760208]  Possible unsafe locking scenario:

[   19.760209]        CPU0                    CPU1
[   19.760211]        ----                    ----
[   19.760212]   lock(&tz->lock);
[   19.760215]                                lock(thermal_list_lock);
[   19.760218]                                lock(&tz->lock);
[   19.760220]   lock(&rdev->wiphy.mtx);
[   19.760223] 
                *** DEADLOCK ***

[   19.760224] 2 locks held by modprobe/881:
[   19.760227]  #0: ffffffffc1914c68 (iwlwifi_opmode_table_mtx){+.+.}-{4:4}, at: iwl_opmode_register+0x21/0xc0 [iwlwifi]
[   19.760247]  #1: ffff897b0204e708 (&tz->lock){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x20/0xa0
[   19.760255] 
               stack backtrace:
[   19.760259] CPU: 11 UID: 0 PID: 881 Comm: modprobe Not tainted 6.16.0-rc3+ #11 PREEMPT(lazy) 
[   19.760262] Hardware name: Dell Inc. XPS 16 9640/09CK4V, BIOS 1.12.0 02/10/2025
[   19.760264] Call Trace:
[   19.760266]  <TASK>
[   19.760267]  dump_stack_lvl+0x68/0x90
[   19.760271]  print_circular_bug.cold+0x185/0x1d0
[   19.760276]  check_noncircular+0x10f/0x130
[   19.760279]  ? __kernel_text_address+0xe/0x30
[   19.760282]  ? unwind_get_return_address+0x26/0x50
[   19.760287]  __lock_acquire+0x1481/0x2270
[   19.760293]  lock_acquire+0xc9/0x2c0
[   19.760296]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.760314]  __mutex_lock+0x9f/0xed0
[   19.760317]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.760332]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.760345]  ? lock_acquire+0xc9/0x2c0
[   19.760348]  ? thermal_zone_device_set_mode+0x20/0xa0
[   19.760352]  ? lock_acquire+0xd9/0x2c0
[   19.760356]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.760368]  iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.760382]  ? lock_is_held_type+0xd5/0x140
[   19.760386]  __thermal_zone_get_temp+0x29/0x90
[   19.760389]  __thermal_zone_device_update+0x69/0x480
[   19.760395]  thermal_zone_device_set_mode+0x52/0xa0
[   19.760399]  iwl_mld_thermal_zone_register+0x144/0x1d0 [iwlmld]
[   19.760416]  iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.760435]  _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.760453]  iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.760468]  ? __pfx_iwl_mld_init+0x10/0x10 [iwlmld]
[   19.760482]  iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.760495]  do_one_initcall+0x54/0x390
[   19.760499]  do_init_module+0x62/0x240
[   19.760502]  ? __do_sys_init_module+0x164/0x190
[   19.760504]  __do_sys_init_module+0x164/0x190
[   19.760510]  do_syscall_64+0x94/0x3d0
[   19.760513]  ? lock_acquire+0xc9/0x2c0
[   19.760516]  ? __folio_batch_add_and_move+0x8f/0x2f0
[   19.760519]  ? lock_acquire+0xd9/0x2c0
[   19.760522]  ? find_held_lock+0x2b/0x80
[   19.760524]  ? find_held_lock+0x2b/0x80
[   19.760526]  ? find_held_lock+0x2b/0x80
[   19.760529]  ? rcu_read_unlock+0x17/0x60
[   19.760533]  ? lock_release+0x1a0/0x2d0
[   19.760537]  ? __lock_acquire+0x45f/0x2270
[   19.760541]  ? __handle_mm_fault+0xaf4/0xe20
[   19.760545]  ? lock_acquire+0xc9/0x2c0
[   19.760549]  ? find_held_lock+0x2b/0x80
[   19.760551]  ? rcu_read_unlock+0x17/0x60
[   19.760553]  ? lock_release+0x1a0/0x2d0
[   19.760556]  ? find_held_lock+0x2b/0x80
[   19.760559]  ? exc_page_fault+0x8c/0x240
[   19.760561]  ? lock_release+0x1a0/0x2d0
[   19.760564]  ? do_user_addr_fault+0x370/0x6b0
[   19.760568]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.760571] RIP: 0033:0x7f531b702bae
[   19.760574] Code: 48 8b 0d 5d 32 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2a 32 0f 00 f7 d8 64 89 01 48
[   19.760576] RSP: 002b:00007ffe4c645798 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[   19.760580] RAX: ffffffffffffffda RBX: 00005600c715be60 RCX: 00007f531b702bae
[   19.760581] RDX: 00005600a44015ee RSI: 00000000000cbf71 RDI: 00005600c7d0acd0
[   19.760583] RBP: 00007ffe4c645850 R08: 00005600c715bd40 R09: 00007f531b7f6ac0
[   19.760584] R10: 00005600c715b010 R11: 0000000000000246 R12: 0000000000040000
[   19.760585] R13: 00005600c715bdc0 R14: 00005600a44015ee R15: 0000000000000000
[   19.760590]  </TASK>
[   19.760846] iwlwifi 0000:03:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0


Regards,

Hans




> 
> ---
> 
> Hi,
> 
> I believe that this should solve the lockdep warning that Hans was
> seeing. That said, I have not tested it much.
> 
> v2:
> - Fix function name
> - Mark lock class variable static
> 
> Benjamin
> ---
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 ++
>  drivers/thermal/thermal_core.c               | 7 +++++++
>  include/linux/thermal.h                      | 8 ++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index 3fc679b6f11b..15d3c904eaa3 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -310,6 +310,7 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
>  
>  static int pkg_temp_thermal_device_add(unsigned int cpu)
>  {
> +	static struct lock_class_key x86_pkg_temp_class;
>  	struct thermal_trip trips[MAX_NUMBER_OF_TRIPS] = { 0 };
>  	int id = topology_logical_die_id(cpu);
>  	u32 eax, ebx, ecx, edx;
> @@ -349,6 +350,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>  		err = PTR_ERR(zonedev->tzone);
>  		goto out_kfree_zonedev;
>  	}
> +	thermal_zone_device_set_lock_class(zonedev->tzone, &x86_pkg_temp_class);
>  	err = thermal_zone_device_enable(zonedev->tzone);
>  	if (err)
>  		goto out_unregister_tz;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 17ca5c082643..ff5c2e01904a 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1657,6 +1657,13 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
>  }
>  EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
>  
> +void thermal_zone_device_set_lock_class(struct thermal_zone_device *tz,
> +					struct lock_class_key *lock_class)
> +{
> +	lockdep_set_class_and_name(&tz->lock, lock_class, tz->type);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_set_lock_class);
> +
>  void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
>  {
>  	return tzd->devdata;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 0b5ed6821080..3cb4cf60b66d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -240,6 +240,9 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
>  					const struct thermal_zone_device_ops *ops,
>  					const struct thermal_zone_params *tzp);
>  
> +void thermal_zone_device_set_lock_class(struct thermal_zone_device *tz,
> +					struct lock_class_key *lock_class);
> +
>  void thermal_zone_device_unregister(struct thermal_zone_device *tz);
>  
>  void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
> @@ -290,6 +293,11 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
>  					const struct thermal_zone_params *tzp)
>  { return ERR_PTR(-ENODEV); }
>  
> +static inline void
> +thermal_zone_device_set_lock_class(struct thermal_zone_device *tz,
> +				   struct lock_class_key *lock_class)
> +{ }
> +
>  static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  { }
>  


