Return-Path: <linux-pm+bounces-24930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A5A7F97E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE1F3BB9D5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24B264FAA;
	Tue,  8 Apr 2025 09:27:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56819264F9F;
	Tue,  8 Apr 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104468; cv=none; b=PKLOSt/hoz2hR6dAPvmCJZocjwM4tnCjzNSC7aknGEUa0lqgWhVLPWSOjW10a92rk4KYpH4xPQP7oKS6MbjmtKEyWt3uyQrmxhsmbebPGCbx3qgFUAB/v1LbBjqHe6MrTzo6qkcCRLoyIxJbRoTx1DYzFjqbpE60CnAk96qyIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104468; c=relaxed/simple;
	bh=aMbRfljk3VL783Mt6idyLGub6ZrKA5QxLM0kTwp3sf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VixKrsH011ScrPXYbbs/7+TDmWYI0hLNhX1C0CXI7jttt/9e8w9FgIxl+/z+r9w4R9IzKOOsQqPIq22loaDq2QyC350CAyrWmHZPx3Yk7xsa3ez0l/mhN9SgUj5CBuqb7YZAk+FoBs9a7jM21If5tf8JgJp2WP9ato+PVejZmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AD33E61E647BB;
	Tue, 08 Apr 2025 11:26:48 +0200 (CEST)
Message-ID: <a8e7171b-d859-4611-9681-e4c614f29d64@molgen.mpg.de>
Date: Tue, 8 Apr 2025 11:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel WARNING (RCU) with btnxpuart on TI AM62 platform
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Kale <neeraj.sanjaykale@nxp.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, regressions@lists.linux.dev
References: <20250408083512.GA26035@francesco-nb>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250408083512.GA26035@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +regressions@]

#regzbot introduced: v6.14..v6.15-rc1


Dear Francesco,


Thank you for your report.

Am 08.04.25 um 10:35 schrieb Francesco Dolcini:

> I do have the following kernel warning with 6.15-rc1, on a TI AM62
> platform (arm64), single CPU core, using btnxpuart driver, any idea?
> PREEMPT_RT is enabled, if it matters.
> 
> Either the issue is not systematic, or multi cores SoCs are not affected
> (no error on the exact same image on a dual nor on quad core TI AM62).
> 
> 
> [   23.139080] Voluntary context switch within RCU read-side critical section!
> [   23.139119] WARNING: CPU: 0 PID: 61 at /kernel/rcu/tree_plugin.h:332 rcu_note_context_switch+0x3c4/0x430
> [   23.139172] Modules linked in: uas onboard_usb_dev optee_rng dwc3 evdev btnxpuart spidev aes_ce_blk aes_ce_cipher ghash_ce gf128mul sha2_ce sha256_arm64 sha1_ce snd_soc_simple_card snd_soc_simple_card_utils optee spi_cadence_quadspi tee gpio_keys usb_conn_gpio display_connector roles dwc3_am62 mwifiex_sdio k3_j72xx_bandgap mwifiex rtc_ti_k3 cfg80211 tidss sa2ul sha512_generic snd_soc_davinci_mcasp authenc drm_display_helper snd_soc_ti_udma crypto_null snd_soc_ti_edma sha1_generic snd_soc_ti_sdma omap_hwspinlock lontium_lt8912b ina2xx snd_soc_wm8904 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 tpm_tis_i2c tps65219_pwrbutton crc_ccitt tpm_tis_core tpm rng_core tc358768 m_can_platform pwm_tiehrpwm m_can spi_omap2_mcspi can_dev bluetooth ecdh_generic ecc rfkill libaes loop fuse ipv6 autofs4
> [   23.139459] CPU: 0 UID: 0 PID: 61 Comm: kworker/u5:0 Not tainted 6.15.0-rc1-0.0.0-devel #1 PREEMPT_RT
> [   23.139471] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
> [   23.139478] Workqueue: hci0 hci_power_off [bluetooth]
> [   23.139615] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   23.139625] pc : rcu_note_context_switch+0x3c4/0x430
> [   23.139647] lr : rcu_note_context_switch+0x3c4/0x430
> [   23.139658] sp : ffff8000819fb740
> [   23.139661] x29: ffff8000819fb740 x28: 0000000000000000 x27: ffff0000079d2010
> [   23.139673] x26: ffff0000011e7810 x25: ffff000001c2c200 x24: 0000000000000000
> [   23.139688] x23: 0000000000000000 x22: ffff000001c2c200 x21: ffff000001c2c200
> [   23.139700] x20: ffff800081083ec0 x19: ffff00001da9fec0 x18: fffffffffffe7e78
> [   23.139712] x17: ffff7fff9ca1c000 x16: ffff800080000000 x15: ffff00001da9f8c0
> [   23.139726] x14: fffffffffffc7e77 x13: 216e6f6974636573 x12: 206c616369746972
> [   23.139738] x11: 6320656469732d64 x10: 6165722055435220 x9 : 206e696874697720
> [   23.139750] x8 : ffff80008113f040 x7 : ffff8000819fb4e0 x6 : 000000000000000c
> [   23.139761] x5 : ffff00001da95888 x4 : 0000000000000000 x3 : 0000000000000027
> [   23.139775] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000001c2c200
> [   23.139788] Call trace:
> [   23.139793]  rcu_note_context_switch+0x3c4/0x430 (P)
> [   23.139813]  __schedule+0xa0/0x7dc
> [   23.139830]  schedule+0x34/0x11c
> [   23.139841]  schedule_timeout+0x8c/0x110
> [   23.139861]  wait_for_completion_timeout+0x78/0x14c
> [   23.139873]  ti_sci_set_device_state+0x120/0x1fc
> [   23.139886]  ti_sci_cmd_get_device_exclusive+0x18/0x30
> [   23.139899]  ti_sci_pd_power_on+0x28/0x54
> [   23.139916]  _genpd_power_on+0x98/0x188
> [   23.139927]  genpd_power_on+0xa8/0x168
> [   23.139940]  genpd_runtime_resume+0xc0/0x298
> [   23.139957]  __rpm_callback+0x48/0x1a4
> [   23.139974]  rpm_callback+0x74/0x80
> [   23.139987]  rpm_resume+0x3b0/0x698
> [   23.140000]  __pm_runtime_resume+0x48/0x88
> [   23.140012]  omap8250_set_mctrl+0x2c/0xbc
> [   23.140030]  serial8250_set_mctrl+0x20/0x40
> [   23.140046]  uart_update_mctrl+0x80/0x110
> [   23.140062]  uart_dtr_rts+0x104/0x118
> [   23.140079]  tty_port_shutdown+0xd4/0xe0
> [   23.140092]  tty_port_close+0x3c/0xb8
> [   23.140103]  uart_close+0x34/0x98
> [   23.140116]  ttyport_close+0x50/0xa0
> [   23.140137]  serdev_device_close+0x40/0x5c
> [   23.140150]  btnxpuart_close+0x1c/0xa0 [btnxpuart]
> [   23.140175]  hci_dev_close_sync+0x304/0x7cc [bluetooth]
> [   23.140243]  hci_dev_do_close+0x2c/0x70 [bluetooth]
> [   23.140309]  hci_power_off+0x20/0x64 [bluetooth]
> [   23.140379]  process_one_work+0x148/0x284
> [   23.140403]  worker_thread+0x2c8/0x3dc
> [   23.140414]  kthread+0x12c/0x208
> [   23.140426]  ret_from_fork+0x10/0x20

As I understood, that it’s a regression, and you can reproduce it, would 
it be possible, that you bisected the issue?


Kind regards,

Paul

