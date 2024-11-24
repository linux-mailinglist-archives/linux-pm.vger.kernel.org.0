Return-Path: <linux-pm+bounces-17999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEABD9D766B
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A04B283015
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29A25776;
	Sun, 24 Nov 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szS1/3qb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8429A9;
	Sun, 24 Nov 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468251; cv=none; b=Oxa5JiF5T11/xlSoXWvu0GEfvDCJroIsPxH9aOQ2+YfXGmMVwbNrT+BgwiFy6fMfljafGInzLAG/oeyIUBewd7nXZR42DcsRdabffv1F/uQ3UgL23IyCsQdPCGUsWgEw4+tv39CuXuBP52jZZDWmyCZrVkXV0prawQH4nkkuYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468251; c=relaxed/simple;
	bh=JMpphRHrvrNUXU/Bv0iBkopHsT7/Fgvhl4pq7h+uxww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubKfYz3q0MMbmasyCdKuPZDhwraGNB1xeH/9bVSLEQgcCkEA9F+S/nW6FofjN1nbfQcpmQVZp0THJa8ZDDreZkYAUMUVAPFBx9ypWSxJbOnFMj3ebWnMgk5gVYDPeYjzJjVQeDghWOnSXR4tGQBwR0cXh/BbknX2QZ52yHIJRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szS1/3qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFED3C4CECC;
	Sun, 24 Nov 2024 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732468251;
	bh=JMpphRHrvrNUXU/Bv0iBkopHsT7/Fgvhl4pq7h+uxww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szS1/3qb+Y0gog7DD75HUEd2xUMGhz/hY/qeFxEWnybO/InkTgMsJke+2ZoHYkua0
	 5HDRxhLIYyEB4heDGpz04A/QMTCbbxjrwDy8O/ir0YOa+CC0vCGSkl2ERAATKqwONP
	 akA2I6afWSUIYEOZ3kYQiR//TPfq6gQH+/vIU8zqpkbQ0vL88J8eNBXXerdkJPrNI4
	 S2zvC85FGSvUdyGUBYssVjhWMsHlcOkdFc9V2qcvDOXYO0qyVpiAg58c125gYSKv72
	 iI3N8Z8hfyj4c0IGwkZ3MHMMMHl41FOjAou+kuMZ4sgVtmcyLlFmZFaQOCk/wqiaUl
	 drT1xp0V2x95g==
Date: Sun, 24 Nov 2024 12:10:48 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] Thermal control updates for v6.13-rc1
Message-ID: <Z0NeGF4ryCe_b5rr@sashalap>
References: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>

On Mon, Nov 18, 2024 at 11:23:46AM +0100, Rafael J. Wysocki wrote:
>Hi Linus,
>
>Please pull from the tag
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> thermal-6.13-rc1

Hi Rafael,

After merging this PR into linus-next, KernelCI started reporting boot
failures on a few platforms:

[    6.921489] [00000000000000d0] user address but active_mm is swapper
[    6.927831] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    6.934086] Modules linked in:
[    6.937131] CPU: 7 UID: 0 PID: 12 Comm: kworker/u32:1 Tainted: G        W          6.12.0 #1 cab58e2e59020ebd4be8ada89a65f465a316c742
[    6.949114] Tainted: [W]=WARN
[    6.952070] Hardware name: Google Spherion (rev0 - 3) (DT)
[    6.957543] Workqueue: async async_run_entry_fn
[    6.962066] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.969013] pc : power_allocator_bind+0xd4/0x2e8
[    6.973622] lr : power_allocator_bind+0x38/0x2e8
[    6.978226] sp : ffff8000800e3010 
[    6.981528] x29: ffff8000800e3010 x28: ffff71f205b31800 x27: ffff71f205b31c08
[    6.988650] x26: ffffd833bdc11a78 x25: 0000000000000000 x24: ffff71f205b31da8
[    6.995773] x23: 0000000000000000 x22: ffff71f205b31800 x21: ffffd833bcd5f438
[    7.002896] x20: ffff71f200af61c0 x19: 0000000000000000 x18: ffffffffffffffff
[    7.010018] x17: 000000040044ffff x16: 0000000000000100 x15: ffff8000800e2e30
[    7.017141] x14: ffff71f205b40a1c x13: ffff71f205b4026f x12: 0101010101010101
[    7.024264] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000000 x9 : ffffd833baefbd2c
[    7.031387] x8 : ffff71f200af6200 x7 : 0000000000000000 x6 : 0000000000000000
[    7.038509] x5 : 0000000000000000 x4 : 0000000000000040 x3 : 0000000000000000
[    7.045632] x2 : ffffffffffffffc0 x1 : 0000000000000000 x0 : ffff71f205b31da8
[    7.052755] Call trace:
[    7.055190]  power_allocator_bind+0xd4/0x2e8 (P)
[    7.059795]  power_allocator_bind+0x38/0x2e8 (L)
[    7.064399]  thermal_set_governor+0x4c/0xc8
[    7.068571]  thermal_zone_device_register_with_trips+0x480/0x630
[    7.074566]  thermal_tripless_zone_device_register+0x34/0x48
[    7.080214]  __power_supply_register.part.0+0x364/0x4b8
[    7.085428]  __power_supply_register+0x64/0xc0
[    7.089860]  devm_power_supply_register+0x64/0xb8
[    7.094552]  sbs_probe+0x290/0x3a0 
[    7.097941]  i2c_device_probe+0x150/0x2a0
[    7.101941]  really_probe+0xc4/0x2a8
[    7.105506]  __driver_probe_device+0x80/0x140
[    7.109850]  driver_probe_device+0x44/0x120
[    7.114021]  __device_attach_driver+0xc0/0x108
[    7.118451]  bus_for_each_drv+0x8c/0xf0
[    7.122276]  __device_attach+0xa4/0x198 
[    7.126099]  device_initial_probe+0x1c/0x30
[    7.130269]  bus_probe_device+0xb4/0xc0
[    7.134093]  device_add+0x570/0x740
[    7.137570]  device_register+0x28/0x40 
[    7.141307]  i2c_new_client_device+0x19c/0x380
[    7.145740]  of_i2c_register_devices+0x120/0x1a0
[    7.150345]  i2c_register_adapter+0x204/0x670
[    7.154690]  i2c_add_adapter+0x80/0xe0 
[    7.158428]  ec_i2c_probe+0xe0/0x160
[    7.161991]  platform_probe+0x70/0xd0
[    7.165642]  really_probe+0xc4/0x2a8 
[    7.169207]  __driver_probe_device+0x80/0x140
[    7.173550]  driver_probe_device+0x44/0x120
[    7.177720]  __device_attach_driver+0xc0/0x108
[    7.182151]  bus_for_each_drv+0x8c/0xf0
[    7.185976]  __device_attach+0xa4/0x198
[    7.189799]  device_initial_probe+0x1c/0x30
[    7.193970]  bus_probe_device+0xb4/0xc0
[    7.197794]  device_add+0x570/0x740
[    7.201271]  of_device_add+0x5c/0x78
[    7.204836]  of_platform_device_create_pdata+0x98/0x138
[    7.210050]  of_platform_bus_create+0x15c/0x398
[    7.214569]  of_platform_populate+0x58/0x110
[    7.218827]  devm_of_platform_populate+0x60/0xd0
[    7.223432]  cros_ec_register+0x18c/0x370
[    7.227430]  cros_ec_spi_probe+0x17c/0x250
[    7.231514]  spi_probe+0x88/0xf8
[    7.234732]  really_probe+0xc4/0x2a8
[    7.238297]  __driver_probe_device+0x80/0x140
[    7.242641]  driver_probe_device+0x44/0x120
[    7.246812]  __driver_attach_async_helper+0x54/0xc8
[    7.251678]  async_run_entry_fn+0x40/0x160
[    7.255762]  process_one_work+0x18c/0x420
[    7.259762]  worker_thread+0x30c/0x418
[    7.263500]  kthread+0x128/0x138
[    7.266716]  ret_from_fork+0x10/0x20
[    7.270282] Code: b4000b47 aa0703e5 a9019e86 52800013 (f84d0ca0)
[    7.276362] ---[ end trace 0000000000000000 ]---
[    7.282971] Kernel panic - not syncing: Oops: Fatal exception

-- 
Thanks,
Sasha

