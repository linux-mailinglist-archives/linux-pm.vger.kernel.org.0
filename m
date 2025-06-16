Return-Path: <linux-pm+bounces-28749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3573ADA510
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39843188EFBD
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9F2080C4;
	Mon, 16 Jun 2025 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSPK3RX/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6D1F3BA9
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033760; cv=none; b=f3aKgiKKJxcuByRznSSwTNXAKX2e+uDDnAAchsoXLhcqRrIyZvaL7w5ZjUiFA878CJJzpnUB5ijsxf/VK+/gAw+M65AcDp7pIBfwyulidEtEv9uSjFL9LlTrQsvpUFcnhqF+YnDXqWl+RJoluwCzRcARaC0Qhg99X0YEwYkkuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033760; c=relaxed/simple;
	bh=uCGOIxpfENe53ZuDNroPFS7e2xAHyIG1Ks6qkejSS5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSD1WOxeX2z2NUCnN4RyZcDmcMZdv7Q/Uf90kHPhbPzMr2Hj2d5qdaedB5JKhdyaZMyPR8sV9EjVc4wSH54uUsLTb+Sk1lEWK6x9hPCwnUX23aRitQlKZlxmWI+3Y0YMr3TjHLjj61CX9YPbLA/0otN38VlqkT6+NEqoYJhQgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSPK3RX/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G0Fdi8030619
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	et5qH1nq61Kd11V17HtRz636cYV6OXED75wXLsLJgdQ=; b=fSPK3RX/zccr+HIn
	uFDYvxK9eVWo4toiKc+n1+u2CXXFtvnshDfB7LpBfNxRPAZxA74/roj+hfGppDbM
	wLcy0xS/f3XbyXtFltmDRhL2N8MjgHfyssIJCtZnQ+DBmK6bHIysP7K/CKz4i0FZ
	sM8s2cEQT/0hQw7KDhqNT+6l1fZ1Tfq0K85Ew2n4jOoj7f9B6Z4c5hDngahHtCvW
	/rYheo55h9mFS9RQEC2HIHsOmNvWl0OGoZ/2wAoBH3gK7gVRQIeX8Cb11RoB904w
	nwCmy+TL9Mii8No4qGt3sZqBjhETKRzNV982K7NYXbwak00kXjdJFU2AKfHoEINO
	t4BMpA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mahm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fab979413fso77946196d6.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033754; x=1750638554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=et5qH1nq61Kd11V17HtRz636cYV6OXED75wXLsLJgdQ=;
        b=K16pZvJ4Q5eZZnN8USC27wbaMpiR8owXfJcM+qFdThR1mMvfeqsFgUScgxWBuHYvRV
         bSoeUgscTPzyJD5WTloLgi4lOhdrhHJ7wFeWWXosjHmA5Kp5gknJwfMnh2docQ5JEQAH
         P7EIOStAcVeZNwowFlHjgm/lAg9HFSJxDDHpDGTIfl7VGkkR8c1ZcSidnAF+YvLoO38v
         G4spbZ00x5YirCCKkgSf+faJCwrMihqWwotYIQWw2V+BcELzpcj2ooRVhEY5W3mGHsLk
         Woi1lh4e4Rty6p5+dsQexCuqOcH8Y/7Vdm6E0C/+qeYIXFIDxwZUvIu9sqHrSqj7+ro/
         hFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3yjsRzZZ97LQ9T1kC2dYdaPGrzkNpko5OXU09aMUNDzDdd4tWZjfwHHe0bgzE+SYHfe2gg40+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyokmV+eSBVw775+a5aPyeMEZBXDNiDDP4kl0Vwr3cvPU2di4ya
	5jHbb1Kn1L6rdW1Tq4lh9OXc13X+ouU/3VNoDmRaL7zbbFmfD1ihds7cNT9JgaMPb47wWJnoHxt
	grb+HbHCqrFWGrwH9el7EHF9pfwPH2zGgKE7UpkVdkHXWinPBIuBcJjGUHweg0Zlle2TWNwNM
X-Gm-Gg: ASbGncu/YdCwtr5DmUMl0IJGPmPscOLD5gwHrmm7tvbYVkM5x9tkJmBz5mAkMkXNxO8
	auUc5fc24VmtErf30Anpl1q4lVhYbttcJd0a06syTQdxGk8O/fihpGah2o+vU5E2tXwZdU1Kr40
	OwarS5ZYGpfJHxwbR/8tARd/NTYMcDfkPz11kW7yLGt0SGsIx+jVKg7ogks0POC49PWC/Y7p2XN
	ATLeoRJrMYC1J+ZxiR4v1OxpeDVIcllmS6BFT6WIH9kF340YOmrJp7/yriKtZRLcvZj+DeICwqW
	Zd0D+54BPFpW13mm6eT9t5sXAcHYe/JQ4qHG6rod+DWGB8ep0nERWBGIUVRiCwbdETq3RC7ka88
	oNMG0fR7ypN9ygQy6/55+fVJ6OAWJl9NPlso=
X-Received: by 2002:a0c:f113:0:b0:6fb:4b73:79f7 with SMTP id 6a1803df08f44-6fb4b737a30mr66365406d6.41.1750033754015;
        Sun, 15 Jun 2025 17:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRpwf20NnKMMLlCmRVL+quEClQ9B6+CUDsUGXuBUwo9BLe8BvOCwOUe05ozbQInqZhs7QFJg==
X-Received: by 2002:a0c:f113:0:b0:6fb:4b73:79f7 with SMTP id 6a1803df08f44-6fb4b737a30mr66365226d6.41.1750033753481;
        Sun, 15 Jun 2025 17:29:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:29:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:25 +0300
Subject: [PATCH 13/28] interconnect: qcom: qdu1000: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-13-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=31356;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uCGOIxpfENe53ZuDNroPFS7e2xAHyIG1Ks6qkejSS5I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UjRJgVCPL6tVY9+Ddh0v5LfdJRLeI10gSHm
 YFY/b/KXxSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIwAKCRCLPIo+Aiko
 1XFuB/9xwQ+kROSDYSjSbd2HvAX4I+2BrUd3zhixtDW7qQOQhLxaPgFF9PsM6W28LkK/vk0BN/a
 RoL8N4/vPI3DudehBJkYiXj9nNL423Db3jDodr2bR1mNIJbglCp71+GeRIdqDHoF/s+Y/lrMvHE
 fRTp9wVvDFIB6SVzyOh+mBOQv7eb7rnP2KVtTAZ9gWA1vw3wg21auXb3HDvMukqVQ4wNMzdbz06
 bcAVz683UUEZiq/HtCY5ka6GTNHbLQJPdwHuZ1hZoNMlhz00EWDE8oW2osIuw1efLWlBZFEqUAL
 v3Kt/GG1l3eRxRGfR7dZ0Jf7kan3/BpKzuZS92q4dOMc0+P5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX/olYFGt/Rdep
 ySAWjGErCfQRpXBEEhl2PkGv+olW5bnj/AkcGxaGJoKRoIE55SetJ9/B8KPIkij8n5OK2IRmIq8
 R6rYYouymk8Tu6mGh3Vr37oPn36ne95bhitn6tS7tQu/cOmNsCxhLceavmRSTWtlBxx1WfsM1A+
 TO2sxE4c3MyaA3I+ojxvZ8+Q/aGW6x03j9cYqjO1GzHTaTh5cqqC9lvwLhdZueM8O5sJUDEnTYu
 LNT4x1acLpL2FPhsXy/DaEwBK15x7g/d1bF7nxAi1i5KPby0MjjPpoJ9o1PNGCGIdTIgKPwsDSR
 USphqtxZXgL7QH2U9vhMuc+MaYB+ldr4N8tAyPRm2mZiYpBO2m/RgMEringP9RT5GR2rOsdBTNP
 4dq2fcr55cYg3U3D1QUzovApJCuk5KES3jk+bsT17nHJgGRq1YgYH9dogsW4xD0YtOViBqwy
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=684f655b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=-fx8czeLLTIB5ZzmIrQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 5vE24xR8JhAcHXVztqEcY1QVfDGoeSPs
X-Proofpoint-ORIG-GUID: 5vE24xR8JhAcHXVztqEcY1QVfDGoeSPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qdu1000.c | 437 ++++++++++++++++--------------------
 drivers/interconnect/qcom/qdu1000.h |  95 --------
 2 files changed, 196 insertions(+), 336 deletions(-)

diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index 727482c0f7f8f15e32cf508a5f7300546e9d2daf..6bd7b16f8129758eca38ed9d348ac745226897dd 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -15,756 +15,707 @@
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
-#include "qdu1000.h"
+
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_ecpri_dma;
+static struct qcom_icc_node qnm_fec_2_gemnoc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_mdsp;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qpic;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_system_noc_cfg;
+static struct qcom_icc_node qnm_aggre_noc;
+static struct qcom_icc_node qnm_aggre_noc_gsi;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_modem_slave;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ecpri_gsi;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_ecpri_dma;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node xm_pcie;
+static struct qcom_icc_node xm_qdss_etr0;
+static struct qcom_icc_node xm_qdss_etr1;
+static struct qcom_icc_node xm_sdc;
+static struct qcom_icc_node xm_usb3;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_modem_slave;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qhs_ahb2phy0_south;
+static struct qcom_icc_node qhs_ahb2phy1_north;
+static struct qcom_icc_node qhs_ahb2phy2_east;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto_cfg;
+static struct qcom_icc_node qhs_ecpri_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_pcie_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qpic;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_smbus_cfg;
+static struct qcom_icc_node qhs_system_noc_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qhs_tsc_cfg;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_anoc_snoc_gsi;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_ecpri_gemnoc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qns_modem;
+static struct qcom_icc_node qns_pcie_gemnoc;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_system_noc;
+static struct qcom_icc_node xs_ethernet_ss;
+static struct qcom_icc_node xs_pcie;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = QDU1000_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = QDU1000_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = QDU1000_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = QDU1000_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 4,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
-		   QDU1000_SLAVE_GEMNOC_MODEM_CNOC, QDU1000_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_modem_slave, &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_ecpri_dma = {
 	.name = "qnm_ecpri_dma",
-	.id = QDU1000_MASTER_GEMNOC_ECPRI_DMA,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_fec_2_gemnoc = {
 	.name = "qnm_fec_2_gemnoc",
-	.id = QDU1000_MASTER_FEC_2_GEMNOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = QDU1000_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 3,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
-		   QDU1000_SLAVE_GEMNOC_MODEM_CNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_modem_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = QDU1000_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = QDU1000_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 4,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
-		   QDU1000_SLAVE_GEMNOC_MODEM_CNOC, QDU1000_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_modem_slave, &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qxm_mdsp = {
 	.name = "qxm_mdsp",
-	.id = QDU1000_MASTER_MSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { QDU1000_SLAVE_GEM_NOC_CNOC, QDU1000_SLAVE_LLCC,
-		   QDU1000_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = QDU1000_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = QDU1000_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = QDU1000_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = QDU1000_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = QDU1000_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = QDU1000_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = QDU1000_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_system_noc_cfg = {
 	.name = "qhm_system_noc_cfg",
-	.id = QDU1000_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_system_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = QDU1000_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_noc_gsi = {
 	.name = "qnm_aggre_noc_gsi",
-	.id = QDU1000_MASTER_ANOC_GSI,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = QDU1000_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 36,
-	.links = { QDU1000_SLAVE_AHB2PHY_SOUTH, QDU1000_SLAVE_AHB2PHY_NORTH,
-		   QDU1000_SLAVE_AHB2PHY_EAST, QDU1000_SLAVE_AOSS,
-		   QDU1000_SLAVE_CLK_CTL, QDU1000_SLAVE_RBCPR_CX_CFG,
-		   QDU1000_SLAVE_RBCPR_MX_CFG, QDU1000_SLAVE_CRYPTO_0_CFG,
-		   QDU1000_SLAVE_ECPRI_CFG, QDU1000_SLAVE_IMEM_CFG,
-		   QDU1000_SLAVE_IPC_ROUTER_CFG, QDU1000_SLAVE_CNOC_MSS,
-		   QDU1000_SLAVE_PCIE_CFG, QDU1000_SLAVE_PDM,
-		   QDU1000_SLAVE_PIMEM_CFG, QDU1000_SLAVE_PRNG,
-		   QDU1000_SLAVE_QDSS_CFG, QDU1000_SLAVE_QPIC,
-		   QDU1000_SLAVE_QSPI_0, QDU1000_SLAVE_QUP_0,
-		   QDU1000_SLAVE_QUP_1, QDU1000_SLAVE_SDCC_2,
-		   QDU1000_SLAVE_SMBUS_CFG, QDU1000_SLAVE_SNOC_CFG,
-		   QDU1000_SLAVE_TCSR, QDU1000_SLAVE_TLMM,
-		   QDU1000_SLAVE_TME_CFG, QDU1000_SLAVE_TSC_CFG,
-		   QDU1000_SLAVE_USB3_0, QDU1000_SLAVE_VSENSE_CTRL_CFG,
-		   QDU1000_SLAVE_DDRSS_CFG, QDU1000_SLAVE_IMEM,
-		   QDU1000_SLAVE_PIMEM, QDU1000_SLAVE_ETHERNET_SS,
-		   QDU1000_SLAVE_QDSS_STM, QDU1000_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_ahb2phy0_south, &qhs_ahb2phy1_north,
+			&qhs_ahb2phy2_east, &qhs_aoss,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto_cfg,
+			&qhs_ecpri_cfg, &qhs_imem_cfg,
+			&qhs_ipc_router, &qhs_mss_cfg,
+			&qhs_pcie_cfg, &qhs_pdm,
+			&qhs_pimem_cfg, &qhs_prng,
+			&qhs_qdss_cfg, &qhs_qpic,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc2,
+			&qhs_smbus_cfg, &qhs_system_noc_cfg,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tme_cfg, &qhs_tsc_cfg,
+			&qhs_usb3, &qhs_vsense_ctrl_cfg,
+			&qns_ddrss_cfg, &qxs_imem,
+			&qxs_pimem, &xs_ethernet_ss,
+			&xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_modem_slave = {
 	.name = "qnm_gemnoc_modem_slave",
-	.id = QDU1000_MASTER_GEMNOC_MODEM_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_MODEM_OFFLINE },
+	.link_nodes = { &qns_modem, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = QDU1000_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = QDU1000_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ecpri_gsi = {
 	.name = "qxm_ecpri_gsi",
-	.id = QDU1000_MASTER_ECPRI_GSI,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { QDU1000_SLAVE_ANOC_SNOC_GSI, QDU1000_SLAVE_PCIE_0 },
+	.link_nodes = { &qns_anoc_snoc_gsi, &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = QDU1000_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_ecpri_dma = {
 	.name = "xm_ecpri_dma",
-	.id = QDU1000_MASTER_SNOC_ECPRI_DMA,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { QDU1000_SLAVE_ECPRI_GEMNOC, QDU1000_SLAVE_PCIE_0 },
+	.link_nodes = { &qns_ecpri_gemnoc, &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = QDU1000_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = QDU1000_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr0 = {
 	.name = "xm_qdss_etr0",
-	.id = QDU1000_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr1 = {
 	.name = "xm_qdss_etr1",
-	.id = QDU1000_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node xm_sdc = {
 	.name = "xm_sdc",
-	.id = QDU1000_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = QDU1000_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = QDU1000_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = QDU1000_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = QDU1000_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = QDU1000_SLAVE_LLCC,
 	.channels = 8,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_modem_slave = {
 	.name = "qns_modem_slave",
-	.id = QDU1000_SLAVE_GEMNOC_MODEM_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_GEMNOC_MODEM_CNOC },
+	.link_nodes = { &qnm_gemnoc_modem_slave, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = QDU1000_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = QDU1000_SLAVE_EBI1,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0_south = {
 	.name = "qhs_ahb2phy0_south",
-	.id = QDU1000_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1_north = {
 	.name = "qhs_ahb2phy1_north",
-	.id = QDU1000_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy2_east = {
 	.name = "qhs_ahb2phy2_east",
-	.id = QDU1000_SLAVE_AHB2PHY_EAST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = QDU1000_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = QDU1000_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = QDU1000_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = QDU1000_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto_cfg = {
 	.name = "qhs_crypto_cfg",
-	.id = QDU1000_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ecpri_cfg = {
 	.name = "qhs_ecpri_cfg",
-	.id = QDU1000_SLAVE_ECPRI_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = QDU1000_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = QDU1000_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = QDU1000_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_cfg = {
 	.name = "qhs_pcie_cfg",
-	.id = QDU1000_SLAVE_PCIE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = QDU1000_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = QDU1000_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = QDU1000_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = QDU1000_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = QDU1000_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = QDU1000_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = QDU1000_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = QDU1000_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = QDU1000_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_smbus_cfg = {
 	.name = "qhs_smbus_cfg",
-	.id = QDU1000_SLAVE_SMBUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_system_noc_cfg = {
 	.name = "qhs_system_noc_cfg",
-	.id = QDU1000_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_system_noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = QDU1000_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = QDU1000_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = QDU1000_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tsc_cfg = {
 	.name = "qhs_tsc_cfg",
-	.id = QDU1000_SLAVE_TSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = QDU1000_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = QDU1000_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = QDU1000_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qns_anoc_snoc_gsi = {
 	.name = "qns_anoc_snoc_gsi",
-	.id = QDU1000_SLAVE_ANOC_SNOC_GSI,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_ANOC_GSI },
+	.link_nodes = { &qnm_aggre_noc_gsi, NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = QDU1000_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_ecpri_gemnoc = {
 	.name = "qns_ecpri_gemnoc",
-	.id = QDU1000_SLAVE_ECPRI_GEMNOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_GEMNOC_ECPRI_DMA },
+	.link_nodes = { &qnm_ecpri_dma, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = QDU1000_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = QDU1000_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_modem = {
 	.name = "qns_modem",
-	.id = QDU1000_SLAVE_MODEM_OFFLINE,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_pcie_gemnoc = {
 	.name = "qns_pcie_gemnoc",
-	.id = QDU1000_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 1,
-	.links = { QDU1000_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = QDU1000_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = QDU1000_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_system_noc = {
 	.name = "srvc_system_noc",
-	.id = QDU1000_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_ethernet_ss = {
 	.name = "xs_ethernet_ss",
-	.id = QDU1000_SLAVE_ETHERNET_SS,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = QDU1000_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = QDU1000_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = QDU1000_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -865,6 +816,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -892,6 +844,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -909,6 +862,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -995,6 +949,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qdu1000_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/qdu1000.h b/drivers/interconnect/qcom/qdu1000.h
deleted file mode 100644
index e75a6419df235353a5dcfbefe1cb3979ae966054..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/qdu1000.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_QDU1000_H
-#define __DRIVERS_INTERCONNECT_QCOM_QDU1000_H
-
-#define QDU1000_MASTER_SYS_TCU				0
-#define QDU1000_MASTER_APPSS_PROC			1
-#define QDU1000_MASTER_LLCC				2
-#define QDU1000_MASTER_GIC_AHB				3
-#define QDU1000_MASTER_QDSS_BAM				4
-#define QDU1000_MASTER_QPIC				5
-#define QDU1000_MASTER_QSPI_0				6
-#define QDU1000_MASTER_QUP_0				7
-#define QDU1000_MASTER_QUP_1				8
-#define QDU1000_MASTER_SNOC_CFG				9
-#define QDU1000_MASTER_ANOC_SNOC			10
-#define QDU1000_MASTER_ANOC_GSI				11
-#define QDU1000_MASTER_GEMNOC_ECPRI_DMA			12
-#define QDU1000_MASTER_FEC_2_GEMNOC			13
-#define QDU1000_MASTER_GEM_NOC_CNOC			14
-#define QDU1000_MASTER_GEMNOC_MODEM_CNOC		15
-#define QDU1000_MASTER_GEM_NOC_PCIE_SNOC		16
-#define QDU1000_MASTER_ANOC_PCIE_GEM_NOC		17
-#define QDU1000_MASTER_SNOC_GC_MEM_NOC			18
-#define QDU1000_MASTER_SNOC_SF_MEM_NOC			19
-#define QDU1000_MASTER_QUP_CORE_0			20
-#define QDU1000_MASTER_QUP_CORE_1			21
-#define QDU1000_MASTER_CRYPTO				22
-#define QDU1000_MASTER_ECPRI_GSI			23
-#define QDU1000_MASTER_MSS_PROC				24
-#define QDU1000_MASTER_PIMEM				25
-#define QDU1000_MASTER_SNOC_ECPRI_DMA			26
-#define QDU1000_MASTER_GIC				27
-#define QDU1000_MASTER_PCIE				28
-#define QDU1000_MASTER_QDSS_ETR				29
-#define QDU1000_MASTER_QDSS_ETR_1			30
-#define QDU1000_MASTER_SDCC_1				31
-#define QDU1000_MASTER_USB3				32
-#define QDU1000_SLAVE_EBI1				512
-#define QDU1000_SLAVE_AHB2PHY_SOUTH			513
-#define QDU1000_SLAVE_AHB2PHY_NORTH			514
-#define QDU1000_SLAVE_AHB2PHY_EAST			515
-#define QDU1000_SLAVE_AOSS				516
-#define QDU1000_SLAVE_CLK_CTL				517
-#define QDU1000_SLAVE_RBCPR_CX_CFG			518
-#define QDU1000_SLAVE_RBCPR_MX_CFG			519
-#define QDU1000_SLAVE_CRYPTO_0_CFG			520
-#define QDU1000_SLAVE_ECPRI_CFG				521
-#define QDU1000_SLAVE_IMEM_CFG				522
-#define QDU1000_SLAVE_IPC_ROUTER_CFG			523
-#define QDU1000_SLAVE_CNOC_MSS				524
-#define QDU1000_SLAVE_PCIE_CFG				525
-#define QDU1000_SLAVE_PDM				526
-#define QDU1000_SLAVE_PIMEM_CFG				527
-#define QDU1000_SLAVE_PRNG				528
-#define QDU1000_SLAVE_QDSS_CFG				529
-#define QDU1000_SLAVE_QPIC				530
-#define QDU1000_SLAVE_QSPI_0				531
-#define QDU1000_SLAVE_QUP_0				532
-#define QDU1000_SLAVE_QUP_1				533
-#define QDU1000_SLAVE_SDCC_2				534
-#define QDU1000_SLAVE_SMBUS_CFG				535
-#define QDU1000_SLAVE_SNOC_CFG				536
-#define QDU1000_SLAVE_TCSR				537
-#define QDU1000_SLAVE_TLMM				538
-#define QDU1000_SLAVE_TME_CFG				539
-#define QDU1000_SLAVE_TSC_CFG				540
-#define QDU1000_SLAVE_USB3_0				541
-#define QDU1000_SLAVE_VSENSE_CTRL_CFG			542
-#define QDU1000_SLAVE_A1NOC_SNOC			543
-#define QDU1000_SLAVE_ANOC_SNOC_GSI			544
-#define QDU1000_SLAVE_DDRSS_CFG				545
-#define QDU1000_SLAVE_ECPRI_GEMNOC			546
-#define QDU1000_SLAVE_GEM_NOC_CNOC			547
-#define QDU1000_SLAVE_SNOC_GEM_NOC_GC			548
-#define QDU1000_SLAVE_SNOC_GEM_NOC_SF			549
-#define QDU1000_SLAVE_LLCC				550
-#define QDU1000_SLAVE_MODEM_OFFLINE			551
-#define QDU1000_SLAVE_GEMNOC_MODEM_CNOC			552
-#define QDU1000_SLAVE_MEM_NOC_PCIE_SNOC			553
-#define QDU1000_SLAVE_ANOC_PCIE_GEM_NOC			554
-#define QDU1000_SLAVE_QUP_CORE_0			555
-#define QDU1000_SLAVE_QUP_CORE_1			556
-#define QDU1000_SLAVE_IMEM				557
-#define QDU1000_SLAVE_PIMEM				558
-#define QDU1000_SLAVE_SERVICE_SNOC			559
-#define QDU1000_SLAVE_ETHERNET_SS			560
-#define QDU1000_SLAVE_PCIE_0				561
-#define QDU1000_SLAVE_QDSS_STM				562
-#define QDU1000_SLAVE_TCU				563
-
-#endif

-- 
2.39.5


