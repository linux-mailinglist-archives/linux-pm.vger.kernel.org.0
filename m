Return-Path: <linux-pm+bounces-28478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67458AD539D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE153ACD6D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B4273D82;
	Wed, 11 Jun 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQLqZHu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CC2E6138
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640580; cv=none; b=NGadoPQxzI1nddJ8DlazgLv0y3M722+5YEcNyyhv1v5sctP0Sx4Xg7P3EL3dzWubiD4CnjwL5pyLH7DHV2hVztGH9HxcNB0vrJGTFvgP+XTOT7NE4oV51g17L2jjm7bjU/NIQLqBH92mFTqnyp+CalqETGCckBB+dUAYaTjTors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640580; c=relaxed/simple;
	bh=+s4ITcXnEPYZYROUKwHmQyjB4wKU/KPjLzqOm960DLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/j0K14d82ExJLkriFH0CRCMfiQxTmuxvSTgCVTIM3D/EcwqikQThDtovmJJUNUwemzlE7MZvOHWixAC+syGVBlVE1d6kVvNBR/G8D/9NKpoANsREg6D0oN7NPsW7+8CLw+08qvMazwQpy8ariYvgxptqcMMGPA/wO/Y+IXY2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQLqZHu4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DCPE002350
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V3j1uc9440Aqe3s91zqfhD9O3nYuGwVY1biiyW8GV5w=; b=cQLqZHu4SR959/cD
	TVEoC9cM62pYtKr1pOEuu/dPCBJVrmgCV6r3nt+B9H/IJRBngV3bpbKVaauWrxOX
	NtI1FB6Q6bB3lP7NKFPMkU8JssHjvBolmsvNzUfGKlFAULd04wl1UrbHMZeCVVlF
	IzmIwYfEmm1NEwm/iB6Ww8iyai/spB8TU/Jr+ddaClhfyh6KYyzpWP6BZWG6OiFo
	AQLFwV/ZNvBF1HeEYsRPEIi+o65cNUhxxyWJs2KIOgu8OG1iq3iMKUIq/q+7MViH
	weR4MJ5JpLqaEqIMbvol54w/Q/S+Zdh0lg7VziYOsPT2Zk3QfxgZKSmmCwJv3Mhz
	VNY2Ww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgxvyg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 11:16:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-747cebffd4eso5175694b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 04:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640577; x=1750245377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3j1uc9440Aqe3s91zqfhD9O3nYuGwVY1biiyW8GV5w=;
        b=qGjJPMrG+7kuU9y71z19VEDxtELtowYxzvzxEYpeyy+PBuoU/ZLGORwE6HR6KQoPrN
         +Cv1oSnm+ZnDEuBFU793sbz2TAyPC7yhedrb5MP0xaiEZ8sLjDuQIaPFpvAJKr4H4ouO
         zFCZj1hOidytfApIlTjkK61dZAAKebvIn4yU68aKkaLMSpbeG8GYfvaihdMs5gjNn8Yj
         b3Z2n7zZXGcz8extKbPZy2PkbCdb1IIsxI7kQOi4Xcbpm1RV5B+gtPrdEMWtpHMB1Htv
         5nY7qSuJCjddHGlK81PAY4iHP8Ia7G6bVpZrwxW2pBFLJugV8YD7lJZiZSNouH9JJOdG
         IFsw==
X-Forwarded-Encrypted: i=1; AJvYcCX1UDR627OcgXxbc1NI0Hhs/tyUtmz4uCczeNSyCrhX1pC2sP3zB/FA1BimRLLn+UWNUVm+9IYoag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw015X4ySYeGI/3lbyni+jzf7kOLFcgzlV63x2cD0/WhcJZIxk+
	bOr+1W2ismxcDrU7cM6igcpXG1QwNhNgQXialgSqeWrN+nv4CbCSESstA79zJqdGvOHYcce0m9U
	ZLWQxf6ugFgA0d5cIxDuQgJABjQcHXPtKD/TUqeOjBepIrHm/PzXzML8vAZgekQ==
X-Gm-Gg: ASbGncsarh8Rd2C7uWwHliyyHP7hVEgOTts62luMsQN3eSFAWPJZivivCYRjzPCxPw0
	aJNQ/HThzsAEb9KVRC7Jc8ff+gtQOViOyJzo6/pq9NQOOpGDSTWH6sfWrSgt57L9/S4nOdM8aAT
	GFjJphCSy5Tze4c8Rj3jxFjzs5Fki7gKKsmdE2+AmHglNLO0bovJZoQYIkvuATK2q7MvTrVorK6
	SSIyBwYGJt2PGkaBv8nF1PZBHj6ogPXU86FO7QVcRJWzXFnkha3rJkfPSr4+lhQc2dQFuvtC6N4
	gbo7+sXKnXMkwuD9JOW4fZTell9+aZUg
X-Received: by 2002:a05:6a00:3e18:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-7486cb59a04mr3951258b3a.4.1749640576341;
        Wed, 11 Jun 2025 04:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAG34Pvkev4y/hpRlus2OjuQHXtSd81WCCELRlR9luC9dphyxucxaLNk7Bj0pfHjdJyK31pg==
X-Received: by 2002:a05:6a00:3e18:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-7486cb59a04mr3951226b3a.4.1749640575915;
        Wed, 11 Jun 2025 04:16:15 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9d57sm8820772b3a.160.2025.06.11.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:16:15 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 16:45:33 +0530
Subject: [PATCH v2 3/4] drm/msm/adreno: Add Adreno X1-45 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-x1p-adreno-v2-3-5074907bebbd@oss.qualcomm.com>
References: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
In-Reply-To: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749640547; l=2022;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=+s4ITcXnEPYZYROUKwHmQyjB4wKU/KPjLzqOm960DLE=;
 b=1BufoQl+K2Mq+EwIqeygORUYFrLK7REnSATB3nejAesVra4H4dodAXHO6ddF72x+zhVjfsmKF
 jPpmZU5C+rVDlrz0Lfd80Nhf8eY9DdVkZHaoRrQdu7TxWUm3e+ZDLWa
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 4yrkvGamkY5NirkkQUE2Er1J4Wk6R3ct
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=68496582 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=25T8ekUwwafyqMypFLMA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 4yrkvGamkY5NirkkQUE2Er1J4Wk6R3ct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NiBTYWx0ZWRfXyeEyk3Klsh4T
 raExOHQxCLuRgNxFLkCEdclM8hwAC1YHFa0iNSuvksqj9veCOQ0CJEPmGfzISqqNzwfT2ep/eJp
 xxHutVL0ypn2LnLow+DwMJRdaE4C71efNDApQnSpHda59SNnEP9BKsu21QU2Q0XzF9Scu6vZaCb
 MPzoQo8wyRIkm1w/AUVz7p/bR2Je/ZdklDGuD3ngfzJiEwTU2+wqkLIBf2PIkwM0UA3dB2J7p/c
 8NCu1ncW6RzxRs5HvE62Uk/Apd0Lpt5gNYyfNVQ5HfQ+2D5G0rW42lboYgtixWYTk6DPX0BA9Hq
 dhf2DFML/cR5JjjCjZTHBBONSL3LaX6P4chiqj/Z0viXojJvGhnDkfw/5383sqPaqBZ56NwLIGX
 Wka/LfzfI1JjQTb25QD94em5MSS1Whasg/pmFumXRx5Fxd+guChzA0T9K7mFBTUPOngnqO0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110096

Add support for Adreno X1-45 GPU present Snapdragon X1P42100
series of compute chipsets. This GPU is a smaller version of
X1-85 GPU with lower core count and smaller internal memories.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 70f7ad806c34076352d84f32d62c2833422b6e5e..2db748ce7df57a9151ed1e7f1b025a537bb5f653 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1474,6 +1474,44 @@ static const struct adreno_info a7xx_gpus[] = {
 			},
 		},
 		.preempt_record_size = 3572 * SZ_1K,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x43030c00),
+		.family = ADRENO_7XX_GEN2,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen71500_sqe.fw",
+			[ADRENO_FW_GMU] = "gen71500_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION,
+		.init = a6xx_gpu_init,
+		.a6xx = &(const struct a6xx_info) {
+			.hwcg = a740_hwcg,
+			.protect = &a730_protect,
+			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gmu_chipid = 0x70f0000,
+			.gmu_cgc_mode = 0x00020222,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(3),
+					.perfmode_bw = 16500000,
+				},
+				{ /* sentinel */ },
+			},
+		},
+		.preempt_record_size = 4192 * SZ_1K,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 294, 1 },
+			{ 263, 2 },
+			{ 141, 3 },
+		),
 	}
 };
 DECLARE_ADRENO_GPULIST(a7xx);

-- 
2.48.1


