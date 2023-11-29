Return-Path: <linux-pm+bounces-496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A07FD9EE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D91A282481
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139DC32185;
	Wed, 29 Nov 2023 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNw6hCbM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE40D67
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a0029289b1bso935393766b.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269058; x=1701873858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhPk3gIHMkcRIIJu/Q2shfUhw94w8SwgcuUapNUkT6Q=;
        b=jNw6hCbMo7j8pPJEpXruQdZQaHZYFY7MQguBXH978sX0H+kN6Y7JbSmN5b/i/Hl3hZ
         aWdZxo7Z8KwGay2yvgjFxfD8gIufntT9pNlxixbn2NotPZIs2Zsoi32NFST1g740wkFU
         ACtGJjcoV3GKXba4qiDsoExH1zOMBtlDVoEE/vmQvFxdgkyPG34QHQL9T3Xjt8bJQJz1
         G1nBHcxMY17BLvE78u8WgzTiqGVTElaTcJNpmhynahpqnTxf2CUZ2XPzsLxOsJcL9oYl
         bl/QoqySxYcimXZpLsxpwzrfOOu90iv6rCQ3/DFtzAmzM57aftZbhLghajj7Db6sA0Px
         v1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269058; x=1701873858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhPk3gIHMkcRIIJu/Q2shfUhw94w8SwgcuUapNUkT6Q=;
        b=IxbN3DL/o3SScHdo+B9RT5ZpY1bg0HvD3nESV1iba+TZhamBAzhrOKNSkshrLj5HYW
         7YbMvXe0fRSxO9RbHygtbeCfu62jYnQdAKgzm2huY2JKz/UqhmnLlrIITlq9n2SUGLb6
         upd2ovyRExFSRe8VLSimXwFzbXTWjnMhLUXaQ3H7er0GgHPUkEMaXVwffNLJruinowO9
         Qe0ZQ5Ty4Peazg5F1AIj2R8rbHHoUpvmqvqHsIA8NGBcQKdukXySCF4QK+TMjLnqdd+/
         HZkkVWACE9lqoTtj5VIFJqyL2T8uRGMBxfmjV572dwaWysEDrDQdLWiYyY4dj/476ydt
         OAow==
X-Gm-Message-State: AOJu0Yxw6tlACINQ9KSQOWJWwIJuT4Fl0QffRMcNPfQJFzxQ4gR3FIXn
	skJV3D+SNt1GHYlT4lr5Q/3Aog==
X-Google-Smtp-Source: AGHT+IELUKZHQLPVXvrqWTCWTWyQ1q5ziCaTJA9OZKmwCNLvITVZ5WvOUuMIs3bTAJCDlyB/ZXSxCA==
X-Received: by 2002:a17:906:e0d3:b0:9fd:3ba:ddcb with SMTP id gl19-20020a170906e0d300b009fd03baddcbmr13503603ejb.29.1701269058026;
        Wed, 29 Nov 2023 06:44:18 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:17 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:00 +0100
Subject: [PATCH v3 03/12] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Add QCM2290 bwmon instance
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-3-4cbb567743bb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=959;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1AOnfLSu9gHpTFJJhxoEDrJmbQSA5ACPtQkIorVkBaU=;
 b=Bttpjh5YDu8RJ2oiG0axvEhFefhRGDd512/Kb/Ls46aYSNJYNXnDWH6qSWS8RcmRTRCivj3fj
 7wcKLyJ1Ot8Bx4Wi3/Cp5wx9Q0m0AaDIIXjigS8cH3/dBs+PrrTzSLx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

QCM2290 has a single BWMONv4 intance for CPU. Document it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 7cb8df757477..a88cea732370 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,6 +25,7 @@ properties:
       - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
+              - qcom,qcm2290-cpu-bwmon
               - qcom,sc7180-cpu-bwmon
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon

-- 
2.43.0


