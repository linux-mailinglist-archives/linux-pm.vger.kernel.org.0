Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7777417E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjHHRWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjHHRWO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 13:22:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3E57C71A
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 09:09:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99cdb0fd093so313752166b.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510913; x=1692115713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCx8RlEOFx8UDQtGNW/6cgXaxJHTs4rAU1l6hTQLDFk=;
        b=i2k+dD/dSZxuPOeS8lJPGJJ6Z2acvLB4HfDnhPlvSLrFFuMXzSwRgsmRA2np4W6dBv
         JmTCsKeCteqHzakn/u+HaCa34pS73AJ9cEL4q1nIqy9tU3eIem00try/15u+F4+yK8Ik
         9y4qKGFU1k0YGLKae80bsO/t66gelaFQcs3w08Bc2SsnzczxCtAZTvPqGHVxaRsq71WZ
         aSOmcaE607mUQVz0Zv9Dj+T8o8y/ogSJfj4GASSS8wGREXFyKFf8r55urF2DF2dMeG7I
         CZcl0PNEXN127PZrLV+B728myJzyJfG66oCk/d35zi2TTWxlOLLI8RZWuSrt4AFNqe8P
         60TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510913; x=1692115713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCx8RlEOFx8UDQtGNW/6cgXaxJHTs4rAU1l6hTQLDFk=;
        b=hrhI1jr/Kv/Jt50SaO+FKgVgMm7fI8Ypcsgnov1cHwFP8TPaS3ZfMPaxgHZHFChGwG
         oOcXOo8nEw6QmDfi9QzW4YsMhJqrOd8cq/DwLiSKFibXTF/CTy1FrrM7O0FdjtEKWMTM
         xFsGGg5/pDrHEQkFFA8s+XJpOH0a64lLadFIpldI074G/w/tpcrdURpwx0Fs3+BRnn/R
         ++gj16osgWrIwoWoSqe27g21xHtd76+YlQ+u/wXdeen+AcV1vfqS1iIZLOyRWsh6hQVj
         Ktyh+KBuUEHE8fgdSau8dSEafFpLw+mfs0Iz8yiasszlTTPHI19uT175DX8mEem0/Z1t
         vi2Q==
X-Gm-Message-State: AOJu0YyZdSfMiVbl3zZtJuIeOOlVTyh1ro2APKfL+Ay/tpPcec1+vtQO
        BWdi3B7Wv+oN17qwV0nCfBj08nmZhmZjzg7PrWc=
X-Google-Smtp-Source: AGHT+IH+sPe9RaM9v5SJiPH9mGRNklcFtnmQjV71N3tInoFanoFMD5xKQLAj+RolMkFNtpIptv/IlA==
X-Received: by 2002:a05:6512:2e4:b0:4fe:cca:c6f7 with SMTP id m4-20020a05651202e400b004fe0ccac6f7mr7807040lfq.48.1691495022052;
        Tue, 08 Aug 2023 04:43:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 13:43:36 +0200
Subject: [PATCH v3 05/10] interconnect: qcom: qcm2290: Hook up
 MAS_APPS_PROC's bus clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v3-5-dee684d6cdd2@linaro.org>
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=2342;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=baltAV4RoHwcQRz0/eW44USFJNd7n+E9JFHsU6Sjt+4=;
 b=MAN7N0prQn1s1uUMDQ6ZtSNXTmx17gJ/z3RFDO/h4V4WTWklSZf/hJxh+ULsHiD442q2RovQ8
 KHxzAyUUWgKBUDESPgVueFeDu76mSu4J0AXSNzBnfLgjMfDWMV8ZgAD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This single node has its own clock which seems to be responsible for
transactions between CPUSS (CPU + some stuff) and the GNOC. See [1]
for reference.

Define it and hook it up.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/02f8c342b23c20a5cf967df649814be37a08227c%5E%21/#F0
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm-clocks.c | 6 ++++++
 drivers/interconnect/qcom/icc-rpm.h        | 1 +
 drivers/interconnect/qcom/qcm2290.c        | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
index 63c82a91bbc7..ac1677de7dfd 100644
--- a/drivers/interconnect/qcom/icc-rpm-clocks.c
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -25,6 +25,12 @@ const struct rpm_clk_resource bimc_clk = {
 };
 EXPORT_SYMBOL_GPL(bimc_clk);
 
+const struct rpm_clk_resource mem_1_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 1,
+};
+EXPORT_SYMBOL_GPL(mem_1_clk);
+
 const struct rpm_clk_resource bus_0_clk = {
 	.resource_type = QCOM_SMD_RPM_BUS_CLK,
 	.clock_id = 0,
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 4abf99ce2690..a13768cfd231 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -152,6 +152,7 @@ extern const struct rpm_clk_resource bimc_clk;
 extern const struct rpm_clk_resource bus_0_clk;
 extern const struct rpm_clk_resource bus_1_clk;
 extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource mem_1_clk;
 extern const struct rpm_clk_resource mmaxi_0_clk;
 extern const struct rpm_clk_resource mmaxi_1_clk;
 extern const struct rpm_clk_resource qup_clk;
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 3c3b24264a5b..52a6eb32e832 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -112,6 +112,9 @@ static struct qcom_icc_node mas_appss_proc = {
 	.qos.qos_mode = NOC_QOS_MODE_FIXED,
 	.qos.prio_level = 0,
 	.qos.areq_prio = 0,
+	.bus_clk_desc = &mem_1_clk,
+	.ab_coeff = 159,
+	.ib_coeff = 96,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_appss_proc_links),

-- 
2.41.0

