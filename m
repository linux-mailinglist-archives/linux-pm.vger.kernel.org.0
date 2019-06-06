Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA473767D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 16:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFFOXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 10:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727378AbfFFOXz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 10:23:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE85BAF3B;
        Thu,  6 Jun 2019 14:23:53 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] clk: bcm2835: remove pllb
Date:   Thu,  6 Jun 2019 16:22:49 +0200
Message-Id: <20190606142255.29454-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606142255.29454-1-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Raspberry Pi's firmware controls this pll, we should use the firmware
interface to access it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Eric Anholt <eric@anholt.net>

---

Changes since v1:
  - Add comment to explain why pllb isn't there anymore

 drivers/clk/bcm/clk-bcm2835.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 770bb01f523e..867ae3c20041 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1651,30 +1651,10 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.fixed_divider = 1,
 		.flags = CLK_SET_RATE_PARENT),
 
-	/* PLLB is used for the ARM's clock. */
-	[BCM2835_PLLB]		= REGISTER_PLL(
-		.name = "pllb",
-		.cm_ctrl_reg = CM_PLLB,
-		.a2w_ctrl_reg = A2W_PLLB_CTRL,
-		.frac_reg = A2W_PLLB_FRAC,
-		.ana_reg_base = A2W_PLLB_ANA0,
-		.reference_enable_mask = A2W_XOSC_CTRL_PLLB_ENABLE,
-		.lock_mask = CM_LOCK_FLOCKB,
-
-		.ana = &bcm2835_ana_default,
-
-		.min_rate = 600000000u,
-		.max_rate = 3000000000u,
-		.max_fb_rate = BCM2835_MAX_FB_RATE),
-	[BCM2835_PLLB_ARM]	= REGISTER_PLL_DIV(
-		.name = "pllb_arm",
-		.source_pll = "pllb",
-		.cm_reg = CM_PLLB,
-		.a2w_reg = A2W_PLLB_ARM,
-		.load_mask = CM_PLLB_LOADARM,
-		.hold_mask = CM_PLLB_HOLDARM,
-		.fixed_divider = 1,
-		.flags = CLK_SET_RATE_PARENT),
+	/*
+	 * PLLB is used for the ARM's clock. Controlled by firmware, see
+	 * clk-raspberrypi.c.
+	 */
 
 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
-- 
2.21.0

