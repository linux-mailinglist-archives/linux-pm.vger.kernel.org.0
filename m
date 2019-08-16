Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6541E90853
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfHPTma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:42:30 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14970 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfHPTm2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d57072f0000>; Fri, 16 Aug 2019 12:42:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:42:27 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:27 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:27 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d570721000b>; Fri, 16 Aug 2019 12:42:27 -0700
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
Subject: [PATCH v9 07/22] clk: Add API to get index of the clock parent
Date:   Fri, 16 Aug 2019 12:41:52 -0700
Message-ID: <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984559; bh=+6ERoAACorYaysuYDP8ceYAHJiBt40PUivlQZua8vRY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DnB/En3oXEcmbvugodC0hNEERW5GDrDc61DLqJNPXdjoXD7bTPKtSPlGiZzqQHW1q
         ipxEWonEkrmGjK2Ynbl1rm2Ha/2dqRMKE47knhedZS5sX5Bf2YWsQprdOsp0/gxUTW
         df8/C76py62fO/59Mm1hcgpK6uHAtmDx7cVoWr4B7u/6KajBwi1QkQohvXCjZ7e3mp
         e9a+22TvwgGU066OIW1uDqTe1IT6dkjRmyJQfp9+31BJ7VdE/Q7Ec4qMR5zMvmeCs6
         g4a6vAZ709MUnlhQwOdtwI1wwPR47u74yPakl1+Uik9FGVPsM3nEB7GZ6sd9+2aMpc
         PuwbQPgO9bjZw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds an API clk_hw_get_parent_index to get index of the
clock parent to use during the clock restore operations on system
resume.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/clk.c            | 17 +++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cbcc333aec84..12ad0e9b8591 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1645,6 +1645,23 @@ static int clk_fetch_parent_index(struct clk_core *core,
 	return i;
 }
 
+/**
+ * clk_hw_get_parent_index - return the index of parent clock
+ * @hw: clk_hw associated with the clk being consumed
+ * @parent_hw: clk_hw associated with the parent of clk
+ *
+ * Fetches and returns the index of parent clock.
+ * If hw or parent_hw is NULL, returns -EINVAL.
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
index dce5521a9bf6..cce830780900 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -817,6 +817,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
+int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent_hw);
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
-- 
2.7.4

