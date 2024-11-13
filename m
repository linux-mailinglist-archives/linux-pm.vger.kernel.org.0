Return-Path: <linux-pm+bounces-17507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085559C77CF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFCA1F222C7
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB433201249;
	Wed, 13 Nov 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8MFZpFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66298200C82
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512930; cv=none; b=g1FxGWRZZJKCvAUKqpPuoYhqyHPIfez5Mpatr5Dq4K+/6GI2cJT/8o9iZR5jCNyTpCPaaLLYnaMiX2Ez0eOEDnJDH/ldHqW2JqQkxy3MLq0Z7fBkSYVa8naPt8OB2zLbXV79N0J0FBu62FHo//8eUKbMZsJDt5l+lkA+vZxL1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512930; c=relaxed/simple;
	bh=xTy0814t50k26n3IdWEnCW6RpXe9FNt3pkGR9JMo8Wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvoFxJSCBnagOdqekY8b3UcxdpTd+F3GIWTduIEtPqkdJMC9CgZpcRNhPKGunJDQZyMEhiTNuNLeYk4jgQxRe5tw7J6nTlxyOqGOkGzU0XZ4atI4D/1/boqJH261h/lLxDWfhZrXjq9hwpqtefA2qA4wryO4EkX3bqDoOQJSK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8MFZpFY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so60559335e9.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731512926; x=1732117726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QLp1s6RunFlEIPDGsvb0lHzi+DB0IAKSMWyP0xL4Qc=;
        b=D8MFZpFYr8Uvccs3OkpIsaXeFgtxAlk4fGbvb8MJG/7WqF/zuiY5Rp1SUK/6PKFKkI
         UjBgX9dlFQO5j9b31qCcATD1M3r66BdJRoazwA1o9lb1OeHr99NfIs9Slnz4U/XTh6uE
         cA8AtiY9sYaqgA7xRSXwVEbEepCjTvte3B9RPJsn/xkN4wjkbKbfASCSer24V5n3bs2I
         1rh/tXZnqzGQPwArn5tBXAJUFh1/efGE4jWisCM7DP08dbwNd4UNMhTIZ45mD055zBWC
         2C7a2P45qme9ELD4A5L59JxemKBj/mrEkoom5WhsIMjoXsuyCEi9wtucbs3IucdyXgv3
         QO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512926; x=1732117726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QLp1s6RunFlEIPDGsvb0lHzi+DB0IAKSMWyP0xL4Qc=;
        b=ogPQ8TKT7zXpKQqpEsaq91lMreYOG0Atmqia6rDU5oOqmRVaGus6SoxzbF0+HC7TSv
         cLelnDmf0ObkB3s/yRJ8qhG+r6TW1xIWMnPWosNMOvC/ZcnHRh/gMGEt8IsUITc9Zny7
         T98nMi/QcPQRmmq/SkEm2pBBq8Jl2/T4BoLU4LgE2c/OV0RfdfdaXIGHKh36iXxgJ+nf
         WcDsMSqGZ9cGPqNzrucGYf/ppBVNTrWZ7QYtMi9O8DVkjdpS/+DXWrjo2o0Fr8xIrGa0
         qXMxwZMv6aWJt7XXmHCN//Md7vNhxDaOCabfmmHCa/lU3AlCI7YCXkCE8oK4fJv/yXfE
         cwRg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlG5v447Z9x4pI/X1rURVe4qIBtrUDkuwFk9a5AGJcldoEpHPKflqr7kJfwyBeIvOldDzRmt8Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXiXIzvPBbBGXY/R2tPfKWcY6RAUEILEDgfS1VHPUZT7yMQJXB
	9DX3ukHSNCDtJikzKQiT8/h7BcKOkdjfjLtF+e6wRAdBOkEIAoAuch7af95YiVQ=
X-Google-Smtp-Source: AGHT+IHhsJ5vHXywCMjF85D0QDjPH1adB7FRz0zTJs0n2OMOmH517AP2qB1RCaElCXb/vLCQ/ACOcQ==
X-Received: by 2002:a05:600c:4f88:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-432b7518dcbmr164295975e9.21.1731512925721;
        Wed, 13 Nov 2024 07:48:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f772asm28445345e9.18.2024.11.13.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:48:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 13 Nov 2024 16:48:33 +0100
Subject: [PATCH RFC 7/8] arm64: qcom: dts: sm8550: add interconnect and
 opp-peak-kBps for GPU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-topic-sm8x50-gpu-bw-vote-v1-7-3b8d39737a9b@linaro.org>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xTy0814t50k26n3IdWEnCW6RpXe9FNt3pkGR9JMo8Wo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnNMpTUkjA+wwux/4I7KQrmdXKIWToek9n3/xCqvqa
 drjlifKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzTKUwAKCRB33NvayMhJ0dPpD/
 4tNTq3Jga253HLV0W9pD5OuDlR8t8KvIXXyV17X+2j4V8DHNENp9TR9TdAhfUJuQnj/9y0D2zSyXAP
 gkrIds2ZigtWraGgAGb4eX9X6iegJnW8v4DapwoYwc5FUB6KjZ9jnut+oV3dEFftAr5/Pmwg+aOpsi
 u34PZ/fxNGtvOdIguu0lHD4gesyBfyncZoyIGBIoLP6Slwu2gMwOt92vErrlYtgW9Xw41qoMcr1LiM
 AvwPgzRab2E7N0VMXaViFkojH8vhz7PplQW8WmQ6zlv0pbcIe0NSvGlTQ6njZJTMy0ymCFcqk5XH7f
 2TDhWwpf4imPdYhj5QDu7DWbBIX09OI9YZHLFUp2O/uhLTvPIVIVM8rYwPgj9QrRr3HE733+X4Fw4r
 BAHhTpoNQ5DF+49m9mB/+c/gXPCmfeR/qscl4gsns3FIUF13IRTlyzECehCEFaFLzc/d2qlSjwgRNJ
 XMaeVevwuOfyI7/LcWtzTgexvvUEKjXWygVw3Rh3ARcGjrIfGvhBUbvyHJ+20YHFpV4lcV29WFF8cr
 h3uClG6c2biDO/R/CZKW1jAr0Ru2y/hANIEYphScZeKygVmQQaVcNotxMcB9eNB4S3GBMKVFQY7zIM
 6Zk6cW1OBVMJpRnj8sF2uJxqY5b9+ucb2KhJXFjzQ4XK4g830Z8yzK+p9zVw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Each GPU OPP requires a specific peak DDR bandwidth, let's add
those to each OPP and also the related interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9dc0ee3eb98f8711e01934e47331b99e3bb73682..808dce3a624197d38222f53fffa280e63088c1c1 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2113,6 +2113,9 @@ gpu: gpu@3d00000 {
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
 
+			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "gfx-mem";
+
 			status = "disabled";
 
 			zap-shader {
@@ -2126,41 +2129,49 @@ gpu_opp_table: opp-table {
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-615000000 {
 					opp-hz = /bits/ 64 <615000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-550000000 {
 					opp-hz = /bits/ 64 <550000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-475000000 {
 					opp-hz = /bits/ 64 <475000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-401000000 {
 					opp-hz = /bits/ 64 <401000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <6671875>;
 				};
 
 				opp-348000000 {
 					opp-hz = /bits/ 64 <348000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-295000000 {
 					opp-hz = /bits/ 64 <295000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-220000000 {
 					opp-hz = /bits/ 64 <220000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <6074218>;
 				};
 			};
 		};

-- 
2.34.1


