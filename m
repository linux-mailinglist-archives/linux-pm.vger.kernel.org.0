Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89D86E66
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405102AbfHHXsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:48:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17846 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404857AbfHHXrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb47a0000>; Thu, 08 Aug 2019 16:47:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 16:47:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:04 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:03 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4770002>; Thu, 08 Aug 2019 16:47:03 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v8 07/21] clk: Add API to get index of the clock parent
Date:   Thu, 8 Aug 2019 16:46:46 -0700
Message-ID: <1565308020-31952-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308026; bh=EiTuhKMOCGYA8wAQ23vYtJnhT0+JOt4gE1tR3JSN/XE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oe0c2wg2BrQE/iJ/ajYhjulg5iTeSqw18Bz5Su2y6XE+7MAuXbftpoueJxPrr5x69
         0B9sKUb2SN4w4AeEFXNDTWDlGyiAtxXGOgiUYrVl7jZLfc0cwcSdGMsdG6Ma3LLzfx
         tbCJUK7WGfbKgiGo+VR8sUIUwWW5mFj+TNDak6QJczQvYY7QCvyQyFpS9mGglESRVK
         FthWIu9EsYVG3yLXtXV8QPLTbKm2/Q4dss5RB5STogtaNnumilX0/X6IOGx1Xzrjux
         pPP8mb6bcQKnPUdyGC837kbjWSwWw3ChrJAaP8pz/8YyWYaUy/zq53PgbuyfZR1KuD
         EEpBmsqulocXw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds an API clk_hw_get_parent_index to get index of the
clock parent to use during the clock restore operations on system
resume.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/clk.c            | 17 +++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..f26252e48f73 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1643,6 +1643,23 @@ static int clk_fetch_parent_index(struct clk_core *core,
 	return i;
 }
 
+/**
+ * clk_hw_get_parent_index - return the index of parent clock
+ * @hw: clk_hw associated with the clk being consumed
+ * @parent_hw: clk_hw associated with the parent of clk
+ *
+ * Fetches and returns the index of parent clock.
+ * if hw or parent_hw is NULL, returns -EINVAL.
+ */
+int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent_hw)
+{
+	if (!hw || !parent_hw)
+		return -EINVAL;
+
+	return clk_fetch_parent_index(hw->core, parent_hw->core);
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
+
 /*
  * Update the orphan status of @core and all its children.
  */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2ae7604783dd..477112946dd2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -817,6 +817,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
+int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent_hw);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
-- 
2.7.4

