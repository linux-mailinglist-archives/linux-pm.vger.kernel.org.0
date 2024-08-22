Return-Path: <linux-pm+bounces-12785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D22695C115
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40ACB242A3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A521D364D;
	Thu, 22 Aug 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fk5nOHwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF11D2F7F
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366779; cv=none; b=aVFDqGogvW/EPao6xOJXowPz/vZNZ8BNSDlpdRPPaRBB7FtrtVddnPAsib+Ft1a85pCmgnERu9bA/jsKi3LXts0AGB7kBbfoeYSvWQkPoYOixBOpQtAh9ZHUa7/PL9rzIOdN3o5xefFbITPsVOMExJhqpADpsy24ZvkmTBBKb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366779; c=relaxed/simple;
	bh=Ovr+J/J43NIgh+z5G4Zg3sqsrt0ah7LcS47W5xpCqBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWnaCJ1/Ko1oe+3VGJgua7NYq2EWxYae7WLoT+gYZ9sCT6r8mUvF9zAFY3GyEfrlciiZK/fxD4/IOjtC/HbBB4RM4c+Rr+bi4EV/gqvRwrYSq2Pu2/CGRnCS4RPvIEoGhuec8nRbQhZeOqj6rHWToUoqiL5gzmW+WnSN+rxcz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fk5nOHwa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53438aa64a4so60798e87.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366775; x=1724971575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1A26YlhfePaP3jDbaTwUiFXKbFKwoAq1rqRtisM7j8=;
        b=fk5nOHwa9nMMFrtfZs6iHo2/IEDoWXppuaW04I9eEO5OcfThpPQe3BeOa+aIky8gAD
         zUWEyIWBgn5t0ddLruaprxqZdjtTtcL3sl5KVs/O5VTHNDdbPec7UyruCkRyc6Ayi+gP
         zcLcrWHu58hs41+aoyfE7Rr10szAXGOnXZppxEoVGhLnAymMmaFzkcFFRBLAyv1mM5/n
         hfUwr2Kr2F5p7JYFq0jeMGtteFtgkRCMxS1k2Yh6Z2YGTJQyMYCcYCfwS/fwdZ/pCzdk
         RiBCEJ+y54w4mzDGhtGIp/zo0vWk+c1pAsowwRlFtuxaOEBOymguqKS+HeXIiNYWyy3U
         xxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366775; x=1724971575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1A26YlhfePaP3jDbaTwUiFXKbFKwoAq1rqRtisM7j8=;
        b=Uwor65OATNNTAwBbu3bsO1I6RDXBFAv55sRsgD2LHGFFswvptt+2JxmR6w3icJR99b
         jDNDpDphuo23YIel0b7M6or4zog+hYsuWmMbN2s9FAPXfNl9Lmkc/ISTSP4rT3LMvwTq
         J7xx4M0uyzV+VIB8fmY6jObmwDXtCjYLwoglP8Tga3C/5Dr0s3YaxQ9TjXeBdAhibOEz
         PlelMaGufbdcnisbFOGWqsWRzrVfz1p6ad3poz9rEFZS5FFV0S0nvjCTy6Li/eQPUzrP
         kVlDTS1QT7HqaB8/cfO7hM1rV1HEop8WVs4vLs04ZxTeM+YduvHZoDCo2d8Logd3e5SG
         cP9w==
X-Forwarded-Encrypted: i=1; AJvYcCUuVWZAdiLJpEHR1FmvUCJIqw3g7l/Zr1A3smOu26nEecqCF9et4iws49fVxQdlkg9AtLayx0A1NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxktJ/Cb4t+lG68Ocz1oeNsHGTUb2uu+7nZSTEzMthxp3wLTDoC
	uc7zGXfgAPJUWC99/apFDLs5IwNhT6Tt1AUv4c61v81ylRFrs8DB4TQ6VVkBLyg=
X-Google-Smtp-Source: AGHT+IEYCvO6PxDZuiKr7Z/6TAjnmPIaE1HH1Y16/UregoH9/xLXNer5kgVUUiDFaWpCN/2/MSiCtA==
X-Received: by 2002:a05:6512:1282:b0:533:4785:82a2 with SMTP id 2adb3069b0e04-53438869dccmr141908e87.59.1724366775519;
        Thu, 22 Aug 2024 15:46:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:15 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] media: venus: Convert into devm_pm_domain_attach_list() for OPP PM domain
Date: Fri, 23 Aug 2024 00:45:45 +0200
Message-Id: <20240822224547.385095-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than hooking up the PM domain through devm_pm_opp_attach_genpd() and
manage the device-link, let's avoid the boilerplate-code by converting into
devm_pm_domain_attach_list().

Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Updated commitmsg and added Stanimir's ack.
	- Converted to devm mangaged version of dev_pm_domain_attach_list()
---
 drivers/media/platform/qcom/venus/core.c      |  8 ++--
 drivers/media/platform/qcom/venus/core.h      |  6 +--
 .../media/platform/qcom/venus/pm_helpers.c    | 44 +++++--------------
 3 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 165c947a6703..4666278671e2 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -751,7 +751,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -800,7 +800,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -857,7 +857,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.opp_pmdomain = (const char *[]) { "mx" },
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -916,7 +916,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 55202b89e1b9..435325432922 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -132,9 +132,7 @@ struct venus_format {
  * @vcodec1_clks: an array of vcodec1 struct clk pointers
  * @video_path: an interconnect handle to video to/from memory path
  * @cpucfg_path: an interconnect handle to cpu configuration path
- * @has_opp_table: does OPP table exist
  * @pmdomains:	a pointer to a list of pmdomains
- * @opp_dl_venus: an device-link for device OPP
  * @opp_pmdomain: an OPP power-domain
  * @resets: an array of reset signals
  * @vdev_dec:	a reference to video device structure for decoder instances
@@ -186,10 +184,8 @@ struct venus_core {
 	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
-	bool has_opp_table;
 	struct dev_pm_domain_list *pmdomains;
-	struct device_link *opp_dl_venus;
-	struct device *opp_pmdomain;
+	struct dev_pm_domain_list *opp_pmdomain;
 	struct reset_control *resets[VIDC_RESETS_NUM_MAX];
 	struct video_device *vdev_dec;
 	struct video_device *vdev_enc;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index ea8a2bd9419e..355dfa586f8e 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -864,7 +864,6 @@ static int venc_power_v4(struct device *dev, int on)
 static int vcodec_domains_get(struct venus_core *core)
 {
 	int ret;
-	struct device **opp_virt_dev;
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
 	struct dev_pm_domain_attach_data vcodec_data = {
@@ -872,6 +871,11 @@ static int vcodec_domains_get(struct venus_core *core)
 		.num_pd_names = res->vcodec_pmdomains_num,
 		.pd_flags = PD_FLAG_NO_DEV_LINK,
 	};
+	struct dev_pm_domain_attach_data opp_pd_data = {
+		.pd_names = res->opp_pmdomain,
+		.num_pd_names = 1,
+		.pd_flags = PD_FLAG_DEV_LINK_ON,
+	};
 
 	if (!res->vcodec_pmdomains_num)
 		goto skip_pmdomains;
@@ -881,37 +885,15 @@ static int vcodec_domains_get(struct venus_core *core)
 		return ret;
 
 skip_pmdomains:
-	if (!core->res->opp_pmdomain)
+	if (!res->opp_pmdomain)
 		return 0;
 
 	/* Attach the power domain for setting performance state */
-	ret = devm_pm_opp_attach_genpd(dev, res->opp_pmdomain, &opp_virt_dev);
-	if (ret)
-		goto opp_attach_err;
-
-	core->opp_pmdomain = *opp_virt_dev;
-	core->opp_dl_venus = device_link_add(dev, core->opp_pmdomain,
-					     DL_FLAG_RPM_ACTIVE |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_STATELESS);
-	if (!core->opp_dl_venus) {
-		ret = -ENODEV;
-		goto opp_attach_err;
-	}
+	ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
+	if (ret < 0)
+		return ret;
 
 	return 0;
-
-opp_attach_err:
-	return ret;
-}
-
-static void vcodec_domains_put(struct venus_core *core)
-{
-	if (!core->has_opp_table)
-		return;
-
-	if (core->opp_dl_venus)
-		device_link_del(core->opp_dl_venus);
 }
 
 static int core_resets_reset(struct venus_core *core)
@@ -1000,9 +982,7 @@ static int core_get_v4(struct venus_core *core)
 
 	if (core->res->opp_pmdomain) {
 		ret = devm_pm_opp_of_add_table(dev);
-		if (!ret) {
-			core->has_opp_table = true;
-		} else if (ret != -ENODEV) {
+		if (ret && ret != -ENODEV) {
 			dev_err(dev, "invalid OPP table in device tree\n");
 			return ret;
 		}
@@ -1013,10 +993,6 @@ static int core_get_v4(struct venus_core *core)
 
 static void core_put_v4(struct venus_core *core)
 {
-	if (legacy_binding)
-		return;
-
-	vcodec_domains_put(core);
 }
 
 static int core_power_v4(struct venus_core *core, int on)
-- 
2.34.1


