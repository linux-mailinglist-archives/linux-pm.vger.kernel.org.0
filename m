Return-Path: <linux-pm+bounces-14785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E08986E7A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D6281FDA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16EC18B478;
	Thu, 26 Sep 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fcqtXLfU"
X-Original-To: linux-pm@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB1135A53;
	Thu, 26 Sep 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337858; cv=none; b=sanFMgEw+0Kwa2+ABS/lWu5qHnQcc6xgpyASaMAVjtLFcptGkmPdgiSvtFUZQNUNeCvFN3O2Ylz/GqZvLHmxdb4gtQD55VLmADuOEMKOw2LvQknJoHRuWvacNH9Ewuq867LTRzaz3BivWGTMiiiszK6jNAIxg5ZMwagwdiTVPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337858; c=relaxed/simple;
	bh=Ohle+mSw6OKgmkTexCka+g0/+2Xqg7/h2dZCBBh3Xck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7eX+VnuDAqxBRw1MubW7OohEuH1bt0I9HCpVDXFkrkyAs/tFBzlpfSYzRI25QDkXFCy+Ij6N4qdOzL1M3DymjPvPeMP6fWAJjk1PlpwAeUQEQnzC+1lP6DxjYsVa55rzs9A0bgsKXvmAqE4GWleFBelA7v578BC9Xw6a32Df8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fcqtXLfU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description;
	bh=KZQEtEFqUVCYlKWgRmtdxxygl4+pC7dy1IIxMbe5cg0=; b=fcqtXLfUs9b0sULv/yGdtMPUAG
	C9xD76hz3naN3LSTALxxk4w4BNVXi5kRrF2VSnJGc4xMzQFEVr3A4zHlg3eRRts5wNy5LCIqdgAHK
	+u/sCaAQ7dVJToa3UQcd5kXR6Yu9uw3uZ+I6HBCmdHK5DKdOx00yi+SQ55nIFeHRqPmKR6xDMgKbW
	/0JA35CRO+2UsrXtE59d/992zfbKEcVd52QdBVvgksGjqhTrl2/ECVnXlSC9YGv1SC1TnjxhuGxli
	7eyIvl1dxLWKehKye7NVE/Fd5iEesYH2O5GN+sBPTBv0DQkBUQxYU+JfgO11r9/t0Y5decbrbD6K4
	6Wp9in8g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <ukleinek@debian.org>)
	id 1stjEr-004i5t-8z; Thu, 26 Sep 2024 07:48:37 +0000
Message-ID: <10a1def7-1abc-4455-b73b-c324a9e0c0dd@debian.org>
Date: Thu, 26 Sep 2024 09:48:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
To: =?UTF-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paHKQ==?= <atzlinux@sina.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 1076483@bugs.debian.org
Cc: linux-pm@vger.kernel.org, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, linux-rt-users@vger.kernel.org
References: <20240919081121.10784-2-ukleinek@debian.org>
 <26829a6d-671c-45a4-bef4-4172f4f11615@sina.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>
In-Reply-To: <26829a6d-671c-45a4-bef4-4172f4f11615@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: ukleinek

Hello,

On 9/23/24 03:53, xiao sheng wen(肖盛文) wrote:
> I apply this patch on Debian kernel 6.11-1~exp1 (2024-09-19) source code.
> 
> uname -a
> Linux atzlinux-ce 6.11-rt-amd64 #1 SMP PREEMPT_RT atzlinux 6.11-1~exp1 
> (2024-09-19) x86_64 GNU/Linux
> 
> I get the following errors in dmesg:
> 
> [    7.273690] ucsi_acpi USBC000:00: possible UCSI driver bug 2
> [    7.451822] ucsi_acpi USBC000:00: error -EINVAL: PPM init failed
> [    7.537749] ------------[ cut here ]------------
> [    7.537753] WARNING: CPU: 12 PID: 96 at kernel/workqueue.c:2259 
> delayed_work_timer_fn+0x63/0x90
> [    7.537763] Modules linked in: rfcomm cmac algif_hash algif_skcipher 
> af_alg snd_seq_dummy snd_hrtimer snd_seq snd_seq_device bnep btusb 
> uvcvideo btrtl btintel videobuf2_vmalloc btbcm uvc btmtk 
> videobuf2_memops videobuf2_v4l2 bluetooth videodev videobuf2_common mc 
> snd_soc_skl_hda_dsp snd_soc_hdac_hdmi snd_sof_probes 
> snd_soc_intel_hda_dsp_common binfmt_misc nls_ascii nls_cp437 vfat fat 
> snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic 
> snd_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_tgl 
> snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel 
> soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda_common 
> snd_sof_intel_hda_mlink snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp 
> snd_sof iwlmvm snd_sof_utils intel_uncore_frequency snd_soc_hdac_hda 
> intel_uncore_frequency_common snd_soc_acpi_intel_match 
> x86_pkg_temp_thermal intel_powerclamp snd_soc_acpi soundwire_bus 
> coretemp kvm_intel snd_ctl_led mac80211 snd_soc_avs kvm 
> snd_soc_hda_codec snd_hda_ext_core snd_soc_core libarc4
> [    7.537811]  crct10dif_pclmul snd_compress snd_pcm_dmaengine 
> ghash_clmulni_intel sha512_ssse3 snd_hda_intel sha256_ssse3 sha1_ssse3 
> iwlwifi snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec aesni_intel 
> gf128mul snd_hda_core crypto_simd cryptd rapl mei_hdcp mei_pxp mei_wdt 
> snd_hwdep intel_rapl_msr processor_thermal_device_pci intel_cstate 
> cfg80211 processor_thermal_device processor_thermal_wt_hint intel_uncore 
> snd_pcm thinkpad_acpi think_lmi iTCO_wdt processor_thermal_rfim mei_me 
> firmware_attributes_class intel_pmc_bxt processor_thermal_rapl snd_timer 
> ucsi_acpi mei iTCO_vendor_support intel_rapl_common nvram typec_ucsi 
> wmi_bmof watchdog platform_profile processor_thermal_wt_req pcspkr 
> processor_thermal_power_floor snd igen6_edac processor_thermal_mbox 
> typec roles soundcore rfkill ac int3403_thermal joydev 
> int340x_thermal_zone intel_pmc_core int3400_thermal intel_vsec intel_hid 
> pmt_telemetry acpi_thermal_rel sparse_keymap acpi_tad pmt_class acpi_pad 
> evdev serio_raw dm_mod loop configfs efi_pstore efivarfs ip_tables
> [    7.537861]  x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic 
> i915 drm_buddy i2c_algo_bit drm_display_helper cec hid_multitouch 
> rc_core hid_generic xhci_pci xhci_hcd ttm i2c_hid_acpi i2c_hid usbcore 
> drm_kms_helper hid intel_lpss_pci video nvme intel_lpss crc32_pclmul 
> i2c_i801 thunderbolt psmouse drm nvme_core e1000e crc32c_intel idma64 
> usb_common i2c_smbus fan button battery wmi
> [    7.537887] CPU: 12 UID: 0 PID: 96 Comm: ktimers/12 Not tainted 6.11- 
> rt-amd64 #1  atzlinux 6.11-1~exp1
> [    7.537891] Hardware name: LENOVO 21HD0078CD/21HD0078CD, BIOS 
> N3QET47W (1.47 ) 07/18/2024
> [    7.537893] RIP: 0010:delayed_work_timer_fn+0x63/0x90
> [    7.537898] Code: 65 48 8b 3d 3f ad b4 77 65 8b 05 40 ad b4 77 8b 97 
> 00 0d 00 00 25 00 00 ff 00 81 e2 00 01 00 00 09 d0 75 06 f6 47 2c 20 75 
> 0b <0f> 0b 5b 5d 41 5c c3 cc cc cc cc e8 fd 76 00 00 48 85 c0 74 eb 48
> [    7.537900] RSP: 0018:ffffbb900046bc98 EFLAGS: 00010006
> [    7.537903] RAX: 0000000000000100 RBX: ffff9a6182053000 RCX: 
> ffff9a64cf7a35c0
> [    7.537904] RDX: 0000000000000100 RSI: ffffffff884eab80 RDI: 
> ffff9a6181130000
> [    7.537906] RBP: 0000000000002000 R08: ffff9a64cf7a3610 R09: 
> ffff9a64cf7a3658
> [    7.537907] R10: 0000000000000002 R11: 0000000000000001 R12: 
> ffff9a6183bfa900
> [    7.537908] R13: dead000000000122 R14: ffffffff884eab80 R15: 
> ffff9a6183bfa920
> [    7.537910] FS:  0000000000000000(0000) GS:ffff9a64cf600000(0000) 
> knlGS:0000000000000000
> [    7.537912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.537913] CR2: 0000561c94ed4000 CR3: 000000041d62c000 CR4: 
> 0000000000f50ef0
> [    7.537915] PKRU: 55555554
> [    7.537916] Call Trace:
> [    7.537918]  <TASK>
> [    7.537919]  ? delayed_work_timer_fn+0x63/0x90
> [    7.537923]  ? __warn.cold+0x93/0xed
> [    7.537926]  ? delayed_work_timer_fn+0x63/0x90
> [    7.537933]  ? report_bug+0xff/0x140
> [    7.537937]  ? handle_bug+0x3c/0x80
> [    7.537942]  ? exc_invalid_op+0x17/0x70
> [    7.537945]  ? asm_exc_invalid_op+0x1a/0x20
> [    7.537947]  ? __pfx_delayed_work_timer_fn+0x10/0x10
> [    7.537951]  ? __pfx_delayed_work_timer_fn+0x10/0x10
> [    7.537955]  ? delayed_work_timer_fn+0x63/0x90
> [    7.537958]  ? __pfx_delayed_work_timer_fn+0x10/0x10
> [    7.537961]  call_timer_fn+0x27/0x120
> [    7.537965]  __run_timers+0x18d/0x300
> [    7.537969]  timer_expire_remote+0x51/0x80
> [    7.537973]  tmigr_handle_remote+0x3cc/0x470
> [    7.537979]  handle_softirqs.isra.0+0xb5/0x230
> [    7.537982]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    7.537986]  run_timersd+0x3e/0x80
> [    7.537988]  smpboot_thread_fn+0xda/0x1d0
> [    7.537992]  kthread+0xcf/0x100
> [    7.537995]  ? __pfx_kthread+0x10/0x10
> [    7.537997]  ret_from_fork+0x31/0x50
> [    7.538000]  ? __pfx_kthread+0x10/0x10
> [    7.538001]  ret_from_fork_asm+0x1a/0x30
> [    7.538006]  </TASK>
> [    7.538007] ---[ end trace 0000000000000000 ]---
> 
> The whole dmesg is:
> https://linux-hardware.org/?probe=28057f9ed2&log=dmesg

On a first glance this looks like an unrelated issue to me. Could you 
test with CONFIG_X86_INTEL_PSTATE=n? (If doesn't matter if you do this 
with my patch applied or not, without CONFIG_X86_INTEL_PSTATE the driver 
isn't build.)

Best regards
Uwe

