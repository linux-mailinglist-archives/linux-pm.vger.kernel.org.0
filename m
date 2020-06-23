Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92443205A3E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgFWSIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B8C061573;
        Tue, 23 Jun 2020 11:08:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so13793934wrv.9;
        Tue, 23 Jun 2020 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmuqJ4buTrZEnhQ3OwlLnys6fUl+viCTck1AnKYO5ok=;
        b=rmYzdO7OYq8VSY73XgUoty5FL5YDKiP4p4z37fZM/eE4+AwDh6+vsvkFJbY0AH8NtO
         A8oWX/hZNEMJznlNSATUsszAsF+1YdgGxyi7fxoNYabRcxxDrwQO47R86Att5QVajQaF
         QdzAFU3hN9qAw1MhAWe2M5d+TGd6kuidj2Xn2Vuinx+KCLBrKBV/Zqq1RQ5fm0hzlSJP
         LQEniNhn+LLj0oAB1BJj+XWF/P2qOp1KY3CENTrRHiIw4GSDeSXNs4ampdzUF8vykApc
         A+7VsZgU4gkCOe5nHOqGJYoX3FFvegQfbMq3ANT6UX+SdtZlyZ6qUEdoOHJzBvfycMYN
         TLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmuqJ4buTrZEnhQ3OwlLnys6fUl+viCTck1AnKYO5ok=;
        b=PQIqSDqWnpqe4HjZaCPvgIDewxEivwGNjHfTS0UxeleUo0QF7sHhyqggqwWFrkPXsg
         nW96RhFLk3gs10GS2+Z/2nozYOVlpzmUlQSTerRSGqycKx98AwX8dNQMjzp5s2ZuOhPt
         4D7wnfvLmlRGdLJlnEz5jXcXrvSkburR4J2ZyZuNitla42y5TeIqOds6dKotBd9/84x3
         +bEM3LGCyy6Jm5I9kv3XpSEie4s+tn5nggr/uOuhw/SXpKBFdtZE2FMl1tmrZeId2ThE
         fT4jr4YHWyf3CUGzz3fMtt+p+IPhr4s9ow6pygi3sJClDE189OpiJ1vMIYelyaJt4YOy
         KjrA==
X-Gm-Message-State: AOAM530FFTnzISnYv0CiamjX3LKK+CSu0HYB4HDh+MX2QJFODZ8TB7Hr
        oyfG+LLEqHPzOchpINEaOKc=
X-Google-Smtp-Source: ABdhPJw8B34q2i4XM4XyV5NH8sz3t/6oK3BIxKzCOZmgBRjJsLkNvqxANMutYqjJR1LHwjuNQEcCUg==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr28035139wrt.220.1592935720081;
        Tue, 23 Jun 2020 11:08:40 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:39 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/8] soc: qcom: rpmpd: Add SDM660 power-domains
Date:   Tue, 23 Jun 2020 20:08:25 +0200
Message-Id: <20200623180832.254163-2-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the shared cx/mx and sensor sub-system's cx and mx
power-domains found on SDM660.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/soc/qcom/rpmpd.c                      | 33 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 12 +++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 8058955fb3b9..45ec2439ff51 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,msm8996-rpmpd
       - qcom,msm8998-rpmpd
       - qcom,qcs404-rpmpd
+      - qcom,sdm660-rpmpd
       - qcom,sc7180-rpmhpd
       - qcom,sdm845-rpmhpd
       - qcom,sm8150-rpmhpd
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index f2168e4259b2..d54a84dd83a8 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -220,11 +220,44 @@ static const struct rpmpd_desc qcs404_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
+/* sdm660 RPM Power domains */
+DEFINE_RPMPD_PAIR(sdm660, vddcx, vddcx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_VFL(sdm660, vddcx_vfl, RWCX, 0);
+
+DEFINE_RPMPD_PAIR(sdm660, vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_VFL(sdm660, vddmx_vfl, RWMX, 0);
+
+DEFINE_RPMPD_LEVEL(sdm660, vdd_ssccx, RWSC, 0);
+DEFINE_RPMPD_VFL(sdm660, vdd_ssccx_vfl, RWSC, 0);
+
+DEFINE_RPMPD_LEVEL(sdm660, vdd_sscmx, RWSM, 0);
+DEFINE_RPMPD_VFL(sdm660, vdd_sscmx_vfl, RWSM, 0);
+
+static struct rpmpd *sdm660_rpmpds[] = {
+	[SDM660_VDDCX] =		&sdm660_vddcx,
+	[SDM660_VDDCX_AO] =		&sdm660_vddcx_ao,
+	[SDM660_VDDCX_VFL] =		&sdm660_vddcx_vfl,
+	[SDM660_VDDMX] =		&sdm660_vddmx,
+	[SDM660_VDDMX_AO] =		&sdm660_vddmx_ao,
+	[SDM660_VDDMX_VFL] =		&sdm660_vddmx_vfl,
+	[SDM660_SSCCX] =		&sdm660_vdd_ssccx,
+	[SDM660_SSCCX_VFL] =		&sdm660_vdd_ssccx_vfl,
+	[SDM660_SSCMX] =		&sdm660_vdd_sscmx,
+	[SDM660_SSCMX_VFL] =		&sdm660_vdd_sscmx_vfl,
+};
+
+static const struct rpmpd_desc sdm660_desc = {
+	.rpmpds = sdm660_rpmpds,
+	.num_pds = ARRAY_SIZE(sdm660_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
 	{ .compatible = "qcom,msm8998-rpmpd", .data = &msm8998_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
+	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpmpd_match_table);
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index dc146e44228b..c5a2ddef6b4b 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -101,6 +101,18 @@
 #define QCS404_LPIMX		5
 #define QCS404_LPIMX_VFL	6
 
+/* SDM660 Power Domains */
+#define SDM660_VDDCX		0
+#define SDM660_VDDCX_AO		1
+#define SDM660_VDDCX_VFL	2
+#define SDM660_VDDMX		3
+#define SDM660_VDDMX_AO		4
+#define SDM660_VDDMX_VFL	5
+#define SDM660_SSCCX		6
+#define SDM660_SSCCX_VFL	7
+#define SDM660_SSCMX		8
+#define SDM660_SSCMX_VFL	9
+
 /* RPM SMD Power Domain performance levels */
 #define RPM_SMD_LEVEL_RETENTION       16
 #define RPM_SMD_LEVEL_RETENTION_PLUS  32
-- 
2.27.0

