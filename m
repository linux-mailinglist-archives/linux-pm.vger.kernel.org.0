Return-Path: <linux-pm+bounces-24928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00730A7F7F9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3481898EF4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BF826158C;
	Tue,  8 Apr 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OgsHMGm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818020B7EC;
	Tue,  8 Apr 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101322; cv=none; b=LPaBnutsbihb1eA3GsKB9N+83qHY4ttCQDM+7+nDUekjnPelmR4My1vxebUIUx4+IYp3LxGe7u0IzFyi9IoEvDz6GVB8y5b3YZ/Dh+TXmgwwULYPEzurLZF9NQnTC+BbE0+m2SPKzfV8ecf5t5a6CXkftTY/5GpQidThg7d+pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101322; c=relaxed/simple;
	bh=KzjoqOqYDCXtxlc3Hol6YOIfBy2OmCIPyYdnm6eJh8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fgFDEah70s85jWtYNDw5KHMAeKQo1KyB1iGX+dFdjIr3GgA877hMJlvmgxzNtFZuzrWa0ExvHqhLxSCrf2OxYH/i1uWloPJc97S+luOvlLeCxG8ofYagGFhkZk0bVKfJy9uRqbqfmwBSp8YRnRS30soTAxHRuEFWCEjngADmDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OgsHMGm2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0C34C1F91A;
	Tue,  8 Apr 2025 10:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744101316;
	bh=RMIaEj3zohUGYvvm32lDbkghJh7svLhWp2HrTir4CEQ=; h=From:To:Subject;
	b=OgsHMGm2+PdrrEV5mCfAE5oP8QO9XF80IvOK/cePrdbUc1u7QirAzxIElhvqqSurv
	 xgjRl6LWAnMuBoGM445fM1P5mISbMmP8TE2tzBX0lyV1GiZ8SL5KdDkClLXCc37drb
	 x4PJ34ty2EArVKWLt4wU53U7kidEhueahDsrNkBrFdYRIla3V6IxzyHRR6ak4yIF9f
	 VWx/ZqKh7T6nySZZruwG4thmNiaWTTJpChd3MPoQ02oUURwQD52N6iVSJv/pck16Ku
	 ULblTiDOAdwF5gcIf1H/nnRQ6FLO1TQEddIP8hkv+QFeS7kRHPhKwj3ECF4f0AsiIY
	 6LQ5VtWHAmIGw==
Date: Tue, 8 Apr 2025 10:35:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Kernel WARNING (RCU) with btnxpuart on TI AM62 platform
Message-ID: <20250408083512.GA26035@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I do have the following kernel warning with 6.15-rc1, on a TI AM62
platform (arm64), single CPU core, using btnxpuart driver, any idea?
PREEMPT_RT is enabled, if it matters.

Either the issue is not systematic, or multi cores SoCs are not affected
(no error on the exact same image on a dual nor on quad core TI AM62).


[   23.139080] Voluntary context switch within RCU read-side critical section!
[   23.139119] WARNING: CPU: 0 PID: 61 at /kernel/rcu/tree_plugin.h:332 rcu_note_context_switch+0x3c4/0x430
[   23.139172] Modules linked in: uas onboard_usb_dev optee_rng dwc3 evdev btnxpuart spidev aes_ce_blk aes_ce_cipher ghash_ce gf128mul sha2_ce sha256_arm64 sha1_ce snd_soc_simple_card snd_soc_simple_card_utils optee spi_cadence_quadspi tee gpio_keys usb_conn_gpio display_connector roles dwc3_am62 mwifiex_sdio k3_j72xx_bandgap mwifiex rtc_ti_k3 cfg80211 tidss sa2ul sha512_generic snd_soc_davinci_mcasp authenc drm_display_helper snd_soc_ti_udma crypto_null snd_soc_ti_edma sha1_generic snd_soc_ti_sdma omap_hwspinlock lontium_lt8912b ina2xx snd_soc_wm8904 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 tpm_tis_i2c tps65219_pwrbutton crc_ccitt tpm_tis_core tpm rng_core tc358768 m_can_platform pwm_tiehrpwm m_can spi_omap2_mcspi can_dev bluetooth ecdh_generic ecc rfkill libaes loop fuse ipv6 autofs4
[   23.139459] CPU: 0 UID: 0 PID: 61 Comm: kworker/u5:0 Not tainted 6.15.0-rc1-0.0.0-devel #1 PREEMPT_RT
[   23.139471] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
[   23.139478] Workqueue: hci0 hci_power_off [bluetooth]
[   23.139615] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   23.139625] pc : rcu_note_context_switch+0x3c4/0x430
[   23.139647] lr : rcu_note_context_switch+0x3c4/0x430
[   23.139658] sp : ffff8000819fb740
[   23.139661] x29: ffff8000819fb740 x28: 0000000000000000 x27: ffff0000079d2010
[   23.139673] x26: ffff0000011e7810 x25: ffff000001c2c200 x24: 0000000000000000
[   23.139688] x23: 0000000000000000 x22: ffff000001c2c200 x21: ffff000001c2c200
[   23.139700] x20: ffff800081083ec0 x19: ffff00001da9fec0 x18: fffffffffffe7e78
[   23.139712] x17: ffff7fff9ca1c000 x16: ffff800080000000 x15: ffff00001da9f8c0
[   23.139726] x14: fffffffffffc7e77 x13: 216e6f6974636573 x12: 206c616369746972
[   23.139738] x11: 6320656469732d64 x10: 6165722055435220 x9 : 206e696874697720
[   23.139750] x8 : ffff80008113f040 x7 : ffff8000819fb4e0 x6 : 000000000000000c
[   23.139761] x5 : ffff00001da95888 x4 : 0000000000000000 x3 : 0000000000000027
[   23.139775] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000001c2c200
[   23.139788] Call trace:
[   23.139793]  rcu_note_context_switch+0x3c4/0x430 (P)
[   23.139813]  __schedule+0xa0/0x7dc
[   23.139830]  schedule+0x34/0x11c
[   23.139841]  schedule_timeout+0x8c/0x110
[   23.139861]  wait_for_completion_timeout+0x78/0x14c
[   23.139873]  ti_sci_set_device_state+0x120/0x1fc
[   23.139886]  ti_sci_cmd_get_device_exclusive+0x18/0x30
[   23.139899]  ti_sci_pd_power_on+0x28/0x54
[   23.139916]  _genpd_power_on+0x98/0x188
[   23.139927]  genpd_power_on+0xa8/0x168
[   23.139940]  genpd_runtime_resume+0xc0/0x298
[   23.139957]  __rpm_callback+0x48/0x1a4
[   23.139974]  rpm_callback+0x74/0x80
[   23.139987]  rpm_resume+0x3b0/0x698
[   23.140000]  __pm_runtime_resume+0x48/0x88
[   23.140012]  omap8250_set_mctrl+0x2c/0xbc
[   23.140030]  serial8250_set_mctrl+0x20/0x40
[   23.140046]  uart_update_mctrl+0x80/0x110
[   23.140062]  uart_dtr_rts+0x104/0x118
[   23.140079]  tty_port_shutdown+0xd4/0xe0
[   23.140092]  tty_port_close+0x3c/0xb8
[   23.140103]  uart_close+0x34/0x98
[   23.140116]  ttyport_close+0x50/0xa0
[   23.140137]  serdev_device_close+0x40/0x5c
[   23.140150]  btnxpuart_close+0x1c/0xa0 [btnxpuart]
[   23.140175]  hci_dev_close_sync+0x304/0x7cc [bluetooth]
[   23.140243]  hci_dev_do_close+0x2c/0x70 [bluetooth]
[   23.140309]  hci_power_off+0x20/0x64 [bluetooth]
[   23.140379]  process_one_work+0x148/0x284
[   23.140403]  worker_thread+0x2c8/0x3dc
[   23.140414]  kthread+0x12c/0x208
[   23.140426]  ret_from_fork+0x10/0x20


Francesco


