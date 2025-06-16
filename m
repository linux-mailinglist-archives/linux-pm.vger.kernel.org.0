Return-Path: <linux-pm+bounces-28760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E36ADA533
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99657188FB6B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CD283145;
	Mon, 16 Jun 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FlG3W7M3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155328153A
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033803; cv=none; b=i1BfOfMDTu2KJPGpaa5b7wlyOO4CFc31uAD51NWlYwRf502GVbG5wLtpMLPXi+8pBV5hhe5QyaiT4oxSt9UhTyPVETDkLctHPbTjt5Em9zPwYBQbU5T5zdR9JZH/0WqGssSA6lZfkrqRp6L1YNiM3z4toi1wqJtop61FvJLQa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033803; c=relaxed/simple;
	bh=kU7AJ+e1rRkRiLJV63mBmJp1T3Bj5ehduyJSyTYGY9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlPjjY/9jAvm/u1ef/QHdwydegf7v64ygSXw6vnvxgVKjsKpA2rWACGPiBrUni+mPoSQXp+OHh0pmVB4NO2SGfvFI+eDIeJDmC8hJJyW3K3ZB319MkZk7wP8zL2DGTF/2cpd3qmWCSo08MHRezaX8ahUCKhwdwAMQ5NTdnfe5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FlG3W7M3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNZXGn015579
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UT4U+jXYUcrTf9pKkJBivWtt6TLdtK6lUdRzRhzwwdA=; b=FlG3W7M36pkxTDP3
	2WlOodOHzh+P0KzzQgFYUIs6ZX+qTtw1WgQ1iAvxFxtEn5YsneSpIYi8H4pErgJz
	qj4fZeCtSoH8K1d1Ig0hYKfNiwKA67PM/7Zb3UihGv8w0qrpDLRd6khd/sgXznlW
	uXKwZ4NTees8LwsGrQ0/plh2tT87/NT96ZuT83+nzBHQ6Pceaq+EoBemc5iiGNwa
	DaFtS3bH5L5Lr/kE0A5d8KAr57R/wUCYzjbkYrAeeOSUmqmvgKtAmfGO1R9Um4Mm
	ElZ04q6J8FkNFiK64pih1BUWL/RGUJ21XtrcvXfBbBMEfzETmnK7b4cooIIvKWAR
	Bg+O+g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hctk15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fad9167e4cso85352556d6.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033796; x=1750638596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT4U+jXYUcrTf9pKkJBivWtt6TLdtK6lUdRzRhzwwdA=;
        b=GJYErBF7JLpiBAlrnhtEeaRkUBB11pFUzaDmLqyDMca3zAX+ne6KK16eMzqU2zf9c8
         /BZMFisG9BuzB9iOyq4TAkoagMbwsGpXW5bE/y2ksZ1syD5tbH232jskAkqnyayCy+79
         ChvyUSw72eG1y/+qgNKaEMBNvYNdOJdjMbnWS06ORAUdRheFBcxbb/6JhQREdrdbiHZj
         w5nqU9wdsYPFihLmk/yd0UQ/1+m4ccaa98MxXogwvt1eT8M9+fb/RpvEJUOtVLzosqUs
         zI8AD22KFLGHU9Rl4KvpqJeu8kzXUxMOoHDOJ1wyha3ZNkUNEYDMj1Tb1C/WTjYibV0h
         FyZg==
X-Forwarded-Encrypted: i=1; AJvYcCVOxIEdNHnJuln6fFOd5w1myYNwALbe3i/K587eEzpRRp24XoEHT18JIKL9OXckdqK7m3OZfIsnDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFRLXeFk1VGfheC29d/HPJckmSD0vBWFEVrtdUg0P/vkNMdRS
	GtikiXD5TAG9D/gD2ZDQvLTAWeeIR+XIQmnFFdEJui+olKFAwUWGl5hpbc8OdY/jbbxx6d4hjUJ
	Oiv57+5N4zKNZpT2IPJ6jxH7Z0x0z2049ux0VSXwCbTDqylZyQWgj4PxRfp9SpQ==
X-Gm-Gg: ASbGnct4GOxl9tNTFzqgscY3Vu+gAIR0h6Fg+/5w+M2bOcKjXA4rlrnQVtUmPyt24VN
	ZESbuoDtdtSvfCUD0vHvs0alcWWBaOJIUW0nBTyQNaPeRUzhPE7HlyDfmjnUXjeIgJVF8pzYglq
	ceEsH6tM2s9RsZghl9IJQZ0WLNzeAcqTqL395KZjg6270Tgn0pjIQhF2lPSqkD+OsJAvElUYxfx
	7KphdgOfEVMiPl8C8wtbibUliUnIyoYSqR5ganHpqycWwNwUDjDvjdL0k5ImYWtQGHAOfAtg/hv
	by4kkLEx3VHjgnpuO1zq57WhADMXESWzrzQxeHJfkoREydOjyhjKrJ3h92mdrEvGtz2iQEDMU3e
	yeRDng5W5c0eIZdgoJndmEPw63eD8iyWBtJU=
X-Received: by 2002:a05:6214:2682:b0:6fa:c634:dc01 with SMTP id 6a1803df08f44-6fb47786d90mr124167356d6.16.1750033795304;
        Sun, 15 Jun 2025 17:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCKKCyY36Fv6+OuYtORof5/MnPpQ/qxHfoqMN1eK+WcbXcoo1iPuUloLRdQqQd5WTXWjYFIg==
X-Received: by 2002:a05:6214:2682:b0:6fa:c634:dc01 with SMTP id 6a1803df08f44-6fb47786d90mr124167056d6.16.1750033794679;
        Sun, 15 Jun 2025 17:29:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:29:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:36 +0300
Subject: [PATCH 24/28] interconnect: qcom: sm8450: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-24-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=55578;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kU7AJ+e1rRkRiLJV63mBmJp1T3Bj5ehduyJSyTYGY9M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UllR9jIFYFtLPif4IGQKcQL6jcYHon5gjXG
 CfWc6CyWLCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lJQAKCRCLPIo+Aiko
 1ZC4CACqivVLdYT5wzte16vyqbjqr0QG68ykPRJ5xKJklayve8w0azO20wSkxSjckW/FjCXPd26
 Y5Gq+38A+xVHz3hu8twwVXb3UE0cJeDMe1tfscm9Jizh9s7v++COLv0hT+f7LyJyB9c2DF3Wbry
 eF2hF8mmnJwmqdR9Aj/AUt0fsy+B/WCKYqecZbDV0YhPWqJ4fNXquuyCXMmk5R9220jLzUsXTaM
 GHrGCKwfMuRQlPEcLT7zmBoqPaOjluEfx+pfn+NVIwIU/5RFfrOIwSxAXmC3d4WB7JZeYANopgF
 zYvquTgtAKVFnPcAxIdd6xezrGnScEt1QMb5p1wWNDmCaSPn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMCBTYWx0ZWRfX/iRuXvVsw6sU
 aZgOV8am1Ap1lAbNTLZt0yZg57oOWWKJlph6B3cg+Sn7+gl6VFyUwiXFhRb4xHx1EvJfai3NwkM
 pTSWCB46/Tb1d5GnWVK3IQpQl8ufmD+RXV0HlTBw69oeF+JPnbPDLRkr6Kv0XSoNrPAXS8QpuCl
 0nPqHSaWinAz/QKlGrjkWjbCpb/cWvNJ1WCc47beEHq8krukakVx0RQW+UiSiPLdpiD5neZMIf1
 xQQh0aemNol3AWQiMt6Jc+++6RHRgwNZzy+YUs4KDh64L2gmYgQVdb+mefWFffNPI9nc2P0txXT
 E7aiFc8ypSTfp+7anNsGIEhObXBIueqqxSk3XnaQ94NfnBByZ7YyfTNAptJAZ1F1duHr4Ls5kHw
 YxWpDHqYPKNxxFCQ00xhIizRxlLOGZ1OYjpjPjswdcxHvYfVJ0VKI0VJ9ZZrn8TvaSXRswG1
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=684f6586 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=tdp4ZlxAoC5NwBbKlvEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: r2KtelEJdxhFFLIp_C4jCS3NgPcivp1I
X-Proofpoint-GUID: r2KtelEJdxhFFLIp_C4jCS3NgPcivp1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160000

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm8450.c | 762 +++++++++++++++++--------------------
 drivers/interconnect/qcom/sm8450.h | 169 --------
 2 files changed, 343 insertions(+), 588 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 94e60b5067625606e2b141fbde1b5d90425386d3..eb3c2bb5499da9aaa6cd84b14d3917ab5e119a5f 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -16,1325 +16,1238 @@
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
-#include "sm8450.h"
+
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qnm_a1noc_cfg;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qnm_a2noc_cfg;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node qxm_sensorss_q6;
+static struct qcom_icc_node qxm_sp;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup2_core_master;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mdsp;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_nsp_gemnoc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qhm_config_noc;
+static struct qcom_icc_node qxm_lpass_dsp;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mdp;
+static struct qcom_icc_node qnm_mnoc_cfg;
+static struct qcom_icc_node qnm_rot;
+static struct qcom_icc_node qnm_vapss_hcp;
+static struct qcom_icc_node qnm_video;
+static struct qcom_icc_node qnm_video_cv_cpu;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qhm_nsp_noc_config;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node qnm_pcie_anoc_cfg;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_lpass_noc;
+static struct qcom_icc_node qnm_snoc_cfg;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qnm_mnoc_hf_disp;
+static struct qcom_icc_node qnm_mnoc_sf_disp;
+static struct qcom_icc_node qnm_pcie_disp;
+static struct qcom_icc_node llcc_mc_disp;
+static struct qcom_icc_node qnm_mdp_disp;
+static struct qcom_icc_node qnm_rot_disp;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mxa;
+static struct qcom_icc_node qhs_cpr_mxc;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_lpass_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_a1_noc_cfg;
+static struct qcom_icc_node qns_a2_noc_cfg;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_mnoc_cfg;
+static struct qcom_icc_node qns_pcie_anoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node qhs_lpass_core;
+static struct qcom_icc_node qhs_lpass_lpi;
+static struct qcom_icc_node qhs_lpass_mpu;
+static struct qcom_icc_node qhs_lpass_top;
+static struct qcom_icc_node qns_sysnoc;
+static struct qcom_icc_node srvc_niu_aml_noc;
+static struct qcom_icc_node srvc_niu_lpass_agnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node service_nsp_noc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_pcie_aggre_noc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node qns_llcc_disp;
+static struct qcom_icc_node ebi_disp;
+static struct qcom_icc_node qns_mem_noc_hf_disp;
+static struct qcom_icc_node qns_mem_noc_sf_disp;
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8450_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8450_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a1noc_cfg = {
 	.name = "qnm_a1noc_cfg",
-	.id = SM8450_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8450_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8450_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8450_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8450_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SM8450_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8450_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a2noc_cfg = {
 	.name = "qnm_a2noc_cfg",
-	.id = SM8450_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8450_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8450_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_sensorss_q6 = {
 	.name = "qxm_sensorss_q6",
-	.id = SM8450_MASTER_SENSORS_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_sp = {
 	.name = "qxm_sp",
-	.id = SM8450_MASTER_SP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = SM8450_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = SM8450_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8450_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM8450_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM8450_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SM8450_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SM8450_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 51,
-	.links = { SM8450_SLAVE_AHB2PHY_SOUTH, SM8450_SLAVE_AHB2PHY_NORTH,
-		   SM8450_SLAVE_AOSS, SM8450_SLAVE_CAMERA_CFG,
-		   SM8450_SLAVE_CLK_CTL, SM8450_SLAVE_CDSP_CFG,
-		   SM8450_SLAVE_RBCPR_CX_CFG, SM8450_SLAVE_RBCPR_MMCX_CFG,
-		   SM8450_SLAVE_RBCPR_MXA_CFG, SM8450_SLAVE_RBCPR_MXC_CFG,
-		   SM8450_SLAVE_CRYPTO_0_CFG, SM8450_SLAVE_CX_RDPM,
-		   SM8450_SLAVE_DISPLAY_CFG, SM8450_SLAVE_GFX3D_CFG,
-		   SM8450_SLAVE_IMEM_CFG, SM8450_SLAVE_IPA_CFG,
-		   SM8450_SLAVE_IPC_ROUTER_CFG, SM8450_SLAVE_LPASS,
-		   SM8450_SLAVE_CNOC_MSS, SM8450_SLAVE_MX_RDPM,
-		   SM8450_SLAVE_PCIE_0_CFG, SM8450_SLAVE_PCIE_1_CFG,
-		   SM8450_SLAVE_PDM, SM8450_SLAVE_PIMEM_CFG,
-		   SM8450_SLAVE_PRNG, SM8450_SLAVE_QDSS_CFG,
-		   SM8450_SLAVE_QSPI_0, SM8450_SLAVE_QUP_0,
-		   SM8450_SLAVE_QUP_1, SM8450_SLAVE_QUP_2,
-		   SM8450_SLAVE_SDCC_2, SM8450_SLAVE_SDCC_4,
-		   SM8450_SLAVE_SPSS_CFG, SM8450_SLAVE_TCSR,
-		   SM8450_SLAVE_TLMM, SM8450_SLAVE_TME_CFG,
-		   SM8450_SLAVE_UFS_MEM_CFG, SM8450_SLAVE_USB3_0,
-		   SM8450_SLAVE_VENUS_CFG, SM8450_SLAVE_VSENSE_CTRL_CFG,
-		   SM8450_SLAVE_A1NOC_CFG, SM8450_SLAVE_A2NOC_CFG,
-		   SM8450_SLAVE_DDRSS_CFG, SM8450_SLAVE_CNOC_MNOC_CFG,
-		   SM8450_SLAVE_PCIE_ANOC_CFG, SM8450_SLAVE_SNOC_CFG,
-		   SM8450_SLAVE_IMEM, SM8450_SLAVE_PIMEM,
-		   SM8450_SLAVE_SERVICE_CNOC, SM8450_SLAVE_QDSS_STM,
-		   SM8450_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+			&qhs_aoss, &qhs_camera_cfg,
+			&qhs_clk_ctl, &qhs_compute_cfg,
+			&qhs_cpr_cx, &qhs_cpr_mmcx,
+			&qhs_cpr_mxa, &qhs_cpr_mxc,
+			&qhs_crypto0_cfg, &qhs_cx_rdpm,
+			&qhs_display_cfg, &qhs_gpuss_cfg,
+			&qhs_imem_cfg, &qhs_ipa,
+			&qhs_ipc_router, &qhs_lpass_cfg,
+			&qhs_mss_cfg, &qhs_mx_rdpm,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pdm, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_qup2,
+			&qhs_sdc2, &qhs_sdc4,
+			&qhs_spss_cfg, &qhs_tcsr,
+			&qhs_tlmm, &qhs_tme_cfg,
+			&qhs_ufs_mem_cfg, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qns_a1_noc_cfg, &qns_a2_noc_cfg,
+			&qns_ddrss_cfg, &qns_mnoc_cfg,
+			&qns_pcie_anoc_cfg, &qns_snoc_cfg,
+			&qxs_imem, &qxs_pimem,
+			&srvc_cnoc, &xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SM8450_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_PCIE_0, SM8450_SLAVE_PCIE_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SM8450_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SM8450_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SM8450_MASTER_APPSS_PROC,
 	.channels = 3,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC,
-		   SM8450_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8450_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mdsp = {
 	.name = "qnm_mdsp",
-	.id = SM8450_MASTER_MSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC,
-		   SM8450_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8450_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8450_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_nsp_gemnoc = {
 	.name = "qnm_nsp_gemnoc",
-	.id = SM8450_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8450_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM8450_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8450_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8450_SLAVE_GEM_NOC_CNOC, SM8450_SLAVE_LLCC,
-		   SM8450_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SM8450_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 6,
-	.links = { SM8450_SLAVE_LPASS_CORE_CFG, SM8450_SLAVE_LPASS_LPI_CFG,
-		   SM8450_SLAVE_LPASS_MPU_CFG, SM8450_SLAVE_LPASS_TOP_CFG,
-		   SM8450_SLAVE_SERVICES_LPASS_AML_NOC, SM8450_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
+			&qhs_lpass_mpu, &qhs_lpass_top,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_lpass_dsp = {
 	.name = "qxm_lpass_dsp",
-	.id = SM8450_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 4,
-	.links = { SM8450_SLAVE_LPASS_TOP_CFG, SM8450_SLAVE_LPASS_SNOC,
-		   SM8450_SLAVE_SERVICES_LPASS_AML_NOC, SM8450_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_top, &qns_sysnoc,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8450_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SM8450_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SM8450_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SM8450_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
-	.id = SM8450_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_cfg = {
 	.name = "qnm_mnoc_cfg",
-	.id = SM8450_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_rot = {
 	.name = "qnm_rot",
-	.id = SM8450_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_vapss_hcp = {
 	.name = "qnm_vapss_hcp",
-	.id = SM8450_MASTER_CDSP_HCP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
-	.id = SM8450_MASTER_VIDEO,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
-	.id = SM8450_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM8450_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = SM8450_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SM8450_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SM8450_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie_anoc_cfg = {
 	.name = "qnm_pcie_anoc_cfg",
-	.id = SM8450_MASTER_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SERVICE_PCIE_ANOC },
+	.link_nodes = { &srvc_pcie_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM8450_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SM8450_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = SM8450_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8450_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM8450_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
-	.id = SM8450_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SM8450_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SM8450_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8450_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf_disp = {
 	.name = "qnm_mnoc_hf_disp",
-	.id = SM8450_MASTER_MNOC_HF_MEM_NOC_DISP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC_DISP },
+	.link_nodes = { &qns_llcc_disp, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf_disp = {
 	.name = "qnm_mnoc_sf_disp",
-	.id = SM8450_MASTER_MNOC_SF_MEM_NOC_DISP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC_DISP },
+	.link_nodes = { &qns_llcc_disp, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie_disp = {
 	.name = "qnm_pcie_disp",
-	.id = SM8450_MASTER_ANOC_PCIE_GEM_NOC_DISP,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_LLCC_DISP },
+	.link_nodes = { &qns_llcc_disp, NULL },
 };
 
 static struct qcom_icc_node llcc_mc_disp = {
 	.name = "llcc_mc_disp",
-	.id = SM8450_MASTER_LLCC_DISP,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_EBI1_DISP },
+	.link_nodes = { &ebi_disp, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp_disp = {
 	.name = "qnm_mdp_disp",
-	.id = SM8450_MASTER_MDP_DISP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_HF_MEM_NOC_DISP },
+	.link_nodes = { &qns_mem_noc_hf_disp, NULL },
 };
 
 static struct qcom_icc_node qnm_rot_disp = {
 	.name = "qnm_rot_disp",
-	.id = SM8450_MASTER_ROTATOR_DISP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_SLAVE_MNOC_SF_MEM_NOC_DISP },
+	.link_nodes = { &qns_mem_noc_sf_disp, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8450_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM8450_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8450_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM8450_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM8450_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM8450_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SM8450_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM8450_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SM8450_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8450_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8450_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8450_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_cfg = {
 	.name = "qhs_compute_cfg",
-	.id = SM8450_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { MASTER_CDSP_NOC_CFG },
+	.link_nodes = { MASTER_CDSP_NOC_CFG, NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM8450_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SM8450_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mxa = {
 	.name = "qhs_cpr_mxa",
-	.id = SM8450_SLAVE_RBCPR_MXA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mxc = {
 	.name = "qhs_cpr_mxc",
-	.id = SM8450_SLAVE_RBCPR_MXC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8450_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SM8450_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8450_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8450_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8450_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8450_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SM8450_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SM8450_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { MASTER_CNOC_LPASS_AG_NOC, NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SM8450_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SM8450_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SM8450_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SM8450_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM8450_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM8450_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM8450_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8450_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8450_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SM8450_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM8450_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SM8450_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8450_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8450_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SM8450_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8450_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SM8450_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = SM8450_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8450_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8450_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8450_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8450_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a1_noc_cfg = {
 	.name = "qns_a1_noc_cfg",
-	.id = SM8450_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_MASTER_A1NOC_CFG },
+	.link_nodes = { &qnm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_a2_noc_cfg = {
 	.name = "qns_a2_noc_cfg",
-	.id = SM8450_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_MASTER_A2NOC_CFG },
+	.link_nodes = { &qnm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SM8450_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
 	//FIXME where is link
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mnoc_cfg = {
 	.name = "qns_mnoc_cfg",
-	.id = SM8450_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qnm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_anoc_cfg = {
 	.name = "qns_pcie_anoc_cfg",
-	.id = SM8450_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_MASTER_PCIE_ANOC_CFG },
+	.link_nodes = { &qnm_pcie_anoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SM8450_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8450_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8450_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM8450_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM8450_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SM8450_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SM8450_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8450_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8450_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SM8450_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8450_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SM8450_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SM8450_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SM8450_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SM8450_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SM8450_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_sysnoc = {
 	.name = "qns_sysnoc",
-	.id = SM8450_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_LPASS_ANOC },
+	.link_nodes = { &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SM8450_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SM8450_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8450_SLAVE_EBI1,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8450_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM8450_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8450_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SM8450_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SM8450_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8450_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_pcie_aggre_noc = {
 	.name = "srvc_pcie_aggre_noc",
-	.id = SM8450_SLAVE_SERVICE_PCIE_ANOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM8450_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8450_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8450_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM8450_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_llcc_disp = {
 	.name = "qns_llcc_disp",
-	.id = SM8450_SLAVE_LLCC_DISP,
 	.channels = 4,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8450_MASTER_LLCC_DISP },
+	.link_nodes = { &llcc_mc_disp, NULL },
 };
 
 static struct qcom_icc_node ebi_disp = {
 	.name = "ebi_disp",
-	.id = SM8450_SLAVE_EBI1_DISP,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf_disp = {
 	.name = "qns_mem_noc_hf_disp",
-	.id = SM8450_SLAVE_MNOC_HF_MEM_NOC_DISP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_MNOC_HF_MEM_NOC_DISP },
+	.link_nodes = { &qnm_mnoc_hf_disp, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf_disp = {
 	.name = "qns_mem_noc_sf_disp",
-	.id = SM8450_SLAVE_MNOC_SF_MEM_NOC_DISP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8450_MASTER_MNOC_SF_MEM_NOC_DISP },
+	.link_nodes = { &qnm_mnoc_sf_disp, NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1529,6 +1442,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1556,6 +1470,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1578,6 +1493,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1647,6 +1563,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1682,6 +1599,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1704,6 +1622,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1725,6 +1644,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1760,6 +1680,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1778,6 +1699,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_nsp_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1797,6 +1719,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1825,6 +1748,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8450_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8450.h b/drivers/interconnect/qcom/sm8450.h
deleted file mode 100644
index a5790ec6767b36e15997d838339d024007f9f7be..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm8450.h
+++ /dev/null
@@ -1,169 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * SM8450 interconnect IDs
- *
- * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Linaro Limited
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8450_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM8450_H
-
-#define SM8450_MASTER_GPU_TCU				0
-#define SM8450_MASTER_SYS_TCU				1
-#define SM8450_MASTER_APPSS_PROC			2
-#define SM8450_MASTER_LLCC				3
-#define SM8450_MASTER_CNOC_LPASS_AG_NOC			4
-#define SM8450_MASTER_GIC_AHB				5
-#define SM8450_MASTER_CDSP_NOC_CFG			6
-#define SM8450_MASTER_QDSS_BAM				7
-#define SM8450_MASTER_QSPI_0				8
-#define SM8450_MASTER_QUP_0				9
-#define SM8450_MASTER_QUP_1				10
-#define SM8450_MASTER_QUP_2				11
-#define SM8450_MASTER_A1NOC_CFG				12
-#define SM8450_MASTER_A2NOC_CFG				13
-#define SM8450_MASTER_A1NOC_SNOC			14
-#define SM8450_MASTER_A2NOC_SNOC			15
-#define SM8450_MASTER_CAMNOC_HF				16
-#define SM8450_MASTER_CAMNOC_ICP			17
-#define SM8450_MASTER_CAMNOC_SF				18
-#define SM8450_MASTER_GEM_NOC_CNOC			19
-#define SM8450_MASTER_GEM_NOC_PCIE_SNOC			20
-#define SM8450_MASTER_GFX3D				21
-#define SM8450_MASTER_LPASS_ANOC			22
-#define SM8450_MASTER_MDP				23
-#define SM8450_MASTER_MDP0				SM8450_MASTER_MDP
-#define SM8450_MASTER_MDP1				SM8450_MASTER_MDP
-#define SM8450_MASTER_MSS_PROC				24
-#define SM8450_MASTER_CNOC_MNOC_CFG			25
-#define SM8450_MASTER_MNOC_HF_MEM_NOC			26
-#define SM8450_MASTER_MNOC_SF_MEM_NOC			27
-#define SM8450_MASTER_COMPUTE_NOC			28
-#define SM8450_MASTER_ANOC_PCIE_GEM_NOC			29
-#define SM8450_MASTER_PCIE_ANOC_CFG			30
-#define SM8450_MASTER_ROTATOR				31
-#define SM8450_MASTER_SNOC_CFG				32
-#define SM8450_MASTER_SNOC_GC_MEM_NOC			33
-#define SM8450_MASTER_SNOC_SF_MEM_NOC			34
-#define SM8450_MASTER_CDSP_HCP				35
-#define SM8450_MASTER_VIDEO				36
-#define SM8450_MASTER_VIDEO_P0				SM8450_MASTER_VIDEO
-#define SM8450_MASTER_VIDEO_P1				SM8450_MASTER_VIDEO
-#define SM8450_MASTER_VIDEO_CV_PROC			37
-#define SM8450_MASTER_VIDEO_PROC			38
-#define SM8450_MASTER_VIDEO_V_PROC			39
-#define SM8450_MASTER_QUP_CORE_0			40
-#define SM8450_MASTER_QUP_CORE_1			41
-#define SM8450_MASTER_QUP_CORE_2			42
-#define SM8450_MASTER_CRYPTO				43
-#define SM8450_MASTER_IPA				44
-#define SM8450_MASTER_LPASS_PROC			45
-#define SM8450_MASTER_CDSP_PROC				46
-#define SM8450_MASTER_PIMEM				47
-#define SM8450_MASTER_SENSORS_PROC			48
-#define SM8450_MASTER_SP				49
-#define SM8450_MASTER_GIC				50
-#define SM8450_MASTER_PCIE_0				51
-#define SM8450_MASTER_PCIE_1				52
-#define SM8450_MASTER_QDSS_ETR				53
-#define SM8450_MASTER_QDSS_ETR_1			54
-#define SM8450_MASTER_SDCC_2				55
-#define SM8450_MASTER_SDCC_4				56
-#define SM8450_MASTER_UFS_MEM				57
-#define SM8450_MASTER_USB3_0				58
-#define SM8450_SLAVE_EBI1				512
-#define SM8450_SLAVE_AHB2PHY_SOUTH			513
-#define SM8450_SLAVE_AHB2PHY_NORTH			514
-#define SM8450_SLAVE_AOSS				515
-#define SM8450_SLAVE_CAMERA_CFG				516
-#define SM8450_SLAVE_CLK_CTL				517
-#define SM8450_SLAVE_CDSP_CFG				518
-#define SM8450_SLAVE_RBCPR_CX_CFG			519
-#define SM8450_SLAVE_RBCPR_MMCX_CFG			520
-#define SM8450_SLAVE_RBCPR_MXA_CFG			521
-#define SM8450_SLAVE_RBCPR_MXC_CFG			522
-#define SM8450_SLAVE_CRYPTO_0_CFG			523
-#define SM8450_SLAVE_CX_RDPM				524
-#define SM8450_SLAVE_DISPLAY_CFG			525
-#define SM8450_SLAVE_GFX3D_CFG				526
-#define SM8450_SLAVE_IMEM_CFG				527
-#define SM8450_SLAVE_IPA_CFG				528
-#define SM8450_SLAVE_IPC_ROUTER_CFG			529
-#define SM8450_SLAVE_LPASS				530
-#define SM8450_SLAVE_LPASS_CORE_CFG			531
-#define SM8450_SLAVE_LPASS_LPI_CFG			532
-#define SM8450_SLAVE_LPASS_MPU_CFG			533
-#define SM8450_SLAVE_LPASS_TOP_CFG			534
-#define SM8450_SLAVE_CNOC_MSS				535
-#define SM8450_SLAVE_MX_RDPM				536
-#define SM8450_SLAVE_PCIE_0_CFG				537
-#define SM8450_SLAVE_PCIE_1_CFG				538
-#define SM8450_SLAVE_PDM				539
-#define SM8450_SLAVE_PIMEM_CFG				540
-#define SM8450_SLAVE_PRNG				541
-#define SM8450_SLAVE_QDSS_CFG				542
-#define SM8450_SLAVE_QSPI_0				543
-#define SM8450_SLAVE_QUP_0				544
-#define SM8450_SLAVE_QUP_1				545
-#define SM8450_SLAVE_QUP_2				546
-#define SM8450_SLAVE_SDCC_2				547
-#define SM8450_SLAVE_SDCC_4				548
-#define SM8450_SLAVE_SPSS_CFG				549
-#define SM8450_SLAVE_TCSR				550
-#define SM8450_SLAVE_TLMM				551
-#define SM8450_SLAVE_TME_CFG				552
-#define SM8450_SLAVE_UFS_MEM_CFG			553
-#define SM8450_SLAVE_USB3_0				554
-#define SM8450_SLAVE_VENUS_CFG				555
-#define SM8450_SLAVE_VSENSE_CTRL_CFG			556
-#define SM8450_SLAVE_A1NOC_CFG				557
-#define SM8450_SLAVE_A1NOC_SNOC				558
-#define SM8450_SLAVE_A2NOC_CFG				559
-#define SM8450_SLAVE_A2NOC_SNOC				560
-#define SM8450_SLAVE_DDRSS_CFG				561
-#define SM8450_SLAVE_GEM_NOC_CNOC			562
-#define SM8450_SLAVE_SNOC_GEM_NOC_GC			563
-#define SM8450_SLAVE_SNOC_GEM_NOC_SF			564
-#define SM8450_SLAVE_LLCC				565
-#define SM8450_SLAVE_MNOC_HF_MEM_NOC			566
-#define SM8450_SLAVE_MNOC_SF_MEM_NOC			567
-#define SM8450_SLAVE_CNOC_MNOC_CFG			568
-#define SM8450_SLAVE_CDSP_MEM_NOC			569
-#define SM8450_SLAVE_MEM_NOC_PCIE_SNOC			570
-#define SM8450_SLAVE_PCIE_ANOC_CFG			571
-#define SM8450_SLAVE_ANOC_PCIE_GEM_NOC			572
-#define SM8450_SLAVE_SNOC_CFG				573
-#define SM8450_SLAVE_LPASS_SNOC				574
-#define SM8450_SLAVE_QUP_CORE_0				575
-#define SM8450_SLAVE_QUP_CORE_1				576
-#define SM8450_SLAVE_QUP_CORE_2				577
-#define SM8450_SLAVE_IMEM				578
-#define SM8450_SLAVE_PIMEM				579
-#define SM8450_SLAVE_SERVICE_NSP_NOC			580
-#define SM8450_SLAVE_SERVICE_A1NOC			581
-#define SM8450_SLAVE_SERVICE_A2NOC			582
-#define SM8450_SLAVE_SERVICE_CNOC			583
-#define SM8450_SLAVE_SERVICE_MNOC			584
-#define SM8450_SLAVE_SERVICES_LPASS_AML_NOC		585
-#define SM8450_SLAVE_SERVICE_LPASS_AG_NOC		586
-#define SM8450_SLAVE_SERVICE_PCIE_ANOC			587
-#define SM8450_SLAVE_SERVICE_SNOC			588
-#define SM8450_SLAVE_PCIE_0				589
-#define SM8450_SLAVE_PCIE_1				590
-#define SM8450_SLAVE_QDSS_STM				591
-#define SM8450_SLAVE_TCU				592
-#define SM8450_MASTER_LLCC_DISP				1000
-#define SM8450_MASTER_MDP_DISP				1001
-#define SM8450_MASTER_MDP0_DISP				SM8450_MASTER_MDP_DISP
-#define SM8450_MASTER_MDP1_DISP				SM8450_MASTER_MDP_DISP
-#define SM8450_MASTER_MNOC_HF_MEM_NOC_DISP		1002
-#define SM8450_MASTER_MNOC_SF_MEM_NOC_DISP		1003
-#define SM8450_MASTER_ANOC_PCIE_GEM_NOC_DISP		1004
-#define SM8450_MASTER_ROTATOR_DISP			1005
-#define SM8450_SLAVE_EBI1_DISP				1512
-#define SM8450_SLAVE_LLCC_DISP				1513
-#define SM8450_SLAVE_MNOC_HF_MEM_NOC_DISP		1514
-#define SM8450_SLAVE_MNOC_SF_MEM_NOC_DISP		1515
-
-#endif

-- 
2.39.5


