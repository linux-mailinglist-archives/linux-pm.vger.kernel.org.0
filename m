Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F9BD11F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbfIXSBV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 14:01:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53794 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389911AbfIXSBU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 14:01:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E2261A0A42;
        Tue, 24 Sep 2019 20:01:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 60E9F1A0767;
        Tue, 24 Sep 2019 20:01:18 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CF4F205ED;
        Tue, 24 Sep 2019 20:01:18 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: Fix icc_onecell_data allocation
Date:   Tue, 24 Sep 2019 21:01:15 +0300
Message-Id: <a7360abb6561917e30bbfaa6084578449152bf1d.1569348056.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a struct with a trailing zero-length array of icc_node pointers
but it's allocated as if it were a single array of icc_nodes instead.

This allocates too much memory at probe time but shouldn't have any
noticeable effect. Both sdm845 and qcs404 are affected.

Fix by replacing kcalloc with kzalloc and using the "struct_size" macro.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

Didn't test beyond compiling, this was found this by reading the code.
---
 drivers/interconnect/qcom/qcs404.c | 3 ++-
 drivers/interconnect/qcom/sdm845.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 910081d6ddc0..b4966d8f3348 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -431,11 +431,12 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
-	data = devm_kcalloc(dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
 				    GFP_KERNEL);
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 57955596bb59..502a6c22b41e 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -788,11 +788,12 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, struct_size(data, nodes, num_nodes),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	provider = &qp->provider;
 	provider->dev = &pdev->dev;
-- 
2.17.1

