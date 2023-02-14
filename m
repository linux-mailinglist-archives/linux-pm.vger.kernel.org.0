Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C46966FE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 15:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjBNOiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBNOiE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 09:38:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD1B76D
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d40so16452259eda.8
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M85Txp3qLBn12UcZyAcNozii0oizm6RueYAIHWFw6cU=;
        b=qd0o44Kbx1EkTg2qCbYQ88IqKD2XXI8v0ZJsoaIdotgP0HkxnI4I19WQ24tTPfMAOW
         lFpmnCRzr5pw1XHh7wzWefbw7qtNFHCqecYZrxwfMNsunLnZSMueBJzXoD9OPx0/W/en
         QKB71ok8wQMLINpM8ANzhnK0SlwfdC+1SiPyhjIF3VmnQ7/VM4wlIygaptS/be0heIpN
         S05FwmHSI7OHkWFwJfyZ51z2/cz6zQ+CQnfcbjqg08f6lCb+3xXhYGxHffyLA9Dhahxl
         tI7ekiocb7FlKLETfreIF5bZv+FJXV6KdIzknhKtY4ogObFbAJgEGQ/jVXmvbD2ToUdo
         RBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M85Txp3qLBn12UcZyAcNozii0oizm6RueYAIHWFw6cU=;
        b=Z6WBE922jug/hK53xTDSA2fo10NJdPxOj8ZkTq8oRfyl3kt+NO2L7zoWpqh34M2pw3
         S6uq6hdXzLEKiFNhfUYomxyadyEow3OyzpuBSAfLR0/tU/m5/FZYf0mFk027a4NXZVlu
         25NrBc/MV6D1kgu7kvQR4VYicbQztVf5q5o/1bfROjbMAnDX/MhRqnhs90HXx5aBCGxg
         qpCce9CSe19cusPfLHtTyG9q2roQSG+AkuYMRvjlBc8lE16HgqEMaGnsd4L0oHXRghjo
         33DjBK/b5PrrELJh4ZhYdGGIKn3OJDMMhUACV9xPD8bPrJMlESPmWTrVd1DjRQBB382K
         gr3Q==
X-Gm-Message-State: AO0yUKVFxqnKkWMNhijNuZ9yLjquMvvkIInb41SGUicrbbrhMQqdTHB6
        53RLSZfivPPT6j43C2QmaJrWGw==
X-Google-Smtp-Source: AK7set+dGcrUWhW4uRJR+Y3MWD8ILgsLvd+GS1Qc911EPpD1TtoB3LUXv1PCZDb5FRpm7yPYa9emEQ==
X-Received: by 2002:a50:bace:0:b0:4ab:4cf0:4ab3 with SMTP id x72-20020a50bace000000b004ab4cf04ab3mr2741589ede.38.1676385481563;
        Tue, 14 Feb 2023 06:38:01 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:01 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/12] interconnect: qcom: rpm: Add support for specifying channel num
Date:   Tue, 14 Feb 2023 15:37:10 +0100
Message-Id: <20230214143720.2416762-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
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

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 385a67c20956..7fcc2d86117b 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	int i;
 
 	/* Initialise aggregate values */
@@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
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
index 8ba1918d7997..8aed5400afda 100644
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
2.39.1

