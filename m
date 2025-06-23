Return-Path: <linux-pm+bounces-29342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A036AE469B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F109A4A0625
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E7259C84;
	Mon, 23 Jun 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5YqHr6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1F258CE5
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688068; cv=none; b=j7kEVhDKzlGeENi2RInDxgidJVUKDKwNKqgeJ2TpZjlWTzEMvNPStjEFeoBMNZsVAj8I4mJJbhcVZ+OtaSs+dqrYtqWf5DFVy4x1wvOa7tlCrFf9ADWsZVxvmo8V2utxRBF8FjZAqlW80zSyTG0YusNcmDKIt906sK4ur8gvZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688068; c=relaxed/simple;
	bh=CXzUmqLlLPgJV9fUhlYdmN7WEdQrsY5odxja3TUwO60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mta1McN4EhzMUjlTrcD3mnoEQxxSYle1gXqyBpAFjTO+IkAhr4XeXTovwJ0V/U6xqwr/6Mn3EHNWculCVpmworQQXihtkgM0z8DDM1q8Cw6aTaYkSxc1urVsVYJkKJHUQL3HICIV2zRhOheAACendehLPNUZlxWB4VpcAU4HjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5YqHr6M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7fdca021793
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wZMlnY8BYR2NJHtTMgElKXRX8o21D4nyviqYLbRcalE=; b=P5YqHr6MEH8Mx9NB
	/WYUbki4mLK2IqtMi4oqNA8F76ApbOVt9fG/gMv39Td96PfzaXZHfVdcbyi9d8lY
	LgSt97mPI5rvnDUC7a2kyvPIwvkbtm7hbut8Rpji80JQ/IICE4+Zx/aRB2JgzaQC
	WFgZkhvtNq8K18mTI/bW7USM9s+KoGbZ/4x6QHLhyplCc/xdgqAFmUaWckdYAhRz
	+x3u2b/YE9Ub9h8d7p2XmFqR8cstAcXXzZ+mfSVL8FPQZI765U5b8pVaBRSeSjNi
	bYB6XNwbvBfgC2ZUEYGhScDIrDB5K+ko5x85KNIRvJC8zP5XILZTDDp2koJ5PzVM
	sOXn6w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rps2bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 14:14:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2349fe994a9so33265055ad.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 07:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688065; x=1751292865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZMlnY8BYR2NJHtTMgElKXRX8o21D4nyviqYLbRcalE=;
        b=dlth1rwywRcSugcwTwj7KGkVc+A8QljCaVTjHVAZy2fIUYNMNM5HC/n6HuO4R6g0+m
         l0KRUUH25ipQBgw5y3+JbSO9D1M5LaM20BM4/viaUEzTt8xBMZUFc4fvT1GVcNuQ9qfJ
         0zFECDgLsR0XjgrrBAzbfdqahI2+rNm/ZhbxOKOz9jkaa+zIp1P8lXqbQ9KQ6FL69lsL
         whyG7qCXgdnlvlAHhI35P1nLEoABj21etfny+6rQTdiCApBnea71TZb3M1gmbr+xn2XL
         eYDtd6furC7IPX6O7uc5yQ7ASfSyWKrtV3JZDb3PdeinY7GhnZ512+z3itj24K9v6yJe
         7otw==
X-Forwarded-Encrypted: i=1; AJvYcCXJR0Nh6NiXUAhab8IjoANwMFVbbzZrVkPGv71cOiPNBwAm17hEb2wP/r4xH1/xWMHsxfRtz/u8dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJuMH9E2nZq5dockNJCiThAszhF9kLOsHIZwAp8hs+xbXqLnX
	G9Rp+4mDX24e/kfTmQTc8jEHRaE2VthczQnxKcqZvfiJ/7+NhJ9kD6zrcwuL3H+zpAjjGGwq5Kk
	i8QwG+HicQRlv040NjprFhNuco3edwwwVrPC6oaHqiJb/hSDOMuQNGmPC/KHLFQ==
X-Gm-Gg: ASbGnctKs+Sinaj6vEC898Xa9Y8rD3PO1SQgMMmWnZjzy9EwAcjZdLK8El6S8fGEXHd
	u92UnJOP2aGp+FUKfaysDDlHAbdOmlF5caP2DjLhpjukjGc/daYrHLE6LZeDExTeYyN0htIPl+p
	gFwAa0NYAh/cDKoqJVgHiYHZaPCsFK7CLczCJdqHeW7G5BRRvMcS1y5Fi7ir6sYZPOUxaJIDax+
	/w+oYIA9TGeKb3rs2ZyoXDOK25YByIBKuT/cTWvjYpC0fBsbr2PEHbA+3XiY92RdgVN6xUVvpFM
	RdZERTgbau6jErWAMUC9/SRKFT5GqEYi
X-Received: by 2002:a17:903:2381:b0:235:779:edfd with SMTP id d9443c01a7336-237d9aa9e27mr198760955ad.39.1750688065057;
        Mon, 23 Jun 2025 07:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJYwVOtji4ivszfg3dCwr+wwwtTLGvgE3mvwgNUp3nkK1wJ0Yg7CyP113mzC0FYbbRpk6BeA==
X-Received: by 2002:a17:903:2381:b0:235:779:edfd with SMTP id d9443c01a7336-237d9aa9e27mr198760425ad.39.1750688064536;
        Mon, 23 Jun 2025 07:14:24 -0700 (PDT)
Received: from [10.213.111.143] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71c4bsm8112049a91.2.2025.06.23.07.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:14:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 19:42:07 +0530
Subject: [PATCH v4 2/4] arm64: defconfig: Enable X1P42100 GPUCC driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-x1p-adreno-v4-2-d2575c839cbb@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750688040; l=799;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=CXzUmqLlLPgJV9fUhlYdmN7WEdQrsY5odxja3TUwO60=;
 b=4uyHJkQisGznH0LxP67gAcDDVSB8DRWaZ/k7WS/BKOKxwSHsZEn2+ComoaYVBYm9FmzCZNeKG
 czEusA45p6KAGXSG+1Cj3wlPTXnM/Xmw3CDRQojl9WKtXxK9jjDoCMb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=68596142 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=GAw9eemyJ_aXAIuB88AA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4NCBTYWx0ZWRfX1w1hbt6/B2Gr
 ZQI3SX+fYyS36TvxSX3lVAe5H5it7jk/SE8UP+DxSYLnRjjK28kSeq4BUjVm5LwuNPqsGVu8QFy
 dy5W9kxNK5PKbPe90P/IxYZG6ubbHHBH2pvpmX0DvdevshYTEZAPjvZw5fLdHB1K3jDHC4KR5Go
 PFFVicOHv9s6BprhTnCQJww29RD+vRBvyCOdGSM9LUoLUfr7w54S0nPwc49Riuv5bxcQLBv5N8s
 IPt1iXnpvPPvOJsvPRhsKRX6pR285pCuWud3l9j9fZ0I8CY6PJeGmiH4eGpKEHVSkqXu1+oKWQE
 spVsdvz5f/66dWk2V1tvItHJ7X/pLU8UFj2HOlDqValP8fzmayxZGp6jOKhgaN6FXvKku/HAnNw
 W4met9FgffI3wyYH23lHijQLmwcqFUE9aZvNFQQ8B0wBQEmuKwzjUuRylkkqMGXL26EB6fb1
X-Proofpoint-ORIG-GUID: vcaQ1dGtpIfKgGHa3TYjFcf1uBTgG9ZM
X-Proofpoint-GUID: vcaQ1dGtpIfKgGHa3TYjFcf1uBTgG9ZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=561 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230084

In order to enable GPU support in X1P42100-CRD and other similar
laptops with Snapdragon X1P42100 SoC, enable X1P42100 GPUCC driver
as a module.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a91b79770639d3eb15beb3ee48ef77..c381ec0f2b73233cb3b4a19a214b69f534b3f519 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1348,6 +1348,7 @@ CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y
 CONFIG_CLK_X1E80100_GPUCC=m
 CONFIG_CLK_X1E80100_TCSRCC=y
+CONFIG_CLK_X1P42100_GPUCC=m
 CONFIG_CLK_QCM2290_GPUCC=m
 CONFIG_QCOM_A53PLL=y
 CONFIG_QCOM_CLK_APCS_MSM8916=y

-- 
2.48.1


