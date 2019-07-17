Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B105C6BF5A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGQPxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 11:53:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQPxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 11:53:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8618660159; Wed, 17 Jul 2019 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563378798;
        bh=neGF5FCENe6mEc6GArZIeGpuo6QccxA0L5Slvsy0ytU=;
        h=From:To:Cc:Subject:Date:From;
        b=M3Ni/Dqjle3iHnjI78cK4D5tQKQixrIpLLXoW3oy++K3PWkYs9dU7JsSbUX03bvzm
         zXx0OwigUZ2lPAj3+7E5Ll6ABls0M4xcZHxgH8/fX0K9cbb8OilM0IvVqtd9Dh+ZfR
         62RR9eezE6iiPLtQ6fti5/Qq9jZ0oEpIJ08SpllU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC9EE6072E;
        Wed, 17 Jul 2019 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563378797;
        bh=neGF5FCENe6mEc6GArZIeGpuo6QccxA0L5Slvsy0ytU=;
        h=From:To:Cc:Subject:Date:From;
        b=YAO018CN2k4FCloPKulgx4Y9bWyS5Pw0CAz+cVs2F+PPTo9c/FPeSl3LG1PaumX3q
         dRmoWnR+Imc/NjLnxV/aajAwq1WxP5VYxePipvXXicNE6+qP5azXCOREGGWWr4wH7I
         7L7tE4o45tx1RbDJzlhJsZ4Ip6ZDfhvYFW6Zudy4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC9EE6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     ilina@codeaurora.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] qcom: Add BCM vote macro to TCS header
Date:   Wed, 17 Jul 2019 09:53:13 -0600
Message-Id: <1563378793-22023-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The A6XX family of Adreno GPUs use a microcontroller to control the
GPU clock independently. The microcontroller also has the capability
to vote for the bus but doesn't currently do so except for one initial
vote that is hard coded [1].

Currently there is no good way to construct a valid TCS command outside
of the inner workings of the QCOM interconnect driver which is something
that will need to be addressed for the next generation of GPU drivers.

To start the process, this change moves the TCS command macros from the
sdm845 interconnect driver into a soc specific header to make it available
for future efforts into this area.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/msm/adreno/a6xx_hfi.c#n219

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/interconnect/qcom/sdm845.c | 17 -----------------
 include/soc/qcom/tcs.h             | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 4915b78..79b6f01 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
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
index 262876a..6012a9e 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -53,4 +53,21 @@ struct tcs_request {
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
+#define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
+	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
+	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
+	((cpu_to_le32(vote_x) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
+	((cpu_to_le32(vote_y) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
+
 #endif /* __SOC_QCOM_TCS_H__ */
-- 
2.7.4

