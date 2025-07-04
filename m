Return-Path: <linux-pm+bounces-30161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07BAF98C1
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0105A4A3092
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668F3271B4;
	Fri,  4 Jul 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mA0LnYFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DF3271A0
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646965; cv=none; b=GccDLRIocPbJ3ReZpfGX4JuHIlrfuUDUPYJ0xqLeO5dPo0hL6XJCGLr9loQDCvJR9UHKfSbysxQBzk2XQTq6zYkeZvqeNHV+unTcmlZIumRv7jL/M8yO/tk7Ckv1A0nbgsRKicV4HKPzGgQX/Zg3KF76TeCcSIq3se6JHL3EbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646965; c=relaxed/simple;
	bh=z9gH4E6LS0TM+vI5PE18aVO1Idzjr3yXTAQdY21Q8z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enGgL9RhlxTb4FP2uuM9iwObLBuPnemJD1+Z2W0AvRznng4yeIWY3UcAMOCbau+0RgwqPzJ1xYVVfYpvRvfCcyYBJ+NqeIbk/O6PGTLiE+aDMbC3VO0cg2MokQN7133nEeyVRORTcU23zzYptPEi/HQEQjCYXx4xuNwGDAN9AAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mA0LnYFU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564AQQ9H009985
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GInTWFbla9zarKERqW9T4J8yFeC1+G+wqqT7Xm9GTW8=; b=mA0LnYFUJEUU8sQW
	h21LRxDdL+PQouw3WIy8lA0y+RxHbfsg4Xv1bVuZMgP2YVG8q9987rKg4GOCftrq
	IUnbpLfQJfC2y2rLUSREj1gtLWyqcGQiqJgZYCcCZwLoeDVTAL4tWKvuyVsK1S9d
	omTShpgoLR7jlE0PXfH3wm2XR1uZmGIJk8gApUfAw7VUArILtMz0N5H/WmO1/2ML
	PsO8xSbnmfvNdu2oj7FFZ+5PKYtw9MHfNpphOECpifMq8ceMQqlxxoZjXp8KeGEI
	PTDhodTg9FEqG/0A+MIsmOAIIvT/fQ16DwFuBdFgRp3Bg6JwLiGUQai+y93VW+0Q
	zwgAHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pd6w0xks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d40185a630so174381285a.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646957; x=1752251757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GInTWFbla9zarKERqW9T4J8yFeC1+G+wqqT7Xm9GTW8=;
        b=rM4b1rWMmQWG8j6hZsgQvb1+IkLX+0g5jFrgz4+Imie1nqfg1JBgTT+oW5sPLCZ6fd
         kAR2qifMSrsvSWNojsSymUaxl5jKUT2hmI0z9EQWQwmjV8uEy6sS3SCHYGEyRJv9yi6r
         BX8WvvuXfPQHefwpKk9Zd2yBgEARXa9wEklz8WPT/OH/dQ+5N9ZgAjDWCC0687/qmbXK
         o/vYFYdlj+QAvcKBD98nuu8C1+0LwrYtLHYbSgw0vkEEk6jfKNWP0LW5VHMCEQXR3l09
         FGZEpPJKuZ7sMoRAQb1tNK1B1mYRkmBRkC/vyrr+aLwF2SePgPNjE8Mb1Z9CgiBgcN5G
         nQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCW0WmLy7ukn0ejCPLxa8PMrHbViFCB7weHjej4cf0uNeLPUX84AawcvquUzgB9DoRC0XyJNAwx5lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UFXGGkqUb1wFb3zJkMnFebiHy0ypZ5RggHGuUy3a9Y/7mxBb
	o7tokWmhnHA5ZGX8UElw5d3oLXJzgdFm8f+Udumz+YnmPjQnGJBpbQJLvH1n1v0Oyjw6ZzewzcP
	VcBavckNKyGxzxiPda8VRx6VF9y7wOaIBmuM+Hquj2k557FTjV3IiUYYWfXpDpA==
X-Gm-Gg: ASbGncvXnN9q+UPmQXe9HRLzIcTxaXPV28j0cbbVZ/etmW6qmDidKvS90iZWvFjGSUw
	RiJZy59nYSw+tp0TlgpMcl0uthK9X5FzvGpDXtKhGMb03pOrwHqHO4Vtb01M674Cyhc3vN/CekM
	WpUPOdMSesGXGceVAond/cEsPEYvdmpxi4/Rc6n2kjx9TIwNbekldCVXXpzuVoOB3TQrbX0MqFO
	3D+scxUnAITXqps4jj1g+HFePw+irLeH6w8PF4HxgRNsD6u9PPCeYZZ1DRm/aFrZVIop5t3Hi3l
	dpuukYw8KBSwTZm9rbb2ThPEsQjtBjuAuWrP2BtXRWums1bBnrotH5BsXTg2m8cFOm9fFBBi/dw
	p8zaJE8ZA6bRGqSNhGiSru/F0PVQi2mH70/E=
X-Received: by 2002:a05:620a:7085:b0:7d4:4b9b:3eed with SMTP id af79cd13be357-7d5df1130c8mr366111285a.25.1751646956274;
        Fri, 04 Jul 2025 09:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/toiDffxY7KbtAudogFdq/CPIewqtE5ftiNmVcL2hhumMIoTeaXgjqOgHgiZRVoySPLjq+w==
X-Received: by 2002:a05:620a:7085:b0:7d4:4b9b:3eed with SMTP id af79cd13be357-7d5df1130c8mr366106685a.25.1751646955684;
        Fri, 04 Jul 2025 09:35:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:30 +0300
Subject: [PATCH v2 18/28] interconnect: qcom: sdx65: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-18-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24526;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=z9gH4E6LS0TM+vI5PE18aVO1Idzjr3yXTAQdY21Q8z4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALHWRqfhwLmKggAISb8vUagD8jvNLWYu/XpK
 x7fNoAuh96JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxwAKCRCLPIo+Aiko
 1dkxB/9IBWmZeQP+kkhV1PCl9S2HgQcDpXnDR6fX3pLdyv3pHxyXeOxWS/1s0P59//LTNYCbuh/
 j0xmiNNY7xdU5uFhMsGuJd1zN1+Sg+hgMa/iE52BgDUpWu4vtXPX/n+tncsme7crMcXQDGxuw5t
 rY2QHhPCuwJB/STJcBexTtjj9uUO120znSXjV3D2jDX22tVbsAS/6jYIiLxY09ok8xKb4beac8G
 Q7B+1a5tVdhyMs/GQdi98HF5c+cv1Byvvh5ERmYTVnE8UtafGQ76mynuoqjL/1cI2tdTVfecdmP
 mL242sz0L9DC4+vmA3gjoA1fAaFftQD1cGrBdtkJ4Z1iYexI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX2eJCOOqdGf3M
 vd2LmPFGeFWDa50Dwmd/eIiHtHEeaERxXt9JUvgnt+loFGzNiNMiAFCRWYROXgwdwLgtLzMs+7N
 J57/nHu58L1UqF2fWTpRg7bo0xoAW8hnnfpl+776Qe0t2cAmNXZEZZcSGr8GHl4/wFin99p+yq8
 la5CU+RFDDlRuEh0JRChDrL/OvNGxDk1gCdd6Ca7BTqyvOQseOYDuA2SQILNrW3DlW8ZagNMBZc
 MhNNqHUZN7PXCUFDgxODTwxG9y9wbE1JXBJGTfwyg1J2crPM4XMOYgCOGLrf7mv2O/w33R4ZNFo
 ueHCfh/F5EDA6mhhQIcMqVMXWJLxC9kyKCV4REDDyVgTNKplttsK0fIqmRHRBT17Guu5c/pjzSb
 /p5lqtlzgaadTlY+qpQkl0qCIY2E+YhTVTno3z7FRn0EmMNaY9SPKEOkxs0IK4L+JekporHe
X-Proofpoint-GUID: 1EgYvAEQDjBgf1DBBitFcmdkBb_jGt-t
X-Authority-Analysis: v=2.4 cv=UPrdHDfy c=1 sm=1 tr=0 ts=686802ee cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=SBZ_mQBx4u5IdJMTS58A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 1EgYvAEQDjBgf1DBBitFcmdkBb_jGt-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdx65.c | 519 +++++++++++++++++++-------------------
 drivers/interconnect/qcom/sdx65.h |  65 -----
 2 files changed, 257 insertions(+), 327 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index cf24f94eef6e0e1a7c1e957e07a316803942d174..267eeeec0e655e13c9643c432139f4b94542d959 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -13,595 +13,587 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sdx65.h"
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
+static struct qcom_icc_node xm_ipa2pcie_slv;
+static struct qcom_icc_node xm_pcie;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_usb3;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_memnoc_snoc;
+static struct qcom_icc_node qns_sys_pcie;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_audio;
+static struct qcom_icc_node qhs_blsp1;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_ecc_cfg;
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
-	.id = SDX65_MASTER_LLCC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node acm_tcu = {
 	.name = "acm_tcu",
-	.id = SDX65_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 3,
-	.links = { SDX65_SLAVE_LLCC,
-		   SDX65_SLAVE_MEM_NOC_SNOC,
-		   SDX65_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SDX65_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node xm_apps_rdwr = {
 	.name = "xm_apps_rdwr",
-	.id = SDX65_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDX65_SLAVE_LLCC,
-		   SDX65_SLAVE_MEM_NOC_SNOC,
-		   SDX65_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_audio = {
 	.name = "qhm_audio",
-	.id = SDX65_MASTER_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_blsp1 = {
 	.name = "qhm_blsp1",
-	.id = SDX65_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDX65_MASTER_QDSS_BAM,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 26,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_BLSP_1,
-		   SDX65_SLAVE_CLK_CTL,
-		   SDX65_SLAVE_CRYPTO_0_CFG,
-		   SDX65_SLAVE_CNOC_DDRSS,
-		   SDX65_SLAVE_ECC_CFG,
-		   SDX65_SLAVE_IMEM_CFG,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_CNOC_MSS,
-		   SDX65_SLAVE_PCIE_PARF,
-		   SDX65_SLAVE_PDM,
-		   SDX65_SLAVE_PRNG,
-		   SDX65_SLAVE_QDSS_CFG,
-		   SDX65_SLAVE_QPIC,
-		   SDX65_SLAVE_SDCC_1,
-		   SDX65_SLAVE_SNOC_CFG,
-		   SDX65_SLAVE_SPMI_FETCHER,
-		   SDX65_SLAVE_SPMI_VGI_COEX,
-		   SDX65_SLAVE_TCSR,
-		   SDX65_SLAVE_TLMM,
-		   SDX65_SLAVE_USB3,
-		   SDX65_SLAVE_USB3_PHY_CFG,
-		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX65_SLAVE_IMEM,
-		   SDX65_SLAVE_TCU
-	},
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qhs_aoss,
+			&qhs_audio,
+			&qhs_blsp1,
+			&qhs_clk_ctl,
+			&qhs_crypto0_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ecc_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_pdm,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qpic,
+			&qhs_sdc1,
+			&qhs_snoc_cfg,
+			&qhs_spmi_fetcher,
+			&qhs_spmi_vgi_coex,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_usb3,
+			&qhs_usb3_phy,
+			&qns_snoc_memnoc,
+			&qxs_imem,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = SDX65_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 4,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_ANOC_SNOC
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_audio,
+			&qhs_ipa,
+			&qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SDX65_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_spmi_fetcher1 = {
 	.name = "qhm_spmi_fetcher1",
-	.id = SDX65_MASTER_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_ANOC_SNOC
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = SDX65_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 29,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_APPSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_BLSP_1,
-		   SDX65_SLAVE_CLK_CTL,
-		   SDX65_SLAVE_CRYPTO_0_CFG,
-		   SDX65_SLAVE_CNOC_DDRSS,
-		   SDX65_SLAVE_ECC_CFG,
-		   SDX65_SLAVE_IMEM_CFG,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_CNOC_MSS,
-		   SDX65_SLAVE_PCIE_PARF,
-		   SDX65_SLAVE_PDM,
-		   SDX65_SLAVE_PRNG,
-		   SDX65_SLAVE_QDSS_CFG,
-		   SDX65_SLAVE_QPIC,
-		   SDX65_SLAVE_SDCC_1,
-		   SDX65_SLAVE_SNOC_CFG,
-		   SDX65_SLAVE_SPMI_FETCHER,
-		   SDX65_SLAVE_SPMI_VGI_COEX,
-		   SDX65_SLAVE_TCSR,
-		   SDX65_SLAVE_TLMM,
-		   SDX65_SLAVE_USB3,
-		   SDX65_SLAVE_USB3_PHY_CFG,
-		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX65_SLAVE_IMEM,
-		   SDX65_SLAVE_PCIE_0,
-		   SDX65_SLAVE_QDSS_STM,
-		   SDX65_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_apss,
+			&qhs_audio,
+			&qhs_blsp1,
+			&qhs_clk_ctl,
+			&qhs_crypto0_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ecc_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_pdm,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qpic,
+			&qhs_sdc1,
+			&qhs_snoc_cfg,
+			&qhs_spmi_fetcher,
+			&qhs_spmi_vgi_coex,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_usb3,
+			&qhs_usb3_phy,
+			&qns_snoc_memnoc,
+			&qxs_imem,
+			&xs_pcie,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_ipa = {
 	.name = "qnm_ipa",
-	.id = SDX65_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 26,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_BLSP_1,
-		   SDX65_SLAVE_CLK_CTL,
-		   SDX65_SLAVE_CRYPTO_0_CFG,
-		   SDX65_SLAVE_CNOC_DDRSS,
-		   SDX65_SLAVE_ECC_CFG,
-		   SDX65_SLAVE_IMEM_CFG,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_CNOC_MSS,
-		   SDX65_SLAVE_PCIE_PARF,
-		   SDX65_SLAVE_PDM,
-		   SDX65_SLAVE_PRNG,
-		   SDX65_SLAVE_QDSS_CFG,
-		   SDX65_SLAVE_QPIC,
-		   SDX65_SLAVE_SDCC_1,
-		   SDX65_SLAVE_SNOC_CFG,
-		   SDX65_SLAVE_SPMI_FETCHER,
-		   SDX65_SLAVE_TCSR,
-		   SDX65_SLAVE_TLMM,
-		   SDX65_SLAVE_USB3,
-		   SDX65_SLAVE_USB3_PHY_CFG,
-		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX65_SLAVE_IMEM,
-		   SDX65_SLAVE_PCIE_0,
-		   SDX65_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_audio,
+			&qhs_blsp1,
+			&qhs_clk_ctl,
+			&qhs_crypto0_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ecc_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_pdm,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qpic,
+			&qhs_sdc1,
+			&qhs_snoc_cfg,
+			&qhs_spmi_fetcher,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_usb3,
+			&qhs_usb3_phy,
+			&qns_snoc_memnoc,
+			&qxs_imem,
+			&xs_pcie,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_memnoc = {
 	.name = "qnm_memnoc",
-	.id = SDX65_MASTER_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 27,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_APPSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_BLSP_1,
-		   SDX65_SLAVE_CLK_CTL,
-		   SDX65_SLAVE_CRYPTO_0_CFG,
-		   SDX65_SLAVE_CNOC_DDRSS,
-		   SDX65_SLAVE_ECC_CFG,
-		   SDX65_SLAVE_IMEM_CFG,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_CNOC_MSS,
-		   SDX65_SLAVE_PCIE_PARF,
-		   SDX65_SLAVE_PDM,
-		   SDX65_SLAVE_PRNG,
-		   SDX65_SLAVE_QDSS_CFG,
-		   SDX65_SLAVE_QPIC,
-		   SDX65_SLAVE_SDCC_1,
-		   SDX65_SLAVE_SNOC_CFG,
-		   SDX65_SLAVE_SPMI_FETCHER,
-		   SDX65_SLAVE_SPMI_VGI_COEX,
-		   SDX65_SLAVE_TCSR,
-		   SDX65_SLAVE_TLMM,
-		   SDX65_SLAVE_USB3,
-		   SDX65_SLAVE_USB3_PHY_CFG,
-		   SDX65_SLAVE_IMEM,
-		   SDX65_SLAVE_QDSS_STM,
-		   SDX65_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_apss,
+			&qhs_audio,
+			&qhs_blsp1,
+			&qhs_clk_ctl,
+			&qhs_crypto0_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ecc_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_pdm,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qpic,
+			&qhs_sdc1,
+			&qhs_snoc_cfg,
+			&qhs_spmi_fetcher,
+			&qhs_spmi_vgi_coex,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_usb3,
+			&qhs_usb3_phy,
+			&qxs_imem,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_memnoc_pcie = {
 	.name = "qnm_memnoc_pcie",
-	.id = SDX65_MASTER_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDX65_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_ANOC_SNOC
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_ipa2pcie_slv = {
 	.name = "xm_ipa2pcie_slv",
-	.id = SDX65_MASTER_IPA_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = SDX65_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SDX65_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 26,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_BLSP_1,
-		   SDX65_SLAVE_CLK_CTL,
-		   SDX65_SLAVE_CRYPTO_0_CFG,
-		   SDX65_SLAVE_CNOC_DDRSS,
-		   SDX65_SLAVE_ECC_CFG,
-		   SDX65_SLAVE_IMEM_CFG,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_CNOC_MSS,
-		   SDX65_SLAVE_PCIE_PARF,
-		   SDX65_SLAVE_PDM,
-		   SDX65_SLAVE_PRNG,
-		   SDX65_SLAVE_QDSS_CFG,
-		   SDX65_SLAVE_QPIC,
-		   SDX65_SLAVE_SDCC_1,
-		   SDX65_SLAVE_SNOC_CFG,
-		   SDX65_SLAVE_SPMI_FETCHER,
-		   SDX65_SLAVE_SPMI_VGI_COEX,
-		   SDX65_SLAVE_TCSR,
-		   SDX65_SLAVE_TLMM,
-		   SDX65_SLAVE_USB3,
-		   SDX65_SLAVE_USB3_PHY_CFG,
-		   SDX65_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX65_SLAVE_IMEM,
-		   SDX65_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_audio,
+			&qhs_blsp1,
+			&qhs_clk_ctl,
+			&qhs_crypto0_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ecc_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_pdm,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qpic,
+			&qhs_sdc1,
+			&qhs_snoc_cfg,
+			&qhs_spmi_fetcher,
+			&qhs_spmi_vgi_coex,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_usb3,
+			&qhs_usb3_phy,
+			&qns_snoc_memnoc,
+			&qxs_imem,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SDX65_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 4,
-	.links = { SDX65_SLAVE_AOSS,
-		   SDX65_SLAVE_AUDIO,
-		   SDX65_SLAVE_IPA_CFG,
-		   SDX65_SLAVE_ANOC_SNOC
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_audio,
+			&qhs_ipa,
+			&qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = SDX65_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDX65_SLAVE_EBI1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDX65_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX65_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_memnoc_snoc = {
 	.name = "qns_memnoc_snoc",
-	.id = SDX65_SLAVE_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_MASTER_MEM_NOC_SNOC },
+	.link_nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = SDX65_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_MASTER_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_memnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SDX65_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SDX65_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_audio = {
 	.name = "qhs_audio",
-	.id = SDX65_SLAVE_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_blsp1 = {
 	.name = "qhs_blsp1",
-	.id = SDX65_SLAVE_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDX65_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SDX65_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SDX65_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ecc_cfg = {
 	.name = "qhs_ecc_cfg",
-	.id = SDX65_SLAVE_ECC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDX65_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDX65_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SDX65_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_parf = {
 	.name = "qhs_pcie_parf",
-	.id = SDX65_SLAVE_PCIE_PARF,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDX65_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDX65_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDX65_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = SDX65_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SDX65_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SDX65_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX65_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_spmi_fetcher = {
 	.name = "qhs_spmi_fetcher",
-	.id = SDX65_SLAVE_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spmi_vgi_coex = {
 	.name = "qhs_spmi_vgi_coex",
-	.id = SDX65_SLAVE_SPMI_VGI_COEX,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDX65_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SDX65_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SDX65_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_phy = {
 	.name = "qhs_usb3_phy",
-	.id = SDX65_SLAVE_USB3_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_aggre_noc = {
 	.name = "qns_aggre_noc",
-	.id = SDX65_SLAVE_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX65_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qns_snoc_memnoc = {
 	.name = "qns_snoc_memnoc",
-	.id = SDX65_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX65_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDX65_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SDX65_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = SDX65_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDX65_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDX65_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
@@ -759,6 +751,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx65_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -781,6 +774,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx65_mem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -857,6 +851,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx65_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx65.h b/drivers/interconnect/qcom/sdx65.h
deleted file mode 100644
index 5dca6e8b32c99942e4a4f474999bc72ea2fb4fb6..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdx65.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX65_H
-#define __DRIVERS_INTERCONNECT_QCOM_SDX65_H
-
-#define SDX65_MASTER_TCU_0		0
-#define SDX65_MASTER_LLCC		1
-#define SDX65_MASTER_AUDIO		2
-#define SDX65_MASTER_BLSP_1		3
-#define SDX65_MASTER_QDSS_BAM		4
-#define SDX65_MASTER_QPIC		5
-#define SDX65_MASTER_SNOC_CFG		6
-#define SDX65_MASTER_SPMI_FETCHER	7
-#define SDX65_MASTER_ANOC_SNOC		8
-#define SDX65_MASTER_IPA		9
-#define SDX65_MASTER_MEM_NOC_SNOC	10
-#define SDX65_MASTER_MEM_NOC_PCIE_SNOC	11
-#define SDX65_MASTER_SNOC_GC_MEM_NOC	12
-#define SDX65_MASTER_CRYPTO		13
-#define SDX65_MASTER_APPSS_PROC		14
-#define SDX65_MASTER_IPA_PCIE		15
-#define SDX65_MASTER_PCIE_0		16
-#define SDX65_MASTER_QDSS_ETR		17
-#define SDX65_MASTER_SDCC_1		18
-#define SDX65_MASTER_USB3		19
-#define SDX65_SLAVE_EBI1		512
-#define SDX65_SLAVE_AOSS		513
-#define SDX65_SLAVE_APPSS		514
-#define SDX65_SLAVE_AUDIO		515
-#define SDX65_SLAVE_BLSP_1		516
-#define SDX65_SLAVE_CLK_CTL		517
-#define SDX65_SLAVE_CRYPTO_0_CFG	518
-#define SDX65_SLAVE_CNOC_DDRSS		519
-#define SDX65_SLAVE_ECC_CFG		520
-#define SDX65_SLAVE_IMEM_CFG		521
-#define SDX65_SLAVE_IPA_CFG		522
-#define SDX65_SLAVE_CNOC_MSS		523
-#define SDX65_SLAVE_PCIE_PARF		524
-#define SDX65_SLAVE_PDM			525
-#define SDX65_SLAVE_PRNG		526
-#define SDX65_SLAVE_QDSS_CFG		527
-#define SDX65_SLAVE_QPIC		528
-#define SDX65_SLAVE_SDCC_1		529
-#define SDX65_SLAVE_SNOC_CFG		530
-#define SDX65_SLAVE_SPMI_FETCHER	531
-#define SDX65_SLAVE_SPMI_VGI_COEX	532
-#define SDX65_SLAVE_TCSR		533
-#define SDX65_SLAVE_TLMM		534
-#define SDX65_SLAVE_USB3		535
-#define SDX65_SLAVE_USB3_PHY_CFG	536
-#define SDX65_SLAVE_ANOC_SNOC		537
-#define SDX65_SLAVE_LLCC		538
-#define SDX65_SLAVE_MEM_NOC_SNOC	539
-#define SDX65_SLAVE_SNOC_MEM_NOC_GC	540
-#define SDX65_SLAVE_MEM_NOC_PCIE_SNOC	541
-#define SDX65_SLAVE_IMEM		542
-#define SDX65_SLAVE_SERVICE_SNOC	543
-#define SDX65_SLAVE_PCIE_0		544
-#define SDX65_SLAVE_QDSS_STM		545
-#define SDX65_SLAVE_TCU			546
-
-#endif

-- 
2.39.5


