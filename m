Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC85770EE2
	for <lists+linux-pm@lfdr.de>; Sat,  5 Aug 2023 10:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHEImo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Aug 2023 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHEImn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Aug 2023 04:42:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B711B
        for <linux-pm@vger.kernel.org>; Sat,  5 Aug 2023 01:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8486B60BA2
        for <linux-pm@vger.kernel.org>; Sat,  5 Aug 2023 08:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF507C433C7
        for <linux-pm@vger.kernel.org>; Sat,  5 Aug 2023 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691224952;
        bh=kd0iTlPQjYrqyaUZrOusz9X20n6FY0aG2B6v5WwYGlg=;
        h=From:To:Subject:Date:From;
        b=Kcnqr0Qa23XOHEQNE5PvcF12DBhuNFEZKClO/Yt5qAQ5Sr+IGnr2c+yzDsRj+aZjR
         sOytT4stupWOzJakhpZo5rtLBWUA0O2OJtcyCMYZs4Vq3JFmvfb+LQWNZWMsiw8WIQ
         +XKpUB+AAmyPWW8IBbeX7x7BzViMtyTh36PwtHuhrJK5+rCUCH+W97GbFkE9f5AVAC
         P7f4hlnfNYJq7F2miNPXCak53s2B0+7ORi9iIh1WHSz+M8eL8f8+5tiFMRiC/oo5oK
         9KJgvmLriURwM7/Y+ykfpOqcFfVlexKgSAD+6MvsZs9Pty/gBEL8spLcWrl/NUX+5Z
         wSJISM7nnPaHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B1E89C53BC6; Sat,  5 Aug 2023 08:42:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217765] New: CFI violation when reading amd_pstate/status
Date:   Sat, 05 Aug 2023 08:42:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jannik.glueckert@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217765-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217765

            Bug ID: 217765
           Summary: CFI violation when reading amd_pstate/status
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: jannik.glueckert@gmail.com
        Regression: No

On kernel 6.4.7, with amd_pstate=3Dactive, with a Ryzen 7700X
I get a Clang CFI violation when reading
/sys/devices/system/cpu/amd_pstate/status

This is reproduceable with every read, I have only tried with amd_pstate=3D=
active

With the following CFI and Clang configs, Clang 16.0.6
CONFIG_CFI_CLANG=3Dy
CONFIG_CFI_PERMISSIVE=3Dy
CONFIG_LTO_CLANG=3Dy
CONFIG_LTO_CLANG_THIN=3Dy

Below is the full call trace, let me know if you need a trace with debug in=
fo.

[ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target:
show_status+0x0/0x70; expected type: 0x8651b1de)
[ 4947.849358] WARNING: CPU: 2 PID: 16519 at dev_attr_show+0x24/0x60
[ 4947.849360] Modules linked in: binfmt_misc nf_conntrack_netbios_ns
nf_conntrack_broadcast wireguard curve25519_x86_64 libcurve25519_generic
ip6_udp_tunnel udp_tunnel snd_seq_dummy snd_hrtimer snd_seq rfcomm joydev u=
hid
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_=
tftp
nft_fib_inet nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_reject_inet nf_reject_ip=
v6
nf_reject_ipv4 nft_reject nft_ct nft_chain_nat bridge 8021q mrp garp stp llc
nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_=
raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_=
ipv4
iptable_mangle iptable_raw iptable_security ip_set nfnetlink ebtable_filter
ebtables ip6table_filter ip6_tables iptable_filter ip_tables bnep vfat fat
amdgpu snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_intel mt7921e vfio_pci intel_rapl_msr mt7921_common intel_rapl_comm=
on
mt76_connac_lib edac_mce_amd vfio_pci_core mt76 vfio_iommu_type1 vfio kvm_a=
md
iommufd iommu_v2 snd_usb_audio
[ 4947.849379]  snd_intel_dspcfg gpu_sched snd_intel_sdw_acpi mac80211
drm_suballoc_helper snd_usbmidi_lib i2c_algo_bit drm_ttm_helper snd_hda_cod=
ec
btusb ttm btrtl libarc4 btmtk snd_hda_core snd_rawmidi kvm snd_seq_device
drm_display_helper btintel snd_hwdep mc btbcm irqbypass cfg80211 cec snd_pcm
asus_nb_wmi bluetooth eeepc_wmi snd_timer asus_wmi drm_kms_helper ledtrig_a=
udio
sparse_keymap snd gpio_amdpt platform_profile gpio_generic drm_buddy rfkill
soundcore rapl i2c_piix4 wmi_bmof pcspkr k10temp lm92 nct6775_core hwmon_vid
fuse loop dm_crypt crct10dif_pclmul polyval_clmulni polyval_generic
ghash_clmulni_intel nvme sp5100_tco ccp r8169 nvme_core nvme_common video w=
mi
sunrpc
[ 4947.849398] CPU: 2 PID: 16519 Comm: cat Tainted: P=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
6.4.7-gentoo-dist-hardened #1
[ 4947.849399] Hardware name: ASUS System Product Name/TUF GAMING B650M-PLUS
WIFI, BIOS 1616 05/16/2023
[ 4947.849400] RIP: 0010:dev_attr_show+0x24/0x60
[ 4947.849401] Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 56 53 =
4c
8b 5e 10 4d 85 db 74 34 49 89 f6 41 ba 22 4e ae 79 45 03 53 f1 74 02 <0f> 0=
b 41
ff d3 0f 1f 00 48 89 c3 48 3d 00 10 00 00 7c 19 49 8b 76
[ 4947.849403] RSP: 0018:ffffb33a03d9fd10 EFLAGS: 00010203
[ 4947.849404] RAX: ffff922f11509980 RBX: ffff9230e86f43c0 RCX:
0000000000000000
[ 4947.849404] RDX: ffff922f1746b000 RSI: ffffffffaee25f10 RDI:
ffff922f0005f800
[ 4947.849405] RBP: ffff9230e86f43e8 R08: 0000000000001000 R09:
ffff922f1746b000
[ 4947.849405] R10: 0000000015e419ad R11: ffffffffadda9330 R12:
ffffffffae8aa188
[ 4947.849406] R13: ffff9233bbcb6fc0 R14: ffffffffaee25f10 R15:
ffff922f1746b000
[ 4947.849407] FS:  00007eff007b4740(0000) GS:ffff923657e80000(0000)
knlGS:0000000000000000
[ 4947.849407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4947.849408] CR2: 00007eff0099f000 CR3: 000000010a0a2000 CR4:
0000000000750ee0
[ 4947.849409] PKRU: 55555554
[ 4947.849409] Call Trace:
[ 4947.849410]  <TASK>
[ 4947.849411]  ? __warn+0xcf/0x1c0
[ 4947.849414]  ? dev_attr_show+0x24/0x60
[ 4947.849415]  ? report_cfi_failure+0x4e/0x60
[ 4947.849417]  ? handle_cfi_failure+0x14c/0x1d0
[ 4947.849419]  ? __cfi_show_status+0x10/0x10
[ 4947.849420]  ? handle_bug+0x4f/0x90
[ 4947.849421]  ? exc_invalid_op+0x1a/0x60
[ 4947.849422]  ? asm_exc_invalid_op+0x1a/0x20
[ 4947.849424]  ? __cfi_show_status+0x10/0x10
[ 4947.849425]  ? dev_attr_show+0x24/0x60
[ 4947.849426]  sysfs_kf_seq_show+0xa6/0x110
[ 4947.849433]  seq_read_iter+0x16c/0x4b0
[ 4947.849436]  vfs_read+0x272/0x2d0
[ 4947.849438]  ksys_read+0x72/0xe0
[ 4947.849439]  do_syscall_64+0x76/0xb0
[ 4947.849440]  ? do_user_addr_fault+0x252/0x650
[ 4947.849442]  ? exc_page_fault+0x7a/0x1b0
[ 4947.849443]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 4947.849444] RIP: 0033:0x7eff008b2651
[ 4947.849445] Code: b5 fe ff ff 48 8d 3d 66 42 0a 00 50 e8 68 1b 02 00 0f =
1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d ad 0d 0e 00 00 74 13 31 c0 0f 05 <48> 3=
d 00
f0 ff ff 77 57 c3 66 0f 1f 44 00 00 53 48 83 ec 20 48 89
[ 4947.849446] RSP: 002b:00007ffecca23268 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 4947.849447] RAX: ffffffffffffffda RBX: 0000000000008000 RCX:
00007eff008b2651
[ 4947.849447] RDX: 0000000000020000 RSI: 00007eff009a0000 RDI:
0000000000000003
[ 4947.849448] RBP: 0000000000000003 R08: 00000000ffffffff R09:
0000000000000000
[ 4947.849448] R10: 0000000000000022 R11: 0000000000000246 R12:
0000000000020000
[ 4947.849449] R13: 0000000000000000 R14: 00007eff009a0000 R15:
0000000000020000
[ 4947.849450]  </TASK>
[ 4947.849450] ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
