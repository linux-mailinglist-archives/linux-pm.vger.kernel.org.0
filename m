Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E591D4719C1
	for <lists+linux-pm@lfdr.de>; Sun, 12 Dec 2021 12:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhLLLUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Dec 2021 06:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhLLLUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Dec 2021 06:20:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F20C0613F8
        for <linux-pm@vger.kernel.org>; Sun, 12 Dec 2021 03:20:37 -0800 (PST)
Date:   Sun, 12 Dec 2021 11:20:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639308035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9lD2sk9EYibliNff2r6+rl1Rz/hmmGUy+iovuZTPMI=;
        b=GMM2S1z25LHZ/EUG7S0dno1TewIngIXXfYOtzIehWaRnjOoWDxYppF7tip9Kw+k0XhVpxf
        zCyeRXf15FA26H7BIeOnU9iFemgJifqUGITmm0l2ArHKhk1rZKB7h+YIA5Z/HXZwkj/bK7
        0qmLgsS/Zn4ffjNWo43D9rAIYtExF/kD6d5tozINhp/mjgJo5Tu+llzonVoHp6NzjUO/Aa
        eU8NLQhwvZACrbMWYEx6hasv4vy37u0deNMg6A+Y49UKGEQ4DXZZvNpPkl3tBtB/5T8tqq
        462YeYMZV9RC84gnj3jCvN68cAuHqOKHJCOFY4mUTkiS4vbo/BLVn2LQSvx2Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639308035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9lD2sk9EYibliNff2r6+rl1Rz/hmmGUy+iovuZTPMI=;
        b=BcEG7HGqp2WwkFCowYcNGdoAaHMLwGuwMvDL9BeV/gOYdi2HtMwk7HgzRWIuUKZ2xMf6jK
        NsKvdRzBN2X0rjDg==
From:   "thermal-bot for Paul Gerber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/imx8mm: Enable ADC when
 enabling monitor
Cc:     Paul Gerber <Paul.Gerber@tq-group.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
References: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Message-ID: <163930803412.23020.11036902330313833239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3de89d8842a2b5d3dd22ebf97dd561ae0a330948
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3de89d8842a2b5d3dd22ebf97dd561ae0a330948
Author:        Paul Gerber <Paul.Gerber@tq-group.com>
AuthorDate:    Mon, 22 Nov 2021 12:42:25 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 02 Dec 2021 11:12:24 +01:00

thermal/drivers/imx8mm: Enable ADC when enabling monitor

The i.MX 8MP has a ADC_PD bit in the TMU_TER register that controls the
operating mode of the ADC:
* 0 means normal operating mode
* 1 means power down mode

When enabling/disabling the TMU, the ADC operating mode must be set
accordingly.

i.MX 8M Mini & Nano are lacking this bit.

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Fixes: 2b8f1f0337c5 ("thermal: imx8mm: Add i.MX8MP support")
Link: https://lore.kernel.org/r/20211122114225.196280-1-alexander.stein@ew.tq-group.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx8mm_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 7442e01..af666bd 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -21,6 +21,7 @@
 #define TPS			0x4
 #define TRITSR			0x20	/* TMU immediate temp */
 
+#define TER_ADC_PD		BIT(30)
 #define TER_EN			BIT(31)
 #define TRITSR_TEMP0_VAL_MASK	0xff
 #define TRITSR_TEMP1_VAL_MASK	0xff0000
@@ -113,6 +114,8 @@ static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
 
 	val = readl_relaxed(tmu->base + TER);
 	val = enable ? (val | TER_EN) : (val & ~TER_EN);
+	if (tmu->socdata->version == TMU_VER2)
+		val = enable ? (val & ~TER_ADC_PD) : (val | TER_ADC_PD);
 	writel_relaxed(val, tmu->base + TER);
 }
 
