Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742C033F09B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCQMjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCQMjQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:16 -0400
Date:   Wed, 17 Mar 2021 12:39:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ilgAwXnfyvrvPymYueacZXnwwUD4HpYW5u896ag4LA=;
        b=ferYmh2Dmnin1PsBuxv3QLiu2H9ZkSA4QQgd+2pEGlCs5D+9wVnPcOR/C36SHareaR8+iU
        eSY9VCJEjtTW0TddU+xm4LU4pNhKUmF2Dc5TkmbeHCKO2L7CT+yCeBG/8GoqADy4zbGSon
        HsuNuFPCGK7IeZs74yTXj7233tn6oxECyPVKuv2MTBEw15P2tpec8kpcYNTuzEfHPMC74v
        +rGxfwsmPkK6voMJSKWorHX+XB6vQq1A/aiyUxUe07h4MR6taQZ7EHHz6j9GrQq/Z0jome
        6bF9IDTIcDBDewh/IigK5dPsUesW+tZn4nVp8V3feOfkUsD60jtCU84T83ZNsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ilgAwXnfyvrvPymYueacZXnwwUD4HpYW5u896ag4LA=;
        b=vv2s0380IA7AcMWJrTmBxQRVzmI2FQcL2sXzD7QJgQVxg+ct1PZvdX6TX+PUhzH4/eomYo
        M3VGGPPprLoOc/BA==
From:   "thermal-bot for Manaf Meethalavalappu Pallikunhi" 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] drivers: thermal: Add NULL pointer check
 before using cooling device stats
Cc:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1607367181-24589-1-git-send-email-manafm@codeaurora.org>
References: <1607367181-24589-1-git-send-email-manafm@codeaurora.org>
MIME-Version: 1.0
Message-ID: <161598475463.398.3494185643778469173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     35c31b81f19728220652d588ed464d75d1a8f05f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//35c31b81f19728220652d588ed464d75d1a8f05f
Author:        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
AuthorDate:    Tue, 08 Dec 2020 00:23:01 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 12:53:23 +01:00

drivers: thermal: Add NULL pointer check before using cooling device stats

There is a possible chance that some cooling device stats buffer
allocation fails due to very high cooling device max state value.
Later cooling device update sysfs can try to access stats data
for the same cooling device. It will lead to NULL pointer
dereference issue.

Add a NULL pointer check before accessing thermal cooling device
stats data. It fixes the following bug

[ 26.812833] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
[ 27.122960] Call trace:
[ 27.122963] do_raw_spin_lock+0x18/0xe8
[ 27.122966] _raw_spin_lock+0x24/0x30
[ 27.128157] thermal_cooling_device_stats_update+0x24/0x98
[ 27.128162] cur_state_store+0x88/0xb8
[ 27.128166] dev_attr_store+0x40/0x58
[ 27.128169] sysfs_kf_write+0x50/0x68
[ 27.133358] kernfs_fop_write+0x12c/0x1c8
[ 27.133362] __vfs_write+0x54/0x160
[ 27.152297] vfs_write+0xcc/0x188
[ 27.157132] ksys_write+0x78/0x108
[ 27.162050] ksys_write+0xf8/0x108
[ 27.166968] __arm_smccc_hvc+0x158/0x4b0
[ 27.166973] __arm_smccc_hvc+0x9c/0x4b0
[ 27.186005] el0_svc+0x8/0xc

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1607367181-24589-1-git-send-email-manafm@codeaurora.org
---
 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 345917a..1c4aac8 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -674,6 +674,9 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 {
 	struct cooling_dev_stats *stats = cdev->stats;
 
+	if (!stats)
+		return;
+
 	spin_lock(&stats->lock);
 
 	if (stats->state == new_state)
