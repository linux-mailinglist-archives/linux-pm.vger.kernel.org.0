Return-Path: <linux-pm+bounces-29129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7AEAE1466
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E224A1A4D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFD9229B26;
	Fri, 20 Jun 2025 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z7zW9rHg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17C228CB2
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402531; cv=none; b=ROoeg7OpQE3n3yQFZoZS+04KaYpGl4TvxD0RnhXmiGYbt4liaiRP8Wj5jjaZTSIoJ9rDx5eEgdT0+jV56UFGvQaUKMEJSOKjDuno7EeEctllLG16nMr1VpTJqngzsJej7MUjU+oHilgSlsFV6QAH2jH02SA378zEaE5ONnQ+cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402531; c=relaxed/simple;
	bh=cb1ncv5kKe+9beezyK8P8PEh4cB50d4o5qsPw+1gBfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jO26jZQYMEGCGID73en1TREDGHIQjEIXnA4U/3HJgc9qj/HXNWUdaehrCiePR8KJGUFt0AD5ZxdyRaYzo+S1i9hf0AcbJdxdFp8nwninpzxul0LiGKwnkQnqxcHNCzPqvrcC1DYEiaAOUS7OzLAHFdGFNWyAyRZznOJSDHkVF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z7zW9rHg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JGhOum003284
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 06:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/cra5HUnd+Onw8p9cvyHZDcLODFatDJov6W4y7HTf2Q=; b=Z7zW9rHgAvjhnm+7
	kYL4yUZtbz0UIW6nnqrODR/VmfF+4C/5FGxkDS/zx7TzGL8C9Ct2iiAdlwdUKpSZ
	SiAukqYqYzbaxcmKz4RTPXLA74cmmJNFYTepJ36kl/Ew21UnfcnQw3wUO7LwPE3E
	w+5A1jmH402taX7tIQjYAY9JjCgmshTMMQAW/jzUi7xFIcCsfxGstp5AKbgJitbQ
	SVWfbuzSyugfgB4/jWj98hadZnGarfXFrmDy+CI7pw+cXYlyzMIK71KxJHTB2nkN
	S2P37muGUrtu8FvQ+BzKlYl1gG9jtEYfhRGz+lwHnUPZM+O0j1DvBunp3V5nHH52
	5X/gmw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag23ea81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 06:55:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2369dd58602so14371585ad.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 23:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750402515; x=1751007315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cra5HUnd+Onw8p9cvyHZDcLODFatDJov6W4y7HTf2Q=;
        b=HCCEaKa6yAx7+bxqxnSFKgBhGz1HwJ3+9ViNe+NhT1dsfkLO4kOXIbsRW1sBYXeXjQ
         li9KdjkabrYy1fxZ1IjArlOM85a6gz1mHLza8ZO6ipF+tK/nBYgHJeHDCrrftiPjtwg7
         H4xlgA3JXAXgek5DBHm/gcMSCpOwZV/ilVcokArCC/WAQ+GN1b7DffX0GdRE9xaNcddo
         12J9302Xv8P7tzz8FW6Ii5rssDMfJApZyqDF81y5X/FJJZfrMmlCUhNgPseDt0U/emaG
         NKD6OV3PSYy1rwp7ymNrlZnON32eF2pSIhfmrgNgdvgbmNefRjLbypnBO6kNu3k5qjdn
         NEtg==
X-Forwarded-Encrypted: i=1; AJvYcCUID6EFv4jFEMd/J8tffAi8w3g2v20W23QYsMRGlbr2Wns5oXIn+z7uqIKbNHtwNRkVBdqoyW0dvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kldo8NHWLgKtosM5fREcwKdU5IZrOJjrQ7Pv+8rX0tUI+9Tu
	6DCu0Hxv9ka9JKF35sEB8J4ew3ZPYxbzxrgsIIeRKhnidfTqScVxGUfnADee0LEWRiJY+PZMVYZ
	zYVADIUpZpYhGZjlBaRPVw6svrjsBUzxOG+qNzNePKr/98NhwNZX1wbE1m9M+Cg==
X-Gm-Gg: ASbGncuiXzdfiL0s0wkNwrDaPY8ShNzVqdQuAuCsfF9QUG/j+WTxQt1ozEGn7uM51bz
	GDDnJZUaA67VPRd97WDIWY3ZvFaT7dq2qjpRafP3hN7UVbJ/8sT60RYZAE3xEwa6otuN7cgYSpt
	Hb1eL5vI9Rsi8vZjogqA+KDcUFiLpp8SiZ+EkBcUNctufwBYvYMXjBzy9dgd5U3Q9jEDi/oAID7
	N4HdA1+YsU9xe50U6r+qttWwigNCE1oRJndAeLjLwamHG/+eV7v+iEKMS1FRgOGsY1O7NHoa3EV
	jspe69al/NA8YGGdWCB5BOLpZ3MVeKFY
X-Received: by 2002:a17:903:1b66:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-237d99064ccmr28616705ad.16.1750402515073;
        Thu, 19 Jun 2025 23:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiXAnjhsU81dzFSNF8XeE5n0aYS1wi4Wc4hIGCqzrClvvAQg3nAWi7A56J6kwNx3saDQ1gfA==
X-Received: by 2002:a17:903:1b66:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-237d99064ccmr28616285ad.16.1750402514633;
        Thu, 19 Jun 2025 23:55:14 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8701c0csm10636185ad.223.2025.06.19.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 23:55:14 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 12:24:30 +0530
Subject: [PATCH v3 3/4] drm/msm/adreno: Add Adreno X1-45 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-x1p-adreno-v3-3-56398c078c15@oss.qualcomm.com>
References: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
In-Reply-To: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
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
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750402486; l=2100;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=cb1ncv5kKe+9beezyK8P8PEh4cB50d4o5qsPw+1gBfI=;
 b=6DsTJ1+fRdhEPD5dnhpU8R/Gz1ebwrb9QGaqZxTAvYnxQjpNbqZZnZeVEtrXDr6XOrbHpho2d
 D3lSYE0SnesC8otPnX0urguqEuklaUZlab1toQoIuaDx+Bast0rjRDM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: C06EcHAFu7dR84m1Jk-o_LjOS9nCKDmM
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=685505e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=gxl3bz0cAAAA:8
 a=xcvD53-FQScLkYWh0o0A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA1MSBTYWx0ZWRfX4Qaceo8DNQ8i
 UjRGyDuc586AeETKK0A4Ud5/4347yv70ufcDve3YgSDNFsBqAQjwV1FTzZFC7ejgMh2wOE7KzfI
 jvfHw3pOZYBz2oRuh89wwAnaVQ65LrK/W+KmjclFUq5wzjYmnkg2gCMCGBtUq5VcpKxSrY3dHNm
 GUln+mAqlsWPtlq4LTnxnJ45JXLtfsaNAkYUGuv3xdomIcbR4htmwHArWKL03WzCUho4joN4GJw
 gpDrsqcdrC5PfI/elyszlolqIVeSEBKZMbHhqd71jiJMsbRMvXEY9thHk/N98qC1SIFsklMCgsR
 WSGjzb7JovoWZnwOc1HOWwcLY6H5rrPhNzXj8oZJYyfk7lMIg7xGY8Tz6b2g7oqBDQn0C+fM5SZ
 /TPXUm77/pfu0SFAnoR3U3F3BFB9mL29KvgnltoazqgPOCiK8tzTGpNt2iTHptMz25mcC7zN
X-Proofpoint-GUID: C06EcHAFu7dR84m1Jk-o_LjOS9nCKDmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200051

Add support for Adreno X1-45 GPU present Snapdragon X1P42100
series of compute chipsets. This GPU is a smaller version of
X1-85 GPU with lower core count and smaller internal memories.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
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


