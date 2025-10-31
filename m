Return-Path: <linux-pm+bounces-37206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E406EC25B39
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AEA1B2170F
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75291286D60;
	Fri, 31 Oct 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFWqgfsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isBoSMZ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B41269AEE
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921951; cv=none; b=rmYE+eWaYw2+0Gl16LQK+EwzmbrthGX85XKt0Gl6eiwxCn1jhP1/h6c5gPt1+FQoTZvViM9rMMH5pY2twIpdVbl9wT5rnlNC37YTmzkuTOcx9uCdPM6YLSfMZ8p9d/+mm3CcVPJ2W/nviu7mZNY5fDoKu8qH//g3Qtzd+g3YOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921951; c=relaxed/simple;
	bh=kEmjTMQv/fEeYMCWGjZo5rUMhgG97OMqWBAYCbIfIa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEPR2xxHEHle7iUAVt2Pb1ucAbKeoFmelKQ2euxAs/MJkrM/nAAVIy6exD5kbXeURuFH4/SnZ6AAKphH2r5IQnJByhd3R8PIwnyx8iQ8cMMjIEIIpf2s64Ecj+Nv2DJdQBmxagZN7UmLWZQA095c9KhPWg/4VrqHcsIPWVL4J7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFWqgfsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isBoSMZ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V6XfLe3115819
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r+caKMYUhI2FyvHKc9WMUzd1ZWwAkoazG3znnIliEZI=; b=YFWqgfshK+28GxJu
	dxtnOWxIdYoQe6dbxjB8rs+/CeN2ohCyGUTp0P6V/k6G+4PucnwI8xd7b5854ffn
	9E6SzvltDwzbCWBpPH+FrRR9XPiplEecJT1ZoOZuX66Z7YmiErrdptxV7zd0Qf38
	TtUnDdntNS36EW2CJNPcPp+1I+TCGl0kXZBuhSM4GfNtq8h7X2EOSXUtYTPM4pme
	diFVxF7IJNCAefT6QhKAvOoAX/FPdbIMHdn5H7q3/eFopg5xP79ObFZq/HmrZoM7
	K3T/EWuJ21FIVbwbJaIazTOmLlMhRKKcmb5KrDNDWoPNdmyeB/tqe6Y9YkSUzVkl
	eQQjlA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b44g65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-818bf399f8aso63697966d6.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921943; x=1762526743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+caKMYUhI2FyvHKc9WMUzd1ZWwAkoazG3znnIliEZI=;
        b=isBoSMZ0v7fYKAlIqb7QccG9taNE8wbc/ZKn00ZXRsU6Uo6A5AKWkYRhuYsCXIl81P
         rVNOy1zGq1vUkCiFyKpI1AQTdr66wcXpXGy3BEhPAPgIXAnW9gS2xwri01pns5nlcAhj
         1nCWvE46C/sU1l6hpTB4gpnXg7HOuICHKuQdJPiaQ8gy5IIpKiCduouibIadXCFhhhIf
         RuUuxFwT5P+E6IcPhrLaU2dmPKmo8yyZEjHTdLtk00kvmNFfPRrKcQtCTgZ0KsXj9B7w
         2y0FCChB2K0mspoiaHorNMHSjloT6lBL7VjvwVrlT5gJ3IEWrfOXA0RAh0WlpSqhryyD
         Gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921943; x=1762526743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+caKMYUhI2FyvHKc9WMUzd1ZWwAkoazG3znnIliEZI=;
        b=hF5jSZbNq3u4j/VsBPTajKFDqY7w4RCQDF3WgdkrQiFWPdCPgcpae1zauTAg0MJeeR
         YCDMW+ao9Py23yN7J47wj9LQcfZAXW4yB7kodEdlMN0bLqpJ4gp/xOl0jAZfXg6uKRoS
         AT6Ov91VpzLU3wtRXkcWAn0D4hfPsR/gfshSb7jXb0lGw8y93lJvRBHmiTG2sHPlWYtw
         mbCRLLZDXrTszoABq7gTA9+oZbgm2xTW+IgIUmmsqkmszhNPedRtyVHCcVqgDcpxKoHH
         akJTyUd4X8Lq3onlUDbiCaqO9oJtTXs9s5Q0xYGwAIZF6I6CvwggJL8/sxf/tMIHI7nv
         bYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUToTuZjuxhHabnf02ZASF4ND7ibI2fUOGH2zqr0aqQlq4+zNjjY7Avpe6kGCMRQPFMuV/aldcDTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4rnvT0tgl+n72rdFtUy47n0FChf7jx5nSwMH3tPbj0x7hnVM
	kZi2ZT3QEcbtMBDGYrpPLob3Y5POn7BwuoXuU6ySjZnaUQQgtmDrz6an2xhhFyvth8BxNqyys9K
	eMYuz6GkzlA+XgRjblyqxWEaE6po177S4ewSIbjI9J59h3+qG6oiNksqkmHda5w==
X-Gm-Gg: ASbGncu95Cg9aiDesIZOOb134B4dVKqDYHYf/tsZEy3MnygCTi5f63MqVXaFUXsXQ5x
	1gWDWj6NTrWd596srnvSysaVxbZukno8dBVarG9fCEWU1YoyTQ12flq1hjbHjh1n9h39g05VvS5
	1GRrcsiJAO6lTItAR5QHJ4gRliyqlwmWPuXXTL/7/bGUskHpF1sZPcMbE5cz7QQtyE06ZEjzgUe
	+dQCwOIlowMZGBPY8PSq81tuNACkuq//N2D531p5foJOHySxbvkLkK1UZiDL8jhl/c+lG8ui1/q
	6PsKJSM7IWbS9rxZPH8ANhyUxLVE7Vf4yJED5enEPUUHiijcSWd1Dh9QcDfEG8ciEWtrRRAk0aY
	ibb3A1jg+mdctR19audGTZVBfYx3tiUlCbBYMkOPAIkEeDgaMGLJGJZe42+plsL385TRa44JQw0
	8BFKebPcG6K1mG
X-Received: by 2002:a05:622a:ce:b0:4e8:b21d:88f1 with SMTP id d75a77b69052e-4ed30df1e48mr38930691cf.20.1761921941822;
        Fri, 31 Oct 2025 07:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCHGzPjgPwj5mEec8tQSZvXNk5UyBiG1Gph1vC7ikiJqNrxAB7uPMDLDxSZZ54anBqkFvBAQ==
X-Received: by 2002:a05:622a:ce:b0:4e8:b21d:88f1 with SMTP id d75a77b69052e-4ed30df1e48mr38930001cf.20.1761921940992;
        Fri, 31 Oct 2025 07:45:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:23 +0200
Subject: [PATCH v3 07/25] interconnect: qcom: x1e80100: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-7-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=58143;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kEmjTMQv/fEeYMCWGjZo5rUMhgG97OMqWBAYCbIfIa4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuCMFeuclh0Cq6uLmhEqgBHXMLDyPltLnxlL
 jF1wZ8ik6iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLggAKCRCLPIo+Aiko
 1efuB/9sqKkQfknUlJmRK18XL82p43PBvLONZJNtsYc62b8nLrIXPhMMV/mSN1n60ag+eW32ggn
 JMGygy4rbDd4DOO1vwK/ZzHS3yDFT2j9igPd+mcDmP6uRRkt6TORdSWlWdWLcCLBgDWH99Z60rO
 JevjCldo7cw6kDJ01K7sVDXWxsSI7zTD5q1IuRO0Op3U1VGLSqjBjqdJ2PXu1UO3q4mhRihIsav
 aAAk49gT4wowTojytbY7rU4CIGP2AnbyC4+68gMobmH1wXU3afl3FlS2hHofOHsFt1Jzjtv00tI
 HWSrNBkAjZma466gPoeRl9o0AetjBweQeIhMWSLxQ+00j3ws
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX8LyhgX1FIh3z
 07AQCyEQEkFYwLPQy70HaYfhx6RAtH377bT5QhVBNlLtV0IwlD+g10W2X0PrVL1SUUZxa7uQmxW
 snbWGWGc0HqkX4qwBO45qi+gl4lpElK38621Y+AmARy4/SdbCKjj++GBcVFMmlbnYKK8MxJGDwt
 4lFLYkiGhtGA03j7543ixkQ5YtG3kY02FLLlov2A2knhd5BTyH3EeRS+ZISE24wi3eR5EoCIvkY
 QFofh10E619JrYcgT+aZjisLoA6Z00ZZb5A5MrKMn1NhOTPkfqInKknwQHO4SsYOVHL8nRLYs7S
 PkJ08bm/wYy5BO5D3J50O0S/CYNTzdfIoMOu9ksD76xeg2pEMe8NJClAvU20bnFpzDF9E+lWcRM
 mQtrBjbNSXeDsB0HrKsvKYzTUbf++g==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6904cb97 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tMBC91xD8baL_Gpc_PYA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: pgqaKeEkqm14wxyryo2U3mqnwdbYbOro
X-Proofpoint-GUID: pgqaKeEkqm14wxyryo2U3mqnwdbYbOro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/x1e80100.c | 629 ++++++++++++++++-------------------
 drivers/interconnect/qcom/x1e80100.h | 192 -----------
 2 files changed, 292 insertions(+), 529 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 2c46fdb4a0543f8345e03dbfe83d3a7ab95bd17c..d5df26f02675de0150e2903df09fe419a8bd8892 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -15,1342 +15,1278 @@
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
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = X1E80100_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = X1E80100_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = X1E80100_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = X1E80100_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = X1E80100_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = X1E80100_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_sp = {
 	.name = "qxm_sp",
-	.id = X1E80100_MASTER_SP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = X1E80100_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = X1E80100_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = X1E80100_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = X1E80100_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = X1E80100_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = X1E80100_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave },
 };
 
 static struct qcom_icc_node qsm_cfg = {
 	.name = "qsm_cfg",
-	.id = X1E80100_MASTER_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 47,
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
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = X1E80100_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 6,
-	.links = { X1E80100_SLAVE_AOSS, X1E80100_SLAVE_TME_CFG,
-		   X1E80100_SLAVE_APPSS, X1E80100_SLAVE_CNOC_CFG,
-		   X1E80100_SLAVE_BOOT_IMEM, X1E80100_SLAVE_IMEM },
+	.link_nodes = { &qhs_aoss, &qhs_tme_cfg,
+			&qns_apss, &qss_cfg,
+			&qxs_boot_imem, &qxs_imem },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = X1E80100_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 8,
-	.links = { X1E80100_SLAVE_PCIE_0, X1E80100_SLAVE_PCIE_1,
-		   X1E80100_SLAVE_PCIE_2, X1E80100_SLAVE_PCIE_3,
-		   X1E80100_SLAVE_PCIE_4, X1E80100_SLAVE_PCIE_5,
-		   X1E80100_SLAVE_PCIE_6A, X1E80100_SLAVE_PCIE_6B },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1,
+			&xs_pcie_2, &xs_pcie_3,
+			&xs_pcie_4, &xs_pcie_5,
+			&xs_pcie_6a, &xs_pcie_6b },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = X1E80100_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
-	.id = X1E80100_MASTER_PCIE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = X1E80100_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = X1E80100_MASTER_APPSS_PROC,
 	.channels = 6,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = X1E80100_MASTER_GFX3D,
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_lpass = {
 	.name = "qnm_lpass",
-	.id = X1E80100_MASTER_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = X1E80100_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = X1E80100_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_nsp_noc = {
 	.name = "qnm_nsp_noc",
-	.id = X1E80100_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = X1E80100_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 2,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = X1E80100_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 3,
-	.links = { X1E80100_SLAVE_GEM_NOC_CNOC, X1E80100_SLAVE_LLCC,
-		   X1E80100_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = X1E80100_MASTER_GIC2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_lpiaon_noc = {
 	.name = "qnm_lpiaon_noc",
-	.id = X1E80100_MASTER_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_LPASS_GEM_NOC },
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc },
 };
 
 static struct qcom_icc_node qnm_lpass_lpinoc = {
 	.name = "qnm_lpass_lpinoc",
-	.id = X1E80100_MASTER_LPASS_LPINOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+	.link_nodes = { &qns_lpass_aggnoc },
 };
 
 static struct qcom_icc_node qxm_lpinoc_dsp_axim = {
 	.name = "qxm_lpinoc_dsp_axim",
-	.id = X1E80100_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_LPICX_NOC_LPIAON_NOC },
+	.link_nodes = { &qns_lpi_aon_noc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = X1E80100_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qnm_av1_enc = {
 	.name = "qnm_av1_enc",
-	.id = X1E80100_MASTER_AV1_ENC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = X1E80100_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = X1E80100_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = X1E80100_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_eva = {
 	.name = "qnm_eva",
-	.id = X1E80100_MASTER_EVA,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
-	.id = X1E80100_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
-	.id = X1E80100_MASTER_VIDEO,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
-	.id = X1E80100_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = X1E80100_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qsm_mnoc_cfg = {
 	.name = "qsm_mnoc_cfg",
-	.id = X1E80100_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = X1E80100_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qnm_pcie_north_gem_noc = {
 	.name = "qnm_pcie_north_gem_noc",
-	.id = X1E80100_MASTER_PCIE_NORTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node qnm_pcie_south_gem_noc = {
 	.name = "qnm_pcie_south_gem_noc",
-	.id = X1E80100_MASTER_PCIE_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_3 = {
 	.name = "xm_pcie_3",
-	.id = X1E80100_MASTER_PCIE_3,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH },
+	.link_nodes = { &qns_pcie_north_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_4 = {
 	.name = "xm_pcie_4",
-	.id = X1E80100_MASTER_PCIE_4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH },
+	.link_nodes = { &qns_pcie_north_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_5 = {
 	.name = "xm_pcie_5",
-	.id = X1E80100_MASTER_PCIE_5,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_NORTH },
+	.link_nodes = { &qns_pcie_north_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_0 = {
 	.name = "xm_pcie_0",
-	.id = X1E80100_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_1 = {
 	.name = "xm_pcie_1",
-	.id = X1E80100_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_2 = {
 	.name = "xm_pcie_2",
-	.id = X1E80100_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_6a = {
 	.name = "xm_pcie_6a",
-	.id = X1E80100_MASTER_PCIE_6A,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_6b = {
 	.name = "xm_pcie_6b",
-	.id = X1E80100_MASTER_PCIE_6B,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_PCIE_SOUTH },
+	.link_nodes = { &qns_pcie_south_gem_noc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = X1E80100_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = X1E80100_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_gic = {
 	.name = "qnm_gic",
-	.id = X1E80100_MASTER_GIC1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_usb_anoc = {
 	.name = "qnm_usb_anoc",
-	.id = X1E80100_MASTER_USB_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre_usb_north_snoc = {
 	.name = "qnm_aggre_usb_north_snoc",
-	.id = X1E80100_MASTER_AGGRE_USB_NORTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre_usb_south_snoc = {
 	.name = "qnm_aggre_usb_south_snoc",
-	.id = X1E80100_MASTER_AGGRE_USB_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_USB_NOC_SNOC },
+	.link_nodes = { &qns_aggre_usb_snoc },
 };
 
 static struct qcom_icc_node xm_usb2_0 = {
 	.name = "xm_usb2_0",
-	.id = X1E80100_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_NORTH },
+	.link_nodes = { &qns_aggre_usb_north_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_mp = {
 	.name = "xm_usb3_mp",
-	.id = X1E80100_MASTER_USB3_MP,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_NORTH },
+	.link_nodes = { &qns_aggre_usb_north_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = X1E80100_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = X1E80100_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_2 = {
 	.name = "xm_usb3_2",
-	.id = X1E80100_MASTER_USB3_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_node xm_usb4_0 = {
 	.name = "xm_usb4_0",
-	.id = X1E80100_MASTER_USB4_0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_node xm_usb4_1 = {
 	.name = "xm_usb4_1",
-	.id = X1E80100_MASTER_USB4_1,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_node xm_usb4_2 = {
 	.name = "xm_usb4_2",
-	.id = X1E80100_MASTER_USB4_2,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
+	.link_nodes = { &qns_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = X1E80100_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = X1E80100_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = X1E80100_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = X1E80100_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = X1E80100_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = X1E80100_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = X1E80100_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = X1E80100_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_av1_enc_cfg = {
 	.name = "qhs_av1_enc_cfg",
-	.id = X1E80100_SLAVE_AV1_ENC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = X1E80100_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = X1E80100_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = X1E80100_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = X1E80100_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = X1E80100_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = X1E80100_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = X1E80100_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = X1E80100_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = X1E80100_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie2_cfg = {
 	.name = "qhs_pcie2_cfg",
-	.id = X1E80100_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie3_cfg = {
 	.name = "qhs_pcie3_cfg",
-	.id = X1E80100_SLAVE_PCIE_3_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie4_cfg = {
 	.name = "qhs_pcie4_cfg",
-	.id = X1E80100_SLAVE_PCIE_4_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie5_cfg = {
 	.name = "qhs_pcie5_cfg",
-	.id = X1E80100_SLAVE_PCIE_5_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie6a_cfg = {
 	.name = "qhs_pcie6a_cfg",
-	.id = X1E80100_SLAVE_PCIE_6A_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie6b_cfg = {
 	.name = "qhs_pcie6b_cfg",
-	.id = X1E80100_SLAVE_PCIE_6B_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie_rsc_cfg = {
 	.name = "qhs_pcie_rsc_cfg",
-	.id = X1E80100_SLAVE_PCIE_RSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = X1E80100_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = X1E80100_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = X1E80100_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = X1E80100_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = X1E80100_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = X1E80100_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = X1E80100_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = X1E80100_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = X1E80100_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_smmuv3_cfg = {
 	.name = "qhs_smmuv3_cfg",
-	.id = X1E80100_SLAVE_SMMUV3_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = X1E80100_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = X1E80100_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = X1E80100_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb2_0_cfg = {
 	.name = "qhs_usb2_0_cfg",
-	.id = X1E80100_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_0_cfg = {
 	.name = "qhs_usb3_0_cfg",
-	.id = X1E80100_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_1_cfg = {
 	.name = "qhs_usb3_1_cfg",
-	.id = X1E80100_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_2_cfg = {
 	.name = "qhs_usb3_2_cfg",
-	.id = X1E80100_SLAVE_USB3_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_mp_cfg = {
 	.name = "qhs_usb3_mp_cfg",
-	.id = X1E80100_SLAVE_USB3_MP,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb4_0_cfg = {
 	.name = "qhs_usb4_0_cfg",
-	.id = X1E80100_SLAVE_USB4_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb4_1_cfg = {
 	.name = "qhs_usb4_1_cfg",
-	.id = X1E80100_SLAVE_USB4_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb4_2_cfg = {
 	.name = "qhs_usb4_2_cfg",
-	.id = X1E80100_SLAVE_USB4_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = X1E80100_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_lpass_qtb_cfg = {
 	.name = "qss_lpass_qtb_cfg",
-	.id = X1E80100_SLAVE_LPASS_QTB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_mnoc_cfg = {
 	.name = "qss_mnoc_cfg",
-	.id = X1E80100_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qsm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qss_nsp_qtb_cfg = {
 	.name = "qss_nsp_qtb_cfg",
-	.id = X1E80100_SLAVE_NSP_QTB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = X1E80100_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = X1E80100_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = X1E80100_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = X1E80100_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_apss = {
 	.name = "qns_apss",
-	.id = X1E80100_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_cfg = {
 	.name = "qss_cfg",
-	.id = X1E80100_SLAVE_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_CNOC_CFG },
+	.link_nodes = { &qsm_cfg },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = X1E80100_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = X1E80100_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = X1E80100_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = X1E80100_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_2 = {
 	.name = "xs_pcie_2",
-	.id = X1E80100_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_3 = {
 	.name = "xs_pcie_3",
-	.id = X1E80100_SLAVE_PCIE_3,
 	.channels = 1,
 	.buswidth = 64,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_4 = {
 	.name = "xs_pcie_4",
-	.id = X1E80100_SLAVE_PCIE_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_5 = {
 	.name = "xs_pcie_5",
-	.id = X1E80100_SLAVE_PCIE_5,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_6a = {
 	.name = "xs_pcie_6a",
-	.id = X1E80100_SLAVE_PCIE_6A,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_6b = {
 	.name = "xs_pcie_6b",
-	.id = X1E80100_SLAVE_PCIE_6B,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = X1E80100_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = X1E80100_SLAVE_LLCC,
 	.channels = 8,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = X1E80100_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
 	.name = "qns_lpass_ag_noc_gemnoc",
-	.id = X1E80100_SLAVE_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_LPASS_GEM_NOC },
+	.link_nodes = { &qnm_lpass },
 };
 
 static struct qcom_icc_node qns_lpass_aggnoc = {
 	.name = "qns_lpass_aggnoc",
-	.id = X1E80100_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_LPIAON_NOC },
+	.link_nodes = { &qnm_lpiaon_noc },
 };
 
 static struct qcom_icc_node qns_lpi_aon_noc = {
 	.name = "qns_lpi_aon_noc",
-	.id = X1E80100_SLAVE_LPICX_NOC_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_LPASS_LPINOC },
+	.link_nodes = { &qnm_lpass_lpinoc },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = X1E80100_SLAVE_EBI1,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = X1E80100_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = X1E80100_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = X1E80100_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = X1E80100_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_nsp_noc },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = X1E80100_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node qns_pcie_north_gem_noc = {
 	.name = "qns_pcie_north_gem_noc",
-	.id = X1E80100_SLAVE_PCIE_NORTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_PCIE_NORTH },
+	.link_nodes = { &qnm_pcie_north_gem_noc },
 };
 
 static struct qcom_icc_node qns_pcie_south_gem_noc = {
 	.name = "qns_pcie_south_gem_noc",
-	.id = X1E80100_SLAVE_PCIE_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_PCIE_SOUTH },
+	.link_nodes = { &qnm_pcie_south_gem_noc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = X1E80100_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qns_aggre_usb_snoc = {
 	.name = "qns_aggre_usb_snoc",
-	.id = X1E80100_SLAVE_USB_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_USB_NOC_SNOC },
+	.link_nodes = { &qnm_usb_anoc },
 };
 
 static struct qcom_icc_node qns_aggre_usb_north_snoc = {
 	.name = "qns_aggre_usb_north_snoc",
-	.id = X1E80100_SLAVE_AGGRE_USB_NORTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_AGGRE_USB_NORTH },
+	.link_nodes = { &qnm_aggre_usb_north_snoc },
 };
 
 static struct qcom_icc_node qns_aggre_usb_south_snoc = {
 	.name = "qns_aggre_usb_south_snoc",
-	.id = X1E80100_SLAVE_AGGRE_USB_SOUTH,
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.links = { X1E80100_MASTER_AGGRE_USB_SOUTH },
+	.link_nodes = { &qnm_aggre_usb_south_snoc },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1531,6 +1467,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1553,6 +1490,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1575,6 +1513,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1638,6 +1577,7 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_cnoc_cfg = {
+	.alloc_dyn_id = true,
 	.nodes = cnoc_cfg_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
 	.bcms = cnoc_cfg_bcms,
@@ -1668,6 +1608,7 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_cnoc_main = {
+	.alloc_dyn_id = true,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1698,6 +1639,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1713,6 +1655,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1729,6 +1672,7 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_lpiaon_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1744,6 +1688,7 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 	.bcms = lpass_lpicx_noc_bcms,
@@ -1761,6 +1706,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1789,6 +1735,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1805,6 +1752,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_nsp_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1822,6 +1770,7 @@ static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_center_anoc_nodes),
 	.bcms = pcie_center_anoc_bcms,
@@ -1839,6 +1788,7 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_north_anoc_nodes),
 	.bcms = pcie_north_anoc_bcms,
@@ -1858,6 +1808,7 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_south_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_south_anoc_nodes),
 	.bcms = pcie_south_anoc_bcms,
@@ -1880,6 +1831,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
@@ -1896,6 +1848,7 @@ static struct qcom_icc_node * const usb_center_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = usb_center_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_center_anoc_nodes),
 	.bcms = usb_center_anoc_bcms,
@@ -1912,6 +1865,7 @@ static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = usb_north_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(usb_north_anoc_nodes),
 	.bcms = usb_north_anoc_bcms,
@@ -1932,6 +1886,7 @@ static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
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
2.47.3


