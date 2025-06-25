Return-Path: <linux-pm+bounces-29508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C2AE8490
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D204C6A3ECB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB712627E7;
	Wed, 25 Jun 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwE9lFVY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5623199E89
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857814; cv=none; b=OWPDHy3ksXNgrArsD6OZs/2OZtntTYOyE616/7vlzIl/RqRsBko5t3qPhBb9g6i6XkGqIrqLSB9bsm2U6q2TR57IdJ9Jt5S4OXjDAXOXfEDFsr5nR20+YV/Oj3sfTL+4/1ld9khHnrOQyjnxKc4S9br+1Qpkgl2euoO86ZSydd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857814; c=relaxed/simple;
	bh=P6c7g9In//pvVPwb9uXj1B0Fnkg/1qbB4UEfWFAQYSA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=BbnMzr2j7Ew8nSJBU5oiI16Q00NUZHLUoVzfd6Lssl5+d3nlpTc+JqTSHKbcIYap4W1sIuXtfpmmneGsmDZ2iKkKmOWbwAyFHzc4b4o9/Pd4z301kAfP8zlWu7hUmBqzUv3122fUxMyww3X417ijXjQUnx8+ZtNH5rRd3d2SP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwE9lFVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D153C4CEEA;
	Wed, 25 Jun 2025 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857814;
	bh=P6c7g9In//pvVPwb9uXj1B0Fnkg/1qbB4UEfWFAQYSA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwE9lFVYV67Mp1kBR2VIn8fSeFTngUWOG9TelUSsJ3DW9E8sFxqWOIjCdsBseQE9T
	 NLeY/W9scU5JO6Jd+tokDrvSTjdHan4HoBjVNPgYml7t+K6lpsrSX0MvexXdfXdnxr
	 IAMgPC6BpvgxvSHKti3K7wmFTonExrX15AlYZacPd7Xz7tboQCLMtkw7ilaswLib0A
	 fJFEGmqEJNu2r9+dJyWscGZ0KjmbZqccmg8HaU7izp8Y3W3cZB2T0eYUgBmVFHHJ2M
	 7seq8z5aUT4+2JwR+ud3GlCpwxBYIx0DNyJpUmX0Um8SdlsALQKTVu6ULUrGOSsQNB
	 wrAjkFOlieBtw==
Content-Type: multipart/mixed; boundary="------------arKh07wBOyIx3IoyvbG76Lwl"
Message-ID: <4e459a6f-321f-4e02-a6a5-6d9bc0109fa9@kernel.org>
Date: Wed, 25 Jun 2025 15:23:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: use a custom lock class for intel
 x86_pkg_temp
To: "Berg, Benjamin" <benjamin.berg@intel.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>
References: <20250624132406.1485407-1-benjamin@sipsolutions.net>
 <4225e2d2-4fd8-49ee-b0e2-97cd5737423b@kernel.org>
 <55e9d6c524da8ea17f9853099b92adfa08ae74da.camel@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <55e9d6c524da8ea17f9853099b92adfa08ae74da.camel@intel.com>

This is a multi-part message in MIME format.
--------------arKh07wBOyIx3IoyvbG76Lwl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Benjamin,

On 25-Jun-25 12:15 PM, Berg, Benjamin wrote:
> On Wed, 2025-06-25 at 11:44 +0200, Hans de Goede wrote:
>> Hi Benjamin,
>>
>> On 24-Jun-25 3:24 PM, Benjamin Berg wrote:
>>> From: Benjamin Berg <benjamin.berg@intel.com>
>>>
>>> The intel driver has code paths that will take the tz->lock while the
>>> cpuhp_state-up lock is held. As the cpuhp_state-up lock is used in other
>>> code paths, it may happen that lockdep detects possible deadlocks
>>> through unrelated thermal zone devices.
>>>
>>> Fix these false positives by using a separate lockdep class for the
>>> x86_pkg_temp thermal device.
>>>
>>> Reported-by: Hans de Goede <hansg@kernel.org>
>>> Closes: https://lore.kernel.org/linux-pm/e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org/
>>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>>
>> Thank you for trying to fix this, the fix does get rid of cpuhp_state-up
>> in the lockdep report, only for it to be replaced with the thermal_list_lock
>> unfortunately (full lockdep report below).
>>
>> It seems that the real issue is trying to lock wiphy.mtx while holding
>> tz->lock.
>>
>> Or maybe we need this patch + a patch to not hold wiphy.mtx while
>> registering the thermalzone ?
> 
> I think my patch simply did not work, because
> thermal_zone_device_register_with_trips is already taking &tz->lock
> before the lock class is changed.
> 
> What might work is to instead pass the lock class in when registering
> the thermal zone device. i.e. just add a new helper with an additional
> argument for the lock class and set it right after the mutex_init call
> for &tz->lock.

I wrote the attached patch to give each call-site (so each tz driver)
its own lock_class_key. Unfortunately this does not help and AFAICT
the lockdep report is unchanged from your v2 patch. I'll put the new
full lockdep report below.

Regards,

Hans


[   19.526864] ======================================================
[   19.526866] WARNING: possible circular locking dependency detected
[   19.526868] 6.16.0-rc3+ #17 Tainted: G        W          
[   19.526871] ------------------------------------------------------
[   19.526873] modprobe/893 is trying to acquire lock:
[   19.526875] ffff8c5c17570768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.526915] 
               but task is already holding lock:
[   19.526916] ffff8c5bee900708 (&tz->lock#5){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x20/0xa0
[   19.526929] 
               which lock already depends on the new lock.

[   19.526931] 
               the existing dependency chain (in reverse order) is:
[   19.526932] 
               -> #5 (&tz->lock#5){+.+.}-{4:4}:
[   19.526938]        __mutex_lock+0x9f/0xed0
[   19.526944]        thermal_zone_device_register_with_trips_and_lockkey+0x571/0x640
[   19.526948]        iwl_mld_thermal_zone_register+0x130/0x1e0 [iwlmld]
[   19.526967]        iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.526992]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.527013]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.527029]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.527045]        do_one_initcall+0x54/0x390
[   19.527051]        do_init_module+0x62/0x240
[   19.527056]        __do_sys_init_module+0x164/0x190
[   19.527058]        do_syscall_64+0x94/0x3d0
[   19.527062]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.527065] 
               -> #4 (thermal_list_lock){+.+.}-{4:4}:
[   19.527069]        __mutex_lock+0x9f/0xed0
[   19.527072]        __thermal_cooling_device_register.part.0+0x16e/0x2a0
[   19.527076]        acpi_processor_thermal_init+0x24/0xb0
[   19.527082]        acpi_soft_cpu_online+0xa7/0x140
[   19.527085]        cpuhp_invoke_callback+0x1ab/0x660
[   19.527090]        cpuhp_thread_fun+0x187/0x270
[   19.527094]        smpboot_thread_fn+0x12a/0x2e0
[   19.527099]        kthread+0x108/0x240
[   19.527103]        ret_from_fork+0x232/0x2a0
[   19.527109]        ret_from_fork_asm+0x1a/0x30
[   19.527113] 
               -> #3 (cpuhp_state-up){+.+.}-{0:0}:
[   19.527117]        cpuhp_thread_fun+0x99/0x270
[   19.527121]        smpboot_thread_fn+0x12a/0x2e0
[   19.527124]        kthread+0x108/0x240
[   19.527127]        ret_from_fork+0x232/0x2a0
[   19.527131]        ret_from_fork_asm+0x1a/0x30
[   19.527134] 
               -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[   19.527138]        cpus_read_lock+0x3c/0xe0
[   19.527142]        static_key_slow_inc+0x12/0x30
[   19.527148]        __nf_register_net_hook+0xb7/0x210
[   19.527154]        nf_register_net_hook+0x2d/0x90
[   19.527157]        nf_tables_addchain.constprop.0+0x2dd/0x6f0 [nf_tables]
[   19.527180]        nf_tables_newchain+0x78f/0xb10 [nf_tables]
[   19.527194]        nfnetlink_rcv_batch+0x7a5/0xc50 [nfnetlink]
[   19.527199]        nfnetlink_rcv+0x12d/0x150 [nfnetlink]
[   19.527202]        netlink_unicast+0x1bf/0x2b0
[   19.527205]        netlink_sendmsg+0x211/0x430
[   19.527207]        ____sys_sendmsg+0x373/0x3b0
[   19.527212]        ___sys_sendmsg+0x7d/0xc0
[   19.527216]        __sys_sendmsg+0x5e/0xb0
[   19.527218]        do_syscall_64+0x94/0x3d0
[   19.527221]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.527223] 
               -> #1 (&nft_net->commit_mutex){+.+.}-{4:4}:
[   19.527228]        __mutex_lock+0x9f/0xed0
[   19.527230]        nf_tables_netdev_event+0x59/0xc0 [nf_tables]
[   19.527246]        notifier_call_chain+0x3d/0x100
[   19.527250]        register_netdevice+0x731/0x8f0
[   19.527254]        cfg80211_register_netdevice+0x4c/0xf0 [cfg80211]
[   19.527318]        ieee80211_if_add+0x475/0x740 [mac80211]
[   19.527406]        ieee80211_register_hw+0xd6b/0xdb0 [mac80211]
[   19.527453]        iwl_op_mode_mld_start+0x438/0x4b0 [iwlmld]
[   19.527476]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.527494]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.527507] Adding alias for supply vdd-amp,(null) -> vdd-amp,sdw:0:0:01fa:4243:01
[   19.527510]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.527526]        do_one_initcall+0x54/0x390
[   19.527530]        do_init_module+0x62/0x240
[   19.527533]        __do_sys_init_module+0x164/0x190
[   19.527535]        do_syscall_64+0x94/0x3d0
[   19.527538]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.527540] 
               -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
[   19.527545]        __lock_acquire+0x1481/0x2270
[   19.527550]        lock_acquire+0xc9/0x2c0
[   19.527554]        __mutex_lock+0x9f/0xed0
[   19.527557]        iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.527580]        __thermal_zone_get_temp+0x29/0x90
[   19.527584]        __thermal_zone_device_update+0x69/0x480
[   19.527588]        thermal_zone_device_set_mode+0x52/0xa0
[   19.527592]        iwl_mld_thermal_zone_register+0x14b/0x1e0 [iwlmld]
[   19.527608]        iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.527626]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.527642]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.527658]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.527672]        do_one_initcall+0x54/0x390
[   19.527675]        do_init_module+0x62/0x240
[   19.527678]        __do_sys_init_module+0x164/0x190
[   19.527681]        do_syscall_64+0x94/0x3d0
[   19.527683]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.527685] 
               other info that might help us debug this:

[   19.527687] Chain exists of:
                 &rdev->wiphy.mtx --> thermal_list_lock --> &tz->lock#5

[   19.527694]  Possible unsafe locking scenario:

[   19.527695]        CPU0                    CPU1
[   19.527697]        ----                    ----
[   19.527698]   lock(&tz->lock#5);
[   19.527701]                                lock(thermal_list_lock);
[   19.527704]                                lock(&tz->lock#5);
[   19.527707]   lock(&rdev->wiphy.mtx);
[   19.527710] 
                *** DEADLOCK ***

[   19.527711] 2 locks held by modprobe/893:
[   19.527714]  #0: ffffffffc1a47c68 (iwlwifi_opmode_table_mtx){+.+.}-{4:4}, at: iwl_opmode_register+0x21/0xc0 [iwlwifi]
[   19.527735]  #1: ffff8c5bee900708 (&tz->lock#5){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x20/0xa0
[   19.527743] 
               stack backtrace:
[   19.527747] CPU: 8 UID: 0 PID: 893 Comm: modprobe Tainted: G        W           6.16.0-rc3+ #17 PREEMPT(lazy) 
[   19.527751] Tainted: [W]=WARN
[   19.527752] Hardware name: Dell Inc. XPS 16 9640/09CK4V, BIOS 1.12.0 02/10/2025
[   19.527754] Call Trace:
[   19.527756]  <TASK>
[   19.527757]  dump_stack_lvl+0x68/0x90
[   19.527762]  print_circular_bug.cold+0x185/0x1d0
[   19.527767]  check_noncircular+0x10f/0x130
[   19.527770]  ? __kernel_text_address+0xe/0x30
[   19.527773]  ? unwind_get_return_address+0x26/0x50
[   19.527778]  __lock_acquire+0x1481/0x2270
[   19.527784]  lock_acquire+0xc9/0x2c0
[   19.527787]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.527806]  __mutex_lock+0x9f/0xed0
[   19.527809]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.527824]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.527839]  ? lock_acquire+0xc9/0x2c0
[   19.527843]  ? thermal_zone_device_set_mode+0x20/0xa0
[   19.527846]  ? lock_acquire+0xd9/0x2c0
[   19.527850]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.527864]  iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.527885]  ? lock_is_held_type+0xd5/0x140
[   19.527889]  __thermal_zone_get_temp+0x29/0x90
[   19.527892]  __thermal_zone_device_update+0x69/0x480
[   19.527898]  thermal_zone_device_set_mode+0x52/0xa0
[   19.527901]  iwl_mld_thermal_zone_register+0x14b/0x1e0 [iwlmld]
[   19.527920]  iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.527943]  _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.527963]  iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.527979]  ? __pfx_iwl_mld_init+0x10/0x10 [iwlmld]
[   19.527994]  iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.528008]  do_one_initcall+0x54/0x390
[   19.528013]  do_init_module+0x62/0x240
[   19.528015]  ? __do_sys_init_module+0x164/0x190
[   19.528018]  __do_sys_init_module+0x164/0x190
[   19.528025]  do_syscall_64+0x94/0x3d0
[   19.528028]  ? lock_acquire+0xc9/0x2c0
[   19.528032]  ? find_held_lock+0x2b/0x80
[   19.528035]  ? rcu_read_unlock+0x17/0x60
[   19.528040]  ? lock_release+0x1a0/0x2d0
[   19.528043]  ? find_held_lock+0x2b/0x80
[   19.528045]  ? exc_page_fault+0x8c/0x240
[   19.528047]  ? lock_release+0x1a0/0x2d0
[   19.528052]  ? do_user_addr_fault+0x370/0x6b0
[   19.528056]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.528058] RIP: 0033:0x7f7cf7f02bae
[   19.528063] Code: 48 8b 0d 5d 32 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2a 32 0f 00 f7 d8 64 89 01 48
[   19.528065] RSP: 002b:00007ffeadb3b848 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[   19.528068] RAX: ffffffffffffffda RBX: 00005560c13fae60 RCX: 00007f7cf7f02bae
[   19.528070] RDX: 00005560a17a75ee RSI: 00000000000cbfb9 RDI: 00005560c1fa9cd0
[   19.528071] RBP: 00007ffeadb3b900 R08: 00005560c13fad40 R09: 00007f7cf7ff6ac0
[   19.528072] R10: 00005560c13fa010 R11: 0000000000000246 R12: 0000000000040000
[   19.528073] R13: 00005560c13fadc0 R14: 00005560a17a75ee R15: 0000000000000000
[   19.528078]  </TASK>
[   19.528285] iwlwifi 0000:03:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0





--------------arKh07wBOyIx3IoyvbG76Lwl
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-thermal-core-Give-each-thermal-zone-driver-its-own-l.patch"
Content-Disposition: attachment;
 filename*0="0001-thermal-core-Give-each-thermal-zone-driver-its-own-l.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhYmI1ZjFjMzBhZTc3MzgxYmMzNmY0ZTQyMjQxYzk3ODkzMDllMDI4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoYW5zZ0BrZXJuZWwub3Jn
PgpEYXRlOiBXZWQsIDI1IEp1biAyMDI1IDEzOjQwOjE5ICswMjAwClN1YmplY3Q6IFtQQVRD
SF0gdGhlcm1hbDogY29yZTogR2l2ZSBlYWNoIHRoZXJtYWwtem9uZSBkcml2ZXIgaXRzIG93
bgogbG9ja19jbGFzc19rZXkKCkRpZmZlcmVudCB0aGVybWFsLXpvbmUgZGV2aWNlcyBzaGFy
aW5nIHRoZSBzYW1lIGxvY2tfY2xhc3Nfa2V5IGNhbiBsZWFkCnRvIGZhbHNlLXBvc2l0aXZl
IGxvY2tkZXAgcmVwb3J0cy4KCkNoYW5nZSB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVy
X3dpdGhfdHJpcHMoKSBpbnRvCnRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90
cmlwc19hbmRfbG9ja2tleSgpIGFuZCBtYWtlCnRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0
ZXJfd2l0aF90cmlwcygpIGEgd3JhcHBlciBtYWNybyBhcm91bmQKdGhpcyBpbmNsdWRpbmcg
Z2l2aW5nIGVhY2ggdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKCkK
Y2FsbC1zaXRlIHRoZWlyIG93biBsb2NrX2NsYXNzX2tleS4KCkFsc28gdHVybiB0aGVybWFs
X3RyaXBsZXNzX3pvbmVfZGV2aWNlX3JlZ2lzdGVyKCkgaW50byBhIG1hY3JvLCBzbyB0aGF0
IGl0cwpjYWxsZXJzIGFsc28gZ2V0IHRoZWlyIG93biBsb2NrX2NsYXNzX2tleS4KClN1Z2dl
c3RlZC1ieTogQmVuamFtaW4gQmVyZyA8YmVuamFtaW4uYmVyZ0BpbnRlbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhhbnNnQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHwgMzUgKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0KIGluY2x1ZGUvbGludXgvdGhlcm1hbC5oICAgICAgICB8IDQwICsrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9u
cygrKSwgMzQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfY29yZS5jIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCmluZGV4IDE3
Y2E1YzA4MjY0My4uMDAzMzQyYzQ2NjI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmMKKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCkBA
IC0xNDcwLDcgKzE0NzAsNyBAQCBzdGF0aWMgdm9pZCB0aGVybWFsX3pvbmVfaW5pdF9jb21w
bGV0ZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHopCiB9CiAKIC8qKgotICogdGhl
cm1hbF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKCkgLSByZWdpc3RlciBhIG5l
dyB0aGVybWFsIHpvbmUgZGV2aWNlCisgKiB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVy
X3dpdGhfdHJpcHNfYW5kX2xvY2trZXkoKSAtIHJlZ2lzdGVyIGEgbmV3IHRoZXJtYWwgem9u
ZSBkZXZpY2UKICAqIEB0eXBlOgl0aGUgdGhlcm1hbCB6b25lIGRldmljZSB0eXBlCiAgKiBA
dHJpcHM6CWEgcG9pbnRlciB0byBhbiBhcnJheSBvZiB0aGVybWFsIHRyaXBzCiAgKiBAbnVt
X3RyaXBzOgl0aGUgbnVtYmVyIG9mIHRyaXAgcG9pbnRzIHRoZSB0aGVybWFsIHpvbmUgc3Vw
cG9ydApAQCAtMTQ4Miw2ICsxNDgyLDkgQEAgc3RhdGljIHZvaWQgdGhlcm1hbF96b25lX2lu
aXRfY29tcGxldGUoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KQogICogQHBvbGxp
bmdfZGVsYXk6IG51bWJlciBvZiBtaWxsaXNlY29uZHMgdG8gd2FpdCBiZXR3ZWVuIHBvbGxz
IHdoZW4gY2hlY2tpbmcKICAqCQkgICB3aGV0aGVyIHRyaXAgcG9pbnRzIGhhdmUgYmVlbiBj
cm9zc2VkICgwIGZvciBpbnRlcnJ1cHQKICAqCQkgICBkcml2ZW4gc3lzdGVtcykKKyAqIEBs
b2Nra2V5Oglsb2NrX2NsYXNzX2tleSB0byB1c2UgZm9yIHRoaXMgdGhlcm1hbCB6b25lJ3Mg
bG9jaywgbm90ZSBkcml2ZXJzCisgKgkJc2hvdWxkIHVzZSB0aGUgdGhlcm1hbF96b25lX2Rl
dmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKCkgbWFjcm8KKyAqCQlpbnN0ZWFkIG9mIHNwZWNp
ZnlpbmcgdGhpcwogICoKICAqIFRoaXMgaW50ZXJmYWNlIGZ1bmN0aW9uIGFkZHMgYSBuZXcg
dGhlcm1hbCB6b25lIGRldmljZSAoc2Vuc29yKSB0bwogICogL3N5cy9jbGFzcy90aGVybWFs
IGZvbGRlciBhcyB0aGVybWFsX3pvbmVbMC0qXS4gSXQgdHJpZXMgdG8gYmluZCBhbGwgdGhl
CkBAIC0xNDk0LDEzICsxNDk3LDE0IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV9pbml0
X2NvbXBsZXRlKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eikKICAqIElTX0VSUioo
KSBoZWxwZXJzLgogICovCiBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqCi10aGVybWFs
X3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMoY29uc3QgY2hhciAqdHlwZSwKLQkJ
CQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcCAqdHJpcHMsCi0JCQkJCWludCBudW1fdHJp
cHMsIHZvaWQgKmRldmRhdGEsCi0JCQkJCWNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2
aWNlX29wcyAqb3BzLAotCQkJCQljb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX3BhcmFtcyAq
dHpwLAotCQkJCQl1bnNpZ25lZCBpbnQgcGFzc2l2ZV9kZWxheSwKLQkJCQkJdW5zaWduZWQg
aW50IHBvbGxpbmdfZGVsYXkpCit0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhf
dHJpcHNfYW5kX2xvY2trZXkoY29uc3QgY2hhciAqdHlwZSwKKwkJCQkJCSAgICBjb25zdCBz
dHJ1Y3QgdGhlcm1hbF90cmlwICp0cmlwcywKKwkJCQkJCSAgICBpbnQgbnVtX3RyaXBzLCB2
b2lkICpkZXZkYXRhLAorCQkJCQkJICAgIGNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2
aWNlX29wcyAqb3BzLAorCQkJCQkJICAgIGNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfcGFy
YW1zICp0enAsCisJCQkJCQkgICAgdW5zaWduZWQgaW50IHBhc3NpdmVfZGVsYXksCisJCQkJ
CQkgICAgdW5zaWduZWQgaW50IHBvbGxpbmdfZGVsYXksCisJCQkJCQkgICAgc3RydWN0IGxv
Y2tfY2xhc3Nfa2V5ICpsb2Nra2V5KQogewogCWNvbnN0IHN0cnVjdCB0aGVybWFsX3RyaXAg
KnRyaXAgPSB0cmlwczsKIAlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHo7CkBAIC0x
NTU1LDcgKzE1NTksNyBAQCB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJp
cHMoY29uc3QgY2hhciAqdHlwZSwKIAlJTklUX0xJU1RfSEVBRCgmdHotPnRyaXBzX3JlYWNo
ZWQpOwogCUlOSVRfTElTVF9IRUFEKCZ0ei0+dHJpcHNfaW52YWxpZCk7CiAJaWRhX2luaXQo
JnR6LT5pZGEpOwotCW11dGV4X2luaXQoJnR6LT5sb2NrKTsKKwltdXRleF9pbml0X3dpdGhf
a2V5KCZ0ei0+bG9jaywgbG9ja2tleSk7CiAJaW5pdF9jb21wbGV0aW9uKCZ0ei0+cmVtb3Zh
bCk7CiAJaW5pdF9jb21wbGV0aW9uKCZ0ei0+cmVzdW1lKTsKIAlpZCA9IGlkYV9hbGxvYygm
dGhlcm1hbF90el9pZGEsIEdGUF9LRVJORUwpOwpAQCAtMTY0NCwxOCArMTY0OCw3IEBAIHRo
ZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlwcyhjb25zdCBjaGFyICp0eXBl
LAogCWtmcmVlKHR6KTsKIAlyZXR1cm4gRVJSX1BUUihyZXN1bHQpOwogfQotRVhQT1JUX1NZ
TUJPTF9HUEwodGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKTsKLQot
c3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnRoZXJtYWxfdHJpcGxlc3Nfem9uZV9kZXZp
Y2VfcmVnaXN0ZXIoCi0JCQkJCWNvbnN0IGNoYXIgKnR5cGUsCi0JCQkJCXZvaWQgKmRldmRh
dGEsCi0JCQkJCWNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlX29wcyAqb3BzLAot
CQkJCQljb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX3BhcmFtcyAqdHpwKQotewotCXJldHVy
biB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHModHlwZSwgTlVMTCwg
MCwgZGV2ZGF0YSwKLQkJCQkJCSAgICAgICBvcHMsIHR6cCwgMCwgMCk7Ci19Ci1FWFBPUlRf
U1lNQk9MX0dQTCh0aGVybWFsX3RyaXBsZXNzX3pvbmVfZGV2aWNlX3JlZ2lzdGVyKTsKK0VY
UE9SVF9TWU1CT0xfR1BMKHRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlw
c19hbmRfbG9ja2tleSk7CiAKIHZvaWQgKnRoZXJtYWxfem9uZV9kZXZpY2VfcHJpdihzdHJ1
Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkKQogewpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC90aGVybWFsLmggYi9pbmNsdWRlL2xpbnV4L3RoZXJtYWwuaAppbmRleCAwYjVlZDY4
MjEwODAuLmYzNWRhYjk1MDAxZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC90aGVybWFs
LmgKKysrIGIvaW5jbHVkZS9saW51eC90aGVybWFsLmgKQEAgLTEzLDYgKzEzLDcgQEAKICNp
bmNsdWRlIDxsaW51eC9vZi5oPgogI2luY2x1ZGUgPGxpbnV4L2lkci5oPgogI2luY2x1ZGUg
PGxpbnV4L2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L2xvY2tkZXBfdHlwZXMuaD4KICNp
bmNsdWRlIDxsaW51eC9zeXNmcy5oPgogI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgog
I2luY2x1ZGUgPHVhcGkvbGludXgvdGhlcm1hbC5oPgpAQCAtMjI1LDIwICsyMjYsMzMgQEAg
dm9pZCB0aGVybWFsX3pvbmVfc2V0X3RyaXBfdGVtcChzdHJ1Y3QgdGhlcm1hbF96b25lX2Rl
dmljZSAqdHosCiBpbnQgdGhlcm1hbF96b25lX2dldF9jcml0X3RlbXAoc3RydWN0IHRoZXJt
YWxfem9uZV9kZXZpY2UgKnR6LCBpbnQgKnRlbXApOwogCiAjaWZkZWYgQ09ORklHX1RIRVJN
QUwKLXN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0aGVybWFsX3pvbmVfZGV2aWNlX3Jl
Z2lzdGVyX3dpdGhfdHJpcHMoCi0JCQkJCWNvbnN0IGNoYXIgKnR5cGUsCi0JCQkJCWNvbnN0
IHN0cnVjdCB0aGVybWFsX3RyaXAgKnRyaXBzLAotCQkJCQlpbnQgbnVtX3RyaXBzLCB2b2lk
ICpkZXZkYXRhLAotCQkJCQljb25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZV9vcHMg
Km9wcywKLQkJCQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9wYXJhbXMgKnR6cCwKLQkJ
CQkJdW5zaWduZWQgaW50IHBhc3NpdmVfZGVsYXksCi0JCQkJCXVuc2lnbmVkIGludCBwb2xs
aW5nX2RlbGF5KTsKKyNkZWZpbmUgdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRo
X3RyaXBzKHR5cGUsIHRyaXBzLCBudW1fdHJpcHMsIGRldmRhdGEsCVwKKwkJCQkJCW9wcywg
dHpwLCBwYXNzaXZlX2RlbGF5LCBwb2xsaW5nX2RlbGF5KQlcCisoewkJCQkJCQkJCQkJXAor
CXN0YXRpYyBzdHJ1Y3QgbG9ja19jbGFzc19rZXkgX19rZXk7CQkJCQkJXAorCXRoZXJtYWxf
em9uZV9kZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlwc19hbmRfbG9ja2tleSh0eXBlLCB0cmlw
cywgbnVtX3RyaXBzLAlcCisJCQkJCQkJICAgIGRldmRhdGEsIG9wcywgdHpwLAkJXAorCQkJ
CQkJCSAgICBwYXNzaXZlX2RlbGF5LAkJXAorCQkJCQkJCSAgICBwb2xsaW5nX2RlbGF5LCAm
X19rZXkpOwlcCit9KQogCi1zdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdGhlcm1hbF90
cmlwbGVzc196b25lX2RldmljZV9yZWdpc3RlcigKLQkJCQkJY29uc3QgY2hhciAqdHlwZSwK
LQkJCQkJdm9pZCAqZGV2ZGF0YSwKLQkJCQkJY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9k
ZXZpY2Vfb3BzICpvcHMsCi0JCQkJCWNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfcGFyYW1z
ICp0enApOworI2RlZmluZSB0aGVybWFsX3RyaXBsZXNzX3pvbmVfZGV2aWNlX3JlZ2lzdGVy
KHR5cGUsIGRldmRhdGEsIG9wcywgdHpwKQkJCVwKKyh7CQkJCQkJCQkJCQlcCisJc3RhdGlj
IHN0cnVjdCBsb2NrX2NsYXNzX2tleSBfX2tleTsJCQkJCQlcCisJdGhlcm1hbF96b25lX2Rl
dmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzX2FuZF9sb2Nra2V5KHR5cGUsIE5VTEwsIDAsCQlc
CisJCQkJCQkJICAgIGRldmRhdGEsIG9wcywgdHpwLAkJXAorCQkJCQkJCSAgICAwLCAwLCAm
X19rZXkpOwkJXAorfSkKKworc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKgordGhlcm1h
bF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzX2FuZF9sb2Nra2V5KGNvbnN0IGNo
YXIgKnR5cGUsCisJCQkJCQkgICAgY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJpcCAqdHJpcHMs
CisJCQkJCQkgICAgaW50IG51bV90cmlwcywgdm9pZCAqZGV2ZGF0YSwKKwkJCQkJCSAgICBj
b25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZV9vcHMgKm9wcywKKwkJCQkJCSAgICBj
b25zdCBzdHJ1Y3QgdGhlcm1hbF96b25lX3BhcmFtcyAqdHpwLAorCQkJCQkJICAgIHVuc2ln
bmVkIGludCBwYXNzaXZlX2RlbGF5LAorCQkJCQkJICAgIHVuc2lnbmVkIGludCBwb2xsaW5n
X2RlbGF5LAorCQkJCQkJICAgIHN0cnVjdCBsb2NrX2NsYXNzX2tleSAqbG9ja2tleSk7CiAK
IHZvaWQgdGhlcm1hbF96b25lX2RldmljZV91bnJlZ2lzdGVyKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eik7CiAKLS0gCjIuNDkuMAoK

--------------arKh07wBOyIx3IoyvbG76Lwl--

