Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A314072D
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAQJ6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50416 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgAQJ6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so6810231wmb.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCMDhhcV5Co8iy+iIHE40yl0F53n9N1ZTv4ZVbZXaTE=;
        b=WkASaBpCCtMQpQiYrnAyLL7EXfhipWDs/RyGnHO7GWnpGpuXGACNAfgCvbR2nG95uI
         HJc/lRc3OCKS4/2B05ipoDed7tI10ERAWJL/5281XUsl7mLSNwjPB57/dg9ON0RrWlrU
         M79AIn1fit0gfdfS9XGA1euAANxBYCGsKhTYWR9NaxF5HaxcENxte9GoSSJ8zwJHQg1E
         t9xS5VugIGG+Zlwbm2FBolvx1gdG4djnNGzZ1zZzRqd4W9uyx/kb039P3eQIFNsPmaZC
         Dc2as+WnVyRX8D0ZG8HF5zz+ejJTQLhjVSTJxnVXWfz/gfVAckud51/uF8RO2rd+jcGl
         iMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCMDhhcV5Co8iy+iIHE40yl0F53n9N1ZTv4ZVbZXaTE=;
        b=LuSRzIqg2xquyztRb70WfYwFcOxxT8CjAxQ25s1S6BqrAcGYAy9VqK0l6p8rlrJPbp
         LtvxFG5vpV7SuxfayAxeEJy9OCI6iPUG7IKyMAW8CpRO+bBZb3nnpuuc1C49PBABPe1W
         8EAgYuFIcEahHtma0z2eGFAVaMc5+pnEBPRvpgxn/d9j8X+wLCQe1XuzRxd6I2zeTW0Q
         2IBnIHbOJ23gZVXEBl2QxOV1EzBT4rl2oks5OrxTMfnW/yeja38LaSkPB+V0RnmNRSwf
         RbksUral5K8bO27UNM5W3PocytKbywWdkq+rhc2HIw2K7mjargDyiMhuaH04bCH7zelY
         uHvw==
X-Gm-Message-State: APjAAAU8vwDaza4Y+CWfa58dDftJgc+RYD57513F/81kVi42FkDHZL6A
        42KL4wDNrJ9JJneUEWa/laLxPA==
X-Google-Smtp-Source: APXvYqzjRBo5valf4Bh2cFZL0ciRsfHmmVsJOf1HzVgXjWWXljJyez39HDwladdtbiiJRXkTKhuqUA==
X-Received: by 2002:a1c:1d1:: with SMTP id 200mr3724723wmb.181.1579255107985;
        Fri, 17 Jan 2020 01:58:27 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:27 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 07/12] interconnect: qcom: Use the standard aggregate function
Date:   Fri, 17 Jan 2020 11:58:11 +0200
Message-Id: <20200117095816.23575-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now we have a common function for standard aggregation, so let's use it,
instead of duplicating the code.

Reviewed-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 15 +++------------
 drivers/interconnect/qcom/qcs404.c  | 15 +++------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index e669a1f726d2..3a313e11e73d 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -550,15 +550,6 @@ static struct msm8974_icc_desc msm8974_snoc = {
 	.num_nodes = ARRAY_SIZE(msm8974_snoc_nodes),
 };
 
-static int msm8974_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-				 u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
-{
-	*agg_avg += avg_bw;
-	*agg_peak = max(*agg_peak, peak_bw);
-
-	return 0;
-}
-
 static void msm8974_icc_rpm_smd_send(struct device *dev, int rsc_type,
 				     char *name, int id, u64 val)
 {
@@ -603,8 +594,8 @@ static int msm8974_icc_set(struct icc_node *src, struct icc_node *dst)
 	qp = to_msm8974_icc_provider(provider);
 
 	list_for_each_entry(n, &provider->nodes, node_list)
-		msm8974_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
-				      &agg_avg, &agg_peak);
+		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
+				    &agg_avg, &agg_peak);
 
 	sum_bw = icc_units_to_bps(agg_avg);
 	max_peak_bw = icc_units_to_bps(agg_peak);
@@ -694,7 +685,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = msm8974_icc_set;
-	provider->aggregate = msm8974_icc_aggregate;
+	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index c8eb1276cce8..d4769a5ea182 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -327,15 +327,6 @@ static struct qcom_icc_desc qcs404_snoc = {
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };
 
-static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
-{
-	*agg_avg += avg_bw;
-	*agg_peak = max(*agg_peak, peak_bw);
-
-	return 0;
-}
-
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
@@ -354,8 +345,8 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	qp = to_qcom_provider(provider);
 
 	list_for_each_entry(n, &provider->nodes, node_list)
-		qcom_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
-				   &agg_avg, &agg_peak);
+		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
+				    &agg_avg, &agg_peak);
 
 	sum_bw = icc_units_to_bps(agg_avg);
 	max_peak_bw = icc_units_to_bps(agg_peak);
@@ -456,7 +447,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
-	provider->aggregate = qcom_icc_aggregate;
+	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 
