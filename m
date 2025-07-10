Return-Path: <linux-pm+bounces-30575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C559DB001FB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749EC1CA01A1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A02EA15D;
	Thu, 10 Jul 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ndX2buqC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7927056A;
	Thu, 10 Jul 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150603; cv=none; b=YXfKt+oA+q3kMyJx31swkYvmiULOufxt82Tzf+9Z8IdMxz7mF+XwZpWOu5EDMQ9BHLTbghHlW/xC0Fey6XtN4+UI7rokl/Z4bga7WzR6nGhRWRHMqp5HteOxY/RHjDwkETsjM6YbENxZkyz/arvbX1NAm4+oHFcU3qBnDLN8IUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150603; c=relaxed/simple;
	bh=2us2rpGL9zkiRlp32RB/c3CJ+1+7vDtLGPfyKLPCbE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LvKmas7adkcdXh2z6HqiXscX/9xH/b5oylID+q2+zcTERfziDaa+0JLS2b4i9KvAe3rm6O5H/XBuvAIIdLojqbNCN5kntleuoRLxHT7EJ2RPHnUU4Nhy8hqJs1EfbcqLb1EdhLoh8twjbGMWY+hGgzTOTjN1Ln8VxCJmplXy+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ndX2buqC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9GP9H012606;
	Thu, 10 Jul 2025 12:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1TC7OL6QmYBBMcwfPaJCbsNoDqxeC+lLH/AnYjZeqzk=; b=ndX2buqCM0ylFELs
	FOyYnQgr1d/PcE/wNsULwgbM3vi9Lb2+oT1V+R1FWreuGznoIzijUk058LTgo5Yb
	CdQQFPvjo0cuvFZ+Ep/xBA4w9ap8w7Wv0cHFEYr4cNBNuzauZnezdvFkcKIuzvoT
	M43zIR05kPD/TQxiseCwr18nPCpKik9wJknBrKWvh3HsILnGOf+QZtPPHeyDwJ4v
	hg/6dNbocWp/TXzxGqtZvYwxyOofSHeoIZu7UpTTNfIBxR/ku8Vise0U042qaS8q
	t9lYvIs3Q+504+eUJ4E2DP+/4XJax3yNTa70qv6ejF6jYhx8pGVPLe1N8KWUwjKz
	eEPDHA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn8ehc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ACTnJ9020838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:49 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 05:29:44 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 10 Jul 2025 20:28:18 +0800
Subject: [PATCH v3 10/10] arm64: defconfig: Build NSS clock controller
 driver for IPQ5424
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-qcom_ipq5424_nsscc-v3-10-f149dc461212@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Anusha Rao
	<quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752150529; l=836;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=2us2rpGL9zkiRlp32RB/c3CJ+1+7vDtLGPfyKLPCbE4=;
 b=/i5R2AyHvoZMtzHjoerIZKqJOxQNoYwSiAdf3gy4YWJm38DIula2xkxFraSGcdPdFGufQhWgR
 fTRXhtMSExuBn2Wwo6uXVrGXAS/id3zEzFmUGd//sVCYQX9iD9EsKhA
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686fb23e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=ikIlBLl75NxfxiEf-eQA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VknlAFBTCf3bG_y0vBip5fQVobo6ugMt
X-Proofpoint-ORIG-GUID: VknlAFBTCf3bG_y0vBip5fQVobo6ugMt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX9LIz1D+9fKm4
 0zZRFJqLT2Pe9E6x7z5z8oMEVrR2AxoW6vs5juKin3gT5mPirsaogzLYQws/+2WRGjuj8NuWs7L
 IKXJD6nzDmeHcn4aClsHhdEBtyC3orme0NIVKvtnEkYgywzeXGQRFENzp7nWg+Ngosew3lrpXq7
 ev58x9NvCaBa7YyIHJBmyb2YILOlgkiMPKhFXtceNpzY6NjsMjJ1aSUttDUkU9J3DwUxxtaPn8j
 1fKJ5owlTqABW82zBaGmg/jj7uVRHfJ4Dd/x6TKFp/4dyRaebCK4ljBsD6pz3VOr565yZ9jSfrk
 g9ZLFoalFYeZceEdmC7y1cnJ1C2AF4At6dxCv9QR7ZxbTLD+A8Zurf2wj4hDrqy6DnFoazgIRF/
 LCkNuENri9m26oVutwB4I0+8bd9ifZGNNtRs1YRn4EHx6Qwm/q4Kzz/VHsY/DDQXwN1F40mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=809 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100106

NSS clock controller is needed for supplying clocks and resets to the
networking blocks for the Ethernet functions on the IPQ5424 platforms.

All boards based on the IPQ5424 SoC will require this driver to be enabled.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f56a4ce84db8..b37addde371d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1372,6 +1372,7 @@ CONFIG_IPQ_GCC_5424=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_5424=m
 CONFIG_IPQ_NSSCC_9574=m
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_MMCC_8994=m

-- 
2.34.1


