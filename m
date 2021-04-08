Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B7358239
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhDHLmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhDHLmn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D682F61139;
        Thu,  8 Apr 2021 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882152;
        bh=M9MXm3LXCgSubOTEtwLCtoqMPGuzpyz06oKfcx6beuo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hfkQVUXysIsoJlZQLOPtEnkshGDy51GPs2QD06UFqe1UijiMrOEEDCpt7HRRH0pKk
         YPm+Mm29DRalifNmFUoPhao3C8WNwzwIKWAMYs5hoj/9eOU3ov4KFSJv08aeF2eTq6
         yltAaR8OZesWKLJJV0++7zvv5jG3PKyux2hL9dbAqTmn9LS34ohaNevR7gjSzVY/vW
         A+Rcz4QzAtc88KIDqtDZaY/mc1kC70AeUojUoBRDzYPJPnO4g81agRmwNnQ2LLkF9H
         nWlJPhR5kn68r/tUauCggvZQjvhhTmE5duQ0Y80W4wob0/q6NxS1czzH42O8eg1/am
         I6XLJJJshsBGg==
Received: by pali.im (Postfix)
        id 3358DEDE; Thu,  8 Apr 2021 13:42:30 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 05/10] clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to 1 GHz
Date:   Thu,  8 Apr 2021 13:42:18 +0200
Message-Id: <20210408114223.8471-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It was observed that the workaround introduced by commit 61c40f35f5cd
("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to
1.2GHz") when base CPU frequency is 1.2 GHz is also required when base
CPU frequency is 1 GHz. Otherwise switching CPU frequency directly from
L2 (250 MHz) to L0 (1 GHz) causes a crash.

When base CPU frequency is just 800 MHz no crashed were observed during
switch from L2 to L0.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")
Cc: stable@vger.kernel.org # 61c40f35f5cd ("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz")
---
 drivers/clk/mvebu/armada-37xx-periph.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 6507bd2c5f31..b15e177bea7e 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -487,8 +487,10 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 /*
- * Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
- * respectively) to L0 frequency (1.2 Ghz) requires a significant
+ * Workaround when base CPU frequnecy is 1000 or 1200 MHz
+ *
+ * Switching the CPU from the L2 or L3 frequencies (250/300 or 200 MHz
+ * respectively) to L0 frequency (1/1.2 GHz) requires a significant
  * amount of time to let VDD stabilize to the appropriate
  * voltage. This amount of time is large enough that it cannot be
  * covered by the hardware countdown register. Due to this, the CPU
@@ -498,15 +500,15 @@ static long clk_pm_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
  * To work around this problem, we prevent switching directly from the
  * L2/L3 frequencies to the L0 frequency, and instead switch to the L1
  * frequency in-between. The sequence therefore becomes:
- * 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
+ * 1. First switch from L2/L3 (200/250/300 MHz) to L1 (500/600 MHz)
  * 2. Sleep 20ms for stabling VDD voltage
- * 3. Then switch from L1(600MHZ) to L0(1200Mhz).
+ * 3. Then switch from L1 (500/600 MHz) to L0 (1000/1200 MHz).
  */
 static void clk_pm_cpu_set_rate_wa(unsigned long rate, struct regmap *base)
 {
 	unsigned int cur_level;
 
-	if (rate != 1200 * 1000 * 1000)
+	if (rate < 1000 * 1000 * 1000)
 		return;
 
 	regmap_read(base, ARMADA_37XX_NB_CPU_LOAD, &cur_level);
-- 
2.20.1

