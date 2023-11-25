Return-Path: <linux-pm+bounces-219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0CF7F8B6A
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 15:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6ADB211AA
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BBA18041;
	Sat, 25 Nov 2023 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcLUpqji"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2DB10D8
	for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 06:17:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ffef4b2741so376403166b.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921877; x=1701526677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWCPgxbV31hYh8dy6WyfWoyvdSmmu8EadahKhw6DkWw=;
        b=qcLUpqjiwzHK5tC+KD+KtHDgUJB5RTkKQPP4XhaNtPXiIcjb7JzabYxYqicZ5HiNLb
         NhRMp2euNEbewi+QDtjIsNvoAwbAsaJCYLKIAIe39dWa27HDYKMhIDAiYoUoyEudI5Tg
         e5FxcJE3u+s2+RTQW1KIJGUzZVPaajp7X9yczcPrFDZOWHBNeqicLtyD6HgPYNkdjz92
         +P7DBicLgpAfqdADC1m1wMVmCFhKWDfDGs+j1M4FBxMEpnmZ38oyvSmIMmlEGnuaHkW+
         8a2OPzoyAyVLHGDiKeCCFEqt9v94hQnlp3bDZqJgT6Z4f4msJcWA/5KbQFx1SfdvDBJ/
         1k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921877; x=1701526677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWCPgxbV31hYh8dy6WyfWoyvdSmmu8EadahKhw6DkWw=;
        b=Sy/pfQ2Be2uMxxLoZpBe5eXFm9oj4dZnJ7LW7kbvHflAT8Ll8kCSG3iTRBZGn58LmI
         pftk7g2G5X/uePJb0Hl1cyl6L6lN37mB2dP8HimN4N5SLohXtTNW2kRfpBDlZR49YFCo
         2NJmXTWeyqLBd+5YOaY7Ez6q4VVQoIOF1Jz24rfSxkA8/VCY36/3X/GpBxBQBKnWfWWT
         U5C+dm04iDmBGJswi3VbV73PM8CPaciXMSsg6oge0nt0kWX05ghKqBrInezA9je3Xr5h
         6lceI84durarftv7x6oPb+P3gy/PhMzuAtwc/rvoNR7OcX7qXzVmyAuAwFIkapNyqaAD
         1KEA==
X-Gm-Message-State: AOJu0YwFMOU3zvYb5tFmcmMO+nbc1mRj93DoDqo/XOEU9p28xCtMe1e/
	hW8UROXCrruuK776vE6zGAzDvQ==
X-Google-Smtp-Source: AGHT+IHvD1QUH58vfrh+JuFXiAspD6f2yTyYe0BNJ9QJi9uFvF8FzZqrsK628r6rcj/cdkeKg5L5Ow==
X-Received: by 2002:a17:906:608d:b0:9d2:20ee:b18b with SMTP id t13-20020a170906608d00b009d220eeb18bmr4065922ejj.42.1700921877219;
        Sat, 25 Nov 2023 06:17:57 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 25 Nov 2023 15:17:33 +0100
Subject: [PATCH 05/12] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 QCM2290 bwmon instance
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-5-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
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
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=892;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4p1t3ladITCzScGHKWRD4AUO04YXuJiZkuRiWJFiujo=;
 b=HgtcxdLyklPczRRLJMxdrlC1sVeNSeCuWIN6F4Xkr9dxy/a75RHP8Tm9mVxVipeW+jkpJiDqG
 jjrxeMEwW5LBwHqcbF7tqgSlw1eWMPkjI1ABsatTSpX8EHUOrDEKyaC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

QCM2290 has a single BWMONv4 intance for CPU. Document it.

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


