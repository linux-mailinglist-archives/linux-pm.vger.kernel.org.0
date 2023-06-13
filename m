Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A272E4FB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbjFMOD5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbjFMODk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 10:03:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDB1BF9
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:03:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so69460751fa.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665008; x=1689257008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlAqaMdbmLGj8l7MjsoGS3k3gkoQWn0R47qb9oWSrKE=;
        b=YLqKySA91oNbc4gJRil9KGHva6VZcljWOL/RKYl/2PjottzKpnRyvU2hX5YIeYIwqp
         3uqLXKHLBMMUwzlLYhrB4i2b8UprDMG5v3MXqQGCb2XaEOxtIDpAe6+MrZmaoDAq7+TO
         +kX9UW3mRK1+qCUPBe12Ep1SHLj4AYURphlrP8sstUAlllena9Gveb+H76DBJRojAoqj
         Fgx18tGSxahfNClybMb4WUdbNaKC9CStqj6Is8rxMCJcXOP6b49lPNiew8TXPhnpuLFz
         3ryemDyDaz6oBwShgTBKntzyVxsptaa8duf2+S4M8NIRpVU4uFn/0X31s20HDwGPcxd1
         lOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665008; x=1689257008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlAqaMdbmLGj8l7MjsoGS3k3gkoQWn0R47qb9oWSrKE=;
        b=IwBcHiRmvt2eDI7Vm87JFqzl0Zev3Mc5YyMypAobStClrOtpYzKErnVIyRGVPQVd2X
         frJakAxAM6TTzm8yURT+nHcwukrs0f2IdbZ6jwBrax2ym5uSn28H9qpDUvAv9irn1gm+
         WU2mwNPfwAbIsu0e1DF1VWdfrPUgOKaKyEyN7oBldom2gX6/BLYXDTXXuTmcPC4xGIkL
         Vpl8YnfOAvOxQrbPdz001fb/EoMWiGSus+bEoBKDqwkN5MNDsJTh0b/FwAsHvY01rzCq
         gngZ3hT81DcksqXBJts3kkin73AJGrIPgoBbJFX1UFpAD1CqYv0y37jM4l7ZmKQtmgPY
         vj/w==
X-Gm-Message-State: AC+VfDwLQUs+dlqBzIS8rAgOPM7gfFcOo6nIyAApxwLCqLst2/M7lxtW
        lz1sbuvZTAxvYBDfDLI8+aRElw==
X-Google-Smtp-Source: ACHHUZ5E8pp9o55LtP7bMV3L9lpH5xJUtHwnf9bxT7R7cJjt6eJ4hilBuOgJHfrlEQtlWRW/44w5Dg==
X-Received: by 2002:a2e:9846:0:b0:2b1:ac82:296 with SMTP id e6-20020a2e9846000000b002b1ac820296mr5073574ljj.34.1686665007963;
        Tue, 13 Jun 2023 07:03:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:10 +0200
Subject: [PATCH v4 10/22] interconnect: qcom: Define RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-10-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=4129;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yBQnfvZP3t8Oj9Z8/s29s0nbV7xIPzwaUA8Ls3ERlog=;
 b=dkzLSRz8wjX7XWZOF81OhWPUkkH8dKfvj8zXaexV8gvIyDvS6i4ut+4lCQlGjf2Jl9OnYF0B0
 +ePX9nEr0e2B4qwptNnbZiD+3ll5W4STDCUmkm5NnX46BD3Yr0UL8mk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the definitions for RPM bus clocks that will be used by many
different platforms.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/Makefile         |  2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c | 77 ++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpm.h        | 13 +++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ab988926433c..80d9d2da95d1 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -29,7 +29,7 @@ qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
 qnoc-sm8450-objs			:= sm8450.o
 qnoc-sm8550-objs			:= sm8550.o
-icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
+icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
new file mode 100644
index 000000000000..63c82a91bbc7
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Linaro Ltd
+ */
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include "icc-rpm.h"
+
+const struct rpm_clk_resource aggre1_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 1,
+};
+EXPORT_SYMBOL_GPL(aggre1_clk);
+
+const struct rpm_clk_resource aggre2_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 2,
+};
+EXPORT_SYMBOL_GPL(aggre2_clk);
+
+const struct rpm_clk_resource bimc_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 0,
+};
+EXPORT_SYMBOL_GPL(bimc_clk);
+
+const struct rpm_clk_resource bus_0_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 0,
+};
+EXPORT_SYMBOL_GPL(bus_0_clk);
+
+const struct rpm_clk_resource bus_1_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 1,
+};
+EXPORT_SYMBOL_GPL(bus_1_clk);
+
+const struct rpm_clk_resource bus_2_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 2,
+};
+EXPORT_SYMBOL_GPL(bus_2_clk);
+
+const struct rpm_clk_resource mmaxi_0_clk = {
+	.resource_type = QCOM_SMD_RPM_MMAXI_CLK,
+	.clock_id = 0,
+};
+EXPORT_SYMBOL_GPL(mmaxi_0_clk);
+
+const struct rpm_clk_resource mmaxi_1_clk = {
+	.resource_type = QCOM_SMD_RPM_MMAXI_CLK,
+	.clock_id = 1,
+};
+EXPORT_SYMBOL_GPL(mmaxi_1_clk);
+
+const struct rpm_clk_resource qup_clk = {
+	.resource_type = QCOM_SMD_RPM_QUP_CLK,
+	.clock_id = 0,
+};
+EXPORT_SYMBOL_GPL(qup_clk);
+
+/* Branch clocks */
+const struct rpm_clk_resource aggre1_branch_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 1,
+	.branch = true,
+};
+EXPORT_SYMBOL_GPL(aggre1_branch_clk);
+
+const struct rpm_clk_resource aggre2_branch_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 2,
+	.branch = true,
+};
+EXPORT_SYMBOL_GPL(aggre2_branch_clk);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index ee6ec7f2d0e1..ef738133b00d 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -136,6 +136,19 @@ enum qos_mode {
 	NOC_QOS_MODE_BYPASS,
 };
 
+extern const struct rpm_clk_resource aggre1_clk;
+extern const struct rpm_clk_resource aggre2_clk;
+extern const struct rpm_clk_resource bimc_clk;
+extern const struct rpm_clk_resource bus_0_clk;
+extern const struct rpm_clk_resource bus_1_clk;
+extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource mmaxi_0_clk;
+extern const struct rpm_clk_resource mmaxi_1_clk;
+extern const struct rpm_clk_resource qup_clk;
+
+extern const struct rpm_clk_resource aggre1_branch_clk;
+extern const struct rpm_clk_resource aggre2_branch_clk;
+
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 

-- 
2.41.0

