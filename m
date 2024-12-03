Return-Path: <linux-pm+bounces-18498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E89E2948
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7635C169622
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAC1F8AE1;
	Tue,  3 Dec 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IA4QohTQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516221E25E3
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246990; cv=none; b=cc3dWhJtxhBZJVrSKZqPZhLLKrxLK455n6jiFhMb2f1Q+Hh+UISMK/n5Z9Q9H3D6O2K8TyjbsdDHAs/wt2MyhR8MDyba1ZpwJmeZfYL773OgXjgEpM9t5Eit6TUBAuWRbIrEIvn9XqWk6Dc6XRz0IU9J6R9iIpiL3SPz5nikZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246990; c=relaxed/simple;
	bh=c6B7j0pVqqSQff1A+qurvLDMuAbIqpFfLl39JSLyVz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUcmw5wijLBTdt8whblXGiTi6WTgsi4eoJ+aL04tnvn0nyltok0jW8tWRQ9w6zYdhMKUe0d94sTR/dSOKzJPzGltU6ctedqE6pqHCNtduLw7z9kdPAYJsdO7WFNG3XEbxB479jDuKdNl5WHvHylciDMkaiYFPnj8g9dTuzrBA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IA4QohTQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733246988; x=1764782988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c6B7j0pVqqSQff1A+qurvLDMuAbIqpFfLl39JSLyVz8=;
  b=IA4QohTQVxoebmHMc9hT5KPbYPF+kVhH2JG5fTEFmx62FaueCp2/Wchh
   HEZux6f5vKRgs/nfvLqrbmmG/rMHcDqxkNIgaacSkQ4GCbJ5qnAMu4cJY
   xpQHiyw9Kzm8hE2Q0PpYaQNPPVXCQ9Uiac+Mx7lJTlAEll6SSXIf3xw0l
   xF0g4BZxnKwrXQsw04B0MJ/XJGjtmY22Wpz45oO7+DerjDzz0FhRwvCYR
   z4H4BaO16u67jQeLSxtEQagrRVWZdsslhtplrVUJN46ZYbnjxlTLHI90l
   TlQpTEnHiJ/2XBj8syiNj6hcSW4Nh/b0SHZdEmv8awhTvuk/mkscpzmKc
   g==;
X-CSE-ConnectionGUID: lJgjJIjQTn+6mrY0OR9XVQ==
X-CSE-MsgGUID: zSnm+eJ0RpG9RWcjWYtxEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44868179"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="44868179"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:29:46 -0800
X-CSE-ConnectionGUID: AcGO7C0fS+Kc/uj8n16Z3w==
X-CSE-MsgGUID: Ya92w0CjRNu89JbiyygPyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93591627"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.210])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:29:43 -0800
Date: Tue, 3 Dec 2024 11:29:36 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Coelho, Luciano" <luciano.coelho@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Nikula, Jani" <jani.nikula@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <55daux4id67kg6ezr2zjuytzhkvvvrhw64d4eo3iyqznqd5dja@2hflmndl5u7p>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
 <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
 <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>
 <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>

On Tue, Dec 03, 2024 at 03:50:28PM +0100, Thomas Weißschuh wrote:
>On 2024-12-03 15:33:21+0100, Rafael J. Wysocki wrote:
>> On Tue, Dec 3, 2024 at 1:04 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
>> >
>> > On 2024-12-03 12:54:54+0100, Rafael J. Wysocki wrote:
>> > > On Tue, Dec 3, 2024 at 7:51 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
>> > > >
>> > > > (+Cc Sebastian)
>> > > >
>> > > > Hi Chaitanya,
>> > > >
>> > > > On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
>> > > > > Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>> > > > >
>> > > > > This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
>> > > >
>> > > > Thanks for the report.
>> > > >
>> > > > > Since the version next-20241120 [2], we are seeing the following regression
>> > > > >
>> > > > > `````````````````````````````````````````````````````````````````````````````````
>> > > > > <4>[   19.990743] Oops: general protection fault, probably for non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
>> > > > > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
>> > > > > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
>> > > > > <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
>> > > > > `````````````````````````````````````````````````````````````````````````````````
>> > > > > Details log can be found in [3].
>> > > > >
>> > > > > After bisecting the tree, the following patch [4] seems to be the first "bad"
>> > > > > commit
>> > > > >
>> > > > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
>> > > > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
>> > > > > Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
>> > > > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
>> > > > > Commit:     Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
>> > > > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
>> > > > >     power: supply: core: add wakeup source inhibit by power_supply_config
>> > > > > `````````````````````````````````````````````````````````````````````````````````````````````````````````
>> > > > >
>> > > > > This is now seen in our drm-tip runs as well. [5]
>> > > > >
>> > > > > Could you please check why the patch causes this regression and provide a fix if necessary?
>> > > >
>> > > > I don't see how this patch can lead to this error.
>> > >
>> > > It looks like the cfg->no_wakeup_source access reaches beyond the
>> > > struct boundary for some reason.
>> >
>> > But the access to this field is only done in __power_supply_register().
>> > The error reports however don't show this function at all,
>> > they come from power_supply_uevent() and power_supply_get_property() by
>> > which time the call to __power_supply_register() is long over.
>> >
>> > FWIW there is an uninitialized 'struct power_supply_config' in
>> > drivers/hid/hid-corsair-void.c. But I highly doubt the test machines are
>> > using that. (I'll send a patch later for it)
>>
>> So the only way I can think about in which the commit in question may
>> lead to the reported issues is that changing the size of struct
>> power_supply_config or its alignment makes an unexpected functional
>> difference somewhere.
>
>Indeed. I'd really like to see this issue reproduced with KASAN.

I just reproduced it in another machine, Lunar Lake. Signature is
slightly different. See the output with KASAN:


[   86.490814] Oops: general protection fault, probably for non-canonical address 0xe95b10e51c79f1ba: 0000 [#2] PREEMPT SMP KASAN NOPTI
[   86.502796] KASAN: maybe wild-memory-access in range [0x4ad8a728e3cf8dd0-0x4ad8a728e3cf8dd7]
[   86.511296] CPU: 1 UID: 0 PID: 900 Comm: systemd-logind Tainted: G      D            6.13.0-rc1-xe+ #2
[   86.520675] Tainted: [D]=DIE
[   86.523602] Hardware name: Intel Corporation Lunar Lake Client Platform/LNL-M LP5 RVP1, BIOS LNLMFWI1.R00.3220.D98.2407250720 07/25/2024
[   86.532322] loop0: detected capacity change from 0 to 8
[   86.535928] RIP: 0010:power_supply_get_property+0x105/0x2f0
[   86.546843] Code: ed 31 c0 48 be 00 00 00 00 00 fc ff df eb 10 41 83 c5 01 49 63 c5 48 39 c8 0f 83 e9 00 00 00 49 8d 1c 80 48 89 d8 48 c1 e8 03 <0f> b6 14 30 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 43
[   86.565712] RSP: 0018:ffff888119d97900 EFLAGS: 00010203
[   86.565720] RAX: 095b14e51c79f1ba RBX: 4ad8a728e3cf8dd5 RCX: 16c0acab92af81fb
[   86.565724] RDX: 1ffff11020b6449a RSI: dffffc0000000000 RDI: ffff888105b224d0
[   86.565727] RBP: ffff888119d97940 R08: 4ad8a728e3cf8dd5 R09: ffff888105b224b8
[   86.565731] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888119d97988
[   86.565734] R13: 0000000000000000 R14: 0000000000000004 R15: ffff888110182000
[   86.565737] FS:  000071c34d5f69c0(0000) GS:ffff888821080000(0000) knlGS:0000000000000000
[   86.565742] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.565745] CR2: 00005eada2cefb98 CR3: 00000001286c0003 CR4: 0000000000f70ef0
[   86.565749] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   86.565752] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   86.565755] PKRU: 55555554
[   86.565758] Call Trace:
[   86.565760]  <TASK>
[   86.565764]  ? show_regs+0x6c/0x80
[   86.565772]  ? die_addr+0x41/0xc0
[   86.565778]  ? exc_general_protection+0x163/0x260
[   86.661418]  ? asm_exc_general_protection+0x27/0x30
[   86.661431]  ? power_supply_get_property+0x105/0x2f0
[   86.661440]  ? kernfs_seq_start+0x4b/0x3e0
[   86.675515]  power_supply_show_property+0x16c/0x5a0
[   86.675524]  ? __pfx_power_supply_show_property+0x10/0x10
[   86.675532]  ? kasan_save_track+0x14/0x40
[   86.675542]  dev_attr_show+0x48/0xe0
[   86.675548]  ? __asan_memset+0x39/0x50
[   86.675554]  sysfs_kf_seq_show+0x1f4/0x3e0
[   86.701536]  kernfs_seq_show+0x117/0x170
[   86.701543]  seq_read_iter+0x410/0x12d0
[   86.701556]  kernfs_fop_read_iter+0x428/0x5a0
[   86.713826]  ? rw_verify_area+0x6f/0x600
[   86.713834]  vfs_read+0x7ee/0xd30
[   86.713842]  ? vfs_getattr_nosec+0x236/0x380
[   86.713849]  ? __pfx_vfs_read+0x10/0x10
[   86.713858]  ? __do_sys_newfstat+0xf8/0x100
[   86.733600]  ksys_read+0x11a/0x240
[   86.733608]  ? __pfx_ksys_read+0x10/0x10
[   86.741034]  __x64_sys_read+0x72/0xc0
[   86.741040]  ? syscall_trace_enter+0xa6/0x290
[   86.749155]  x64_sys_call+0x1bd1/0x2650
[   86.749162]  do_syscall_64+0x91/0x180
[   86.749169]  ? do_syscall_64+0x9d/0x180
[   86.760632]  ? trace_irq_enable+0xed/0x130
[   86.760642]  ? syscall_exit_to_user_mode+0x95/0x250
[   86.760650]  ? do_syscall_64+0x9d/0x180
[   86.760656]  ? syscall_exit_to_user_mode+0x95/0x250
[   86.778537]  ? do_syscall_64+0x9d/0x180
[   86.778543]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   86.778548] RIP: 0033:0x71c34cf25701
[   86.778553] Code: 00 48 8b 15 21 b7 0e 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 c0 cb 01 00 f3 0f 1e fa 80 3d 65 39 0f 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[   86.810010] RSP: 002b:00007ffcb91ef858 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   86.810015] RAX: ffffffffffffffda RBX: 0000000000001008 RCX: 000071c34cf25701
[   86.810019] RDX: 0000000000001008 RSI: 00005eada2cd2fa0 RDI: 000000000000000b
[   86.810022] RBP: 00007ffcb91ef960 R08: 0000000000000000 R09: 0000000000000001
[   86.810025] R10: 0000000000000003 R11: 0000000000000246 R12: 000000000000000b
[   86.810028] R13: 0000000000001008 R14: ffffffffffffffff R15: 00005eada2cd2fa0
[   86.810039]  </TASK>
[   86.810042] Modules linked in: overlay cmdlinepart spi_nor mtd intel_rapl_msr sunrpc wmi_bmof spi_intel_pci binfmt_misc processor_thermal_device_pci spi_intel processor_thermal_device processor_thermal_wt_hint processor_thermal_rfim intel_vpu processor_thermal_rapl mei_me drm_shmem_helper intel_rapl_common mei processor_thermal_wt_req idma64 drm_kms_helper processor_thermal_power_floor processor_thermal_mbox nls_iso88
59_1 intel_skl_int3472_tps68470 tps68470_regulator clk_tps68470 int3403_thermal int340x_thermal_zone intel_pmc_core intel_hid int3400_thermal intel_vsec pmt_telemetry intel_skl_int3472_discrete sparse_keymap pmt_class acpi_thermal_rel intel_skl_int3472_common acpi_pad acpi_tad input_leds joydev msr fuse efi_pstore dm_multipath nfnetlink ip_tables x_tables raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor a
sync_tx raid1 raid0 hid_sensor_custom hid_sensor_hub hid_generic intel_ishtp_hid crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha256_ssse3 usbhid
[   86.856030]  sha1_ssse3 hid e1000e intel_ish_ipc intel_ishtp ucsi_acpi thunderbolt typec_ucsi typec video wmi pinctrl_intel_platform aesni_intel crypto_simd cryptd
[   86.960822] ---[ end trace 0000000000000000 ]---


>
>> AFAICS, this commit cannot be reverted by itself, so which commits on
>> top of it need to be reverted in order to revert it cleanly?
>
>All the other patches from this series:
>https://lore.kernel.org/lkml/20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net/

it doesn's seem like these changes in power_supply are really the
culprit.  I tried taking all the power_supply changes on top of v6.12
and I don't see any issue there. It's looking more like a memory
corruption

>
>Could you point me to the full boot log in the drm-tip CI?

Here is one:
https://intel-gfx-ci.01.org/tree/intel-xe/xe-2310-5779fb3c12faf12589054127d60b1d36d56ba219/bat-lnl-1/boot0.txt

You can get more, with slightly different signatures by heading to
https://intel-gfx-ci.01.org/tree/intel-xe/bat-all.html?testfilter=igt@runner@aborted
  - click in one of the red cells for bat-lnl and then boot0

Lucas De Marchi

