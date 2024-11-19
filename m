Return-Path: <linux-pm+bounces-17779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5C79D2D6B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A431F25F25
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932D1DD0E7;
	Tue, 19 Nov 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6xG3nad"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26E1D9595
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039023; cv=none; b=Dnkmb9ci1KS5J5uS+K/WGp2pPU2BbFAsCsBH7rbS/b1f3T/UnLBDbqWrjSPSgU4PNj1yi4/HUdOou2Lc7OtVQTa0Vmg0RdwhAqRJnw3/vx62HjsI9UXLfkpeYBWBfkMzGGnj2tpvbD+pgYVM0mADLR6NxXymrOY6bcURFoy7rfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039023; c=relaxed/simple;
	bh=kMBG33vo/TOc40mVibFxMI9MiLmVj3cBO8HFx/GtxHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVItw+pIWXGIUY6//0N9iUzZS8eMoiX41fyVBcdnqz8mGjSZai7fRFvWWpTqBw5VkcU0SaAA4IOTSzSQmvS5iBNE9moPtSAHeXbsafpA9YBadDWAOxVor9c413p2v4gzJ1hHwgi6dGtCDJPZ54q20CVYA0Bo8KjXS/Io0gKteBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6xG3nad; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161c0068bso30816755e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039018; x=1732643818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHpOD3kUgP0NZgNkpxEn7+M6CVhgca5HnhadSgnc1wM=;
        b=q6xG3nadyd5V+SEMvb4T3EEI6lXl7JmViz1HK2dPPkDTSMPX1yh+wwHHmcfs4sX1ga
         ravHF4jAYoVnFsGfw19Lg3MKHDZpu0wWQoNrV0/ples/GxdHplyAEwkemDUugkqGpJ38
         Ufo9k6gJ7LWtonagMMxdtDQmn0JO6EYRwctTtM3dbzSP/pQ5ovJB/qPcg4Wbcqja72Gy
         CJyyxXE43k7aZFEMIe8tXUBEroCEc01MvV3dRNuPlfaRhQpJtCZKHtao0+Dv6jvq1IY7
         GCrfBJDJ1DUapaXb/HM+sAKNhttp2tmOPOlrV4/BVGvBPiJxqwVKH6vy100AAiyuTkct
         nu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039018; x=1732643818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHpOD3kUgP0NZgNkpxEn7+M6CVhgca5HnhadSgnc1wM=;
        b=GQ0ByJiBFA1yI446q9s3a9X7gU4Yh+qqOVAHHtDlI+C5O2AC2GgVlbCrH/mYABBgg3
         uoXLClmQkp+7GA2lyRgtR42aE8zpoyrSR2VCHtoFvlAA56ySMdthHqtYovuYgyKhJx6A
         +7S2hRfkXHahCK9Kqmz+xWGP6qdA2fbGj+3gyhaixxfbKELJMkygKKjHFQDkcx2OuIkP
         pFdmljpFBgNy94Nt/rzH7mMIp/gkTWcYXdBQcBlQaNa032c3s/sTij8Q3gN7tDXpLUVv
         092/lNNPUe1VVhPzLDzDXH6pxExO+W+bVskk21xQ9D1hP9kdlhvRL5MTosQ5XkSVVsS+
         JM7g==
X-Forwarded-Encrypted: i=1; AJvYcCWhjNBvHH2oUS4EOrubqDfO91wlPHsigHZRiVvgJsbgI7X54lTQvwfy42gVr2n5KajCfa0kcJU9Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2iITZtzTx+g/csnwBwjyuoLTxdB63snh4sArwQ6fIbNeb8mPa
	O1xs8rNQ2DEuiYgzRNGcta9dL/TTHqUSTIUxHImHc2iGsoNkNXQmmRmqkgn4BZ0=
X-Google-Smtp-Source: AGHT+IFPDNX6KLXFLn/SU6zrsFO0OInhb1Q9wiuJ7LRR3o8jd+59g6Yz543jn9+v12PfjDHzMkSYog==
X-Received: by 2002:a05:600c:3111:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-432df74c8bdmr168114705e9.17.1732039018583;
        Tue, 19 Nov 2024 09:56:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Nov 2024 18:56:46 +0100
Subject: [PATCH v2 11/11] arm64: qcom: dts: sm8650: add interconnect and
 opp-peak-kBps for GPU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-11-4deb87be2498@linaro.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kMBG33vo/TOc40mVibFxMI9MiLmVj3cBO8HFx/GtxHk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFbEK25BwtwTu1JMvsqoiBYwcvGuuHxuWkwKltH
 JiltqguJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRWwAKCRB33NvayMhJ0SqJD/
 9i9oT1zcWnuyY+2ojc3JgiG8RZ8/za1lypAPHpIoWVyEqom9FIhYIr5FQhaBl8JzvTyLgD5dWllI46
 xxzzMukeW1ktiB/KPRpfA/qz1LbqwExPkNQVl8ruAMbqBYXAUVPHxmlYxEkD0WuUga+D/CX9Xik71k
 EENR+lA4BtGV7oMNCM1bQ1ov1HNA2p3jmOY7Km2JYzI0lzXkuwskSHjiN1B6wDVtQgdBfU2SJK2gTS
 mxXzExfxB9VsQDtMgcy9ejIRVoidE9NeFJUYAbTflhXprqiPS08t6S6FoVv6lIA/l6cQPprydHYCGL
 Jj7gxQv6t1+boECssBZUnNCqepbKsacMzl+b4KJ8RPrOaE9xJMvVMIwvJWlBhyzSqCVCBVEU3dGnzk
 O/bOXlwFhF4bWgUR+Qu/VTw7QvCQ6JGkY66Mn9mp2Vyx646XSu/L/tCYvP5j70I8k7gg2RlPJKjSWq
 4U0AX/V3yGRATzqzGJMvvWraXnglSRW0OVivH9GCNMsGpbdpz5oUWi3KOyHyE+l2p6anawxBOGxx2J
 ZhkTaJCDFFiNapDGgPEpDSsj+j0KXa3TIR/G5IL3zC7ZFigY3hFKs0q4+cvAg9LCE106xwAem7Qvd1
 UsfFkATgF/Hg9N4PH2GzIJYmYirtoOjIshEu/UTgSZhQiBWYSMcV0yqVUm3g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Each GPU OPP requires a specific peak DDR bandwidth, let's add
those to each OPP and also the related interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 01ac3769ffa62ffb83c5c51878e2823e1982eb67..331c5140c16bf013190d6da136c0920009d2646b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2636,6 +2636,9 @@ gpu: gpu@3d00000 {
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
 
+			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "gfx-mem";
+
 			status = "disabled";
 
 			zap-shader {
@@ -2649,56 +2652,67 @@ gpu_opp_table: opp-table {
 				opp-231000000 {
 					opp-hz = /bits/ 64 <231000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <2136718>;
 				};
 
 				opp-310000000 {
 					opp-hz = /bits/ 64 <310000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-366000000 {
 					opp-hz = /bits/ 64 <366000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-422000000 {
 					opp-hz = /bits/ 64 <422000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-500000000 {
 					opp-hz = /bits/ 64 <500000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-578000000 {
 					opp-hz = /bits/ 64 <578000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-629000000 {
 					opp-hz = /bits/ 64 <629000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-770000000 {
 					opp-hz = /bits/ 64 <770000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-834000000 {
 					opp-hz = /bits/ 64 <834000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <16500000>;
 				};
 			};
 		};

-- 
2.34.1


