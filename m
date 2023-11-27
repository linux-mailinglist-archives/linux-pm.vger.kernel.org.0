Return-Path: <linux-pm+bounces-284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DAC7FA48B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B372A1C20CC4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130B328BC;
	Mon, 27 Nov 2023 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjKz4i9J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4F183
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so5861124a12.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098944; x=1701703744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsjff4lo1TEsrq1gFW/fhWlByzdhetZPF5yWDTWUZEA=;
        b=MjKz4i9JEnsvpFh9NJbh6ao518pGLidS+riiMljmapXlIwc7jS7grGtgYOHWQJkfSw
         guCJlFjnd70xio2crIB3s+a536rpt6HzisaAIX3BSzROg93WhSULXqnx9aPxwVfcVdIH
         wMGSKhpTVST14FPmE33QU0mCM/J1+4ELP3PXgyVCBPeLI5yXOo8S1JnQz7Q2m22yXSVE
         dn0236y/E5S/OQJ9gLc/d0OW40q4G20w0qtyY+kNyVwEWZR+/Ll49eApOBfN44kf7Z0y
         ElP/3ZG6Ih5e/+b5DI1sXGTJOI8z7fvPDfX7v/W16VkeWzbY1Pcc2jt3X11Kxl+T01mt
         /gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098944; x=1701703744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsjff4lo1TEsrq1gFW/fhWlByzdhetZPF5yWDTWUZEA=;
        b=pzyYKVAjSqUhIcJtmFBBt7YWJdpdTrgAHYYsZSkBQ6XkxozfvIASFa3+8jnN4LKL+5
         IPhyKDnRG6cau4mrfQf4VJgqeIbExBMcUqXH77GctS7oz4QVbEdfCLThugYzCSw+dgcd
         Vhc3tbs4iNiDlUVry7SFk3fJ3WjdnsJqXbyCBwYZXFvZvNOgcyTtTOCF8qOfcnT+7h+l
         0F82In3x6cnQ+uGG+OTZIqzstmwUI648WOS9s7kGhSp2u4xLfgCK7lgNfz37rb9zVhxJ
         TnpnJ6UgicV1fXphR/FMEx+MJBsy7zstlSo/5KCF6CWJdKektoTo4/1MR/3nXmC1oJuu
         CnCg==
X-Gm-Message-State: AOJu0YzkSv595T8uo0fcGbplCbPHFZcUcK8eA+1bT1XUWRb024xgFiPK
	GNgblNRv1XWviPdXubkM0k13vA==
X-Google-Smtp-Source: AGHT+IFOyIrlG3K4TKUYS2ME/41gHY9uKSnDmZkZO/xmnu/DRtbRQqQLfmFgD0DWgrRTWqt07Bphiw==
X-Received: by 2002:a05:6402:b08:b0:54b:35f1:905 with SMTP id bm8-20020a0564020b0800b0054b35f10905mr5607319edb.3.1701098944044;
        Mon, 27 Nov 2023 07:29:04 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:03 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:44 +0100
Subject: [PATCH v2 04/12] dt-bindings: firmware: qcom,scm: Allow
 interconnect for everyone
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-4-979b28f35e4a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1156;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ATWzTDawV1rfiW1Rmh2AEVyFtBtlEoO5VeMvQ1CdaLU=;
 b=d2uxm8koLiSmmdjKdjpShjLXryrZ+gjNkqEkIxKGxUdhaPhhQ69YN5mCvINv/crH2NFSPaxwY
 vbIbYzQoWl8CAPM339TI9Ayh67M741P51t4zrDzpIG103JKmvS20sDA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Every Qualcomm SoC physically has a "CRYPTO0<->DDR" interconnect lane.
Allow this property to be present, no matter the SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 0613a37a851a..f3a87a8426d0 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -178,21 +178,6 @@ allOf:
           minItems: 3
           maxItems: 3
 
-  # Interconnects
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,scm-qdu1000
-                - qcom,scm-sc8280xp
-                - qcom,scm-sm8450
-                - qcom,scm-sm8550
-    then:
-      properties:
-        interconnects: false
-
   # Interrupts
   - if:
       not:

-- 
2.43.0


