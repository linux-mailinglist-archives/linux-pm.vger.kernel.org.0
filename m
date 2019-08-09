Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2387984
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406753AbfHIMNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:13:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35838 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406740AbfHIMNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:13:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so69323151lfa.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nv77OQJ4wAginoyVflZ1aiIA0B/xXdKVZ4ai4MBEt/c=;
        b=LgxYjcaR5YDWLbczNxlYJ+ENOQue2F1rKRf6UcnXKkf4cMmIZq4pU4re9Rux9DbPaB
         fn76unZBnCbuKzUzw01bavZPktY7qjHLyTX6Pew0q54Pk8PZN92wx6OX/iyKu/DOl00L
         MXSRNGh0aImXRL6ZKcma19q5FCK+S+DB5pQDvTyEcy7smyrWq4jxWDywgTc1gP8yhhfu
         eXgCZ0LpWd0PxxmnMqS/llh76pspoRE8iXMlw9YD008bg6Y5NO3Dhm/ITfPfsdA9y20k
         /bE5lM9d2ZXU+dV0wEiU7hVppoqgf+RpkpgtFxP8MOudphIUY1apDkCi0OHaRqkrolRF
         tEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nv77OQJ4wAginoyVflZ1aiIA0B/xXdKVZ4ai4MBEt/c=;
        b=QSk56tesMZgaYNKW9ItUBKFJRa/keFLWWJDGBjqCc/+0cdhhKRoBIH3tzC0ifl8KkH
         5OFbUX7mx8Y2jI3+vFneVZOOoUmMyG9ju5SlhIVrQMjcCn5eirayoPf6h+hpSC0+hpYh
         kso+lJH6u2bUjoLiL0qqa4kvd3bmoHDNXo5TV/wkArIMFT7pyCb3KKKdq7WMTEJLqOO7
         kRPrrkkP65ze1khP9af7ItcYuaT3Y5tJzd9ZWKfJRCwJXvtHtWha/oqSOP3tSEYnp5hk
         LN9uGFvmBY9Nh4wVz5q0vCQRILkn4G3C46nEN3nG2DLQlVCvmZEb5LmzjDcYabfROSeg
         uyvQ==
X-Gm-Message-State: APjAAAWrQj2DHpTTR0CeH03KqHkkr6COXueELB0d40s+Mq2qVNmc+9SU
        rTBwi1aqCGHR44jp2am3CcBWg/GUj5U=
X-Google-Smtp-Source: APXvYqxFUkwTLM0yLzNMJVzI2IUjEvXWAw83CsS+OyA4NffQkZuiECZmFZqLY33hbjy/3anmrtYFNA==
X-Received: by 2002:a19:f819:: with SMTP id a25mr13239881lff.183.1565352812618;
        Fri, 09 Aug 2019 05:13:32 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id f23sm1083425lfc.25.2019.08.09.05.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 05:13:32 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v3 3/3] interconnect: qcom: Add tagging and wake/sleep support for sdm845
Date:   Fri,  9 Aug 2019 15:13:25 +0300
Message-Id: <20190809121325.8138-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809121325.8138-1-georgi.djakov@linaro.org>
References: <20190809121325.8138-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add support for wake and sleep commands by using a tag to indicate
whether or not the aggregate and set requests fall into execution
state specific bucket.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 134 ++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 31 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index fb526004c82e..b2047d1c6d84 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -66,6 +66,17 @@ struct bcm_db {
 #define SDM845_MAX_BCM_PER_NODE	2
 #define SDM845_MAX_VCD		10
 
+#define QCOM_ICC_BUCKET_AMC		0
+#define QCOM_ICC_BUCKET_WAKE		1
+#define QCOM_ICC_BUCKET_SLEEP		2
+#define QCOM_ICC_NUM_BUCKETS		3
+#define QCOM_ICC_TAG_AMC		BIT(QCOM_ICC_BUCKET_AMC)
+#define QCOM_ICC_TAG_WAKE		BIT(QCOM_ICC_BUCKET_WAKE)
+#define QCOM_ICC_TAG_SLEEP		BIT(QCOM_ICC_BUCKET_SLEEP)
+#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
+#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
+					 QCOM_ICC_TAG_SLEEP)
+
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
@@ -86,8 +97,8 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg;
-	u64 max_peak;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
 	struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
 	size_t num_bcms;
 };
@@ -112,8 +123,8 @@ struct qcom_icc_bcm {
 	const char *name;
 	u32 type;
 	u32 addr;
-	u64 vote_x;
-	u64 vote_y;
+	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
+	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
@@ -555,7 +566,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 		cmd->wait = true;
 }
 
-static void tcs_list_gen(struct list_head *bcm_list,
+static void tcs_list_gen(struct list_head *bcm_list, int bucket,
 			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
 			 int n[SDM845_MAX_VCD])
 {
@@ -573,8 +584,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
 			commit = true;
 			cur_vcd_size = 0;
 		}
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
-			    bcm->addr, commit);
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
+			    bcm->vote_y[bucket], bcm->addr, commit);
 		idx++;
 		n[batch]++;
 		/*
@@ -595,51 +606,76 @@ static void tcs_list_gen(struct list_head *bcm_list,
 
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
-	size_t i;
-	u64 agg_avg = 0;
-	u64 agg_peak = 0;
+	size_t i, bucket;
+	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
+	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
 	u64 temp;
 
-	for (i = 0; i < bcm->num_nodes; i++) {
-		temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-		agg_avg = max(agg_avg, temp);
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			agg_avg[bucket] = max(agg_avg[bucket], temp);
 
-		temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth);
-		agg_peak = max(agg_peak, temp);
-	}
+			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth);
+			agg_peak[bucket] = max(agg_peak[bucket], temp);
+		}
 
-	temp = agg_avg * 1000ULL;
-	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_x = temp;
+		temp = agg_avg[bucket] * 1000ULL;
+		do_div(temp, bcm->aux_data.unit);
+		bcm->vote_x[bucket] = temp;
 
-	temp = agg_peak * 1000ULL;
-	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_y = temp;
+		temp = agg_peak[bucket] * 1000ULL;
+		do_div(temp, bcm->aux_data.unit);
+		bcm->vote_y[bucket] = temp;
+	}
 
-	if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
-		bcm->vote_x = 1;
-		bcm->vote_y = 1;
+	if (bcm->keepalive && bcm->vote_x[0] == 0 && bcm->vote_y[0] == 0) {
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
 	}
 
 	bcm->dirty = false;
 }
 
+static void qcom_icc_pre_aggregate(struct icc_node *node)
+{
+	size_t i;
+	struct qcom_icc_node *qn;
+
+	qn = node->data;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		qn->sum_avg[i] = 0;
+		qn->max_peak[i] = 0;
+	}
+}
+
 static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
 {
 	size_t i;
 	struct qcom_icc_node *qn;
+	unsigned long tag_word = (unsigned long)tag;
 
 	qn = node->data;
 
+	if (!tag)
+		tag_word = QCOM_ICC_TAG_ALWAYS;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		if (test_bit(i, &tag_word)) {
+			qn->sum_avg[i] += avg_bw;
+			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
+		}
+	}
+
 	*agg_avg += avg_bw;
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
-	qn->sum_avg = *agg_avg;
-	qn->max_peak = *agg_peak;
-
 	for (i = 0; i < qn->num_bcms; i++)
 		qn->bcms[i]->dirty = true;
 
@@ -675,7 +711,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	 * Construct the command list based on a pre ordered list of BCMs
 	 * based on VCD.
 	 */
-	tcs_list_gen(&commit_list, cmds, commit_idx);
+	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
 
 	if (!commit_idx[0])
 		return ret;
@@ -693,6 +729,41 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		return ret;
 	}
 
+	INIT_LIST_HEAD(&commit_list);
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		/*
+		 * Only generate WAKE and SLEEP commands if a resource's
+		 * requirements change as the execution environment transitions
+		 * between different power states.
+		 */
+		if (qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_WAKE] !=
+		    qp->bcms[i]->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
+		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_WAKE] !=
+		    qp->bcms[i]->vote_y[QCOM_ICC_BUCKET_SLEEP]) {
+			list_add_tail(&qp->bcms[i]->list, &commit_list);
+		}
+	}
+
+	if (list_empty(&commit_list))
+		return ret;
+
+	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
+		return ret;
+	}
+
+	tcs_list_gen(&commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
+	if (ret) {
+		pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
+		return ret;
+	}
+
 	return ret;
 }
 
@@ -738,6 +809,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider = &qp->provider;
 	provider->dev = &pdev->dev;
 	provider->set = qcom_icc_set;
+	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	INIT_LIST_HEAD(&provider->nodes);
