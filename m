Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC03AE66F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhFUJtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhFUJtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:14 -0400
Date:   Mon, 21 Jun 2021 09:46:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uBPTwoVNFnGXXlpME7H0GHqfwFr5lSzFT1YPX0MASc=;
        b=3NUAtZLHK5mHCE4CLH0wJRa6taStjXCmRoz1MuJ+LIeBhbiB0ndOKkYnGuyl3I/tA9gbTp
        zE2+iCW59RLjhG8SDzHIor6S3v58PimwJtsYXjF//5SmJvgXHGQ4AEFCdZUbAicY6NSdgX
        QvaXBIzb2jfGeei/XZQgNwtewLeSs4CvzzdP9itGsCOdkODYYJKzqrZUvffMUTL0/cvttI
        ZaPXX4tKkuXe1lK0ILwctGi9IFztdOkmEZ5LRPguEb+a7vxKuwtAQGCV49yEZKBe8p2/ct
        p8YE2/rER6J4yBqIEsfMKbYYRoSWj/cXzF2ctrZxlLKSKjsj0UOgAvJnCVPTyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uBPTwoVNFnGXXlpME7H0GHqfwFr5lSzFT1YPX0MASc=;
        b=Db/hURTMs2OKEMb2PRp2lThacXUK4OBVjPlK2a6tCiAqzTO3zsvNCIH+x/3VORfHC9SW2V
        +pM6BWdjSO6YqiCA==
From:   "thermal-bot for Chunyan Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/sprd: Add missing MODULE_DEVICE_TABLE
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210512093752.243168-1-zhang.lyra@gmail.com>
References: <20210512093752.243168-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Message-ID: <162426881030.395.11799165463920994375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4d57fd9aeaa013a245bf1fade81e2c30a5efd491
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4d57fd9aeaa013a245bf1fade81e2c30a5efd491
Author:        Chunyan Zhang <chunyan.zhang@unisoc.com>
AuthorDate:    Wed, 12 May 2021 17:37:52 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Jun 2021 11:33:17 +02:00

thermal/drivers/sprd: Add missing MODULE_DEVICE_TABLE

MODULE_DEVICE_TABLE is used to extract the device information out of the
driver and builds a table when being compiled. If using this macro,
kernel can find the driver if available when the device is plugged in,
and then loads that driver and initializes the device.

Fixes: 554fdbaf19b18 ("thermal: sprd: Add Spreadtrum thermal driver support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210512093752.243168-1-zhang.lyra@gmail.com
---
 drivers/thermal/sprd_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 3682edb..fe06ccc 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -532,6 +532,7 @@ static const struct of_device_id sprd_thermal_of_match[] = {
 	{ .compatible = "sprd,ums512-thermal", .data = &ums512_data },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, sprd_thermal_of_match);
 
 static const struct dev_pm_ops sprd_thermal_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sprd_thm_suspend, sprd_thm_resume)
