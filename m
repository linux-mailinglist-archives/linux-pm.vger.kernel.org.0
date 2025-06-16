Return-Path: <linux-pm+bounces-28743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4EADA500
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E7216D2BC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463BC1DE3DB;
	Mon, 16 Jun 2025 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p80X+eDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F51A31
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033740; cv=none; b=hpaCoarJ1WSZuZPhW5la90Qfmg/5hakX/31HQdVMQLY2Qff0dDNlE6MGaJoImKF27FKOPPJeT3O19XYKRqiuMOjYGVTG+H5d1Hwl+A5gNIzeMv1c8VCtFbyeFVta9DcqqB8Qq4DqzT8MiOhGpofsdw7U816LlxPPlaV+20RsrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033740; c=relaxed/simple;
	bh=/5lFy9Wl/LvoHc4nf7rVM5uc4Aavy8cOu4twP02b7eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUHi4sgwU/vrgzuqadjPVUf3XG0ZW8bbsGiJa3zqLZhiF9xmvmwnOXwNBhOSnx7zgejRHWvKVYFoYtU0xX8md0DRHz6UL5AMTRGp8uA+7N26QW9h9GJ32AUIrCgnjeC9QNeUR1RU2NlYOzUO/o9hZfKr3xnHhAOD6PiBWxLalUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p80X+eDW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMbJEK012297
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oA//hSnjS6jPYNi1Q2R6UFNBxnk0WO9USaL64c2V/oA=; b=p80X+eDW2vGy1n8f
	Pbhj08C70NCQTL1E5i02HqTWimtjxfXDamsca6/kYUrG0R0SXV+M0RqSnETmBRhZ
	5eEzEbjwtqQPmgNzyZ8a4XtQ3S58JHwqI8jvuLnMTPRHTjCQdcjQpFLv2Az4xuPT
	mR50qtTNHauPbyuhdRl+nUDxiVPVPFZ+f4gh3fRBJ/Jzfmxz50Fkb6O8ReJimKN4
	j198M1ZkxBoz1eQRq/NlfUexcUlqZLC/2LM61WcYSgvM4/MF3Ig8ANOPPMsPJ7lT
	Uh0+UFeiMcj4/gyuY7Ogc8tJBk9fNNm8y/oaR+j7SODwRtfd9mW3CbCbyK9y0w4H
	h6pOVA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791ugahrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fad29c1b72so56369966d6.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033733; x=1750638533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA//hSnjS6jPYNi1Q2R6UFNBxnk0WO9USaL64c2V/oA=;
        b=nNfQeC35hHpRjyFhCCpfPUfOhMgps/bmA3DWwgQdn9q71kDQLqPE5Beh4GxKeuztBC
         Of0RDthx5ycN5CGLNUHwE7bR3A57MIQavtSmMGru7lOzH7JHuozW0lXcjfO6b1xnHcOa
         ybzglw/RwB9kTtdqCZnTSWnd3VexAhAfE4yJtznNG14SQuoHleyjnn1DT+2z3l9JVdXN
         NkxTS3onSgfQy0r0cNgDfmfwR/ILB+7B+7KToue4jwQKywAooMOVMbWSYyCbpk1vMZBQ
         gEkrWf1AtsP+6gzxwTvi9uL6hGZUZ/xb+NrrGoIQ0hCx2WtxYsO9dDnBS+mWRr9fvX7o
         NSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9ighxyc39uNuxrkfYEEv84Got8SfwfNjFIFDYh06zemnWIFcNLduc2h/fWrK4JfNhQLvxLOSf3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyQl5kageTYuYRg0FXmbZ9JMoYBrhxdu+sknwd4ypzmEUKg4l
	11h3t+CkGdHTFL56DgsH5I0BZW7QKPRLERgz1XqLh5/Lw9Sd/6m2Fe476WuB5lg8cILmMwpIyTL
	z8KqMWoJTOLQ/MTJtd+u8hfXe+Zw/vRFLWqjTHitkVJrtd4atiGaShuyXDndobA==
X-Gm-Gg: ASbGnct+ozP4BFZTWC/MWMA1VjspBdtn1gL8J77olOJITNg4Y6uELsNrtV4j97SJBnE
	s4jjjrHrC4llIDD0SG/OSoodAV3m7Q7vfkFLwYxksi00AeHkj3Dqkg/W/bSuJCFKI5lFytsHd0o
	hq0yHwgcHc0qG8WS1y1xZe7sUFoHbvM7ppngx7qcA3lpuL84vPXq3mtrPDwEPEkC2GgDy2MlGiN
	SLKLBXqXDBLnimPjytiQ9dWRiyw9Bq2ndXejNcLpF5RUQAw7qwP5wYcOvatiFiRnk7hid6Y4arn
	/e8o0JZfjHvBOp99DrojSI2Iy1wKs+3CoZ7ts3rNFrZbAoGy59fAwRq5V9tQb/90k2ENTYGptOi
	1Vn52TWYtrGlY3+APrA9d2Oi0YetnSnvK7wc=
X-Received: by 2002:a05:6214:2244:b0:6fa:ffff:d7d8 with SMTP id 6a1803df08f44-6fb4724992dmr119943996d6.0.1750033732088;
        Sun, 15 Jun 2025 17:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5BzbnkH+qIrAS+KlOsgevMPQcq9doIQc0xdFBD2NjZQ/E+tgp+tMKPAWKUtfA1kwA9Wbfnw==
X-Received: by 2002:a05:6214:2244:b0:6fa:ffff:d7d8 with SMTP id 6a1803df08f44-6fb4724992dmr119943726d6.0.1750033731379;
        Sun, 15 Jun 2025 17:28:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:19 +0300
Subject: [PATCH 07/28] interconnect: qcom: sc8280xp: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-7-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=74537;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/5lFy9Wl/LvoHc4nf7rVM5uc4Aavy8cOu4twP02b7eM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2Ui+udi9o+1AEzo7MrGxpuQxvp+M9Ll5Rj4g
 hdTm/W2/g2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIgAKCRCLPIo+Aiko
 1XANCACK0rnJZ4gSLHJRwUVlxaJnHh+DmlSaqSvA5W4gjjN7c6RO7cX0tRzBxZdGEnZXZTwR8bw
 Ork1FcT9Fqk3JWVwDScFcFlT+BlzzbtxKxQ/RDjuQgg6331yarMAZ7ZAYDeasehhjrhpoqlVidE
 597L/pQhBeHXJ2Y0SBT5OAZe8x1OcCtAnAzXkayzrOvs53QEQExF0J2jxYJcIPeYyAMIPSoRsHP
 5zmDs7OXbuyk2WjlHR2sFPFQSQHeVz9/Yscce+QYEgSaDGIcTXcfCZ89qLaA8n5q6BTuZ8O6C+M
 4Qwl9DwYkk1URUEl5WZc5Q+ET8H2k1ZO4p5BaLLvSjkzfT8E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX6ndSiRandUvC
 N6UxDzC2bI5zVri0OjdkPoLG2aEFFaU3p4C6CqtNxpPZXw2VmxbfZqGehxqVDmtMVl/FaFVR1pu
 S0fuPbHy+4YIDJl7rEEO27AfgzN7Dxz+ajyY6dVZGQDW/CCbhcwPl1gZqauK98mOQY0YtXWAQ36
 F9l6VUkE3047n9mEty72F0bgPyo2T2akebffYFWN5pMJ1VvAlvv2ZgN/QUuoM5/40wQkRIP/CzI
 o7gC92StdeCuaj9BXwOTNxAmrPMEUiRfQh1UtuNzqIrWjlhNUdfY+pqPA8lOlrwnWiHwwvFxzsy
 GJ/82LxmfPU3qa1dwyMJTszOoFTcDnX1HOoe8HHmBPwj4ro9pqE5CPGUQDoafQWWRov6IK013vO
 L2lnMb4n/wrO75XRKJsnC+fdht9hTSbykITm7w5UkwD8ZgewKlTMUG68ThXECupvnqQrhJPW
X-Proofpoint-GUID: qvvOUsOTs-4Py4-lN9_yjw4ngcHNnISs
X-Authority-Analysis: v=2.4 cv=NtnRc9dJ c=1 sm=1 tr=0 ts=684f6546 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=NjmkkNhIjjFqeOvid_0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: qvvOUsOTs-4Py4-lN9_yjw4ngcHNnISs
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
 drivers/interconnect/qcom/sc8280xp.c | 1181 +++++++++++++++++-----------------
 drivers/interconnect/qcom/sc8280xp.h |  209 ------
 2 files changed, 587 insertions(+), 803 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 1a9b97aa9e1c5bec0cda12cb4c5a8b14af970358..d9fd67ae6258d66ab3e78e06863a5a42da3ac131 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -14,1701 +14,1682 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sc8280xp.h"
+
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qnm_a1noc_cfg;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_emac_1;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node xm_usb3_mp;
+static struct qcom_icc_node xm_usb4_host0;
+static struct qcom_icc_node xm_usb4_host1;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qnm_a2noc_cfg;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_sensorss_q6;
+static struct qcom_icc_node qxm_sp;
+static struct qcom_icc_node xm_emac_0;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_pcie3_2a;
+static struct qcom_icc_node xm_pcie3_2b;
+static struct qcom_icc_node xm_pcie3_3a;
+static struct qcom_icc_node xm_pcie3_3b;
+static struct qcom_icc_node xm_pcie3_4;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_ufs_card;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup2_core_master;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qnm_cnoc_dc_noc;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_pcie_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_cmpnoc0;
+static struct qcom_icc_node qnm_cmpnoc1;
+static struct qcom_icc_node qnm_gemnoc_cfg;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qhm_config_noc;
+static struct qcom_icc_node qxm_lpass_dsp;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_mdp0_0;
+static struct qcom_icc_node qnm_mdp0_1;
+static struct qcom_icc_node qnm_mdp1_0;
+static struct qcom_icc_node qnm_mdp1_1;
+static struct qcom_icc_node qnm_mnoc_cfg;
+static struct qcom_icc_node qnm_rot_0;
+static struct qcom_icc_node qnm_rot_1;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video1;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qxm_camnoc_icp;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qhm_nsp_noc_config;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node qhm_nspb_noc_config;
+static struct qcom_icc_node qxm_nspb;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_aggre_usb_noc;
+static struct qcom_icc_node qnm_lpass_noc;
+static struct qcom_icc_node qnm_snoc_cfg;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_aggre_usb_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_pcie_gem_noc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute0_cfg;
+static struct qcom_icc_node qhs_compute1_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_cpr_nspcx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_display0_cfg;
+static struct qcom_icc_node qhs_display1_cfg;
+static struct qcom_icc_node qhs_emac0_cfg;
+static struct qcom_icc_node qhs_emac1_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_hwkm;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_lpass_cfg;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_mxc_rdpm;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie2a_cfg;
+static struct qcom_icc_node qhs_pcie2b_cfg;
+static struct qcom_icc_node qhs_pcie3a_cfg;
+static struct qcom_icc_node qhs_pcie3b_cfg;
+static struct qcom_icc_node qhs_pcie4_cfg;
+static struct qcom_icc_node qhs_pcie_rsc_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_pka_wrapper_cfg;
+static struct qcom_icc_node qhs_pmu_wrapper_cfg;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_smmuv3_cfg;
+static struct qcom_icc_node qhs_smss_cfg;
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_card_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_usb3_1;
+static struct qcom_icc_node qhs_usb3_mp;
+static struct qcom_icc_node qhs_usb4_host_0;
+static struct qcom_icc_node qhs_usb4_host_1;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_r_cfg;
+static struct qcom_icc_node qns_a1_noc_cfg;
+static struct qcom_icc_node qns_a2_noc_cfg;
+static struct qcom_icc_node qns_anoc_pcie_bridge_cfg;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_mnoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qns_snoc_sf_bridge_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_pcie_2a;
+static struct qcom_icc_node xs_pcie_2b;
+static struct qcom_icc_node xs_pcie_3a;
+static struct qcom_icc_node xs_pcie_3b;
+static struct qcom_icc_node xs_pcie_4;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_smss;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qns_gemnoc;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node srvc_even_gemnoc;
+static struct qcom_icc_node srvc_odd_gemnoc;
+static struct qcom_icc_node srvc_sys_gemnoc;
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
+static struct qcom_icc_node qxs_nsp_xfr;
+static struct qcom_icc_node service_nsp_noc;
+static struct qcom_icc_node qns_nspb_gemnoc;
+static struct qcom_icc_node qxs_nspb_xfr;
+static struct qcom_icc_node service_nspb_noc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node srvc_snoc;
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SC8280XP_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SC8280XP_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SC8280XP_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a1noc_cfg = {
 	.name = "qnm_a1noc_cfg",
-	.id = SC8280XP_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SC8280XP_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_1 = {
 	.name = "xm_emac_1",
-	.id = SC8280XP_MASTER_EMAC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SC8280XP_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SC8280XP_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SC8280XP_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SC8280XP_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_mp = {
 	.name = "xm_usb3_mp",
-	.id = SC8280XP_MASTER_USB3_MP,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb4_host0 = {
 	.name = "xm_usb4_host0",
-	.id = SC8280XP_MASTER_USB4_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb4_host1 = {
 	.name = "xm_usb4_host1",
-	.id = SC8280XP_MASTER_USB4_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SC8280XP_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SC8280XP_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a2noc_cfg = {
 	.name = "qnm_a2noc_cfg",
-	.id = SC8280XP_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SC8280XP_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_sensorss_q6 = {
 	.name = "qxm_sensorss_q6",
-	.id = SC8280XP_MASTER_SENSORS_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_sp = {
 	.name = "qxm_sp",
-	.id = SC8280XP_MASTER_SP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
-	.id = SC8280XP_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SC8280XP_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SC8280XP_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_2a = {
 	.name = "xm_pcie3_2a",
-	.id = SC8280XP_MASTER_PCIE_2A,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_2b = {
 	.name = "xm_pcie3_2b",
-	.id = SC8280XP_MASTER_PCIE_2B,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_3a = {
 	.name = "xm_pcie3_3a",
-	.id = SC8280XP_MASTER_PCIE_3A,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_3b = {
 	.name = "xm_pcie3_3b",
-	.id = SC8280XP_MASTER_PCIE_3B,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_4 = {
 	.name = "xm_pcie3_4",
-	.id = SC8280XP_MASTER_PCIE_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SC8280XP_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SC8280XP_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
-	.id = SC8280XP_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SC8280XP_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SC8280XP_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SC8280XP_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SC8280XP_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 76,
-	.links = { SC8280XP_SLAVE_AHB2PHY_0,
-		   SC8280XP_SLAVE_AHB2PHY_1,
-		   SC8280XP_SLAVE_AHB2PHY_2,
-		   SC8280XP_SLAVE_AOSS,
-		   SC8280XP_SLAVE_APPSS,
-		   SC8280XP_SLAVE_CAMERA_CFG,
-		   SC8280XP_SLAVE_CLK_CTL,
-		   SC8280XP_SLAVE_CDSP_CFG,
-		   SC8280XP_SLAVE_CDSP1_CFG,
-		   SC8280XP_SLAVE_RBCPR_CX_CFG,
-		   SC8280XP_SLAVE_RBCPR_MMCX_CFG,
-		   SC8280XP_SLAVE_RBCPR_MX_CFG,
-		   SC8280XP_SLAVE_CPR_NSPCX,
-		   SC8280XP_SLAVE_CRYPTO_0_CFG,
-		   SC8280XP_SLAVE_CX_RDPM,
-		   SC8280XP_SLAVE_DCC_CFG,
-		   SC8280XP_SLAVE_DISPLAY_CFG,
-		   SC8280XP_SLAVE_DISPLAY1_CFG,
-		   SC8280XP_SLAVE_EMAC_CFG,
-		   SC8280XP_SLAVE_EMAC1_CFG,
-		   SC8280XP_SLAVE_GFX3D_CFG,
-		   SC8280XP_SLAVE_HWKM,
-		   SC8280XP_SLAVE_IMEM_CFG,
-		   SC8280XP_SLAVE_IPA_CFG,
-		   SC8280XP_SLAVE_IPC_ROUTER_CFG,
-		   SC8280XP_SLAVE_LPASS,
-		   SC8280XP_SLAVE_MX_RDPM,
-		   SC8280XP_SLAVE_MXC_RDPM,
-		   SC8280XP_SLAVE_PCIE_0_CFG,
-		   SC8280XP_SLAVE_PCIE_1_CFG,
-		   SC8280XP_SLAVE_PCIE_2A_CFG,
-		   SC8280XP_SLAVE_PCIE_2B_CFG,
-		   SC8280XP_SLAVE_PCIE_3A_CFG,
-		   SC8280XP_SLAVE_PCIE_3B_CFG,
-		   SC8280XP_SLAVE_PCIE_4_CFG,
-		   SC8280XP_SLAVE_PCIE_RSC_CFG,
-		   SC8280XP_SLAVE_PDM,
-		   SC8280XP_SLAVE_PIMEM_CFG,
-		   SC8280XP_SLAVE_PKA_WRAPPER_CFG,
-		   SC8280XP_SLAVE_PMU_WRAPPER_CFG,
-		   SC8280XP_SLAVE_QDSS_CFG,
-		   SC8280XP_SLAVE_QSPI_0,
-		   SC8280XP_SLAVE_QUP_0,
-		   SC8280XP_SLAVE_QUP_1,
-		   SC8280XP_SLAVE_QUP_2,
-		   SC8280XP_SLAVE_SDCC_2,
-		   SC8280XP_SLAVE_SDCC_4,
-		   SC8280XP_SLAVE_SECURITY,
-		   SC8280XP_SLAVE_SMMUV3_CFG,
-		   SC8280XP_SLAVE_SMSS_CFG,
-		   SC8280XP_SLAVE_SPSS_CFG,
-		   SC8280XP_SLAVE_TCSR,
-		   SC8280XP_SLAVE_TLMM,
-		   SC8280XP_SLAVE_UFS_CARD_CFG,
-		   SC8280XP_SLAVE_UFS_MEM_CFG,
-		   SC8280XP_SLAVE_USB3_0,
-		   SC8280XP_SLAVE_USB3_1,
-		   SC8280XP_SLAVE_USB3_MP,
-		   SC8280XP_SLAVE_USB4_0,
-		   SC8280XP_SLAVE_USB4_1,
-		   SC8280XP_SLAVE_VENUS_CFG,
-		   SC8280XP_SLAVE_VSENSE_CTRL_CFG,
-		   SC8280XP_SLAVE_VSENSE_CTRL_R_CFG,
-		   SC8280XP_SLAVE_A1NOC_CFG,
-		   SC8280XP_SLAVE_A2NOC_CFG,
-		   SC8280XP_SLAVE_ANOC_PCIE_BRIDGE_CFG,
-		   SC8280XP_SLAVE_DDRSS_CFG,
-		   SC8280XP_SLAVE_CNOC_MNOC_CFG,
-		   SC8280XP_SLAVE_SNOC_CFG,
-		   SC8280XP_SLAVE_SNOC_SF_BRIDGE_CFG,
-		   SC8280XP_SLAVE_IMEM,
-		   SC8280XP_SLAVE_PIMEM,
-		   SC8280XP_SLAVE_SERVICE_CNOC,
-		   SC8280XP_SLAVE_QDSS_STM,
-		   SC8280XP_SLAVE_SMSS,
-		   SC8280XP_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_ahb2phy0,
+			&qhs_ahb2phy1,
+			&qhs_ahb2phy2,
+			&qhs_aoss,
+			&qhs_apss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute0_cfg,
+			&qhs_compute1_cfg,
+			&qhs_cpr_cx,
+			&qhs_cpr_mmcx,
+			&qhs_cpr_mx,
+			&qhs_cpr_nspcx,
+			&qhs_crypto0_cfg,
+			&qhs_cx_rdpm,
+			&qhs_dcc_cfg,
+			&qhs_display0_cfg,
+			&qhs_display1_cfg,
+			&qhs_emac0_cfg,
+			&qhs_emac1_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_hwkm,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_ipc_router,
+			&qhs_lpass_cfg,
+			&qhs_mx_rdpm,
+			&qhs_mxc_rdpm,
+			&qhs_pcie0_cfg,
+			&qhs_pcie1_cfg,
+			&qhs_pcie2a_cfg,
+			&qhs_pcie2b_cfg,
+			&qhs_pcie3a_cfg,
+			&qhs_pcie3b_cfg,
+			&qhs_pcie4_cfg,
+			&qhs_pcie_rsc_cfg,
+			&qhs_pdm,
+			&qhs_pimem_cfg,
+			&qhs_pka_wrapper_cfg,
+			&qhs_pmu_wrapper_cfg,
+			&qhs_qdss_cfg,
+			&qhs_qspi,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_qup2,
+			&qhs_sdc2,
+			&qhs_sdc4,
+			&qhs_security,
+			&qhs_smmuv3_cfg,
+			&qhs_smss_cfg,
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_usb3_mp,
+			&qhs_usb4_host_0,
+			&qhs_usb4_host_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_vsense_ctrl_r_cfg,
+			&qns_a1_noc_cfg,
+			&qns_a2_noc_cfg,
+			&qns_anoc_pcie_bridge_cfg,
+			&qns_ddrss_cfg,
+			&qns_mnoc_cfg,
+			&qns_snoc_cfg,
+			&qns_snoc_sf_bridge_cfg,
+			&qxs_imem,
+			&qxs_pimem,
+			&srvc_cnoc,
+			&xs_qdss_stm,
+			&xs_smss,
+			&xs_sys_tcu_cfg,
+			NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SC8280XP_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 7,
-	.links = { SC8280XP_SLAVE_PCIE_0,
-		   SC8280XP_SLAVE_PCIE_1,
-		   SC8280XP_SLAVE_PCIE_2A,
-		   SC8280XP_SLAVE_PCIE_2B,
-		   SC8280XP_SLAVE_PCIE_3A,
-		   SC8280XP_SLAVE_PCIE_3B,
-		   SC8280XP_SLAVE_PCIE_4
-	},
+	.link_nodes = { &xs_pcie_0,
+			&xs_pcie_1,
+			&xs_pcie_2a,
+			&xs_pcie_2b,
+			&xs_pcie_3a,
+			&xs_pcie_3b,
+			&xs_pcie_4, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
-	.id = SC8280XP_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_LLCC_CFG,
-		   SC8280XP_SLAVE_GEM_NOC_CFG
-	},
+	.link_nodes = { &qhs_llcc,
+			&qns_gemnoc, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SC8280XP_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
-	.id = SC8280XP_MASTER_PCIE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SC8280XP_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SC8280XP_MASTER_APPSS_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC,
-		   SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc0 = {
 	.name = "qnm_cmpnoc0",
-	.id = SC8280XP_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc1 = {
 	.name = "qnm_cmpnoc1",
-	.id = SC8280XP_MASTER_COMPUTE_NOC_1,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SC8280XP_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 3,
-	.links = { SC8280XP_SLAVE_SERVICE_GEM_NOC_1,
-		   SC8280XP_SLAVE_SERVICE_GEM_NOC_2,
-		   SC8280XP_SLAVE_SERVICE_GEM_NOC
-	},
+	.link_nodes = { &srvc_even_gemnoc,
+			&srvc_odd_gemnoc,
+			&srvc_sys_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SC8280XP_MASTER_GFX3D,
 	.channels = 4,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SC8280XP_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_LLCC,
-		   SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SC8280XP_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SC8280XP_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SC8280XP_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SC8280XP_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SC8280XP_SLAVE_GEM_NOC_CNOC,
-		   SC8280XP_SLAVE_LLCC,
-		   SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC },
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SC8280XP_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 6,
-	.links = { SC8280XP_SLAVE_LPASS_CORE_CFG,
-		   SC8280XP_SLAVE_LPASS_LPI_CFG,
-		   SC8280XP_SLAVE_LPASS_MPU_CFG,
-		   SC8280XP_SLAVE_LPASS_TOP_CFG,
-		   SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC,
-		   SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC
-	},
+	.link_nodes = { &qhs_lpass_core,
+			&qhs_lpass_lpi,
+			&qhs_lpass_mpu,
+			&qhs_lpass_top,
+			&srvc_niu_aml_noc,
+			&srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_lpass_dsp = {
 	.name = "qxm_lpass_dsp",
-	.id = SC8280XP_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 4,
-	.links = { SC8280XP_SLAVE_LPASS_TOP_CFG,
-		   SC8280XP_SLAVE_LPASS_SNOC,
-		   SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC,
-		   SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC
-	},
+	.link_nodes = { &qhs_lpass_top,
+			&qns_sysnoc,
+			&srvc_niu_aml_noc,
+			&srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SC8280XP_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SC8280XP_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp0_0 = {
 	.name = "qnm_mdp0_0",
-	.id = SC8280XP_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp0_1 = {
 	.name = "qnm_mdp0_1",
-	.id = SC8280XP_MASTER_MDP1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp1_0 = {
 	.name = "qnm_mdp1_0",
-	.id = SC8280XP_MASTER_MDP_CORE1_0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp1_1 = {
 	.name = "qnm_mdp1_1",
-	.id = SC8280XP_MASTER_MDP_CORE1_1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_cfg = {
 	.name = "qnm_mnoc_cfg",
-	.id = SC8280XP_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_rot_0 = {
 	.name = "qnm_rot_0",
-	.id = SC8280XP_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_rot_1 = {
 	.name = "qnm_rot_1",
-	.id = SC8280XP_MASTER_ROTATOR_1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SC8280XP_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
-	.id = SC8280XP_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SC8280XP_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
-	.id = SC8280XP_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SC8280XP_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SC8280XP_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SC8280XP_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_CDSP_MEM_NOC,
-		   SC8280XP_SLAVE_NSP_XFR
-	},
+	.link_nodes = { &qns_nsp_gemnoc,
+				&qxs_nsp_xfr, NULL },
 };
 
 static struct qcom_icc_node qhm_nspb_noc_config = {
 	.name = "qhm_nspb_noc_config",
-	.id = SC8280XP_MASTER_CDSPB_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SERVICE_NSPB_NOC },
+	.link_nodes = { &service_nspb_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nspb = {
 	.name = "qxm_nspb",
-	.id = SC8280XP_MASTER_CDSP_PROC_B,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SC8280XP_SLAVE_CDSPB_MEM_NOC,
-		   SC8280XP_SLAVE_NSPB_XFR
-	},
+	.link_nodes = { &qns_nspb_gemnoc,
+			&qxs_nspb_xfr, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SC8280XP_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SC8280XP_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_usb_noc = {
 	.name = "qnm_aggre_usb_noc",
-	.id = SC8280XP_MASTER_USB_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
-	.id = SC8280XP_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SC8280XP_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SC8280XP_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SC8280XP_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SC8280XP_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qns_aggre_usb_snoc = {
 	.name = "qns_aggre_usb_snoc",
-	.id = SC8280XP_SLAVE_USB_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_USB_NOC_SNOC },
+	.link_nodes = { &qnm_aggre_usb_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SC8280XP_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SC8280XP_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_gem_noc = {
 	.name = "qns_pcie_gem_noc",
-	.id = SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SC8280XP_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SC8280XP_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SC8280XP_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SC8280XP_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SC8280XP_SLAVE_AHB2PHY_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SC8280XP_SLAVE_AHB2PHY_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = SC8280XP_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SC8280XP_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SC8280XP_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SC8280XP_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SC8280XP_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute0_cfg = {
 	.name = "qhs_compute0_cfg",
-	.id = SC8280XP_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_CDSP_NOC_CFG },
+	.link_nodes = { &qhm_nsp_noc_config, NULL },
 };
 
 static struct qcom_icc_node qhs_compute1_cfg = {
 	.name = "qhs_compute1_cfg",
-	.id = SC8280XP_SLAVE_CDSP1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_CDSPB_NOC_CFG },
+	.link_nodes = { &qhm_nspb_noc_config, NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SC8280XP_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SC8280XP_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SC8280XP_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_nspcx = {
 	.name = "qhs_cpr_nspcx",
-	.id = SC8280XP_SLAVE_CPR_NSPCX,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SC8280XP_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SC8280XP_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SC8280XP_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display0_cfg = {
 	.name = "qhs_display0_cfg",
-	.id = SC8280XP_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display1_cfg = {
 	.name = "qhs_display1_cfg",
-	.id = SC8280XP_SLAVE_DISPLAY1_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac0_cfg = {
 	.name = "qhs_emac0_cfg",
-	.id = SC8280XP_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac1_cfg = {
 	.name = "qhs_emac1_cfg",
-	.id = SC8280XP_SLAVE_EMAC1_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SC8280XP_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
-	.id = SC8280XP_SLAVE_HWKM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SC8280XP_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SC8280XP_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SC8280XP_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SC8280XP_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SC8280XP_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mxc_rdpm = {
 	.name = "qhs_mxc_rdpm",
-	.id = SC8280XP_SLAVE_MXC_RDPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SC8280XP_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SC8280XP_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie2a_cfg = {
 	.name = "qhs_pcie2a_cfg",
-	.id = SC8280XP_SLAVE_PCIE_2A_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie2b_cfg = {
 	.name = "qhs_pcie2b_cfg",
-	.id = SC8280XP_SLAVE_PCIE_2B_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie3a_cfg = {
 	.name = "qhs_pcie3a_cfg",
-	.id = SC8280XP_SLAVE_PCIE_3A_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie3b_cfg = {
 	.name = "qhs_pcie3b_cfg",
-	.id = SC8280XP_SLAVE_PCIE_3B_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie4_cfg = {
 	.name = "qhs_pcie4_cfg",
-	.id = SC8280XP_SLAVE_PCIE_4_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_rsc_cfg = {
 	.name = "qhs_pcie_rsc_cfg",
-	.id = SC8280XP_SLAVE_PCIE_RSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SC8280XP_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SC8280XP_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pka_wrapper_cfg = {
 	.name = "qhs_pka_wrapper_cfg",
-	.id = SC8280XP_SLAVE_PKA_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
 	.name = "qhs_pmu_wrapper_cfg",
-	.id = SC8280XP_SLAVE_PMU_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SC8280XP_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SC8280XP_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SC8280XP_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SC8280XP_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SC8280XP_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SC8280XP_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SC8280XP_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SC8280XP_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_smmuv3_cfg = {
 	.name = "qhs_smmuv3_cfg",
-	.id = SC8280XP_SLAVE_SMMUV3_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_smss_cfg = {
 	.name = "qhs_smss_cfg",
-	.id = SC8280XP_SLAVE_SMSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SC8280XP_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SC8280XP_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SC8280XP_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SC8280XP_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SC8280XP_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SC8280XP_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SC8280XP_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_mp = {
 	.name = "qhs_usb3_mp",
-	.id = SC8280XP_SLAVE_USB3_MP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb4_host_0 = {
 	.name = "qhs_usb4_host_0",
-	.id = SC8280XP_SLAVE_USB4_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb4_host_1 = {
 	.name = "qhs_usb4_host_1",
-	.id = SC8280XP_SLAVE_USB4_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SC8280XP_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SC8280XP_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_r_cfg = {
 	.name = "qhs_vsense_ctrl_r_cfg",
-	.id = SC8280XP_SLAVE_VSENSE_CTRL_R_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a1_noc_cfg = {
 	.name = "qns_a1_noc_cfg",
-	.id = SC8280XP_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_A1NOC_CFG },
+	.link_nodes = { &qnm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_a2_noc_cfg = {
 	.name = "qns_a2_noc_cfg",
-	.id = SC8280XP_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_A2NOC_CFG },
+	.link_nodes = { &qnm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_anoc_pcie_bridge_cfg = {
 	.name = "qns_anoc_pcie_bridge_cfg",
-	.id = SC8280XP_SLAVE_ANOC_PCIE_BRIDGE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SC8280XP_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qnm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qns_mnoc_cfg = {
 	.name = "qns_mnoc_cfg",
-	.id = SC8280XP_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qnm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SC8280XP_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_snoc_sf_bridge_cfg = {
 	.name = "qns_snoc_sf_bridge_cfg",
-	.id = SC8280XP_SLAVE_SNOC_SF_BRIDGE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SC8280XP_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SC8280XP_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SC8280XP_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SC8280XP_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SC8280XP_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_2a = {
 	.name = "xs_pcie_2a",
-	.id = SC8280XP_SLAVE_PCIE_2A,
 	.channels = 1,
 	.buswidth = 16,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_2b = {
 	.name = "xs_pcie_2b",
-	.id = SC8280XP_SLAVE_PCIE_2B,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_3a = {
 	.name = "xs_pcie_3a",
-	.id = SC8280XP_SLAVE_PCIE_3A,
 	.channels = 1,
 	.buswidth = 16,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_3b = {
 	.name = "xs_pcie_3b",
-	.id = SC8280XP_SLAVE_PCIE_3B,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_4 = {
 	.name = "xs_pcie_4",
-	.id = SC8280XP_SLAVE_PCIE_4,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SC8280XP_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_smss = {
 	.name = "xs_smss",
-	.id = SC8280XP_SLAVE_SMSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SC8280XP_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SC8280XP_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SC8280XP_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qnm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SC8280XP_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SC8280XP_SLAVE_LLCC,
 	.channels = 8,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SC8280XP_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SC8280XP_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SC8280XP_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SC8280XP_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SC8280XP_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SC8280XP_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SC8280XP_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_sysnoc = {
 	.name = "qns_sysnoc",
-	.id = SC8280XP_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_LPASS_ANOC },
+	.link_nodes = { &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SC8280XP_SLAVE_EBI1,
 	.channels = 8,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SC8280XP_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SC8280XP_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SC8280XP_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SC8280XP_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc0, NULL },
 };
 
 static struct qcom_icc_node qxs_nsp_xfr = {
 	.name = "qxs_nsp_xfr",
-	.id = SC8280XP_SLAVE_NSP_XFR,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SC8280XP_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nspb_gemnoc = {
 	.name = "qns_nspb_gemnoc",
-	.id = SC8280XP_SLAVE_CDSPB_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_COMPUTE_NOC_1 },
+	.link_nodes = { &qnm_cmpnoc1, NULL },
 };
 
 static struct qcom_icc_node qxs_nspb_xfr = {
 	.name = "qxs_nspb_xfr",
-	.id = SC8280XP_SLAVE_NSPB_XFR,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node service_nspb_noc = {
 	.name = "service_nspb_noc",
-	.id = SC8280XP_SLAVE_SERVICE_NSPB_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SC8280XP_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SC8280XP_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC8280XP_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SC8280XP_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1726,85 +1707,85 @@ static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
 	.nodes = { &qnm_gemnoc_cnoc,
-		   &qnm_gemnoc_pcie,
-		   &xs_pcie_0,
-		   &xs_pcie_1,
-		   &xs_pcie_2a,
-		   &xs_pcie_2b,
-		   &xs_pcie_3a,
-		   &xs_pcie_3b,
-		   &xs_pcie_4, NULL },
+			&qnm_gemnoc_pcie,
+			&xs_pcie_0,
+			&xs_pcie_1,
+			&xs_pcie_2a,
+			&xs_pcie_2b,
+			&xs_pcie_3a,
+			&xs_pcie_3b,
+			&xs_pcie_4, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
 	.nodes = { &qhs_ahb2phy0,
-		   &qhs_ahb2phy1,
-		   &qhs_ahb2phy2,
-		   &qhs_aoss,
-		   &qhs_apss,
-		   &qhs_camera_cfg,
-		   &qhs_clk_ctl,
-		   &qhs_compute0_cfg,
-		   &qhs_compute1_cfg,
-		   &qhs_cpr_cx,
-		   &qhs_cpr_mmcx,
-		   &qhs_cpr_mx,
-		   &qhs_cpr_nspcx,
-		   &qhs_crypto0_cfg,
-		   &qhs_cx_rdpm,
-		   &qhs_dcc_cfg,
-		   &qhs_display0_cfg,
-		   &qhs_display1_cfg,
-		   &qhs_emac0_cfg,
-		   &qhs_emac1_cfg,
-		   &qhs_gpuss_cfg,
-		   &qhs_hwkm,
-		   &qhs_imem_cfg,
-		   &qhs_ipa,
-		   &qhs_ipc_router,
-		   &qhs_lpass_cfg,
-		   &qhs_mx_rdpm,
-		   &qhs_mxc_rdpm,
-		   &qhs_pcie0_cfg,
-		   &qhs_pcie1_cfg,
-		   &qhs_pcie2a_cfg,
-		   &qhs_pcie2b_cfg,
-		   &qhs_pcie3a_cfg,
-		   &qhs_pcie3b_cfg,
-		   &qhs_pcie4_cfg,
-		   &qhs_pcie_rsc_cfg,
-		   &qhs_pdm,
-		   &qhs_pimem_cfg,
-		   &qhs_pka_wrapper_cfg,
-		   &qhs_pmu_wrapper_cfg,
-		   &qhs_qdss_cfg,
-		   &qhs_sdc2,
-		   &qhs_sdc4,
-		   &qhs_security,
-		   &qhs_smmuv3_cfg,
-		   &qhs_smss_cfg,
-		   &qhs_spss_cfg,
-		   &qhs_tcsr,
-		   &qhs_tlmm,
-		   &qhs_ufs_card_cfg,
-		   &qhs_ufs_mem_cfg,
-		   &qhs_usb3_0,
-		   &qhs_usb3_1,
-		   &qhs_usb3_mp,
-		   &qhs_usb4_host_0,
-		   &qhs_usb4_host_1,
-		   &qhs_venus_cfg,
-		   &qhs_vsense_ctrl_cfg,
-		   &qhs_vsense_ctrl_r_cfg,
-		   &qns_a1_noc_cfg,
-		   &qns_a2_noc_cfg,
-		   &qns_anoc_pcie_bridge_cfg,
-		   &qns_ddrss_cfg,
-		   &qns_mnoc_cfg,
-		   &qns_snoc_cfg,
-		   &qns_snoc_sf_bridge_cfg,
-		   &srvc_cnoc, NULL },
+			&qhs_ahb2phy1,
+			&qhs_ahb2phy2,
+			&qhs_aoss,
+			&qhs_apss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute0_cfg,
+			&qhs_compute1_cfg,
+			&qhs_cpr_cx,
+			&qhs_cpr_mmcx,
+			&qhs_cpr_mx,
+			&qhs_cpr_nspcx,
+			&qhs_crypto0_cfg,
+			&qhs_cx_rdpm,
+			&qhs_dcc_cfg,
+			&qhs_display0_cfg,
+			&qhs_display1_cfg,
+			&qhs_emac0_cfg,
+			&qhs_emac1_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_hwkm,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_ipc_router,
+			&qhs_lpass_cfg,
+			&qhs_mx_rdpm,
+			&qhs_mxc_rdpm,
+			&qhs_pcie0_cfg,
+			&qhs_pcie1_cfg,
+			&qhs_pcie2a_cfg,
+			&qhs_pcie2b_cfg,
+			&qhs_pcie3a_cfg,
+			&qhs_pcie3b_cfg,
+			&qhs_pcie4_cfg,
+			&qhs_pcie_rsc_cfg,
+			&qhs_pdm,
+			&qhs_pimem_cfg,
+			&qhs_pka_wrapper_cfg,
+			&qhs_pmu_wrapper_cfg,
+			&qhs_qdss_cfg,
+			&qhs_sdc2,
+			&qhs_sdc4,
+			&qhs_security,
+			&qhs_smmuv3_cfg,
+			&qhs_smss_cfg,
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_usb3_mp,
+			&qhs_usb4_host_0,
+			&qhs_usb4_host_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_vsense_ctrl_r_cfg,
+			&qns_a1_noc_cfg,
+			&qns_a2_noc_cfg,
+			&qns_anoc_pcie_bridge_cfg,
+			&qns_ddrss_cfg,
+			&qns_mnoc_cfg,
+			&qns_snoc_cfg,
+			&qns_snoc_sf_bridge_cfg,
+			&srvc_cnoc, NULL },
 };
 
 static struct qcom_icc_bcm bcm_cn2 = {
@@ -1976,6 +1957,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -2012,6 +1994,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -2034,6 +2017,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -2138,6 +2122,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -2154,6 +2139,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -2188,6 +2174,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -2211,6 +2198,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -2228,6 +2216,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -2259,6 +2248,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -2279,6 +2269,7 @@ static struct qcom_icc_node * const nspa_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_nspa_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -2299,6 +2290,7 @@ static struct qcom_icc_node * const nspb_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_nspb_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nspb_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
 	.bcms = nspb_noc_bcms,
@@ -2328,6 +2320,7 @@ static struct qcom_icc_node * const system_noc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8280xp_system_noc_main = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_main_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_main_nodes),
 	.bcms = system_noc_main_bcms,
diff --git a/drivers/interconnect/qcom/sc8280xp.h b/drivers/interconnect/qcom/sc8280xp.h
deleted file mode 100644
index c5c410fd5ec3c4d1bd0660091e1c4948fc019347..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sc8280xp.h
+++ /dev/null
@@ -1,209 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SC8280XP_H
-#define __DRIVERS_INTERCONNECT_QCOM_SC8280XP_H
-
-#define SC8280XP_MASTER_GPU_TCU				0
-#define SC8280XP_MASTER_PCIE_TCU			1
-#define SC8280XP_MASTER_SYS_TCU				2
-#define SC8280XP_MASTER_APPSS_PROC			3
-/* 4 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SC8280XP_MASTER_LLCC				5
-#define SC8280XP_MASTER_CNOC_LPASS_AG_NOC		6
-#define SC8280XP_MASTER_CDSP_NOC_CFG			7
-#define SC8280XP_MASTER_CDSPB_NOC_CFG			8
-#define SC8280XP_MASTER_QDSS_BAM			9
-#define SC8280XP_MASTER_QSPI_0				10
-#define SC8280XP_MASTER_QUP_0				11
-#define SC8280XP_MASTER_QUP_1				12
-#define SC8280XP_MASTER_QUP_2				13
-#define SC8280XP_MASTER_A1NOC_CFG			14
-#define SC8280XP_MASTER_A2NOC_CFG			15
-#define SC8280XP_MASTER_A1NOC_SNOC			16
-#define SC8280XP_MASTER_A2NOC_SNOC			17
-#define SC8280XP_MASTER_USB_NOC_SNOC			18
-#define SC8280XP_MASTER_CAMNOC_HF			19
-#define SC8280XP_MASTER_COMPUTE_NOC			20
-#define SC8280XP_MASTER_COMPUTE_NOC_1			21
-#define SC8280XP_MASTER_CNOC_DC_NOC			22
-#define SC8280XP_MASTER_GEM_NOC_CFG			23
-#define SC8280XP_MASTER_GEM_NOC_CNOC			24
-#define SC8280XP_MASTER_GEM_NOC_PCIE_SNOC		25
-#define SC8280XP_MASTER_GFX3D				26
-#define SC8280XP_MASTER_LPASS_ANOC			27
-#define SC8280XP_MASTER_MDP0				28
-#define SC8280XP_MASTER_MDP1				29
-#define SC8280XP_MASTER_MDP_CORE1_0			30
-#define SC8280XP_MASTER_MDP_CORE1_1			31
-#define SC8280XP_MASTER_CNOC_MNOC_CFG			32
-#define SC8280XP_MASTER_MNOC_HF_MEM_NOC			33
-#define SC8280XP_MASTER_MNOC_SF_MEM_NOC			34
-#define SC8280XP_MASTER_ANOC_PCIE_GEM_NOC		35
-#define SC8280XP_MASTER_ROTATOR				36
-#define SC8280XP_MASTER_ROTATOR_1			37
-#define SC8280XP_MASTER_SNOC_CFG			38
-#define SC8280XP_MASTER_SNOC_GC_MEM_NOC			39
-#define SC8280XP_MASTER_SNOC_SF_MEM_NOC			40
-#define SC8280XP_MASTER_VIDEO_P0			41
-#define SC8280XP_MASTER_VIDEO_P1			42
-#define SC8280XP_MASTER_VIDEO_PROC			43
-#define SC8280XP_MASTER_QUP_CORE_0			44
-#define SC8280XP_MASTER_QUP_CORE_1			45
-#define SC8280XP_MASTER_QUP_CORE_2			46
-#define SC8280XP_MASTER_CAMNOC_ICP			47
-#define SC8280XP_MASTER_CAMNOC_SF			48
-#define SC8280XP_MASTER_CRYPTO				49
-#define SC8280XP_MASTER_IPA				50
-#define SC8280XP_MASTER_LPASS_PROC			51
-#define SC8280XP_MASTER_CDSP_PROC			52
-#define SC8280XP_MASTER_CDSP_PROC_B			53
-#define SC8280XP_MASTER_PIMEM				54
-#define SC8280XP_MASTER_SENSORS_PROC			55
-#define SC8280XP_MASTER_SP				56
-#define SC8280XP_MASTER_EMAC				57
-#define SC8280XP_MASTER_EMAC_1				58
-#define SC8280XP_MASTER_GIC				59
-#define SC8280XP_MASTER_PCIE_0				60
-#define SC8280XP_MASTER_PCIE_1				61
-#define SC8280XP_MASTER_PCIE_2A				62
-#define SC8280XP_MASTER_PCIE_2B				63
-#define SC8280XP_MASTER_PCIE_3A				64
-#define SC8280XP_MASTER_PCIE_3B				65
-#define SC8280XP_MASTER_PCIE_4				66
-#define SC8280XP_MASTER_QDSS_ETR			67
-#define SC8280XP_MASTER_SDCC_2				68
-#define SC8280XP_MASTER_SDCC_4				69
-#define SC8280XP_MASTER_UFS_CARD			70
-#define SC8280XP_MASTER_UFS_MEM				71
-#define SC8280XP_MASTER_USB3_0				72
-#define SC8280XP_MASTER_USB3_1				73
-#define SC8280XP_MASTER_USB3_MP				74
-#define SC8280XP_MASTER_USB4_0				75
-#define SC8280XP_MASTER_USB4_1				76
-#define SC8280XP_SLAVE_EBI1				512
-/* 513 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SC8280XP_SLAVE_AHB2PHY_0			514
-#define SC8280XP_SLAVE_AHB2PHY_1			515
-#define SC8280XP_SLAVE_AHB2PHY_2			516
-#define SC8280XP_SLAVE_AOSS				517
-#define SC8280XP_SLAVE_APPSS				518
-#define SC8280XP_SLAVE_CAMERA_CFG			519
-#define SC8280XP_SLAVE_CLK_CTL				520
-#define SC8280XP_SLAVE_CDSP_CFG				521
-#define SC8280XP_SLAVE_CDSP1_CFG			522
-#define SC8280XP_SLAVE_RBCPR_CX_CFG			523
-#define SC8280XP_SLAVE_RBCPR_MMCX_CFG			524
-#define SC8280XP_SLAVE_RBCPR_MX_CFG			525
-#define SC8280XP_SLAVE_CPR_NSPCX			526
-#define SC8280XP_SLAVE_CRYPTO_0_CFG			527
-#define SC8280XP_SLAVE_CX_RDPM				528
-#define SC8280XP_SLAVE_DCC_CFG				529
-#define SC8280XP_SLAVE_DISPLAY_CFG			530
-#define SC8280XP_SLAVE_DISPLAY1_CFG			531
-#define SC8280XP_SLAVE_EMAC_CFG				532
-#define SC8280XP_SLAVE_EMAC1_CFG			533
-#define SC8280XP_SLAVE_GFX3D_CFG			534
-#define SC8280XP_SLAVE_HWKM				535
-#define SC8280XP_SLAVE_IMEM_CFG				536
-#define SC8280XP_SLAVE_IPA_CFG				537
-#define SC8280XP_SLAVE_IPC_ROUTER_CFG			538
-#define SC8280XP_SLAVE_LLCC_CFG				539
-#define SC8280XP_SLAVE_LPASS				540
-#define SC8280XP_SLAVE_LPASS_CORE_CFG			541
-#define SC8280XP_SLAVE_LPASS_LPI_CFG			542
-#define SC8280XP_SLAVE_LPASS_MPU_CFG			543
-#define SC8280XP_SLAVE_LPASS_TOP_CFG			544
-#define SC8280XP_SLAVE_MX_RDPM				545
-#define SC8280XP_SLAVE_MXC_RDPM				546
-#define SC8280XP_SLAVE_PCIE_0_CFG			547
-#define SC8280XP_SLAVE_PCIE_1_CFG			548
-#define SC8280XP_SLAVE_PCIE_2A_CFG			549
-#define SC8280XP_SLAVE_PCIE_2B_CFG			550
-#define SC8280XP_SLAVE_PCIE_3A_CFG			551
-#define SC8280XP_SLAVE_PCIE_3B_CFG			552
-#define SC8280XP_SLAVE_PCIE_4_CFG			553
-#define SC8280XP_SLAVE_PCIE_RSC_CFG			554
-#define SC8280XP_SLAVE_PDM				555
-#define SC8280XP_SLAVE_PIMEM_CFG			556
-#define SC8280XP_SLAVE_PKA_WRAPPER_CFG			557
-#define SC8280XP_SLAVE_PMU_WRAPPER_CFG			558
-#define SC8280XP_SLAVE_QDSS_CFG				559
-#define SC8280XP_SLAVE_QSPI_0				560
-#define SC8280XP_SLAVE_QUP_0				561
-#define SC8280XP_SLAVE_QUP_1				562
-#define SC8280XP_SLAVE_QUP_2				563
-#define SC8280XP_SLAVE_SDCC_2				564
-#define SC8280XP_SLAVE_SDCC_4				565
-#define SC8280XP_SLAVE_SECURITY				566
-#define SC8280XP_SLAVE_SMMUV3_CFG			567
-#define SC8280XP_SLAVE_SMSS_CFG				568
-#define SC8280XP_SLAVE_SPSS_CFG				569
-#define SC8280XP_SLAVE_TCSR				570
-#define SC8280XP_SLAVE_TLMM				571
-#define SC8280XP_SLAVE_UFS_CARD_CFG			572
-#define SC8280XP_SLAVE_UFS_MEM_CFG			573
-#define SC8280XP_SLAVE_USB3_0				574
-#define SC8280XP_SLAVE_USB3_1				575
-#define SC8280XP_SLAVE_USB3_MP				576
-#define SC8280XP_SLAVE_USB4_0				577
-#define SC8280XP_SLAVE_USB4_1				578
-#define SC8280XP_SLAVE_VENUS_CFG			579
-#define SC8280XP_SLAVE_VSENSE_CTRL_CFG			580
-#define SC8280XP_SLAVE_VSENSE_CTRL_R_CFG		581
-#define SC8280XP_SLAVE_A1NOC_CFG			582
-#define SC8280XP_SLAVE_A1NOC_SNOC			583
-#define SC8280XP_SLAVE_A2NOC_CFG			584
-#define SC8280XP_SLAVE_A2NOC_SNOC			585
-#define SC8280XP_SLAVE_USB_NOC_SNOC			586
-#define SC8280XP_SLAVE_ANOC_PCIE_BRIDGE_CFG		587
-#define SC8280XP_SLAVE_DDRSS_CFG			588
-#define SC8280XP_SLAVE_GEM_NOC_CNOC			589
-#define SC8280XP_SLAVE_GEM_NOC_CFG			590
-#define SC8280XP_SLAVE_SNOC_GEM_NOC_GC			591
-#define SC8280XP_SLAVE_SNOC_GEM_NOC_SF			592
-#define SC8280XP_SLAVE_LLCC				593
-#define SC8280XP_SLAVE_MNOC_HF_MEM_NOC			594
-#define SC8280XP_SLAVE_MNOC_SF_MEM_NOC			595
-#define SC8280XP_SLAVE_CNOC_MNOC_CFG			596
-#define SC8280XP_SLAVE_CDSP_MEM_NOC			597
-#define SC8280XP_SLAVE_CDSPB_MEM_NOC			598
-#define SC8280XP_SLAVE_GEM_NOC_PCIE_CNOC		599
-#define SC8280XP_SLAVE_ANOC_PCIE_GEM_NOC		600
-#define SC8280XP_SLAVE_SNOC_CFG				601
-#define SC8280XP_SLAVE_SNOC_SF_BRIDGE_CFG		602
-#define SC8280XP_SLAVE_LPASS_SNOC			603
-#define SC8280XP_SLAVE_QUP_CORE_0			604
-#define SC8280XP_SLAVE_QUP_CORE_1			605
-#define SC8280XP_SLAVE_QUP_CORE_2			606
-#define SC8280XP_SLAVE_IMEM				607
-#define SC8280XP_SLAVE_NSP_XFR				608
-#define SC8280XP_SLAVE_NSPB_XFR				609
-#define SC8280XP_SLAVE_PIMEM				610
-#define SC8280XP_SLAVE_SERVICE_NSP_NOC			611
-#define SC8280XP_SLAVE_SERVICE_NSPB_NOC			612
-#define SC8280XP_SLAVE_SERVICE_A1NOC			613
-#define SC8280XP_SLAVE_SERVICE_A2NOC			614
-#define SC8280XP_SLAVE_SERVICE_CNOC			615
-#define SC8280XP_SLAVE_SERVICE_GEM_NOC_1		616
-#define SC8280XP_SLAVE_SERVICE_MNOC			617
-#define SC8280XP_SLAVE_SERVICES_LPASS_AML_NOC		618
-#define SC8280XP_SLAVE_SERVICE_LPASS_AG_NOC		619
-#define SC8280XP_SLAVE_SERVICE_GEM_NOC_2		620
-#define SC8280XP_SLAVE_SERVICE_SNOC			621
-#define SC8280XP_SLAVE_SERVICE_GEM_NOC			622
-#define SC8280XP_SLAVE_PCIE_0				623
-#define SC8280XP_SLAVE_PCIE_1				624
-#define SC8280XP_SLAVE_PCIE_2A				625
-#define SC8280XP_SLAVE_PCIE_2B				626
-#define SC8280XP_SLAVE_PCIE_3A				627
-#define SC8280XP_SLAVE_PCIE_3B				628
-#define SC8280XP_SLAVE_PCIE_4				629
-#define SC8280XP_SLAVE_QDSS_STM				630
-#define SC8280XP_SLAVE_SMSS				631
-#define SC8280XP_SLAVE_TCU				632
-
-#endif
-

-- 
2.39.5


