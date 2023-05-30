Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013FE715B67
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 12:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjE3KUW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjE3KUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 06:20:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C176BF7
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso3272666e87.1
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442009; x=1688034009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2kIraAUGywb2+d2U4eiUZYtYMrjO65pXPVCKxcFzAQ=;
        b=FXLaLTk0DnaJqBKJCU01rRK0ZsoXEA9e8UpGSsALNLu8ghDb+E6k6aWSyNSyVC6lPa
         ilZz6vEWkOsaRlzIs9sC3ObchnfoWlO5XhSKc7ZGkKVZalmFGQkZWEmLghC4O/5l36xI
         FzrQATVKeWmyc60EN/bypsWM/feyiHYmvVDEB7FXmpg+LeDlqC5hnyvTEHPYqvYcx7B0
         3gtj57XsHk+bb1gs0hniq3yVlPQK21vbSXtr2WmQGEtx3+AEQ5jV7LkzjXduyRJaKwu2
         rdij/JhgaI3sB8nupnRZSkyceBSsbbCSqXfQry0BOShYN2wmi7xlDdhavkdqwEsm0Jyc
         LNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442009; x=1688034009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2kIraAUGywb2+d2U4eiUZYtYMrjO65pXPVCKxcFzAQ=;
        b=OG/0fXPndPPMFJJnNlXirJNnCD2DlJ2Y55XsQlbhBXUozQKJDIOyGsQnYOQCatx6hh
         3ynMb5hZw1ISSeDMb7dG69fVMMvyW+w5NIiT+NXzxD58EAUP/YEOVK/vD1ailN7Qe2zv
         r9L3QhyVUvqf+3RVuv7dFId/Cn8qz8PlVH7t2oxjyXu2iSG0Ti1LV+jn5oP9F+05KRKR
         u/HmnOovfDP4xy5lxtF8RHJ1HAw73/5Qm2H24ksjNakp7+VL0BcVjBoGipxsuEKsXHwV
         Gs32YPRR8jX2OOWWW1Mvz6WWmST/iUeNKez/NAWaz/yIRBD/67oz5ER2ag3RpDdTvOal
         eQPA==
X-Gm-Message-State: AC+VfDwtQyARD9PesNqzjmhAClYo4ttYBvNznEbLRFI6z8CMhXbV7p6O
        V4d183bCfntswBFSqXxtNDuFAQ==
X-Google-Smtp-Source: ACHHUZ6V9aiyPB1rEZrvr74Gq50/5rPQenYEg+WViShIap4NPP1ErYCPYs2dr4eVPFn7guUzBNEeSQ==
X-Received: by 2002:ac2:5393:0:b0:4f2:5007:bd7f with SMTP id g19-20020ac25393000000b004f25007bd7fmr567797lfh.36.1685442009111;
        Tue, 30 May 2023 03:20:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:03 +0200
Subject: [PATCH 04/20] clk: qcom: smd-rpm: Export clock scaling
 availability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-4-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=1931;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vv9ovaVfudhM+q+5bDTICrg6LSXL32E3dDhuR4rNt6k=;
 b=/ynbR+DidbffM3nQVfBIlotgJXYyM7xDfgIAvWguD3MbX/y+Tz21Z3ModMTfX2ZnhmxTxTZmY
 rGXg7qPFu4TDYEbz++ruI7IA9iK9AGtL+ClI+4WyA6KXMk6XcLlm/Be
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
clock rate requests will not be commited in hardware. This poses a
race threat since we're accessing the bus clocks directly from within
the interconnect framework.

Add a marker to indicate that we're good to go with sending new requests
and export it so that it can be referenced from icc.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
 include/linux/soc/qcom/smd-rpm.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index b63f946e4520..f8f5977408e0 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -151,6 +151,7 @@
 #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
 
 static struct qcom_smd_rpm *rpmcc_smd_rpm;
+static bool smd_rpm_clk_scaling;
 
 struct clk_smd_rpm {
 	const int rpm_res_type;
@@ -393,6 +394,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
 	return r->rate;
 }
 
+bool qcom_smd_rpm_scaling_available(void)
+{
+	return smd_rpm_clk_scaling;
+}
+EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
+
 static int clk_smd_rpm_enable_scaling(void)
 {
 	int ret;
@@ -418,6 +425,8 @@ static int clk_smd_rpm_enable_scaling(void)
 		return ret;
 	}
 
+	smd_rpm_clk_scaling = true;
+
 	pr_debug("%s: RPM clock scaling is enabled\n", __func__);
 	return 0;
 }
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 8190878645f9..420f6c79d535 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -65,4 +65,6 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 		       u32 resource_type, u32 resource_id,
 		       void *buf, size_t count);
 
+bool qcom_smd_rpm_scaling_available(void);
+
 #endif

-- 
2.40.1

