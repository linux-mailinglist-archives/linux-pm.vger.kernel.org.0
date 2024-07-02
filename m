Return-Path: <linux-pm+bounces-10388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807189249E9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3658D1F22ED6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC320127D;
	Tue,  2 Jul 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NIrbnihi"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1791148FF0;
	Tue,  2 Jul 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955536; cv=none; b=OW/8v4bhqxBlWd8OOBa6RVVPP2zd/sjHbRGs8/+I+5vhriTT+bEfl0nrHTzNZnT8Nk1hxBxbkkgpC2ALigWSfrXWmGJ7jTnUfh+Bj2OX/ESuvhkARe/iBbFJhzkLToHRr3DFQBfTPO5+FzzsbuUqY+3uadIbpOc0VeQgC2ncVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955536; c=relaxed/simple;
	bh=kxOa+jj5icSx1TV8u2CbRScO5ZwrgRSKLg5LVgqTcd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NzD6cliAj8qvdXCOgV2m1WViVu0P4Odp4+jJ3/QW6Gpk/5HPuEw3xXlHVbpzofvZr/5xocq5BZGlrwxBKD/FCAPDmre9P46oC9waItDHnNQoyouoRe4mvGZoTZ0UR4PReG+o1UuECA6lAvF02irZm78scPxdmEGxA+KRhMBBe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NIrbnihi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719955533;
	bh=kxOa+jj5icSx1TV8u2CbRScO5ZwrgRSKLg5LVgqTcd4=;
	h=From:Date:Subject:To:Cc:From;
	b=NIrbnihinxT1gB6gnvSxy9dSyWS1U4oNykI4qNhHHbhc6wrMt+E4QBlLB2tRSGaRV
	 QKJxRJdPqZq1Cl9C8lIupmKiOrkOAMAgJAu6iHzSlQNOKnkc4DKeIXbiKwj4QWOyOK
	 0IokuOqs384mSikorJS4Fe5DE65g8MUgruHm72sNFBJiw2cv8mbz0SYAGx60cf3Hzo
	 D3qUYWQp8UOvdaTkuFFGf2X9txI6MgrByQVG0AkcDrgUUkHkmbEuo2obbBfCWTtmwY
	 AV/eef5DHJec8GYKHS9fSszxvSt3WNaGX2SKz1N2uGdQ0LK8e+4cB8JWdXWedPBu6x
	 iTaTOeRcNiGqg==
Received: from [192.168.1.203] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0ED6037811EB;
	Tue,  2 Jul 2024 21:25:30 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 02 Jul 2024 17:24:56 -0400
Subject: [PATCH] thermal: gov_power_allocator: Return early in manage if
 trip_max is null
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
X-B4-Tracking: v=1; b=H4sIACdwhGYC/x3MwQqDMAwA0F+RnBfoiqD4K2OHLEYN1LakbhPEf
 7d4fJd3QBFTKTA0B5j8tGiKFc9HA7xQnAV1rAbvfOs65zGnvxhSCIlpS4bxGwJuphlX2vHDved
 +7ISEoR7ZZNL9/l/v87wAJiIUDG8AAAA=
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Nikita Travkin <nikita@trvn.ru>
Cc: kernel@collabora.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Commit da781936e7c3 ("thermal: gov_power_allocator: Allow binding
without trip points") allowed the governor to bind even when trip_max
is null. This allows a null pointer dereference to happen in the manage
callback. Add an early return to prevent it, since the governor is
expected to not do anything in this case.

Fixes: da781936e7c3 ("thermal: gov_power_allocator: Allow binding without trip points")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
This issue was noticed by KernelCI during a boot test on the
mt8195-cherry-tomato-r2 platform with the config in [1]. The stack trace
is attached below.

[1] http://0x0.st/XaON.txt

[    4.015786] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    4.015791] Mem abort info:
[    4.015793]   ESR = 0x0000000096000004
[    4.015796]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.015799]   SET = 0, FnV = 0
[    4.015802]   EA = 0, S1PTW = 0
[    4.015804]   FSC = 0x04: level 0 translation fault
[    4.015807] Data abort info:
[    4.015809]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    4.015811]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    4.015814]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    4.015818] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109809000
[    4.015821] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[    4.015835] Modules linked in: mt8195_mt6359(+) mt6577_auxadc snd_soc_mt8195_afe mtk_scp_ipi snd_sof_utils mtk_wdt(+)
[    4.015852] CPU: 2 PID: 13 Comm: kworker/u32:1 Not tainted 6.10.0-rc6 #1 c5d519ae8e7fec6bbe67cb8c50bfebcb89dfa54e
[    4.015859] Hardware name: Acer Tomato (rev2) board (DT)
[    4.015862] Workqueue: events_unbound deferred_probe_work_func
[    4.015875] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.015880] pc : power_allocator_manage+0x110/0x6a0
[    4.015888] lr : __thermal_zone_device_update+0x1dc/0x400
[    4.015893] sp : ffff8000800eb800
[    4.015895] x29: ffff8000800eb810 x28: 0000000000000001 x27: 0000000000000001
[    4.015903] x26: aaaaaaaaaaaaaaab x25: ffff07a0461c15a0 x24: ffffb58530ca67c0
[    4.015911] x23: 0000000000000000 x22: ffff07a04098fcc0 x21: ffffb58532eec848
[    4.015918] x20: ffff8000800eb920 x19: ffff07a0461c1000 x18: 0000000000000b4b
[    4.015926] x17: 5359534255530031 x16: ffffb585310352e4 x15: 0000000000000020
[    4.015933] x14: 0000000000000000 x13: ffffffff00000000 x12: 0000000000000040
[    4.015940] x11: 0101010101010101 x10: ffffffffffffffff x9 : ffffb58530ca8d78
[    4.015948] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000000001388
[    4.015955] x5 : 0000000000000000 x4 : 0000000000000384 x3 : 0000000000000000
[    4.015962] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    4.015970] Call trace:
[    4.015972]  power_allocator_manage+0x110/0x6a0
[    4.015978]  __thermal_zone_device_update+0x1dc/0x400
[    4.015983]  thermal_zone_device_set_mode+0x7c/0xa0
[    4.015987]  thermal_zone_device_enable+0x1c/0x28
[    4.015991]  thermal_of_zone_register+0x43c/0x498
[    4.015996]  devm_thermal_of_zone_register+0x6c/0xb8
[    4.016001]  gadc_thermal_probe+0x140/0x214
[    4.016007]  platform_probe+0x70/0xc4
[    4.016012]  really_probe+0x140/0x270
[    4.016018]  __driver_probe_device+0xfc/0x114
[    4.016024]  driver_probe_device+0x44/0x100
[    4.016029]  __device_attach_driver+0x64/0xdc
[    4.016035]  bus_for_each_drv+0xb4/0xdc
[    4.016041]  __device_attach+0xdc/0x16c
[    4.016046]  device_initial_probe+0x1c/0x28
[    4.016052]  bus_probe_device+0x44/0xac
[    4.016057]  deferred_probe_work_func+0xb0/0xc4
[    4.016063]  process_scheduled_works+0x114/0x330
[    4.016070]  worker_thread+0x1c0/0x20c
[    4.016076]  kthread+0xf8/0x108
[    4.016081]  ret_from_fork+0x10/0x20
[    4.016090] Code: d1030294 17ffffdd f94012c0 f9401ed7 (b9400000)
[    4.016095] ---[ end trace 0000000000000000 ]---
---
 drivers/thermal/gov_power_allocator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 45f04a25255a..1b2345a697c5 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -759,6 +759,9 @@ static void power_allocator_manage(struct thermal_zone_device *tz)
 		return;
 	}
 
+	if (!params->trip_max)
+		return;
+
 	allocate_power(tz, params->trip_max->temperature);
 	params->update_cdevs = true;
 }

---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240702-power-allocator-null-trip-max-bc82c8d7eaec

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


