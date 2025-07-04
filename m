Return-Path: <linux-pm+bounces-30169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ABEAF98EB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE5E3A16D2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CA2E2A22;
	Fri,  4 Jul 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jbbhm7O8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C52D8385
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646986; cv=none; b=qfOWBW9u5gYFupHDJQuDI5SwzNLvSGKNUwbkrWGYRzscBWZ8FDcsvf9vOxYSLixBUJ8Xq3u3YP8T4LnKKpMW2enblu08KGZbqaU9/DD6u4zNlnNB+Cx1wWiNZ+5Hgb2LLJbj2eV6xVXu1NVAmpOzsPazbOXxDzqhLpUwUiBBPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646986; c=relaxed/simple;
	bh=3Xv7ooAmkrDRiDwOwfuSNE143RBjhZuSyTcf+uWMPyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1l2oqAhNFDf6JNqJ7owL0GZv7dA1LnUt0Twc3dEDEi0l4xmgL6NEmqVoy+py+PgYgHsiFd6WnwuGxwsVqsnlc3VWEIJDNn0dF6lgVZMDN6hTySlptJIPOGcIFnESmG//+B4mYSAmIGhbSmSlXdl4AuBVBYH9LOYlXL9g6L/moM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jbbhm7O8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564DQ1x5008123
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nJwcqxQhpB6P4yt0GMuRWoOGKRtDnCgo8+2/hMkms04=; b=Jbbhm7O8JwIfAbyl
	hOtxCfbwsl56Q5RlkTBtpJg21ihmh7+s2ynmcEua7/+l9gk0tu2puGZL5zkycb65
	iWSznylwwRriN9omJDfeAPlf4buSVFoiPyx0cX39ntCEXQQ6A8t979vPTwjVHtL5
	gDeUC0RNzjoTDUAT5bNVgIh7ZJ3f+kGjFrRgkq8+i7/n+SVUY+AQ+Y9JwmdFChKz
	4UzawI6ZElEb8lB575ikOiQ8YYyY7cUXt4qVr6KQ1Wygw23mnpTfbETr0F84UFf6
	09kwrQsFCj0Ak2Hq0x8xPG7u+hRo0b2LduIJV1wC1DDMWeUe7xTcxWoYBiXW3wHY
	h0pvlQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5js1kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:36:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d45e0dbee2so172702685a.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646972; x=1752251772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJwcqxQhpB6P4yt0GMuRWoOGKRtDnCgo8+2/hMkms04=;
        b=pQMtH5rMNf+9QrJz2so62NBW5A6CRk33MnkzjH/Nt3kLzxvc5hrfUBSYkFZGL/pGs2
         162ujHNxlPCbu/rNz/N4+hsJcGwVzKuTCVvSA2aH4fC9qIt8FE6UFDWh1aYnlt4voU8r
         A7gLItyeFypeUD/rIR8UeVjdJdFBe7vmZ4WHr6SWVRHnGdP4sMgyMXhEeMHThIYm+fDp
         rg6NqyxkaME3MHG9CeRh5dZ6gWPwtty6g7w9i5/avaZJZ5r1XRBSGfjlsqTMwojcw2yl
         ZoC7r3tIoyZPlE+O6zyUPVC1kZSr4lCtkXwZpPxYQv17ECSdrGVKGEQ6JwJMUHydWg/T
         BGyw==
X-Forwarded-Encrypted: i=1; AJvYcCVdGYB6VWVOIS5pdSVzMYa8KLE8IB3lPlxGXtrBpEBWzJelKIO3w7wQOiHCsSFYsbjmedANbV6YUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgDVTWjjx+s+DIcQDZnn2UTdAPsxnU28op+hhQv3RIvGcTuIx
	LuwLdPuO+QX/xSGHvaZdKcMXAjQOu91l+qfo0MRuvqN1B2uvbqB04eUSHVDWs8GNIA3cq9CQsem
	XnWLKw1NP9bkRp84m3WJdEr0o3G1gDCNmbptj/yJ0GBvzyI/hwdd+5+KzR+iAlQ==
X-Gm-Gg: ASbGnctXqll6h3Xoew+rJSx5kFje5SRstHRs4fLg/DFlZp5GYNI3bqVnUbKg4dMTUaD
	RMAbx9T/jiAr/TScTzoHvCLBqRspXInSlrvKDU2sANsUfF9nVEMgakZZxp3UT86Mgl/Pcx3G6Vf
	HuBT+feKURRW/S5FoYiiovhPccHk0AHu8yJKA1eOVNKpWj6xWMJOyvgHxvyoCI4B5PYniMin9r/
	XhRG9PUbFQZeJao2wENHSSKjt3bHrB6yeiSX+JlmDyqhm4WuBCYcJiTj3ey+LnJbeycPUs9frAv
	atFJViXSgrl+mbuYg1SzVw+QhQ0oJxffMfvaXll1MAzA4/RKK6m0grdGPmHiI4s3kRh2R2JM6a7
	yxAWN1rCyMzBVHj9ijpbGpj71/wBD8PLI/m4=
X-Received: by 2002:a05:620a:2909:b0:7c5:962b:e87c with SMTP id af79cd13be357-7d5ddc5fe4bmr452182385a.44.1751646971951;
        Fri, 04 Jul 2025 09:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAGKBbzELfHclvtSNXNi4u2ZaeXzkCtPKhcmvU/cKbHxPm/+p+6Q9kaQO3vEjREe47nRCukA==
X-Received: by 2002:a05:620a:2909:b0:7c5:962b:e87c with SMTP id af79cd13be357-7d5ddc5fe4bmr452176285a.44.1751646971229;
        Fri, 04 Jul 2025 09:36:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:36:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:39 +0300
Subject: [PATCH v2 27/28] interconnect: qcom: sm8750: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-27-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=45137;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3Xv7ooAmkrDRiDwOwfuSNE143RBjhZuSyTcf+uWMPyM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALJRyqOdMcBvbrDL9pgJZsfUt0GboyBadUGr
 czVkIPtHAqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCyQAKCRCLPIo+Aiko
 1fRHB/997X6QPBE6SZ3uO9dffLDioge9b4OXnysRb/sw5EM5r7xkrmui3456ZBP857sVKxrLInd
 rY+75T2d/GLEbiOcppsYJmJc71ERCc1OFXLvCx/th5jDf1ep9ZjVYrck8Fq2FVffoyoNQfrdIj3
 0u3W43o9ador6VG5sTprPldQJnSKrHChAL/mzvm7ok5E0qod1gNzEfP7q2+jtsn9skZXyoXqpRn
 d/LGYmPHZK0oYLDjPYf+hkB55whT/L68ZQUjvS/wvR46WaJjQPLfTlSYWcZKP09P8MprP4e8lIq
 DeV90EZxiMjFTr06AaxR4DV5jGQISli0R8Yw/ulUmvjPxMCS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=686802fe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=prURIEE5GSX6ld7tghgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rs1rvvNH2zq3kTOiPMHOklZvXEqcFdHS
X-Proofpoint-GUID: rs1rvvNH2zq3kTOiPMHOklZvXEqcFdHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXxXt5ZtnmG0a+
 grJi20kGSQJrySj41WpVp3cDR6omT0p84w9C3PcNH/HcEwcXgp0QB8M6u1z78RzGxHHVPvy/mfT
 7fFpqszL/CErWip78t7FQP29qyw4JaAUMYnXlnGMLtmJfs2XKKf0aL43ynZXtj6YNRwECwMHIHd
 fEXpMjPc1/tiVlRJoURaTobvX3n4e09tCYUyTwofGxyWDUMuEtqOK32jI2eGSjKmgRaHyyPeFhf
 qsr3q82StEbfk/wH7q6Mqi9FFqM5pbOvcEeQ46+hPSPjtcVK8Cy7qCqyzPaC+43cu7RjmvMHmBl
 5pJqBDYDlBGAvO/c4dMNbWTqWwoqybYtW25YseuAWtZsSHnxPiOnWboCVUqjFnIMo3Ci8kPainl
 jusf4k9PUmVm9F6Qn0x3dh90Kov2vcz/AZzWGsxo8trX/YDjBq9PMOLNfJ+wvnwomQMpCf/Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm8750.c | 736 ++++++++++++++-----------------------
 1 file changed, 280 insertions(+), 456 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
index eba39bf966c27254ca5df43c9acd7435a69726a2..0c9b39ea4f9ec970112f2a9117d16e70a6f41c93 100644
--- a/drivers/interconnect/qcom/sm8750.c
+++ b/drivers/interconnect/qcom/sm8750.c
@@ -14,1181 +14,991 @@
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
 
-#define SM8750_MASTER_GPU_TCU				0
-#define SM8750_MASTER_SYS_TCU				1
-#define SM8750_MASTER_APPSS_PROC			2
-#define SM8750_MASTER_LLCC				3
-#define SM8750_MASTER_QDSS_BAM				4
-#define SM8750_MASTER_QSPI_0				5
-#define SM8750_MASTER_QUP_1				6
-#define SM8750_MASTER_QUP_2				7
-#define SM8750_MASTER_A1NOC_SNOC			8
-#define SM8750_MASTER_A2NOC_SNOC			9
-#define SM8750_MASTER_CAMNOC_HF				10
-#define SM8750_MASTER_CAMNOC_NRT_ICP_SF			11
-#define SM8750_MASTER_CAMNOC_RT_CDM_SF			12
-#define SM8750_MASTER_CAMNOC_SF				13
-#define SM8750_MASTER_GEM_NOC_CNOC			14
-#define SM8750_MASTER_GEM_NOC_PCIE_SNOC			15
-#define SM8750_MASTER_GFX3D				16
-#define SM8750_MASTER_LPASS_GEM_NOC			17
-#define SM8750_MASTER_LPASS_LPINOC			18
-#define SM8750_MASTER_LPIAON_NOC			19
-#define SM8750_MASTER_LPASS_PROC			20
-#define SM8750_MASTER_MDP				21
-#define SM8750_MASTER_MSS_PROC				22
-#define SM8750_MASTER_MNOC_HF_MEM_NOC			23
-#define SM8750_MASTER_MNOC_SF_MEM_NOC			24
-#define SM8750_MASTER_CDSP_PROC				25
-#define SM8750_MASTER_COMPUTE_NOC			26
-#define SM8750_MASTER_ANOC_PCIE_GEM_NOC			27
-#define SM8750_MASTER_SNOC_SF_MEM_NOC			28
-#define SM8750_MASTER_UBWC_P				29
-#define SM8750_MASTER_CDSP_HCP				30
-#define SM8750_MASTER_VIDEO_CV_PROC			31
-#define SM8750_MASTER_VIDEO_EVA				32
-#define SM8750_MASTER_VIDEO_MVP				33
-#define SM8750_MASTER_VIDEO_V_PROC			34
-#define SM8750_MASTER_CNOC_CFG				35
-#define SM8750_MASTER_CNOC_MNOC_CFG			36
-#define SM8750_MASTER_PCIE_ANOC_CFG			37
-#define SM8750_MASTER_QUP_CORE_0			38
-#define SM8750_MASTER_QUP_CORE_1			39
-#define SM8750_MASTER_QUP_CORE_2			40
-#define SM8750_MASTER_CRYPTO				41
-#define SM8750_MASTER_IPA				42
-#define SM8750_MASTER_QUP_3				43
-#define SM8750_MASTER_SOCCP_AGGR_NOC			44
-#define SM8750_MASTER_SP				45
-#define SM8750_MASTER_GIC				46
-#define SM8750_MASTER_PCIE_0				47
-#define SM8750_MASTER_QDSS_ETR				48
-#define SM8750_MASTER_QDSS_ETR_1			49
-#define SM8750_MASTER_SDCC_2				50
-#define SM8750_MASTER_SDCC_4				51
-#define SM8750_MASTER_UFS_MEM				52
-#define SM8750_MASTER_USB3_0				53
-#define SM8750_SLAVE_UBWC_P				54
-#define SM8750_SLAVE_EBI1				55
-#define SM8750_SLAVE_AHB2PHY_SOUTH			56
-#define SM8750_SLAVE_AHB2PHY_NORTH			57
-#define SM8750_SLAVE_AOSS				58
-#define SM8750_SLAVE_CAMERA_CFG				59
-#define SM8750_SLAVE_CLK_CTL				60
-#define SM8750_SLAVE_CRYPTO_0_CFG			61
-#define SM8750_SLAVE_DISPLAY_CFG			62
-#define SM8750_SLAVE_EVA_CFG				63
-#define SM8750_SLAVE_GFX3D_CFG				64
-#define SM8750_SLAVE_I2C				65
-#define SM8750_SLAVE_I3C_IBI0_CFG			66
-#define SM8750_SLAVE_I3C_IBI1_CFG			67
-#define SM8750_SLAVE_IMEM_CFG				68
-#define SM8750_SLAVE_IPA_CFG				69
-#define SM8750_SLAVE_IPC_ROUTER_CFG			70
-#define SM8750_SLAVE_CNOC_MSS				71
-#define SM8750_SLAVE_PCIE_CFG				72
-#define SM8750_SLAVE_PRNG				73
-#define SM8750_SLAVE_QDSS_CFG				74
-#define SM8750_SLAVE_QSPI_0				75
-#define SM8750_SLAVE_QUP_3				76
-#define SM8750_SLAVE_QUP_1				77
-#define SM8750_SLAVE_QUP_2				78
-#define SM8750_SLAVE_SDCC_2				79
-#define SM8750_SLAVE_SDCC_4				80
-#define SM8750_SLAVE_SOCCP				81
-#define SM8750_SLAVE_SPSS_CFG				82
-#define SM8750_SLAVE_TCSR				83
-#define SM8750_SLAVE_TLMM				84
-#define SM8750_SLAVE_TME_CFG				85
-#define SM8750_SLAVE_UFS_MEM_CFG			86
-#define SM8750_SLAVE_USB3_0				87
-#define SM8750_SLAVE_VENUS_CFG				88
-#define SM8750_SLAVE_VSENSE_CTRL_CFG			89
-#define SM8750_SLAVE_A1NOC_SNOC				90
-#define SM8750_SLAVE_A2NOC_SNOC				91
-#define SM8750_SLAVE_APPSS				92
-#define SM8750_SLAVE_GEM_NOC_CNOC			93
-#define SM8750_SLAVE_SNOC_GEM_NOC_SF			94
-#define SM8750_SLAVE_LLCC				95
-#define SM8750_SLAVE_LPASS_GEM_NOC			96
-#define SM8750_SLAVE_LPIAON_NOC_LPASS_AG_NOC		97
-#define SM8750_SLAVE_LPICX_NOC_LPIAON_NOC		98
-#define SM8750_SLAVE_MNOC_HF_MEM_NOC			99
-#define SM8750_SLAVE_MNOC_SF_MEM_NOC			100
-#define SM8750_SLAVE_CDSP_MEM_NOC			101
-#define SM8750_SLAVE_MEM_NOC_PCIE_SNOC			102
-#define SM8750_SLAVE_ANOC_PCIE_GEM_NOC			103
-#define SM8750_SLAVE_CNOC_CFG				104
-#define SM8750_SLAVE_DDRSS_CFG				105
-#define SM8750_SLAVE_CNOC_MNOC_CFG			106
-#define SM8750_SLAVE_PCIE_ANOC_CFG			107
-#define SM8750_SLAVE_QUP_CORE_0				108
-#define SM8750_SLAVE_QUP_CORE_1				109
-#define SM8750_SLAVE_QUP_CORE_2				110
-#define SM8750_SLAVE_BOOT_IMEM				111
-#define SM8750_SLAVE_IMEM				112
-#define SM8750_SLAVE_BOOT_IMEM_2			113
-#define SM8750_SLAVE_SERVICE_CNOC			114
-#define SM8750_SLAVE_SERVICE_MNOC			115
-#define SM8750_SLAVE_SERVICE_PCIE_ANOC			116
-#define SM8750_SLAVE_PCIE_0				117
-#define SM8750_SLAVE_QDSS_STM				118
-#define SM8750_SLAVE_TCU				119
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qxm_qup02;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node qxm_soccp;
+static struct qcom_icc_node qxm_sp;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup2_core_master;
+static struct qcom_icc_node qsm_cfg;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_lpass_gemnoc;
+static struct qcom_icc_node qnm_mdsp;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_nsp_gemnoc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qnm_ubwc_p;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qnm_lpiaon_noc;
+static struct qcom_icc_node qnm_lpass_lpinoc;
+static struct qcom_icc_node qnm_lpinoc_dsp_qns4m;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_nrt_icp_sf;
+static struct qcom_icc_node qnm_camnoc_rt_cdm_sf;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mdp;
+static struct qcom_icc_node qnm_vapss_hcp;
+static struct qcom_icc_node qnm_video_cv_cpu;
+static struct qcom_icc_node qnm_video_eva;
+static struct qcom_icc_node qnm_video_mvp;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qsm_mnoc_cfg;
+static struct qcom_icc_node qnm_nsp;
+static struct qcom_icc_node qsm_pcie_anoc_cfg;
+static struct qcom_icc_node xm_pcie3;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_eva_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_i2c;
+static struct qcom_icc_node qhs_i3c_ibi0_cfg;
+static struct qcom_icc_node qhs_i3c_ibi1_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_pcie_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup02;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qss_mnoc_cfg;
+static struct qcom_icc_node qss_pcie_anoc_cfg;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_soccp;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qns_apss;
+static struct qcom_icc_node qss_cfg;
+static struct qcom_icc_node qss_ddrss_cfg;
+static struct qcom_icc_node qxs_boot_imem;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_modem_boot_imem;
+static struct qcom_icc_node srvc_cnoc_main;
+static struct qcom_icc_node xs_pcie;
+static struct qcom_icc_node chs_ubwc_p;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc;
+static struct qcom_icc_node qns_lpass_aggnoc;
+static struct qcom_icc_node qns_lpi_aon_noc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_pcie_aggre_noc;
+static struct qcom_icc_node qns_gemnoc_sf;
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8750_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8750_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_qup02 = {
 	.name = "qxm_qup02",
-	.id = SM8750_MASTER_QUP_3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8750_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8750_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8750_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8750_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8750_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8750_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8750_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_soccp = {
 	.name = "qxm_soccp",
-	.id = SM8750_MASTER_SOCCP_AGGR_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_sp = {
 	.name = "qxm_sp",
-	.id = SM8750_MASTER_SP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = SM8750_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = SM8750_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8750_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM8750_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM8750_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SM8750_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_node qsm_cfg = {
 	.name = "qsm_cfg",
-	.id = SM8750_MASTER_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 33,
-	.links = { SM8750_SLAVE_AHB2PHY_SOUTH, SM8750_SLAVE_AHB2PHY_NORTH,
-			   SM8750_SLAVE_CAMERA_CFG, SM8750_SLAVE_CLK_CTL,
-			   SM8750_SLAVE_CRYPTO_0_CFG, SM8750_SLAVE_DISPLAY_CFG,
-			   SM8750_SLAVE_EVA_CFG, SM8750_SLAVE_GFX3D_CFG,
-			   SM8750_SLAVE_I2C, SM8750_SLAVE_I3C_IBI0_CFG,
-			   SM8750_SLAVE_I3C_IBI1_CFG, SM8750_SLAVE_IMEM_CFG,
-			   SM8750_SLAVE_CNOC_MSS, SM8750_SLAVE_PCIE_CFG,
-			   SM8750_SLAVE_PRNG, SM8750_SLAVE_QDSS_CFG,
-			   SM8750_SLAVE_QSPI_0, SM8750_SLAVE_QUP_3,
-			   SM8750_SLAVE_QUP_1, SM8750_SLAVE_QUP_2,
-			   SM8750_SLAVE_SDCC_2, SM8750_SLAVE_SDCC_4,
-			   SM8750_SLAVE_SPSS_CFG, SM8750_SLAVE_TCSR,
-			   SM8750_SLAVE_TLMM, SM8750_SLAVE_UFS_MEM_CFG,
-			   SM8750_SLAVE_USB3_0, SM8750_SLAVE_VENUS_CFG,
-			   SM8750_SLAVE_VSENSE_CTRL_CFG, SM8750_SLAVE_CNOC_MNOC_CFG,
-			   SM8750_SLAVE_PCIE_ANOC_CFG, SM8750_SLAVE_QDSS_STM,
-			   SM8750_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+				&qhs_camera_cfg, &qhs_clk_ctl,
+				&qhs_crypto0_cfg, &qhs_display_cfg,
+				&qhs_eva_cfg, &qhs_gpuss_cfg,
+				&qhs_i2c, &qhs_i3c_ibi0_cfg,
+				&qhs_i3c_ibi1_cfg, &qhs_imem_cfg,
+				&qhs_mss_cfg, &qhs_pcie_cfg,
+				&qhs_prng, &qhs_qdss_cfg,
+				&qhs_qspi, &qhs_qup02,
+				&qhs_qup1, &qhs_qup2,
+				&qhs_sdc2, &qhs_sdc4,
+				&qhs_spss_cfg, &qhs_tcsr,
+				&qhs_tlmm, &qhs_ufs_mem_cfg,
+				&qhs_usb3_0, &qhs_venus_cfg,
+				&qhs_vsense_ctrl_cfg, &qss_mnoc_cfg,
+				&qss_pcie_anoc_cfg, &xs_qdss_stm,
+				&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SM8750_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 12,
-	.links = { SM8750_SLAVE_AOSS, SM8750_SLAVE_IPA_CFG,
-			   SM8750_SLAVE_IPC_ROUTER_CFG, SM8750_SLAVE_SOCCP,
-			   SM8750_SLAVE_TME_CFG, SM8750_SLAVE_APPSS,
-			   SM8750_SLAVE_CNOC_CFG, SM8750_SLAVE_DDRSS_CFG,
-			   SM8750_SLAVE_BOOT_IMEM, SM8750_SLAVE_IMEM,
-			   SM8750_SLAVE_BOOT_IMEM_2, SM8750_SLAVE_SERVICE_CNOC },
+	.link_nodes = { &qhs_aoss, &qhs_ipa,
+				&qhs_ipc_router, &qhs_soccp,
+				&qhs_tme_cfg, &qns_apss,
+				&qss_cfg, &qss_ddrss_cfg,
+				&qxs_boot_imem, &qxs_imem,
+				&qxs_modem_boot_imem, &srvc_cnoc_main, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SM8750_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SM8750_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SM8750_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SM8750_MASTER_APPSS_PROC,
 	.channels = 4,
 	.buswidth = 32,
-	.num_links = 4,
-	.links = { SM8750_SLAVE_UBWC_P, SM8750_SLAVE_GEM_NOC_CNOC,
-			   SM8750_SLAVE_LLCC, SM8750_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &chs_ubwc_p, &qns_gem_noc_cnoc,
+				&qns_llcc, &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8750_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_gemnoc = {
 	.name = "qnm_lpass_gemnoc",
-	.id = SM8750_MASTER_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC,
-			   SM8750_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+				&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_mdsp = {
 	.name = "qnm_mdsp",
-	.id = SM8750_MASTER_MSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC,
-			   SM8750_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+				&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8750_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8750_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_nsp_gemnoc = {
 	.name = "qnm_nsp_gemnoc",
-	.id = SM8750_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC,
-			   SM8750_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+				&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8750_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8750_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8750_SLAVE_GEM_NOC_CNOC, SM8750_SLAVE_LLCC,
-			   SM8750_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+				&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_ubwc_p = {
 	.name = "qnm_ubwc_p",
-	.id = SM8750_MASTER_UBWC_P,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8750_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpiaon_noc = {
 	.name = "qnm_lpiaon_noc",
-	.id = SM8750_MASTER_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_LPASS_GEM_NOC },
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_lpinoc = {
 	.name = "qnm_lpass_lpinoc",
-	.id = SM8750_MASTER_LPASS_LPINOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+	.link_nodes = { &qns_lpass_aggnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpinoc_dsp_qns4m = {
 	.name = "qnm_lpinoc_dsp_qns4m",
-	.id = SM8750_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_LPICX_NOC_LPIAON_NOC },
+	.link_nodes = { &qns_lpi_aon_noc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8750_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SM8750_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_nrt_icp_sf = {
 	.name = "qnm_camnoc_nrt_icp_sf",
-	.id = SM8750_MASTER_CAMNOC_NRT_ICP_SF,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_rt_cdm_sf = {
 	.name = "qnm_camnoc_rt_cdm_sf",
-	.id = SM8750_MASTER_CAMNOC_RT_CDM_SF,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SM8750_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
-	.id = SM8750_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_vapss_hcp = {
 	.name = "qnm_vapss_hcp",
-	.id = SM8750_MASTER_CDSP_HCP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
-	.id = SM8750_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_eva = {
 	.name = "qnm_video_eva",
-	.id = SM8750_MASTER_VIDEO_EVA,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_mvp = {
 	.name = "qnm_video_mvp",
-	.id = SM8750_MASTER_VIDEO_MVP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = SM8750_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qsm_mnoc_cfg = {
 	.name = "qsm_mnoc_cfg",
-	.id = SM8750_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_nsp = {
 	.name = "qnm_nsp",
-	.id = SM8750_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qsm_pcie_anoc_cfg = {
 	.name = "qsm_pcie_anoc_cfg",
-	.id = SM8750_MASTER_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_SERVICE_PCIE_ANOC },
+	.link_nodes = { &srvc_pcie_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3 = {
 	.name = "xm_pcie3",
-	.id = SM8750_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8750_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM8750_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8750_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8750_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM8750_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM8750_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SM8750_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM8750_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SM8750_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8750_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8750_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8750_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8750_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_eva_cfg = {
 	.name = "qhs_eva_cfg",
-	.id = SM8750_SLAVE_EVA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8750_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_i2c = {
 	.name = "qhs_i2c",
-	.id = SM8750_SLAVE_I2C,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_i3c_ibi0_cfg = {
 	.name = "qhs_i3c_ibi0_cfg",
-	.id = SM8750_SLAVE_I3C_IBI0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_i3c_ibi1_cfg = {
 	.name = "qhs_i3c_ibi1_cfg",
-	.id = SM8750_SLAVE_I3C_IBI1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8750_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SM8750_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_cfg = {
 	.name = "qhs_pcie_cfg",
-	.id = SM8750_SLAVE_PCIE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM8750_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8750_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8750_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup02 = {
 	.name = "qhs_qup02",
-	.id = SM8750_SLAVE_QUP_3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM8750_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SM8750_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8750_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8750_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SM8750_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8750_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SM8750_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8750_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8750_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8750_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8750_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qss_mnoc_cfg = {
 	.name = "qss_mnoc_cfg",
-	.id = SM8750_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qsm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qss_pcie_anoc_cfg = {
 	.name = "qss_pcie_anoc_cfg",
-	.id = SM8750_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_MASTER_PCIE_ANOC_CFG },
+	.link_nodes = { &qsm_pcie_anoc_cfg, NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8750_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8750_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8750_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8750_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SM8750_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_soccp = {
 	.name = "qhs_soccp",
-	.id = SM8750_SLAVE_SOCCP,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = SM8750_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_apss = {
 	.name = "qns_apss",
-	.id = SM8750_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qss_cfg = {
 	.name = "qss_cfg",
-	.id = SM8750_SLAVE_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8750_MASTER_CNOC_CFG },
+	.link_nodes = { &qsm_cfg, NULL },
 };
 
 static struct qcom_icc_node qss_ddrss_cfg = {
 	.name = "qss_ddrss_cfg",
-	.id = SM8750_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = SM8750_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8750_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_modem_boot_imem = {
 	.name = "qxs_modem_boot_imem",
-	.id = SM8750_SLAVE_BOOT_IMEM_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc_main = {
 	.name = "srvc_cnoc_main",
-	.id = SM8750_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = SM8750_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node chs_ubwc_p = {
 	.name = "chs_ubwc_p",
-	.id = SM8750_SLAVE_UBWC_P,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SM8750_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8750_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SM8750_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
 	.name = "qns_lpass_ag_noc_gemnoc",
-	.id = SM8750_SLAVE_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_LPASS_GEM_NOC },
+	.link_nodes = { &qnm_lpass_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_lpass_aggnoc = {
 	.name = "qns_lpass_aggnoc",
-	.id = SM8750_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_LPIAON_NOC },
+	.link_nodes = { &qnm_lpiaon_noc, NULL },
 };
 
 static struct qcom_icc_node qns_lpi_aon_noc = {
 	.name = "qns_lpi_aon_noc",
-	.id = SM8750_SLAVE_LPICX_NOC_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_LPASS_LPINOC },
+	.link_nodes = { &qnm_lpass_lpinoc, NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8750_SLAVE_EBI1,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8750_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM8750_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8750_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SM8750_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8750_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8750_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8750_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_pcie_aggre_noc = {
 	.name = "srvc_pcie_aggre_noc",
-	.id = SM8750_SLAVE_SERVICE_PCIE_ANOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8750_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8750_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1345,6 +1155,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 };
@@ -1367,6 +1178,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1389,6 +1201,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1438,6 +1251,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1467,6 +1281,7 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_cnoc_main = {
+	.alloc_dyn_id = true,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1500,6 +1315,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1512,6 +1328,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 };
@@ -1526,6 +1343,7 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_lpass_lpiaon_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1538,6 +1356,7 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_lpass_lpicx_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 };
@@ -1553,6 +1372,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1582,6 +1402,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1598,6 +1419,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_nsp_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1616,6 +1438,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1635,6 +1458,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8750_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,

-- 
2.39.5


