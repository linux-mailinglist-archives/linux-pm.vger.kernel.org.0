Return-Path: <linux-pm+bounces-494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B67FD9E6
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0B2833E9
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FB30340;
	Wed, 29 Nov 2023 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+qfJj84"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA6AD5D
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9e1021dbd28so919941666b.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269046; x=1701873846; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylEU11Sj8y9lW/5egLuUmSM5125mWJnuLEGjsRPUTJo=;
        b=b+qfJj84HFi7KHGXbY3991wdSxUu3uDJhe1WyG2L4NNpl+Fpw/Kn4jQozhnz8KtEKc
         FL1rx8JzUxBZbkwysF43TPwnqjoR4Gpr2S7k/xGaJeV9T12HV3DiFH+bj+90SRQYZXvv
         MzueIJU21Fp8yOQnhUaSZDjFOUA5bBfW77mOMuDEHSP5WfFRwA3G2lTMe1mcgCpJy4ht
         C/MnsF8MQEO5vso310JmIaC1/vO9AGJi7FWlfuFq7+kcbMJRyHHZWZkb47MkZ4026YYI
         Z6uELtX5EipXKHseAPzvbShK05SJLnq0xUbyJDKus9kbgje+YyLd5stfMAdvtp7r1v+V
         lnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269046; x=1701873846;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylEU11Sj8y9lW/5egLuUmSM5125mWJnuLEGjsRPUTJo=;
        b=Gqi6WHDgzXk/cETR5e5vWogBZPqVD99x73EplPkPDud+H+GQzEZVE6egDOQU+h5QYi
         2n3Yp4aC8oq2nf6jAYc+SBXwbpcuXC3nJzJMmIoAvvsrS7Q4pt/AGrpae520bpSNMyzP
         3L2MhnK32a2mqfQQH4zXsiL9Gwa65cEehsUIR4vQPRBunTlk5a7zGmvy1cWeZPjD6BnW
         0oc5+xM7dhWFjWmTipSWrN7IJh/wKkHB2gEIPf685Lv6AG45P1kbRvyPP5/qOcHTr6H8
         ay6Rg/N8YK0tXaomZ7m+CY9dYm/Z+4/TT0/P0yvFgkDajrK4K/Ukk52fFOcIaZkMzaGl
         D2sg==
X-Gm-Message-State: AOJu0Yw39P+zwGZN01hCc4X42ks2nHx+JIadAKuiOtp7aPWP7TkQkUEP
	rjsNKzKg8Bm84/jA2LBYwW0J4w==
X-Google-Smtp-Source: AGHT+IFEXQX5eb9doRuoINpQIG+Qas2v9OWjMo2x6sJj2S1M6xOCHUkKC0SwNpJFe6cwgq0kONdNQQ==
X-Received: by 2002:a17:907:7289:b0:a04:bcc4:b8d8 with SMTP id dt9-20020a170907728900b00a04bcc4b8d8mr13575442ejc.43.1701269046550;
        Wed, 29 Nov 2023 06:44:06 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:06 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/12] RB1/QCM2290 features
Date: Wed, 29 Nov 2023 15:43:57 +0100
Message-Id: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1OZ2UC/32NwQ6CMBAFf4X0bA27tQKe/A9jTEsXaEJa0mKjI
 fy7hZsHPc5LZt7CIgVLkV2KhQVKNlrvMohDwdpBuZ64NZkZligAUPLZT7blQcOjIzVzYySUUuA
 ZQbMsaRWJ66BcO2TNPccxj1Ogzr72l9s982Dj7MN7P02wrT/7CXjJAUwFGlCXsr6O1qngjz70b
 Gsl/O9j9puq0Vh3QtJJffnrun4AEq4XRAIBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=3004;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=eV260drlUhaV86AtMNOLW5CfSC+ugoXrL0AzM2FTKtc=;
 b=i1CbpYQhpDTPJ5XiYrBQ5xsHRCDu6vxMZQ/OHzcmfaEiDhHV4Sw10Tu/GPRgYbTNufhADMuHR
 PHRNnPX728XB+61s6hLdjib0rJBmAEAX/m1WIwS4EIuhYsxDLg/kDMm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This series brings:
- interconnect plumbing
- display setup

for QCM2290/QRB2210 and

- CAN bus controller
- HDMI display
- wifi fw variant name

for QTI RB1

and the necessary bindings changes

Patch 1-2 is for Dmitry/freedreno
Patch 3 for Georgi/icc
Patch 5 for Will/iommu
the rest are for Bjorn/qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Pick up tags
- Fix commit msg of "iommu/arm-smmu-qcom: Add QCM2290.."
- Add missing sob ("qrb2210-rb1: add wifi variant property")
- Link to v2: https://lore.kernel.org/r/20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org

Changes in v2:
- Fix up the bindings example in "qcm2290-mdss: Use the non-deprecated DSI compat" (krzk)
- Fix up sc7180 & sc7280 DTs as a result of the bindings changes
- Pick up rbs where it makes sense
- Link to v1: https://lore.kernel.org/r/20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org

---
Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb2210-rb1: add wifi variant property

Konrad Dybcio (11):
      dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
      dt-bindings: display: msm: Add reg bus and rotator interconnects
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add QCM2290 bwmon instance
      dt-bindings: firmware: qcom,scm: Allow interconnect for everyone
      iommu/arm-smmu-qcom: Add QCM2290 MDSS compatible
      arm64: dts: qcom: sc7180: Add the missing MDSS icc path
      arm64: dts: qcom: sc7280: Add the missing MDSS icc path
      arm64: dts: qcom: qcm2290: Add display nodes
      arm64: dts: qcom: qcm2290: Hook up interconnects
      arm64: dts: qcom: qrb2210-rb1: Set up HDMI
      arm64: dts: qcom: qrb2210-rb1: Enable CAN bus controller

 .../bindings/display/msm/mdss-common.yaml          |  18 +-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    |  21 +-
 .../bindings/display/msm/qcom,sc7180-mdss.yaml     |  14 +-
 .../bindings/display/msm/qcom,sc7280-mdss.yaml     |  14 +-
 .../bindings/display/msm/qcom,sm6115-mdss.yaml     |  10 +
 .../bindings/display/msm/qcom,sm6125-mdss.yaml     |   8 +-
 .../bindings/display/msm/qcom,sm6350-mdss.yaml     |   8 +-
 .../bindings/display/msm/qcom,sm6375-mdss.yaml     |   8 +-
 .../bindings/display/msm/qcom,sm8450-mdss.yaml     |  13 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |  15 -
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   1 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 462 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           | 109 +++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 16 files changed, 671 insertions(+), 48 deletions(-)
---
base-commit: 1f5c003694fab4b1ba6cbdcc417488b975c088d0
change-id: 20231125-topic-rb1_feat-dd510532621b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


