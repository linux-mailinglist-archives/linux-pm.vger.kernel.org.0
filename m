Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB7785702
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjHWLpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjHWLpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 07:45:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663A3E70
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 04:45:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so30479221fa.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692791144; x=1693395944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj2meqHj1uQ8ycW47wSLw+vGt1Gkm3UaWY3FGRdov4I=;
        b=LxvOihteykPsbq0ELFTsjunH9/Ll/sHYoF0bL2a2KmEegWSK8l3PyI9a5mqt/x1VYu
         YBppL1uMhdjmPARq5c7mFKF0ek45ULf1vCjrkQRwiRGQBW68DfWSattIGoViHoWRHImk
         pRC6/mClZ+V8jq7/nxnYcEGU241WIaqTkuzwykfJDWGrzIDEGLMWw0e0ClhnX7st4rpE
         x4FJAxwrWpuJXQ/DWzKFQYq6TqCJsu/HnQaZHI/ZKuekcveLchxOJnU/ATtJRoUyNwrV
         vb7PglOWtDhHcnC1IRbAd4AOVBd29xdbxDwIzif9js0jEWQcj6akAa3xt4+Sp3rvZUOW
         I1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692791144; x=1693395944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj2meqHj1uQ8ycW47wSLw+vGt1Gkm3UaWY3FGRdov4I=;
        b=ChydoNCqBoj2jhMKHKIlObMTVDJWVJC1evjVeiG00kf1/CJut++s6O+dauABxvSGXb
         N1qvPY6p3oW1Iz2fvxh1v9vI6Tewq+3shHHWIlqoqQS7Q2BSyYIiERpkFNCtDpS+2yD+
         odNLT4lL2shwmJWE73Llwy8yY6lCFq8/1EHk7rrKByjfmgp9a9BhYBKNbq1/ce970ikt
         QrBSwmi/cQX2mfmCotl6Dar+p9BRvEzKpWQ8gf+eOXovpBNQShHYcndTN43emmr74sof
         0cULVIdlKtqC2s/wjTYEPBc1fJ0xH4DiuZ9ToruSlo7hKxXoswEFe+IgchU6TGDdwwek
         Gtjw==
X-Gm-Message-State: AOJu0YzKmNP/dLJ7ix0TpHzX7u+H2ZToZW9zDINfTndikUufD9HlZwr8
        cwT9g2fW3V5kuOhpwAJm13xzqg==
X-Google-Smtp-Source: AGHT+IHcRniuOaTwNb3qeIRnIhh7FLNsaHEOk7sAt8OJGcjm/DL1E6rAHN1GjxntF7AtC9iXjIu26g==
X-Received: by 2002:a2e:908a:0:b0:2bc:b0c3:9e8d with SMTP id l10-20020a2e908a000000b002bcb0c39e8dmr8678383ljg.41.1692791144651;
        Wed, 23 Aug 2023 04:45:44 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b003fbc0a49b57sm18503577wmc.6.2023.08.23.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:45:44 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH v3 5/5] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode
Date:   Wed, 23 Aug 2023 14:45:28 +0300
Message-Id: <20230823114528.3677667-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823114528.3677667-1-abel.vesa@linaro.org>
References: <20230823114528.3677667-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jagadeesh Kona <quic_jkona@quicinc.com>

This change demonstrates the use of dev_pm_genpd_set_hwmode API from
video driver to switch the video mvs0 gdsc to SW/HW modes at runtime
based on requirement.

This change adds a new boolean array member vcodec_pmdomains_hwctrl in
venus_resources structure to indicate if GDSC's have HW control support
or not. This data is used in vcodec_control_v4() to check if GDSC has
support to switch to HW control mode and then call dev_pm_genpd_set_hwmode
to switch the GDSC mode.

Before the GDSC HWCTL was available to the consumer, the venus driver
needed to somehow keep the power from collapsing while under the driver
control. The only way to do that was to clear the CORE_PWR_DISABLE bit
(in wrapper POWER_CONTROL register) and, respectively, set it back after
the driver control was completed.

Now, that there is a way to switch the GDSC HW/SW control back and
forth, the CORE_PWR_DISABLE toggling can be dropped.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * Explained the removal of the POWER_CONTROL register toggle and why
   the fact the GDSC HW control knob availability to the consumer
   renders that useless.

 drivers/media/platform/qcom/venus/core.c      |  4 ++
 drivers/media/platform/qcom/venus/core.h      |  1 +
 .../media/platform/qcom/venus/pm_helpers.c    | 47 ++++++++-----------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 054b8e74ba4f..8145062ab6f7 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -706,6 +706,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
+	.vcodec_pmdomains_hwctrl = { false, true, true },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 2,
@@ -755,6 +756,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_hwctrl = { false, true },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
@@ -812,6 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_hwctrl = { false, true },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "mx", NULL },
 	.vcodec_num = 1,
@@ -871,6 +874,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_hwctrl = { false, true },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 4a633261ece4..6d591ecad482 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -73,6 +73,7 @@ struct venus_resources {
 	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	unsigned int vcodec_clks_num;
 	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	bool vcodec_pmdomains_hwctrl[VIDC_PMDOMAINS_NUM_MAX];
 	unsigned int vcodec_pmdomains_num;
 	const char **opp_pmdomain;
 	unsigned int vcodec_num;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 48c9084bb4db..c53eef23c793 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -408,35 +408,28 @@ static const struct venus_pm_ops pm_ops_v3 = {
 
 static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
 {
-	void __iomem *ctrl, *stat;
-	u32 val;
-	int ret;
-
-	if (IS_V6(core)) {
-		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
-		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
-	} else if (coreid == VIDC_CORE_ID_1) {
-		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
-		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
-	} else {
-		ctrl = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
-		stat = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
-	}
-
-	if (enable) {
-		writel(0, ctrl);
-
-		ret = readl_poll_timeout(stat, val, val & BIT(1), 1, 100);
-		if (ret)
-			return ret;
-	} else {
-		writel(1, ctrl);
+	int i, ret = 0;
+	struct device *dev = core->dev;
+	const struct venus_resources *res = core->res;
 
-		ret = readl_poll_timeout(stat, val, !(val & BIT(1)), 1, 100);
-		if (ret)
-			return ret;
+	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
+		if (res->vcodec_pmdomains_hwctrl[i]) {
+
+			if (!core->pmdomains[i])
+				return -ENODEV;
+
+			/*
+			 * enable( true ), switch the gdsc to SW mode
+			 * enable( false), switch the gdsc to HW mode
+			 */
+			ret = dev_pm_genpd_set_hwmode(core->pmdomains[i], !enable);
+			if (ret) {
+				dev_err(dev, "Failed to switch power-domain:%d to %s mode\n",
+					i, enable ? "SW" : "HW");
+				return ret;
+			}
+		}
 	}
-
 	return 0;
 }
 
-- 
2.34.1

