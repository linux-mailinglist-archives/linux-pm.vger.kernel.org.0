Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA03788CAE
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjHYPjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbjHYPik (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 11:38:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A44726AF
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 08:38:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso15593991fa.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977912; x=1693582712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN2YRy5nVk/3pPVAynBwTOKMJ1RGnBnnrlQRo1bfz94=;
        b=Ag8oduepr8osxtNJfd1ArTVJIC0qYFDPObkAAoI+rKK6N8FWH4MVR/Vfp5gp92sxts
         ViJOvoXsekB/X6f3MAgrlCba5ZSpnybQAvNC60IHlx6PcWW15gFssjDnKp4Apdtis3Go
         h9RWzMyixvBPn+Yd2sd/wRJx2G/dVoRe4IzH+btnw+D8ETaXxn/w3sS2rZrA2zRczx35
         O3HQefon9OeQt9BQ/FZ9ILJjpckOwrJkiGY2jaHq8DngLLqPtk+80JfGq14fAZwBS/wU
         +ONrcw46KGC4hzTeL9HXC6QKWDWFSJj5yFaTjy8wYVZrIZGpWeRyebdoGuSb9TeoZN3X
         vpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977912; x=1693582712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UN2YRy5nVk/3pPVAynBwTOKMJ1RGnBnnrlQRo1bfz94=;
        b=f8PN7hES+gvKrdMCsZiL5o9oqIqZ91dIMgvYvxezoXQWF8NdsOM5Nxqm8L7nkdhF8T
         E5DxkWykjPlJntII0XvHU1vd2ySaNsILVzcbYWtg8ca+tmsqW/8hnz49QHo2UQ54T+Zb
         b93sixePpsXb54xnprQgrK6UCDQRKAhHZbzLcDb3lqoHzGnkjPtrTIsutjOKxvd7QLbF
         75AXMZzsEgDK8f5lW2kX4RtoI6l7h06xh8Xaem1TFqn0bAItXKAysh5Z7Il3IpdP3JR3
         iYACyXlOi3NOCd29xMJ5WBWefHTzmMk5N3YBsc7oFpKfjJE3wTcDd/iRprr4D2S3WgVL
         6JNQ==
X-Gm-Message-State: AOJu0YytBkS+PL6dsTv4AtKW1Ayb+/jhJTfPbUlU7WDjhUaxdD3iSxEJ
        N8Fken4miAXqPmqE9D59zQ3IUA==
X-Google-Smtp-Source: AGHT+IGVMooC/n4ki8lW14Aik8eDks0F5p6RSUGvawcJIy/64vruyQQ5iSXb04VYvoNt4X0oYxY4tw==
X-Received: by 2002:a05:6512:12c4:b0:4fb:9712:a717 with SMTP id p4-20020a05651212c400b004fb9712a717mr15074361lfg.13.1692977912522;
        Fri, 25 Aug 2023 08:38:32 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:27 +0200
Subject: [PATCH v4 05/10] interconnect: qcom: qcm2290: Hook up
 MAS_APPS_PROC's bus clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-5-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=2342;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GlL8hPLpxopE6Z6juWkr7yv0qDqrTnKLRNlPdw5/ARI=;
 b=nzOBRO0gupeVDvFwwhflJMN8ilm1Z/7ImveUexKVtqMrfY7vWa5H/LTxgGJtbOeV+/D8FwJFz
 G2IKVUTUZWnBX/zzhyP2pe9Zsk3/b5ZoIyjs+tSoSmYS0nSKlyD4Wi0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 5bc4b7516608..026e4c82d6d4 100644
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
2.42.0

