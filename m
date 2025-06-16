Return-Path: <linux-pm+bounces-28747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7DADA50B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D729116D119
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1421FC7CA;
	Mon, 16 Jun 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxlyfH6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D41F30CC
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033754; cv=none; b=Hu3SiIh3Z6YCbzRuAgl+WZVfLN+6Lqqbyda7CE953QPuZFCaQqFn7uv2gEoyKg/X4D0N7+9lK1JFZi6o+ZSk98ymL8mP4yBSnsg/Qb0/ljW01Pvqvc5xK7+t5zD3vJ9c18fHFCN138pxdnadOk1nZ0cS496lwkJv6NgjzMr+r7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033754; c=relaxed/simple;
	bh=3bf8TRzsZH6WoEUnaTMAiG8XwfFK5qsNPxMs1nulwQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O22x2Ljprvyn6gzwBPTRlkXHyeoh5NBwSd8FkOGobF2b4acX7CfQjHbpZtnU7DoPOb72c+41J98plqOrCwWndzj+r6nXt/64MC8dl0HZhiE0PoH0qPKj926nt6MC9p70PxhyiBGVKUbQbfeCn11GG9zI4LlerbeT709EamdKQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxlyfH6e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMeKta019267
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bx4Sdr8NiqaeaiHLFn6qxN13t+SoKih+XAmE1YMuj08=; b=jxlyfH6ed+zAltzG
	ZM7qHIyhxVavrONxsNP9ml9KgSvu6tghfnf+2OSq3At+a/kxIP8MexDC6Ap8x03n
	3kqwMlGoJ6REOJMdDah/TL3vvEcgmfFKAnYJeMoUm5B2Q2qHEMhr0G35zDSJBNp5
	Aob8lTcgDILo7mt5YZY5cpT1uvce7aYkvPHNWGOjm9A9M09f3JI9+rt7OqoDtPZz
	ovtGQQXacD1YWrEkHRYlkqU+CvqTqVIQBDNrjsGqW4CvX4GF1nPTxKG/jff5LkmP
	Dx4lhS+NncNTOCTdeedqRqrqGJHMeAEcstehnorVFSCZgzVXKqclGG8LN1Z9VsaT
	jJAprw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hctjxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad8b4c92cso99414246d6.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033747; x=1750638547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx4Sdr8NiqaeaiHLFn6qxN13t+SoKih+XAmE1YMuj08=;
        b=HS6KE4YkbnJ3rcNpdQfGoPfzgEVsWc7NIom10M+9xMfxV1fQsPY2g4PnCNvvxB3d0u
         NQR109C9XwemrvQkcyMXPneQpVGLlhOQf5nWw8ky67b+atjrPbvYTKztZXiI64e+fWKn
         v45KniEEThRio9kxZZjR0E/++jOy4N72I9LOnUsOPykFtZjezAAl+0bj4Tb40siWT1kC
         iWainxZJ4xgnJNrsl85xuMyS32u96+ZcAinMPFORBP1ezK/TJbZAVNxj8mm/zCunTbzS
         81gK6tWwxLmAEocOBgFi7M1vmcOynXjR3q+Wbs9M8w7wTefY7bG3lFejWPY6cTUSCVwZ
         pIbA==
X-Forwarded-Encrypted: i=1; AJvYcCWKDtuciNJHIAYebCAy5x29rBM6WGlK7Z9TRsQGdB6c2/ezOwFl2QHaHOU5OYshZGCTlc5uZE3TTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTM33Uuguc/Y30NxW/YzIMjrp8msQbIgkvJ8wT08iSkiI9MSZ
	ZtHjRLOvQ+3RM4SW7hcb+enc8eoHfaV5KeI8ovgRl6eFSv5KSVEyqBN/7uTDk2gSRpYALsX3Ulx
	Etvgj+kfndHiI8SBE0hCYCG5LL+wx0Lr9H4/qyQsPtahbU1naVUVSjWgThHiKUQ==
X-Gm-Gg: ASbGncuMLgzbY9xB9Mi1Ewjl/+lR14tJ/+Md4C/VwBYLoIm1xwjDlfaLmU+Q3sZPBaz
	QI+ztHMt8VjJljWORUh4rclfsZXvWQOuCAHa8D7zfI2fyCY0IqC4yBo5DglCTeG7TpEnJ5ggT9a
	PvS0d5bDA4FxDGVNbIe5CrJqtlwSyslyI7O5xPX2Lnoq5GowcVY9fPNCGhu8OwCimB4Uh6X8cv5
	zXUV6XqKmRxS2gJB07guIhGVStdtBW3Ne3IXz2axZbRWKilvT4soerOUspafHMqgf4WMWMlMBPQ
	zp7O990QmtRd6YjkcK8OACCiYRiInxWen85Kuw+0nd2PB4a7WAdsXgpqsNhc8SkqLjm4LJg3/lf
	9U+C7YJ76raysq8hdGcL8M+Z7t6CmxrUp/hc=
X-Received: by 2002:ad4:5ecd:0:b0:6fa:ccff:352a with SMTP id 6a1803df08f44-6fb478016d8mr124936336d6.37.1750033746814;
        Sun, 15 Jun 2025 17:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIWYbsi39bmOyAYT3CjsSVvyK4dTd26XcNThJkseXGIrO5bIBtIgV5XO9ipmyPJYsriU0JCQ==
X-Received: by 2002:ad4:5ecd:0:b0:6fa:ccff:352a with SMTP id 6a1803df08f44-6fb478016d8mr124936036d6.37.1750033746214;
        Sun, 15 Jun 2025 17:29:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:29:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:23 +0300
Subject: [PATCH 11/28] interconnect: qcom: qcs615: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-11-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=44958;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3bf8TRzsZH6WoEUnaTMAiG8XwfFK5qsNPxMs1nulwQ8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UjtQaKCskBWu4ngQJmIk3e5nd5YIYRiKuBV
 Cy9tAsQB6mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIwAKCRCLPIo+Aiko
 1XwLCACKgLlR7r7VTEStXuy0nTX/K0b6DA6pYLemREMzzZsrVPb/4Wnx27sVDLOoWtSpPirwOVT
 oTeZuaRZjSBkWOmlSR6xv/hFb1DyBgaxr4yco6smRgJ6e8J/IS8tRQYa/knKOBlcxDVgnoYzJYE
 NpS34sCEMGOpu/M5ojGJWj/7mtmEPhhrPpW0q0/aRXWkKVpCnv9x2WVoe7SXtFJkgpKFLXInRLA
 UJB0bM85iv7ts0qf6m8rM5I0jtgVTmQukVZpyqZVLyzFpkoKSuUc76iAm5+5id1hLaImOWfIMjZ
 ClTdmeF4eblM2fSJxp1d+SCf/u9TlOiB36XL+pNlPw7C+o87
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMCBTYWx0ZWRfX9IyRzXTvkZEI
 +enRW7jZkeeq/8eFFPyGxDUMzGv96YOBI5j3qVASr1/s7kWIIncuj1TFh4+VF22iI7eREHnz36d
 m9lWIM2ac2yXR+K79SgC/2HVjn2wM8RkcpziED+qnIfekRg0r1jvsELBJTZrRl6aN5vXoM7Px/D
 aqA2VUg8pu7uh0/ZfXNpo9YjQOU7d+rn2efGzmNhC0GcTo1J2JBRsSbmI1pIj+zFcxOiJN7sxII
 KHZrA4Ke0+LAbstRDJ2jmlDS+G2kSXDxa13bP5oI0OWH7Bq0+0L9yiAAwTvaKtrt+3Ktrywb98Q
 cjAO90btOOQPaR69wsnrQpYq7dxk4f2Mdvo1dTF7t/rcYAOurLcPW5BYWXBYlVhdriSjlXnfR4n
 xI42Qikb/QMc2+wCaHKmR+Z6XK6hTaeea27QamEMQd7qdgAgK9NcEv/9MSOYL4niGJq+bKxI
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=684f6554 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=fqGdE4ulDXNMkqeDF_EA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 8E2Yqk-ntoXTIYgh5NlBqRV1B7cgmM1n
X-Proofpoint-GUID: 8E2Yqk-ntoXTIYgh5NlBqRV1B7cgmM1n
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
 drivers/interconnect/qcom/qcs615.c | 644 +++++++++++++++++--------------------
 drivers/interconnect/qcom/qcs615.h | 128 --------
 2 files changed, 293 insertions(+), 479 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index acf452b5ed023b2e42b23f7455e57ab124bfa524..4fc58de384e9dec2364d78e89630ef61d0338155 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -13,1058 +13,991 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "qcs615.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_emac_avb;
+static struct qcom_icc_node xm_pcie;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qhm_spdm;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc;
+static struct qcom_icc_node acm_apps;
+static struct qcom_icc_node acm_gpu_tcu;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node ipa_core_master;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qxm_camnoc_hf0;
+static struct qcom_icc_node qxm_camnoc_hf1;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qxm_venus0;
+static struct qcom_icc_node qxm_venus_arm9;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qnm_lpass_anoc;
+static struct qcom_icc_node qnm_pcie_anoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_lpass_snoc;
+static struct qcom_icc_node qns_pcie_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy_east;
+static struct qcom_icc_node qhs_ahb2phy_west;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_emac_avb_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_pcie_config;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spdm;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_east;
+static struct qcom_icc_node qhs_tlmm_south;
+static struct qcom_icc_node qhs_tlmm_west;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb2;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_dc_noc_gemnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_sys_pcie;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ipa_core_slave;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns2_mem_noc;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qns_memnoc_gc;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_pcie;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = QCS615_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = QCS615_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = QCS615_MASTER_QSPI,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = QCS615_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = QCS615_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = QCS615_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = QCS615_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = QCS615_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_LPASS_SNOC },
+	.link_nodes = { &qns_lpass_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_avb = {
 	.name = "xm_emac_avb",
-	.id = QCS615_MASTER_EMAC_EVB,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = QCS615_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_ANOC_PCIE_SNOC },
+	.link_nodes = { &qns_pcie_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = QCS615_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = QCS615_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = QCS615_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = QCS615_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb2 = {
 	.name = "xm_usb2",
-	.id = QCS615_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = QCS615_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = QCS615_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
 	.name = "qxm_camnoc_hf1_uncomp",
-	.id = QCS615_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = QCS615_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qhm_spdm = {
 	.name = "qhm_spdm",
-	.id = QCS615_MASTER_SPDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_CNOC_A2NOC },
+	.link_nodes = { &qns_cnoc_a2noc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = QCS615_MASTER_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 39,
-	.links = { QCS615_SLAVE_A1NOC_CFG, QCS615_SLAVE_AHB2PHY_EAST,
-		   QCS615_SLAVE_AHB2PHY_WEST, QCS615_SLAVE_AOP,
-		   QCS615_SLAVE_AOSS, QCS615_SLAVE_CAMERA_CFG,
-		   QCS615_SLAVE_CLK_CTL, QCS615_SLAVE_RBCPR_CX_CFG,
-		   QCS615_SLAVE_RBCPR_MX_CFG, QCS615_SLAVE_CRYPTO_0_CFG,
-		   QCS615_SLAVE_CNOC_DDRSS, QCS615_SLAVE_DISPLAY_CFG,
-		   QCS615_SLAVE_EMAC_AVB_CFG, QCS615_SLAVE_GLM,
-		   QCS615_SLAVE_GFX3D_CFG, QCS615_SLAVE_IMEM_CFG,
-		   QCS615_SLAVE_IPA_CFG, QCS615_SLAVE_CNOC_MNOC_CFG,
-		   QCS615_SLAVE_PCIE_CFG, QCS615_SLAVE_PIMEM_CFG,
-		   QCS615_SLAVE_PRNG, QCS615_SLAVE_QDSS_CFG,
-		   QCS615_SLAVE_QSPI, QCS615_SLAVE_QUP_0,
-		   QCS615_SLAVE_QUP_1, QCS615_SLAVE_SDCC_1,
-		   QCS615_SLAVE_SDCC_2, QCS615_SLAVE_SNOC_CFG,
-		   QCS615_SLAVE_SPDM_WRAPPER, QCS615_SLAVE_TCSR,
-		   QCS615_SLAVE_TLMM_EAST, QCS615_SLAVE_TLMM_SOUTH,
-		   QCS615_SLAVE_TLMM_WEST, QCS615_SLAVE_UFS_MEM_CFG,
-		   QCS615_SLAVE_USB2, QCS615_SLAVE_USB3,
-		   QCS615_SLAVE_VENUS_CFG, QCS615_SLAVE_VSENSE_CTRL_CFG,
-		   QCS615_SLAVE_SERVICE_CNOC },
+	.link_nodes = { &qhs_a1_noc_cfg, &qhs_ahb2phy_east,
+			&qhs_ahb2phy_west, &qhs_aop,
+			&qhs_aoss, &qhs_camera_cfg,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto0_cfg,
+			&qhs_ddrss_cfg, &qhs_display_cfg,
+			&qhs_emac_avb_cfg, &qhs_glm,
+			&qhs_gpuss_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_mnoc_cfg,
+			&qhs_pcie_config, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_sdc2, &qhs_snoc_cfg,
+			&qhs_spdm, &qhs_tcsr,
+			&qhs_tlmm_east, &qhs_tlmm_south,
+			&qhs_tlmm_west, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = QCS615_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 40,
-	.links = { QCS615_SLAVE_A1NOC_CFG, QCS615_SLAVE_AHB2PHY_EAST,
-		   QCS615_SLAVE_AHB2PHY_WEST, QCS615_SLAVE_AOP,
-		   QCS615_SLAVE_AOSS, QCS615_SLAVE_CAMERA_CFG,
-		   QCS615_SLAVE_CLK_CTL, QCS615_SLAVE_RBCPR_CX_CFG,
-		   QCS615_SLAVE_RBCPR_MX_CFG, QCS615_SLAVE_CRYPTO_0_CFG,
-		   QCS615_SLAVE_CNOC_DDRSS, QCS615_SLAVE_DISPLAY_CFG,
-		   QCS615_SLAVE_EMAC_AVB_CFG, QCS615_SLAVE_GLM,
-		   QCS615_SLAVE_GFX3D_CFG, QCS615_SLAVE_IMEM_CFG,
-		   QCS615_SLAVE_IPA_CFG, QCS615_SLAVE_CNOC_MNOC_CFG,
-		   QCS615_SLAVE_PCIE_CFG, QCS615_SLAVE_PIMEM_CFG,
-		   QCS615_SLAVE_PRNG, QCS615_SLAVE_QDSS_CFG,
-		   QCS615_SLAVE_QSPI, QCS615_SLAVE_QUP_0,
-		   QCS615_SLAVE_QUP_1, QCS615_SLAVE_SDCC_1,
-		   QCS615_SLAVE_SDCC_2, QCS615_SLAVE_SNOC_CFG,
-		   QCS615_SLAVE_SPDM_WRAPPER, QCS615_SLAVE_TCSR,
-		   QCS615_SLAVE_TLMM_EAST, QCS615_SLAVE_TLMM_SOUTH,
-		   QCS615_SLAVE_TLMM_WEST, QCS615_SLAVE_UFS_MEM_CFG,
-		   QCS615_SLAVE_USB2, QCS615_SLAVE_USB3,
-		   QCS615_SLAVE_VENUS_CFG, QCS615_SLAVE_VSENSE_CTRL_CFG,
-		   QCS615_SLAVE_CNOC_A2NOC, QCS615_SLAVE_SERVICE_CNOC },
+	.link_nodes = { &qhs_a1_noc_cfg, &qhs_ahb2phy_east,
+			&qhs_ahb2phy_west, &qhs_aop,
+			&qhs_aoss, &qhs_camera_cfg,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto0_cfg,
+			&qhs_ddrss_cfg, &qhs_display_cfg,
+			&qhs_emac_avb_cfg, &qhs_glm,
+			&qhs_gpuss_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_mnoc_cfg,
+			&qhs_pcie_config, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_sdc2, &qhs_snoc_cfg,
+			&qhs_spdm, &qhs_tcsr,
+			&qhs_tlmm_east, &qhs_tlmm_south,
+			&qhs_tlmm_west, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qns_cnoc_a2noc, &srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qhm_cnoc = {
 	.name = "qhm_cnoc",
-	.id = QCS615_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_DC_NOC_GEMNOC, QCS615_SLAVE_LLCC_CFG },
+	.link_nodes = { &qhs_dc_noc_gemnoc, &qhs_llcc, NULL },
 };
 
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
-	.id = QCS615_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC,
-		   QCS615_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node acm_gpu_tcu = {
 	.name = "acm_gpu_tcu",
-	.id = QCS615_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = QCS615_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = QCS615_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_MSS_PROC_MS_MPU_CFG, QCS615_SLAVE_SERVICE_GEM_NOC },
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg, &srvc_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = QCS615_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = QCS615_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = QCS615_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = QCS615_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = QCS615_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node ipa_core_master = {
 	.name = "ipa_core_master",
-	.id = QCS615_MASTER_IPA_CORE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_IPA_CORE },
+	.link_nodes = { &ipa_core_slave, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = QCS615_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = QCS615_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
-	.id = QCS615_MASTER_CAMNOC_HF0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
-	.id = QCS615_MASTER_CAMNOC_HF1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = QCS615_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = QCS615_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = QCS615_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = QCS615_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = QCS615_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = QCS615_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = QCS615_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 8,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
-		   QCS615_SLAVE_PIMEM, QCS615_SLAVE_PCIE_0,
-		   QCS615_SLAVE_QDSS_STM, QCS615_SLAVE_TCU },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qns_gemnoc_sf, &qxs_imem,
+			&qxs_pimem, &xs_pcie,
+			&xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = QCS615_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 6,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_IMEM, QCS615_SLAVE_PIMEM,
-		   QCS615_SLAVE_QDSS_STM, QCS615_SLAVE_TCU },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qxs_imem, &qxs_pimem,
+			&xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = QCS615_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_anoc = {
 	.name = "qnm_lpass_anoc",
-	.id = QCS615_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 7,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
-		   QCS615_SLAVE_PIMEM, QCS615_SLAVE_PCIE_0,
-		   QCS615_SLAVE_QDSS_STM },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qns_gemnoc_sf, &qxs_imem,
+			&qxs_pimem, &xs_pcie,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie_anoc = {
 	.name = "qnm_pcie_anoc",
-	.id = QCS615_MASTER_ANOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 5,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
-		   QCS615_SLAVE_QDSS_STM },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qns_gemnoc_sf, &qxs_imem,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = QCS615_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_SNOC_MEM_NOC_GC, QCS615_SLAVE_IMEM },
+	.link_nodes = { &qns_memnoc_gc, &qxs_imem, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = QCS615_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { QCS615_SLAVE_SNOC_MEM_NOC_GC, QCS615_SLAVE_IMEM },
+	.link_nodes = { &qns_memnoc_gc, &qxs_imem, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = QCS615_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QCS615_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qns_lpass_snoc = {
 	.name = "qns_lpass_snoc",
-	.id = QCS615_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_LPASS_ANOC },
+	.link_nodes = { &qnm_lpass_anoc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_snoc = {
 	.name = "qns_pcie_snoc",
-	.id = QCS615_SLAVE_ANOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_ANOC_PCIE_SNOC },
+	.link_nodes = { &qnm_pcie_anoc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = QCS615_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = QCS615_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = QCS615_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_east = {
 	.name = "qhs_ahb2phy_east",
-	.id = QCS615_SLAVE_AHB2PHY_EAST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_west = {
 	.name = "qhs_ahb2phy_west",
-	.id = QCS615_SLAVE_AHB2PHY_WEST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = QCS615_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = QCS615_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = QCS615_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = QCS615_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = QCS615_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = QCS615_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = QCS615_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = QCS615_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc, NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = QCS615_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac_avb_cfg = {
 	.name = "qhs_emac_avb_cfg",
-	.id = QCS615_SLAVE_EMAC_AVB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = QCS615_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = QCS615_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = QCS615_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = QCS615_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = QCS615_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_config = {
 	.name = "qhs_pcie_config",
-	.id = QCS615_SLAVE_PCIE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = QCS615_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = QCS615_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = QCS615_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = QCS615_SLAVE_QSPI,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = QCS615_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = QCS615_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = QCS615_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = QCS615_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = QCS615_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_spdm = {
 	.name = "qhs_spdm",
-	.id = QCS615_SLAVE_SPDM_WRAPPER,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = QCS615_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_east = {
 	.name = "qhs_tlmm_east",
-	.id = QCS615_SLAVE_TLMM_EAST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_south = {
 	.name = "qhs_tlmm_south",
-	.id = QCS615_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_west = {
 	.name = "qhs_tlmm_west",
-	.id = QCS615_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = QCS615_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb2 = {
 	.name = "qhs_usb2",
-	.id = QCS615_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = QCS615_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = QCS615_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = QCS615_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = QCS615_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc, NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = QCS615_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dc_noc_gemnoc = {
 	.name = "qhs_dc_noc_gemnoc",
-	.id = QCS615_SLAVE_DC_NOC_GEMNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QCS615_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = QCS615_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = QCS615_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = QCS615_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = QCS615_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QCS615_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = QCS615_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = QCS615_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ipa_core_slave = {
 	.name = "ipa_core_slave",
-	.id = QCS615_SLAVE_IPA_CORE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = QCS615_SLAVE_EBI1,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns2_mem_noc = {
 	.name = "qns2_mem_noc",
-	.id = QCS615_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = QCS615_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QCS615_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = QCS615_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = QCS615_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = QCS615_SLAVE_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_CNOC },
+	.link_nodes = { &qnm_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = QCS615_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_memnoc_gc = {
 	.name = "qns_memnoc_gc",
-	.id = QCS615_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = QCS615_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = QCS615_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = QCS615_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = QCS615_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = QCS615_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = QCS615_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1261,6 +1194,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1279,6 +1213,7 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_camnoc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1337,6 +1272,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1350,6 +1286,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1379,6 +1316,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1395,6 +1333,7 @@ static struct qcom_icc_node * const ipa_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_ipa_virt = {
+	.alloc_dyn_id = true,
 	.nodes = ipa_virt_nodes,
 	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
 	.bcms = ipa_virt_bcms,
@@ -1412,6 +1351,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1440,6 +1380,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1482,6 +1423,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/qcs615.h b/drivers/interconnect/qcom/qcs615.h
deleted file mode 100644
index 66e66c7e23d4ecaf92c2697e695980c3f8663664..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/qcs615.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS615_H
-#define __DRIVERS_INTERCONNECT_QCOM_QCS615_H
-
-#define QCS615_MASTER_A1NOC_CFG				1
-#define QCS615_MASTER_A1NOC_SNOC			2
-#define QCS615_MASTER_ANOC_PCIE_SNOC			3
-#define QCS615_MASTER_APPSS_PROC			4
-#define QCS615_MASTER_BLSP_1				5
-#define QCS615_MASTER_CAMNOC_HF0			6
-#define QCS615_MASTER_CAMNOC_HF0_UNCOMP			7
-#define QCS615_MASTER_CAMNOC_HF1			8
-#define QCS615_MASTER_CAMNOC_HF1_UNCOMP			9
-#define QCS615_MASTER_CAMNOC_SF				10
-#define QCS615_MASTER_CAMNOC_SF_UNCOMP			11
-#define QCS615_MASTER_CNOC_A2NOC			12
-#define QCS615_MASTER_CNOC_DC_NOC			13
-#define QCS615_MASTER_CNOC_MNOC_CFG			14
-#define QCS615_MASTER_CRYPTO				15
-#define QCS615_MASTER_EMAC_EVB				16
-#define QCS615_MASTER_GEM_NOC_CFG			17
-#define QCS615_MASTER_GEM_NOC_PCIE_SNOC			18
-#define QCS615_MASTER_GEM_NOC_SNOC			19
-#define QCS615_MASTER_GFX3D				20
-#define QCS615_MASTER_GIC				21
-#define QCS615_MASTER_GPU_TCU				22
-#define QCS615_MASTER_IPA				23
-#define QCS615_MASTER_IPA_CORE				24
-#define QCS615_MASTER_LLCC				25
-#define QCS615_MASTER_LPASS_ANOC			26
-#define QCS615_MASTER_MDP0				27
-#define QCS615_MASTER_MNOC_HF_MEM_NOC			28
-#define QCS615_MASTER_MNOC_SF_MEM_NOC			29
-#define QCS615_MASTER_PCIE				30
-#define QCS615_MASTER_PIMEM				31
-#define QCS615_MASTER_QDSS_BAM				32
-#define QCS615_MASTER_QDSS_DAP				33
-#define QCS615_MASTER_QDSS_ETR				34
-#define QCS615_MASTER_QSPI				35
-#define QCS615_MASTER_QUP_0				36
-#define QCS615_MASTER_ROTATOR				37
-#define QCS615_MASTER_SDCC_1				38
-#define QCS615_MASTER_SDCC_2				39
-#define QCS615_MASTER_SNOC_CFG				40
-#define QCS615_MASTER_SNOC_CNOC				41
-#define QCS615_MASTER_SNOC_GC_MEM_NOC			42
-#define QCS615_MASTER_SNOC_SF_MEM_NOC			43
-#define QCS615_MASTER_SPDM				44
-#define QCS615_MASTER_SYS_TCU				45
-#define QCS615_MASTER_UFS_MEM				46
-#define QCS615_MASTER_USB2				47
-#define QCS615_MASTER_USB3_0				48
-#define QCS615_MASTER_VIDEO_P0				49
-#define QCS615_MASTER_VIDEO_PROC			50
-#define QCS615_SLAVE_A1NOC_CFG				51
-#define QCS615_SLAVE_A1NOC_SNOC				52
-#define QCS615_SLAVE_AHB2PHY_EAST			53
-#define QCS615_SLAVE_AHB2PHY_WEST			54
-#define QCS615_SLAVE_ANOC_PCIE_SNOC			55
-#define QCS615_SLAVE_AOP				56
-#define QCS615_SLAVE_AOSS				57
-#define QCS615_SLAVE_APPSS				58
-#define QCS615_SLAVE_CAMERA_CFG				59
-#define QCS615_SLAVE_CAMNOC_UNCOMP			60
-#define QCS615_SLAVE_CLK_CTL				61
-#define QCS615_SLAVE_CNOC_A2NOC				62
-#define QCS615_SLAVE_CNOC_DDRSS				63
-#define QCS615_SLAVE_CNOC_MNOC_CFG			64
-#define QCS615_SLAVE_CRYPTO_0_CFG			65
-#define QCS615_SLAVE_DC_NOC_GEMNOC			66
-#define QCS615_SLAVE_DISPLAY_CFG			67
-#define QCS615_SLAVE_EBI1				68
-#define QCS615_SLAVE_EMAC_AVB_CFG			69
-#define QCS615_SLAVE_GEM_NOC_SNOC			70
-#define QCS615_SLAVE_GFX3D_CFG				71
-#define QCS615_SLAVE_GLM				72
-#define QCS615_SLAVE_IMEM				73
-#define QCS615_SLAVE_IMEM_CFG				74
-#define QCS615_SLAVE_IPA_CFG				75
-#define QCS615_SLAVE_IPA_CORE				76
-#define QCS615_SLAVE_LLCC				77
-#define QCS615_SLAVE_LLCC_CFG				78
-#define QCS615_SLAVE_LPASS_SNOC				79
-#define QCS615_SLAVE_MEM_NOC_PCIE_SNOC			80
-#define QCS615_SLAVE_MNOC_HF_MEM_NOC			81
-#define QCS615_SLAVE_MNOC_SF_MEM_NOC			82
-#define QCS615_SLAVE_MSS_PROC_MS_MPU_CFG		83
-#define QCS615_SLAVE_PCIE_0				84
-#define QCS615_SLAVE_PCIE_CFG				85
-#define QCS615_SLAVE_PIMEM				86
-#define QCS615_SLAVE_PIMEM_CFG				87
-#define QCS615_SLAVE_PRNG				88
-#define QCS615_SLAVE_QDSS_CFG				89
-#define QCS615_SLAVE_QDSS_STM				90
-#define QCS615_SLAVE_QSPI				91
-#define QCS615_SLAVE_QUP_0				92
-#define QCS615_SLAVE_QUP_1				93
-#define QCS615_SLAVE_RBCPR_CX_CFG			94
-#define QCS615_SLAVE_RBCPR_MX_CFG			95
-#define QCS615_SLAVE_SDCC_1				96
-#define QCS615_SLAVE_SDCC_2				97
-#define QCS615_SLAVE_SERVICE_A2NOC			98
-#define QCS615_SLAVE_SERVICE_CNOC			99
-#define QCS615_SLAVE_SERVICE_GEM_NOC			100
-#define QCS615_SLAVE_SERVICE_MNOC			101
-#define QCS615_SLAVE_SERVICE_SNOC			102
-#define QCS615_SLAVE_SNOC_CFG				103
-#define QCS615_SLAVE_SNOC_CNOC				104
-#define QCS615_SLAVE_SNOC_GEM_NOC_SF			105
-#define QCS615_SLAVE_SNOC_MEM_NOC_GC			106
-#define QCS615_SLAVE_SPDM_WRAPPER			107
-#define QCS615_SLAVE_TCSR				108
-#define QCS615_SLAVE_TCU				109
-#define QCS615_SLAVE_TLMM_EAST				110
-#define QCS615_SLAVE_TLMM_SOUTH				111
-#define QCS615_SLAVE_TLMM_WEST				112
-#define QCS615_SLAVE_UFS_MEM_CFG			113
-#define QCS615_SLAVE_USB2				114
-#define QCS615_SLAVE_USB3				115
-#define QCS615_SLAVE_VENUS_CFG				116
-#define QCS615_SLAVE_VSENSE_CTRL_CFG			117
-
-#endif
-

-- 
2.39.5


