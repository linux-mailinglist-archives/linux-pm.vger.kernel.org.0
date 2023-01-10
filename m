Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D566E664186
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 14:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjAJNWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 08:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbjAJNWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 08:22:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED51B9EB
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 05:22:14 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so18402033lfv.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 05:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBGFAAvIVTLZ7wqBvBmVy/pQHR3/8reooL4uATi89Cw=;
        b=FkWAEBxxlG5RsGMbU5xcWURg67RBGiBuoFzUEUXnCzwp3GvhXviQTKJl7I0/xkqtrM
         lCcUAMsbL4FICzuEPK8W0wmzI235jwBMXkFqrnNnupMQTccptUhp1352WHAXCv7KzKAJ
         VCzWrnPo+rI31kM+4eTT5bAHvEGCGcFwt4w4kVGhWj+ETxQavdtt9PrvxLNYdU3jF5eO
         s7rsC1FCGMP4nwE9bLIvw1CGJF841FXXnjr4Htm8EO9cXA3naGowVYSzdgv//+sDsW4M
         KSuetIM9jOEN/n74iA9rXhEM8o7EREIUpb63mYz8kvPkXoX9AzVzCYoe8G+yDNskCC0J
         0YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBGFAAvIVTLZ7wqBvBmVy/pQHR3/8reooL4uATi89Cw=;
        b=Or0xSky7hZtLvUz0mB7pHgzFdTMrnZfrcGY3mKi3jheADCF0/0/792bcFgosPZ2Xzu
         rQb+bVeaWNjRPbYzqPsDs7t6A7sfRpk8Zz2deD/paRvzaZ6dx8qCZcjJijpKa2/uHrxt
         wpdS4ZY4BYGqYf8aASEpnJIkzVc7gj69JtQR/e9CI+jaED6lZTF7cnaCa3l7w/6EmIOx
         aJvNZTKOiY33pzSWSkrUzxkSH+mDwsU/Ru48FgMHSWu7xN876GuZfOdn5B9lk7LkZMpe
         zo5T8I70eUmwPeI7Y9c7fXtlOaQiz8Q5l5oznD3ecneaA4KizGIK+fRsJin6CmBZSsvO
         FV5Q==
X-Gm-Message-State: AFqh2krR055tT7inqNKJiRqO18ys6LG9pIA6/BDyM1OhQpVMN2dLUgn9
        XJ7DFTRs63NJJ1ROG67X1J/I5w==
X-Google-Smtp-Source: AMrXdXvC7XZax+njuxplEpw3sgGlTM3D74JxCma76jB1oZsRFp7gCGpQo6K4LnjB6fYUFPpNCY+0NA==
X-Received: by 2002:a19:2d0f:0:b0:4cc:7c51:bf47 with SMTP id k15-20020a192d0f000000b004cc7c51bf47mr2504986lfj.22.1673356933091;
        Tue, 10 Jan 2023 05:22:13 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] interconnect: qcom: rpm: Add support for specifying channel num
Date:   Tue, 10 Jan 2023 14:21:56 +0100
Message-Id: <20230110132202.956619-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
one channel. This should be taken into account in bandwidth calcualtion,
as we're supposed to feed msmbus with the per-channel bandwidth. Add
support for specifying that and use it during bandwidth aggregation.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 0516b74abdc7..3207b4c99d04 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -336,6 +336,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	int i;
 
 	/* Initialise aggregate values */
@@ -353,7 +354,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
 		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-			agg_avg[i] += qn->sum_avg[i];
+			if (qn->channels)
+				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
+			else
+				sum_avg[i] = qn->sum_avg[i];
+			agg_avg[i] += sum_avg[i];
 			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
 		}
 	}
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 3762648f9d47..eb51680f890d 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -66,6 +66,7 @@ struct qcom_icc_qos {
  * @id: a unique node identifier
  * @links: an array of nodes where we can go next while traversing
  * @num_links: the total number of @links
+ * @channels: number of channels at this node (e.g. DDR channels)
  * @buswidth: width of the interconnect between a node and the bus (bytes)
  * @sum_avg: current sum aggregate value of all avg bw requests
  * @max_peak: current max aggregate value of all peak bw requests
@@ -78,6 +79,7 @@ struct qcom_icc_node {
 	u16 id;
 	const u16 *links;
 	u16 num_links;
+	u16 channels;
 	u16 buswidth;
 	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
-- 
2.39.0

