Return-Path: <linux-pm+bounces-11343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2156D93A322
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C971F22CD0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91E156F34;
	Tue, 23 Jul 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6T9+TQI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12097156C5F
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745999; cv=none; b=bLYCMZ4wuS+al2pLwkA2AEdlLW4e+c71DFvLS6iQj+1le3PuErD3mxj86dvN+RRMH2cctcKz49IfLr4wo7w9fMTcXqy11XozkicHIS3z+sMiHDUYaTS1JoLH9TSIA7E0ym5im/p/qAzMOHKtgwdESFbKbIC7lnk5Ou51gg0bI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745999; c=relaxed/simple;
	bh=WX8LSh0rDhHf39Hv/bNh9FIYIrWp/QkmbC/T7oE22gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp+0eXe3nbCSlHFDyzcYjMTGPXgq+Ld3ZEHPuYl6sfonnaKRf+rEmfgDvo92IbyPCiRMDKAfsv6RJL+LH7lzw8IkRM3f657jzp9VxnMr65JiUOT1cm34m5cJiuyA6pRmYkXnppKrxEMli3GGmOCQY804LqEc5IG8El6etWASoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6T9+TQI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f01afa11cso3809591e87.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745995; x=1722350795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBP7dKcnoInh8D+ltmvy6AsIFtXdPmqqH+0/BiruIy4=;
        b=O6T9+TQIqTsJoMcf34HEDRSTyxQFYXXO43oDOHHj0ElP1oNrL2DfHi6TaHTmtlX/nm
         yhnYdklrNNlkPPAYGAIuLsUwgmWJ7UXmjHezFyItqTJB/j3bxN83xOwkCQePy3IgbWzw
         X/ySlHG93DX3qIMHB9NWvp1zcc5tK7a9LmKNxNJdEFxp6brc87iqhCAyC0CmQPptReic
         +Pgz6SnJJvC1hZ5YGRlUCa1ma/HiFDF/Xtk3KYBwPW3skEi1Bz0y0w14z1GottaQzrcA
         2vSRM46+qZbNUnb0z5fGfGGxZzFwWTeZnUnOnyf6b9L2XgLDcgOnm3jWkRcc5TMGfmlW
         K0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745995; x=1722350795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBP7dKcnoInh8D+ltmvy6AsIFtXdPmqqH+0/BiruIy4=;
        b=tq/wPgL2ps2qtNnzOJ6PLEkSslVcrVzVKETHXJZ2u9QSPSDjBpFA8KMsanHJgUl5Cd
         /7IARn8I94m6bZcph2Hv6wV/lPIi5oZ7SW6J+wToqpkwkrN6X5DVmQuuUiilk5MoH6I7
         lnhlVDhYaptKKGWiTHfF/+M7GQmDU1iyFro2NsJojcti6/1wAn4ZXFOq5kqNTctRUTC9
         7z7/4w5pmIL7rrqa/W6oe4Dni2HJtNmY0W5VZMaKgk99t4eNe4YReyv7Ms3JrERjdlmj
         WnCC9J22IFcTVjEJPu6gF5slXj1eOvpNwHyoyby7delX8HNeNqZdbG+eYaQSnpZJGoU+
         mhUw==
X-Forwarded-Encrypted: i=1; AJvYcCUdpW7zvxotfxVnzZ1nhkz9dz0twN+a5YxC85iN2mvqmsCW/yHxKXU0+/hqg1Rmg518ZBFq6EIbahpmlyRQtH5i2SETxG7YAZ4=
X-Gm-Message-State: AOJu0YwI3CIUXC5shonfxbJI/QRfEdMfZ/J8T5p581lOx/Mj7gLN2PtZ
	x1isInurmfoC/S8Z6iGnvi3fRj8UJMSydiPMkz3Wsic9frV69EBTssmhqHX/0bI=
X-Google-Smtp-Source: AGHT+IFGj2dGhWRS15wyntOxuIbZDSW3f20N1Gxb1NU6kUm4Z5FMUXshX3IqJbFS6MM2MvmCAr6WLA==
X-Received: by 2002:a05:6512:2204:b0:52c:cc38:592c with SMTP id 2adb3069b0e04-52fc3fef109mr2116350e87.0.1721745995211;
        Tue, 23 Jul 2024 07:46:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0415eb08sm774540e87.9.2024.07.23.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:34 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/4] media: venus: Use dev_pm_domain_attach|detach_list() for OPP PM domain
Date: Tue, 23 Jul 2024 16:46:08 +0200
Message-Id: <20240723144610.564273-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723144610.564273-1-ulf.hansson@linaro.org>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
and manage the device-link, let's avoid the boilerplate-code by converting
into dev_pm_domain_attach|detach_list.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c      |  8 ++---
 drivers/media/platform/qcom/venus/core.h      |  6 +---
 .../media/platform/qcom/venus/pm_helpers.c    | 31 ++++++-------------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index ce206b709754..a422bbb3b610 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -709,7 +709,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -758,7 +758,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -815,7 +815,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.opp_pmdomain = (const char *[]) { "mx" },
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -874,7 +874,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = (const char *[]) { "cx" },
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 6a77de374454..aec587e6294f 100644
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
@@ -185,10 +183,8 @@ struct venus_core {
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
index 502822059498..e133683871aa 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -857,7 +857,6 @@ static int venc_power_v4(struct device *dev, int on)
 static int vcodec_domains_get(struct venus_core *core)
 {
 	int ret;
-	struct device **opp_virt_dev;
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
 	struct dev_pm_domain_attach_data vcodec_data = {
@@ -865,6 +864,11 @@ static int vcodec_domains_get(struct venus_core *core)
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
@@ -874,24 +878,14 @@ static int vcodec_domains_get(struct venus_core *core)
 		return ret;
 
 skip_pmdomains:
-	if (!core->res->opp_pmdomain)
+	if (!res->opp_pmdomain)
 		return 0;
 
 	/* Attach the power domain for setting performance state */
-	ret = devm_pm_opp_attach_genpd(dev, res->opp_pmdomain, &opp_virt_dev);
+	ret = dev_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
 	if (ret)
 		goto opp_attach_err;
 
-	core->opp_pmdomain = *opp_virt_dev;
-	core->opp_dl_venus = device_link_add(dev, core->opp_pmdomain,
-					     DL_FLAG_RPM_ACTIVE |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_STATELESS);
-	if (!core->opp_dl_venus) {
-		ret = -ENODEV;
-		goto opp_attach_err;
-	}
-
 	return 0;
 
 opp_attach_err:
@@ -902,12 +896,7 @@ static int vcodec_domains_get(struct venus_core *core)
 static void vcodec_domains_put(struct venus_core *core)
 {
 	dev_pm_domain_detach_list(core->pmdomains);
-
-	if (!core->has_opp_table)
-		return;
-
-	if (core->opp_dl_venus)
-		device_link_del(core->opp_dl_venus);
+	dev_pm_domain_detach_list(core->opp_pmdomain);
 }
 
 static int core_resets_reset(struct venus_core *core)
@@ -996,9 +985,7 @@ static int core_get_v4(struct venus_core *core)
 
 	if (core->res->opp_pmdomain) {
 		ret = devm_pm_opp_of_add_table(dev);
-		if (!ret) {
-			core->has_opp_table = true;
-		} else if (ret != -ENODEV) {
+		if (ret && ret != -ENODEV) {
 			dev_err(dev, "invalid OPP table in device tree\n");
 			return ret;
 		}
-- 
2.34.1


