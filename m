Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2E8261D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfHEUdw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 16:33:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHEUdw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 16:33:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4652E608BA; Mon,  5 Aug 2019 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565037231;
        bh=EQpwyTaZLqo/0FlVjz7BjVXvv2QX6kRf2rU72r3sSKo=;
        h=From:To:Cc:Subject:Date:From;
        b=YQLqCyavrSjZaLIy9k/4zyq0wafVpMa/YcHH0w5NKJ44Ytg8bDOY58kWvRrOl8fqp
         76TcWcbF0zcOP7k8YXppQ3x78Rfmse0uOMIXRQVgrs5b8s49CEZotZriRtJAfl3Ckn
         IEeCghUFOPMhOuG0cUDRlmVClqRw4+u8PrOGwQpQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 856C76076C;
        Mon,  5 Aug 2019 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565037230;
        bh=EQpwyTaZLqo/0FlVjz7BjVXvv2QX6kRf2rU72r3sSKo=;
        h=From:To:Cc:Subject:Date:From;
        b=fesrASc4hlP33n5ROrTySwgZhfsOqs1BLFm2PzqvpylY3nuXOIM4/cVG/D6UnQN4Q
         5+HdPtaul0xWvoIuDcQcXG0Ma6VxWlLqosZAhW/w9rM7CpS/TGltdX2bMOdDefx3HU
         Lkai0x8Fbcr+21VATj1hmVGppBmM1sxgFKIdmS+s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 856C76076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v2] drivers: qcom: Add BCM vote macro to header
Date:   Mon,  5 Aug 2019 14:33:46 -0600
Message-Id: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The macro to generate a Bus Controller Manager (BCM) TCS command is used
by the interconnect driver but might also be interesting to other
drivers that need to construct TCS commands for sub processors so move
it out of the sdm845 specific file and into the header.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

Changes in v2:
- Replace a similar BCS_TCS_CMD macro in clk-rpmh.c with the generic one

 drivers/clk/qcom/clk-rpmh.c        | 16 +++-------------
 drivers/interconnect/qcom/sdm845.c | 19 +------------------
 include/soc/qcom/tcs.h             | 21 ++++++++++++++++++++-
 3 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index c3fd632..a32bfae 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/clk-provider.h>
@@ -12,23 +12,13 @@
 #include <linux/platform_device.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
+#include <soc/qcom/tcs.h>
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 
 #define CLK_RPMH_ARC_EN_OFFSET		0
 #define CLK_RPMH_VRM_EN_OFFSET		4
 
-#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
-#define BCM_TCS_CMD_VALID_SHIFT		29
-#define BCM_TCS_CMD_VOTE_MASK		0x3fff
-#define BCM_TCS_CMD_VOTE_SHIFT		0
-
-#define BCM_TCS_CMD(valid, vote)				\
-	(BCM_TCS_CMD_COMMIT_MASK |				\
-	((valid) << BCM_TCS_CMD_VALID_SHIFT) |			\
-	((vote & BCM_TCS_CMD_VOTE_MASK)				\
-	<< BCM_TCS_CMD_VOTE_SHIFT))
-
 /**
  * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
  * @unit: divisor used to convert Hz value to an RPMh msg
@@ -269,7 +259,7 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 	}
 
 	cmd.addr = c->res_addr;
-	cmd.data = BCM_TCS_CMD(enable, cmd_state);
+	cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
 
 	ret = rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
 	if (ret) {
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 4915b78..2181170 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
  *
  */
 
@@ -20,23 +20,6 @@
 #include <soc/qcom/rpmh.h>
 #include <soc/qcom/tcs.h>
 
-#define BCM_TCS_CMD_COMMIT_SHFT		30
-#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
-#define BCM_TCS_CMD_VALID_SHFT		29
-#define BCM_TCS_CMD_VALID_MASK		0x20000000
-#define BCM_TCS_CMD_VOTE_X_SHFT		14
-#define BCM_TCS_CMD_VOTE_MASK		0x3fff
-#define BCM_TCS_CMD_VOTE_Y_SHFT		0
-#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
-
-#define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
-	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
-	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
-	((cpu_to_le32(vote_x) &					\
-	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
-	((cpu_to_le32(vote_y) &					\
-	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
-
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
 
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 262876a..dbf3c88 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
  */
 
 #ifndef __SOC_QCOM_TCS_H__
@@ -53,4 +53,23 @@ struct tcs_request {
 	struct tcs_cmd *cmds;
 };
 
+#define BCM_TCS_CMD_COMMIT_SHFT		30
+#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
+#define BCM_TCS_CMD_VALID_SHFT		29
+#define BCM_TCS_CMD_VALID_MASK		0x20000000
+#define BCM_TCS_CMD_VOTE_X_SHFT		14
+#define BCM_TCS_CMD_VOTE_MASK		0x3fff
+#define BCM_TCS_CMD_VOTE_Y_SHFT		0
+#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
+
+/* Construct a Bus Clock Manager (BCM) specific TCS command */
+#define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
+	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
+	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
+	((cpu_to_le32(vote_x) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
+	((cpu_to_le32(vote_y) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
+
+
 #endif /* __SOC_QCOM_TCS_H__ */
-- 
2.7.4

