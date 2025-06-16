Return-Path: <linux-pm+bounces-28757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0B8ADA52A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D321D7A6B3D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1262676F3;
	Mon, 16 Jun 2025 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uj8GxVmk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EB262FF1
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033789; cv=none; b=iSQDAIntOEiu+F5an578nPpms+NKj5HQzz1i+nX4I4DjF4fpACyY3vyXSsFK4DjiX4SJknQAbP8qXw/kGQ/FRcTradZF/nbCkJN6/vyqchCOK68A2dqD+HR1GAGwaD+ChnBXOnu/oJt3vhHZjydkq+trazEXx9SQVpTOtfqdyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033789; c=relaxed/simple;
	bh=HSieXGnHjEcB0zf/ak11SvXOtbrJHvrHZiCZdZgMyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uM8jFbFrx8/CPGKqq3GjFAEjLom0W0YklfsGz+QO5J/GqetTyjAqhlRo+PeUrlvzZheDs9n9CwH0k6QaLPBCcUal6nZg9ZXQxBL0oPay9kBTAafJNqkUOH52Cdl3w2OUTsNcMSucq8aX4DFHPJOQmX1HFApNnJppAuB7Y2fXjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uj8GxVmk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMmN91004610
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OAffTv+MBsng6vSetPqNs+laSDJ6uKu3jLq5dSPTaLM=; b=Uj8GxVmke4gh/ymx
	v3axcvl3dTiLHVCL3g9wfuzIAVbbpR2qoCyEo4YN4+A0QNkeZG/HamjtqY9p1+De
	9NanuiGjpOy5X7yKC5s4oCNDaIPSiO1to5fF3dic9SXed1tXpTyQBgU5PiGF/DV5
	mNTz81Zom+BT/HGGOHGo6M0g8GY1UQviz9v7XG0GB8UwUB4eDte0NGjCvuVGgNr9
	0ooHUVtJvHfm0Q2cV/Lsa2xTItt5OMQj9TpFhAIQnOQdzGNBj4Neku14N4hsKh8k
	bzJCrco5tu+PN3IKLzsUgYWtdtJkFKxF+5GpfCbOczPaW/pUCqbtw+uaS3HSSdDo
	5t/NMQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfamad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6faf265c3c5so58535606d6.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033784; x=1750638584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAffTv+MBsng6vSetPqNs+laSDJ6uKu3jLq5dSPTaLM=;
        b=TFHBJSyln+aaecAs0EZY86SUvqVRkQEFtG3O30cikdpX62cdqPTHx5RiiYf4Ur9Rbw
         TG7Gj8+ugQrdg5snt+MCUiWK+KkL5tVVLM9W35nqFBw2YsU5BOnMZSyJnbImp7HbdI8t
         9y0jwoWpyB4I8f4VI2nkg8wbz3y6dERsV32bktZZFdj4Mb68WA8YxGwEpneGmYc6JNZd
         IpMIS6kPWiiq10mwJf7nMLR5kO0zDduVJPyD6k+z55t09zl+3THNr7sEppO5Qm7Vhkoi
         1dYbBR7th9VFPI+YEjzaW9/X3Hq54SOwjPT3b33Z3VoothcaF4RLcSOSu0By4iplxgsZ
         xSeA==
X-Forwarded-Encrypted: i=1; AJvYcCUofZCtvb3qIw/h+E9GoBO0B5hiS5tmUCNibKbNrxOH1XmJCitrMZErxHfIxs9KKFcb/DOynee0gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfsQYjvhiliGKZSbUr79aF8FqFz8QoqGdVG2LRN0LRPljQuP4B
	Hx+AOpwtnXT2Yg848iUWI8MqF97jaaLW25ybGB4gS1EPDK1yUKjWf5m27zfMSWIoVwxkOS2E8Xn
	GHlPmiWkhfLBCHoX2Kqk2o4KpG+MbguTUh3pDGXcsoDP54nMQbtLWK95dgsp059K7Umj1NT8D
X-Gm-Gg: ASbGncuNn0fjq/ZmpCCAo6RPJ9VpDoLvs5++s1oshuDFFHAaN9jM8gKWpBH263kVbML
	XQzQVPbvjWfz3paCi32hG8XynjUYSkpg7W/6jWKYY9UyBM/4aL3Z/jm7PGyfeCEZu3Z+Ymya5J3
	wP8e64f0ZiLrlWV7bgNgkmahcWNleXiNnEpGXRlD4urC83go5V7J2TskE5drLa7ZOEScyeN63Gg
	nGVPjsgLcrGV8ghLGxJY6H5wOtveDBjSJtDrRLhf04KgKH62P1Im9TdI7NfM3tdaJoruH91k378
	CcEDlcmAO6EYcbfRgJl7zGW96INGbDe1Wlx+0HwoBM5j6m3jMmQimqskMDXzir2e3yJVSGecV48
	gWIpo3GCo9CZYQ99fveQtW+mv3gUVT/A/G80=
X-Received: by 2002:a05:6214:2307:b0:6f8:b4aa:2a4d with SMTP id 6a1803df08f44-6fb47793608mr130372336d6.31.1750033783320;
        Sun, 15 Jun 2025 17:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ilBaAmE9NA3ITXSXQjLs8X3c3obJclVPv8H9/b2EKdHZ2uPU5SS0G1A6Ue7xmtDJa5Ti0Q==
X-Received: by 2002:a05:6214:2307:b0:6f8:b4aa:2a4d with SMTP id 6a1803df08f44-6fb47793608mr130371996d6.31.1750033782720;
        Sun, 15 Jun 2025 17:29:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:29:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:33 +0300
Subject: [PATCH 21/28] interconnect: qcom: sm7150: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-21-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=49299;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HSieXGnHjEcB0zf/ak11SvXOtbrJHvrHZiCZdZgMyhE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UkFpV7mebnHPPdnOUlxp48jR19JuGOnXmZ0
 K0u56D5zEOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lJAAKCRCLPIo+Aiko
 1Y4OCACdGsuZ8zMjpWKDgnUjyFOVO3V1vVUWINjMof+5xE2YDYOJkY+WmgssPZYkNckrd6aj0IH
 DUpH+/plAFZhUVbl79d8niKszy7NAFzrx50mzIf/H+0g+/8ag7F1gkcx6VksjGGji7lUuDwlzXa
 glmQNSfCT5oy/h7zcDs5MmxTQFzxZBINrYaglPPrMnnX+Kj+7RLrC/4LSLnmnfUM8+wW3Xus3BY
 lgTEC5OKwvdk7vQCHJPUaBcwMQHXxgWvq3HlzZ0+M62huBDp9eI2vqsH2f44rvujVOha0CJq/n+
 WrEgAWgKsLlcoAa4KMWNX514kkUbzot2Kp6Pvs8esN3XsvAx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX80SKlUlUidDk
 todEFDRA750jlLnU0Qj1WX0160aoxZO9Sf1sJcRjLpMfl9aO9afEbegD6KyDAfLkHhrDJ2cC1J3
 nLiJg5TdspSKR3nK+rBl+OMoCEg8ZGlQGPDmeK9qzRiSYy6+X2fgDvdq2T+T1cRXBPOXfaCXtKt
 i2Z/NlZd0zJe3+oMh49Tq24qITRzPAHTJJ8ERH6RrInAmK1161HlC9j4MTRF7DXoRjDMAwrPP0H
 d5y4NDiENrg0HzBVzx04Jq7Wwpqkk2DS8wF5/INz7eFMTsiWwMIQFeAO/bdU3iQEGf07B1MIjlY
 oUJFmz4eFPBdmyXpa4am1usGCb1eej10b/RTvelBdmBg5+pTNvfVc/2EvSr7GOc3QKuUPkJROpG
 ez89525q4P/dPG3VnkzPbUB+xjtnFDEdU8lpdxUn1LQELRuI1zQbIyAddVXXpgioM7i8vvqO
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=684f6579 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=7ibcVnAUAAAA:8 a=tY5jagQ4Fi85YF4Zq0QA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=HywIFdX19-EX8Ph82vJO:22
X-Proofpoint-GUID: oVa_E98vX6itbYXvm3AejMqHDlg7OWKA
X-Proofpoint-ORIG-GUID: oVa_E98vX6itbYXvm3AejMqHDlg7OWKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm7150.c | 790 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sm7150.h | 140 -------
 2 files changed, 385 insertions(+), 545 deletions(-)

diff --git a/drivers/interconnect/qcom/sm7150.c b/drivers/interconnect/qcom/sm7150.c
index 3892e49e614ba189d29d9bb6f278835283bfaac0..5e2b77f3e1d2245ded149add1548e603a1358295 100644
--- a/drivers/interconnect/qcom/sm7150.c
+++ b/drivers/interconnect/qcom/sm7150.c
@@ -14,1171 +14,1141 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sm7150.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qup_center;
+static struct qcom_icc_node qhm_tsif;
+static struct qcom_icc_node xm_emmc;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup_north;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_rt_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qxm_camnoc_nrt_uncomp;
+static struct qcom_icc_node qnm_npu;
+static struct qcom_icc_node qhm_spdm;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc_dc_noc;
+static struct qcom_icc_node acm_apps;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_gpu;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qxm_camnoc_hf;
+static struct qcom_icc_node qxm_camnoc_nrt;
+static struct qcom_icc_node qxm_camnoc_rt;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_mdp1;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qxm_venus0;
+static struct qcom_icc_node qxm_venus1;
+static struct qcom_icc_node qxm_venus_arm9;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_pcie_gemnoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qns_cdsp_gemnoc;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy_north;
+static struct qcom_icc_node qhs_ahb2phy_south;
+static struct qcom_icc_node qhs_ahb2phy_west;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_camera_nrt_thrott_cfg;
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_dsp_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_display_throttle_cfg;
+static struct qcom_icc_node qhs_emmc_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_pcie_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qupv3_center;
+static struct qcom_icc_node qhs_qupv3_north;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spdm;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_north;
+static struct qcom_icc_node qhs_tlmm_south;
+static struct qcom_icc_node qhs_tlmm_west;
+static struct qcom_icc_node qhs_tsif;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_venus_cvp_throttle_cfg;
+static struct qcom_icc_node qhs_venus_throttle_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_gemnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns2_mem_noc;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
-	.name = "qhm-a1noc-cfg",
-	.id = SM7150_MASTER_A1NOC_CFG,
+	.name = "qhm_a1noc_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup_center = {
 	.name = "qhm_qup_center",
-	.id = SM7150_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_tsif = {
 	.name = "qhm_tsif",
-	.id = SM7150_MASTER_TSIF,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emmc = {
 	.name = "xm_emmc",
-	.id = SM7150_MASTER_EMMC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM7150_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM7150_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM7150_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SM7150_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM7150_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup_north = {
 	.name = "qhm_qup_north",
-	.id = SM7150_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SM7150_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM7150_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM7150_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM7150_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM7150_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM7150_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SM7150_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_rt_uncomp = {
 	.name = "qxm_camnoc_rt_uncomp",
-	.id = SM7150_MASTER_CAMNOC_RT_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SM7150_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_nrt_uncomp = {
 	.name = "qxm_camnoc_nrt_uncomp",
-	.id = SM7150_MASTER_CAMNOC_NRT_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SM7150_MASTER_NPU,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qhm_spdm = {
 	.name = "qhm_spdm",
-	.id = SM7150_MASTER_SPDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_CNOC_A2NOC },
+	.link_nodes = { &qns_cnoc_a2noc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SM7150_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 47,
-	.links = { SM7150_SLAVE_TLMM_SOUTH,
-		   SM7150_SLAVE_CAMERA_CFG,
-		   SM7150_SLAVE_SDCC_4,
-		   SM7150_SLAVE_SDCC_2,
-		   SM7150_SLAVE_CNOC_MNOC_CFG,
-		   SM7150_SLAVE_UFS_MEM_CFG,
-		   SM7150_SLAVE_QUP_0,
-		   SM7150_SLAVE_GLM,
-		   SM7150_SLAVE_PDM,
-		   SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SM7150_SLAVE_A2NOC_CFG,
-		   SM7150_SLAVE_QDSS_CFG,
-		   SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SM7150_SLAVE_DISPLAY_CFG,
-		   SM7150_SLAVE_PCIE_CFG,
-		   SM7150_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SM7150_SLAVE_TCSR,
-		   SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG,
-		   SM7150_SLAVE_CNOC_DDRSS,
-		   SM7150_SLAVE_AHB2PHY_NORTH,
-		   SM7150_SLAVE_SNOC_CFG,
-		   SM7150_SLAVE_GRAPHICS_3D_CFG,
-		   SM7150_SLAVE_VENUS_CFG,
-		   SM7150_SLAVE_TSIF,
-		   SM7150_SLAVE_CDSP_CFG,
-		   SM7150_SLAVE_CLK_CTL,
-		   SM7150_SLAVE_AOP,
-		   SM7150_SLAVE_QUP_1,
-		   SM7150_SLAVE_AHB2PHY_SOUTH,
-		   SM7150_SLAVE_SERVICE_CNOC,
-		   SM7150_SLAVE_AHB2PHY_WEST,
-		   SM7150_SLAVE_USB3,
-		   SM7150_SLAVE_VENUS_THROTTLE_CFG,
-		   SM7150_SLAVE_IPA_CFG,
-		   SM7150_SLAVE_RBCPR_CX_CFG,
-		   SM7150_SLAVE_TLMM_WEST,
-		   SM7150_SLAVE_A1NOC_CFG,
-		   SM7150_SLAVE_AOSS,
-		   SM7150_SLAVE_PRNG,
-		   SM7150_SLAVE_VSENSE_CTRL_CFG,
-		   SM7150_SLAVE_EMMC_CFG,
-		   SM7150_SLAVE_SPDM_WRAPPER,
-		   SM7150_SLAVE_CRYPTO_0_CFG,
-		   SM7150_SLAVE_PIMEM_CFG,
-		   SM7150_SLAVE_TLMM_NORTH,
-		   SM7150_SLAVE_RBCPR_MX_CFG,
-		   SM7150_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_tlmm_south,
+			&qhs_camera_cfg,
+			&qhs_sdc4,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_qupv3_center,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_camera_nrt_thrott_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_display_cfg,
+			&qhs_pcie_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_tcsr,
+			&qhs_venus_cvp_throttle_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ahb2phy_north,
+			&qhs_snoc_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_compute_dsp_cfg,
+			&qhs_clk_ctl,
+			&qhs_aop,
+			&qhs_qupv3_north,
+			&qhs_ahb2phy_south,
+			&srvc_cnoc,
+			&qhs_ahb2phy_west,
+			&qhs_usb3_0,
+			&qhs_venus_throttle_cfg,
+			&qhs_ipa,
+			&qhs_cpr_cx,
+			&qhs_tlmm_west,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_emmc_cfg,
+			&qhs_spdm,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_tlmm_north,
+			&qhs_cpr_mx,
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM7150_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 48,
-	.links = { SM7150_SLAVE_TLMM_SOUTH,
-		   SM7150_SLAVE_CAMERA_CFG,
-		   SM7150_SLAVE_SDCC_4,
-		   SM7150_SLAVE_SDCC_2,
-		   SM7150_SLAVE_CNOC_MNOC_CFG,
-		   SM7150_SLAVE_UFS_MEM_CFG,
-		   SM7150_SLAVE_QUP_0,
-		   SM7150_SLAVE_GLM,
-		   SM7150_SLAVE_PDM,
-		   SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SM7150_SLAVE_A2NOC_CFG,
-		   SM7150_SLAVE_QDSS_CFG,
-		   SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SM7150_SLAVE_DISPLAY_CFG,
-		   SM7150_SLAVE_PCIE_CFG,
-		   SM7150_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SM7150_SLAVE_TCSR,
-		   SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG,
-		   SM7150_SLAVE_CNOC_DDRSS,
-		   SM7150_SLAVE_CNOC_A2NOC,
-		   SM7150_SLAVE_AHB2PHY_NORTH,
-		   SM7150_SLAVE_SNOC_CFG,
-		   SM7150_SLAVE_GRAPHICS_3D_CFG,
-		   SM7150_SLAVE_VENUS_CFG,
-		   SM7150_SLAVE_TSIF,
-		   SM7150_SLAVE_CDSP_CFG,
-		   SM7150_SLAVE_CLK_CTL,
-		   SM7150_SLAVE_AOP,
-		   SM7150_SLAVE_QUP_1,
-		   SM7150_SLAVE_AHB2PHY_SOUTH,
-		   SM7150_SLAVE_SERVICE_CNOC,
-		   SM7150_SLAVE_AHB2PHY_WEST,
-		   SM7150_SLAVE_USB3,
-		   SM7150_SLAVE_VENUS_THROTTLE_CFG,
-		   SM7150_SLAVE_IPA_CFG,
-		   SM7150_SLAVE_RBCPR_CX_CFG,
-		   SM7150_SLAVE_TLMM_WEST,
-		   SM7150_SLAVE_A1NOC_CFG,
-		   SM7150_SLAVE_AOSS,
-		   SM7150_SLAVE_PRNG,
-		   SM7150_SLAVE_VSENSE_CTRL_CFG,
-		   SM7150_SLAVE_EMMC_CFG,
-		   SM7150_SLAVE_SPDM_WRAPPER,
-		   SM7150_SLAVE_CRYPTO_0_CFG,
-		   SM7150_SLAVE_PIMEM_CFG,
-		   SM7150_SLAVE_TLMM_NORTH,
-		   SM7150_SLAVE_RBCPR_MX_CFG,
-		   SM7150_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_tlmm_south,
+			&qhs_camera_cfg,
+			&qhs_sdc4,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_qupv3_center,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_camera_nrt_thrott_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_display_cfg,
+			&qhs_pcie_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_tcsr,
+			&qhs_venus_cvp_throttle_cfg,
+			&qhs_ddrss_cfg,
+			&qns_cnoc_a2noc,
+			&qhs_ahb2phy_north,
+			&qhs_snoc_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_compute_dsp_cfg,
+			&qhs_clk_ctl,
+			&qhs_aop,
+			&qhs_qupv3_north,
+			&qhs_ahb2phy_south,
+			&srvc_cnoc,
+			&qhs_ahb2phy_west,
+			&qhs_usb3_0,
+			&qhs_venus_throttle_cfg,
+			&qhs_ipa,
+			&qhs_cpr_cx,
+			&qhs_tlmm_west,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_emmc_cfg,
+			&qhs_spdm,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_tlmm_north,
+			&qhs_cpr_mx,
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SM7150_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC_CFG,
-		   SM7150_SLAVE_GEM_NOC_CFG
-	},
+	.link_nodes = { &qhs_llcc,
+			&qhs_gemnoc, NULL },
 };
 
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
-	.id = SM7150_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC,
-		   SM7150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = SM7150_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC,
-		   SM7150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SM7150_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_SERVICE_GEM_NOC,
-		   SM7150_SLAVE_MSS_PROC_MS_MPU_CFG
-	},
+	.link_nodes = { &srvc_gemnoc,
+			&qhs_mdsp_ms_mpu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM7150_MASTER_COMPUTE_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC,
-		   SM7150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM7150_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM7150_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC,
-		   SM7150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM7150_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC,
-		   SM7150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM7150_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM7150_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
-	.id = SM7150_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_LLCC,
-		   SM7150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM7150_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SM7150_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
-	.id = SM7150_MASTER_CAMNOC_HF0,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_nrt = {
 	.name = "qxm_camnoc_nrt",
-	.id = SM7150_MASTER_CAMNOC_NRT,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_rt = {
 	.name = "qxm_camnoc_rt",
-	.id = SM7150_MASTER_CAMNOC_RT,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SM7150_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM7150_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SM7150_MASTER_MDP_PORT1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SM7150_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = SM7150_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus1 = {
 	.name = "qxm_venus1",
-	.id = SM7150_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = SM7150_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SM7150_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM7150_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 6,
-	.links = { SM7150_SLAVE_SNOC_GEM_NOC_SF,
-		   SM7150_SLAVE_PIMEM,
-		   SM7150_SLAVE_OCIMEM,
-		   SM7150_SLAVE_APPSS,
-		   SM7150_SNOC_CNOC_SLV,
-		   SM7150_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qns_gemnoc_sf,
+			&qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM7150_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 7,
-	.links = { SM7150_SLAVE_SNOC_GEM_NOC_SF,
-		   SM7150_SLAVE_PIMEM,
-		   SM7150_SLAVE_OCIMEM,
-		   SM7150_SLAVE_APPSS,
-		   SM7150_SNOC_CNOC_SLV,
-		   SM7150_SLAVE_TCU,
-		   SM7150_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qns_gemnoc_sf,
+			&qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = SM7150_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 6,
-	.links = { SM7150_SLAVE_PIMEM,
-		   SM7150_SLAVE_OCIMEM,
-		   SM7150_SLAVE_APPSS,
-		   SM7150_SNOC_CNOC_SLV,
-		   SM7150_SLAVE_TCU,
-		   SM7150_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SM7150_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_SNOC_GEM_NOC_GC,
-		   SM7150_SLAVE_OCIMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM7150_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM7150_SLAVE_SNOC_GEM_NOC_GC,
-		   SM7150_SLAVE_OCIMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM7150_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM7150_A1NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM7150_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM7150_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM7150_A2NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_gemnoc = {
 	.name = "qns_pcie_gemnoc",
-	.id = SM7150_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM7150_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SM7150_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cdsp_gemnoc = {
 	.name = "qns_cdsp_gemnoc",
-	.id = SM7150_SLAVE_CDSP_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SM7150_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SM7150_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_north = {
 	.name = "qhs_ahb2phy_north",
-	.id = SM7150_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_south = {
 	.name = "qhs_ahb2phy_south",
-	.id = SM7150_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_west = {
 	.name = "qhs_ahb2phy_west",
-	.id = SM7150_SLAVE_AHB2PHY_WEST,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SM7150_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM7150_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM7150_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_nrt_thrott_cfg = {
 	.name = "qhs_camera_nrt_thrott_cfg",
-	.id = SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
-	.id = SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM7150_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_dsp_cfg = {
 	.name = "qhs_compute_dsp_cfg",
-	.id = SM7150_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM7150_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM7150_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM7150_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SM7150_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM7150_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_throttle_cfg = {
 	.name = "qhs_display_throttle_cfg",
-	.id = SM7150_SLAVE_DISPLAY_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emmc_cfg = {
 	.name = "qhs_emmc_cfg",
-	.id = SM7150_SLAVE_EMMC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SM7150_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM7150_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM7150_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM7150_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SM7150_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_cfg = {
 	.name = "qhs_pcie_cfg",
-	.id = SM7150_SLAVE_PCIE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM7150_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM7150_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM7150_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM7150_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_center = {
 	.name = "qhs_qupv3_center",
-	.id = SM7150_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_north = {
 	.name = "qhs_qupv3_north",
-	.id = SM7150_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM7150_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM7150_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SM7150_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_spdm = {
 	.name = "qhs_spdm",
-	.id = SM7150_SLAVE_SPDM_WRAPPER,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM7150_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_north = {
 	.name = "qhs_tlmm_north",
-	.id = SM7150_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_south = {
 	.name = "qhs_tlmm_south",
-	.id = SM7150_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_west = {
 	.name = "qhs_tlmm_west",
-	.id = SM7150_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tsif = {
 	.name = "qhs_tsif",
-	.id = SM7150_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM7150_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM7150_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM7150_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
 	.name = "qhs_venus_cvp_throttle_cfg",
-	.id = SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_throttle_cfg = {
 	.name = "qhs_venus_throttle_cfg",
-	.id = SM7150_SLAVE_VENUS_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM7150_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SM7150_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc, NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM7150_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gemnoc = {
 	.name = "qhs_gemnoc",
-	.id = SM7150_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM7150_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM7150_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SM7150_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SM7150_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM7150_SLAVE_LLCC,
 	.channels = 2,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM7150_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SM7150_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM7150_SLAVE_EBI_CH0,
 	.channels = 2,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns2_mem_noc = {
 	.name = "qns2_mem_noc",
-	.id = SM7150_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM7150_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM7150_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM7150_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM7150_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SM7150_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_SNOC_CNOC_MAS },
+	.link_nodes = { &qnm_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM7150_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM7150_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM7150_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM7150_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM7150_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM7150_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM7150_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM7150_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM7150_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1414,6 +1384,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1443,6 +1414,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1462,6 +1434,7 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_camnoc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1479,6 +1452,7 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1544,6 +1518,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1560,6 +1535,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1591,6 +1567,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1608,6 +1585,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1639,6 +1617,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1675,6 +1654,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm7150_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm7150.h b/drivers/interconnect/qcom/sm7150.h
deleted file mode 100644
index e00a9b0c1279367890e01e2a4108aef7c5cd7580..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm7150.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Qualcomm #define SM7150 interconnect IDs
- *
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM7150_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM7150_H
-
-#define SM7150_A1NOC_SNOC_MAS			0
-#define SM7150_A1NOC_SNOC_SLV			1
-#define SM7150_A2NOC_SNOC_MAS			2
-#define SM7150_A2NOC_SNOC_SLV			3
-#define SM7150_MASTER_A1NOC_CFG			4
-#define SM7150_MASTER_A2NOC_CFG			5
-#define SM7150_MASTER_AMPSS_M0			6
-#define SM7150_MASTER_CAMNOC_HF0		7
-#define SM7150_MASTER_CAMNOC_HF0_UNCOMP		8
-#define SM7150_MASTER_CAMNOC_NRT		9
-#define SM7150_MASTER_CAMNOC_NRT_UNCOMP		10
-#define SM7150_MASTER_CAMNOC_RT			11
-#define SM7150_MASTER_CAMNOC_RT_UNCOMP		12
-#define SM7150_MASTER_CAMNOC_SF			13
-#define SM7150_MASTER_CAMNOC_SF_UNCOMP		14
-#define SM7150_MASTER_CNOC_A2NOC		15
-#define SM7150_MASTER_CNOC_DC_NOC		16
-#define SM7150_MASTER_CNOC_MNOC_CFG		17
-#define SM7150_MASTER_COMPUTE_NOC		18
-#define SM7150_MASTER_CRYPTO_CORE_0		19
-#define SM7150_MASTER_EMMC			20
-#define SM7150_MASTER_GEM_NOC_CFG		21
-#define SM7150_MASTER_GEM_NOC_PCIE_SNOC		22
-#define SM7150_MASTER_GEM_NOC_SNOC		23
-#define SM7150_MASTER_GIC			24
-#define SM7150_MASTER_GRAPHICS_3D		25
-#define SM7150_MASTER_IPA			26
-#define SM7150_MASTER_LLCC			27
-#define SM7150_MASTER_MDP_PORT0			28
-#define SM7150_MASTER_MDP_PORT1			29
-#define SM7150_MASTER_MNOC_HF_MEM_NOC		30
-#define SM7150_MASTER_MNOC_SF_MEM_NOC		31
-#define SM7150_MASTER_NPU			32
-#define SM7150_MASTER_PCIE			33
-#define SM7150_MASTER_PIMEM			34
-#define SM7150_MASTER_QDSS_BAM			35
-#define SM7150_MASTER_QDSS_DAP			36
-#define SM7150_MASTER_QDSS_ETR			37
-#define SM7150_MASTER_QUP_0			38
-#define SM7150_MASTER_QUP_1			39
-#define SM7150_MASTER_ROTATOR			40
-#define SM7150_MASTER_SDCC_2			41
-#define SM7150_MASTER_SDCC_4			42
-#define SM7150_MASTER_SNOC_CFG			43
-#define SM7150_MASTER_SNOC_GC_MEM_NOC		44
-#define SM7150_MASTER_SNOC_SF_MEM_NOC		45
-#define SM7150_MASTER_SPDM			46
-#define SM7150_MASTER_SYS_TCU			47
-#define SM7150_MASTER_TSIF			48
-#define SM7150_MASTER_UFS_MEM			49
-#define SM7150_MASTER_USB3			50
-#define SM7150_MASTER_VIDEO_P0			51
-#define SM7150_MASTER_VIDEO_P1			52
-#define SM7150_MASTER_VIDEO_PROC		53
-#define SM7150_SLAVE_A1NOC_CFG			54
-#define SM7150_SLAVE_A2NOC_CFG			55
-#define SM7150_SLAVE_AHB2PHY_NORTH		56
-#define SM7150_SLAVE_AHB2PHY_SOUTH		57
-#define SM7150_SLAVE_AHB2PHY_WEST		58
-#define SM7150_SLAVE_ANOC_PCIE_GEM_NOC		59
-#define SM7150_SLAVE_AOP			60
-#define SM7150_SLAVE_AOSS			61
-#define SM7150_SLAVE_APPSS			62
-#define SM7150_SLAVE_CAMERA_CFG			63
-#define SM7150_SLAVE_CAMERA_NRT_THROTTLE_CFG	64
-#define SM7150_SLAVE_CAMERA_RT_THROTTLE_CFG	65
-#define SM7150_SLAVE_CAMNOC_UNCOMP		66
-#define SM7150_SLAVE_CDSP_CFG			67
-#define SM7150_SLAVE_CDSP_GEM_NOC		68
-#define SM7150_SLAVE_CLK_CTL			69
-#define SM7150_SLAVE_CNOC_A2NOC			70
-#define SM7150_SLAVE_CNOC_DDRSS			71
-#define SM7150_SLAVE_CNOC_MNOC_CFG		72
-#define SM7150_SLAVE_CRYPTO_0_CFG		73
-#define SM7150_SLAVE_DISPLAY_CFG		74
-#define SM7150_SLAVE_DISPLAY_THROTTLE_CFG	75
-#define SM7150_SLAVE_EBI_CH0			76
-#define SM7150_SLAVE_EMMC_CFG			77
-#define SM7150_SLAVE_GEM_NOC_CFG		78
-#define SM7150_SLAVE_GEM_NOC_SNOC		79
-#define SM7150_SLAVE_GLM			80
-#define SM7150_SLAVE_GRAPHICS_3D_CFG		81
-#define SM7150_SLAVE_IMEM_CFG			82
-#define SM7150_SLAVE_IPA_CFG			83
-#define SM7150_SLAVE_LLCC			84
-#define SM7150_SLAVE_LLCC_CFG			85
-#define SM7150_SLAVE_MNOC_HF_MEM_NOC		86
-#define SM7150_SLAVE_MNOC_SF_MEM_NOC		87
-#define SM7150_SLAVE_MSS_PROC_MS_MPU_CFG	88
-#define SM7150_SLAVE_OCIMEM			89
-#define SM7150_SLAVE_PCIE_CFG			90
-#define SM7150_SLAVE_PDM			91
-#define SM7150_SLAVE_PIMEM			92
-#define SM7150_SLAVE_PIMEM_CFG			93
-#define SM7150_SLAVE_PRNG			94
-#define SM7150_SLAVE_QDSS_CFG			95
-#define SM7150_SLAVE_QDSS_STM			96
-#define SM7150_SLAVE_QUP_0			97
-#define SM7150_SLAVE_QUP_1			98
-#define SM7150_SLAVE_RBCPR_CX_CFG		99
-#define SM7150_SLAVE_RBCPR_MX_CFG		100
-#define SM7150_SLAVE_SDCC_2			101
-#define SM7150_SLAVE_SDCC_4			102
-#define SM7150_SLAVE_SERVICE_A1NOC		103
-#define SM7150_SLAVE_SERVICE_A2NOC		104
-#define SM7150_SLAVE_SERVICE_CNOC		105
-#define SM7150_SLAVE_SERVICE_GEM_NOC		106
-#define SM7150_SLAVE_SERVICE_MNOC		107
-#define SM7150_SLAVE_SERVICE_SNOC		108
-#define SM7150_SLAVE_SNOC_CFG			109
-#define SM7150_SLAVE_SNOC_GEM_NOC_GC		110
-#define SM7150_SLAVE_SNOC_GEM_NOC_SF		111
-#define SM7150_SLAVE_SPDM_WRAPPER		112
-#define SM7150_SLAVE_TCSR			113
-#define SM7150_SLAVE_TCU			114
-#define SM7150_SLAVE_TLMM_NORTH			115
-#define SM7150_SLAVE_TLMM_SOUTH			116
-#define SM7150_SLAVE_TLMM_WEST			117
-#define SM7150_SLAVE_TSIF			118
-#define SM7150_SLAVE_UFS_MEM_CFG		119
-#define SM7150_SLAVE_USB3			120
-#define SM7150_SLAVE_VENUS_CFG			121
-#define SM7150_SLAVE_VENUS_CVP_THROTTLE_CFG	122
-#define SM7150_SLAVE_VENUS_THROTTLE_CFG		123
-#define SM7150_SLAVE_VSENSE_CTRL_CFG		124
-#define SM7150_SNOC_CNOC_MAS			125
-#define SM7150_SNOC_CNOC_SLV			126
-
-#endif

-- 
2.39.5


