Return-Path: <linux-pm+bounces-499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295ED7FDA06
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA441C20DAC
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FC321A1;
	Wed, 29 Nov 2023 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E30oDYhM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F578D67
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso10210215e87.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269064; x=1701873864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo1sJJZHw7KBTaKmEN30ScvrIwX30d4f2jOhkPUqxBM=;
        b=E30oDYhMTwfJgxyu8vzz07F+Pfth/PKq7buzGFo8wmOy9eQ5ayRV/a6IjfXOzTasaa
         A8OwZyTwoZ1jthwxAUWxZ+cu4weRiNk/CYNTrzEHXN5SzYQ5CqZKMmA2kIyGvVOf3GMS
         mUT21ZiUBtjgWePPZIN1SSPYgXrDxqFy60wDiVCweIOBKLrEpK/ljILOW4S/XIyjylYR
         PEZ3nMvfl1h71eGz2bRonLG5pbWjiu868OKp6rcizogawgv5swyOy89KmUliJJjHaz6B
         ehv9JOraSnkeGc7iiMWQBxK0Sir0HdbZhYHLFpyjynVEH3BGjgaqRfWrzsyga+awseGZ
         6mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269064; x=1701873864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo1sJJZHw7KBTaKmEN30ScvrIwX30d4f2jOhkPUqxBM=;
        b=gHnDW6nkszE4mZCnyWgSBqkJ0n5VIIXlc2C/gTwBbJPE71+oojg6Dm8ZBvvfKNeaK4
         YVYAlqXMBSEEWgL2wEX6lQtl14a/Rk3PhJS6mEcX3XBrpCSzslR7R5cqek3SjLB06Nhh
         sjLp9mZQZgphBK0wGWDxyFal6CBaQMOYo29xwWv45cycdn5jBp8khzsevPvRQ+qspvQv
         yZzd4AbxEW9RnVdiE/n5aq3kR7yg9EMlMJyUt4PLZ7oOEMIE97nXz1XIJHuBDkbRtNKk
         7vJVySfyAnk1JFohuAu7E6K4hEEE0sBkGmzZeuB428Mpwb7EPjZuV0CVHqhBJR1udJ7K
         TwWg==
X-Gm-Message-State: AOJu0YwW5RnMKaWDxlysj9A3TNvcJg2RnDCHc0lFlSSbgytVuHcfMfiV
	ygLtEmi/tBDC87Lu29JbGfLj7g==
X-Google-Smtp-Source: AGHT+IHIFF7EvttkvKqxTdo7EUCkiD1rO8UjhJ/NykBDp9vXAQKIDUWYvgiQY1lP0nrgP7lsgpW8vw==
X-Received: by 2002:a05:6512:3d94:b0:507:9a66:3577 with SMTP id k20-20020a0565123d9400b005079a663577mr11819960lfv.5.1701269064766;
        Wed, 29 Nov 2023 06:44:24 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:24 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:02 +0100
Subject: [PATCH v3 05/12] iommu/arm-smmu-qcom: Add QCM2290 MDSS compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-5-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=938;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZKnU1eVaZSjTBiyHSPh2Tjy7o0Kv51jXq1kQ7e4q0JU=;
 b=0+UJnE/UFmA357lPZt/AVpOt+TH32uQu3LcDEhl3VCvws5BJst6hotge8OV/5/cQmoLRQIEVm
 h3sFcW4Ar/GDlhsMpOlDPsgg2azmr+u1A/lG/dy/MwcPNnwfEdJT2bg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the QCM2290 MDSS compatible to clients compatible list, as it also
needs the workarounds.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..aea5e85b20ff 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -245,6 +245,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
+	{ .compatible = "qcom,qcm2290-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },
 	{ .compatible = "qcom,sc7280-mdss" },

-- 
2.43.0


