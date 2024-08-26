Return-Path: <linux-pm+bounces-12874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0B95EFC3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419BF1C2144C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC61514E1;
	Mon, 26 Aug 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rJBfiGmS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0ED14D2BD
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671926; cv=none; b=UgyCBNpnc9aFfdSEyLdgjJwQp7pUoIYcoQ6LN1IqahsDuhCyVbPg1KScQGaDionEw8Sq/4SkRzVFufxtr5I8hMd+renldsZPFlExa7MQQDKs8f0/dvRT64QlprT/AxQ3LS3sYWvO9GYrhGi5NBerpE+H/t6GwdC5XH8orENYVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671926; c=relaxed/simple;
	bh=7GYM9SZsgGgN/ZC+AO1EScM+TL+WniMacfJbyVMO5sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sTmnnnNksl/b0kJ8AmiX4DXA5vQvzH+L3yOzbxjuPKxlOfaQ3b7oHN21JtgGwmtWyIL4BfJsPNOD5SnV35FA5gud/1HCLQpGKGS52wWgN9qXTOjo21nPZ8dGnq1T/rWdj3QkSkrlnk5El5F/R0Cq6nj29XNpHHxs4qXcDM13fvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rJBfiGmS; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240826113155euoutp02e583d3ea14846fb5e41669447445dc80~vQ-gTWQhY1892618926euoutp02_
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 11:31:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240826113155euoutp02e583d3ea14846fb5e41669447445dc80~vQ-gTWQhY1892618926euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724671915;
	bh=J0TRlNzlQxarkx8fTMeGEK/wTpXLvUaZJK/z/pLCxpw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rJBfiGmSk+lPz4XKUeekfGjWXQg21ihOGBXbxmTqCXDlQznDFJosmUuBkv5Y2EK4e
	 om5jIi+FIx3mCGkr35nMyBEcMJcd6bYCWLuu3/ChsNUiPMzeU5UU1GAchTdg8h8e+g
	 O7gUgjhnNHsZ2JO9rIgMRhhWlyahbbv1X45Nd9NM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240826113154eucas1p215e61cae3ea247a4f0be7236770b3a88~vQ-f2_jZr2099320993eucas1p2z;
	Mon, 26 Aug 2024 11:31:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D7.E2.09875.AA76CC66; Mon, 26
	Aug 2024 12:31:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5~vQ-fTt_Vw2403124031eucas1p1B;
	Mon, 26 Aug 2024 11:31:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240826113153eusmtrp1cc3868864f5e0b54f42078487d53aaf1~vQ-fSYEWr0936009360eusmtrp1P;
	Mon, 26 Aug 2024 11:31:53 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-01-66cc67aac0e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.9C.09010.9A76CC66; Mon, 26
	Aug 2024 12:31:53 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240826113152eusmtip19dda6fdfcaddae49e386f803f2530b50~vQ-eKSvr02755627556eusmtip1c;
	Mon, 26 Aug 2024 11:31:52 +0000 (GMT)
Message-ID: <ef729a47-b7f9-48b6-a14d-692565ef1d38@samsung.com>
Date: Mon, 26 Aug 2024 13:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] thermal/of: Use the .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, 'Mateusz Majewski'
	<m.majewski2@samsung.com>, linux-amlogic@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <2236794.NgBsaNRSFp@rjwysocki.net>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7qr0s+kGUx5J2wx77Osxd7XW9kt
	Fszmtri8aw6bxefeI4wWM87vY7JY2NTCbjHx2GRmizOnL7FaPHnYx+bA5bFm3hpGj8V7XjJ5
	3Lm2h81j85J6jy1X21k8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+NYWwtLwb0WxoozM8+y
	NzC+yeli5OSQEDCR2Ha6k7mLkYtDSGAFo8Sxhe2sEM4XRom+p+/ZIJzPjBJTlr9nhml52t7K
	BGILCSxnlOj5ywNR9JFRYtrEr+wgCV4BO4kL7WfAGlgEVCWmrD7FCBEXlDg58wkLiC0qIC9x
	/9YMsHphgQiJFY8msoHYIgJBEmvnzgLbzCxwn0ni2/+3YIOYBcQlbj2ZD7aZTcBQouttF1gD
	p4C+xP/1yxghauQlmrfOBntIQqCZU+LM1TtA2ziAHBeJtpdREB8IS7w6voUdwpaROD25hwWi
	vp1RYsHv+0wQzgRGiYbntxghqqwl7pz7xQYyiFlAU2L9Ln2IsKNE16GjzBDz+SRuvBWEuIFP
	YtK26VBhXomONiGIajWJWcfXwa09eOES8wRGpVlIwTILyZezkHwzC2HvAkaWVYziqaXFuemp
	xUZ5qeV6xYm5xaV56XrJ+bmbGIEp6/S/4192MC5/9VHvECMTB+MhRgkOZiURXrnLJ9OEeFMS
	K6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamNrilxmzGKVOEtD/
	Ih24Zq/KftZTHxc6NNxb2h54vnKt8aPsrXMLCxeu/Rmvo7JtQeDBLa7p6YH9k7V+ifXJXPwz
	RVBuksnvOL8pbk8tuY9ckUhMVinyYy3aEhGTHP8lR63+5sZFi5Lld9lXbn2RVtZyVtGWJ/T4
	ny/1LOUZP2ZFpW0/MV926fx3ayJ+vPhxYG2h9YOla3/1XEsuUIyMkz818/gO3zU8hfbVnye0
	v7x0zD3E7rab6s2/iwVPhX9pveQp8XfxncnfuXd8W9T317VyesmmNGOnsDkyy5jDCtwcS7w4
	pKLm6dx5Uupz5fHLjvnnlibOEG0tnP3sXTLjXqW6Jtmv2+f1lYtPsLv+/6MSS3FGoqEWc1Fx
	IgDZz/r8yAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7or08+kGbz9qmIx77Osxd7XW9kt
	Fszmtri8aw6bxefeI4wWM87vY7JY2NTCbjHx2GRmizOnL7FaPHnYx+bA5bFm3hpGj8V7XjJ5
	3Lm2h81j85J6jy1X21k8+rasYvT4vEkugD1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP
	0Ng81srIVEnfziYlNSezLLVI3y5BL+NYWwtLwb0WxoozM8+yNzC+yeli5OSQEDCReNreytTF
	yMUhJLCUUeLknD1MEAkZiZPTGlghbGGJP9e62CCK3jNKbL82B6yIV8BO4kL7GWYQm0VAVWLK
	6lOMEHFBiZMzn7CA2KIC8hL3b81gB7GFBSIk2t82g8VFBIIk7s/7wwIylFngMZPEhqmPwYqE
	BIIlfj4/BraAWUBc4taT+WA2m4ChRNdbkCs4OTgF9CX+r1/GCFFjJtG1tQvKlpdo3jqbeQKj
	0Cwkd8xCMmoWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzSbcd+btnBuPLV
	R71DjEwcjIcYJTiYlUR45S6fTBPiTUmsrEotyo8vKs1JLT7EaAoMjInMUqLJ+cA0kVcSb2hm
	YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLT+e9SHzc5LPH5nSudPVN56
	SthR4Hx0z8yTzN9irvg+ztZpWzm5Xd//ndNLW56a0s/r7jU6TG4UynA86lP8Qf/hMa20PRGu
	D3bV3Fgy+zjrtyPTrxoqKW4rXHpAVHLPxh9TZ/Xb/WksUTuQteuItG99Erduw7HHmf9aF7lF
	t7p8WGWu2XTGZl/05XuTDl89rlB8ZFNagfCNjx+UD29Xy7IWWzNZLm5vVPDcI3rzwlb3X9jw
	4eOkd74NvMe4NlnfOuETmHZ48mGBjUvbODqTGcSKlp94ceZostnKTcuzc1xaOr0y+yROZyb6
	vPsacD60TEB60qOI67sPr4t7GdSc3bct9MYHT7t57CfEjU8c3OChxFKckWioxVxUnAgAZTRw
	rFsDAAA=
X-CMS-MailID: 20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5
References: <2205737.irdbgypaU6@rjwysocki.net>
	<2236794.NgBsaNRSFp@rjwysocki.net>
	<CGME20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5@eucas1p1.samsung.com>

On 19.08.2024 18:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make the thermal_of driver use the .should_bind() thermal zone callback
> to provide the thermal core with the information on whether or not to
> bind the given cooling device to the given trip point in the given
> thermal zone.  If it returns 'true', the thermal core will bind the
> cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
>
> This replaces the .bind() and .unbind() thermal zone callbacks which
> assumed the same trip points ordering in the driver and in the thermal
> core (that may not be true any more in the future).  The .bind()
> callback would walk the given thermal zone's cooling maps to find all
> of the valid trip point combinations with the given cooling device and
> it would call thermal_zone_bind_cooling_device() for all of them using
> trip point indices reflecting the ordering of the trips in the DT.
>
> The .should_bind() callback still walks the thermal zone's cooling maps,
> but it can use the trip object passed to it by the thermal core to find
> the trip in question in the first place and then it uses the
> corresponding 'cooling-device' entries to look up the given cooling
> device.  To be able to match the trip object provided by the thermal
> core to a specific device node, the driver sets the 'priv' field of each
> trip to the corresponding device node pointer during initialization.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This patch landed recently in linux-next as commit 6d71d55c3b12 
("thermal/of: Use the .should_bind() thermal zone callback"). In my 
tests I found that it breaks booting some on my test boars: Exynos-based 
(OdroidXU4 with ARM32 bit kernel from multi_v7_defconfig) and Amlogic 
Meson based boards (OdroidC4, VIM3 with ARM64 defconfig+some debug 
options). Reverting $subject on top of next-20240823 together with 
c1ee6e1f68f5 ("thermal: core: Clean up trip bind/unbind functions") and 
526954900465 ("thermal: core: Drop unused bind/unbind functions and 
callbacks") due to compile dependencies fixes the issue.

On Odroid C4 I see the following warnings before the boards hangs:

BUG: sleeping function called from invalid context at 
kernel/locking/rwsem.c:1578
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 263, name: 
systemd-udevd
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by systemd-udevd/263:
  #0: ffff0000013768f8 (&dev->mutex){....}-{3:3}, at: 
__driver_attach+0x90/0x1ac
  #1: ffff80008349e1a0 (thermal_list_lock){+.+.}-{3:3}, at: 
__thermal_cooling_device_register.part.0+0x154/0x2f4
  #2: ffff000000988700 (&tz->lock){+.+.}-{3:3}, at: 
thermal_zone_cdev_binding+0x84/0x1e4
  #3: ffff8000834b8a98 (devtree_lock){....}-{2:2}, at: 
of_get_next_child+0x2c/0x80
irq event stamp: 7936
hardirqs last  enabled at (7935): [<ffff8000812b1700>] 
_raw_spin_unlock_irqrestore+0x74/0x78
hardirqs last disabled at (7936): [<ffff8000812b0b14>] 
_raw_spin_lock_irqsave+0x84/0x88
softirqs last  enabled at (7302): [<ffff8000800b13dc>] 
handle_softirqs+0x4cc/0x4e4
softirqs last disabled at (7295): [<ffff8000800105b0>] 
__do_softirq+0x14/0x20
CPU: 3 UID: 0 PID: 263 Comm: systemd-udevd Not tainted 6.11.0-rc3+ #15264
Hardware name: Hardkernel ODROID-C4 (DT)
Call trace:
  dump_backtrace+0x94/0xec
  show_stack+0x18/0x24
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  __might_resched+0x144/0x248
  __might_sleep+0x48/0x98
  down_write+0x28/0xe8
  kernfs_remove+0x34/0x58
  sysfs_remove_dir+0x54/0x70
  __kobject_del+0x40/0xb8
  kobject_put+0x104/0x124
  of_node_put+0x18/0x28
  of_get_next_child+0x4c/0x80
  thermal_of_should_bind+0xec/0x28c
  thermal_zone_cdev_binding+0x104/0x1e4
  __thermal_cooling_device_register.part.0+0x194/0x2f4
  thermal_of_cooling_device_register+0x3c/0x54
  of_devfreq_cooling_register_power+0x220/0x298
  devfreq_cooling_em_register+0x48/0xa8
  panfrost_devfreq_init+0x294/0x320 [panfrost]
  panfrost_device_init+0x16c/0x5c8 [panfrost]
  panfrost_probe+0xbc/0x194 [panfrost]
  platform_probe+0x68/0xdc
  really_probe+0xbc/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x40/0x164
  __driver_attach+0x9c/0x1ac
  bus_for_each_dev+0x74/0xd4
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x208
  driver_register+0x60/0x128
  __platform_driver_register+0x28/0x34
  panfrost_driver_init+0x20/0x1000 [panfrost]
  do_one_initcall+0x68/0x300
  do_init_module+0x60/0x224
  load_module+0x1b0c/0x1cb0
  init_module_from_file+0x84/0xc4
  idempotent_init_module+0x18c/0x284
  __arm64_sys_finit_module+0x64/0xa0
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0x40/0xe8
  do_el0_svc_compat+0x20/0x3c
  el0_svc_compat+0x44/0xe0
  el0t_32_sync_handler+0x98/0x148
  el0t_32_sync+0x194/0x198

=============================
[ BUG: Invalid wait context ]
6.11.0-rc3+ #15264 Tainted: G        W
-----------------------------
systemd-udevd/263 is trying to lock:
ffff0000000e5948 (&root->kernfs_rwsem){++++}-{3:3}, at: 
kernfs_remove+0x34/0x58
other info that might help us debug this:
context-{4:4}
4 locks held by systemd-udevd/263:
  #0: ffff0000013768f8 (&dev->mutex){....}-{3:3}, at: 
__driver_attach+0x90/0x1ac
  #1: ffff80008349e1a0 (thermal_list_lock){+.+.}-{3:3}, at: 
__thermal_cooling_device_register.part.0+0x154/0x2f4
  #2: ffff000000988700 (&tz->lock){+.+.}-{3:3}, at: 
thermal_zone_cdev_binding+0x84/0x1e4
  #3: ffff8000834b8a98 (devtree_lock){....}-{2:2}, at: 
of_get_next_child+0x2c/0x80
stack backtrace:
CPU: 3 UID: 0 PID: 263 Comm: systemd-udevd Tainted: G W          
6.11.0-rc3+ #15264
Tainted: [W]=WARN
Hardware name: Hardkernel ODROID-C4 (DT)
Call trace:
  dump_backtrace+0x94/0xec
  show_stack+0x18/0x24
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  __lock_acquire+0x9fc/0x21a0
  lock_acquire+0x200/0x340
  down_write+0x50/0xe8
  kernfs_remove+0x34/0x58
  sysfs_remove_dir+0x54/0x70
  __kobject_del+0x40/0xb8
  kobject_put+0x104/0x124
  of_node_put+0x18/0x28
  of_get_next_child+0x4c/0x80
  thermal_of_should_bind+0xec/0x28c
  thermal_zone_cdev_binding+0x104/0x1e4
  __thermal_cooling_device_register.part.0+0x194/0x2f4
  thermal_of_cooling_device_register+0x3c/0x54
  of_devfreq_cooling_register_power+0x220/0x298
  devfreq_cooling_em_register+0x48/0xa8
  panfrost_devfreq_init+0x294/0x320 [panfrost]
  panfrost_device_init+0x16c/0x5c8 [panfrost]
  panfrost_probe+0xbc/0x194 [panfrost]
  platform_probe+0x68/0xdc
  really_probe+0xbc/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x40/0x164
  __driver_attach+0x9c/0x1ac
  bus_for_each_dev+0x74/0xd4
  driver_attach+0x24/0x30
  bus_add_driver+0xe4/0x208
  driver_register+0x60/0x128
  __platform_driver_register+0x28/0x34
  panfrost_driver_init+0x20/0x1000 [panfrost]
  do_one_initcall+0x68/0x300
  do_init_module+0x60/0x224
  load_module+0x1b0c/0x1cb0
  init_module_from_file+0x84/0xc4
  idempotent_init_module+0x18c/0x284
  __arm64_sys_finit_module+0x64/0xa0
  invoke_syscall+0x48/0x110
  el0_svc_common.constprop.0+0x40/0xe8
  do_el0_svc_compat+0x20/0x3c
  el0_svc_compat+0x44/0xe0
  el0t_32_sync_handler+0x98/0x148
  el0t_32_sync+0x194/0x198
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     2-...!: (0 ticks this GP) idle=2aac/1/0x4000000000000000 
softirq=798/798 fqs=4
rcu:     3-...!: (0 ticks this GP) idle=28a4/1/0x4000000000000000 
softirq=1007/1007 fqs=4
rcu:     (detected by 0, t=6505 jiffies, g=349, q=46 ncpus=4)
Sending NMI from CPU 0 to CPUs 2:
Sending NMI from CPU 0 to CPUs 3:
rcu: rcu_preempt kthread timer wakeup didn't happen for 6483 jiffies! 
g349 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu:     Possible timer handling issue on cpu=1 timer-softirq=260
rcu: rcu_preempt kthread starved for 6484 jiffies! g349 f0x0 
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now 
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:0     pid:16    tgid:16 ppid:2      
flags:0x00000008
Call trace:
  __switch_to+0xe0/0x124
  __schedule+0x318/0xc30
  schedule+0x50/0x15c
  schedule_timeout+0xac/0x134
  rcu_gp_fqs_loop+0x16c/0x8b4
  rcu_gp_kthread+0x280/0x314
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     2-...!: (0 ticks this GP) idle=2aac/1/0x4000000000000000 
softirq=798/798 fqs=4
rcu:     3-...!: (0 ticks this GP) idle=28a4/1/0x4000000000000000 
softirq=1007/1007 fqs=4
rcu:     (detected by 0, t=26013 jiffies, g=349, q=46 ncpus=4)
Sending NMI from CPU 0 to CPUs 2:
Sending NMI from CPU 0 to CPUs 3:

Let me know if I can help debugging this issue further.

> ---
>
> v2 -> v3: Reorder (previously [14/17])
>
> v1 -> v2:
>     * Fix a build issue (undefined symbol)
>
> This patch only depends on the [06/14] introducing the .should_bind()
> thermal zone callback:
>
> https://lore.kernel.org/linux-pm/9334403.CDJkKcVGEf@rjwysocki.net/
>
> ---
>   drivers/thermal/thermal_of.c |  171 ++++++++++---------------------------------
>   1 file changed, 41 insertions(+), 130 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_of.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_of.c
> +++ linux-pm/drivers/thermal/thermal_of.c
> @@ -20,37 +20,6 @@
>   
>   /***   functions parsing device tree nodes   ***/
>   
> -static int of_find_trip_id(struct device_node *np, struct device_node *trip)
> -{
> -	struct device_node *trips;
> -	struct device_node *t;
> -	int i = 0;
> -
> -	trips = of_get_child_by_name(np, "trips");
> -	if (!trips) {
> -		pr_err("Failed to find 'trips' node\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Find the trip id point associated with the cooling device map
> -	 */
> -	for_each_child_of_node(trips, t) {
> -
> -		if (t == trip) {
> -			of_node_put(t);
> -			goto out;
> -		}
> -		i++;
> -	}
> -
> -	i = -ENXIO;
> -out:
> -	of_node_put(trips);
> -
> -	return i;
> -}
> -
>   /*
>    * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
>    * into the device tree binding of 'trip', property type.
> @@ -119,6 +88,8 @@ static int thermal_of_populate_trip(stru
>   
>   	trip->flags = THERMAL_TRIP_FLAG_RW_TEMP;
>   
> +	trip->priv = np;
> +
>   	return 0;
>   }
>   
> @@ -290,39 +261,9 @@ static struct device_node *thermal_of_zo
>   	return tz_np;
>   }
>   
> -static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_id,
> -			       struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
> -{
> -	struct of_phandle_args cooling_spec;
> -	int ret;
> -
> -	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
> -					 index, &cooling_spec);
> -
> -	if (ret < 0) {
> -		pr_err("Invalid cooling-device entry\n");
> -		return ret;
> -	}
> -
> -	of_node_put(cooling_spec.np);
> -
> -	if (cooling_spec.args_count < 2) {
> -		pr_err("wrong reference to cooling device, missing limits\n");
> -		return -EINVAL;
> -	}
> -
> -	if (cooling_spec.np != cdev->np)
> -		return 0;
> -
> -	ret = thermal_zone_unbind_cooling_device(tz, trip_id, cdev);
> -	if (ret)
> -		pr_err("Failed to unbind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
> -
> -	return ret;
> -}
> -
> -static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
> -			     struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
> +static bool thermal_of_get_cooling_spec(struct device_node *map_np, int index,
> +					struct thermal_cooling_device *cdev,
> +					struct cooling_spec *c)
>   {
>   	struct of_phandle_args cooling_spec;
>   	int ret, weight = THERMAL_WEIGHT_DEFAULT;
> @@ -334,104 +275,75 @@ static int __thermal_of_bind(struct devi
>   
>   	if (ret < 0) {
>   		pr_err("Invalid cooling-device entry\n");
> -		return ret;
> +		return false;
>   	}
>   
>   	of_node_put(cooling_spec.np);
>   
>   	if (cooling_spec.args_count < 2) {
>   		pr_err("wrong reference to cooling device, missing limits\n");
> -		return -EINVAL;
> +		return false;
>   	}
>   
>   	if (cooling_spec.np != cdev->np)
> -		return 0;
> -
> -	ret = thermal_zone_bind_cooling_device(tz, trip_id, cdev, cooling_spec.args[1],
> -					       cooling_spec.args[0],
> -					       weight);
> -	if (ret)
> -		pr_err("Failed to bind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
> -
> -	return ret;
> -}
> -
> -static int thermal_of_for_each_cooling_device(struct device_node *tz_np, struct device_node *map_np,
> -					      struct thermal_zone_device *tz, struct thermal_cooling_device *cdev,
> -					      int (*action)(struct device_node *, int, int,
> -							    struct thermal_zone_device *, struct thermal_cooling_device *))
> -{
> -	struct device_node *tr_np;
> -	int count, i, trip_id;
> -
> -	tr_np = of_parse_phandle(map_np, "trip", 0);
> -	if (!tr_np)
> -		return -ENODEV;
> -
> -	trip_id = of_find_trip_id(tz_np, tr_np);
> -	if (trip_id < 0)
> -		return trip_id;
> -
> -	count = of_count_phandle_with_args(map_np, "cooling-device", "#cooling-cells");
> -	if (count <= 0) {
> -		pr_err("Add a cooling_device property with at least one device\n");
> -		return -ENOENT;
> -	}
> +		return false;
>   
> -	/*
> -	 * At this point, we don't want to bail out when there is an
> -	 * error, we will try to bind/unbind as many as possible
> -	 * cooling devices
> -	 */
> -	for (i = 0; i < count; i++)
> -		action(map_np, i, trip_id, tz, cdev);
> +	c->lower = cooling_spec.args[0];
> +	c->upper = cooling_spec.args[1];
> +	c->weight = weight;
>   
> -	return 0;
> +	return true;
>   }
>   
> -static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
> -					    struct thermal_cooling_device *cdev,
> -					    int (*action)(struct device_node *, int, int,
> -							  struct thermal_zone_device *, struct thermal_cooling_device *))
> +static bool thermal_of_should_bind(struct thermal_zone_device *tz,
> +				   const struct thermal_trip *trip,
> +				   struct thermal_cooling_device *cdev,
> +				   struct cooling_spec *c)
>   {
>   	struct device_node *tz_np, *cm_np, *child;
> -	int ret = 0;
> +	bool result = false;
>   
>   	tz_np = thermal_of_zone_get_by_name(tz);
>   	if (IS_ERR(tz_np)) {
>   		pr_err("Failed to get node tz by name\n");
> -		return PTR_ERR(tz_np);
> +		return false;
>   	}
>   
>   	cm_np = of_get_child_by_name(tz_np, "cooling-maps");
>   	if (!cm_np)
>   		goto out;
>   
> +	/* Look up the trip and the cdev in the cooling maps. */
>   	for_each_child_of_node(cm_np, child) {
> -		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
> -		if (ret) {
> +		struct device_node *tr_np;
> +		int count, i;
> +
> +		tr_np = of_parse_phandle(child, "trip", 0);
> +		if (tr_np != trip->priv) {
>   			of_node_put(child);
> -			break;
> +			continue;
> +		}
> +
> +		/* The trip has been found, look up the cdev. */
> +		count = of_count_phandle_with_args(child, "cooling-device", "#cooling-cells");
> +		if (count <= 0)
> +			pr_err("Add a cooling_device property with at least one device\n");
> +
> +		for (i = 0; i < count; i++) {
> +			result = thermal_of_get_cooling_spec(child, i, cdev, c);
> +			if (result)
> +				break;
>   		}
> +
> +		of_node_put(child);
> +		break;
>   	}
>   
>   	of_node_put(cm_np);
>   out:
>   	of_node_put(tz_np);
>   
> -	return ret;
> -}
> -
> -static int thermal_of_bind(struct thermal_zone_device *tz,
> -			   struct thermal_cooling_device *cdev)
> -{
> -	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_bind);
> -}
> -
> -static int thermal_of_unbind(struct thermal_zone_device *tz,
> -			     struct thermal_cooling_device *cdev)
> -{
> -	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_unbind);
> +	return result;
>   }
>   
>   /**
> @@ -502,8 +414,7 @@ static struct thermal_zone_device *therm
>   
>   	thermal_of_parameters_init(np, &tzp);
>   
> -	of_ops.bind = thermal_of_bind;
> -	of_ops.unbind = thermal_of_unbind;
> +	of_ops.should_bind = thermal_of_should_bind;
>   
>   	ret = of_property_read_string(np, "critical-action", &action);
>   	if (!ret)
>
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


