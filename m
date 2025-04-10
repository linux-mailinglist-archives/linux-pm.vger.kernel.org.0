Return-Path: <linux-pm+bounces-25076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C00BA8396C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 08:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E36F16B17F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1DA1F0E4E;
	Thu, 10 Apr 2025 06:35:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEA1D5AC2;
	Thu, 10 Apr 2025 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266918; cv=none; b=uorFckpqsWSN+CmjTeYM342jHU7ua77mRZljZ4930waYGIYDQH+b4Y+HrGCf1af4NGNWmcsZrg+FtpHUxQvyYB4WDyYLTba1D9naxKF7AEH4or/Y5yjYYFV/0LBBwJwVv/LDSr9WZhKOl6ndWL9ims7PQIo+TlegjHb56iYv26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266918; c=relaxed/simple;
	bh=s+UgEkjr70qa18DaHCv1nDIO+jPnwnZxplP6MLd0E2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHF9wXma9IgOZnPzsEZn8gBXTqQBibxWqiu9k4HYy6oIpDbiMEXp+gSbHMhX4sw3b2hQPCyvbJ8SSeMhsSnPV7zlkEbUGNBPBu5qee3x4SqxCF3HVX94/zlw7UfbLratC/B6kBeDdPYw2TfWNXPFg66mC371Jg7pPnZhU0J3hIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af743.dynamic.kabel-deutschland.de [95.90.247.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3E89061E64783;
	Thu, 10 Apr 2025 08:34:25 +0200 (CEST)
Message-ID: <4107dda8-25fe-4f30-a0e6-906441f9b4c9@molgen.mpg.de>
Date: Thu, 10 Apr 2025 08:34:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel WARNING (RCU) with btnxpuart on TI AM62 platform
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Kale <neeraj.sanjaykale@nxp.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
References: <20250408083512.GA26035@francesco-nb>
 <24b28bda-e294-4680-bed5-c44efcb6c455@ti.com>
 <20250410062006.GA7506@francesco-nb>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250410062006.GA7506@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Marcel]

Dear Francesco,


Am 10.04.25 um 08:20 schrieb Francesco Dolcini:

> On Tue, Apr 08, 2025 at 09:15:26PM +0530, Vignesh Raghavendra wrote:
>> On 08/04/25 14:05, Francesco Dolcini wrote:
>>> I do have the following kernel warning with 6.15-rc1, on a TI AM62
>>> platform (arm64), single CPU core, using btnxpuart driver, any idea?
>>> PREEMPT_RT is enabled, if it matters.
>>>
>>> Either the issue is not systematic, or multi cores SoCs are not affected
>>> (no error on the exact same image on a dual nor on quad core TI AM62).
>>>
>>> [   23.139080] Voluntary context switch within RCU read-side critical section!
>>> [   23.139119] WARNING: CPU: 0 PID: 61 at /kernel/rcu/tree_plugin.h:332 rcu_note_context_switch+0x3c4/0x430
>>> [   23.139172] Modules linked in: uas onboard_usb_dev optee_rng dwc3 evdev btnxpuart spidev aes_ce_blk aes_ce_cipher ghash_ce gf128mul sha2_ce sha256_arm64 sha1_ce snd_soc_simple_card snd_soc_simple_card_utils optee spi_cadence_quadspi tee gpio_keys usb_conn_gpio display_connector roles dwc3_am62 mwifiex_sdio k3_j72xx_bandgap mwifiex rtc_ti_k3 cfg80211 tidss sa2ul sha512_generic snd_soc_davinci_mcasp authenc drm_display_helper snd_soc_ti_udma crypto_null snd_soc_ti_edma sha1_generic snd_soc_ti_sdma omap_hwspinlock lontium_lt8912b ina2xx snd_soc_wm8904 ti_ads1015 industrialio_triggered_buffer kfifo_buf lm75 tpm_tis_i2c tps65219_pwrbutton crc_ccitt tpm_tis_core tpm rng_core tc358768 m_can_platform pwm_tiehrpwm m_can spi_omap2_mcspi can_dev bluetooth ecdh_generic ecc rfkill libaes loop fuse ipv6 autofs4
>>> [   23.139459] CPU: 0 UID: 0 PID: 61 Comm: kworker/u5:0 Not tainted 6.15.0-rc1-0.0.0-devel #1 PREEMPT_RT
>>> [   23.139471] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
>>> [   23.139478] Workqueue: hci0 hci_power_off [bluetooth]
>>> [   23.139615] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   23.139625] pc : rcu_note_context_switch+0x3c4/0x430
>>> [   23.139647] lr : rcu_note_context_switch+0x3c4/0x430
>>> [   23.139658] sp : ffff8000819fb740
>>> [   23.139661] x29: ffff8000819fb740 x28: 0000000000000000 x27: ffff0000079d2010
>>> [   23.139673] x26: ffff0000011e7810 x25: ffff000001c2c200 x24: 0000000000000000
>>> [   23.139688] x23: 0000000000000000 x22: ffff000001c2c200 x21: ffff000001c2c200
>>> [   23.139700] x20: ffff800081083ec0 x19: ffff00001da9fec0 x18: fffffffffffe7e78
>>> [   23.139712] x17: ffff7fff9ca1c000 x16: ffff800080000000 x15: ffff00001da9f8c0
>>> [   23.139726] x14: fffffffffffc7e77 x13: 216e6f6974636573 x12: 206c616369746972
>>> [   23.139738] x11: 6320656469732d64 x10: 6165722055435220 x9 : 206e696874697720
>>> [   23.139750] x8 : ffff80008113f040 x7 : ffff8000819fb4e0 x6 : 000000000000000c
>>> [   23.139761] x5 : ffff00001da95888 x4 : 0000000000000000 x3 : 0000000000000027
>>> [   23.139775] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000001c2c200
>>> [   23.139788] Call trace:
>>> [   23.139793]  rcu_note_context_switch+0x3c4/0x430 (P)
>>> [   23.139813]  __schedule+0xa0/0x7dc
>>> [   23.139830]  schedule+0x34/0x11c
>>> [   23.139841]  schedule_timeout+0x8c/0x110
>>> [   23.139861]  wait_for_completion_timeout+0x78/0x14c
>>> [   23.139873]  ti_sci_set_device_state+0x120/0x1fc
>>> [   23.139886]  ti_sci_cmd_get_device_exclusive+0x18/0x30
>>> [   23.139899]  ti_sci_pd_power_on+0x28/0x54
>>> [   23.139916]  _genpd_power_on+0x98/0x188
>>> [   23.139927]  genpd_power_on+0xa8/0x168
>>> [   23.139940]  genpd_runtime_resume+0xc0/0x298
>>> [   23.139957]  __rpm_callback+0x48/0x1a4
>>> [   23.139974]  rpm_callback+0x74/0x80
>>> [   23.139987]  rpm_resume+0x3b0/0x698
>>> [   23.140000]  __pm_runtime_resume+0x48/0x88
>>> [   23.140012]  omap8250_set_mctrl+0x2c/0xbc
>>> [   23.140030]  serial8250_set_mctrl+0x20/0x40
>>> [   23.140046]  uart_update_mctrl+0x80/0x110
>>
>> I think issue is that uart_update_mctrl() holds a spinlock:
>>
>> 	uart_port_lock_irqsave(port, &flags);
>>
>> and then omap8250_set_mctrl() calls pm_runtime APIs which on K3 SoC
>> needs to talk to a Firmware to enable pd. This IPC call is a sleeping
>> call leading to scheduling with IRQs disabled.
>>
>> I guess this is what RT linux is complaining? I dont have a solution
>> though, maybe serdev delays pm_runtime_put till the port is closed?
> 
> Our CI reproduced what looks like the same issue also on current
> torvalds/master (6.15-rc1+) branch, without PREEMPT_RT.
> 
> The call trace seems just the same, but attaching it here for
> completeness.
> 
> 
> [   20.931923] BUG: scheduling while atomic: kworker/u5:0/42/0x00000002
> [   20.938429] Modules linked in: sd_mod uas onboard_usb_dev btnxpuart optee_rng dwc3 evdev spidev aes_ce_blk aes_ce_cipher ghash_ce gf128mul sha2_ce sha256_arm64 sha1_ce snd_soc_simple_card snd_soc_simple_card_utils mwifiex_sdio mwifiex display_connector spi_cadence_quadspi optee usb_conn_gpio tee gpio_keys roles k3_j72xx_bandgap cfg80211 rtc_ti_k3 dwc3_am62 bluetooth ecdh_generic ecc sa2ul sha512_generic rfkill authenc tidss crypto_null libaes snd_soc_davinci_mcasp sha1_generic drm_display_helper snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma omap_hwspinlock lontium_lt8912b ina2xx ti_ads1015 snd_soc_wm8904 industrialio_triggered_buffer kfifo_buf lm75 tpm_tis_i2c crc_ccitt tps65219_pwrbutton tpm_tis_core tpm m_can_platform m_can rng_core tc358768 can_dev pwm_tiehrpwm spi_omap2_mcspi loop fuse ipv6 autofs4
> [   20.938865] CPU: 0 UID: 0 PID: 42 Comm: kworker/u5:0 Not tainted 6.15.0-rc1-0.0.0-devel #1 PREEMPT
> [   20.938878] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
> [   20.938895] Workqueue: hci0 hci_power_off [bluetooth]
> [   20.939032] Call trace:
> [   20.939037]  show_stack+0x2c/0x84 (C)
> [   20.939063]  dump_stack_lvl+0x60/0x80
> [   20.939084]  dump_stack+0x18/0x24
> [   20.939096]  __schedule_bug+0x54/0x70
> [   20.939116]  __schedule+0x628/0x7dc
> [   20.939129]  schedule+0x34/0x11c
> [   20.939138]  rpm_resume+0x17c/0x6a0
> [   20.939155]  __pm_runtime_resume+0x50/0x9c
> [   20.939168]  omap8250_set_mctrl+0x2c/0xc0
> [   20.939183]  serial8250_set_mctrl+0x20/0x40
> [   20.939193]  uart_update_mctrl+0x88/0x11c
> [   20.939215]  uart_dtr_rts+0x104/0x120
> [   20.939226]  tty_port_shutdown+0xd4/0xdc
> [   20.939236]  tty_port_close+0x40/0xc0
> [   20.939248]  uart_close+0x34/0x9c
> [   20.939259]  ttyport_close+0x50/0xa0
> [   20.939272]  serdev_device_close+0x40/0x5c
> [   20.939283]  btnxpuart_close+0x1c/0xa0 [btnxpuart]
> [   20.939309]  hci_dev_close_sync+0x304/0x7cc [bluetooth]
> [   20.939376]  hci_dev_do_close+0x2c/0x70 [bluetooth]
> [   20.939441]  hci_power_off+0x20/0x64 [bluetooth]
> [   20.939508]  process_one_work+0x148/0x290
> [   20.939528]  worker_thread+0x2c8/0x3e4
> [   20.939541]  kthread+0x12c/0x204
> [   20.939554]  ret_from_fork+0x10/0x20
> [   20.943567] BUG: scheduling while atomic: kworker/u5:0/42/0x00000000
> [   20.950126] Modules linked in: sd_mod uas onboard_usb_dev btnxpuart optee_rng dwc3 evdev spidev aes_ce_blk aes_ce_cipher ghash_ce gf128mul sha2_ce sha256_arm64 sha1_ce snd_soc_simple_card snd_soc_simple_card_utils mwifiex_sdio mwifiex display_connector spi_cadence_quadspi optee usb_conn_gpio tee gpio_keys roles k3_j72xx_bandgap cfg80211 rtc_ti_k3 dwc3_am62 bluetooth ecdh_generic ecc sa2ul sha512_generic rfkill authenc tidss crypto_null libaes snd_soc_davinci_mcasp sha1_generic drm_display_helper snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma omap_hwspinlock lontium_lt8912b ina2xx ti_ads1015 snd_soc_wm8904 industrialio_triggered_buffer kfifo_buf lm75 tpm_tis_i2c crc_ccitt tps65219_pwrbutton tpm_tis_core tpm m_can_platform m_can rng_core tc358768 can_dev pwm_tiehrpwm spi_omap2_mcspi loop fuse ipv6 autofs4
> [   20.950550] CPU: 0 UID: 0 PID: 42 Comm: kworker/u5:0 Tainted: G        W           6.15.0-rc1-0.0.0-devel #1 PREEMPT
> [   20.950566] Tainted: [W]=WARN
> [   20.950570] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
> [   20.950584] Workqueue: hci0 hci_power_off [bluetooth]
> [   20.950721] Call trace:
> [   20.950726]  show_stack+0x2c/0x84 (C)
> [   20.950747]  dump_stack_lvl+0x60/0x80
> [   20.950771]  dump_stack+0x18/0x24
> [   20.950783]  __schedule_bug+0x54/0x70
> [   20.950798]  __schedule+0x628/0x7dc
> [   20.950815]  schedule+0x34/0x11c
> [   20.950824]  schedule_timeout+0xd4/0x110
> [   20.950838]  wait_for_completion+0x78/0x140
> [   20.950853]  __flush_work+0x250/0x340
> [   20.950868]  flush_work+0x14/0x20
> [   20.950879]  omap_8250_shutdown+0x2c/0x1a4
> [   20.950903]  serial8250_shutdown+0x18/0x40
> [   20.950913]  uart_port_shutdown+0x40/0x58
> [   20.950926]  uart_tty_port_shutdown+0x5c/0x178
> [   20.950940]  tty_port_shutdown+0x84/0xdc
> [   20.950950]  tty_port_close+0x40/0xc0
> [   20.950958]  uart_close+0x34/0x9c
> [   20.950969]  ttyport_close+0x50/0xa0
> [   20.950990]  serdev_device_close+0x40/0x5c
> [   20.951001]  btnxpuart_close+0x1c/0xa0 [btnxpuart]
> [   20.951017]  hci_dev_close_sync+0x304/0x7cc [bluetooth]
> [   20.951082]  hci_dev_do_close+0x2c/0x70 [bluetooth]
> [   20.951149]  hci_power_off+0x20/0x64 [bluetooth]
> [   20.951214]  process_one_work+0x148/0x290
> [   20.951227]  worker_thread+0x2c8/0x3e4
> [   20.951242]  kthread+0x12c/0x204
> [   20.951258]  ret_from_fork+0x10/0x20

CVE-2024-26959 [1] has the same trace, and supposedly was fixed by 
Marcel’s commit 664130c0b030 (Bluetooth: btnxpuart: Fix btnxpuart_close) 
present since v6.9-rc1, that is also signed off by you.


Kind regards,

Paul


[1]: https://nvd.nist.gov/vuln/detail/cve-2024-26959
[2]: 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=664130c0b0309b360bc5bdd40a30604a9387bde8

