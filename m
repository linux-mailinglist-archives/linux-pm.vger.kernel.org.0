Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB874EDFC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGKMSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGKMSg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:18:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61910C0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:18:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69923a715so88777751fa.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077912; x=1691669912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccaHxWEA1SHNBLA/pJ32RMxAjEs2vftCpusuOqWZkaE=;
        b=AAa407DAcUUBZbNB2i1waM4u2+UaESZbSIFTb8IWbolXR5HnC39wh0iKZ/nEkWNsuS
         /u8mLAN7PTTfYQ08LT1jOQ0uDTK3C8RVGgauvdIqRJDEMrcDAcm7fVVD6qrEe87r+bvb
         o/dpbyN5EfbKehUidsB2RGJQpV4LJ1muPhk/tdE/XngfxGrbONlIFMF1Bq89JNUYTWCI
         OkuV8QkN31TY1YHRFpXYrlbdKEM6Zxahwf5yNcErl9JVNA5t1yYr/tWH1j+sVNTVutKu
         sAv743aQBCXiygGfItZCTDkSx20u4sQA3IMHNS/lZw8ZWoDyoZ+1ULpKH+yVl8rIaYbv
         x7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077912; x=1691669912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccaHxWEA1SHNBLA/pJ32RMxAjEs2vftCpusuOqWZkaE=;
        b=j6cZ63CnOYJ3bGp78rD4R21G3AErnj1S+T0i7dTMkLvmNkp4cY/90WnBY4yuaywdxp
         j7Mkyqm8lGwfQJXg0uWXz4fmCafHFo0vMAXGhQuAYT36cpLYWhzMKJOA5xSCpKlazfAa
         jZD1KhOrn4JDz96h989D/sNaXerYjsWEPEHzMdi9mfG0pOzCcGEYSMQitKiedukN4H0C
         T2m3XhMCTWJioBxgTrAe9R2DY1YMKkj1WwOcV+BWQw4LyLbAbZfjdZhQQn05Pt9VqpI1
         1C5nYDBqMEorj8qOwSwBBlxWNyG1Jr/zimPZ9/iQaj7SUYW7OjcRWYJF8AJqRN3PWMoe
         AwJQ==
X-Gm-Message-State: ABy/qLbY1+64f5J46hiRRsjgscG82xVNUZQH4sGg3B4GX7SnqTlOjoZ0
        0oBC3TGzexlcNa1Bd2+VbuTsKQ==
X-Google-Smtp-Source: APBJJlF3TDNp52qVnWvnuIz7/SR0d+mgazonvPucboip+HYCyKqB81kRMjkq1+V2da/wMQB0zmk42g==
X-Received: by 2002:a2e:7a06:0:b0:2b6:bd82:80b1 with SMTP id v6-20020a2e7a06000000b002b6bd8280b1mr13846968ljc.37.1689077912056;
        Tue, 11 Jul 2023 05:18:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:04 +0200
Subject: [PATCH 05/53] interconnect: qcom: icc-rpmh: Implement voting on
 non-APPS RSCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-5-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=3399;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qxa5myzMVst/ng/FRMS5QwwZ8ABXjqpOGI10XxQPCBc=;
 b=YTn8PsYOLKHdJ4Oifs+Jok/jlVwavascvy0uIPmwXcmQnyELG4gnpyZgozP0wLWdDR7INKJYf
 FKpv39ljyUsDLC8wn1QDYP1tm30T7i3e8mbyhY3odnYIh4XD9fY7ZnA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Linux can cast votes on resources through different RSCs (e.g. DISP). This
can be done for many reasons, from latency to fine-grain on-SoC-power-grid
management.

With all the necessary bits in place, add the loops and ifs necessary to
vote through different RSCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 49 ++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 53298148f24b..3cdd9106b0c0 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -22,6 +22,8 @@ void qcom_icc_pre_aggregate(struct icc_node *node)
 {
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
+	struct qcom_icc_bcm *bcm;
+	int voter_idx;
 	int i;
 
 	qn = node->data;
@@ -32,8 +34,17 @@ void qcom_icc_pre_aggregate(struct icc_node *node)
 		qn->max_peak[i] = 0;
 	}
 
-	for (i = 0; i < qn->num_bcms; i++)
-		qcom_icc_bcm_voter_add(qcom_icc_bcm_voters[ICC_BCM_VOTER_APPS], qn->bcms[i]);
+	for (i = 0; i < qn->num_bcms; i++) {
+		bcm = qn->bcms[i];
+
+		/* Old and incomplete device trees may not specify all voters. */
+		if (qcom_icc_bcm_voters[bcm->voter_idx])
+			voter_idx = bcm->voter_idx;
+		else
+			voter_idx = ICC_BCM_VOTER_APPS;
+
+		qcom_icc_bcm_voter_add(qcom_icc_bcm_voters[voter_idx], bcm);
+	}
 }
 EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
 
@@ -87,6 +98,7 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
+	int i, ret;
 
 	if (!src)
 		node = dst;
@@ -95,7 +107,11 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qp = to_qcom_provider(node->provider);
 
-	qcom_icc_bcm_voter_commit(qcom_icc_bcm_voters[ICC_BCM_VOTER_APPS]);
+	for (i = 0; i < ICC_BCM_VOTER_MAX; i++) {
+		ret = qcom_icc_bcm_voter_commit(qcom_icc_bcm_voters[i]);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -168,6 +184,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	struct qcom_icc_node * const *qnodes, *qn;
 	struct qcom_icc_provider *qp;
 	struct device_node *bcm_node;
+	u32 val, voter_count = 0;
 	struct icc_node *node;
 	size_t num_nodes, i, j;
 	int ret;
@@ -201,10 +218,28 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	qp->bcms = desc->bcms;
 	qp->num_bcms = desc->num_bcms;
 
-	/* Ensure the BCM voter is reachable (unless we don't have any) */
-	qp->voter = qcom_icc_bcm_voters[ICC_BCM_VOTER_APPS];
-	if (qp->num_bcms && !qp->voter)
-		return -EPROBE_DEFER;
+	for (i = 0; i < ICC_BCM_VOTER_MAX; i++) {
+		bcm_node = of_parse_phandle(dev->of_node, "qcom,bcm-voters", voter_count);
+		if (!bcm_node)
+			break;
+
+		voter_count++;
+
+		ret = of_property_read_u32(bcm_node, "qcom,bcm-voter-idx", &val);
+		of_node_put(bcm_node);
+		/* Legacy DTs only ever referenced the APPS BCM voter */
+		if (ret == -EINVAL)
+			val = ICC_BCM_VOTER_APPS;
+		else if (ret)
+			return ret;
+
+		if (!qcom_icc_bcm_voters[val])
+			return -EPROBE_DEFER;
+	}
+
+	/* Let's not forget to add qcom,bcm-voters to the provider node! */
+	if (qp->num_bcms && !voter_count)
+		return -EINVAL;
 
 	for (i = 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], dev);

-- 
2.41.0

