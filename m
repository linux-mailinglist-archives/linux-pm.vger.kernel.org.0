Return-Path: <linux-pm+bounces-28762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC0ADA537
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E91F16D6B2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62B283CBE;
	Mon, 16 Jun 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brYB+bhh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580E35972
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033812; cv=none; b=sbOHMhwgQTjLrpYg0v8aPtj9gBJ+q9x+3W9WMFfPt+CXm01vdaGsOKXyXKt+7g59DZHJodicNQ0+IvlkQrN8PRH1dum8hoiTJmpW/CzfcMlNfvVK1nZ314IsjZjNPM35OzsZHUIoJmohM5PahXbbzsoFIA1fBnRDV9QASqyRhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033812; c=relaxed/simple;
	bh=3Xv7ooAmkrDRiDwOwfuSNE143RBjhZuSyTcf+uWMPyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlRnN8335uGgfflelgShUPC9T/6Y3PvC+4ujEEi00frYBZFvyb2qhDwXMSYxU1adJYyGNL7OneQ3IggMOM8tfzmj5AnrzJQ0duoLysR2uhc08Ge5+An8vtNbNrBf5guXkjZw6uFVjkF30xV3QV4tYn1iM4UDQm68SAl7Pm4D7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brYB+bhh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMPRN8025618
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nJwcqxQhpB6P4yt0GMuRWoOGKRtDnCgo8+2/hMkms04=; b=brYB+bhhY+NHmdaR
	1slFgotTSUM8ElXodRcM4KpYMvN0Lwxa9L1aFFic+KOUwntIDJghclZLk8kGquaJ
	HxjIIPfTRnn2xCyGzRC+eeGFb1gwn/7hM3HBAb1fnT66qUzZofs+VkqmB9bKnjL2
	t8BPFNYDatH4NQvAnYptBRSsqenCanSeU1tEis+B9I7YcSdXSvJNk7eUFS260ghX
	XiPLzgbuxAmEv21oGRD0TJ9hwNDaYA/cnHNw3Mqx+G1B0qkRyL2Q88cM9m4L+WYg
	xQ/tp8fBqtty5ZHuc4aJTu2J8qJbT+T7ZxuKWQBdkXjnTJKx3MzEA4nxeGJeK3Bu
	sNNDqQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791ugahuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:30:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6faeebe9c5bso34744776d6.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033806; x=1750638606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJwcqxQhpB6P4yt0GMuRWoOGKRtDnCgo8+2/hMkms04=;
        b=Au2EE8+2RQ7+3lJs53h6sXJOPoLeCOo4dD4uNcxJlYqfcttV067d37pOw1ITh6tohS
         6LGu0tWmfIPSXA4NtlmAE/j1I7GQ5OzLI1BLOt9dsXb6HzFt/QHjjs+gmZrp3XXKCRWI
         WTvzPMViPBJ0LqK9u3MDiVHubX4+EudxPJZW+5rFsZUVWcWYgs774tYKuYHQaBqpTt9b
         pmsUD8LK50k6f6UmGc6BXluReFUvHXCtGYmfF6pqVbMyxjkobh75p2pLMd79CTc2JxQv
         2ZTpnG9eDrXhiAZpYCuuq+UqS2Z13UG9baB+9iCZv9CPZD5MVSa2mH+dPqqVldjmY5wJ
         lKQA==
X-Forwarded-Encrypted: i=1; AJvYcCVds9KY9+9O92LORaP+fgOxuRarDB00sc8+9zbZw16GXhp1O3OEX2wz8Ly/q+jtb0iXKcZ8TEQxmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7IlkU0DK4SijBhI9sJ2Svwi6+sIkq432UOqrnv5haw6nhHZ5t
	v72IJ9OkqBr91vU1oyCwCbyGaguIBxo0RgOxf7nsyc87PM7RVEyNVaV5cnNVzapHE2HeDAimOuw
	yP2KMTIkRB4tLkzm8SBu59hTjibKLwr0W9oa7quWi3yxvfc6QviZ2wyxATsXS3A==
X-Gm-Gg: ASbGncuPH0x5pU+Tfi7ROd9FkA8PbG7JTboz22hEHYmHZeC84/3yI7lPbI6IkZs13pc
	xGi5OesHFv0ZbNmN7NDqg5ZzENApXpsvKxkSR6J0IT1geq08z8zBlke59MElm/OSmabqiev8eiB
	kP1ykooXGs67o1zk2YGIFv2uAEW1UdHJ8zv/rZ3IfVszvKWHB1dvZcsZ496etd6QCV8g3vAg7Un
	5+Eo1eRyKDyhD5QBwcbXV9rUyZjDYfgA8PySLl2pj9TMqrphSefe5WHEqCh/rU7+4MeTDswwVw1
	w2Wm9JNI1Z1ldxZ3kIHuXpsivIu9wObVe1F3EYiVltR5ZqRUxxXt9XC3Jh/qh566w/8D0SZzl9K
	ljq9+1l523hdRnWko0G3TqgxGIt2sDbRpUJE=
X-Received: by 2002:a05:6214:4b10:b0:6fb:1c3:f527 with SMTP id 6a1803df08f44-6fb47798242mr108007966d6.39.1750033804739;
        Sun, 15 Jun 2025 17:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4lpmUAXGHdMeVyM5BqQgUGiZ7E9ovb2cP0vbYKdxlbq1WED0EvkQIc+7SHw0l0AIDm+ke8g==
X-Received: by 2002:a05:6214:4b10:b0:6fb:1c3:f527 with SMTP id 6a1803df08f44-6fb47798242mr108007426d6.39.1750033804180;
        Sun, 15 Jun 2025 17:30:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:30:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:39 +0300
Subject: [PATCH 27/28] interconnect: qcom: sm8750: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-27-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=45137;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3Xv7ooAmkrDRiDwOwfuSNE143RBjhZuSyTcf+uWMPyM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UlKJLXWeWZgRagq4+Xkmg1RNTH/xx+Z36FU
 ROnsvSRK4KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lJQAKCRCLPIo+Aiko
 1Rv4B/wKM7cu8E7cLv94kWL6vw4sRmhVAkeVI0xElaFGBEmoCEaK87BcGvix3sCe9/ehtNbheN4
 G6rHGdqkkW0WdQczX0o0l5Zdcj2tDvmxB44WZWXaA2G6vQNVx6IQEde2Tjpjxco1HzmQnR4POvT
 +b3uqtzv6W0rBcDsN/Zcpt3H6eSigz1Qypv4tfm4vOxTzK4iJlh4zSoZQM8wf5iwguz1aPEBGK/
 4gdjx6wh6hjh+7luV8fykYceN0r0btSHLgMdqJY2vLKfcpGRkgoTgUeLN/ki3CzaQeXWVP0dHUc
 J5BVPHm1VMPG4DghxGP6PMmGGmLqutrHpkLpHjMm2fyTH7FL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfXxaNEgq8ZOW6O
 4s/bulTSCZMXZTvCkbSFNKYxj9uIqqxyUHpZhI0rT21EJnq3t0ImrOuHQ2O3rCWOefIoOWy2VtQ
 7K6ygmssYoN1SLJSolITj4M/SztoIHf+7ivtlmavZD8IG7NTtTNn4Wn9HdLBwNBjRxcPiHxtJr6
 h8XEvCm+Qn+T+gSrvzrBJGuoemZIKF+dPTUTVorH1Mb6UKEYHnWDgRW/KRwSTM3d1O9v3FpNjvI
 Mk/y4X+CzbdePYIeqoNVuj0mJhgRF+MLUDej3OGSpf+0dIRk9iDBk4v8DL0bs4wrsRxsFz7EEUL
 6Msscw6JuoF7UND6KaPe12jr4JNn0YTQyVMMRaE8pyQPu70LA6pmeaXF8WYL7tA584KJ42vZVEl
 a3mHaCS/Ki9M3T6UZZXhIkY/+JTRvugNx6OUqNNzjElhODCFvXw04fUrUdqBqBwl39LXjdxG
X-Proofpoint-GUID: fZXPaGabGE79bhHYiRvfcaIH8jZcSWnT
X-Authority-Analysis: v=2.4 cv=NtnRc9dJ c=1 sm=1 tr=0 ts=684f658f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=prURIEE5GSX6ld7tghgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: fZXPaGabGE79bhHYiRvfcaIH8jZcSWnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160001

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


