Return-Path: <linux-pm+bounces-29126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5AAE145B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7C44A0E8B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0149226883;
	Fri, 20 Jun 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SeR6SXb1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B4224B12
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402521; cv=none; b=iy0/TB4k5h/6afKtHvZSymBhjUrK92k97DoDQvuliDJ5IeLPvisZg5y3UJiRQpti/I3jC2PvUVtcsTqyoJ4LArI2EYg1gTuXows6Flx3dnk2Czp9QDNv0brE8oNM0qNc+ofISvu6J7towLgaqdpJHlWQVJ0/+Pe/XYL06PDBvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402521; c=relaxed/simple;
	bh=1oxyf68EFFylCmMjwV5jb0pfG0MEgVawKDcLqM/rxmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjLEVAgpvh+OK5buWvreSBaCwWNay2ahfI0Fy3mVaviBcnpZnKGAb0ljT/jHBL6Wk7lnU0yBXASYALCorCcOLTXIAKjTlXEeFkoX1psPLFRQLYOnyqot4p7DEsxCCrNkF/n+18s4PVazEn7pE1Pdr/VPIKyV8JZVdsRC6ErJZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SeR6SXb1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4VexF018578
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 06:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UY8Xz4SAGxjtVkpxY96irg9pXQ6T1NS4IVwFIY8UKPA=; b=SeR6SXb1TsEqQHdC
	p4UluYnmYhsk4gwBJmQfy4n+8j4Cz+An4psweTNeUyZJjCsMFcolWfWiW+v6sFgV
	USDgaX5x7wWUCQnz05F8cgU2NwqCz1AhQTX6/arHEx4E9wVFYy5gwiuODz7I7+lz
	piH2xfuojK08ZNCR2N/pkz6AQ0zKJ8MUTNKfVMLSy6RuvNFZbkifc+SYUF9tzkqm
	r+6V+kioif4KO8eNavxIWQtehgMaePypIL4YyHQO8ce3XGB8PH1IlOi8wws1RdBc
	1injVwtI4E9WRE7s7Hm6MaEsO9g7Q+ckCZYVxs/YRLbUe9lmKZPXQ54XH4rjCIIX
	JoEHBg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47d0pcga9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 06:55:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so14820035ad.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 23:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750402507; x=1751007307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY8Xz4SAGxjtVkpxY96irg9pXQ6T1NS4IVwFIY8UKPA=;
        b=Jw8A/UUwrs435YSOw15/XgW2+S7zYB4UxZiAosf4+L29i+2DFV4GGEl7Z5JXGSbcDn
         gUEMGqFjJvfoHuPiVT0KygjQ/hkKQ0Tsw+w1PBo9DguEzzgFyM8V6G9M5KoBuloufIaa
         Uv43/akptdcT5WAbJlY4sBuwYe3VQ/dZQFGxwcAYwkmygHv9Y6n4HH1LDvs8w0DuD4vD
         CPnuu+p5DUHNkSs3COLB0zX139tl91pQq559bWOQ4ZBTvVEwxGP4GaTZamlsHLZugmXw
         H2t3mJ751a8TyPy8xdEC5ONElwpcBti6ofuuj9AtbA1aVeWTwm2cssOHS5+OQcataNto
         RmVg==
X-Forwarded-Encrypted: i=1; AJvYcCWdEl8jIu01ibPqZ/QkjMroc1LUq+ijJN0ppoES38BOElNLLSqNVHMtWvs5p2XlfZyQDVFTXGBSJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDFwv9Jv1VyGsgYHPsjfBGC+X8IUXM5tKP+QQAbRGtZL5akgp
	NxNbVze0iHw+dkC+ZJ/2mk3iR2pdSCxl7Xnr+ipz6vBb70SjaetxLljiL2umQdvHNqcRHzk+7i8
	i50WCgEOJSOfTt+TCu1MAL/0GXvOUtKm0BLMrlY5ymo9JRDVKQ0lvBA3j42T95w==
X-Gm-Gg: ASbGnctxrNCvwAAeAxjmFCN5xXme8yze0647o3fkF3vwBaGFbuQH/l27L+dXajtJ0bW
	beStTXpGLfPEvGE4woHxCMFZOFDKn8esqZgURGd6qNdEsGbmlG2ZbhqJtnVhcawflwQAD1h1bEj
	LvRkTLQgflPh7uUmWH+/Zy7qfb6xQaWIyp6v01LgkQZg1AsbsW3flbegTpmxGaLH+XqYvCe8g9t
	7x0YbfAkwElfVJmChzc9YxFw6vpOEDm3fD8bp3Pj0BhfIvBEJ6Pg558NMlxMQtlb8G+iYaE9Uts
	ckJsInbXEfe2E4Ft08LsyOgXtuwcN0Tn
X-Received: by 2002:a17:903:2f08:b0:235:efbb:9539 with SMTP id d9443c01a7336-237d9906e40mr27772775ad.17.1750402507474;
        Thu, 19 Jun 2025 23:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ5LpDJJHEcZBAtNAGjCwyfD1eLqoPaVU68U54gQ31anHAn9sWvOPT8dxNj9uXQ8vEOHStmw==
X-Received: by 2002:a17:903:2f08:b0:235:efbb:9539 with SMTP id d9443c01a7336-237d9906e40mr27772265ad.17.1750402507104;
        Thu, 19 Jun 2025 23:55:07 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8701c0csm10636185ad.223.2025.06.19.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 23:55:06 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 12:24:29 +0530
Subject: [PATCH v3 2/4] arm64: defconfig: Enable X1P42100 GPUCC driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-x1p-adreno-v3-2-56398c078c15@oss.qualcomm.com>
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
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750402486; l=857;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=1oxyf68EFFylCmMjwV5jb0pfG0MEgVawKDcLqM/rxmo=;
 b=8PF3//AD3gGPG03AcLC4ONVS69EyuqXu0pNc26VvETNgzRpHlRintCMdeMBUfPaRptrZsJlyV
 vJLwgH/Zyh0BgDMciHJYI0hdt2oscEXRCGJBuuNwMM8XQ99xTylLnso
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: aIwwaZHlRcBQx3tVKmzFYyoT6oI_TfPM
X-Authority-Analysis: v=2.4 cv=YKyfyQGx c=1 sm=1 tr=0 ts=685505d7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8
 a=GAw9eemyJ_aXAIuB88AA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: aIwwaZHlRcBQx3tVKmzFYyoT6oI_TfPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA1MSBTYWx0ZWRfX7zvTA4ZvtN4A
 Bvi3R5aiGGLrvmT5+PfsYvoX8lciBLRi1RW0SyuizwBxMUKYuAtmnYE4jREBJR7g1BGSobk3UV4
 SW8mJpg83jbnwKedtutiobZqRqG5yODJfv7JrSm5XaLOkz0GKgpmGcA4Cmell0Qn1wWM4wEvYoh
 X6Vh6Sl6ko9APc1xVyQE+tdMpKBVK/8bZMbXFdNXado62iUPWmtW9eEl3PrU8GQ2ybTqIJ8PNm0
 AVM0tSgjN40Pi5evKdWPxNMXOXSwEvzymndUb8RJiyPtcwRyeGZncIjVQAaivvnHrE5IBGZkeBQ
 z8506RPIv8auOLvd8PSYzR7NQNbdKVXZ5fxyrhdOc+fsByUYJ2F8LaCzZqYNjt86oHEw124LqTd
 p5zajzuFHcfZCuTIBzxSZUEW9agQqN0Zca3KS6QtFLiIJISUv/qy/QE6cCMeHc4G10eIazoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=549 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200051

In order to enable GPU support in X1P42100-CRD and other similar
laptops with Snapdragon X1P42100 SoC, enable X1P42100 GPUCC driver
as a module.

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a91b79770639d3eb15beb3ee48ef77..ccd03ab5de495498281175a4550bc73d3e65f3f4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1347,6 +1347,7 @@ CONFIG_CLK_X1E80100_CAMCC=m
 CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y
 CONFIG_CLK_X1E80100_GPUCC=m
+CONFIG_CLK_X1P42100_GPUCC=m
 CONFIG_CLK_X1E80100_TCSRCC=y
 CONFIG_CLK_QCM2290_GPUCC=m
 CONFIG_QCOM_A53PLL=y

-- 
2.48.1


