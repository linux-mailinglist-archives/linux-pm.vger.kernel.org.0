Return-Path: <linux-pm+bounces-280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCD7FA471
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA841C209BB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4021328A2;
	Mon, 27 Nov 2023 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkZ5mNs7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F37DB
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:28:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so5860575a12.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098929; x=1701703729; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xH7djIzH2lWtg+ZnnlMA49TMMB9EdHS+GmuOJoHr84A=;
        b=bkZ5mNs7EAGBC/S7WQcK4r4pVQdnMx7B6d6EtMz0b4PT5olluw92VDN/PlM/bs3UG9
         BRhgitjtwFQDuNpsiHiU8FaGfAEHZg7BblU4DSXzl8vDMdZ6DAVnjGgtANKOfOh/nKxs
         cQ7diXgD1B7B9ADAcYWqGL0KcHY2zvyoGuoe7Kt5BmK1N0kqWGL+qEb/XbMAwlQt9br7
         hbfgWENbJzI5XTcmgzFj+J0eFZLe81GzXAJUroR8N+GrYOjy+IKPhmRe8gl3U40l1Msp
         aby63YYneytRAtD1XFUEWKWTD2V6c17oNA2j2DMfDfglNsFTadBpglD7lNQaA/H/B5/w
         7+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098929; x=1701703729;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xH7djIzH2lWtg+ZnnlMA49TMMB9EdHS+GmuOJoHr84A=;
        b=sGaS9Z9Nv2zMGvg8ACaw8Gt3L3KWzOcDRQMB6xXFFBliqIrn5DV7kMc18UCagFLhYO
         8I3eMMbMbnZkHFtryurHD7DBPDgXm/woLS39mfsvg+6bJ0zsDTudMRBWoVSPtHxP+fCw
         jJQlemqsdyoRKsCQ50NRV/07FIo2StXHPEcdPvsZl7gJZHdm+5lnvTNOUFoQzDHnL7Ph
         frH0gFtEQ8KtvPtJWSnDFK+X4HzsgKSyqpcgC0Bnk+UV49pyE3mJfyeVj/JIF3HDTF5B
         +a0hQeYCBHfiohYCs6sh8L8jTPBul/vPAMmsC4D/AddWAuiiWx9fskYHw4vL1t97Lh9E
         RYQw==
X-Gm-Message-State: AOJu0YwsclWBj30CoFAGYADP82riMAZLU4Ybw1QKHWr3MpPGsJ+Fh4Rk
	XjPQylRm4Eb0wVJwrQzruhL5HA==
X-Google-Smtp-Source: AGHT+IFVq8VVBBAB+9CYcFJYQtXvol9+Oolg8Bycg8P4iRm8ZI2RLM5GY7iy8CP/g/zrCxgD8BoRag==
X-Received: by 2002:aa7:c401:0:b0:54b:3bba:8372 with SMTP id j1-20020aa7c401000000b0054b3bba8372mr5619318edq.5.1701098929327;
        Mon, 27 Nov 2023 07:28:49 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:28:48 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/12] RB1/QCM2290 features
Date: Mon, 27 Nov 2023 16:28:40 +0100
Message-Id: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKm1ZGUC/3WNQQqDMBBFryJZNyUzkrZ01XuIlMSMOiCJTKy0i
 Hdv6r7L9+D/t6lMwpTVvdqU0MqZUyyAp0p1o4sDaQ6FFRqsAdDqJc3cafHw7MktOgQLxtZ4QfC
 qjLzLpL242I1lFl/TVOQs1PP7qDRt4ZHzkuRzRFf42b//K2ijAcIVPKA39vaYODpJ5ySDavd9/
 wI0+5IFwgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=2755;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yZgEzYKRpKaQPQoGOfb7ONUfzFPf2ls77sgBQdDr3ME=;
 b=V5UwjbXyluYT3sCqyhvxMPLK7n4ewU5ni508NwKZPVwcvivC25/OkbkbE+ilYnCDD3fCiiOod
 mruf6Ot8p8aBmYMfhBp209eYwgjnXewqW2wsmN8WL5VleHqw0qEtTZV
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
      iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
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
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231125-topic-rb1_feat-dd510532621b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


