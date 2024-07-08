Return-Path: <linux-pm+bounces-10767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927E92A2A2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA55B260A8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578A13B2A2;
	Mon,  8 Jul 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hi7/S844"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55913AA26
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441396; cv=none; b=Ou/T2iwbsSf+176XaPSJTKBBWrjnlD+WAYqU1ZA1Sh0w4BpRdi2apOzeI5P7LMxYHojIsz+Uh7ijluarmfRDTnRWhqOpwNaZFTD1TMot8Lb9f4M1KJHlTByKsYePgsTQFWlhjytUKywG/iUy7rmYkh/cZ3ZM0pGVZo9xVZG/b48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441396; c=relaxed/simple;
	bh=S4/6dqVzCQ55H+jEzo18/eSt3/yhBjBw+Vgvf5+K9HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfF9VXQ0yNnn3A7xXyPOCmVOoMWOIvKTViaJwmEO9Fztdqh3Aj06uGTpvg5M7tFS/16OpSGWMVBZBUKsMyhlmH8Eejb0lb0oKhD7q14eW4K1+8Io2FhhtK534EzBkkGoe4Ya1d0nFd3Lnd3bhTOmj+JI87icnCqtWVhUBwsEnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hi7/S844; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77dc08db60so290147466b.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441393; x=1721046193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS6pi0mbZ0HVf65HjWjlZ5m8NQ5AsGtLpzqZjXxkjCQ=;
        b=hi7/S8443ET0GeYaRrO34NlP7gPKm8FIxVbGmOSki0bNdU5gQEa7r2Boo1hAiHDGK8
         ihu/XLIkF9gSoEFreor/C0dX4TNaQ2kjVisiGoEgIbWNPizaAOrn7DqaadmMsWWYdOVC
         7JSvn66BZnSvv6PxzaKls8Go8bZdn+fx/4aN+Rm0DJ8JKgU++2LC9eIGCDlL9hsJHvzw
         DBjA1m4amhIIBWUB0qjtwga7pWd8NijWC/WXIjIBG+ixh7n3ZIYnYlcaJoH7ykeoY+O1
         K2uo2/k4jRjspaby15RXl2/LNxTuBr47fSzlukoVKvHjE88Iz+bM8t836F0LLWgWRWNG
         waWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441393; x=1721046193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JS6pi0mbZ0HVf65HjWjlZ5m8NQ5AsGtLpzqZjXxkjCQ=;
        b=VCrvIauz3ZnBvzv5tG3Dac2MG/e/cKdiK1l6HPt4UsXsqze/9OB0jU+pgQnt4tA3AW
         fp2h82ZHDoPi9nHln5zBOH7A3/tYYBej/GtqaASVbHY+41riAOVrVsl59ruiPk/mCucc
         t7aSn744lrcvtVJC8wYDaF03zdBleMczbaFZCJx6IYmk8fIZ5AKymPCvwMJK48fEV4uu
         O8ZgRM0I+989m1pCvxwqD17R//72ofupZh9+KEmjEWEGWlT4mr5wqgOhsB6TRt8oJvO2
         vfSx7gK2iFH8bdal4GxZfBnsno8AP0E3yOmKyNfZPfJuutL9WtQFZOZIkpO4uuZENWNE
         109w==
X-Forwarded-Encrypted: i=1; AJvYcCUVlWX7orXEkhrLTSdiKO0RvT/p7cUcGn8UMtYNMU+JZEx3P0BjIqKCRTGw1Mt8yOj+Ny3Y4nUvGeGL0cc930nigeSsrmVSwlo=
X-Gm-Message-State: AOJu0Yw3KN3OjJW5EfgRzohUSJx4c5KoZLlOHVXrJ/Iuj35Urp9taJxy
	IVRCeLDIDB2U3KjRpZwnkHisAw2rVfOClhECCw1HsVeO7suLLEAXnrxeQxcJJlg=
X-Google-Smtp-Source: AGHT+IEqCM5zd4aXRr5or3PDC2PLi11dRi2QzgmCl8YdBcyy4aTB4fLnWFVBxZOXWniNk5yrvjX17g==
X-Received: by 2002:a17:906:24ce:b0:a77:e1fb:7df4 with SMTP id a640c23a62f3a-a77e1fb7f9cmr411901866b.13.1720441392984;
        Mon, 08 Jul 2024 05:23:12 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:23:12 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:38 +0200
Subject: [PATCH v15 07/10] soc: qcom: cpr: Use u64 for frequency
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-7-5bc8b8936489@linaro.org>
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
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=4791;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=S4/6dqVzCQ55H+jEzo18/eSt3/yhBjBw+Vgvf5+K9HA=;
 b=JNg8MhX1IceKVwxNHOoyy/y2U2abJGJALs6cO2umKguYPDeKiU5SIgPNlLiFqqrhT+D8Q5X0S
 YUib4hKDlVUB3JPKtjezGFNVSiTsbqXuj8tonaXAcrQaYCfFnPtDSX2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

32 bits is not enough for over-2.changeGHz frequencies. Move all variables
that operate on Hz to u64 to avoid overflows.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pmdomain/qcom/cpr-common.c | 13 +++++++------
 drivers/pmdomain/qcom/cpr-common.h |  9 ++++-----
 drivers/pmdomain/qcom/cpr.c        |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr-common.c b/drivers/pmdomain/qcom/cpr-common.c
index 44c681bbbf13..3e3a4a61cfde 100644
--- a/drivers/pmdomain/qcom/cpr-common.c
+++ b/drivers/pmdomain/qcom/cpr-common.c
@@ -218,7 +218,7 @@ unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(cpr_get_fuse_corner);
 
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 				     struct device *cpu_dev)
 {
 	u64 rate = 0;
@@ -250,7 +250,7 @@ unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 out_ref:
 	of_node_put(desc_np);
 
-	return (unsigned long) rate;
+	return rate;
 }
 EXPORT_SYMBOL_GPL(cpr_get_opp_hz_for_req);
 
@@ -260,7 +260,7 @@ int cpr_calculate_scaling(struct device *dev,
 			  const struct corner *corner)
 {
 	u32 quot_diff = 0;
-	unsigned long freq_diff;
+	u64 freq_diff;
 	int scaling;
 	const struct fuse_corner *fuse, *prev_fuse;
 	int ret;
@@ -280,8 +280,9 @@ int cpr_calculate_scaling(struct device *dev,
 	}
 
 	freq_diff = fuse->max_freq - prev_fuse->max_freq;
-	freq_diff /= 1000000; /* Convert to MHz */
-	scaling = 1000 * quot_diff / freq_diff;
+	freq_diff = div_u64(freq_diff, 1000000); /* Convert to MHz */
+	scaling = 1000 * quot_diff;
+	do_div(scaling, freq_diff);
 	return min(scaling, fdata->max_quot_scale);
 }
 EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
@@ -289,7 +290,7 @@ EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
 int cpr_interpolate(const struct corner *corner, int step_volt,
 		    const struct fuse_corner_data *fdata)
 {
-	unsigned long f_high, f_low, f_diff;
+	u64 f_high, f_low, f_diff;
 	int uV_high, uV_low, uV;
 	u64 temp, temp_limit;
 	const struct fuse_corner *fuse, *prev_fuse;
diff --git a/drivers/pmdomain/qcom/cpr-common.h b/drivers/pmdomain/qcom/cpr-common.h
index 0aa227617d2f..1b2fa344eb09 100644
--- a/drivers/pmdomain/qcom/cpr-common.h
+++ b/drivers/pmdomain/qcom/cpr-common.h
@@ -42,7 +42,7 @@ struct fuse_corner {
 	int step_quot;
 	const struct reg_sequence *accs;
 	int num_accs;
-	unsigned long max_freq;
+	u64 max_freq;
 	u8 ring_osc_idx;
 };
 
@@ -54,13 +54,13 @@ struct corner {
 	int quot_adjust;
 	u32 save_ctl;
 	u32 save_irq;
-	unsigned long freq;
+	u64 freq;
 	struct fuse_corner *fuse_corner;
 };
 
 struct corner_data {
 	unsigned int fuse_corner;
-	unsigned long freq;
+	u64 freq;
 };
 
 struct acc_desc {
@@ -92,8 +92,7 @@ int cpr_populate_fuse_common(struct device *dev,
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
 u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev);
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
 			  const struct fuse_corner_data *fdata,
diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index 5c83f0c26b29..b2e6e6eaae73 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -826,8 +826,8 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	struct corner_data *cdata;
 	const struct fuse_corner_data *fdata;
 	bool apply_scaling;
-	unsigned long freq_diff, freq_diff_mhz;
-	unsigned long freq;
+	unsigned long freq_diff_mhz;
+	u64 freq, freq_diff;
 	int step_volt = regulator_get_linear_step(drv->vdd_apc);
 	struct dev_pm_opp *opp;
 
@@ -866,7 +866,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		cdata[level - 1].freq = freq;
 
 		fuse = &drv->fuse_corners[fnum];
-		dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
+		dev_dbg(drv->dev, "freq: %llu level: %u fuse level: %u\n",
 			freq, dev_pm_opp_get_level(opp) - 1, fnum);
 		if (freq > fuse->max_freq)
 			fuse->max_freq = freq;
@@ -940,7 +940,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 
 		if (apply_scaling) {
 			freq_diff = fuse->max_freq - corner->freq;
-			freq_diff_mhz = freq_diff / 1000000;
+			freq_diff_mhz = (u32)div_u64(freq_diff, 1000000);
 			corner->quot_adjust = scaling * freq_diff_mhz / 1000;
 
 			corner->uV = cpr_interpolate(corner, step_volt, fdata);

-- 
2.45.2


