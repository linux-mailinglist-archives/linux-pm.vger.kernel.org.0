Return-Path: <linux-pm+bounces-500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84C7FDA0B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6171C2032B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870F32C92;
	Wed, 29 Nov 2023 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtGlSdAv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3812110F4
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so931257966b.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269068; x=1701873868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WME6ubitd3vxaAOMdHVezdwhed8qbighnDEBO169Ec=;
        b=WtGlSdAvYS2KDuvldE8lVt2M9SryXBG3ShZAMXg8gCUJF8BnBIfj/eZlyVnF904vO+
         q/aAYUUsPlbEp4UToSnxM8Xw5WEQMAl5vsh+T9VKFAxTaxLZm2TWq6VvdEVGT1GdbJrH
         YZ3xbyVcAqc/S6QNuJL3HO1AOJxL8/2nP5ZHhbne2adaSoPqcNUr5po06oEad0XC7FGp
         +kWYwW9OgXdZYpsY2BY4At4e4B1XbrDnrWjYXO3s6KVySqb0yucyfxm40Kp75W6o1oTt
         AzezSFS5BCFISbQfpeMDDj4OSEMQN+bEd2Sc4JlY8OLKNJLLd911j6YqJdL4x3auGyLs
         hNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269068; x=1701873868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WME6ubitd3vxaAOMdHVezdwhed8qbighnDEBO169Ec=;
        b=nFKngEvbXbzN1nUrwxcVrJB0XEV+ulP+j9GcHZPs0Ue2kXt1akqyWZiqTf02arokRt
         DJqvhjT0sW2cc/X7keLza/2Ejcvm7Dw8eAbgJ7w8+YrtPr9x1X4n8RzeERVUSEdzaJSb
         RC8b59qMl8rdZEXQzGTobHXiT1h4b8T1rmgnueHITccPmNYRuDb0EFzJEhm/gcdZQ5n8
         kvs/4lu8Yz0Bgw1HOz/NK9GAYVgvV/zqeRrIuYKg63rmje/xV9ZORgAnv65d+ITa+rfB
         eNAltnKBJccDhx8VyaGns5MF09F/KLAMGPbPaWKjZtjMK6rXbC6p4MsFo8MpR+LXyCPm
         O2bw==
X-Gm-Message-State: AOJu0Yxe9UQJeyxcngP4YdedhyhQeYICTVtoe3pqWlB3BrQWnNrzisCS
	E3n3hozozr5sZtDiyQHSNdqIYA==
X-Google-Smtp-Source: AGHT+IH+RwsuXNKo7mRRSs5QfH4RQDMAsxgT6mJOUDi04ruodSJZaS3PyYqxW9aAR+nUNX0ZJcUxXA==
X-Received: by 2002:a17:906:fcce:b0:9f8:2b44:7b7f with SMTP id qx14-20020a170906fcce00b009f82b447b7fmr13038742ejb.70.1701269068288;
        Wed, 29 Nov 2023 06:44:28 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:27 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:03 +0100
Subject: [PATCH v3 06/12] arm64: dts: qcom: sc7180: Add the missing MDSS
 icc path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-6-4cbb567743bb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QxbVxThi6gj4JqQP8V9LpJsjR/myuVOnIJbwHX7amYU=;
 b=sYPUfm+T2CO9HyMoVEn+/8/AzljQnlW0jC9XeZnrz01woxrBDGuDswi+m+bEgPSkuiCtZLp8N
 BR3hZTS03LmDYMTViL/cCS/WJooBooB/al2zibrNvM1dONg09omgSvQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

MDSS, aside from the MDP-MEM path, also requires the CPU-DISP_CFG one.
Failing to provide it may result in register accesses failing and that's
never good.

Add the missing path.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 11f353d416b4..9664e42faeb1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3100,8 +3100,12 @@ mdss: display-subsystem@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
-			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "mdp0-mem";
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			iommus = <&apps_smmu 0x800 0x2>;
 

-- 
2.43.0


