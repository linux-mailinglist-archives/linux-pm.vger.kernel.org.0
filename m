Return-Path: <linux-pm+bounces-30163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09EAF98D0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E30168A47
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BF32801A;
	Fri,  4 Jul 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsfinxNO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21D327A2C
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646972; cv=none; b=H1Rt+6bqNPS9FhnrbKEZHsT6yupXXXFmc6OfK56eWaY1ZjBKjtETeBcgbGwqfTRKcVMNHXM68mqAJVzi4eGIeo2g9QUN/BFTSPG2s/DZ/2WSe8u0LluHLnwrMwm/qOu8G6YTcNYQqcqF4ceXF7nb3Z8ZnjA+rTNFDO6s8B9Ao2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646972; c=relaxed/simple;
	bh=l/GDK516Pef5aGRtzNj+CYesmUAUaQnjiWHcuthC7RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7+SKFCUicXd7zudVpmJAM+09svo+7GcanUv0/BeqyshwbMEurkCdSaI8z/ml8SVaN1QTMfYQRRPeqgrrE3FgecWdEXFtXRDuNNs2veso7lqiAepMP6MuTvMVQXBBM2OrWL5gUi5vatCWyCDAWE1AFa4EbqQA1I/b5V8MYs7IzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsfinxNO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5648LVf6029505
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UTQj7fWnB0raNXRuawE9Zd7z7oSFeYkC+sopPF2xYl0=; b=WsfinxNOdZUDnAkE
	lDG8RVD5tJblGWRUs4CsV5wnM6yFGv3Qs45eDQ7dpqmjU2vgRbMrDI5wckBdgB27
	djY3CSlGe231mB7/OJxM04B3w39rFETmnhDynl2kgIdy3BDE8CJjAz1HYZaThLQS
	GCJ26+hgWFXyxmQwWEpLImuS0MxtX0rsxLvjSyHfGIggquQvUVcPNrnxFjdGQYwI
	iuIzEJKhGLKSjbnLSOWliyn7E6X8OY5us8dNvCdPQxXz4vjSNRRb5f5+aRwBljZj
	/z+oQ96ohOH/xqd9rfnV57YS1Y6yq1axGCSxVUdYnke7bWF2PGM1cNwMKHyjfRo2
	cGMGCA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47nh9s5x9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:36:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3d3f6471cso175307585a.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646961; x=1752251761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTQj7fWnB0raNXRuawE9Zd7z7oSFeYkC+sopPF2xYl0=;
        b=iavbHx0jiNUblnJ5F1iTuqAFTyJuzXwsUWfjgcGWsHi6KNf1iRQfGOhQCHG8Esam/n
         4tPTDeFeNTwwZuSzhja2P7hd7GaD+9Sv0W1gLpMCrttCDYuaWtM2elM2BsbMswoI61P7
         Vzpkp3sdozAog4VuUXRO6wLqixJW4Bm9KuQUFhyp9cz1gdGzbDAFvMnd1LYLmb3QXgei
         FnWOfWCDTCIUzQ3plLOQuCORltqvW81ovgI9yps2VY5cG8nGduEsx+7km6szAi6c32DU
         mrStjYhSzUkaL6GKUwT9QlS+jWfIXMNEYn3c5axKcbgWH1oTk7B8UTJcbXKR+Qy9ZaxW
         +Xgg==
X-Forwarded-Encrypted: i=1; AJvYcCVyxsr5eSLgaxhsfZB9otZtaAA6gMlpwJZmRLGnCjW8b1TxF8zqqyuMBUcTsBIi5oYgAzZReh6xeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zS/f5iEoYA5YT9K0NC4iOPEA0usZglEqzq8veby6kmQ+PFcN
	6LeWMlr7zbdyy8qmG9uBruqA7uZvAC2sKToXJHA2u7eXjpQtdH7SVxJ4WGOHtBa17VMSp5hvGvb
	Ya3VG/WrI2dhaT/HfOokxOVsF4hDAJ+1GBoF6ROkR56YNgIG3DSCxDgTy0LL020hMhPSxYOY/
X-Gm-Gg: ASbGncvUD9OKa7K+jGOBzW7/iWyFnxJbyoYW0ZyrfN64zTHOdEy4Z58L1qBjNcxgj2G
	FHK/nzcPij4Mj9L+hoccshWrxXhm+yBgnMAp8G4JH9+E/7BJ6JkqOfgItWup/+gaqMf+U/T4GT5
	VNOowHzzaPP0IXrXzd80OwM0tfbgTl6PCiDDoLfzIA0JDF3bslFb1cbrx+rnwPoEVxTWdwqalCi
	pB3XI2yadisrjMBWT8GK0fU+682bSU3nAXgjVkMC9xGu9J7orbG8LifTs3EYlpX/uyKoR/WoXTh
	ud6P9ZzcTEJT0OrlG9o4pqki1pkK0BF9n+fWj2ZTP2jEEPM9YaCzOGrsTOvP4cAaliC4Rhzjihr
	sxZUIkig3lWkIkUm2tXpsVH0JHs4N+9R3i4g=
X-Received: by 2002:a05:620a:4444:b0:7d4:4e14:2202 with SMTP id af79cd13be357-7d5dcc9c860mr547239785a.13.1751646960279;
        Fri, 04 Jul 2025 09:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkCSuyNGlC8FUWTwwxVjZ5FC5bx32GO9GPyW/ExQggheADM1lk4ihrG9kd5T7Z26Sl6hBD7Q==
X-Received: by 2002:a05:620a:4444:b0:7d4:4e14:2202 with SMTP id af79cd13be357-7d5dcc9c860mr547230885a.13.1751646959278;
        Fri, 04 Jul 2025 09:35:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:32 +0300
Subject: [PATCH v2 20/28] interconnect: qcom: sm6350: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-20-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=48234;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=l/GDK516Pef5aGRtzNj+CYesmUAUaQnjiWHcuthC7RI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALHpiqhxepJoRUaAERMNaEDvi3NKKlcsPkay
 nDVTh8pl9GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxwAKCRCLPIo+Aiko
 1czmCACmKzKGd8356tKQJkrt91n6oh/PpFXxDXmodl858e4khNAZaRjEofzHM7couKlkJudqBpr
 ORlGVWs6jDowUs4i5MejyVV5iAImG00eeadJNSg6rvFK+E9biBVO+8BWPRWLe9Aq5nbQbPpnqrU
 VE+RkVT3kitYH7xvgUarVUPsEEc+tA4KyJ0oFBodZZBIRmYGItQFcJLIiS05o9dtbNeFhXGB0E7
 2K0FBSSGBOujdn0oEMOugj5aLtBPoULf7WVkhiEkEi7P5FuWS/8W5a+bRLRoyAj/a6UUw4a5137
 zcAepcCQFjYYFPY5zBxOJBUkW+hpbKGbgG9EZWorkLYnxlwS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=frrcZE4f c=1 sm=1 tr=0 ts=686802f2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=oxiPl_rVDUTAQTeVsscA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXxDvH4RRUoNF/
 /PZHA/fd6QKZPnJ8W/8Pzzuw1B6xp/47I7xq/BjM5Bkb986/4VN1fkwMTA6poVH4SvLAA5appiS
 9EDjbJu4Ea/9/yJT4NQgsqv7y84uF2zbXtI5DuBnLddxshDAmq8zwpWW1AKgbmra5mxzBiI4b2Q
 MWOKZiN9BAsnXv1BuMW09PZJyOVGbE25NTKyOuiLR+ZZB3YBAx68hGdJeRYYpVTTTr59yy3NrLr
 /nek9kNMBrKCnSsR3Hcl7UPFnI0+xlhdWsvqanHe30KHwSlH4MTXIKic6LHJZS8/8ns/wzGCp20
 tCnESViZLF7RGN4sOf+3gPUG1fLTITCs9exOX9DJ0/K0KOHg+EQwzWrLVsrTQ57L1WNvr1Uq1FD
 WyZXvyRNujCTIvCY/k72yJgThPh43hxLGyRbOuLUZFJt0vfHVhfi4asxuB0u4MGQY9YQUYmA
X-Proofpoint-GUID: UvljsWwm0LwH96hLDTkYv88MLoVzVizg
X-Proofpoint-ORIG-GUID: UvljsWwm0LwH96hLDTkYv88MLoVzVizg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm6350.c | 770 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sm6350.h | 139 -------
 2 files changed, 382 insertions(+), 527 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 016f75ef970648b00a87483a6dee04dd8208726f..92a33c307c960157bf537bc5fe28b0348fbb9918 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -13,1153 +13,1137 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sm6350.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qup_0;
+static struct qcom_icc_node xm_emmc;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup_1;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_icp_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qnm_npu;
+static struct qcom_icc_node qxm_npu_dsp;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc_dc_noc;
+static struct qcom_icc_node acm_apps;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_gpu;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qxm_camnoc_hf;
+static struct qcom_icc_node qxm_camnoc_icp;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node amm_npu_sys;
+static struct qcom_icc_node qhm_npu_cfg;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qns_cdsp_gemnoc;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_boot_rom;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_camera_nrt_thrott_cfg;
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_display_throttle_cfg;
+static struct qcom_icc_node qhs_emmc_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_npu_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qm_cfg;
+static struct qcom_icc_node qhs_qm_mpu_cfg;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_venus_throttle_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_gemnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_mcdma_ms_mpu_cfg;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_cal_dp0;
+static struct qcom_icc_node qhs_cp;
+static struct qcom_icc_node qhs_dma_bwmon;
+static struct qcom_icc_node qhs_dpm;
+static struct qcom_icc_node qhs_isense;
+static struct qcom_icc_node qhs_llm;
+static struct qcom_icc_node qhs_tcm;
+static struct qcom_icc_node qns_npu_sys;
+static struct qcom_icc_node srvc_noc;
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
 	.name = "qhm_a1noc_cfg",
-	.id = SM6350_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup_0 = {
 	.name = "qhm_qup_0",
-	.id = SM6350_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emmc = {
 	.name = "xm_emmc",
-	.id = SM6350_MASTER_EMMC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM6350_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SM6350_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM6350_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup_1 = {
 	.name = "qhm_qup_1",
-	.id = SM6350_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM6350_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM6350_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM6350_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM6350_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM6350_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SM6350_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp_uncomp = {
 	.name = "qxm_camnoc_icp_uncomp",
-	.id = SM6350_MASTER_CAMNOC_ICP_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SM6350_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM6350_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM6350_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SM6350_MASTER_NPU,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_npu_dsp = {
 	.name = "qxm_npu_dsp",
-	.id = SM6350_MASTER_NPU_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SM6350_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 42,
-	.links = { SM6350_SLAVE_CAMERA_CFG,
-		   SM6350_SLAVE_SDCC_2,
-		   SM6350_SLAVE_CNOC_MNOC_CFG,
-		   SM6350_SLAVE_UFS_MEM_CFG,
-		   SM6350_SLAVE_QM_CFG,
-		   SM6350_SLAVE_SNOC_CFG,
-		   SM6350_SLAVE_QM_MPU_CFG,
-		   SM6350_SLAVE_GLM,
-		   SM6350_SLAVE_PDM,
-		   SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SM6350_SLAVE_A2NOC_CFG,
-		   SM6350_SLAVE_QDSS_CFG,
-		   SM6350_SLAVE_VSENSE_CTRL_CFG,
-		   SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SM6350_SLAVE_DISPLAY_CFG,
-		   SM6350_SLAVE_TCSR,
-		   SM6350_SLAVE_DCC_CFG,
-		   SM6350_SLAVE_CNOC_DDRSS,
-		   SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SM6350_SLAVE_NPU_CFG,
-		   SM6350_SLAVE_AHB2PHY,
-		   SM6350_SLAVE_GRAPHICS_3D_CFG,
-		   SM6350_SLAVE_BOOT_ROM,
-		   SM6350_SLAVE_VENUS_CFG,
-		   SM6350_SLAVE_IPA_CFG,
-		   SM6350_SLAVE_SECURITY,
-		   SM6350_SLAVE_IMEM_CFG,
-		   SM6350_SLAVE_CNOC_MSS,
-		   SM6350_SLAVE_SERVICE_CNOC,
-		   SM6350_SLAVE_USB3,
-		   SM6350_SLAVE_VENUS_THROTTLE_CFG,
-		   SM6350_SLAVE_RBCPR_CX_CFG,
-		   SM6350_SLAVE_A1NOC_CFG,
-		   SM6350_SLAVE_AOSS,
-		   SM6350_SLAVE_PRNG,
-		   SM6350_SLAVE_EMMC_CFG,
-		   SM6350_SLAVE_CRYPTO_0_CFG,
-		   SM6350_SLAVE_PIMEM_CFG,
-		   SM6350_SLAVE_RBCPR_MX_CFG,
-		   SM6350_SLAVE_QUP_0,
-		   SM6350_SLAVE_QUP_1,
-		   SM6350_SLAVE_CLK_CTL
-	},
+	.link_nodes = { &qhs_camera_cfg,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_qm_cfg,
+			&qhs_snoc_cfg,
+			&qhs_qm_mpu_cfg,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_camera_nrt_thrott_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_npu_cfg,
+			&qhs_ahb2phy0,
+			&qhs_gpuss_cfg,
+			&qhs_boot_rom,
+			&qhs_venus_cfg,
+			&qhs_ipa,
+			&qhs_security,
+			&qhs_imem_cfg,
+			&qhs_mss_cfg,
+			&srvc_cnoc,
+			&qhs_usb3_0,
+			&qhs_venus_throttle_cfg,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_emmc_cfg,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_cpr_mx,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_clk_ctl, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM6350_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 42,
-	.links = { SM6350_SLAVE_CAMERA_CFG,
-		   SM6350_SLAVE_SDCC_2,
-		   SM6350_SLAVE_CNOC_MNOC_CFG,
-		   SM6350_SLAVE_UFS_MEM_CFG,
-		   SM6350_SLAVE_QM_CFG,
-		   SM6350_SLAVE_SNOC_CFG,
-		   SM6350_SLAVE_QM_MPU_CFG,
-		   SM6350_SLAVE_GLM,
-		   SM6350_SLAVE_PDM,
-		   SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SM6350_SLAVE_A2NOC_CFG,
-		   SM6350_SLAVE_QDSS_CFG,
-		   SM6350_SLAVE_VSENSE_CTRL_CFG,
-		   SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SM6350_SLAVE_DISPLAY_CFG,
-		   SM6350_SLAVE_TCSR,
-		   SM6350_SLAVE_DCC_CFG,
-		   SM6350_SLAVE_CNOC_DDRSS,
-		   SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SM6350_SLAVE_NPU_CFG,
-		   SM6350_SLAVE_AHB2PHY,
-		   SM6350_SLAVE_GRAPHICS_3D_CFG,
-		   SM6350_SLAVE_BOOT_ROM,
-		   SM6350_SLAVE_VENUS_CFG,
-		   SM6350_SLAVE_IPA_CFG,
-		   SM6350_SLAVE_SECURITY,
-		   SM6350_SLAVE_IMEM_CFG,
-		   SM6350_SLAVE_CNOC_MSS,
-		   SM6350_SLAVE_SERVICE_CNOC,
-		   SM6350_SLAVE_USB3,
-		   SM6350_SLAVE_VENUS_THROTTLE_CFG,
-		   SM6350_SLAVE_RBCPR_CX_CFG,
-		   SM6350_SLAVE_A1NOC_CFG,
-		   SM6350_SLAVE_AOSS,
-		   SM6350_SLAVE_PRNG,
-		   SM6350_SLAVE_EMMC_CFG,
-		   SM6350_SLAVE_CRYPTO_0_CFG,
-		   SM6350_SLAVE_PIMEM_CFG,
-		   SM6350_SLAVE_RBCPR_MX_CFG,
-		   SM6350_SLAVE_QUP_0,
-		   SM6350_SLAVE_QUP_1,
-		   SM6350_SLAVE_CLK_CTL
-	},
+	.link_nodes = { &qhs_camera_cfg,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_qm_cfg,
+			&qhs_snoc_cfg,
+			&qhs_qm_mpu_cfg,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_camera_nrt_thrott_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_npu_cfg,
+			&qhs_ahb2phy0,
+			&qhs_gpuss_cfg,
+			&qhs_boot_rom,
+			&qhs_venus_cfg,
+			&qhs_ipa,
+			&qhs_security,
+			&qhs_imem_cfg,
+			&qhs_mss_cfg,
+			&srvc_cnoc,
+			&qhs_usb3_0,
+			&qhs_venus_throttle_cfg,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_emmc_cfg,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_cpr_mx,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_clk_ctl, NULL },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SM6350_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC_CFG,
-		   SM6350_SLAVE_GEM_NOC_CFG
-	},
+	.link_nodes = { &qhs_llcc,
+			&qhs_gemnoc, NULL },
 };
 
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
-	.id = SM6350_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = SM6350_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SM6350_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 3,
-	.links = { SM6350_SLAVE_MCDMA_MS_MPU_CFG,
-		   SM6350_SLAVE_SERVICE_GEM_NOC,
-		   SM6350_SLAVE_MSS_PROC_MS_MPU_CFG
-	},
+	.link_nodes = { &qhs_mcdma_ms_mpu_cfg,
+			&srvc_gemnoc,
+			&qhs_mdsp_ms_mpu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM6350_MASTER_COMPUTE_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM6350_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM6350_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM6350_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM6350_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
-	.id = SM6350_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM6350_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SM6350_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SM6350_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM6350_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
-	.id = SM6350_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
-	.id = SM6350_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SM6350_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM6350_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node amm_npu_sys = {
 	.name = "amm_npu_sys",
-	.id = SM6350_MASTER_NPU_SYS,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys, NULL },
 };
 
 static struct qcom_icc_node qhm_npu_cfg = {
 	.name = "qhm_npu_cfg",
-	.id = SM6350_MASTER_NPU_NOC_CFG,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 8,
-	.links = { SM6350_SLAVE_SERVICE_NPU_NOC,
-		   SM6350_SLAVE_ISENSE_CFG,
-		   SM6350_SLAVE_NPU_LLM_CFG,
-		   SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG,
-		   SM6350_SLAVE_NPU_CP,
-		   SM6350_SLAVE_NPU_TCM,
-		   SM6350_SLAVE_NPU_CAL_DP0,
-		   SM6350_SLAVE_NPU_DPM
-	},
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &srvc_noc,
+			&qhs_isense,
+			&qhs_llm,
+			&qhs_dma_bwmon,
+			&qhs_cp,
+			&qhs_tcm,
+			&qhs_cal_dp0,
+			&qhs_dpm, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SM6350_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM6350_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 6,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_SF,
-		   SM6350_SLAVE_PIMEM,
-		   SM6350_SLAVE_OCIMEM,
-		   SM6350_SLAVE_APPSS,
-		   SM6350_SNOC_CNOC_SLV,
-		   SM6350_SLAVE_QDSS_STM
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
-	.id = SM6350_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 7,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_SF,
-		   SM6350_SLAVE_PIMEM,
-		   SM6350_SLAVE_OCIMEM,
-		   SM6350_SLAVE_APPSS,
-		   SM6350_SNOC_CNOC_SLV,
-		   SM6350_SLAVE_TCU,
-		   SM6350_SLAVE_QDSS_STM
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
-	.id = SM6350_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 6,
-	.links = { SM6350_SLAVE_PIMEM,
-		   SM6350_SLAVE_OCIMEM,
-		   SM6350_SLAVE_APPSS,
-		   SM6350_SNOC_CNOC_SLV,
-		   SM6350_SLAVE_TCU,
-		   SM6350_SLAVE_QDSS_STM
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
-	.id = SM6350_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_GC,
-		   SM6350_SLAVE_OCIMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM6350_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM6350_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM6350_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM6350_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM6350_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SM6350_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM6350_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM6350_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cdsp_gemnoc = {
 	.name = "qns_cdsp_gemnoc",
-	.id = SM6350_SLAVE_CDSP_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SM6350_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SM6350_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM6350_SLAVE_AHB2PHY,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = SM6350_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM6350_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_boot_rom = {
 	.name = "qhs_boot_rom",
-	.id = SM6350_SLAVE_BOOT_ROM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM6350_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_nrt_thrott_cfg = {
 	.name = "qhs_camera_nrt_thrott_cfg",
-	.id = SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
-	.id = SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM6350_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM6350_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM6350_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM6350_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SM6350_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SM6350_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM6350_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_throttle_cfg = {
 	.name = "qhs_display_throttle_cfg",
-	.id = SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emmc_cfg = {
 	.name = "qhs_emmc_cfg",
-	.id = SM6350_SLAVE_EMMC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SM6350_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM6350_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM6350_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM6350_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SM6350_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SM6350_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_npu_cfg = {
 	.name = "qhs_npu_cfg",
-	.id = SM6350_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_NPU_NOC_CFG },
+	.link_nodes = { &qhm_npu_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM6350_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM6350_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM6350_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM6350_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qm_cfg = {
 	.name = "qhs_qm_cfg",
-	.id = SM6350_SLAVE_QM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qm_mpu_cfg = {
 	.name = "qhs_qm_mpu_cfg",
-	.id = SM6350_SLAVE_QM_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SM6350_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM6350_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM6350_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SM6350_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SM6350_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM6350_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM6350_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM6350_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM6350_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_throttle_cfg = {
 	.name = "qhs_venus_throttle_cfg",
-	.id = SM6350_SLAVE_VENUS_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM6350_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM6350_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gemnoc = {
 	.name = "qhs_gemnoc",
-	.id = SM6350_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM6350_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM6350_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mcdma_ms_mpu_cfg = {
 	.name = "qhs_mcdma_ms_mpu_cfg",
-	.id = SM6350_SLAVE_MCDMA_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SM6350_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SM6350_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM6350_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM6350_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SM6350_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM6350_SLAVE_EBI_CH0,
 	.channels = 2,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM6350_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM6350_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM6350_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM6350_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cal_dp0 = {
 	.name = "qhs_cal_dp0",
-	.id = SM6350_SLAVE_NPU_CAL_DP0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cp = {
 	.name = "qhs_cp",
-	.id = SM6350_SLAVE_NPU_CP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dma_bwmon = {
 	.name = "qhs_dma_bwmon",
-	.id = SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dpm = {
 	.name = "qhs_dpm",
-	.id = SM6350_SLAVE_NPU_DPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_isense = {
 	.name = "qhs_isense",
-	.id = SM6350_SLAVE_ISENSE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llm = {
 	.name = "qhs_llm",
-	.id = SM6350_SLAVE_NPU_LLM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcm = {
 	.name = "qhs_tcm",
-	.id = SM6350_SLAVE_NPU_TCM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_npu_sys = {
 	.name = "qns_npu_sys",
-	.id = SM6350_SLAVE_NPU_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_noc = {
 	.name = "srvc_noc",
-	.id = SM6350_SLAVE_SERVICE_NPU_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM6350_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SM6350_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_SNOC_CNOC_MAS },
+	.link_nodes = { &qnm_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM6350_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM6350_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM6350_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM6350_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM6350_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM6350_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM6350_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM6350_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM6350_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1376,6 +1360,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1401,6 +1386,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1428,6 +1414,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1447,6 +1434,7 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1507,6 +1495,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1523,6 +1512,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1554,6 +1544,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1581,6 +1572,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1605,6 +1597,7 @@ static struct qcom_icc_node * const npu_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_npu_noc = {
+	.alloc_dyn_id = true,
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 	.bcms = npu_noc_bcms,
@@ -1641,6 +1634,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm6350.h b/drivers/interconnect/qcom/sm6350.h
deleted file mode 100644
index 43cf2930c88a5ae1bc36600ab2b3661a4d11ca71..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm6350.h
+++ /dev/null
@@ -1,139 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SM6350 interconnect IDs
- *
- * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM6350_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM6350_H
-
-#define SM6350_A1NOC_SNOC_MAS			0
-#define SM6350_A1NOC_SNOC_SLV			1
-#define SM6350_A2NOC_SNOC_MAS			2
-#define SM6350_A2NOC_SNOC_SLV			3
-#define SM6350_MASTER_A1NOC_CFG			4
-#define SM6350_MASTER_A2NOC_CFG			5
-#define SM6350_MASTER_AMPSS_M0			6
-#define SM6350_MASTER_CAMNOC_HF			7
-#define SM6350_MASTER_CAMNOC_HF0_UNCOMP		8
-#define SM6350_MASTER_CAMNOC_ICP		9
-#define SM6350_MASTER_CAMNOC_ICP_UNCOMP		10
-#define SM6350_MASTER_CAMNOC_SF			11
-#define SM6350_MASTER_CAMNOC_SF_UNCOMP		12
-#define SM6350_MASTER_CNOC_DC_NOC		13
-#define SM6350_MASTER_CNOC_MNOC_CFG		14
-#define SM6350_MASTER_COMPUTE_NOC		15
-#define SM6350_MASTER_CRYPTO_CORE_0		16
-#define SM6350_MASTER_EMMC			17
-#define SM6350_MASTER_GEM_NOC_CFG		18
-#define SM6350_MASTER_GEM_NOC_SNOC		19
-#define SM6350_MASTER_GIC			20
-#define SM6350_MASTER_GRAPHICS_3D		21
-#define SM6350_MASTER_IPA			22
-#define SM6350_MASTER_LLCC			23
-#define SM6350_MASTER_MDP_PORT0			24
-#define SM6350_MASTER_MNOC_HF_MEM_NOC		25
-#define SM6350_MASTER_MNOC_SF_MEM_NOC		26
-#define SM6350_MASTER_NPU			27
-#define SM6350_MASTER_NPU_NOC_CFG		28
-#define SM6350_MASTER_NPU_PROC			29
-#define SM6350_MASTER_NPU_SYS			30
-#define SM6350_MASTER_PIMEM			31
-#define SM6350_MASTER_QDSS_BAM			32
-#define SM6350_MASTER_QDSS_DAP			33
-#define SM6350_MASTER_QDSS_ETR			34
-#define SM6350_MASTER_QUP_0			35
-#define SM6350_MASTER_QUP_1			36
-#define SM6350_MASTER_QUP_CORE_0		37
-#define SM6350_MASTER_QUP_CORE_1		38
-#define SM6350_MASTER_SDCC_2			39
-#define SM6350_MASTER_SNOC_CFG			40
-#define SM6350_MASTER_SNOC_GC_MEM_NOC		41
-#define SM6350_MASTER_SNOC_SF_MEM_NOC		42
-#define SM6350_MASTER_SYS_TCU			43
-#define SM6350_MASTER_UFS_MEM			44
-#define SM6350_MASTER_USB3			45
-#define SM6350_MASTER_VIDEO_P0			46
-#define SM6350_MASTER_VIDEO_PROC		47
-#define SM6350_SLAVE_A1NOC_CFG			48
-#define SM6350_SLAVE_A2NOC_CFG			49
-#define SM6350_SLAVE_AHB2PHY			50
-#define SM6350_SLAVE_AHB2PHY_2			51
-#define SM6350_SLAVE_AOSS			52
-#define SM6350_SLAVE_APPSS			53
-#define SM6350_SLAVE_BOOT_ROM			54
-#define SM6350_SLAVE_CAMERA_CFG			55
-#define SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG	56
-#define SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG	57
-#define SM6350_SLAVE_CAMNOC_UNCOMP		58
-#define SM6350_SLAVE_CDSP_GEM_NOC		59
-#define SM6350_SLAVE_CLK_CTL			60
-#define SM6350_SLAVE_CNOC_DDRSS			61
-#define SM6350_SLAVE_CNOC_MNOC_CFG		62
-#define SM6350_SLAVE_CNOC_MSS			63
-#define SM6350_SLAVE_CRYPTO_0_CFG		64
-#define SM6350_SLAVE_DCC_CFG			65
-#define SM6350_SLAVE_DISPLAY_CFG		66
-#define SM6350_SLAVE_DISPLAY_THROTTLE_CFG	67
-#define SM6350_SLAVE_EBI_CH0			68
-#define SM6350_SLAVE_EMMC_CFG			69
-#define SM6350_SLAVE_GEM_NOC_CFG		70
-#define SM6350_SLAVE_GEM_NOC_SNOC		71
-#define SM6350_SLAVE_GLM			72
-#define SM6350_SLAVE_GRAPHICS_3D_CFG		73
-#define SM6350_SLAVE_IMEM_CFG			74
-#define SM6350_SLAVE_IPA_CFG			75
-#define SM6350_SLAVE_ISENSE_CFG			76
-#define SM6350_SLAVE_LLCC			77
-#define SM6350_SLAVE_LLCC_CFG			78
-#define SM6350_SLAVE_MCDMA_MS_MPU_CFG		79
-#define SM6350_SLAVE_MNOC_HF_MEM_NOC		80
-#define SM6350_SLAVE_MNOC_SF_MEM_NOC		81
-#define SM6350_SLAVE_MSS_PROC_MS_MPU_CFG	82
-#define SM6350_SLAVE_NPU_CAL_DP0		83
-#define SM6350_SLAVE_NPU_CFG			84
-#define SM6350_SLAVE_NPU_COMPUTE_NOC		85
-#define SM6350_SLAVE_NPU_CP			86
-#define SM6350_SLAVE_NPU_DPM			87
-#define SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG	88
-#define SM6350_SLAVE_NPU_LLM_CFG		89
-#define SM6350_SLAVE_NPU_TCM			90
-#define SM6350_SLAVE_OCIMEM			91
-#define SM6350_SLAVE_PDM			92
-#define SM6350_SLAVE_PIMEM			93
-#define SM6350_SLAVE_PIMEM_CFG			94
-#define SM6350_SLAVE_PRNG			95
-#define SM6350_SLAVE_QDSS_CFG			96
-#define SM6350_SLAVE_QDSS_STM			97
-#define SM6350_SLAVE_QM_CFG			98
-#define SM6350_SLAVE_QM_MPU_CFG			99
-#define SM6350_SLAVE_QUP_0			100
-#define SM6350_SLAVE_QUP_1			101
-#define SM6350_SLAVE_QUP_CORE_0			102
-#define SM6350_SLAVE_QUP_CORE_1			103
-#define SM6350_SLAVE_RBCPR_CX_CFG		104
-#define SM6350_SLAVE_RBCPR_MX_CFG		105
-#define SM6350_SLAVE_SDCC_2			106
-#define SM6350_SLAVE_SECURITY			107
-#define SM6350_SLAVE_SERVICE_A1NOC		108
-#define SM6350_SLAVE_SERVICE_A2NOC		109
-#define SM6350_SLAVE_SERVICE_CNOC		110
-#define SM6350_SLAVE_SERVICE_GEM_NOC		111
-#define SM6350_SLAVE_SERVICE_MNOC		112
-#define SM6350_SLAVE_SERVICE_NPU_NOC		113
-#define SM6350_SLAVE_SERVICE_SNOC		114
-#define SM6350_SLAVE_SNOC_CFG			115
-#define SM6350_SLAVE_SNOC_GEM_NOC_GC		116
-#define SM6350_SLAVE_SNOC_GEM_NOC_SF		117
-#define SM6350_SLAVE_TCSR			118
-#define SM6350_SLAVE_TCU			119
-#define SM6350_SLAVE_UFS_MEM_CFG		120
-#define SM6350_SLAVE_USB3			121
-#define SM6350_SLAVE_VENUS_CFG			122
-#define SM6350_SLAVE_VENUS_THROTTLE_CFG		123
-#define SM6350_SLAVE_VSENSE_CTRL_CFG		124
-#define SM6350_SNOC_CNOC_MAS			125
-#define SM6350_SNOC_CNOC_SLV			126
-
-#endif

-- 
2.39.5


