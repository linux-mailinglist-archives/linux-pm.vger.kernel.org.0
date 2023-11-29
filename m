Return-Path: <linux-pm+bounces-495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0437F7FD9EB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A77B2169D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC1232183;
	Wed, 29 Nov 2023 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yg1632co"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19337130
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00ac0101d9so932062966b.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269050; x=1701873850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+pZ3XAdsVueNoWE7iUbXVGwfYWqTolu2H2HJ2DSPkw=;
        b=yg1632coyniA2tIPKhW/qAF/1HeIk89TTbC0/nvIs/YkE3f4FN+5qgghIzStMlcm0a
         re1WG7Q180QzPRBXmWkbEDbUW/oMKd2aibIpDBpYahmMyh/jVkB4ZIR+InwDshG+Fuoq
         37LyZ8EXLqK70WiclOsXxfkIeBonBWn9icbKZFNin2TOCLxbhtRfOeHxQ1dlEZgr7Uzg
         kYGyyhJIdbijZke57nc+kFrvoZZBF+krEotA0zL/m+w0opx+g4RehF0eAEXeXzf0dPE5
         jmNTGw4T/RVxjYJS14cum4Yec9l2GXTb2WcSnRqYhtBqzIdcSJBt1C1Bp27zLPrZeXh9
         18vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269050; x=1701873850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+pZ3XAdsVueNoWE7iUbXVGwfYWqTolu2H2HJ2DSPkw=;
        b=qDYGUFaf5YAgocRpfaJGZr9b3VIz3sIx5U2JMBf3oGi1F8vRJF1jsIlksviXaygNqR
         Libo4Pvir/kNcSO6DQJ9cD76R6De/53AiHDseCmAfvkGQQAiIsnrexvbziSFGEVAOD+U
         RneeWjqqN7Ac8aZcXCoOyV/bw24qZegXsYdirn4GqnSzof4IWysRyP6i0T4gkzZSbXgc
         nSzwBnS1qVwo4PRvjVYGn2s1IkhB8zLFi/g890S5Dg0azIv2opaOHxjgNn+qRtHnfGZk
         TNYz/HmVrUy5YYR89ZmgTcT5TamVmbJdgNl12iQa0/NFZ3Wcq7+oXEZlh3Wz40xJIg3j
         qyDw==
X-Gm-Message-State: AOJu0Yw6x/fze+4sXm7hZp26CFc7Ndl8qpSmfk5Lv5xbWEpjYT2zWdsD
	pwwYd9W+K0kBk+rrDqkKF35WAg==
X-Google-Smtp-Source: AGHT+IFURYRN3Yij4y5ft90nlDPEV1BNLexcpwu9tBs3tNyDBBwPthgG8Q+ABWb8eufV7YLwTjIF0A==
X-Received: by 2002:a17:906:510:b0:9be:30c2:b8ff with SMTP id j16-20020a170906051000b009be30c2b8ffmr12348644eja.61.1701269050628;
        Wed, 29 Nov 2023 06:44:10 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:10 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:43:58 +0100
Subject: [PATCH v3 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-1-4cbb567743bb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=1541;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=l4+kOWFmXlWpi0xa3oCnZKgfHtaUhcfrj2zIVLkYkxw=;
 b=OWgPkJLJLGOOEg/SuBCEfCvzf9y60IwA2WztWt4bBigKVglnHm9CAi7xNYwNozaUtbSvibwxq
 GHrhQZK30uaB89OofoKFMMcdG8oy58DjqfC9DacVEB+qkpCn7d8tK5Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The "qcom,dsi-ctrl-6g-qcm2290" has been deprecated in commit 0c0f65c6dd44
("dt-bindings: msm: dsi-controller-main: Add compatible strings for every
current SoC"), but the example hasn't been updated to reflect that.

Fix that.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 5ad155612b6c..d71a8e09a798 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -56,7 +56,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,dsi-ctrl-6g-qcm2290
+        items:
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object
@@ -136,7 +138,8 @@ examples:
         };
 
         dsi@5e94000 {
-            compatible = "qcom,dsi-ctrl-6g-qcm2290";
+            compatible = "qcom,qcm2290-dsi-ctrl",
+                         "qcom,mdss-dsi-ctrl";
             reg = <0x05e94000 0x400>;
             reg-names = "dsi_ctrl";
 

-- 
2.43.0


