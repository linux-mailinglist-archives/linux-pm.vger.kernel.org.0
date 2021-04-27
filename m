Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1C36CBE0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhD0TpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbhD0TpL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:11 -0400
Date:   Tue, 27 Apr 2021 19:44:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7inlQs/bLEtN/Xd3HbVKP9XEOv6hNTfZ35LVzWsXy5Q=;
        b=VPdRmhVFvrkDmSd/2jb0dAlmYK/CVyj+5uqWmBJtA55Wg2SYJRvcQC54Spw1mahZgqernP
        lYuCKQhB2zb/Q6U00b0AiLVL5MzR/5GQHzlgWnZtbcFoVhUoMRMcYB+3Im/PVL6je8ejvH
        T4jZ3YQDgVXCwyXrbeTpt5LU3pUu88b0p5oXnQxJA4HGzvy/Gk/O4FlScVyhGqA4OGo42r
        L2fGpB4haDeYpJe0X4xU+xrtMV0tNSsvguh4QZO8lKCADYXPftya6kUM7k3xPdebOZu5K/
        /5e/yvsHnuqjQ2PilQHcNjo5bId6JTBsXMYDdDjhG/57Y6+6DhyqSFXZt5qGYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7inlQs/bLEtN/Xd3HbVKP9XEOv6hNTfZ35LVzWsXy5Q=;
        b=nyolchZULmXdhjB+X8GK+1a9RcjjazJG2cNNWB/sv4Orje9SMQWn/3zmuKchxeEEV85km6
        xU9rISpfWz6KahDw==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Drop unused define for msm8960
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210420183343.2272-8-ansuelsmth@gmail.com>
References: <20210420183343.2272-8-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161955266642.29796.6763095510198688989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2ebd0982e6ba69d9f9c02a4a0aab705a5526283e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2ebd0982e6ba69d9f9c02a4a0aab705a5526283e
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:33:41 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 14:10:08 +02:00

thermal/drivers/tsens: Drop unused define for msm8960

Drop unused define for msm8960 replaced by generic api and reg_field.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210420183343.2272-8-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens-8960.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 58112f0..67c1748 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -10,8 +10,6 @@
 #include <linux/thermal.h>
 #include "tsens.h"
 
-#define CAL_MDEGC		30000
-
 #define CONFIG_ADDR		0x3640
 #define CONFIG_ADDR_8660	0x3620
 /* CONFIG_ADDR bitmasks */
@@ -21,39 +19,19 @@
 #define CONFIG_SHIFT_8660	28
 #define CONFIG_MASK_8660	(3 << CONFIG_SHIFT_8660)
 
-#define STATUS_CNTL_ADDR_8064	0x3660
 #define CNTL_ADDR		0x3620
 /* CNTL_ADDR bitmasks */
 #define EN			BIT(0)
 #define SW_RST			BIT(1)
-#define SENSOR0_EN		BIT(3)
+
 #define MEASURE_PERIOD		BIT(18)
 #define SLP_CLK_ENA		BIT(26)
 #define SLP_CLK_ENA_8660	BIT(24)
 #define SENSOR0_SHIFT		3
 
-/* INT_STATUS_ADDR bitmasks */
-#define MIN_STATUS_MASK		BIT(0)
-#define LOWER_STATUS_CLR	BIT(1)
-#define UPPER_STATUS_CLR	BIT(2)
-#define MAX_STATUS_MASK		BIT(3)
-
 #define THRESHOLD_ADDR		0x3624
-/* THRESHOLD_ADDR bitmasks */
-#define THRESHOLD_MAX_LIMIT_SHIFT	24
-#define THRESHOLD_MIN_LIMIT_SHIFT	16
-#define THRESHOLD_UPPER_LIMIT_SHIFT	8
-#define THRESHOLD_LOWER_LIMIT_SHIFT	0
-
-/* Initial temperature threshold values */
-#define LOWER_LIMIT_TH		0x50
-#define UPPER_LIMIT_TH		0xdf
-#define MIN_LIMIT_TH		0x0
-#define MAX_LIMIT_TH		0xff
 
 #define INT_STATUS_ADDR		0x363c
-#define TRDY_MASK		BIT(7)
-#define TIMEOUT_US		100
 
 #define S0_STATUS_OFF		0x3628
 #define S1_STATUS_OFF		0x362c
