Return-Path: <linux-pm+bounces-30153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6EAF9899
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735A41C4812D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB362E5B24;
	Fri,  4 Jul 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dp9MMXOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1A31551B
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646951; cv=none; b=GmQgY+SGNcrbP0KBFa2bM+srSfHx+JwanG40PbUqLRv8tuolV6GUB10vAr4D+aJHQemrjqxrCs9gQLLktwvbrdRSjNcOb67Bqn//rMMAlnsSBiIaYkLYvSGTFaJ+wY9Cimk/KvoT7/G+X6uWY8fbjOqjexQJZkY2A0Z8Nibghhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646951; c=relaxed/simple;
	bh=a6uCbAYyTDvRq2c8q2evsWyUPYJ5FD3vK7Gv2UWSlbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9xjp0rrJHTvMayoI5scv7r6xBX6cI5N4oJJ7Wd3G0ZDWRuVTfdY6fVl3CgA3ffLMAoyOKdpm3mL958nAnxdF6SwsH4dJAL53rLoPVJStb3CarXBulkNDNVJS2VgZCRAMYCzQs2nJ/AyrnHpSAfipG8p9SwCoVYnahUb3W4m2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dp9MMXOO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564B63TH019931
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vxb6SM7+Tisn0E7b8m6TXEw/NPmDaD0i+8SQn+rGCNY=; b=dp9MMXOON4acanKo
	jlLcVM2vqq04yaMEwsyJWiPd8hZfToJXXitYiye5vb6WLYFxzCmAN15imnoaGYvx
	M7tzV3Bh8f/0L6Nx1Gd41qf16zP3xE65hHcWgxxpG4dDoaE16AW25wol7O7baUc4
	6ojm6G3j0VtmkmicV96Y7S1KrOwHVcn+/fHuGEfg5sN0lbmHBVh3tLXmLUWbThks
	jngyGIX1w0U2GqUY95c74v/9WZpNwgzUcfEMFHyMZCV75uufmnAHbagLUyphuk+2
	vS6OpEXympzIRpbvZ5Ol7R2/yf+ezfRct1ZMQWXkF0As4+6EmIqRfVvk8+GF+it+
	oLB5Xw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pdsh8t0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d44ff55c98so199213685a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646943; x=1752251743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxb6SM7+Tisn0E7b8m6TXEw/NPmDaD0i+8SQn+rGCNY=;
        b=VHKk6RPCP5/isf/K1q85G8wC0JF9+N683dN2rCNwGMuRhe3+8Y9O6D5RyYFWQ6EVkd
         aj87XUp4kXsXfKYCy7eHHMa2V/Ft06T5SAAcmDm1cJhAPREYXwlGxB42D+sqncAFoGgy
         QZgenD8S17Vq61LgJ+n1T+sHzorNL4RSBw/WEc2f5nxrtLczxWhhvbWkOiviKeIOKPBF
         GXgKIuI1V5Mz2r1b1nw+qzVMk/gDrAqaSGYN+sT16I/1hRwjcn2f+/tzw1rg6bm+SGYX
         6GeLNSfKwOyQgDDjsTKoFeBH6/gvv2PGvnmrCM+J3Ud/qdTWuCEH6cwQ45RS10Or+Gj/
         TcTg==
X-Forwarded-Encrypted: i=1; AJvYcCWyvYQAq5BefV32oBKuNYG1+iti39bkKnbE73Y4kabJu5n1V7uqpEsU9q9+mSXu8IZjTGX8qNMXpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCw3pJx/9/uBrOrUL3v7VEwL31AnB7//zbjpFIqaYpZhrYMR0V
	LZ/lztZZqJpB2StQ4XGyTk1Ga5KZgfMoE2eyb05NQ497E+bk1qJuP5C42M96AVZUseqvUurze1x
	sd1oyG2zTCQtrZGUzq/6FUb+jarEpCzcRb3MWlcWWjp+y6nhSeMIVnzEs22L+gg==
X-Gm-Gg: ASbGnctwF3VgtDN7C96mz2NeFAoczcr8MvnlevaucM3psjzBQicXOYlFdlox1LojzpR
	rHucGwcVMHB7Z0WtvdE2BLu9pVygbgy0CHoFdcTy3Jymd58ViHdpzK/KPwQt9QOOvNK6wEsqts9
	LBspA2Kq5Ey9hhBtHSlC4cYr2D/t18QzqrKz6Qp3QabuUKcXXrm8o4txVE2v+I/FRTIgu4bBbW0
	C4klCeMDDjfvCXTpkGsCRtWOjI3yFuYn1LjxhHkVCWm7nLQjQCEJdqOPFMrsjjDlf5pA8LQhHFm
	yg4sNRj+GwphxgDc7reRgPP7BQjSTHEscKs7brcOzjFTqIi9LIF3LRupEWbBNW1SBOwM9AVpJ8f
	0gI2VLafE4i+NXJCPyRu1SThNZYX/nrxYw2w=
X-Received: by 2002:a05:620a:690d:b0:7d3:96ba:8561 with SMTP id af79cd13be357-7d5df0cd0b0mr338005385a.8.1751646941882;
        Fri, 04 Jul 2025 09:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfP68RIrTWZYgtUaR4q3SeBbtzq1pEc0BfwjanwBsEWR2Ynfwf25Lsl2txKTPie96kZGX9dA==
X-Received: by 2002:a05:620a:690d:b0:7d3:96ba:8561 with SMTP id af79cd13be357-7d5df0cd0b0mr337998085a.8.1751646940992;
        Fri, 04 Jul 2025 09:35:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:22 +0300
Subject: [PATCH v2 10/28] interconnect: qcom: x1e80100: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-10-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=60397;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=a6uCbAYyTDvRq2c8q2evsWyUPYJ5FD3vK7Gv2UWSlbo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0YG07H7f9ITvtXrzGueVW96atkdz33fuqXYD22auVziv
 lGvLX9VJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAm8uEJ+39Hj9PxHly7SjvL
 vCKql+c6WN6+pHC92MUk6EEWq3Xuy/SJT9gTqtZF6PHG5ExQ++mbZGVxZUJtytvDE7bWbXouesb
 IU6Gjsb0p84pxptCeusKifP+O808+sc545P7QpED955wlgRx1FfPCN6q121q9sWY8cPDEVqZvfB
 /S418dXZObcOrndMGMicw5f7a9iLf4u9F8YXOIyFmBHeZr3lWY8a5QUU/IOTxDwuqw0+sk5eabn
 x8ZndqtafyOo6S6MVi3MOVzk2LGIjfXTbK+rFftrnwrXtm1ITt7q0vlZU+n95NMu5+LZSizcc/5
 8bD0SdTLTD1vJs9DjD3esx8eXSy2aRnfYhHBau1H6xmMAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX7iGLR8BJXm2m
 BqXpEP2A+xx5yuGsaWUMSTArm8U+VY1kWQBdEtrmheXBMHljRvS3s5RwCiWJjnlwx/LgykSwlyE
 9rsAJ/iadj5IStOUxlUcupYzkA/GRwOiQPBJhzWSgL0NCTtf5dORuaCocUtdnorREwZJ5NdxXdR
 huVh86Kb5l2ojy7MgbE5kreeCABAA3RnZnqggsR+uBkVXPKrneWgj0V4fqFUdVtgVTiQnfhm6AH
 6CmZvA4a42C00i+5e1ABaueK7lZdkPpiPf3IAG9blpTKZaTRYS12eJqJ7HEOHEmy2n6g9MLzL40
 ijpyNFvToRzXbaZxw0lbAKi91OH17SDcK6xeNp7zDQ9mB4zwv+CsU9z+lToMTchhTBFQKOyiUqF
 r6MiQS4MfkknFXIjvE3h3GZoiW3OdOsemdhJsQ98S30eFwgq/LYDYAMPBu5fwAgJ2yE8s0Qc
X-Authority-Analysis: v=2.4 cv=RJKzH5i+ c=1 sm=1 tr=0 ts=686802df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZcX7BFObjaVFzTCdnnkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: IdUUfpr4hdnk9LkTAUY5FBcnIBBKEh_t
X-Proofpoint-GUID: IdUUfpr4hdnk9LkTAUY5FBcnIBBKEh_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/x1e80100.c | 781 ++++++++++++++++-------------------
 drivers/interconnect/qcom/x1e80100.h | 192 ---------
 2 files changed, 356 insertions(+), 617 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index f83a881b2becba9f7806bcc8f945e970596554b2..8f2a912f403a48826a9ee89df57933f746e4bed6 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -15,1342 +15,1254 @@
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
-#include "x1e80100.h"
+
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qxm_crypto;
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
+static struct qcom_icc_node alm_pcie_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_lpass;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_nsp_noc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qnm_lpiaon_noc;
+static struct qcom_icc_node qnm_lpass_lpinoc;
+static struct qcom_icc_node qxm_lpinoc_dsp_axim;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_av1_enc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_eva;
+static struct qcom_icc_node qnm_mdp;
+static struct qcom_icc_node qnm_video;
+static struct qcom_icc_node qnm_video_cv_cpu;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qsm_mnoc_cfg;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node qnm_pcie_north_gem_noc;
+static struct qcom_icc_node qnm_pcie_south_gem_noc;
+static struct qcom_icc_node xm_pcie_3;
+static struct qcom_icc_node xm_pcie_4;
+static struct qcom_icc_node xm_pcie_5;
+static struct qcom_icc_node xm_pcie_0;
+static struct qcom_icc_node xm_pcie_1;
+static struct qcom_icc_node xm_pcie_2;
+static struct qcom_icc_node xm_pcie_6a;
+static struct qcom_icc_node xm_pcie_6b;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gic;
+static struct qcom_icc_node qnm_usb_anoc;
+static struct qcom_icc_node qnm_aggre_usb_north_snoc;
+static struct qcom_icc_node qnm_aggre_usb_south_snoc;
+static struct qcom_icc_node xm_usb2_0;
+static struct qcom_icc_node xm_usb3_mp;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node xm_usb3_2;
+static struct qcom_icc_node xm_usb4_0;
+static struct qcom_icc_node xm_usb4_1;
+static struct qcom_icc_node xm_usb4_2;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_av1_enc_cfg;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie2_cfg;
+static struct qcom_icc_node qhs_pcie3_cfg;
+static struct qcom_icc_node qhs_pcie4_cfg;
+static struct qcom_icc_node qhs_pcie5_cfg;
+static struct qcom_icc_node qhs_pcie6a_cfg;
+static struct qcom_icc_node qhs_pcie6b_cfg;
+static struct qcom_icc_node qhs_pcie_rsc_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_smmuv3_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb2_0_cfg;
+static struct qcom_icc_node qhs_usb3_0_cfg;
+static struct qcom_icc_node qhs_usb3_1_cfg;
+static struct qcom_icc_node qhs_usb3_2_cfg;
+static struct qcom_icc_node qhs_usb3_mp_cfg;
+static struct qcom_icc_node qhs_usb4_0_cfg;
+static struct qcom_icc_node qhs_usb4_1_cfg;
+static struct qcom_icc_node qhs_usb4_2_cfg;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qss_lpass_qtb_cfg;
+static struct qcom_icc_node qss_mnoc_cfg;
+static struct qcom_icc_node qss_nsp_qtb_cfg;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qns_apss;
+static struct qcom_icc_node qss_cfg;
+static struct qcom_icc_node qxs_boot_imem;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_pcie_2;
+static struct qcom_icc_node xs_pcie_3;
+static struct qcom_icc_node xs_pcie_4;
+static struct qcom_icc_node xs_pcie_5;
+static struct qcom_icc_node xs_pcie_6a;
+static struct qcom_icc_node xs_pcie_6b;
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
+static struct qcom_icc_node qns_pcie_north_gem_noc;
+static struct qcom_icc_node qns_pcie_south_gem_noc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qns_aggre_usb_snoc;
+static struct qcom_icc_node qns_aggre_usb_north_snoc;
+static struct qcom_icc_node qns_aggre_usb_south_snoc;
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = X1E80100_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = X1E80100_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = X1E80100_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = X1E80100_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = X1E80100_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = X1E80100_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = X1E80100_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_sp = {
 	.name = "qxm_sp",
-	.id = X1E80100_MASTER_SP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = X1E80100_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = X1E80100_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = X1E80100_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = X1E80100_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = X1E80100_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = X1E80100_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_node qsm_cfg = {
 	.name = "qsm_cfg",
-	.id = X1E80100_MASTER_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 47,
-	.links = { X1E80100_SLAVE_AHB2PHY_SOUTH, X1E80100_SLAVE_AHB2PHY_NORTH,
-		   X1E80100_SLAVE_AHB2PHY_2, X1E80100_SLAVE_AV1_ENC_CFG,
-		   X1E80100_SLAVE_CAMERA_CFG, X1E80100_SLAVE_CLK_CTL,
-		   X1E80100_SLAVE_CRYPTO_0_CFG, X1E80100_SLAVE_DISPLAY_CFG,
-		   X1E80100_SLAVE_GFX3D_CFG, X1E80100_SLAVE_IMEM_CFG,
-		   X1E80100_SLAVE_IPC_ROUTER_CFG, X1E80100_SLAVE_PCIE_0_CFG,
-		   X1E80100_SLAVE_PCIE_1_CFG, X1E80100_SLAVE_PCIE_2_CFG,
-		   X1E80100_SLAVE_PCIE_3_CFG, X1E80100_SLAVE_PCIE_4_CFG,
-		   X1E80100_SLAVE_PCIE_5_CFG, X1E80100_SLAVE_PCIE_6A_CFG,
-		   X1E80100_SLAVE_PCIE_6B_CFG, X1E80100_SLAVE_PCIE_RSC_CFG,
-		   X1E80100_SLAVE_PDM, X1E80100_SLAVE_PRNG,
-		   X1E80100_SLAVE_QDSS_CFG, X1E80100_SLAVE_QSPI_0,
-		   X1E80100_SLAVE_QUP_0, X1E80100_SLAVE_QUP_1,
-		   X1E80100_SLAVE_QUP_2, X1E80100_SLAVE_SDCC_2,
-		   X1E80100_SLAVE_SDCC_4, X1E80100_SLAVE_SMMUV3_CFG,
-		   X1E80100_SLAVE_TCSR, X1E80100_SLAVE_TLMM,
-		   X1E80100_SLAVE_UFS_MEM_CFG, X1E80100_SLAVE_USB2,
-		   X1E80100_SLAVE_USB3_0, X1E80100_SLAVE_USB3_1,
-		   X1E80100_SLAVE_USB3_2, X1E80100_SLAVE_USB3_MP,
-		   X1E80100_SLAVE_USB4_0, X1E80100_SLAVE_USB4_1,
-		   X1E80100_SLAVE_USB4_2, X1E80100_SLAVE_VENUS_CFG,
-		   X1E80100_SLAVE_LPASS_QTB_CFG, X1E80100_SLAVE_CNOC_MNOC_CFG,
-		   X1E80100_SLAVE_NSP_QTB_CFG, X1E80100_SLAVE_QDSS_STM,
-		   X1E80100_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+			&qhs_ahb2phy2, &qhs_av1_enc_cfg,
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_crypto0_cfg, &qhs_display_cfg,
+			&qhs_gpuss_cfg, &qhs_imem_cfg,
+			&qhs_ipc_router, &qhs_pcie0_cfg,
+			&qhs_pcie1_cfg, &qhs_pcie2_cfg,
+			&qhs_pcie3_cfg, &qhs_pcie4_cfg,
+			&qhs_pcie5_cfg, &qhs_pcie6a_cfg,
+			&qhs_pcie6b_cfg, &qhs_pcie_rsc_cfg,
+			&qhs_pdm, &qhs_prng,
+			&qhs_qdss_cfg, &qhs_qspi,
+			&qhs_qup0, &qhs_qup1,
+			&qhs_qup2, &qhs_sdc2,
+			&qhs_sdc4, &qhs_smmuv3_cfg,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_ufs_mem_cfg, &qhs_usb2_0_cfg,
+			&qhs_usb3_0_cfg, &qhs_usb3_1_cfg,
+			&qhs_usb3_2_cfg, &qhs_usb3_mp_cfg,
+			&qhs_usb4_0_cfg, &qhs_usb4_1_cfg,
+			&qhs_usb4_2_cfg, &qhs_venus_cfg,
+			&qss_lpass_qtb_cfg, &qss_mnoc_cfg,
+			&qss_nsp_qtb_cfg, &xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = X1E80100_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 6,
-	.links = { X1E80100_SLAVE_AOSS, X1E80100_SLAVE_TME_CFG,
-		   X1E80100_SLAVE_APPSS, X1E80100_SLAVE_CNOC_CFG,
-		   X1E80100_SLAVE_BOOT_IMEM, X1E80100_SLAVE_IMEM },
+	.link_nodes = { &qhs_aoss, &qhs_tme_cfg,
+			&qns_apss, &qss_cfg,
+			&qxs_boot_imem, &qxs_imem, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = X1E80100_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 8,
-	.links = { X1E80100_SLAVE_PCIE_0, X1E80100_SLAVE_PCIE_1,
-		   X1E80100_SLAVE_PCIE_2, X1E80100_SLAVE_PCIE_3,
-		   X1E80100_SLAVE_PCIE_4, X1E80100_SLAVE_PCIE_5,
-		   X1E80100_SLAVE_PCIE_6A, X1E80100_SLAVE_PCIE_6B },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1,
+			&xs_pcie_2, &xs_pcie_3,
+			&xs_pcie_4, &xs_pcie_5,
+			&xs_pcie_6a, &xs_pcie_6b, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = X1E80100_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
-	.id = X1E80100_MASTER_PCIE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = X1E80100_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = X1E80100_MASTER_APPSS_PROC,
 	.channels = 6,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = X1E80100_MASTER_GFX3D,
 	.channels = 4,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass = {
 	.name = "qnm_lpass",
-	.id = X1E80100_MASTER_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = X1E80100_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = X1E80100_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_nsp_noc = {
 	.name = "qnm_nsp_noc",
-	.id = X1E80100_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = X1E80100_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = X1E80100_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = X1E80100_MASTER_GIC2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpiaon_noc = {
 	.name = "qnm_lpiaon_noc",
-	.id = X1E80100_MASTER_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LPASS_GEM_NOC },
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_lpinoc = {
 	.name = "qnm_lpass_lpinoc",
-	.id = X1E80100_MASTER_LPASS_LPINOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+	.link_nodes = { &qns_lpass_aggnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_lpinoc_dsp_axim = {
 	.name = "qxm_lpinoc_dsp_axim",
-	.id = X1E80100_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_LPICX_NOC_LPIAON_NOC },
+	.link_nodes = { &qns_lpi_aon_noc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = X1E80100_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_av1_enc = {
 	.name = "qnm_av1_enc",
-	.id = X1E80100_MASTER_AV1_ENC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = X1E80100_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = X1E80100_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = X1E80100_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_eva = {
 	.name = "qnm_eva",
-	.id = X1E80100_MASTER_EVA,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
-	.id = X1E80100_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
-	.id = X1E80100_MASTER_VIDEO,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
-	.id = X1E80100_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = X1E80100_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qsm_mnoc_cfg = {
 	.name = "qsm_mnoc_cfg",
-	.id = X1E80100_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = X1E80100_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie_north_gem_noc = {
 	.name = "qnm_pcie_north_gem_noc",
-	.id = X1E80100_MASTER_PCIE_NORTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie_south_gem_noc = {
 	.name = "qnm_pcie_south_gem_noc",
-	.id = X1E80100_MASTER_PCIE_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_3 = {
 	.name = "xm_pcie_3",
-	.id = X1E80100_MASTER_PCIE_3,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH },
+	.link_nodes = { &qns_pcie_north_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_4 = {
 	.name = "xm_pcie_4",
-	.id = X1E80100_MASTER_PCIE_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH },
+	.link_nodes = { &qns_pcie_north_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_5 = {
 	.name = "xm_pcie_5",
-	.id = X1E80100_MASTER_PCIE_5,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH },
+	.link_nodes = { &qns_pcie_north_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_0 = {
 	.name = "xm_pcie_0",
-	.id = X1E80100_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_1 = {
 	.name = "xm_pcie_1",
-	.id = X1E80100_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_2 = {
 	.name = "xm_pcie_2",
-	.id = X1E80100_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_6a = {
 	.name = "xm_pcie_6a",
-	.id = X1E80100_MASTER_PCIE_6A,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie_6b = {
 	.name = "xm_pcie_6b",
-	.id = X1E80100_MASTER_PCIE_6B,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = X1E80100_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = X1E80100_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_gic = {
 	.name = "qnm_gic",
-	.id = X1E80100_MASTER_GIC1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_usb_anoc = {
 	.name = "qnm_usb_anoc",
-	.id = X1E80100_MASTER_USB_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_usb_north_snoc = {
 	.name = "qnm_aggre_usb_north_snoc",
-	.id = X1E80100_MASTER_AGGRE_USB_NORTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_usb_south_snoc = {
 	.name = "qnm_aggre_usb_south_snoc",
-	.id = X1E80100_MASTER_AGGRE_USB_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb2_0 = {
 	.name = "xm_usb2_0",
-	.id = X1E80100_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_NORTH },
+	.link_nodes = { &qns_aggre_usb_north_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_mp = {
 	.name = "xm_usb3_mp",
-	.id = X1E80100_MASTER_USB3_MP,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_NORTH },
+	.link_nodes = { &qns_aggre_usb_north_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = X1E80100_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = X1E80100_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_2 = {
 	.name = "xm_usb3_2",
-	.id = X1E80100_MASTER_USB3_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb4_0 = {
 	.name = "xm_usb4_0",
-	.id = X1E80100_MASTER_USB4_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb4_1 = {
 	.name = "xm_usb4_1",
-	.id = X1E80100_MASTER_USB4_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb4_2 = {
 	.name = "xm_usb4_2",
-	.id = X1E80100_MASTER_USB4_2,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = X1E80100_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = X1E80100_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = X1E80100_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = X1E80100_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = X1E80100_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = X1E80100_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = X1E80100_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = X1E80100_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_av1_enc_cfg = {
 	.name = "qhs_av1_enc_cfg",
-	.id = X1E80100_SLAVE_AV1_ENC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = X1E80100_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = X1E80100_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = X1E80100_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = X1E80100_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = X1E80100_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = X1E80100_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = X1E80100_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = X1E80100_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = X1E80100_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie2_cfg = {
 	.name = "qhs_pcie2_cfg",
-	.id = X1E80100_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie3_cfg = {
 	.name = "qhs_pcie3_cfg",
-	.id = X1E80100_SLAVE_PCIE_3_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie4_cfg = {
 	.name = "qhs_pcie4_cfg",
-	.id = X1E80100_SLAVE_PCIE_4_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie5_cfg = {
 	.name = "qhs_pcie5_cfg",
-	.id = X1E80100_SLAVE_PCIE_5_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie6a_cfg = {
 	.name = "qhs_pcie6a_cfg",
-	.id = X1E80100_SLAVE_PCIE_6A_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie6b_cfg = {
 	.name = "qhs_pcie6b_cfg",
-	.id = X1E80100_SLAVE_PCIE_6B_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_rsc_cfg = {
 	.name = "qhs_pcie_rsc_cfg",
-	.id = X1E80100_SLAVE_PCIE_RSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = X1E80100_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = X1E80100_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = X1E80100_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = X1E80100_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = X1E80100_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = X1E80100_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = X1E80100_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = X1E80100_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = X1E80100_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_smmuv3_cfg = {
 	.name = "qhs_smmuv3_cfg",
-	.id = X1E80100_SLAVE_SMMUV3_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = X1E80100_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = X1E80100_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = X1E80100_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb2_0_cfg = {
 	.name = "qhs_usb2_0_cfg",
-	.id = X1E80100_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0_cfg = {
 	.name = "qhs_usb3_0_cfg",
-	.id = X1E80100_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_1_cfg = {
 	.name = "qhs_usb3_1_cfg",
-	.id = X1E80100_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_2_cfg = {
 	.name = "qhs_usb3_2_cfg",
-	.id = X1E80100_SLAVE_USB3_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_mp_cfg = {
 	.name = "qhs_usb3_mp_cfg",
-	.id = X1E80100_SLAVE_USB3_MP,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb4_0_cfg = {
 	.name = "qhs_usb4_0_cfg",
-	.id = X1E80100_SLAVE_USB4_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb4_1_cfg = {
 	.name = "qhs_usb4_1_cfg",
-	.id = X1E80100_SLAVE_USB4_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb4_2_cfg = {
 	.name = "qhs_usb4_2_cfg",
-	.id = X1E80100_SLAVE_USB4_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = X1E80100_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qss_lpass_qtb_cfg = {
 	.name = "qss_lpass_qtb_cfg",
-	.id = X1E80100_SLAVE_LPASS_QTB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qss_mnoc_cfg = {
 	.name = "qss_mnoc_cfg",
-	.id = X1E80100_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qsm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qss_nsp_qtb_cfg = {
 	.name = "qss_nsp_qtb_cfg",
-	.id = X1E80100_SLAVE_NSP_QTB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = X1E80100_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = X1E80100_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = X1E80100_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = X1E80100_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_apss = {
 	.name = "qns_apss",
-	.id = X1E80100_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qss_cfg = {
 	.name = "qss_cfg",
-	.id = X1E80100_SLAVE_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_CNOC_CFG },
+	.link_nodes = { &qsm_cfg, NULL },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = X1E80100_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = X1E80100_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = X1E80100_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = X1E80100_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_2 = {
 	.name = "xs_pcie_2",
-	.id = X1E80100_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_3 = {
 	.name = "xs_pcie_3",
-	.id = X1E80100_SLAVE_PCIE_3,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_4 = {
 	.name = "xs_pcie_4",
-	.id = X1E80100_SLAVE_PCIE_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_5 = {
 	.name = "xs_pcie_5",
-	.id = X1E80100_SLAVE_PCIE_5,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_6a = {
 	.name = "xs_pcie_6a",
-	.id = X1E80100_SLAVE_PCIE_6A,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_6b = {
 	.name = "xs_pcie_6b",
-	.id = X1E80100_SLAVE_PCIE_6B,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = X1E80100_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = X1E80100_SLAVE_LLCC,
 	.channels = 8,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = X1E80100_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
 	.name = "qns_lpass_ag_noc_gemnoc",
-	.id = X1E80100_SLAVE_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_LPASS_GEM_NOC },
+	.link_nodes = { &qnm_lpass, NULL },
 };
 
 static struct qcom_icc_node qns_lpass_aggnoc = {
 	.name = "qns_lpass_aggnoc",
-	.id = X1E80100_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_LPIAON_NOC },
+	.link_nodes = { &qnm_lpiaon_noc, NULL },
 };
 
 static struct qcom_icc_node qns_lpi_aon_noc = {
 	.name = "qns_lpi_aon_noc",
-	.id = X1E80100_SLAVE_LPICX_NOC_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_LPASS_LPINOC },
+	.link_nodes = { &qnm_lpass_lpinoc, NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = X1E80100_SLAVE_EBI1,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = X1E80100_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = X1E80100_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = X1E80100_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = X1E80100_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_nsp_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = X1E80100_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_north_gem_noc = {
 	.name = "qns_pcie_north_gem_noc",
-	.id = X1E80100_SLAVE_PCIE_NORTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_PCIE_NORTH },
+	.link_nodes = { &qnm_pcie_north_gem_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_south_gem_noc = {
 	.name = "qns_pcie_south_gem_noc",
-	.id = X1E80100_SLAVE_PCIE_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_PCIE_SOUTH },
+	.link_nodes = { &qnm_pcie_south_gem_noc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = X1E80100_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_aggre_usb_snoc = {
 	.name = "qns_aggre_usb_snoc",
-	.id = X1E80100_SLAVE_USB_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_USB_NOC_SNOC },
+	.link_nodes = { &qnm_usb_anoc, NULL },
 };
 
 static struct qcom_icc_node qns_aggre_usb_north_snoc = {
 	.name = "qns_aggre_usb_north_snoc",
-	.id = X1E80100_SLAVE_AGGRE_USB_NORTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_AGGRE_USB_NORTH },
+	.link_nodes = { &qnm_aggre_usb_north_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_aggre_usb_south_snoc = {
 	.name = "qns_aggre_usb_south_snoc",
-	.id = X1E80100_SLAVE_AGGRE_USB_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { X1E80100_MASTER_AGGRE_USB_SOUTH },
+	.link_nodes = { &qnm_aggre_usb_south_snoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1512,6 +1424,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1534,6 +1447,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1556,6 +1470,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1619,6 +1534,7 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_cnoc_cfg = {
+	.alloc_dyn_id = true,
 	.nodes = cnoc_cfg_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
 	.bcms = cnoc_cfg_bcms,
@@ -1649,6 +1565,7 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_cnoc_main = {
+	.alloc_dyn_id = true,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1679,6 +1596,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1694,6 +1612,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1710,6 +1629,7 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_lpiaon_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1725,6 +1645,7 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 	.bcms = lpass_lpicx_noc_bcms,
@@ -1742,6 +1663,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1770,6 +1692,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1786,6 +1709,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_nsp_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1803,6 +1727,7 @@ static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_center_anoc_nodes),
 	.bcms = pcie_center_anoc_bcms,
@@ -1820,6 +1745,7 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_north_anoc_nodes),
 	.bcms = pcie_north_anoc_bcms,
@@ -1839,6 +1765,7 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_south_anoc_nodes),
 	.bcms = pcie_south_anoc_bcms,
@@ -1861,6 +1788,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
@@ -1877,6 +1805,7 @@ static struct qcom_icc_node * const usb_center_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = usb_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_center_anoc_nodes),
 	.bcms = usb_center_anoc_bcms,
@@ -1893,6 +1822,7 @@ static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = usb_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_north_anoc_nodes),
 	.bcms = usb_north_anoc_bcms,
@@ -1913,6 +1843,7 @@ static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_south_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = usb_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_south_anoc_nodes),
 	.bcms = usb_south_anoc_bcms,
diff --git a/drivers/interconnect/qcom/x1e80100.h b/drivers/interconnect/qcom/x1e80100.h
deleted file mode 100644
index 2e14264f4c2b01d6c4e3fe63a5f5252dc6d29641..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/x1e80100.h
+++ /dev/null
@@ -1,192 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * X1E80100 interconnect IDs
- *
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
- * Copyright (c) 2023, Linaro Limited
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_X1E80100_H
-#define __DRIVERS_INTERCONNECT_QCOM_X1E80100_H
-
-#define X1E80100_MASTER_A1NOC_SNOC			0
-#define X1E80100_MASTER_A2NOC_SNOC			1
-#define X1E80100_MASTER_ANOC_PCIE_GEM_NOC		2
-#define X1E80100_MASTER_ANOC_PCIE_GEM_NOC_DISP		3
-#define X1E80100_MASTER_APPSS_PROC			4
-#define X1E80100_MASTER_CAMNOC_HF			5
-#define X1E80100_MASTER_CAMNOC_ICP			6
-#define X1E80100_MASTER_CAMNOC_SF			7
-#define X1E80100_MASTER_CDSP_PROC			8
-#define X1E80100_MASTER_CNOC_CFG			9
-#define X1E80100_MASTER_CNOC_MNOC_CFG			10
-#define X1E80100_MASTER_COMPUTE_NOC			11
-#define X1E80100_MASTER_CRYPTO				12
-#define X1E80100_MASTER_GEM_NOC_CNOC			13
-#define X1E80100_MASTER_GEM_NOC_PCIE_SNOC		14
-#define X1E80100_MASTER_GFX3D				15
-#define X1E80100_MASTER_GPU_TCU				16
-#define X1E80100_MASTER_IPA				17
-#define X1E80100_MASTER_LLCC				18
-#define X1E80100_MASTER_LLCC_DISP			19
-#define X1E80100_MASTER_LPASS_GEM_NOC			20
-#define X1E80100_MASTER_LPASS_LPINOC			21
-#define X1E80100_MASTER_LPASS_PROC			22
-#define X1E80100_MASTER_LPIAON_NOC			23
-#define X1E80100_MASTER_MDP				24
-#define X1E80100_MASTER_MDP_DISP			25
-#define X1E80100_MASTER_MNOC_HF_MEM_NOC			26
-#define X1E80100_MASTER_MNOC_HF_MEM_NOC_DISP		27
-#define X1E80100_MASTER_MNOC_SF_MEM_NOC			28
-#define X1E80100_MASTER_PCIE_0				29
-#define X1E80100_MASTER_PCIE_1				30
-#define X1E80100_MASTER_QDSS_ETR			31
-#define X1E80100_MASTER_QDSS_ETR_1			32
-#define X1E80100_MASTER_QSPI_0				33
-#define X1E80100_MASTER_QUP_0				34
-#define X1E80100_MASTER_QUP_1				35
-#define X1E80100_MASTER_QUP_2				36
-#define X1E80100_MASTER_QUP_CORE_0			37
-#define X1E80100_MASTER_QUP_CORE_1			38
-#define X1E80100_MASTER_SDCC_2				39
-#define X1E80100_MASTER_SDCC_4				40
-#define X1E80100_MASTER_SNOC_SF_MEM_NOC			41
-#define X1E80100_MASTER_SP				42
-#define X1E80100_MASTER_SYS_TCU				43
-#define X1E80100_MASTER_UFS_MEM				44
-#define X1E80100_MASTER_USB3_0				45
-#define X1E80100_MASTER_VIDEO				46
-#define X1E80100_MASTER_VIDEO_CV_PROC			47
-#define X1E80100_MASTER_VIDEO_V_PROC			48
-#define X1E80100_SLAVE_A1NOC_SNOC			49
-#define X1E80100_SLAVE_A2NOC_SNOC			50
-#define X1E80100_SLAVE_AHB2PHY_NORTH			51
-#define X1E80100_SLAVE_AHB2PHY_SOUTH			52
-#define X1E80100_SLAVE_ANOC_PCIE_GEM_NOC		53
-#define X1E80100_SLAVE_AOSS				54
-#define X1E80100_SLAVE_APPSS				55
-#define X1E80100_SLAVE_BOOT_IMEM			56
-#define X1E80100_SLAVE_CAMERA_CFG			57
-#define X1E80100_SLAVE_CDSP_MEM_NOC			58
-#define X1E80100_SLAVE_CLK_CTL				59
-#define X1E80100_SLAVE_CNOC_CFG				60
-#define X1E80100_SLAVE_CNOC_MNOC_CFG			61
-#define X1E80100_SLAVE_CRYPTO_0_CFG			62
-#define X1E80100_SLAVE_DISPLAY_CFG			63
-#define X1E80100_SLAVE_EBI1				64
-#define X1E80100_SLAVE_EBI1_DISP			65
-#define X1E80100_SLAVE_GEM_NOC_CNOC			66
-#define X1E80100_SLAVE_GFX3D_CFG			67
-#define X1E80100_SLAVE_IMEM				68
-#define X1E80100_SLAVE_IMEM_CFG				69
-#define X1E80100_SLAVE_IPC_ROUTER_CFG			70
-#define X1E80100_SLAVE_LLCC				71
-#define X1E80100_SLAVE_LLCC_DISP			72
-#define X1E80100_SLAVE_LPASS_GEM_NOC			73
-#define X1E80100_SLAVE_LPASS_QTB_CFG			74
-#define X1E80100_SLAVE_LPIAON_NOC_LPASS_AG_NOC		75
-#define X1E80100_SLAVE_LPICX_NOC_LPIAON_NOC		76
-#define X1E80100_SLAVE_MEM_NOC_PCIE_SNOC		77
-#define X1E80100_SLAVE_MNOC_HF_MEM_NOC			78
-#define X1E80100_SLAVE_MNOC_HF_MEM_NOC_DISP		79
-#define X1E80100_SLAVE_MNOC_SF_MEM_NOC			80
-#define X1E80100_SLAVE_NSP_QTB_CFG			81
-#define X1E80100_SLAVE_PCIE_0				82
-#define X1E80100_SLAVE_PCIE_0_CFG			83
-#define X1E80100_SLAVE_PCIE_1				84
-#define X1E80100_SLAVE_PCIE_1_CFG			85
-#define X1E80100_SLAVE_PDM				86
-#define X1E80100_SLAVE_PRNG				87
-#define X1E80100_SLAVE_QDSS_CFG				88
-#define X1E80100_SLAVE_QDSS_STM				89
-#define X1E80100_SLAVE_QSPI_0				90
-#define X1E80100_SLAVE_QUP_1				91
-#define X1E80100_SLAVE_QUP_2				92
-#define X1E80100_SLAVE_QUP_CORE_0			93
-#define X1E80100_SLAVE_QUP_CORE_1			94
-#define X1E80100_SLAVE_QUP_CORE_2			95
-#define X1E80100_SLAVE_SDCC_2				96
-#define X1E80100_SLAVE_SDCC_4				97
-#define X1E80100_SLAVE_SERVICE_MNOC			98
-#define X1E80100_SLAVE_SNOC_GEM_NOC_SF			99
-#define X1E80100_SLAVE_TCSR				100
-#define X1E80100_SLAVE_TCU				101
-#define X1E80100_SLAVE_TLMM				102
-#define X1E80100_SLAVE_TME_CFG				103
-#define X1E80100_SLAVE_UFS_MEM_CFG			104
-#define X1E80100_SLAVE_USB3_0				105
-#define X1E80100_SLAVE_VENUS_CFG			106
-#define X1E80100_MASTER_DDR_PERF_MODE			107
-#define X1E80100_MASTER_QUP_CORE_2			108
-#define X1E80100_MASTER_PCIE_TCU			109
-#define X1E80100_MASTER_GIC2				110
-#define X1E80100_MASTER_AV1_ENC				111
-#define X1E80100_MASTER_EVA				112
-#define X1E80100_MASTER_PCIE_NORTH			113
-#define X1E80100_MASTER_PCIE_SOUTH			114
-#define X1E80100_MASTER_PCIE_3				115
-#define X1E80100_MASTER_PCIE_4				116
-#define X1E80100_MASTER_PCIE_5				117
-#define X1E80100_MASTER_PCIE_2				118
-#define X1E80100_MASTER_PCIE_6A				119
-#define X1E80100_MASTER_PCIE_6B				120
-#define X1E80100_MASTER_GIC1				121
-#define X1E80100_MASTER_USB_NOC_SNOC			122
-#define X1E80100_MASTER_AGGRE_USB_NORTH			123
-#define X1E80100_MASTER_AGGRE_USB_SOUTH			124
-#define X1E80100_MASTER_USB2				125
-#define X1E80100_MASTER_USB3_MP				126
-#define X1E80100_MASTER_USB3_1				127
-#define X1E80100_MASTER_USB3_2				128
-#define X1E80100_MASTER_USB4_0				129
-#define X1E80100_MASTER_USB4_1				130
-#define X1E80100_MASTER_USB4_2				131
-#define X1E80100_MASTER_ANOC_PCIE_GEM_NOC_PCIE		132
-#define X1E80100_MASTER_LLCC_PCIE			133
-#define X1E80100_MASTER_PCIE_NORTH_PCIE			134
-#define X1E80100_MASTER_PCIE_SOUTH_PCIE			135
-#define X1E80100_MASTER_PCIE_3_PCIE			136
-#define X1E80100_MASTER_PCIE_4_PCIE			137
-#define X1E80100_MASTER_PCIE_5_PCIE			138
-#define X1E80100_MASTER_PCIE_0_PCIE			139
-#define X1E80100_MASTER_PCIE_1_PCIE			140
-#define X1E80100_MASTER_PCIE_2_PCIE			141
-#define X1E80100_MASTER_PCIE_6A_PCIE			142
-#define X1E80100_MASTER_PCIE_6B_PCIE			143
-#define X1E80100_SLAVE_AHB2PHY_2			144
-#define X1E80100_SLAVE_AV1_ENC_CFG			145
-#define X1E80100_SLAVE_PCIE_2_CFG			146
-#define X1E80100_SLAVE_PCIE_3_CFG			147
-#define X1E80100_SLAVE_PCIE_4_CFG			148
-#define X1E80100_SLAVE_PCIE_5_CFG			149
-#define X1E80100_SLAVE_PCIE_6A_CFG			150
-#define X1E80100_SLAVE_PCIE_6B_CFG			151
-#define X1E80100_SLAVE_PCIE_RSC_CFG			152
-#define X1E80100_SLAVE_QUP_0				153
-#define X1E80100_SLAVE_SMMUV3_CFG			154
-#define X1E80100_SLAVE_USB2				155
-#define X1E80100_SLAVE_USB3_1				156
-#define X1E80100_SLAVE_USB3_2				157
-#define X1E80100_SLAVE_USB3_MP				158
-#define X1E80100_SLAVE_USB4_0				159
-#define X1E80100_SLAVE_USB4_1				160
-#define X1E80100_SLAVE_USB4_2				161
-#define X1E80100_SLAVE_PCIE_2				162
-#define X1E80100_SLAVE_PCIE_3				163
-#define X1E80100_SLAVE_PCIE_4				164
-#define X1E80100_SLAVE_PCIE_5				165
-#define X1E80100_SLAVE_PCIE_6A				166
-#define X1E80100_SLAVE_PCIE_6B				167
-#define X1E80100_SLAVE_DDR_PERF_MODE			168
-#define X1E80100_SLAVE_PCIE_NORTH			169
-#define X1E80100_SLAVE_PCIE_SOUTH			170
-#define X1E80100_SLAVE_USB_NOC_SNOC			171
-#define X1E80100_SLAVE_AGGRE_USB_NORTH			172
-#define X1E80100_SLAVE_AGGRE_USB_SOUTH			173
-#define X1E80100_SLAVE_LLCC_PCIE			174
-#define X1E80100_SLAVE_EBI1_PCIE			175
-#define X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE		176
-#define X1E80100_SLAVE_PCIE_NORTH_PCIE			177
-#define X1E80100_SLAVE_PCIE_SOUTH_PCIE			178
-
-#endif

-- 
2.39.5


