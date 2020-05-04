Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA51C481F
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgEDUZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:25:05 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:39407 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728166AbgEDUZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:25:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623904; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dyAHQjbj+/cBM6O9IUUcBIRYNzgSI7OhgoYQIYafOj8=; b=URBcQJqiitHkpfQjBIrgHVCmkIZDNZdcduofIAG8FnUTEqX/0haF4Tla9ifzWLsNSytMsqX1
 mcGm03hb9KyV1oP5Yft53bL5pHyNFs1nsZFJh1UmVuL5apYaNDLWj2BdKWcmCg5ORm4akUoP
 POVeR97qpAho1rUJtsSADPmu96o=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07a1f.7f505694d4c8-smtp-out-n05;
 Mon, 04 May 2020 20:25:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44F41C38565; Mon,  4 May 2020 20:25:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93C8BC00448;
        Mon,  4 May 2020 20:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93C8BC00448
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 10/12] OPP: Add support for setting interconnect-tags
Date:   Tue,  5 May 2020 01:52:41 +0530
Message-Id: <20200504202243.5476-11-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for setting tags on icc paths associated with
the opp_table.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/of.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2b590fe2e69ae..5273b46f11025 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -336,6 +336,7 @@ int _of_find_paths(struct opp_table *opp_table, struct device *dev)
 {
 	struct device_node *np;
 	int ret, i, count, num_paths;
+	u32 tag;
 
 	np = of_node_get(dev->of_node);
 	if (!np)
@@ -343,22 +344,26 @@ int _of_find_paths(struct opp_table *opp_table, struct device *dev)
 
 	count = of_count_phandle_with_args(np, "interconnects",
 					   "#interconnect-cells");
-	of_node_put(np);
-	if (count < 0)
-		return 0;
+	if (count < 0) {
+		ret = 0;
+		goto put_np;
+	}
 
 	/* two phandles when #interconnect-cells = <1> */
 	if (count % 2) {
 		dev_err(dev, "%s: Invalid interconnects values\n",
 			__func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_np;
 	}
 
 	num_paths = count / 2;
 	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
 				   GFP_KERNEL);
-	if (!opp_table->paths)
-		return -ENOMEM;
+	if (!opp_table->paths) {
+		ret = -ENOMEM;
+		goto put_np;
+	}
 
 	for (i = 0; i < num_paths; i++) {
 		opp_table->paths[i] = of_icc_get_by_index(dev, i);
@@ -370,8 +375,14 @@ int _of_find_paths(struct opp_table *opp_table, struct device *dev)
 			}
 			goto err;
 		}
+
+		/* Set tag if present */
+		if (!of_property_read_u32_index(np, "interconnect-tags",
+						i, &tag))
+			icc_set_tag(opp_table->paths[i], tag);
 	}
 	opp_table->path_count = num_paths;
+	of_node_put(np);
 
 	return 0;
 
@@ -381,6 +392,8 @@ int _of_find_paths(struct opp_table *opp_table, struct device *dev)
 
 	kfree(opp_table->paths);
 	opp_table->paths = NULL;
+put_np:
+	of_node_put(np);
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
