Return-Path: <linux-pm+bounces-10768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5492A2A4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8351F215A3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754313C674;
	Mon,  8 Jul 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOjJDF8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615413B798
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441398; cv=none; b=kxjbUg0ZekmvL0AL5TYBjk83WATeuxooRjYMLKdHrGx6jBTClpVinu235XY+Mgk/DOyRYNbvOSFB0BqbixzYphqRkJn8b0//tK8RTMAFIUXKDdaOTPxoFB/uitoIZ2X49+0MpAjEuO27M1zrf/5JFGiGDtewlOuFnPbuB1pfUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441398; c=relaxed/simple;
	bh=4GFe15MMplZISD2mRKRIGTrlhVdPcnPi6hg96zSRZoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8JIe1SGeWVvVKQqDyQhQ5LfgbH3Tgf+WuI97BmxkWZSGhlcqhZOaC7OedZjPbB08BFVc9IUeuA9eA3hrSoaoB0B29SNGk07so+p8VQyhXe+2tebCbFsoQlplPIThrGzctvl83NwWiwQvRE0hZ59zJR+zzhSRw51nKXPQOquFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOjJDF8o; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso4850732a12.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441395; x=1721046195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMYtsmrWmpra2TO4Mu5yog2tiXr5havv6xPG/BMSews=;
        b=VOjJDF8oVeWEqDMzQgH/Vm+Ou1vimSrehjCQKdV+j/LzzwGTDx9C2OJO6nhpQ17y4Z
         6eRDmlFDp2zvS1gNdCgCpw8pr7j2DS1TL83NVUV4ySMFp7xssxnTpSt702v6QQ02rFoG
         hN9LeoqL/h5fA9pwVc97zmrpCeSAC0a/ImK5Y3YFiBZ3gfWUdI/pLRL3qhC3DPCfuFRq
         m+rylCxwV7Obciki2FhiuyNaT92s3eZo8aEOxesK/R4xcmcBQ7q0mxosZkBHn0WIgl64
         HOMJLSjQa9a7jKNNN7tjbO9DMRgdTQMyaOLSJ9V4WBEGE9frx/YroCfKDRxBnpotTUSm
         2xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441395; x=1721046195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMYtsmrWmpra2TO4Mu5yog2tiXr5havv6xPG/BMSews=;
        b=wrKGKAt+oSjgmxh5uaU+nE4w2LfQ0AIZjGTdBd5QUMjv0yqFzFHy4yDuwUiDNTrTtx
         /5rccPXrH+iTulS56QtX+pkYcWSLcyqBB9lY8L8PhcgsEgVN+94hMfQVkHCi/jTqlmna
         dv0JcruxELiU3jwM0c1QHFUXqf5rWSO1d/RGPLLJsztR1WECmPbrDvb/NdHYldFWIAzH
         1a+bRasOAFUEPiV08k+4ryn4R3/03XuHwwl+vt3Wq6R7WTbWAedCztIUyEDpdYgsjqv1
         KJrfTQX15bLiiOH+PJ0OiqEKSp4RG8nnXfB/NM9xfoxP9Oc9rPAmIls9/JSXjs2937RP
         2ldA==
X-Forwarded-Encrypted: i=1; AJvYcCUpONOJJC/ayz7EsTjABMjW0YCr3/Uzq1vXcBDBk6Mt0r4i2uKQbiromSUh2PCnvV3MXlZdPpZ3+v8eYDnvGBdZljyljo6Avjw=
X-Gm-Message-State: AOJu0YwztqlNcUo378SMJB58LjyCt7JlCvVuu91TQlMYZNHoePt19Inr
	LBxYJQH7VMu24/82jKC9YAamTHqGcaVppUIgFabGzrlZs3haFEgYIJ08W3S6Wuo=
X-Google-Smtp-Source: AGHT+IEQaZ79JDmlucwfNuLT9gh+vSxm1knKqmZGZ2z3D+cWhJoBD0Auw9q3oQRpPHMtRiPG371X4A==
X-Received: by 2002:a17:907:3f8b:b0:a72:8fc7:ef7f with SMTP id a640c23a62f3a-a77ba72c6camr845528366b.65.1720441395134;
        Mon, 08 Jul 2024 05:23:15 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:23:14 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:39 +0200
Subject: [PATCH v15 08/10] soc: qcom: cpr-common: Add threads support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-8-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=6371;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=R3yGeSgRjC51yaphFTSAoby0H8mBl+gtp/QxV8bmOsY=;
 b=A+jP0/5BMkKY8RDg2GPX0zR6ICkcO7W5/MFwC85A3taeme0Zan2dFEccMJ5Rgq34Z0gvSgB97
 yskZLO8DsIYDqdAdHHr6Cjg8RvSAYuDic9iRvbtFnokuEX7fwwYsBAn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add support for parsing per-CPR-thread data in preparation for introducing
CPR3+ support.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pmdomain/qcom/cpr-common.c | 42 +++++++++++++++++++++++---------------
 drivers/pmdomain/qcom/cpr-common.h |  8 ++++++--
 drivers/pmdomain/qcom/cpr.c        |  4 ++--
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr-common.c b/drivers/pmdomain/qcom/cpr-common.c
index 3e3a4a61cfde..9001dccd4d95 100644
--- a/drivers/pmdomain/qcom/cpr-common.c
+++ b/drivers/pmdomain/qcom/cpr-common.c
@@ -73,35 +73,42 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
-const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
 				     unsigned int num_fuse_corners)
 {
 	struct cpr_fuse *fuses;
-	int i;
+	char cpr_name[11]; /* length of "cpr" + length of UINT_MAX (7) + \0 */
+	unsigned int i;
 
 	fuses = devm_kcalloc(dev, num_fuse_corners, sizeof(*fuses), GFP_KERNEL);
 	if (!fuses)
 		return ERR_PTR(-ENOMEM);
 
+	/* Support legacy bindings */
+	if (tid == UINT_MAX)
+		snprintf(cpr_name, sizeof(cpr_name), "cpr");
+	else
+		snprintf(cpr_name, sizeof(cpr_name), "cpr%d", tid);
+
 	for (i = 0; i < num_fuse_corners; i++) {
-		char tbuf[32];
+		char tbuf[50];
 
-		snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_ring_osc%d", cpr_name, i + 1);
 		fuses[i].ring_osc = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].ring_osc)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_init_voltage%d", cpr_name, i + 1);
 		fuses[i].init_voltage = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].init_voltage)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient%d", cpr_name, i + 1);
 		fuses[i].quotient = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].quotient)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient_offset%d", cpr_name, i + 1);
 		fuses[i].quotient_offset = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].quotient_offset)
 			return ERR_PTR(-ENOMEM);
@@ -202,15 +209,15 @@ int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 }
 EXPORT_SYMBOL_GPL(cpr_find_initial_corner);
 
-unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
+unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid)
 {
 	struct device_node *np;
 	unsigned int fuse_corner = 0;
 
 	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner))
-		pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
-		       __func__);
+	if (of_property_read_u32_index(np, "qcom,opp-fuse-level", tid, &fuse_corner))
+		pr_err("%s: missing 'qcom,opp-fuse-level[%u]' property\n",
+		       __func__, tid);
 
 	of_node_put(np);
 
@@ -235,15 +242,16 @@ u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 	if (!ref_np)
 		goto out_ref;
 
-	do {
-		of_node_put(child_req_np);
-		child_np = of_get_next_available_child(desc_np, child_np);
+	for_each_available_child_of_node(desc_np, child_np) {
 		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
-	} while (child_np && child_req_np != ref_np);
 
-	if (child_np && child_req_np == ref_np)
-		of_property_read_u64(child_np, "opp-hz", &rate);
+		if (child_np && child_req_np == ref_np) {
+			of_property_read_u64(child_np, "opp-hz", &rate);
+			goto out;
+		}
+	}
 
+out:
 	of_node_put(child_req_np);
 	of_node_put(child_np);
 	of_node_put(ref_np);
diff --git a/drivers/pmdomain/qcom/cpr-common.h b/drivers/pmdomain/qcom/cpr-common.h
index 1b2fa344eb09..2c5bb81ab713 100644
--- a/drivers/pmdomain/qcom/cpr-common.h
+++ b/drivers/pmdomain/qcom/cpr-common.h
@@ -22,6 +22,9 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int range_uV;
+	/* fuse volt: closed/open loop */
+	int volt_cloop_adjust;
 	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
@@ -55,6 +58,7 @@ struct corner {
 	u32 save_ctl;
 	u32 save_irq;
 	u64 freq;
+	bool is_open_loop;
 	struct fuse_corner *fuse_corner;
 };
 
@@ -81,7 +85,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 			      struct fuse_corner *fuse_corner,
 			      const struct cpr_fuse *cpr_fuse,
 			      int num_fuse_corners);
-const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
 				     unsigned int num_fuse_corners);
 int cpr_populate_fuse_common(struct device *dev,
 			     struct fuse_corner_data *fdata,
@@ -91,7 +95,7 @@ int cpr_populate_fuse_common(struct device *dev,
 			     int init_v_step);
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
-u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
+u32 cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid);
 u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index b2e6e6eaae73..25856cf721ae 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -851,7 +851,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		opp = dev_pm_opp_find_level_exact(&drv->pd.dev, level);
 		if (IS_ERR(opp))
 			return -EINVAL;
-		fc = cpr_get_fuse_corner(opp);
+		fc = cpr_get_fuse_corner(opp, 0);
 		if (!fc) {
 			dev_pm_opp_put(opp);
 			return -EINVAL;
@@ -1319,7 +1319,7 @@ static int cpr_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drv->cpr_fuses = cpr_get_fuses(drv->dev, desc->num_fuse_corners);
+	drv->cpr_fuses = cpr_get_fuses(drv->dev, UINT_MAX, desc->num_fuse_corners);
 	if (IS_ERR(drv->cpr_fuses))
 		return PTR_ERR(drv->cpr_fuses);
 

-- 
2.45.2


