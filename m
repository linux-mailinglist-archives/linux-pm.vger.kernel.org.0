Return-Path: <linux-pm+bounces-10766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB792A29F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE231F215D6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DEA13AA42;
	Mon,  8 Jul 2024 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExEiBYs5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D4136E2C
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441394; cv=none; b=ZQdgL9IxnNsgoZ5klU7Dg7Amn3L73op5JBmtE24wIE4Le+iFdbQziHZ4uSNoDIBE7uDbF0/0u8hi7HaLayLGhjbl7jPh5mXfy+niRbMF5r9h6PzPCDZ2jH1CkjUhnLfakwWMbz+eVFgbB/XnlJi4A08PkM+X63YgY4pYMbz2BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441394; c=relaxed/simple;
	bh=lFhFm8XkOz5Bskd3D5+xaH3dSN5OhtVheagJNvAQMPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juhtVbQ4Hsyyw/CuA4Z/IqVJK+aMySFHRNHROy8928DV6Gp2zP7hJdjdC0dl+rnNFWB4Wh/+5b4vU/PvSSwn1tKYpnY316sAY9ZsViD2k68XGdXz8oSuUF+wFkf6FnyHADFVnjWgxq/Xy8vLfcAnDSyDFHkaqwdEDrdjELIKwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ExEiBYs5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c9d3e593so311413066b.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441390; x=1721046190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1uTwXH469EZcpo+8MN3uCbZzqBdHjB+YY0ngrC8PfI=;
        b=ExEiBYs5gOA+1F78aNQih8+kOiJjznrm29dTDmYneXcDG/QGJbhexi2eEumI+vn447
         o6cWOBn9O2vXgTLrgp5NGCaeimlPnK21hatWSZaB/5RpbgGNwq3vyBstLTTJGqgbD/1G
         Zti9YIeM1E/IXNETxKu88ha+zU63mt0Pq/V+yj+UjW+BCqc7FRte9qDLlsnsOh24fmKm
         lg7lt5aPad/siS44zja0JaUdjp0FBBdEcLgsx7Q4uonW67/Liie4qWbl9SX5pye1Fe6c
         ZiYzCZXDLTueC0pZA1U1curYXti1AgdubAPm7O4G56eqo5oR25dUIvYWLzafguC++83N
         5PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441390; x=1721046190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1uTwXH469EZcpo+8MN3uCbZzqBdHjB+YY0ngrC8PfI=;
        b=SCu4kK01kZoVR1MrC1qj7UXxM6FqCJlYHwMtucDTqZDIk0oxguQVqlVA65q2lkyTzc
         kD7ckjvIcUgMdS0guT6tHPBLWb5oCkcqbYgxPRL/vWwwYpGsIKlMhlOlGgpUOBoavMWd
         JnwQXZ9yAb+aFHGBSIrwbh1czEDI3rR+czjxr06ACtcitYq+JFY/fwJ+d0Js1psyBusX
         7DWocKp3Q+O/74GETZaU39lkOk8E09TIS67ldSOzIYW5Y/YcZxi6S/9h5JmYhEefp0IF
         UluVzoKynCkBByJMgiucOPvYfGSKEmqQIlVJvQBoZtJmlR3rO3fQP37MoJHXwFrx1zYK
         61bg==
X-Forwarded-Encrypted: i=1; AJvYcCV+mUMeMwrs1y1p7+AGy5wzdFB71xRFsLffRztDrAF0PmA9OwFqY058ZEL5fZKzJAYLn0SVi2UJZCq6tBNEhYtarCltRbAiL+8=
X-Gm-Message-State: AOJu0YwYbj9U12b6ubLyJw7E88Tgsgmi4ApMEKmiY5/5EQCNwOZ4GXfF
	zIt1xDB7cUh0SaujNvgxpdI7S+pCETrgQzkNKxHIDjo4Th6Yg0cIlA/kILLvga4=
X-Google-Smtp-Source: AGHT+IEzrIE8nTDCnmlFyNmQLCQDmburyEgzq+VfZPoE2qFHfdKrbEcZLGwxoqFHstrY2KSjFmvBDg==
X-Received: by 2002:a17:907:7212:b0:a77:cf9d:f498 with SMTP id a640c23a62f3a-a77cf9df683mr672501166b.40.1720441390300;
        Mon, 08 Jul 2024 05:23:10 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:23:10 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:37 +0200
Subject: [PATCH v15 06/10] soc: qcom: cpr-common: Add support for flat fuse
 adjustment
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-6-5bc8b8936489@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=2082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FEkMInUlFGjcpdQZXJiXJbXnI1fSzwAHTqwD5lohyQc=;
 b=NK+iXcizWrvtLUoUHu/vS0S0kTwc1u4mGLBKv+flCXlPGC3SJ5V91qAvPd1I7NOa5WZEltNRB
 zQe4a73aENsAHL/qm2+6U71S9C0Oqb7IKxclklhO20xqMzrg8/TpLad
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

CPR3 makes use of post-calculation flat value adjustments. Add the
necessary bits to the common functions to support it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pmdomain/qcom/cpr-common.c | 9 ++++++---
 drivers/pmdomain/qcom/cpr-common.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr-common.c b/drivers/pmdomain/qcom/cpr-common.c
index ea85f6b4bef8..44c681bbbf13 100644
--- a/drivers/pmdomain/qcom/cpr-common.c
+++ b/drivers/pmdomain/qcom/cpr-common.c
@@ -49,7 +49,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
 
 static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
-			    int step_volt, const char *init_v_efuse,
+			    int adj, int step_volt, const char *init_v_efuse,
 			    struct device *dev)
 {
 	int steps, uV;
@@ -67,6 +67,9 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 
 	uV = ref_uV + steps * step_size_uV;
 
+	/* Apply open-loop fixed adjustments to fused values */
+	uV += adj;
+
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
@@ -119,8 +122,8 @@ int cpr_populate_fuse_common(struct device *dev,
 
 	/* Populate uV */
 	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
-			      fdata->ref_uV, step_volt,
-			      cpr_fuse->init_voltage, dev);
+			      fdata->ref_uV, fdata->volt_oloop_adjust,
+			      step_volt, cpr_fuse->init_voltage, dev);
 	if (uV < 0)
 		return uV;
 
diff --git a/drivers/pmdomain/qcom/cpr-common.h b/drivers/pmdomain/qcom/cpr-common.h
index 1f2ebf9394cf..0aa227617d2f 100644
--- a/drivers/pmdomain/qcom/cpr-common.h
+++ b/drivers/pmdomain/qcom/cpr-common.h
@@ -22,6 +22,7 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
 	/* fuse quot */

-- 
2.45.2


