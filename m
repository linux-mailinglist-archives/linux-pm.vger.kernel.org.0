Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48A45DFFD
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhKYRxH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 12:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242201AbhKYRvG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Nov 2021 12:51:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9DD6610F8;
        Thu, 25 Nov 2021 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637862475;
        bh=XpDIv730mgFE1qt/Qxxr4XwiiISkabpqqXicAdNUWXw=;
        h=From:To:Cc:Subject:Date:From;
        b=d3cxN6e/BR+AWWg5G61DNnT/M6twroFnUFGdMJgWN/g9bUV9bAsMExx+N4LydMgB+
         EbCsMGydcGljISBYAh61JdxpPqq/ANOfxf2Y7yV7jjpddUxjxWC1FQNuI4GgX3n003
         QARwNe2+fjuGVAmgNbjqqtOYYdsA9idAIvrRNYHheYxtngRzU0D38O7/500+8XBVqS
         bz6Qfz6MhPBAxMrldLyJJzCpjABmwRjPA01WESyfLHhPsbVEN23abRkCc5W2XiilWZ
         DdU3H2XYlqCjYkVwINyx78HYD+ZVVlZPH8Mir2s9ZPusEwIZA1HOW6BI9h+b6IlywH
         C/XVULDWSyleg==
From:   Georgi Djakov <djakov@kernel.org>
To:     djakov@kernel.org, quic_mdtipton@quicinc.com,
        okukatla@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate
Date:   Thu, 25 Nov 2021 19:47:51 +0200
Message-Id: <20211125174751.25317-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Tipton <mdtipton@codeaurora.org>

We're only adding BCMs to the commit list in aggregate(), but there are
cases where pre_aggregate() is called without subsequently calling
aggregate(). In particular, in icc_sync_state() when a node with initial
BW has zero requests. Since BCMs aren't added to the commit list in
these cases, we don't actually send the zero BW request to HW. So the
resources remain on unnecessarily.

Add BCMs to the commit list in pre_aggregate() instead, which is always
called even when there are no requests.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
[georgi: remove icc_sync_state for platforms with incomplete support]
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
v3:
* This patch lowers the power consumption of the boards that have
  (almost) full interconnect support enabled in their client drivers.
  This might cause however issues on platforms with very minimal
  interconnect support that have the sync_state callback set.
  We remove the sync_state callback for these platforms to prevent
  them from turning off any interconnects that have no clients yet.

v2: https://lore.kernel.org/lkml/20210721175432.2119-5-mdtipton@codeaurora.org/

 drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
 drivers/interconnect/qcom/sm8150.c   |  1 -
 drivers/interconnect/qcom/sm8250.c   |  1 -
 drivers/interconnect/qcom/sm8350.c   |  1 -
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3eb7936d2cf6..2c8e12549804 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -21,13 +21,18 @@ void qcom_icc_pre_aggregate(struct icc_node *node)
 {
 	size_t i;
 	struct qcom_icc_node *qn;
+	struct qcom_icc_provider *qp;
 
 	qn = node->data;
+	qp = to_qcom_provider(node->provider);
 
 	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
 		qn->sum_avg[i] = 0;
 		qn->max_peak[i] = 0;
 	}
+
+	for (i = 0; i < qn->num_bcms; i++)
+		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
 }
 EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
 
@@ -45,10 +50,8 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 {
 	size_t i;
 	struct qcom_icc_node *qn;
-	struct qcom_icc_provider *qp;
 
 	qn = node->data;
-	qp = to_qcom_provider(node->provider);
 
 	if (!tag)
 		tag = QCOM_ICC_TAG_ALWAYS;
@@ -68,9 +71,6 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	*agg_avg += avg_bw;
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
-	for (i = 0; i < qn->num_bcms; i++)
-		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_icc_aggregate);
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 2a85f53802b5..745e3c36a61a 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -535,7 +535,6 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8150",
 		.of_match_table = qnoc_of_match,
-		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 8dfb5dea562a..aa707582ea01 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -551,7 +551,6 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
-		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 3e26a2175b28..c79f93a1ac73 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -531,7 +531,6 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
-		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
