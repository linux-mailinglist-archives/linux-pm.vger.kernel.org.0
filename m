Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0222691A78
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjBJI6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 03:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjBJI6S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 03:58:18 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27FAAD08
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 00:58:16 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so4907465pjw.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 00:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmjWtBwFu8z3teuWatWO9DtcrFQXpGgJJ5YvUUDkxBs=;
        b=mJIQv+a6IAsM0CzdovFB7LmAqgOHEsKYodZl8zNQz6ntV/haxclHVBttmZpjNTu7Wt
         +Y4QL/176Y9D5tNvGTgTAiDDawKGjUOXcko99+C8AXYkIyoo9GLQgd0jYsgO2ZM7v7n8
         22zZ35PAU6HQ9ycfR6bfdhOX7A04XDZJSyax77PO1p7j2aht/DsxJ999+sqYE9ES3697
         Nrhuwe5uHZvhCFQGznyJQbZV+9my8RwjSW8cz/+X4+kMT8AwR7Ppa7ovDgZajaNoackN
         uPF+NpvXRyoAQ8YuHR2prtkQMAlbq+iLHCYJ01QfODLxssnZtjGHd0kSCAviiU/aJJXF
         KiBA==
X-Gm-Message-State: AO0yUKXWVeuHLgfcWzDMDdfDEpTmAJBfD8/zzJUEIJE10BBMYPO6LTEA
        xvPtMdKxS0mYMf4CLF/mLEw=
X-Google-Smtp-Source: AK7set/rlm29FTVH2EyofgCWQ9SeWWe0Pb7hoMLEPW2PWaUhaPIns/cBaaVo5zf6H44e0NGGOV5l6A==
X-Received: by 2002:a05:6a20:8e19:b0:b8:84d2:f9aa with SMTP id y25-20020a056a208e1900b000b884d2f9aamr10260065pzj.2.1676019496095;
        Fri, 10 Feb 2023 00:58:16 -0800 (PST)
Received: from tgsp-ThinkPad-X280.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090302d100b00198e346c35dsm2910291plk.9.2023.02.10.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 00:58:15 -0800 (PST)
From:   xiongxin <xiongxin@kylinos.cn>
To:     mark.rutland@arm.com, lpieralisi@kernel.org, kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, xiongxin <xiongxin@kylinos.cn>,
        Tian Yaxiong <tianyaxiong@kylinos.cn>,
        Wei Yufeng <weiyufeng@kylinos.cn>
Subject: [PATCH] firmware/psci: add .begin implementation for psci_suspend_ops
Date:   Fri, 10 Feb 2023 16:58:04 +0800
Message-Id: <20230210085804.1756449-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

nvme_suspend() in the nvme pci driver will call
pm_suspend_via_firmware() to determine whether to use the suspend to
idle mode or other suspend, the code show as below:

static int nvme_suspend(struct device *dev)
{
	...
	if (pm_suspend_via_firmware() || !ctrl->npss ||
	    !pcie_aspm_enabled(pdev) ||
	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
		return nvme_disable_prepare_reset(ndev, true);

	... /* suspend to idle mode */
}

The current ARM64 suspend process does not call the
pm_set_suspend_via_firmware() function, so when PCIe ASPM is enabled,
the nvme suspend process under the ARM64 platform will enter the suspend
to idle mode (the irq free is not called), which will cause the nvme
driver to report the following irq warning during the resume process:

[  189.233188] ------------[ cut here ]------------
[  189.237791] Unbalanced enable for IRQ 52
[  189.241705] WARNING: CPU: 0 PID: 2086 at kernel/irq/manage.c:781 __enable_irq+0x54/0x88
[  189.249700] Modules linked in: nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device snd_timer snd joydev input_leds efi_pstore soundcore sch_fq_codel ppdev lp parport ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq libcrc32c raid1 raid0 multipath linear amdgpu gpu_sched drm_buddy radeon video drm_ttm_helper ttm i2c_algo_bit drm_display_helper cec drm_kms_helper syscopyarea sysfillrect sysimgblt hid_generic drm nvme crct10dif_ce ghash_ce usbhid sha2_ce sha256_arm64 hid nvme_core sha1_ce ahci libahci aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
[  189.321740] CPU: 0 PID: 2086 Comm: systemd-sleep Not tainted 6.2.0-rc7+ #9
[  189.328601] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS KunLun BIOS V4.0 01/19/2021
[  189.337543] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  189.344490] pc : __enable_irq+0x54/0x88
[  189.348313] lr : __enable_irq+0x54/0x88
[  189.352136] sp : ffff80000d58bb00
[  189.355436] x29: ffff80000d58bb00 x28: ffff80000a355a54 x27: ffff001f809910dc
[  189.362559] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[  189.369681] x23: 0000000000000001 x22: 0000000000000000 x21: ffff80000a0d2860
[  189.376803] x20: 0000000000000034 x19: ffff001f80991000 x18: 0000000000000010
[  189.383924] x17: 0000000000000000 x16: 0000000000000400 x15: ffff001f87612578
[  189.391047] x14: 0000000000000000 x13: 3235205152492072 x12: 6f6620656c62616e
[  189.398168] x11: 00000000ffffdfff x10: 00000000ffffdfff x9 : ffff80000823788c
[  189.405291] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 0000000000000001
[  189.412412] x5 : ffff0020f6f0cb08 x4 : 0000000000000000 x3 : 0000000000000027
[  189.419534] x2 : ffff0020f6f0cb10 x1 : 0000000000000000 x0 : 0000000000000000
[  189.426656] Call trace:
[  189.429089]  __enable_irq+0x54/0x88
[  189.432566]  resume_irqs+0x118/0x210
[  189.436129]  resume_device_irqs+0x1c/0x48
[  189.440125]  dpm_resume_noirq+0x1c/0x30
[  189.443951]  suspend_devices_and_enter+0x218/0x8c8
[  189.448731]  pm_suspend+0x31c/0x420
[  189.452207]  state_store+0x94/0x118
[  189.455684]  kobj_attr_store+0x18/0x30
[  189.459421]  sysfs_kf_write+0x4c/0x60
[  189.463073]  kernfs_fop_write_iter+0x130/0x1c0
[  189.467504]  vfs_write+0x284/0x358
[  189.470893]  ksys_write+0x74/0x108
[  189.474282]  __arm64_sys_write+0x24/0x30
[  189.478191]  invoke_syscall+0x4c/0x110
[  189.481930]  el0_svc_common.constprop.0+0x58/0x190
[  189.486708]  do_el0_svc+0x40/0xb8
[  189.490011]  el0_svc+0x2c/0xb8
[  189.493053]  el0t_64_sync_handler+0xb8/0xc0
[  189.497223]  el0t_64_sync+0x1a4/0x1a8
[  189.500872] ---[ end trace 0000000000000000 ]---
...

Implement pm_set_suspend_via_firmware() in PSCI psci_suspend_ops.begin()
for ARM64, so that when doing the suspend process, it will directly
enter the nvme_disable_prepare_reset() process.

Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: Tian Yaxiong <tianyaxiong@kylinos.cn>
Signed-off-by: Wei Yufeng <weiyufeng@kylinos.cn>

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 447ee4ea5c90..90d6102d45d7 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -484,6 +484,13 @@ static int psci_system_suspend(unsigned long unused)
 			      pa_cpu_resume, 0, 0);
 }
 
+static int psci_system_suspend_begin(suspend_state_t state)
+{
+	pm_set_suspend_via_firmware();
+
+	return 0;
+}
+
 static int psci_system_suspend_enter(suspend_state_t state)
 {
 	return cpu_suspend(0, psci_system_suspend);
@@ -491,6 +498,7 @@ static int psci_system_suspend_enter(suspend_state_t state)
 
 static const struct platform_suspend_ops psci_suspend_ops = {
 	.valid          = suspend_valid_only_mem,
+	.begin		= psci_system_suspend_begin,
 	.enter          = psci_system_suspend_enter,
 };
 
-- 
2.34.1

