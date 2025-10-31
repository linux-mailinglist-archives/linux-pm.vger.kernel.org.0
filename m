Return-Path: <linux-pm+bounces-37211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A9C25B57
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9BD1B23C48
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48E2BEC4A;
	Fri, 31 Oct 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1xIsFay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izBaJf7x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF07288510
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921960; cv=none; b=Kr9lrJYXO3mZx5li3a/Qad+ADIjAM9nCKLrioaw2jDEcgPYtbAtxhEcE0pdZ7IJbBI3FJkD3UUfuN4O2YuPlPW7s82B9P3WhA+zHHgwm0k0LB3cDka86Cq47VcAAqhibptu6D7QML/lXEsLbmpgQydgTuAKVL+AJHz5Zu2w9kw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921960; c=relaxed/simple;
	bh=g2LQE2frQRxkJb3tGVdeVAOu4CUe6ZQbflK4ewrE+3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XubIIVZq4vLpmZ11zCCRSTcaA3InvXfAIR/iJNda5eJg6qs4NF23N+wecVysWYXmupJHHu0aA6fSdZnFjGzZ1+a5+qnIt2G+QU7BlJ7SHIW2m3XMN6SJ9IYp5slwWd4q0wcUQAQEaGa31U0Br/Z3Ct0/BdhqJUf7p2+KUd4FvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C1xIsFay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=izBaJf7x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VA3oG12558792
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	idcL2HnaWjhQi3/nWWAzrMNuPdUYtb4jBA15fo06+xw=; b=C1xIsFayNMMLjBPW
	vfR6bC05l0KIrQJueqQyPz4h7+Qq/fOMXVFGIYQB8GNSMNCLXzJS/Uo7dAJ/vLIg
	PnV8Pt9cQokTqEPLQ8q47vmcaD2BwbXxjqTKV8F04R1Pn8kn9hjlzoq/vDSOKjXf
	7FAAM4qYGsPPStxcpyuzC+/gMkLfwF9ZM9ngP4WB/8zrZOIHKDYryvmJYfQHCGIP
	kythtcaL+Lw1VHoxSVLuS1BBAs72y5FQ7ECRzITWps6fldSGaNb5dqAskL026eZe
	QLc/FtixDYI6Wxvo6AI5Bn4noV7hZEzCGbJb56A2gdTRxp3qR6KZ3Gk8aCK0Rr3g
	QAtULQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4u1grq50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:52 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-934c1af8bb8so3379573241.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921952; x=1762526752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idcL2HnaWjhQi3/nWWAzrMNuPdUYtb4jBA15fo06+xw=;
        b=izBaJf7xybBMoCEvS2Vd/HJJItZ63qXhjs8D6krL60GtiNmqcqcywv1Iz8ERmautcB
         e2jmlGPo4fBPa2R1JhGM2/tJbheiI4YrPWAGq9SrITYeG3nrXZQTIbeoqGUiERSgY9Dy
         +5Nsia1GF8kgvqRxcceOj3gwW02rP4dRsvxDoSrujQxf+AzHCSgm/9kDf23wmdpC1MDh
         n2X9zSZ6aMV6Om0SqGjr6BIMdWdtXtxXy7O0wLqkI3p7FIhKpUnv92sfjILOT5AkTclh
         L1ci7pghiC19KJNNyHOuJSJyIr6A49hAKAwBleNe2MRb1SBZPFLzQA5xvlXVvlHSx+KO
         wKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921952; x=1762526752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idcL2HnaWjhQi3/nWWAzrMNuPdUYtb4jBA15fo06+xw=;
        b=qFTsO/a5bXry7cbjKhaxRk8unFAJzG0otvwtt3ijGjGc11SlHtlk2ZT7N7y5wKaSJE
         Hc+J2d0gAasU3qONtGKWViY2yL1XsghpH5ns2aoCh+XQlobt7GWy5oNfDJj6pS+7yycZ
         960eR/CMZVU2UdHH5gPpch8Utn/KqpIZckEGRgoYbhFlCZIoxheyiAqVnOWnA071Jz4S
         c/DpI96bkpxoZY3dO9nsWGkCB+ZnBsSXEepL3L0sPgUBGcsfdy6nQrGsP4DGcKAgX/a0
         NKJA9u8boRhamlsnQ6DA+0dMLC+qyaOEIdD0Kwqd96ZFOQGvnii4EmUgrYy4C/Xe/hKQ
         SUVA==
X-Forwarded-Encrypted: i=1; AJvYcCU0aBMYzUATxc0Bq2EAE7O6XRpUR0XrB752Hx4Gcc+ECpwaEtWtwbCnP/pQ1aWuyMAwRPi9zU6nnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUy3gVQGegzh4bYsiJMq3ILI0mDXk3tr1bCgoBWHG+S3NBFwzJ
	x1O6GjBw/Um1OesCBZxm5qN3WUscMgePOD6xij3vhYqvpSBTvy+P/E6wCcZMynlLof7RwAjdpj9
	KM/ry43mkq2zZxUSnBGUCCtwMKxcIJmICWu5xtaehtSSh092o1UQYQpfwXu2nCQ==
X-Gm-Gg: ASbGncsLEDIH8oYx9gjGHfeE5nbT5CZ4hEz0DvWXQwIXY2jyy01fC6q8yIF2IW8S4NJ
	1xLwA5/nkj6HRn3WuxVRwzVZ1J4qTqlEbog68pGrZU43KMYAMhsoaF8l8XdENRWr1IdDnRKlxWA
	GkK95YVEY7/KzGJ1bU3jlbeh5ko1XfRJIqo6gPK4zl+b45BR1LNDwAEXVbB/2g8AvR+TGpt2DB8
	u+VKDCwRFMmYRhmUB8ebqpWUoPHd9plqTSFhHUHuPC91TqW2p8gnkwjIMpU+51jXZqdSw3mHQVA
	hjvLgFgHXcl/ll7B+PRxcxSi4EFJmYFqZR81DhwEhqSpUoF3SXtvoFiRDcj2vYOb5LNVjqyW1C9
	rqz4HYY5Vu/WUd/aEfmAMiV9AAOrn9zHM7JHjH7wWRKYYaKaF8WJTztZY5/r1+j2qJSZE8K1RXJ
	LCRocoQPA1rfmf
X-Received: by 2002:a05:6102:508e:b0:5d7:dec6:389a with SMTP id ada2fe7eead31-5dbb11f7d36mr1272576137.9.1761921951858;
        Fri, 31 Oct 2025 07:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9QWS4BNY+CLDZ/ik9TtpgcLrWtWQpPZU23EPecoV0z0mZ3M6nJtQlJe9MVMvjlSAatpsHng==
X-Received: by 2002:a05:6102:508e:b0:5d7:dec6:389a with SMTP id ada2fe7eead31-5dbb11f7d36mr1272545137.9.1761921951291;
        Fri, 31 Oct 2025 07:45:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:30 +0200
Subject: [PATCH v3 14/25] interconnect: qcom: sdx55: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-14-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24886;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=g2LQE2frQRxkJb3tGVdeVAOu4CUe6ZQbflK4ewrE+3o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuFgbckwOVSgfBbZhmWj77D8CqWOJw8PQLCa
 g8dw9Rd+uuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLhQAKCRCLPIo+Aiko
 1Q/qCACiBzcpiEtD5VzKw1Ap8Tm5F7BlJRPVXfMut/c70PG7HuAyqbtA1GBHbCb4uXilZb7N/cP
 gv7EumYE/WR55ZoOgKeRYGmjBL/pO4jtpirx7PYBkeH5USOUvPIdM/aKPORQXtptVpyrA4gdl4u
 BwXMwt8hnl4OCorp58qMuCsk6P0Cdz0c0kML7ctKwxMUVxDgFf95ohjrHlk+luvx3r3a9BE3PzC
 19ZyXF/ee7Kkn1U8O18jVM7T7QwHE4IMJ/Lb/AxCvmi0+YH24OuXA83V9fL+wRjECWdGy2jkR+U
 ehLAE6hQL7K00DsPSZU3kHAL2oeTnUqrMmXjYzyzaEW/GnQA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6904cba0 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SBZ_mQBx4u5IdJMTS58A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: auhiv7HLbD2_V6Rn7BLnc35QuS7w6Dqz
X-Proofpoint-GUID: auhiv7HLbD2_V6Rn7BLnc35QuS7w6Dqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfXz8O6Xb2cmi47
 6lUJM3okf2p7HDveuUFwx/8brYdjwXixbfAulQ9QbXz/bAbjdgFTAeM+FrYcNCAq3AM1d8A3w8K
 4CysFfNvifx8WjhIcN5xtSwAPQF7FVE7X+J3nrIZ3k4y4RSTmsZGexmxUWvQYXzvVJyvT3cqBxv
 qJg5kiREw/ceO1BeBVt2yN9ktRkDnWhXJD5OIzKpAa4VRI2CBCR7t020UA425thR3PleCuxkL5q
 vZEWwt6Wmfs6lMWCmAYkf22aZg0pszN6EexfRVCHzb2pmU13NxBmGoSAvhroh1spPoY8fwlvim+
 OCyOvuavalBwbJK9zKQVQQqKFnMbkveKjs24iFEHjE6we98bT2nsgMvgeRbSb5aQ+b2PVgUwsi+
 aVUmKJfxcru2ujcdBgHiNQl4Ted+gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdx55.c | 492 +++++++++++++++++++-------------------
 drivers/interconnect/qcom/sdx55.h |  70 ------
 2 files changed, 242 insertions(+), 320 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 4117db046fa00c634a43d9287711589315f60210..b1a69e430ef444784fdc31edbe1f80877fc63cec 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -17,628 +17,617 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sdx55.h"
+
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node acm_tcu;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node xm_apps_rdwr;
+static struct qcom_icc_node qhm_audio;
+static struct qcom_icc_node qhm_blsp1;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qpic;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qhm_spmi_fetcher1;
+static struct qcom_icc_node qnm_aggre_noc;
+static struct qcom_icc_node qnm_ipa;
+static struct qcom_icc_node qnm_memnoc;
+static struct qcom_icc_node qnm_memnoc_pcie;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node xm_emac;
+static struct qcom_icc_node xm_ipa2pcie_slv;
+static struct qcom_icc_node xm_pcie;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_usb3;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_memnoc_snoc;
+static struct qcom_icc_node qns_sys_pcie;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_audio;
+static struct qcom_icc_node qhs_blsp1;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_ecc_cfg;
+static struct qcom_icc_node qhs_emac_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_pcie_parf;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qpic;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spmi_fetcher;
+static struct qcom_icc_node qhs_spmi_vgi_coex;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_usb3_phy;
+static struct qcom_icc_node qns_aggre_noc;
+static struct qcom_icc_node qns_snoc_memnoc;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_pcie;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SDX55_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node acm_tcu = {
 	.name = "acm_tcu",
-	.id = SDX55_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_LLCC,
-		   SDX55_SLAVE_MEM_NOC_SNOC,
-		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SDX55_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node xm_apps_rdwr = {
 	.name = "xm_apps_rdwr",
-	.id = SDX55_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_LLCC,
-		   SDX55_SLAVE_MEM_NOC_SNOC,
-		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node qhm_audio = {
 	.name = "qhm_audio",
-	.id = SDX55_MASTER_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node qhm_blsp1 = {
 	.name = "qhm_blsp1",
-	.id = SDX55_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDX55_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 28,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_tlmm,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = SDX55_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 5,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_AUDIO
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_ipa,
+			&qns_aggre_noc,
+			&qhs_aop,
+			&qhs_audio },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SDX55_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qhm_spmi_fetcher1 = {
 	.name = "qhm_spmi_fetcher1",
-	.id = SDX55_MASTER_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc,
+			&qhs_aop },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = SDX55_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 30,
-	.links = { SDX55_SLAVE_PCIE_0,
-		   SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QDSS_STM,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_APPSS,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &xs_pcie,
+			&qhs_snoc_cfg,
+			&qhs_sdc1,
+			&qhs_tlmm,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&xs_qdss_stm,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_usb3,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_apss,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qnm_ipa = {
 	.name = "qnm_ipa",
-	.id = SDX55_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 27,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_QDSS_STM,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_aoss,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&xs_qdss_stm,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_audio,
+			&qhs_tlmm,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qnm_memnoc = {
 	.name = "qnm_memnoc",
-	.id = SDX55_MASTER_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 29,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QDSS_STM,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_APPSS,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_tlmm,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&xs_qdss_stm,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_apss,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qnm_memnoc_pcie = {
 	.name = "qnm_memnoc_pcie",
-	.id = SDX55_MASTER_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDX55_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc,
+			&qhs_aop },
 };
 
 static struct qcom_icc_node xm_emac = {
 	.name = "xm_emac",
-	.id = SDX55_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node xm_ipa2pcie_slv = {
 	.name = "xm_ipa2pcie_slv",
-	.id = SDX55_MASTER_IPA_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = SDX55_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SDX55_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 28,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_aoss,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SDX55_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 5,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_AUDIO
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_ipa,
+			&qns_aggre_noc,
+			&qhs_aop,
+			&qhs_audio },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = SDX55_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDX55_SLAVE_EBI_CH0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDX55_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qns_memnoc_snoc = {
 	.name = "qns_memnoc_snoc",
-	.id = SDX55_SLAVE_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_MEM_NOC_SNOC },
+	.link_nodes = { &qnm_memnoc },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = SDX55_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_memnoc_pcie },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SDX55_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SDX55_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SDX55_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_audio = {
 	.name = "qhs_audio",
-	.id = SDX55_SLAVE_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_blsp1 = {
 	.name = "qhs_blsp1",
-	.id = SDX55_SLAVE_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDX55_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SDX55_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SDX55_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ecc_cfg = {
 	.name = "qhs_ecc_cfg",
-	.id = SDX55_SLAVE_ECC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_emac_cfg = {
 	.name = "qhs_emac_cfg",
-	.id = SDX55_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDX55_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDX55_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SDX55_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_parf = {
 	.name = "qhs_pcie_parf",
-	.id = SDX55_SLAVE_PCIE_PARF,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDX55_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDX55_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDX55_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = SDX55_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SDX55_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SDX55_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_spmi_fetcher = {
 	.name = "qhs_spmi_fetcher",
-	.id = SDX55_SLAVE_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_spmi_vgi_coex = {
 	.name = "qhs_spmi_vgi_coex",
-	.id = SDX55_SLAVE_SPMI_VGI_COEX,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDX55_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SDX55_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SDX55_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_phy = {
 	.name = "qhs_usb3_phy",
-	.id = SDX55_SLAVE_USB3_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_aggre_noc = {
 	.name = "qns_aggre_noc",
-	.id = SDX55_SLAVE_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc },
 };
 
 static struct qcom_icc_node qns_snoc_memnoc = {
 	.name = "qns_snoc_memnoc",
-	.id = SDX55_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDX55_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SDX55_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = SDX55_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDX55_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDX55_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
@@ -793,6 +782,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -815,6 +805,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -894,6 +885,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx55.h b/drivers/interconnect/qcom/sdx55.h
deleted file mode 100644
index 46cbabec8aa1f95be840e50618efd04bcbf89f10..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdx55.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2021, Linaro Ltd.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX55_H
-#define __DRIVERS_INTERCONNECT_QCOM_SDX55_H
-
-/* 0 was used by MASTER_IPA_CORE, now represented as RPMh clock */
-#define SDX55_MASTER_LLCC			1
-#define SDX55_MASTER_TCU_0			2
-#define SDX55_MASTER_SNOC_GC_MEM_NOC		3
-#define SDX55_MASTER_AMPSS_M0			4
-#define SDX55_MASTER_AUDIO			5
-#define SDX55_MASTER_BLSP_1			6
-#define SDX55_MASTER_QDSS_BAM			7
-#define SDX55_MASTER_QPIC			8
-#define SDX55_MASTER_SNOC_CFG			9
-#define SDX55_MASTER_SPMI_FETCHER		10
-#define SDX55_MASTER_ANOC_SNOC			11
-#define SDX55_MASTER_IPA			12
-#define SDX55_MASTER_MEM_NOC_SNOC		13
-#define SDX55_MASTER_MEM_NOC_PCIE_SNOC		14
-#define SDX55_MASTER_CRYPTO_CORE_0		15
-#define SDX55_MASTER_EMAC			16
-#define SDX55_MASTER_IPA_PCIE			17
-#define SDX55_MASTER_PCIE			18
-#define SDX55_MASTER_QDSS_ETR			19
-#define SDX55_MASTER_SDCC_1			20
-#define SDX55_MASTER_USB3			21
-/* 22 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SDX55_SLAVE_EBI_CH0			23
-#define SDX55_SLAVE_LLCC			24
-#define SDX55_SLAVE_MEM_NOC_SNOC		25
-#define SDX55_SLAVE_MEM_NOC_PCIE_SNOC		26
-#define SDX55_SLAVE_ANOC_SNOC			27
-#define SDX55_SLAVE_SNOC_CFG			28
-#define SDX55_SLAVE_EMAC_CFG			29
-#define SDX55_SLAVE_USB3			30
-#define SDX55_SLAVE_TLMM			31
-#define SDX55_SLAVE_SPMI_FETCHER		32
-#define SDX55_SLAVE_QDSS_CFG			33
-#define SDX55_SLAVE_PDM				34
-#define SDX55_SLAVE_SNOC_MEM_NOC_GC		35
-#define SDX55_SLAVE_TCSR			36
-#define SDX55_SLAVE_CNOC_DDRSS			37
-#define SDX55_SLAVE_SPMI_VGI_COEX		38
-#define SDX55_SLAVE_QPIC			39
-#define SDX55_SLAVE_OCIMEM			40
-#define SDX55_SLAVE_IPA_CFG			41
-#define SDX55_SLAVE_USB3_PHY_CFG		42
-#define SDX55_SLAVE_AOP				43
-#define SDX55_SLAVE_BLSP_1			44
-#define SDX55_SLAVE_SDCC_1			45
-#define SDX55_SLAVE_CNOC_MSS			46
-#define SDX55_SLAVE_PCIE_PARF			47
-#define SDX55_SLAVE_ECC_CFG			48
-#define SDX55_SLAVE_AUDIO			49
-#define SDX55_SLAVE_AOSS			51
-#define SDX55_SLAVE_PRNG			52
-#define SDX55_SLAVE_CRYPTO_0_CFG		53
-#define SDX55_SLAVE_TCU				54
-#define SDX55_SLAVE_CLK_CTL			55
-#define SDX55_SLAVE_IMEM_CFG			56
-#define SDX55_SLAVE_SERVICE_SNOC		57
-#define SDX55_SLAVE_PCIE_0			58
-#define SDX55_SLAVE_QDSS_STM			59
-#define SDX55_SLAVE_APPSS			60
-
-#endif

-- 
2.47.3


