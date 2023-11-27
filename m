Return-Path: <linux-pm+bounces-285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A37FA491
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FC8B212EA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13932C61;
	Mon, 27 Nov 2023 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CD4a6Tif"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8EB192
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso6628526e87.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098947; x=1701703747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=CD4a6TifEvRyGn/Jv2KZFFdl+HnXBjxcdoC6qjQCwFbSCdC9+Irtn2UhzUPwKNqRza
         W+ovEizHTZW09RLOQmHlSo7xZXUc0zum98mg9QsuhHbkgS96kCkWGj6hidonngUKMnh6
         xwdjuzjVRkfD1IcQyi7hGUl4C1opKrDKLZ2euQwbU4Z6kgnmpK3/1W017sZW1z0wRTnL
         hl47d0H7E0uaV/hGFkSpZtIo4NUPp7gcR4ohTce5Qn0JegnXvsa+oJDXwL3OTYi7ecOh
         +hkDrBXIgDVx63VV/C1Z/IwZcGWodmF/8Dpb0WXZHv9O4prBBn7MoicPfCMlUbH7DyD3
         WmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098947; x=1701703747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=byT4tbePX5C0dQ2EQaJuDv934WHoOTIa29aeAyyjlby2U80Gg8pZJKn7hq6HPbUjGA
         IQn3YlqJvfCjmvFsus7nCXXVtkjTUz4pCmYa2aMKqADR1VGP3VP9kOyr///BriMZW9kH
         Fr8oRLxmpT0g8DqUv8SQ1bj2etHr75VVbXbn2U6OsImnKuhnp8wI4lEJLBCEqlf/xWQ0
         89hAlh5qyQxCbpR85uiGB5i5iPm+0NeODKDbuwRzarDy54TN7M1n1QIP2ALo0+xtlaZX
         1XETAqtn+HbtHDcqRCI7Csk+1+leDmIb3OpHhzYnvCHMdwDie5p7htJv9Z32XrR1kwVZ
         LPtg==
X-Gm-Message-State: AOJu0YxqCK5cmg8MzRicP5Dtn2ME9Yc5UpsCK1OJFTUteoHH7sOv28+Z
	/aG2SoSW4nBir27mYwE9IFrsgw==
X-Google-Smtp-Source: AGHT+IHfuCB/u5iuBzcXxxczmnBsCFIJiK0WEL6nD72DL5ef/WUsiecbpfHVhsXn1JxOeqjD5DGehA==
X-Received: by 2002:ac2:43cb:0:b0:50b:ad16:bca0 with SMTP id u11-20020ac243cb000000b0050bad16bca0mr3545964lfl.40.1701098947808;
        Mon, 27 Nov 2023 07:29:07 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:07 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:45 +0100
Subject: [PATCH v2 05/12] iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-5-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=876;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G/TOscakzMl5L7lLg+f1aIz+xjyCycciuqgvdkeUR9s=;
 b=VIz+Y9084yjDi3/47tMxdkTC2e177oM5XcQ6dTdEpAKxC7RNhwq2iZQcKfXPJV4yp7X01NvAb
 VckWTM1fxXjDzEfWhm9T0ZWjcXcDhTcG2S1DXVj6948Sceq8Wj0LnzX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the QCM2290 DPU compatible to clients compatible list, as it also
needs the workarounds.

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


