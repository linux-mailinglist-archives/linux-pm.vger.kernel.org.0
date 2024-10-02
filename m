Return-Path: <linux-pm+bounces-15061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5A98D31C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E971F24496
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519A1D0B85;
	Wed,  2 Oct 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8J8SpJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD61D0955
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871782; cv=none; b=Z1MmnSNxkFZCMRhNHQzLWBlpbY8BCpEkm6nJYRS/msRQQfDGeS2xXhZGsKu33dZ4gHk5BYpgYZeifSjFtbsA89HsBxgpbxUM/7LpuWKGYFqJtNiq5OrfNSfILMkQVhwBlEb20cGzwnO5R3yiiG7pbREUt4aImcTiOR3SyLr3Bik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871782; c=relaxed/simple;
	bh=sGY+H8789Q9JtgwErnOIGZdYqKc19DOjdR9zTGYRZHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTXk+sMFs2XDJjFAXUYn7CrPmeNBmQaMOkydEffaaIPOHytBHlSiEpI/S1k4NGV7+EE42XrI/1b1w4Zw4u8WWxKF3bqTWGglpFKlYSZYMLdAcf8iKGHz6qMEweeXbOcaa/UeLsSMbdaz/4EUoGvcY/9w+OPb+xtFnJ2az4NIr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i8J8SpJw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53993564cb1so4090858e87.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871779; x=1728476579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vaf6IlG9zhgPzI3KNwNmZFZZ51blXFrFiAKMgpkRJ3I=;
        b=i8J8SpJw8mciG5ab3QqfV+BOsaSZELHCG/wNd53iWsDaN38x0+zapdoJNOAzqV4O9o
         MCXAGrFgv8g7+Xf2B7mggvKG0tWd5qky+OUGo2bXjGqOIQOQGgE/AEb1J7G/2ffFjKG/
         Q+WjD/Qj4Lz3uH13uhlGCDpmpn1ZkfRa/8z8xFyU/j2Fkyh1L1KXRD3xi1jMntcqULOo
         Jl8lJBpcPwmJPjImSJm7B+JKFJBvSuq6Wkk7pPtYPpxI34l1we0cIl2Fj898ADlrQgLt
         BTYYW+BLd4RTEdqiiKv78vnIItM1wlPAYY7ce12ia4fFoor5bsopBVkIu2TwGsOIB9fq
         Qr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871779; x=1728476579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vaf6IlG9zhgPzI3KNwNmZFZZ51blXFrFiAKMgpkRJ3I=;
        b=ujwHWhHsGm6Ld2LcMQN7YCrY0mv2GdjKUo0Ko5znkZKCW05U8SZi0SU++LLzpR4Cfd
         /aqAuv4wVBK5nBoLFQ4/PQOw3BEZoM0y8Eo/MLvSZnWne9VqfC7NrNCgAkyAXbEB/A22
         96BL25IwqDB9tOlCPgMoUhz3y35CRTpT6YohyqJt5rcTTlvTDS7ahcIHfijHLguZo+Bt
         /NhjSreAHjzNzO+ZrNgFJYrSgpHzh1XKSBAXCWYmVXg4aaJikkBZTVT4+GmBWumKI7om
         9ec8/hWhyrO6Huz6gBEJor+hxMHx6DLD6Bcx2mzaUE8CHrXGXDso+GCXk8KISwP8gYDq
         7phA==
X-Forwarded-Encrypted: i=1; AJvYcCUSXmv0hNGFSL83L4XAd2m8QFddxLshCA0y4tlHozrNRjkx8kMGG8ebtKQI0+pYEPptKC2QDsiB2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YwgjUtKWG/VFG4NOYmcRA2KOZq9IaYIlImGmLRqHhtnYPjeG
	HluZlI7IelhdiVRKT+rXwBuxWcIH0gXMnRUK1RvkPtkh4YqDy06M+haMx3m3IQQ=
X-Google-Smtp-Source: AGHT+IF2C5fiXmGg2CrFCAR3PvK0jhrzjShfC2YJsprlsYnRU756vzhC6TCORSWVEQUMw5Zyl9Yn6w==
X-Received: by 2002:a05:6512:334d:b0:539:a4ef:6752 with SMTP id 2adb3069b0e04-539a4ef6a4dmr525834e87.6.1727871778597;
        Wed, 02 Oct 2024 05:22:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:58 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 09/11] media: venus: Convert into devm_pm_domain_attach_list() for OPP PM domain
Date: Wed,  2 Oct 2024 14:22:30 +0200
Message-Id: <20241002122232.194245-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002122232.194245-1-ulf.hansson@linaro.org>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Minor. Use PD_FLAG_REQUIRED_OPP.

---
 drivers/media/platform/qcom/venus/core.c      |  8 ++--
 drivers/media/platform/qcom/venus/core.h      |  6 +--
 .../media/platform/qcom/venus/pm_helpers.c    | 44 +++++--------------
 3 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 84e95a46dfc9..8ad36ed0ca8b 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -752,7 +752,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -801,7 +801,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -858,7 +858,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.opp_pmdomain = (const char *[]) { "mx" },
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -917,7 +917,7 @@ static const struct venus_resources sc7280_res = {
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
index ea8a2bd9419e..33a5a659c0ad 100644
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
+		.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
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


