Return-Path: <linux-pm+bounces-30159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C97AF98BB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9AB179EF8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEC7327A21;
	Fri,  4 Jul 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5UX0zl8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B22326A7B
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646963; cv=none; b=kXi4L0/1Qr9A0I0dOtYFISZ38VlT32sERW4srw8VI5GERldhecTNvZjhXE6nl1p4W3U35QiJgCSjk+z3qxytw818ZNn/opsBOA0bxx9MUwTS0gG10kE/snnwOXTikC9qKGotiYRu/unk4JTn35JtmkWRyNj/sQPAn0RvU9o282Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646963; c=relaxed/simple;
	bh=bBbPgWexkDpRCqTXwnbgm6YFg8/jSw7JM3CzIo4s1w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtAVr23WY2qKw9+wWDLbYayOXUSWJY8ObkrbpTHI0s9evfD3ayPEngYTIG4NJCBl4a/+i/qkAhnLn5f/pdE99tCl404qLOgxA81fRhPdAXVeHLJdgooSFfaWogeps+hHiSIB5uxM6HqUP1OydDhNtoZCCuniVJgMhvhcuOydb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5UX0zl8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5648Xspk025164
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	va5aZWVKpIytVwsEgq7nQjCg9ua6/jvkJ8zXIIesBDQ=; b=S5UX0zl8MQdg5+4p
	Ecvrq8hDUhjlTVVnK93NFEL3t3312KMB/5D6uoKURTYaFfIOMgaT4E0fBLiPF8N/
	bfyvCTf70BQHAyviXn23aWUQt4IcvWnwZ3QkYhInihYOOdx0SPCurQFAwCQYwVE6
	rfdih1+LGEsliYlyFOgPTtOsZe2WkjHch85ePd9crdq27wE3gIXWXpbBX4i1aEMl
	KnIpt2KTASelFgxNj4suTKVPAFr54JFMBthGe8nR3EJVuvb/29hNY5i5Tmm4rzVM
	Yq+aUJKwmxVuV8UqR9GlGpSgiY6/bHHpjzKzC1dhGi567qWiDc2hhg18gbSjbhO2
	QkdR6w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kd651j0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3cbf784acso282432385a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646955; x=1752251755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va5aZWVKpIytVwsEgq7nQjCg9ua6/jvkJ8zXIIesBDQ=;
        b=X/77S35Gzn380TfWlBMxntD8qxrOS04TnUInVv7sbGAQcHoDkfQJrGsCOcbSpzmi0c
         4EpWp2hgaDk4J4mMShRleeAHrJxWlHSXXRCinotgmKv7qEuNO/BN6M82KIXGL9NUN0Xl
         +6z/TVaKMnQ3Blu4uNdVTcyfWC+FkJwsYMe+7neS6znXE4kcoLoceIkg2eCKaYUbDusU
         peQel9tboULdRD3NiZ+fLBOrwQa9mJw+LYST8UUBmTNA3RJYILWXKpGy40bOm9e2JYfP
         42aiWRsbW2n/I2BZ42mZ2Xevc5Whwg44AknsQ6nlbkMs4XqrOIHI53vfSipv09GL894+
         7KMg==
X-Forwarded-Encrypted: i=1; AJvYcCVRUcEgqYCRKeS1Oxdw4BQOeNSn7JD45vvADsRvg3Omu5RLEhqnO5BpymecM1U8DEMh+qyerirnkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0UETUV23Vhaz8OPCgiCEDdyDUvZictzdSF6M9l40dsyJKdMA
	QmZD4MA5Z2onKpWihU1hADQeVecjb9915zkGH9tkZ36ZSOcmKtlkhVt6rHkqfvnIEkv0vCUOs40
	J/tzIKMXdVVD6M8nFuYmvhYX0ILYA2IT0ySckmvDfhdhETF8Cn32YQmrgjUf/Vw==
X-Gm-Gg: ASbGnctOkCYgFUA10Yq6UfTsuYW4UPRwM7CbA6kHU3q8Mco274+TzpZqE1PGWDOIA7D
	j/Ms3WRmWWPbXzz5MAQ/6AAofiZSsYUaEULsv9k86lVHis0ev99I2v8nNScGlz6tycooKzxNt0G
	XO9rdeqDpwFXJyRZ0AO/KEMeOCt5akGEcA4aqf3vR4/doTAsjju6pPFETrFEEasUHuve38kLsgc
	UCi0d+2fVbIwT3o6Urow6mA7cV39DQMriah2W3NbkaHrAuE8fcNcWiFc7HxiDjggt8XR1h5oAKt
	SAgNj546Qc0svW8A+BS8A6aXt14qKaUQtSRnlpHowOAXySzX3SPgs6qrgHrclzS8DGzEXtSSS5q
	6h9Ygw+0r8KNTG5c5H6S2jrAgSm7OPBiTMfk=
X-Received: by 2002:a05:620a:4081:b0:7ca:efed:8644 with SMTP id af79cd13be357-7d5ddaa7c92mr437653285a.5.1751646954907;
        Fri, 04 Jul 2025 09:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAk0+ghccXNshN8u7TNeu4h3k6+oaETuS8xhYM1wr/ZQ6arRzNkAkM/WufO8ztsBL4jDREcw==
X-Received: by 2002:a05:620a:4081:b0:7ca:efed:8644 with SMTP id af79cd13be357-7d5ddaa7c92mr437649185a.5.1751646954343;
        Fri, 04 Jul 2025 09:35:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:29 +0300
Subject: [PATCH v2 17/28] interconnect: qcom: sdx55: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-17-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25964;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bBbPgWexkDpRCqTXwnbgm6YFg8/jSw7JM3CzIo4s1w8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALH7ERgAaDSQu9VkVIkv7Rl2ufRw+cdHMgl/
 q+bxBHFzZyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxwAKCRCLPIo+Aiko
 1ai+B/0X2tuFHM786Y3RSMDv9VsRJPMYJSvM0sKnCeaZZOOvpoG/SdDqUHLCUhLoHxqNtCv+eHs
 0ckP4bqcUlDRYThZM+yXV65iEb1x+E93CreB6Bh/SNK2L60NN0T09eJogPGrHUHbZEo0Ve+0GcO
 +dpDe+SZ9e5NaMBZD1Owa+loiZMIWdwX/twdOqrvooWRCnRPdK/HUEUCEy8Nv6bfF3Ui7w6auvB
 iXZqtVja4nnZ1pfcOQBUkXE/GdphK1sXhHpmvx4l7Aiqwkhi+tYBigbxQvcpm9OcFnfj0J3UmS4
 BVbsbXvCymFdm4e5xMnd4qMdbS+t9X191O4k/pUDTwbkgiWD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z+PsHGRA c=1 sm=1 tr=0 ts=686802eb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lxKA6TRo1hT2z37wmrwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX+qr1OoTioXAb
 ovhNY9Yr6zioRQe8xBBODiDiCF868BByPnAFkmekykWEtcawK2Uspqgx6iVuWR5iYKmoD0X8qHz
 K97nK9oT6bIUstgXQPehEE/FQAllxUj/zEthCi2dUnfJ9zPQc2irsJjhQ9Bcm3Db79LSY9im9Vd
 vhYqPbsXQMkhYj8HpuOtxPCYIjxME76gI4qoA+5Vm7tl5nmgH8wo9fJKD8Wvxm/Mdg1Z4lYAbfd
 Tsfefd86irkxRxoWRGtIjtDgYzxoGvCPF8ucbOvPoLIXPUH1oPbR3lDshIaNn4a7Ocot4FiG6qr
 7XNIqIiWGntl/PqvecbL6Iuy6nGwfsvUGkNQ5dwiyw9kW3OlgNEcZFjCkHZUeWPgUglwVc5+K+q
 o7ZoidS4H+VxSDXQELCawhZI1pKc5/Q5y89tFBAwfljBA1Umku+bZ49+bMe4mWF1a1iBmweG
X-Proofpoint-GUID: 7nd2pT_N7hVS5mDnLbhHQx5_KtvqiVHG
X-Proofpoint-ORIG-GUID: 7nd2pT_N7hVS5mDnLbhHQx5_KtvqiVHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdx55.c | 554 +++++++++++++++++++-------------------
 drivers/interconnect/qcom/sdx55.h |  70 -----
 2 files changed, 275 insertions(+), 349 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index af273e39eef3e90519635d1c310dc108a9f8b708..5d85c1e6ec58d3949b30c143440bb6dd0779a605 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -17,630 +17,623 @@
 
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
-	.num_links = 1,
-	.links = { SDX55_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node acm_tcu = {
 	.name = "acm_tcu",
-	.id = SDX55_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 3,
-	.links = { SDX55_SLAVE_LLCC,
-		   SDX55_SLAVE_MEM_NOC_SNOC,
-		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SDX55_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node xm_apps_rdwr = {
 	.name = "xm_apps_rdwr",
-	.id = SDX55_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDX55_SLAVE_LLCC,
-		   SDX55_SLAVE_MEM_NOC_SNOC,
-		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_audio = {
 	.name = "qhm_audio",
-	.id = SDX55_MASTER_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_blsp1 = {
 	.name = "qhm_blsp1",
-	.id = SDX55_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDX55_MASTER_QDSS_BAM,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 28,
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
+	.channels = 1,
+	.buswidth = 4,
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
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = SDX55_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 5,
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
+			&qhs_audio, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SDX55_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_spmi_fetcher1 = {
 	.name = "qhm_spmi_fetcher1",
-	.id = SDX55_MASTER_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 3,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc,
+			&qhs_aop, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = SDX55_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 30,
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
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_ipa = {
 	.name = "qnm_ipa",
-	.id = SDX55_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 27,
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
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_memnoc = {
 	.name = "qnm_memnoc",
-	.id = SDX55_MASTER_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 29,
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
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_memnoc_pcie = {
 	.name = "qnm_memnoc_pcie",
-	.id = SDX55_MASTER_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDX55_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 3,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc,
+			&qhs_aop, NULL },
 };
 
 static struct qcom_icc_node xm_emac = {
 	.name = "xm_emac",
-	.id = SDX55_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_ipa2pcie_slv = {
 	.name = "xm_ipa2pcie_slv",
-	.id = SDX55_MASTER_IPA_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie, NULL },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = SDX55_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SDX55_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 28,
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
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SDX55_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 5,
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
+			&qhs_audio, NULL },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = SDX55_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDX55_SLAVE_EBI_CH0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDX55_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX55_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qns_memnoc_snoc = {
 	.name = "qns_memnoc_snoc",
-	.id = SDX55_SLAVE_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_MASTER_MEM_NOC_SNOC },
+	.link_nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = SDX55_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_MASTER_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_memnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SDX55_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SDX55_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SDX55_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_audio = {
 	.name = "qhs_audio",
-	.id = SDX55_SLAVE_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_blsp1 = {
 	.name = "qhs_blsp1",
-	.id = SDX55_SLAVE_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDX55_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SDX55_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SDX55_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ecc_cfg = {
 	.name = "qhs_ecc_cfg",
-	.id = SDX55_SLAVE_ECC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac_cfg = {
 	.name = "qhs_emac_cfg",
-	.id = SDX55_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDX55_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDX55_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SDX55_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_parf = {
 	.name = "qhs_pcie_parf",
-	.id = SDX55_SLAVE_PCIE_PARF,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDX55_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDX55_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDX55_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = SDX55_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SDX55_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SDX55_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX55_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_spmi_fetcher = {
 	.name = "qhs_spmi_fetcher",
-	.id = SDX55_SLAVE_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spmi_vgi_coex = {
 	.name = "qhs_spmi_vgi_coex",
-	.id = SDX55_SLAVE_SPMI_VGI_COEX,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDX55_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SDX55_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SDX55_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_phy = {
 	.name = "qhs_usb3_phy",
-	.id = SDX55_SLAVE_USB3_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_aggre_noc = {
 	.name = "qns_aggre_noc",
-	.id = SDX55_SLAVE_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qns_snoc_memnoc = {
 	.name = "qns_snoc_memnoc",
-	.id = SDX55_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX55_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDX55_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SDX55_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = SDX55_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDX55_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDX55_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_mc0 = {
@@ -773,6 +766,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -795,6 +789,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -874,6 +869,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
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
2.39.5


