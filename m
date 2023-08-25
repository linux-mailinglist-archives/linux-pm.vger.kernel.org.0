Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB4788B29
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHYOKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjHYOKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 10:10:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA330D0;
        Fri, 25 Aug 2023 07:09:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-56c2e840e70so534279a12.3;
        Fri, 25 Aug 2023 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692972542; x=1693577342;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQPyk8/VRDr2frmKrGz4pHODK8NiDC03edZqDF0AE7o=;
        b=orSJOmgMZW8QXVrJJzI2raqCc85Th6wgDeQNxgdmC3nAygvoV1H5lFISUTr5AX9hQt
         cvY+wMPmfTH09zFZ7OO8fYUlkbXn/JqOxVXlRPzyLTpSVF4zozW07gfmdEseY8UaBWB8
         Cj5fUzTw0pccWpGFXH4zIcK4UmJfout5KvD9b16lpQUak5EdW7yGqcIIY/hMpvq+Qv/c
         S2AhNmjASmbqM5SHXBnpdvP9QH16VzYvxwjz50wCBQDS0MnLO8FIKpeDt5mR6dWFt7xl
         Kmxj6hgUZuOdziUbiUWmO53Zg6owqPqf5IWyoGljj3GU8B+SSPnrTcwzo3TsMawQyLLb
         L1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972542; x=1693577342;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQPyk8/VRDr2frmKrGz4pHODK8NiDC03edZqDF0AE7o=;
        b=kUhGQY6ZbF0m90PBQqGEklVoYfVMRmMk0p0ZCxXVTLnb5aei3DmMubBh4yTcn1BXeW
         bR+7T0mVr1/2YEr3aMhEyA5Kjv2AxCHDUz2fojqJ1QEed6UWjwbo5i9obCN2Cyhe/BdI
         Ive4INZ9cj6t5VRBegwqdmwgWjFolphl/THrgIfLHaTlrzgRlXNlK5fM0RF1sdwhtf3F
         Jl5eG14pYxsKSgr5Ffs9i1ZT4OL+7cUamuKJpnJFnU31RILOKUCP/Q628VlyWq2aWqqj
         aAPKUKmZXAmuC2oCV2WsYtNSSTqvsI2qW+Hzm01vgufyt5qxXuIMd0+eg9xKvITpoy3x
         xmzg==
X-Gm-Message-State: AOJu0YxQuQ7Ek5bbL9EN2AL6g1yoXdtWGlp484y3Ew7teYerdDqlVpSk
        ayqhL5kuFyXF+zyQditlu0qRMd604hs=
X-Google-Smtp-Source: AGHT+IEC5U4Gey7yy3vbvoqyVH63gdTeWoLCqNe0LpjFmzIOPAqh2ZinNz6DagKv58+ipYNz4w/MMQ==
X-Received: by 2002:a05:6a20:9704:b0:141:a70:6c26 with SMTP id hr4-20020a056a20970400b001410a706c26mr17328137pzc.57.1692972541957;
        Fri, 25 Aug 2023 07:09:01 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c5-20020a62e805000000b00689f10adef9sm1599347pfi.67.2023.08.25.07.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 07:09:01 -0700 (PDT)
Message-ID: <8524b5f1-31fe-dc14-d2e2-3ace87348c8a@gmail.com>
Date:   Fri, 25 Aug 2023 21:08:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan@gmail.com>
Cc:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Intel Xeon w9-3495X hangs during S3 stress test
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Kernel: mainline v6.5-rc7
>=20
> We see this issue happens on machines with Sapphire Rapids CPU, and enc=
ountered the same issue on 2 projects.
>=20
> Using fwts could trigger this issue, but need more trial
> sudo fwts s3 --s3-multiple=3D1000
>=20
> The log attached using sleepgraph with below commands
> sudo sleepgraph -m mem -rtcwake 90 -sync -gzip -multi 30 90 -skiphtml -=
o "$PLAINBOX_SESSION_SHARE"/s3_pm-graph/suspend-"$(date -d today +%Y-%m-%=
d-%H%M)"
>=20
>=20
> [ 6167.815739] general protection fault, probably for non-canonical add=
ress 0x8cdbb8946f549ea0: 0000 [#2] PREEMPT SMP NOPTI
> [ 6167.826650] CPU: 105 PID: 8263 Comm: sleepgraph Tainted: G      D W =
         6.5.0-rc7+ #1
> [ 6167.834964] Hardware name: Dell Inc. Precision 7960 Tower/, BIOS 1.0=
=2E7 05/09/2023
> [ 6167.842496] RIP: 0010:deactivate_slab+0xeb/0x2f0
> [ 6167.847168] Code: ff 7f 00 00 41 0f af d1 48 01 f2 48 39 d0 73 3b 48=
 29 f0 48 99 49 f7 f9 48 85 d2 75 2e 83 c3 01 4d 89 f7 49 89 ce 4b 8d 04 =
06 <48> 8b 10 48 0f c8 48 31 fa 48 89 d1 48 31 c1 48 39 c2 75 9c 83 c3
> [ 6167.865967] RSP: 0000:ff43578e0ee57b10 EFLAGS: 00010a16
> [ 6167.871239] RAX: 8cdbb8946f549ea0 RBX: 0000000000000032 RCX: 8cdbb89=
46f549e78
> [ 6167.878403] RDX: a48b2c8782538287 RSI: ff1c07ed13945000 RDI: a48b2c8=
782531932
> [ 6167.885567] RBP: ff43578e0ee57bc0 R08: 0000000000000028 R09: 0000000=
000000000
> [ 6167.892732] R10: 0000000000000000 R11: 0000000000000001 R12: ff1c07e=
c80274000
> [ 6167.899898] R13: ff8bf38ac64e5140 R14: 8cdbb8946f549e78 R15: ff1c07e=
d13945000
> [ 6167.907064] FS:  00007f21e25701c0(0000) GS:ff1c07f3f0440000(0000) kn=
lGS:0000000000000000
> [ 6167.915183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6167.920963] CR2: 0000000000000000 CR3: 0000000109324004 CR4: 0000000=
000771ee0
> [ 6167.928128] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> [ 6167.935293] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000=
000000400
> [ 6167.942459] PKRU: 00000000
> [ 6167.945203] Call Trace:
> [ 6167.947693]  <TASK>
> [ 6167.949835]  ? show_regs+0x72/0x90
> [ 6167.953292]  ? die_addr+0x38/0xb0
> [ 6167.956649]  ? exc_general_protection+0x1d1/0x460
> [ 6167.961395]  ? asm_exc_general_protection+0x27/0x30
> [ 6167.966315]  ? deactivate_slab+0xeb/0x2f0
> [ 6167.970376]  ? __unfreeze_partials+0x176/0x1f0
> [ 6167.974855]  slub_cpu_dead+0x70/0xd0
> [ 6167.978466]  ? __pfx_slub_cpu_dead+0x10/0x10
> [ 6167.982776]  cpuhp_invoke_callback+0x170/0x4c0
> [ 6167.987259]  ? __pfx_bio_cpu_dead+0x10/0x10
> [ 6167.991487]  __cpuhp_invoke_callback_range+0x79/0xf0
> [ 6167.996485]  _cpu_down+0x12e/0x290
> [ 6167.999932]  trace_clock_x86_tsc+0x20/0x20
> [ 6168.004074]  suspend_devices_and_enter+0x2fa/0x8b0
> [ 6168.008906]  pm_suspend+0x30d/0x6a0
> [ 6168.012432]  state_store+0x85/0xf0
> [ 6168.015874]  kobj_attr_store+0xf/0x40
> [ 6168.019583]  sysfs_kf_write+0x3b/0x60
> [ 6168.023285]  kernfs_fop_write_iter+0x153/0x1e0
> [ 6168.027768]  vfs_write+0x2cf/0x400
> [ 6168.031215]  ksys_write+0x67/0xf0
> [ 6168.034573]  __x64_sys_write+0x19/0x30
> [ 6168.038364]  do_syscall_64+0x59/0x90
> [ 6168.041975]  ? do_syscall_64+0x69/0x90
> [ 6168.045766]  ? sysvec_apic_timer_interrupt+0x4e/0xb0
> [ 6168.050764]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 6168.055857] RIP: 0033:0x7f21e2314a37
> [ 6168.059474] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f=
 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [ 6168.078254] RSP: 002b:00007ffd24566438 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000001
> [ 6168.085853] RAX: ffffffffffffffda RBX: 0000558328947a80 RCX: 00007f2=
1e2314a37
> [ 6168.093019] RDX: 0000000000000003 RSI: 000055832a699fa0 RDI: 0000000=
000000003
> [ 6168.100185] RBP: 000055832981fe60 R08: 0000000000000000 R09: 0000000=
000000000
> [ 6168.107353] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000003
> [ 6168.114520] R13: 00007f21e2570140 R14: 0000000000000003 R15: 0000558=
32a699fa0
> [ 6168.121686]  </TASK>
> [ 6168.123915] Modules linked in: intel_rapl_msr intel_rapl_common inte=
l_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_=
temp_thermal intel_powerclamp dell_wmi binfmt_misc nls_iso8859_1 pmt_tele=
metry intel_sdsi pmt_class dell_wmi_ddv dell_wmi_sysman firmware_attribut=
es_class dell_smbios sparse_keymap dell_wmi_descriptor wmi_bmof coretemp =
kvm_intel dcdbas kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyva=
l_generic ghash_clmulni_intel snd_sof_pci_intel_tgl sha512_ssse3 snd_sof_=
intel_hda_common snd_soc_hdac_hda aesni_intel snd_sof_pci crypto_simd snd=
_sof_xtensa_dsp cryptd snd_sof_intel_hda amdgpu snd_ctl_led snd_sof snd_s=
of_utils rapl snd_soc_acpi_intel_match snd_soc_acpi i2c_algo_bit drm_ttm_=
helper intel_cstate ttm snd_soc_core snd_hda_codec_realtek video snd_comp=
ress drm_suballoc_helper snd_hda_codec_generic snd_sof_intel_hda_mlink am=
dxcp snd_hda_codec_hdmi ledtrig_audio snd_hda_ext_core iommu_v2 drm_buddy=
 isst_if_mbox_pci gpu_sched snd_hda_intel drm_display_helper snd_intel_ds=
pcfg
> [ 6168.123967]  snd_hda_codec drm_kms_helper isst_if_mmio snd_hwdep idx=
d cec isst_if_common intel_vsec rc_core snd_hda_core idxd_bus snd_pcm snd=
_seq cmdlinepart snd_seq_device snd_timer spi_nor mtd snd soundcore joyde=
v input_leds mei_me mei wmi mac_hid sch_fq_codel msr parport_pc ppdev lp =
parport ramoops reed_solomon pstore_blk pstore_zone efi_pstore drm ip_tab=
les x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_rec=
ov async_memcpy async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 =
multipath linear raid0 nvme nvme_core nvme_common hid_generic usbhid hid =
atlantic ahci i2c_i801 e1000e spi_intel_pci xhci_pci vmd libahci macsec s=
pi_intel i2c_smbus xhci_pci_renesas pinctrl_alderlake
> [ 6168.274659] ---[ end trace 0000000000000000 ]---

See Bugzilla for the full thread and attached minicom log.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217822

--=20
An old man doll... just what I always wanted! - Clara
