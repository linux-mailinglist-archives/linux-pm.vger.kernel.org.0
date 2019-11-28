Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413C310C9CE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 14:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfK1Nsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 08:48:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34886 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfK1Nsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 08:48:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id n5so11748462wmc.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+9lLzA6tYXl6Vs9wqUuF2Bk1fla14D0jQAd3Lh6NWE=;
        b=ZeoJzVb9ioAAkeIhCTK8cIY6q3updyUVGelzHsYoR1wl03/0dEVMtb6UDeUP1sX/55
         SxLFvJ5x1b79o2X4gs1K3n/3NzKn1zTm2A0RyoWwGwTfT2a6aOKxJLFaA/RYnGixcqpG
         SR/EowZJO0/P9f9uYhS3MSkTKM8OwZOVdrw++9+gZPTaEaI7qt9wveKIzRxnt1m6aP1c
         WyKq8qmYwoyINdTyqulOCXkM+2kg5T/awkMiRN6aXV0BivBCpcIip+ieUtOTRIdXF9Yr
         y+2qubfrqtJYBblSJZwU4GnqQkPjKEGuwAejEsFBVaF3gUJ0B2XRVFeBg6jhsoMbq3iU
         U8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+9lLzA6tYXl6Vs9wqUuF2Bk1fla14D0jQAd3Lh6NWE=;
        b=aOPS68PfE+66T9r/n6paXqs804p6uZygXG9Z3uBRqXTQFk++YZqniEonUe/wuMDDEI
         6Mk29Yrl2nqd3pl8B2juEFLZuit26ERm7urAr4wugvHfwAm5i5UhMplFXlDyjQwR8Shi
         g+mqjRlArkjSEAy1YumQ5vo0jWaVAz5mGEiLRHe4EDQ14Sb8sm3Xgg/aMx0uC6s48TnD
         CaCapkpPOuKg+n9jAj2Q8+QTBIK4tVwTSz0WtT7+ZoFCUaHINeTlfuBqDbCon0fIsBkM
         dAiExwHdufB43EyVItKBos/TOdvdOK6YkSq+QGNlBTyjOqE/KQ9wFgQdjbgbRtW24PE0
         p9sQ==
X-Gm-Message-State: APjAAAVNoo5nYN0wCpMF2OcpovJ5Yy574Qr8zGAieEyafXKg8QcGJa5a
        xoyc+OdVqe5nZYLU0CH6ubAuEnOiWrQ=
X-Google-Smtp-Source: APXvYqx893KX5X1qljg2pe226q0Tjt5gya+f21cHdySFX/8fWZ2rys9ahSyS/AlO16MbDm+lV2dAdA==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr9861214wmk.8.1574948922009;
        Thu, 28 Nov 2019 05:48:42 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m3sm8523734wrs.53.2019.11.28.05.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:48:41 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        agross@kernel.org, daidavid1@codeaurora.org, masneyb@onstation.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH 2/2] interconnect: qcom: Use the standard aggregate function
Date:   Thu, 28 Nov 2019 15:48:39 +0200
Message-Id: <20191128134839.27606-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128134839.27606-1-georgi.djakov@linaro.org>
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now we have a common function for standard aggregation, so let's use it,
instead of duplicating the code.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 15 +++------------
 drivers/interconnect/qcom/qcs404.c  | 15 +++------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 8823dce811c3..bf724c2ca02b 100644
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
@@ -703,7 +694,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = msm8974_icc_set;
-	provider->aggregate = msm8974_icc_aggregate;
+	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index a4c6ba715f61..ce2e6faa3a79 100644
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
@@ -465,7 +456,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
-	provider->aggregate = qcom_icc_aggregate;
+	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 
