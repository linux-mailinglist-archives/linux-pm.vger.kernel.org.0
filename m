Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B84569EAB
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiGGJic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiGGJia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 05:38:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D764EC
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 02:38:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so25484237wrh.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kWQOrhoFmy774oTZXorQk1Sl8VEFQpTuVhXI8f62Fg=;
        b=Gtbe+RgzEMUXiokTKTzNmYpNVvw6yOPQVvghv90mIBKpwaZFctO7qwcjZU8CXJi8Xp
         VM8ud0JRdl8qS6XBBsh7RoGUQcK95WTzyiD4lwXH9PtUn/B+zq5lSA7JWDdRr8DmUf4C
         xWEO7ohWseQ4l3+c6Ad5OQmaUlRtKhltruVGF5sw+KE/mXKxiU4vPaGyXSKhoFrAwj0k
         6M+Nex/CHlr7TjIisai7JXuSRdvNhRMyf45ka2DqaTVnCHsim3j/yRRUw1n4TVj/f89b
         85kCZ+WTbr4/FSHxSRyjbt5xs31+dZx4BShJ53c3Hm3BLhrgdkOKj1QhOgkotZBlg0W5
         bsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kWQOrhoFmy774oTZXorQk1Sl8VEFQpTuVhXI8f62Fg=;
        b=sdw55Wkcg2s5RlVdH3YbkCi6LI3OfP3ln/flvyJC4tFALbdu3XXxEcM1fKQpsvdUzH
         avItTDAEiX08asgRpSBbUJeFlGr37YzuF52UN8YDB3jDsw7rrIXlQSMrjYUeKeCI4/47
         AS/ieVCJMgztmty1PktHtFDad2ubt/+nOIi4yA4qOhTzrt8VWjSiH/i6mjdUq2nyLxst
         nm02CvzPO6m1k1jb3e0Pk1GBXcU4IpvwuOvqpROilr59doyiFVSeZ8Wmzl5WpduekAAg
         9DPs69dkkz6zIAHPV4WaqqdGayIBQpoJHBcc1+o7jdn5DmiN4MqwotAQtyNuurCJezXK
         qWkw==
X-Gm-Message-State: AJIora9TWFq8gspfz+PGS5szLydAyCRX1mh/C/JMNP0A9eu8s01HaBcn
        6BIHjdsCYPLCIG7DWIDt3+ESEg==
X-Google-Smtp-Source: AGRyM1tbUaUSzMdnUl4PWsdemUZoobZzVtm+vBha/cvhQpP4EuC4TTRfh7ln3HJlSEL4j9z2t6DWng==
X-Received: by 2002:a05:6000:15c6:b0:21b:ccda:fc69 with SMTP id y6-20020a05600015c600b0021bccdafc69mr42022615wry.411.1657186707260;
        Thu, 07 Jul 2022 02:38:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b00213ba3384aesm38877781wrr.35.2022.07.07.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:38:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     djakov@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        shawn.guo@linaro.org, dmitry.baryshkov@linaro.org,
        leo.yan@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH] interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth
Date:   Thu,  7 Jul 2022 10:38:23 +0100
Message-Id: <20220707093823.1691870-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make it possible to set destination as well as source bandwidth. If the
*dst pointer is non-NULL. Right now it appears that we never make the
destination bw allocation call, which is inconsistent with the downstream
way of doing this.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 41 +++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index fb013191c29b9..7e8bcbb2f5dba 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -233,10 +233,30 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
 	return ret;
 }
 
+static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
+			  u64 sum_bw)
+{
+	int ret;
+
+	if (!qn->qos.ap_owned) {
+		/* send bandwidth request message to the RPM processor */
+		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
+		if (ret)
+			return ret;
+	} else if (qn->qos.qos_mode != -1) {
+		/* set bandwidth directly from the AP */
+		ret = qcom_icc_qos_set(n, sum_bw);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *qn;
+	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
 	struct icc_provider *provider;
 	struct icc_node *n;
 	u64 sum_bw;
@@ -246,7 +266,9 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	u32 agg_peak = 0;
 	int ret, i;
 
-	qn = src->data;
+	src_qn = src->data;
+	if (dst)
+		dst_qn = dst->data;
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
@@ -257,21 +279,18 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	sum_bw = icc_units_to_bps(agg_avg);
 	max_peak_bw = icc_units_to_bps(agg_peak);
 
-	if (!qn->qos.ap_owned) {
-		/* send bandwidth request message to the RPM processor */
-		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
-		if (ret)
-			return ret;
-	} else if (qn->qos.qos_mode != -1) {
-		/* set bandwidth directly from the AP */
-		ret = qcom_icc_qos_set(src, sum_bw);
+	ret = __qcom_icc_set(src, src_qn, sum_bw);
+	if (ret)
+		return ret;
+	if (dst_qn) {
+		ret = __qcom_icc_set(dst, dst_qn, sum_bw);
 		if (ret)
 			return ret;
 	}
 
 	rate = max(sum_bw, max_peak_bw);
 
-	do_div(rate, qn->buswidth);
+	do_div(rate, src_qn->buswidth);
 	rate = min_t(u64, rate, LONG_MAX);
 
 	for (i = 0; i < qp->num_clks; i++) {
-- 
2.36.1

