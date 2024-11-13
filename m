Return-Path: <linux-pm+bounces-17505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556DA9C77CA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C9C28101C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7187202647;
	Wed, 13 Nov 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaAOS5HM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D213B791
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512929; cv=none; b=mbQps49/FWXFSJVHglP9CXNCPUYELR2QVGERNHIyXs49vsmlF1WeBrQEF4mcj4UOPYB2TTUnIfq8YW0CmzA/nbdiaE10f4pBKuFG1Hvt6uoNo0yW/bOdhEKYdV+Itasm04QU/VPURUwVPd9s5k0/JyGKuX7tU7dapBS/E0QpLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512929; c=relaxed/simple;
	bh=S+SoSj+qRP3rN1ucH5rok556sxuWpH0G2tK5cUTVK2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX6MIHpPD2MtnsiecXqYcbZscCw89WlFvNaz+5L+F7IsUmKo6CVSVSUST0vUHok5n7f8gze1GYA1qVQkJ8s1v1j6M7L5knvfp23Do6wbkioc0sJWj5kaG0X3gSYn7yyUTgMJbLpi74wigiiMO04ju2PVNH5DZ/ZnLp+udNVckBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aaAOS5HM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da2140769so831877e87.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731512925; x=1732117725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLkvv8R9JARcqpwOo1FEzIbabzBQSYk9vI4IDTHPWAE=;
        b=aaAOS5HMcAMOtT6WIkR2U9GcqK1+YtSyhvWR7N2RgCOqkQ3NHcb3gftbyMWh6eplpR
         cHvA7K7j/F5u9NurkgvJWm1eBtGTSdpWB3JCnH7l2ylBCrL33jAxWo2+Av5nyXxN3NCc
         aO1t6XG3yx1W7Lj2jOwwTf3Gwm/IGA4NVD+jaZ5+617k8YXeNsYrfyla6jVkhzK9IDWb
         KvrWHb3L/BbdZbEZtVGW3x80LOpkZfkO7Q4cpnvFfTK8KFJKOyAhVaRWKTmzhM72faGi
         nl9Fckx8Y/irTDPhgOoLVQsXkiiSexzWgKavhSaXgPHcc/X8naYmSbKLBXrtHqSujXN3
         wpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512925; x=1732117725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLkvv8R9JARcqpwOo1FEzIbabzBQSYk9vI4IDTHPWAE=;
        b=DrPc4v8DAvNlC+ra+bphB6/XqrJE7UFln9EQzuPxuU1yIzHTr5DrgAmCotNf8lXtAN
         Dxf+IcQY4ukkba744oFnTCz0P9RzHDY18mB4uzUozS2re5ptcL40deGKCl4j4mG671tl
         D6mjIhdAJtSbiTnHnn4SF5CrCL/VJFs/4F2cqU9QLHCWMMIRYOLLqBf88PHsxz/SQMTn
         i0VlrcpF4vlxsz3JDZDnDJjUAj1w5TT7PdaVYr/h2YwlcjpWeSjpy+cBrdjXS8nTqRoZ
         QHe0KYUDXovcrmBm5RB3+ud2wtLVnQJTZbHFeqRvhp6eXOsQCJeI0V7Q9Tl64q6W1Aix
         v8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUowknngy2yPHwuSocIEbE5BrKimAPpoVXFGbGR6MGMbhNutBEUQ8etWey0jMst4lxybbbj7NJGIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aJmW6ks3c5rjNplvb0GE0YNEHwVLrXACMM/faOZbdgO2ycmL
	PCIJsHpA3mLFR98av5jOh46iPvSDVM7i8xg4PLLqxC9s6eVT6nVgiPKKX/WKGbs=
X-Google-Smtp-Source: AGHT+IFzTweLUvF3kg8gFXLJ8W63zGBpneugfPnMUH1xqaN+DG5tZl4dczYKpKANSweFAy7zsyr58g==
X-Received: by 2002:a05:6512:2806:b0:53d:a309:7fa3 with SMTP id 2adb3069b0e04-53da3097ff4mr1091284e87.41.1731512924605;
        Wed, 13 Nov 2024 07:48:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f772asm28445345e9.18.2024.11.13.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:48:43 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 13 Nov 2024 16:48:32 +0100
Subject: [PATCH RFC 6/8] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-topic-sm8x50-gpu-bw-vote-v1-6-3b8d39737a9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=S+SoSj+qRP3rN1ucH5rok556sxuWpH0G2tK5cUTVK2M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnNMpSFA/q95rAzi2SnEKM+YVmy9GR0uPKncQSnFbd
 CknGqQiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzTKUgAKCRB33NvayMhJ0Z0cD/
 95X++l6sn4O96M/apxTEx+LCb7aw3VyNWlVxOU0SWzGglMAd2swg03eMMbeqcwIjTUoCGMnTYaSHbR
 ByRZDTnLqFCSX8hTxdP8Fo0BxyeooGlEWqxyGNZtEzxxhCEqmJFI9Ky9CObGupG5/xwv/GGKZ8JF6q
 B3mTXmTHfGrwFAf7LEPgHL8TmOH+ygIoL1zSYRvJrnEduTWyp7IxiKAbKLIozOOKHH8mRKZwKsCUHt
 0hUmZ4WFzVPeQt+TS9JpRRHoUVzVrZGj5Fn/OX27EF4JwjX5bKyEurVCYmprgSQc16qEevaTKKDWqS
 apaZxvUbntlGmj31AwbZlrqSDFvpmRAKBeS+1HxZhX6vI2//fNigkfvZDcKezQLcvUW94+b9pZ0nBB
 CTR3YoWR36Phxfour5b34ivTeeC4kqXm2Clz5hpL4BcugmPEyhzczvfQvFfC3IpWfEvupTtXoSWCv4
 tSVPUuFnN3Mbxx2iHA8/XJk0zV/mDZ3Uhz1sL4BO2VwYewwUUUG/viRFGqEqXQfOnMJZhiYrYqn+AG
 S9TrblcPNbvIdqTeWeKmxA4Sd5keH2daMYCFsjj+HPUCi1N4oqf0Tm2hQ2uKnS3LFx5nVqIz57L9nH
 LXx3uCmCBuQhMgcqWaL9NUtEcIANaxEsQX/8PIZyV+nbe24c9CxlIlNcWlwQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
is in place, let's declare the Bus Control Modules (BCMs) and
it's parameters in the GPU info struct and add the GMU_BW_VOTE
quirk to enable it.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..014a24256b832d8e03fe06a6516b5348a5c0474a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1379,7 +1379,8 @@ static const struct adreno_info a7xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_GMU_BW_VOTE,
 		.init = a6xx_gpu_init,
 		.zapfw = "a740_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1388,6 +1389,16 @@ static const struct adreno_info a7xx_gpus[] = {
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.gmu_chipid = 0x7020100,
 			.gmu_cgc_mode = 0x00020202,
+			.bcm = {
+				[0] = { .name = "SH0", .buswidth = 16 },
+				[1] = { .name = "MC0", .buswidth = 4 },
+				[2] = {
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(3),
+					.perfmode_bw = 16500000,
+				},
+			},
 		},
 		.address_space_size = SZ_16G,
 		.preempt_record_size = 4192 * SZ_1K,
@@ -1424,7 +1435,8 @@ static const struct adreno_info a7xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_GMU_BW_VOTE,
 		.init = a6xx_gpu_init,
 		.zapfw = "gen70900_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -1432,6 +1444,16 @@ static const struct adreno_info a7xx_gpus[] = {
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.gmu_chipid = 0x7090100,
 			.gmu_cgc_mode = 0x00020202,
+			.bcm = {
+				[0] = { .name = "SH0", .buswidth = 16 },
+				[1] = { .name = "MC0", .buswidth = 4 },
+				[2] = {
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(2),
+					.perfmode_bw = 10687500,
+				},
+			},
 		},
 		.address_space_size = SZ_16G,
 		.preempt_record_size = 3572 * SZ_1K,

-- 
2.34.1


