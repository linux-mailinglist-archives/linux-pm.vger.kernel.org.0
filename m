Return-Path: <linux-pm+bounces-28003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60505ACC455
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E167A2BA9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5BD2C3276;
	Tue,  3 Jun 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRWrZhlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616F2C3250;
	Tue,  3 Jun 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946640; cv=none; b=P33bhLmzI6yxm0rHZoKPEzddEP3QbXQXcoNJijnAcch4xAMNfHA/Nw7vMvHhlfIWox6ZfNK2FJgMVNNfgWpcIp4S4uywBCcOpoTvefJ24K4avS7p6yELF+LoGF2r1ZyinX7AOvFQZofYqcYypgeCN+QYxuZHC8GM1tQef0bdZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946640; c=relaxed/simple;
	bh=frmUWxJcLyT+9OJMzPqFcc3Xs+4SBJJpWInxgDDv98Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+DqruM1Lq0iImEIT7tK17XcxvS9zjqLT/SuXh5uVfNgAiSqmgvZRG/bOI6VTfcVY3c0QxJeEHV2PCKXi5IYV4mmEzU5D4no2zs+sYthwBGV5BYnuhd0fs4JMu4lpuSgM3B24zjAN5aTOCc3QyHORLFDLbB/fbYm3NnZwmo/11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRWrZhlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97522C4CEEF;
	Tue,  3 Jun 2025 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748946639;
	bh=frmUWxJcLyT+9OJMzPqFcc3Xs+4SBJJpWInxgDDv98Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XRWrZhlFi8Gka4fPY6kdFXmOBi8EDCGCiLmY5WOtLnExm2K2gviX67vQ4N8k9Ch9G
	 f6txSRaCdVD6S6v9v77GzivGQ5J0PiH2Zlxkf3McoPkz4MeRXCaZoPuEHlNl4/6uyp
	 dQotvJbadAvgDPBUNoi4eF76foitRdojfkrA9nFrAWGjj/LSFdiKsH0L0v4fAKGB2V
	 Glj81fLBf/Vc1F15+lag+jO+SilVv7X7OgmUftxRjFl7+uwD40Ee6gksIequ/7+M1S
	 IfDWQaPNjzMs31qwnPV9BkkdJIl+4Bp+CAS7ApdUUv2R0AtzkuVIgSgDeCpY6EYO17
	 MtcQT8QRYP1og==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-736f9e352cbso1633909a34.2;
        Tue, 03 Jun 2025 03:30:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLPPH2Dkp1jq8oIHKR3lMJ46g8CcjyFEPeqmSmj9l14TpA+fPCHqrz+erq6D5FfV8zgZpe/wf9HCo=@vger.kernel.org, AJvYcCWt0KkA9twghXgpQ5rBmRG8Cptgg/yXP/r7vF8afdbhEvIKlj1xha7tckyEL5qeSGqJyqjPWDSSx5OW7j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUt2skaBLtzy/Rq7klWlE5LnHACwsTHxVINPkmgjZz8rCYlxr
	TNqD0u8urWJ6YUM2TZmhUZMTrPft9uOp94Tgu0wZqU/KdbQJzhqJUyYxWhyTmic5G9jsDHwGEJm
	IOSDl1ew27+ehc8UB33Ngh8X++rDid48=
X-Google-Smtp-Source: AGHT+IH3LQDAgoNyB/dZPAtQuqhlxhHgvWEPxw5r+lvNETc+ILDVwtyZSgVA8YP34jm/CBQHtJ520UkUpUjBGuFgR5w=
X-Received: by 2002:a05:6871:d20f:b0:2e9:e5e:8456 with SMTP id
 586e51a60fabf-2e92a3aef3bmr9037337fac.22.1748946638886; Tue, 03 Jun 2025
 03:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <3541233.QJadu78ljV@rjwysocki.net>
 <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org> <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local> <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 12:30:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
X-Gm-Features: AX0GCFsl9a7Ec1RHwkeTWNFLC6M25FA_DxwNDF1aT_u53yEStxj33cEuzPAQw8c
Message-ID: <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:29=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jun 3, 2025 at 12:17=E2=80=AFPM Chris Bainbridge
> <chris.bainbridge@gmail.com> wrote:
> >
> > On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wrote:
> > >
> > > Chris, please check if the attached patch helps.  I'm going to post i=
t
> > > as a fix anyway later today, but it would be good to verify that it i=
s
> > > sufficient.
> >
> > This did not fix my test case, pstore crash log was:
>
> OK, so can you please enable PM debug messages:
>
> # echo 1 > /sys/power/pm_debug/messages

This should be

# echo 1 > /sys/power/pm_debug_messages

sorry.

> and enabled dynamic debug in drivers/base/power/main.c:
>
> # echo "file drivers/base/power/main.c +p" > /proc/dynamic_debug/control
>
> repeat the test and capture the log?
>
> > <6>[  100.690222] Freezing remaining freezable tasks completed (elapsed=
 0.001 seconds)
> > <6>[  100.690392] printk: Suspending console(s) (use no_console_suspend=
 to debug)
> > <7>[  100.949462] PM: suspend of devices aborted after 1.796 msecs
> > <7>[  100.949469] PM: start suspend of devices aborted after 258.160 ms=
ecs
> > <3>[  100.949472] PM: Some devices failed to suspend, or early wake eve=
nt detected
> > <4>[  100.949565]  slab kmalloc-cg-4k start ffff916fede97000 pointer of=
fset 1936 size 4096
> > <3>[  100.949589] list_add corruption. prev->next should be next (fffff=
fff8f877180), but was ffff916f8ed40998. (prev=3Dffff916fede97790).
> > <4>[  100.949600] ------------[ cut here ]------------
> > <2>[  100.949601] kernel BUG at lib/list_debug.c:32!
> > <4>[  100.949607] Oops: invalid opcode: 0000 [#1] SMP
> > <4>[  100.949610] CPU: 13 UID: 0 PID: 3703 Comm: amd_s2idle.py.o Not ta=
inted 6.15.0-09119-g98079dc6057f #438 PREEMPT(voluntary)
> > <4>[  100.949613] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8=
916, BIOS F.17 12/18/2024
> > <4>[  100.949614] RIP: 0010:__list_add_valid_or_report+0x90/0xa0
> > <4>[  100.949619] Code: 98 8a ff 0f 0b 48 89 f7 48 89 34 24 e8 69 c6 c5=
 ff 48 8b 34 24 48 c7 c7 30 53 40 8f 48 8b 16 48 89 f1 48 89 de e8 50 98 8a=
 ff <0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 54
> > <4>[  100.949621] RSP: 0018:ffffa0f6c715fb68 EFLAGS: 00010246
> > <4>[  100.949622] RAX: 0000000000000075 RBX: ffffffff8f877180 RCX: 0000=
000000000027
> > <4>[  100.949623] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff=
91724689e180
> > <4>[  100.949624] RBP: ffffffff8f876140 R08: 0000000000000001 R09: 0000=
000000000000
> > <4>[  100.949625] R10: 0000000000000001 R11: 0000000000000006 R12: 0000=
000000000010
> > Oops#1 Part3
> > <4>[  100.949626] R13: 000000177d0d8fb9 R14: ffff916fede97790 R15: ffff=
916f8e564820
> > <4>[  100.949627] FS:  00007f076a109100(0000) GS:ffff9172b67c7000(0000)=
 knlGS:0000000000000000
> > <4>[  100.949628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[  100.949629] CR2: 00007fa8ce10f61c CR3: 00000001b80bb000 CR4: 0000=
000000f50ef0
> > <4>[  100.949630] PKRU: 55555554
> > <4>[  100.949630] Call Trace:
> > <4>[  100.949631]  <TASK>
> > <4>[  100.949632]  dpm_resume+0x139/0x350
> > <4>[  100.949636]  dpm_resume_end+0x11/0x20
> > <4>[  100.949639]  suspend_devices_and_enter+0x18e/0x9f0
> > <4>[  100.949642]  pm_suspend.cold+0x273/0x2cf
> > <4>[  100.949645]  state_store+0x6c/0xd0
> > <4>[  100.949647]  kernfs_fop_write_iter+0x194/0x250
> > <4>[  100.949650]  vfs_write+0x254/0x550
> > <4>[  100.949654]  ksys_write+0x71/0xe0
> > <4>[  100.949656]  do_syscall_64+0x97/0x3d0
> > <4>[  100.949658]  ? __lock_acquire+0x469/0x2200
> > <4>[  100.949662]  ? __handle_mm_fault+0xaa7/0xf70
> > <4>[  100.949665]  ? lock_acquire+0xc9/0x2d0
> > <4>[  100.949667]  ? find_held_lock+0x2b/0x80
> > <4>[  100.949669]  ? rcu_read_unlock+0x17/0x60
> > <4>[  100.949672]  ? lock_release+0xd1/0x2a0
> > <4>[  100.949674]  ? find_held_lock+0x2b/0x80
> > <4>[  100.949676]  ? exc_page_fault+0x90/0x240
> > <4>[  100.949678]  ? lock_release+0xd1/0x2a0
> > <4>[  100.949681]  ? do_user_addr_fault+0x36e/0x690
> > <4>[  100.949684]  ? lockdep_hardirqs_on_prepare+0xd7/0x170
> > <4>[  100.949686]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > <4>[  100.949688] RIP: 0033:0x7f076a199687
> > <4>[  100.949690] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00=
 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f=
 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> > Oops#1 Part2
> > <4>[  100.949691] RSP: 002b:00007ffd3a7a3990 EFLAGS: 00000202 ORIG_RAX:=
 0000000000000001
> > <4>[  100.949693] RAX: ffffffffffffffda RBX: 00007f076a109100 RCX: 0000=
7f076a199687
> > <4>[  100.949694] RDX: 0000000000000003 RSI: 0000000008d3e090 RDI: 0000=
000000000004
> > <4>[  100.949694] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000=
000000000000
> > <4>[  100.949695] R10: 0000000000000000 R11: 0000000000000202 R12: 0000=
7f076a109068
> > <4>[  100.949696] R13: 0000000000000004 R14: 0000000000a7e4f0 R15: 0000=
000000a50af8
> > <4>[  100.949700]  </TASK>
> > <4>[  100.949700] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq =
snd_seq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack=
_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_=
addrtype nft_compat nf_tables br_netfilter bridge stp llc ccm overlay qrtr =
rfcomm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbcache =
jbd2 nls_ascii nls_cp437 vfat fat snd_acp3x_rn snd_soc_dmic snd_acp3x_pdm_d=
ma snd_sof_amd_rembrandt snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp snd=
_sof snd_sof_utils snd_ctl_led snd_soc_core snd_compress snd_hda_codec_real=
tek iwlmvm snd_pci_ps snd_hda_codec_generic snd_soc_acpi_amd_match snd_hda_=
scodec_component snd_rpl_pci_acp6x snd_hda_codec_hdmi intel_rapl_msr uvcvid=
eo snd_acp_pci mac80211 btusb snd_hda_intel intel_rapl_common videobuf2_vma=
lloc snd_amd_acpi_mach btrtl snd_intel_dspcfg videobuf2_memops libarc4 kvm_=
amd snd_acp_legacy_common btintel snd_hda_codec uvc videobuf2_v4l2 snd_hwde=
p snd_pci_acp6x btbcm kvm videodev snd_hda_core snd_pci_acp5x btmtk
> > Oops#1 Part1
> > <4>[  100.949738]  iwlwifi snd_rn_pci_acp3x videobuf2_common snd_pcm hp=
_wmi bluetooth irqbypass sg snd_acp_config mc snd_timer platform_profile ra=
pl cfg80211 snd_soc_acpi pcspkr sparse_keymap snd wmi_bmof ee1004 snd_pci_a=
cp3x soundcore k10temp ccp rfkill battery ac evdev joydev acpi_tad amd_pmc =
msr parport_pc ppdev lp parport nvme_fabrics efi_pstore configfs nfnetlink =
efivarfs ip_tables x_tables autofs4 crc32c_cryptoapi btrfs blake2b_generic =
xor raid6_pq dm_crypt dm_mod sd_mod uas usb_storage scsi_mod scsi_common am=
dgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_qui=
rks drm_exec drm_suballoc_helper amdxcp drm_buddy gpu_sched hid_multitouch =
drm_display_helper hid_generic nvme xhci_pci drm_kms_helper ucsi_acpi sp510=
0_tco typec_ucsi ghash_clmulni_intel cec i2c_hid_acpi nvme_core xhci_hcd wa=
tchdog roles sha512_ssse3 rc_core amd_sfh i2c_hid nvme_keyring usbcore i2c_=
piix4 typec video aesni_intel serio_raw crc16 hid nvme_auth i2c_smbus fan u=
sb_common drm button wmi
> > <4>[  100.949784] ---[ end trace 0000000000000000 ]---

