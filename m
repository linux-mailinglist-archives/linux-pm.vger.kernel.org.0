Return-Path: <linux-pm+bounces-29343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EECAE4689
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DF117F9D4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FEA25A2B5;
	Mon, 23 Jun 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qr0/5Lmn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED126255E23
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688077; cv=none; b=LTzJkjH+wxLJX8UoXV6RLe8HhO0SBYojEAkJBHncUjwt5gz7isnry+5e95ZFUShPqABESBxkD09PtJuNw0ze5tvP1ygPwgcvislqhZQsgfYxAF7GCuCJo9XM5P+9xc2ecp5wIz7p2G8CwCyikD5QoVfiq7QiZfoTCijLgHNI0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688077; c=relaxed/simple;
	bh=xKZ9Xj4qiPD/2Zmj4aELMu3Uy4uODXqfzQQwFPTWu3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZsaeOb7Or+dRSgxo2ONQBE2WblAUYqjdE0xVeN3Hi6ahfzAtul+QwTyvJiWlLCy3k8up0gIqGe68V0RnOgywk9xcJQkbgQ4FOqlEu5mCXotRIb+DCkYwq3ehbX2F6qxRn/68OfGLyn3n7oSk5viFRZ2UbCYlIekc/88+TH7+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qr0/5Lmn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDnDjZ020251
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IDdT8GmCmZBkVRDlqMB/TVH3NvJZR5f0rOeZUeSRtHg=; b=Qr0/5LmndzZH7Vy0
	9zK1b+MKQSOhlFsqy/SIVY2SW8wRk3lCJJPoRedx8FZgxUr9nRT9mRUdal33qRpD
	SDPDSp74oKrjJfRHJO3BoSK1Js292xtn1hZQ4mAtC5mJ8LuF/9OFKax3y2kPjC4h
	t6QZf0UYD2JkojDiq2Ao7RYqWkiX41bTauRD2ImU/LFnD5w0JZzry+IQH7L/pOxe
	0Zr+kE1jJeWEGnW/OQaEhU/JjSJ29RSzWfaWfTk/bB41Nitf07qf1Ge2k5/cEXZ8
	QbNnFZm0mTCPILf43q4qVNf2vE5ePBMEUrQOjHHq27WwFKEV5HM5HTpsbkMQ92tI
	7MBqIw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47eah7u5u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:14:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fb347b3e6so4249417a12.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 07:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688073; x=1751292873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDdT8GmCmZBkVRDlqMB/TVH3NvJZR5f0rOeZUeSRtHg=;
        b=cSD6zFHqT6rjqyrqET6bo5gqSZT53REdUn8oxbEXa/PVh2fhhrZCkzSLGQYiA6d3z6
         iahRX67riy6/jQv7ixeIBgSRw8nd31eo0hCsqdB/f+BOvl4mvsXxPO70lcSflKqy6Afr
         H8e1UfDiJyrT6E03mHDxz17ZCr2lD/9pENjmXFgzUCJ+A7giEDs+/vWQfRr7e+sc1mAl
         zxsBLnSysVAnDN3gVcd1xIIy/mivRAUkSsr3znaMxTBtqRTL3DUHMDUQHIfhuJR20ISM
         V0yle0k2Ie+LynsYDLTowCFW9dr+1LJ5n+p1L/4HIWYdwLxCHXdJk2HZ29Wgj54/c8kX
         uM9g==
X-Forwarded-Encrypted: i=1; AJvYcCWjjDqd8QK50Gd8lmbt9S9ejsSvVDBreD+TIhpl+k0UXy6WkIRYFDUk7slNRpa0C6+VTqh/tTsEUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45DJfM+p+AgbZlrqSqfp3qdVd0Wli0TJwkDAQk/bnFjTcEEmr
	/DWyT3zlQUVUeoJDXXJ9pXoM1a+njrrptDfGRbhEXaPb379zR2UFfB1S3bfe4c6bfB+wUxntTH/
	TRRcJC+qiURXkyWY88q91cAmL9ar9tz07H6bIxAcqjoI6rstEjI1RTVItkcJokA==
X-Gm-Gg: ASbGnctUquLGmepZF16uM/pH649HUni/MLMv3Y9J2eI6qQ4pcTgo2A6fBJXkvrRwqu6
	bXbw2S+VuRG6x7vkM/YRkvuPJL17pPjqaSh0GP2Ft8cWqqoy1Ss4XM1B0dyo4aVObZ+hK5jKbx7
	GIc1522QFFGHEajlr/pnwlVqsxVrMxNt3Eqn0plowLNcDJ1CXak8QihbIn+GeDdhrB6FVjogxx+
	w+R0AQdCNHExSStcipkGRdcM5zWNW8k6WRuuiqGjhCKMrw/eBhjwpkeXZe619U1XYcDuA0cDBEr
	uRn2v49vjK/ewZ3PgcvapOuJTtpxh5M0
X-Received: by 2002:a17:90b:2651:b0:311:ad7f:329c with SMTP id 98e67ed59e1d1-3159d7c8f9cmr24187387a91.18.1750688072967;
        Mon, 23 Jun 2025 07:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFohlIbDHPnzGFzoVo8IyUWv275ozTxbFgCP3ruQsyFrF9oyTg/DjA45LUYjJ+1geRNvBXBeA==
X-Received: by 2002:a17:90b:2651:b0:311:ad7f:329c with SMTP id 98e67ed59e1d1-3159d7c8f9cmr24187313a91.18.1750688072479;
        Mon, 23 Jun 2025 07:14:32 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71c4bsm8112049a91.2.2025.06.23.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:14:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 19:42:08 +0530
Subject: [PATCH v4 3/4] drm/msm/adreno: Add Adreno X1-45 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-x1p-adreno-v4-3-d2575c839cbb@oss.qualcomm.com>
References: <20250623-x1p-adreno-v4-0-d2575c839cbb@oss.qualcomm.com>
In-Reply-To: <20250623-x1p-adreno-v4-0-d2575c839cbb@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750688040; l=2172;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xKZ9Xj4qiPD/2Zmj4aELMu3Uy4uODXqfzQQwFPTWu3E=;
 b=nyiUEqvVCW+25SYZKCQtGlM9mIdhtcEW0YGblasDdcsi9vA0hNbTrMnvW29/s2M5+bGhB9XUq
 aFcV0xh4x86AEvTj2u6wD9wWN3yobWDJ/JNXPBpIQzwfyk7yvN++lw5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: JH7DARnNsYC8U-JXTBZXm4fb82LS92dk
X-Authority-Analysis: v=2.4 cv=PpWTbxM3 c=1 sm=1 tr=0 ts=6859614a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=gxl3bz0cAAAA:8
 a=pGLkceISAAAA:8 a=xcvD53-FQScLkYWh0o0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4NCBTYWx0ZWRfX83hNCSuhPmKU
 RXZvOoxv/N7uK4W1M6NqLaa2UzaYIr0xZTcR3SwuK/m8rBfKRo8ftrQSwXRXTPpXOaPy2CLGcg3
 jYVKxcD2ujtmEKWEGzcx4oYCq4iKg/agoi+4vBoiTr84eMjztV6EIQcStdjwozrPmTwsjzCH199
 aNI2je7d558dll3VAavWP/raEvhWA6J2m7qnmRfD/cEvVCMxRyrEtgYp5QCs4VTgUZYFfkiB7oP
 MhACVfqzNbt1VEVfSDnSHdrIaqwwetqzxhAVlRAobBa81ry79eqvailABQgs27tIsQtljFSebzh
 m87YB+eGv7OwOXVJaXXmxosIUcAJak2oRrlYKa0lJzLkxJerEKoDSQ/OhpdFgIMVY+kz9JSxkmt
 71QZmtTGm6do5yyNnd/6WnMaC6hStiLBoP29iVgAAXyPwHKAcOL2JdvP1x2aDSWzk+c6ro4k
X-Proofpoint-GUID: JH7DARnNsYC8U-JXTBZXm4fb82LS92dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230084

Add support for Adreno X1-45 GPU present Snapdragon X1P42100
series of compute chipsets. This GPU is a smaller version of
X1-85 GPU with lower core count and smaller internal memories.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com> # x1-26-100
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 70f7ad806c34076352d84f32d62c2833422b6e5e..7748f92919b883bbcea839a61158ab52e6e4e79d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1474,6 +1474,45 @@ static const struct adreno_info a7xx_gpus[] = {
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
+			{ 233, 3 },
+			{ 141, 4 },
+		),
 	}
 };
 DECLARE_ADRENO_GPULIST(a7xx);

-- 
2.48.1


