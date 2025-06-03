Return-Path: <linux-pm+bounces-28000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D734ACC435
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C70C7A0737
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E52E62C;
	Tue,  3 Jun 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLuzwhVH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF068BE8;
	Tue,  3 Jun 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945879; cv=none; b=cA2XhIcjXG+uowlvq5nVJQUwKkGvRe5WKEtmhizSY54OLkYMmocpuV4d+WHdKlPH+b/FhuncpCXoetHlI0+tqZbUZNN6DFwICxXSkzckshx6R6IoMkvKsG/rcNFM8HomzaluIbiZauDpO/sU3eFa0E+VV+PzlOA/jpjlqMKsIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945879; c=relaxed/simple;
	bh=qAC4fpMrc+fF2adFxTF7f8fgQuyywdm1wAP3quelQ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoncCPZQwUMYWI/c+LRwIslsIDw+rd8Lyyd2RVvgMEtSJOZWPsJnhKHD+IzIlRaUc8pScNRQouTLkJIAESY0Si1Bf5NGytXz4d0Bf6IcYSHZ7mTB8EbzM5ruKFLpI0rKiUbcWTqqdBwo35goXe+jCemeQp7L6D1HeD/uF5tz6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLuzwhVH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d7b50815so17828465e9.2;
        Tue, 03 Jun 2025 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748945876; x=1749550676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0P1OcEuL1F48p/Jk+38qe7qlgSJuzzL+bo4Wlmq7TQ=;
        b=VLuzwhVHDUhXZxSatbxd6xv6biXmZffBKQHtnF8dHWxoypUMASw5QhTwRMRJfg9yEZ
         tuxfNj7yXd5Nc35/cRPQtoMlWMf8j9DFBWZr+eMpbDPQOElS1K1wdFHbRZOPJ8PMjJ06
         QvmCJG0j25SRDEF8xBZ7+kIv2KDYt9CNXpa4ddW+t+HxA+Hqdj/IJL8qv0g2trKRntEM
         xnbSm3TdlRIVTJ5cOknTbSe3d9Cn+dy58FpBLT1ACUewSStFGpob8JApwfNWUTJScbPr
         twv6AJJIF9PaWrZp3H3Y3Ctxox/nSgJngneU/yWiiIo1UAQxdovjwHov7VNOfQFTZd45
         smTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748945876; x=1749550676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0P1OcEuL1F48p/Jk+38qe7qlgSJuzzL+bo4Wlmq7TQ=;
        b=Q1q7aq+qs2Yr4132Hz81MVCm5OUh+Tkt2z4JFyxmwjIfXjwNWLjNNHwp/AddIkmxsR
         4v2vbT38n1p75SR+YRHpVgjyjrypQHNjNe7kTf/yFWAo0wlDCrUPWpft5ws9sKjR9NeL
         Odh38isQAeR+yiz5ZG7GbVB1x80kpvuCJr+xK8cYOxcsp/DoqHINlB9EG81cXXHx9Hnq
         0+Exj4q0PeDzcNMm2OBwd7llcuZ12q9f5BtxxUEIzKMoIGUpYAmavLJk06lzZ9ASFZsu
         YAkFj91WYQLHuzpwa8TmQhiPjRQ0+Zjtyze8/Mw6648e1Da5TQcoJZuoHftLpahvoLEA
         KAEw==
X-Forwarded-Encrypted: i=1; AJvYcCVTY2c9/qPAM76ISq19JzHCKCpzunL4AQhRsg1x3w1gOQ3ryJUqdqwuS4uM3wfNqtw6aHQ5B7QmmSdK+kw=@vger.kernel.org, AJvYcCWg56DnsTrL1VsUDLEmwIw5NpQpexnRVk0FD4h8fy3uCKddQIt9l26ew8bYaQk4uEpAyDh2vykLGZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlT7mqtO7K+XkosxnxY7+mdP9DEISx2WKskzVL4a4WdQGYBWtf
	Yauz1DHnYfefE+5a7kc1+RoVXkp6jomvsiW4Dalvds802fbzaNW9/0iAByBM/1aKUzM=
X-Gm-Gg: ASbGncsVinZ/oh1004sREdCUaqulbxtYn7El7wo70pBcPQSDFHfSQI7QnTe37G3BpZY
	QrO/pOGddbIy36KB6QMnbaEzQ5mGUbCCSzDZlBC3MGR4B4iExbuV+akE86DjqBPAbd39FS0ryp8
	hCXKFNtDyS5leuisWz9dThTUOzpjEAzFUHNrcYnNUVDgSQil/BfntUyjQAzYFvXIFMo6FqfYXwz
	ODHXCZlJJaNRg4BuoA3VcUHQyZXfO+y7e68pDfqdoqVQenGG/g16BKQSNykhoz4XxW4Zd1PvNPd
	DuriZ3uW+Aj9/tNipzPLSy5YJZM0b2UgXbYz34ySKHum4X8n/XrDGWqGLGav
X-Google-Smtp-Source: AGHT+IEWLJbPeG9pLGW1Pj3XDlHYZS7Tj3RLsVjIfu2M5iP457IZ8VxY7J70cN3uUko4tUW5axp9MA==
X-Received: by 2002:a05:600c:1553:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-450d884316fmr154997435e9.9.1748945875924;
        Tue, 03 Jun 2025 03:17:55 -0700 (PDT)
Received: from debian.local ([81.78.104.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009ff7asm18023011f8f.90.2025.06.03.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:17:55 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:17:53 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Saravana Kannan <saravanak@google.com>,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
Message-ID: <aD7L0RD4HT-mEtBc@debian.local>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <3541233.QJadu78ljV@rjwysocki.net>
 <aD2U3VIhf8vDkl09@debian.local>
 <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org>
 <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>

On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wrote:
>=20
> Chris, please check if the attached patch helps.  I'm going to post it
> as a fix anyway later today, but it would be good to verify that it is
> sufficient.

This did not fix my test case, pstore crash log was:

<6>[  100.690222] Freezing remaining freezable tasks completed (elapsed 0.0=
01 seconds)
<6>[  100.690392] printk: Suspending console(s) (use no_console_suspend to =
debug)
<7>[  100.949462] PM: suspend of devices aborted after 1.796 msecs
<7>[  100.949469] PM: start suspend of devices aborted after 258.160 msecs
<3>[  100.949472] PM: Some devices failed to suspend, or early wake event d=
etected
<4>[  100.949565]  slab kmalloc-cg-4k start ffff916fede97000 pointer offset=
 1936 size 4096
<3>[  100.949589] list_add corruption. prev->next should be next (ffffffff8=
f877180), but was ffff916f8ed40998. (prev=3Dffff916fede97790).
<4>[  100.949600] ------------[ cut here ]------------
<2>[  100.949601] kernel BUG at lib/list_debug.c:32!
<4>[  100.949607] Oops: invalid opcode: 0000 [#1] SMP
<4>[  100.949610] CPU: 13 UID: 0 PID: 3703 Comm: amd_s2idle.py.o Not tainte=
d 6.15.0-09119-g98079dc6057f #438 PREEMPT(voluntary)=20
<4>[  100.949613] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916,=
 BIOS F.17 12/18/2024
<4>[  100.949614] RIP: 0010:__list_add_valid_or_report+0x90/0xa0
<4>[  100.949619] Code: 98 8a ff 0f 0b 48 89 f7 48 89 34 24 e8 69 c6 c5 ff =
48 8b 34 24 48 c7 c7 30 53 40 8f 48 8b 16 48 89 f1 48 89 de e8 50 98 8a ff =
<0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 54
<4>[  100.949621] RSP: 0018:ffffa0f6c715fb68 EFLAGS: 00010246
<4>[  100.949622] RAX: 0000000000000075 RBX: ffffffff8f877180 RCX: 00000000=
00000027
<4>[  100.949623] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9172=
4689e180
<4>[  100.949624] RBP: ffffffff8f876140 R08: 0000000000000001 R09: 00000000=
00000000
<4>[  100.949625] R10: 0000000000000001 R11: 0000000000000006 R12: 00000000=
00000010
Oops#1 Part3
<4>[  100.949626] R13: 000000177d0d8fb9 R14: ffff916fede97790 R15: ffff916f=
8e564820
<4>[  100.949627] FS:  00007f076a109100(0000) GS:ffff9172b67c7000(0000) knl=
GS:0000000000000000
<4>[  100.949628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  100.949629] CR2: 00007fa8ce10f61c CR3: 00000001b80bb000 CR4: 00000000=
00f50ef0
<4>[  100.949630] PKRU: 55555554
<4>[  100.949630] Call Trace:
<4>[  100.949631]  <TASK>
<4>[  100.949632]  dpm_resume+0x139/0x350
<4>[  100.949636]  dpm_resume_end+0x11/0x20
<4>[  100.949639]  suspend_devices_and_enter+0x18e/0x9f0
<4>[  100.949642]  pm_suspend.cold+0x273/0x2cf
<4>[  100.949645]  state_store+0x6c/0xd0
<4>[  100.949647]  kernfs_fop_write_iter+0x194/0x250
<4>[  100.949650]  vfs_write+0x254/0x550
<4>[  100.949654]  ksys_write+0x71/0xe0
<4>[  100.949656]  do_syscall_64+0x97/0x3d0
<4>[  100.949658]  ? __lock_acquire+0x469/0x2200
<4>[  100.949662]  ? __handle_mm_fault+0xaa7/0xf70
<4>[  100.949665]  ? lock_acquire+0xc9/0x2d0
<4>[  100.949667]  ? find_held_lock+0x2b/0x80
<4>[  100.949669]  ? rcu_read_unlock+0x17/0x60
<4>[  100.949672]  ? lock_release+0xd1/0x2a0
<4>[  100.949674]  ? find_held_lock+0x2b/0x80
<4>[  100.949676]  ? exc_page_fault+0x90/0x240
<4>[  100.949678]  ? lock_release+0xd1/0x2a0
<4>[  100.949681]  ? do_user_addr_fault+0x36e/0x690
<4>[  100.949684]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
<4>[  100.949686]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
<4>[  100.949688] RIP: 0033:0x7f076a199687
<4>[  100.949690] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 =
59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 =
<5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
Oops#1 Part2
<4>[  100.949691] RSP: 002b:00007ffd3a7a3990 EFLAGS: 00000202 ORIG_RAX: 000=
0000000000001
<4>[  100.949693] RAX: ffffffffffffffda RBX: 00007f076a109100 RCX: 00007f07=
6a199687
<4>[  100.949694] RDX: 0000000000000003 RSI: 0000000008d3e090 RDI: 00000000=
00000004
<4>[  100.949694] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000=
00000000
<4>[  100.949695] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f07=
6a109068
<4>[  100.949696] R13: 0000000000000004 R14: 0000000000a7e4f0 R15: 00000000=
00a50af8
<4>[  100.949700]  </TASK>
<4>[  100.949700] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_=
seq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_net=
link nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addr=
type nft_compat nf_tables br_netfilter bridge stp llc ccm overlay qrtr rfco=
mm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbcache jbd2=
 nls_ascii nls_cp437 vfat fat snd_acp3x_rn snd_soc_dmic snd_acp3x_pdm_dma s=
nd_sof_amd_rembrandt snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp snd_sof=
 snd_sof_utils snd_ctl_led snd_soc_core snd_compress snd_hda_codec_realtek =
iwlmvm snd_pci_ps snd_hda_codec_generic snd_soc_acpi_amd_match snd_hda_scod=
ec_component snd_rpl_pci_acp6x snd_hda_codec_hdmi intel_rapl_msr uvcvideo s=
nd_acp_pci mac80211 btusb snd_hda_intel intel_rapl_common videobuf2_vmalloc=
 snd_amd_acpi_mach btrtl snd_intel_dspcfg videobuf2_memops libarc4 kvm_amd =
snd_acp_legacy_common btintel snd_hda_codec uvc videobuf2_v4l2 snd_hwdep sn=
d_pci_acp6x btbcm kvm videodev snd_hda_core snd_pci_acp5x btmtk
Oops#1 Part1
<4>[  100.949738]  iwlwifi snd_rn_pci_acp3x videobuf2_common snd_pcm hp_wmi=
 bluetooth irqbypass sg snd_acp_config mc snd_timer platform_profile rapl c=
fg80211 snd_soc_acpi pcspkr sparse_keymap snd wmi_bmof ee1004 snd_pci_acp3x=
 soundcore k10temp ccp rfkill battery ac evdev joydev acpi_tad amd_pmc msr =
parport_pc ppdev lp parport nvme_fabrics efi_pstore configfs nfnetlink efiv=
arfs ip_tables x_tables autofs4 crc32c_cryptoapi btrfs blake2b_generic xor =
raid6_pq dm_crypt dm_mod sd_mod uas usb_storage scsi_mod scsi_common amdgpu=
 drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks =
drm_exec drm_suballoc_helper amdxcp drm_buddy gpu_sched hid_multitouch drm_=
display_helper hid_generic nvme xhci_pci drm_kms_helper ucsi_acpi sp5100_tc=
o typec_ucsi ghash_clmulni_intel cec i2c_hid_acpi nvme_core xhci_hcd watchd=
og roles sha512_ssse3 rc_core amd_sfh i2c_hid nvme_keyring usbcore i2c_piix=
4 typec video aesni_intel serio_raw crc16 hid nvme_auth i2c_smbus fan usb_c=
ommon drm button wmi
<4>[  100.949784] ---[ end trace 0000000000000000 ]---

