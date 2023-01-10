Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D06664182
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 14:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAJNWP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 08:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjAJNWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 08:22:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4581B9EB
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 05:22:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bf43so18393470lfb.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS3uiF3saExdVOPAm+E+mNqQzuR/x6HaROiD24WIjGA=;
        b=Sgd1NZEV/X99sRRp/xISipY2qfos6uYFzLwUg7xkyMdlDFVkmF/KkYs5J+4+NBEW6G
         4ntoLimettJNyJYCTWf4Y6VDQ0A3b1gdZrBnXUncERGXuVVDLXBcbyBdAnY6y3y6mI2q
         oa3/rq60Exe7dMxc+dpT5LPekk0k0h3o2vITJFjqK+gJNURzsKzrbz72sOW2FXgZkvqW
         qGW6coQ7EBLfh+4a2gTXWU4rOhM6iwsj1Rnjx7wh2lU1vppsCYSJGMu6E2kJdOIcvjQ9
         ziMAyMhGFLbZIzgKGDlEbLPb+F7LjAL1xWB0DhjN6xg7JEUCwasXz6xMPPjJYfoJ1HvL
         nZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS3uiF3saExdVOPAm+E+mNqQzuR/x6HaROiD24WIjGA=;
        b=knc9NhQt5wr8NvCuEi5A4zFBHFKlvw34xUOCqGpuL8g+QStBB1Kaw7+ceRd+FXode0
         J97m6xtmII7qDjszCqRWWm4XHUrCc9bN8VGdKCA8LAY/ouINdwKFl9R8Ke+T4KH1q2/A
         Qw0QvQcJ6SyWPUBpVCh1uxQJx+7UVEcorEQD9YPa/Q0uVTWrXQEWOw4iju+ksqETnL0B
         MBdcj3bAZf1xV6Y8WHt+aa7KCmOhRi8z1kTKHyuWlYtxhhfvkkN8R/DNREeBmw6dEFgh
         Yc5ppqLwliJiHdjEVx4rJk9HUBHQFdaTfxId+1oWuX04bguza93uqiCN2qiT1z7UeYC1
         zNKA==
X-Gm-Message-State: AFqh2krjNnQQ4DseR1g+3GJbF6p8lRz2xi0SGHeRcsqsjI3b0q8FcCM2
        TpdTT9iI9UyoNR7/1mX+1PmKDA==
X-Google-Smtp-Source: AMrXdXtxCKQLEcW+N26GfLLdnUjIe1zqm3w8OX+yed29UIn/qg7GPktkgGIdZWv7uvqkquAmXBb91w==
X-Received: by 2002:a05:6512:2987:b0:4b1:3960:4cf8 with SMTP id du7-20020a056512298700b004b139604cf8mr17722967lfb.28.1673356931585;
        Tue, 10 Jan 2023 05:22:11 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] interconnect: qcom: rpm: Always set QoS params on QNoC
Date:   Tue, 10 Jan 2023 14:21:55 +0100
Message-Id: <20230110132202.956619-4-konrad.dybcio@linaro.org>
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

On newer SoCs, QoS parameters and RPM bandwidth requests are wholly
separate. Setting one should only depend on the description of the
interconnect node and not whether the other is present. If we don't
vote through RPM, QoS parameters should be set regardless, as we're
requesting additional bandwidth by setting the interconnect clock
rates.

With NoC (the old-SoC bus type), this is not the case and they are
mutually exclusive (so, the current upstream logic is correct).

For BIMC however, newer SoCs expect QoS params to be always set
(like QNoC) whereas older ones (like MSM8998) hang up completely when
doing so, hence this will be addressed in the next commit.

The Fixes tag references the commit in which this logic was added, it
has since been shuffled around to a different file, but it's the one
where it originates from.

Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index cd1eab3d93ba..0516b74abdc7 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -246,15 +246,27 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
 static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 			  u64 sum_bw)
 {
+	struct qcom_icc_provider *qp = to_qcom_provider(n->provider);
+	bool vote_ap, vote_rpm;
 	int ret;
 
-	if (!qn->qos.ap_owned) {
-		/* send bandwidth request message to the RPM processor */
+	if (qp->type == QCOM_ICC_QNOC) {
+		vote_ap = true;
+		vote_rpm = true;
+	} else {
+		vote_ap = qn->qos.ap_owned;
+		vote_rpm = !vote_ap;
+	}
+
+	if (vote_rpm) {
+		/* Send bandwidth request message to the RPM processor */
 		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
 		if (ret)
 			return ret;
-	} else if (qn->qos.qos_mode != -1) {
-		/* set bandwidth directly from the AP */
+	}
+
+	if (vote_ap && qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
+		/* Set QoS params from the AP */
 		ret = qcom_icc_qos_set(n, sum_bw);
 		if (ret)
 			return ret;
-- 
2.39.0

