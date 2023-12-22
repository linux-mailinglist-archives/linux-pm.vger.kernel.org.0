Return-Path: <linux-pm+bounces-1543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E302281C341
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 04:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73375B2241D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 03:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A1ECA;
	Fri, 22 Dec 2023 03:01:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9AEB8
	for <linux-pm@vger.kernel.org>; Fri, 22 Dec 2023 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>
Subject: RE:  WARNING: at drivers/cpuidle/cpuidle.c:269
Thread-Topic: WARNING: at drivers/cpuidle/cpuidle.c:269
Thread-Index: AdoxiaVtCgx1PiOmQ5asG1t3SMumYgC+QLTQ
Date: Fri, 22 Dec 2023 03:01:04 +0000
Message-ID: <3f709048558d4c568b37b2948e05512d@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.55
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM

> -----Original Message-----
> From: Li,Rongqing
> Sent: Monday, December 18, 2023 4:13 PM
> To: linux-pm@vger.kernel.org
> Subject: WARNING: at drivers/cpuidle/cpuidle.c:269
>=20
> [  775.997365] ------------[ cut here ]------------ [  775.997962] defaul=
t_enter_idle
> leaked IRQ state [  775.997985] WARNING: CPU: 2 PID: 0 at
> drivers/cpuidle/cpuidle.c:269 cpuidle_enter_state+0x3bc/0x450 [  775.9994=
61]
> Modules linked in: nft_compat(E) nf_tables(E) libcrc32c(E) nfnetlink(E) i=
sofs(E)
> crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E=
)
> hid_generic(E) aesni_intel(E) crypto_simd(E) cryptd(E) input_leds(E) led_=
class(E)
> pcspkr(E) i2c_i801(E) i2c_smbus(E) usbhid(E) hid(E) i2c_core(E) virtio_ne=
t(E)
> net_failover(E) failover(E) sch_fq_codel(E) virtio_blk(E) atkbd(E) vivald=
i_fmap(E)
> crc32c_intel(E) serio_raw(E) sr_mod(E) cdrom(E) uhci_hcd(E) virtio_pci(E)=
 sg(E)
> virtio(E) virtio_pci_legacy_dev(E) ehci_pci(E) ehci_hcd(E)
> virtio_pci_modern_dev(E) virtio_ring(E)
> [  776.004677] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G            E
> 6.7.0-rc3 #21
> [  776.006896] RIP: 0010:cpuidle_enter_state+0x3bc/0x450
> [  776.007517] Code: 4a 71 43 ff e9 91 fd ff ff 80 3d a0 86 d7 00 00 75 1=
a 49 8b
> 74 24 50 48 c7 c7 2d 2c c8 84 c6 05 8b 86 d7 00 01 e8 44 3e 4d ff <0f> 0b=
 fa e9
> ce fc ff ff 8b 73 04 65 8b 05 ce 4a a6 7b 89 c0 48 0f [  776.009582] RSP:
> 0018:ffffb765000abe90 EFLAGS: 00010282 [  776.010217] RAX:
> 0000000000000000 RBX: ffffd764ffd00988 RCX: 0000000000000027
> [  776.011033] RDX: 0000000000a1810d RSI: ffffb765000abd78 RDI:
> ffff95c22fd204c8 [  776.011847] RBP: 0000000000000001 R08:
> 0000000000000000 R09: c0000000ffff7fff [  776.012660] R10:
> 0000000000000001 R11: ffffb765000abd18 R12: ffffffff85314bc0
> [  776.013483] R13: ffffffff85314b40 R14: 0000000000000001 R15:
> 0000000000000000 [  776.014304] FS:  0000000000000000(0000)
> GS:ffff95c22fd00000(0000) knlGS:0000000000000000 [  776.015286] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  776.015973] CR2:
> 00007f0e0260c1a0 CR3: 00000001087e0006 CR4: 0000000000770ef0
> [  776.016789] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 [  776.017606] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 [  776.018425] PKRU: 55555554
> [  776.018825] Call Trace:
> [  776.019200]  <TASK>
> [  776.019539]  ? __warn+0x85/0x140
> [  776.019995]  ? cpuidle_enter_state+0x3bc/0x450 [  776.020559]  ?
> report_bug+0xfc/0x1e0 [  776.021044]  ? console_unlock+0x51/0xe0
> [  776.021554]  ? handle_bug+0x3f/0x70 [  776.022032]  ?
> exc_invalid_op+0x17/0x70 [  776.022536]  ? asm_exc_invalid_op+0x1a/0x20
> [  776.023076]  ? cpuidle_enter_state+0x3bc/0x450 [  776.023641]
> cpuidle_enter+0x2d/0x40 [  776.024127]  do_idle+0x138/0x200
> [  776.024574]  cpu_startup_entry+0x2a/0x30 [  776.025091]
> start_secondary+0x119/0x140 [  776.025610]
> secondary_startup_64_no_verify+0x16b/0x16b
> [  776.026249]  </TASK>
> [  776.026594] ---[ end trace 0000000000000000 ]---
>=20
>=20
>=20
> cat /sys/devices/system/cpu/cpuidle/current_governor_ro
> haltpoll



Peter:

I see the below warning in VM with haltpoll driver, seem it is caused by th=
is commit


    cpuidle: Move IRQ state validation

    Make cpuidle_enter_state() consistent with the s2idle variant and
    verify ->enter() always returns with interrupts disabled.

default_enter_idle maybe enable irq as below

28 static int default_enter_idle(struct cpuidle_device *dev,
 29                   struct cpuidle_driver *drv, int index)
 30 {
 31     if (current_clr_polling_and_test()) {
 32         local_irq_enable();
 33         return index;
 34     }
 35     arch_cpu_idle();
 36     return index;
 37 }

Thanks=20
-Li

