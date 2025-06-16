Return-Path: <linux-pm+bounces-28759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7401ADA530
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002C63ACF66
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2319F424;
	Mon, 16 Jun 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1wnyHsv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5027D763
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033797; cv=none; b=aqggxvfcm/ZTyEuGWS0olXUmKVRQPjWaGp76/QGnJP107W/W/V1E3fuzzEWdpavj2kvp+EZYL0YbmrndesddP6dQBA6mHiul/X0fwff1knBKw9lzLGjmjTFyZOafHrxDWgecCl0mcs1AjNYB1MYBhtLKb2VOG0T+lHt+/BVJn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033797; c=relaxed/simple;
	bh=1B2I0+eUBpRrRvPAqBvUbalO/FagIr3cL8S8bqPrkfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S00RaRURTKpfBLUR4rL+5XR9KN44PpNfao5oykMWr+dB2sonVdZm+LLbtCar2U4KAn1naZEfPI8j91+iFpT+7yYx/YXR/yTkjea0BpS5t2PUvZpwFZY75PhXJmdjS9qH+sgKLKml9MDb5+F+l9yLMf9XxXubxtIoonSKBL2naOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1wnyHsv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNWaAu018217
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X9UCjigJbRQPQ05q10+bDlSIcVFMSunKT0tVWBLx8cw=; b=E1wnyHsvwAocPNIC
	WHa1ZnjUzxbSwogBZs00f5AurmpNj3IcE46dUSmId8Gl3L++uoqIIw4Dto3POdIm
	kmoBBu/mpeOSlXUQHGzRshqlspo7+LLRBO2Vos4ru+6RIaSbCyjprSNzYOGpj3zu
	TAp4LTwfyZClhSj9h2BwvCJCe4XB2B7SmJ/v+GMcXNaKHk8ijebwdp5l57eUHeef
	WZiRQc3bl3dx96xTzYhvrZUa2lZ9m+frUlNOVGfWdww15AhlygxJdnCQ4sct8JSi
	9dYBaZWRnOriyw/wUsoPosrAJkP7/dBFIWq+J6GHClRItHe/j8bMrhjF6MS7y4M3
	V9j0hg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mahnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb520a74c8so13743296d6.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033791; x=1750638591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9UCjigJbRQPQ05q10+bDlSIcVFMSunKT0tVWBLx8cw=;
        b=KdvqGJd4WbFK/v3r9H+53oYgZ0Wl0FMIbbQ85x/K6VKwNpZsFFUITisARMD3TYUqES
         6G2AsFLPgV8shyUv+bGcTgG1i1ZGynrEVDCJtzU3tewspkvGmzVknUQme7YL7rJ8hr/g
         67CFcdEGquk79SZ00c2LjAht8Oys9HC/SPc/GH2z9mROxOKWrvSwkuT20lBjni+wIQpH
         akuSI+4pnNWoj1+30HvgbE2/g64nq4xkijkt+W5W4zWJUEuWXUzZNKGq18WP6QTbo4Dd
         ZzYWQH8rZqLjdZvksDSaB640UGPGim1NkOapIhrzeTm/KyDMfJFS4mS+UGNLshdiJQhc
         UaYw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0ql+fwEn70VMpcIEO3GKtaZopdr65cEwo7vOcqPg+2ieU5xMLn77F2M0w6pLh9ivLZw8uKmJCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MIHDSL/3IAL7nHzbviXT43iO7WTNZADCKZlr0xHp7GdGZzIk
	mgNnNEk1xrXyjd/9ZoICIztEX2jbouJkXnQwalS1pn67JUCJi6dDBwngNKGyLWx/YJvvO+jgB3i
	6U5L5Vfv1WjQXhmC87myVKpDD72nnOi5cx2NZDUYNJb/qknKQzZGmzy6b9n/bGw==
X-Gm-Gg: ASbGncv4ESuFxRxzsyQuE9MxOPpW9wbaG+RCyZr6Gjs7Kb3qa19WmWOusl9MLoK/Z/S
	lXMiSa00VoIktyAlIrLUc3CDq3qz1ESQLjXmR2sScClcASv1gn8VhV9lhNNI+NYZbWvOouOjlEW
	pzgus01qINOx5vWC+Yj9D6auYbiWF5lAzyhNilGYD5R0YdKd7/y/7giY9HppShLaq2rvMeJ9bdv
	qur85wkvk+ZH34/vRyAOZoKMwmAXNcgd9SpbN5VkQF2jh5IsldnyvRTydfx/HrGGn08WRVT1p8i
	q+fX+ejwB1mF4tF1rre5zwnsAnAA/uHkWPGnlA8Nh2Q2bmzePnDlGJFcyWOyHvWlrn5d6Errnzj
	VT416Nri4bmVidGVRUa1oLnm4zJRd4j626U8=
X-Received: by 2002:a05:6214:5014:b0:6fa:fddf:7343 with SMTP id 6a1803df08f44-6fb477784fbmr115763346d6.23.1750033790547;
        Sun, 15 Jun 2025 17:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhWDp3FCJOvt2mCB/83fLa1BLGZDNPc3uWIv3kn1kL2fIOH1hNBYPXyCov48DozlwFnwEQrA==
X-Received: by 2002:a05:6214:5014:b0:6fa:fddf:7343 with SMTP id 6a1803df08f44-6fb477784fbmr115763016d6.23.1750033789888;
        Sun, 15 Jun 2025 17:29:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:29:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:35 +0300
Subject: [PATCH 23/28] interconnect: qcom: sm8350: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-23-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=52627;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1B2I0+eUBpRrRvPAqBvUbalO/FagIr3cL8S8bqPrkfI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UlUnX8byRheQCg7+0//Ci3Y0/n5UcWiMhiW
 eQWDKJhxoiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lJQAKCRCLPIo+Aiko
 1WHLB/4pf891crvcmVLsuLv/Z3UxaVnO7pWdNO1PXOwaqmGTVJoKHuiE6HlLWA9qUxTKFmZP4fk
 EMFGmdHXZ3CGb5bqsEbWu167+o+bsVrQgL3ekW59RVjMLH+jyCCBv4P90PfigJcdrBHyiAJlvNf
 nSDf2yKQjZbq+jyT3u0s0O0HHzG9zzLbLdDHY94Uf4F2ub1aQyzhXz6WFcTdjEkvKAfSoKv7iTA
 1DMXo6XFQCaN4UQC+JXeb7ezgxsxYhQWVNcSvOmaLftO1kBUUor9BCqmsP8n5Jwy9cAEFItdDkd
 BDVzVHP/Bc+w7E3GvwYrzLffqi1YapU76rEBsBOgs7WT9aZS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfXxkWTeP+faqT+
 T7hCeFJ7l8vuFXsQi+k8xPaKWuiiYg1a0FgHNQpncDBroxbh3omPJCQTPYE29/KZcneIZCbImwj
 ahoc9gSzwQdU6J3woLw1PYR4kiZLotbyFNicQv5DyPFyIR0ncW2wCIpzFbzWvMAXf582BBa1aZC
 dgYWLIKbhu3G2xMjZwck2pzCegDWRHEKm17An5IMQTyTTBCkDxoAd9xBiAleF7qm+Uzb9sWB5+R
 Njqcfy1L6oyQnIxnqCCEQC/MWBC9zUVqPwcu2tlCW3qD7h8BnQvEf/O3rYzjRGxesGfqA5gjQMA
 qcGC7ARWs23IEex1KgezExsiFHwVv/54sAR3su4HuastQ6RriE+SrEpvU2BUa1UVrMTqOG9bVFh
 Sw7Ff1qkQkttnPpUZIRJJJ2zSqVXkXzD5i7HC2jLq4ORjDHUhLSSN52Zhn6JDk47QescqIw0
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=684f6580 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=u7NRIRagGOHztoaRbKsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: QIgL3yyIF_c5bclyp1MB5Pqp89vmPuyE
X-Proofpoint-ORIG-GUID: QIgL3yyIF_c5bclyp1MB5Pqp89vmPuyE
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
 drivers/interconnect/qcom/sm8350.c | 834 +++++++++++++++++++------------------
 drivers/interconnect/qcom/sm8350.h | 158 -------
 2 files changed, 422 insertions(+), 570 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 3fa17b5786b726a8a61c347f9e2bb61dc0709546..d268bb68b18cd7e9b06bd060f905b4f22e565e5e 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -13,1257 +13,1257 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sm8350.h"
+
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qnm_a1noc_cfg;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qnm_a2noc_cfg;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_ufs_card;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qnm_cnoc_dc_noc;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_gemnoc_cfg;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qhm_config_noc;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mnoc_cfg;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video1;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_mdp1;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qhm_nsp_noc_config;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_snoc_cfg;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_hwkm;
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
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_card_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_usb3_1;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_a1_noc_cfg;
+static struct qcom_icc_node qns_a2_noc_cfg;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_mnoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qxs_boot_imem;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qns_gemnoc;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qhs_modem_ms_mpu_cfg;
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
+static struct qcom_icc_node srvc_niu_aml_noc;
+static struct qcom_icc_node srvc_niu_lpass_agnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node service_nsp_noc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node srvc_snoc;
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8350_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SM8350_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8350_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8350_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a1noc_cfg = {
 	.name = "qnm_a1noc_cfg",
-	.id = SM8350_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8350_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8350_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8350_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SM8350_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8350_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a2noc_cfg = {
 	.name = "qnm_a2noc_cfg",
-	.id = SM8350_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8350_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8350_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM8350_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SM8350_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM8350_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8350_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
-	.id = SM8350_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SM8350_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 56,
-	.links = { SM8350_SLAVE_AHB2PHY_SOUTH,
-		   SM8350_SLAVE_AHB2PHY_NORTH,
-		   SM8350_SLAVE_AOSS,
-		   SM8350_SLAVE_APPSS,
-		   SM8350_SLAVE_CAMERA_CFG,
-		   SM8350_SLAVE_CLK_CTL,
-		   SM8350_SLAVE_CDSP_CFG,
-		   SM8350_SLAVE_RBCPR_CX_CFG,
-		   SM8350_SLAVE_RBCPR_MMCX_CFG,
-		   SM8350_SLAVE_RBCPR_MX_CFG,
-		   SM8350_SLAVE_CRYPTO_0_CFG,
-		   SM8350_SLAVE_CX_RDPM,
-		   SM8350_SLAVE_DCC_CFG,
-		   SM8350_SLAVE_DISPLAY_CFG,
-		   SM8350_SLAVE_GFX3D_CFG,
-		   SM8350_SLAVE_HWKM,
-		   SM8350_SLAVE_IMEM_CFG,
-		   SM8350_SLAVE_IPA_CFG,
-		   SM8350_SLAVE_IPC_ROUTER_CFG,
-		   SM8350_SLAVE_LPASS,
-		   SM8350_SLAVE_CNOC_MSS,
-		   SM8350_SLAVE_MX_RDPM,
-		   SM8350_SLAVE_PCIE_0_CFG,
-		   SM8350_SLAVE_PCIE_1_CFG,
-		   SM8350_SLAVE_PDM,
-		   SM8350_SLAVE_PIMEM_CFG,
-		   SM8350_SLAVE_PKA_WRAPPER_CFG,
-		   SM8350_SLAVE_PMU_WRAPPER_CFG,
-		   SM8350_SLAVE_QDSS_CFG,
-		   SM8350_SLAVE_QSPI_0,
-		   SM8350_SLAVE_QUP_0,
-		   SM8350_SLAVE_QUP_1,
-		   SM8350_SLAVE_QUP_2,
-		   SM8350_SLAVE_SDCC_2,
-		   SM8350_SLAVE_SDCC_4,
-		   SM8350_SLAVE_SECURITY,
-		   SM8350_SLAVE_SPSS_CFG,
-		   SM8350_SLAVE_TCSR,
-		   SM8350_SLAVE_TLMM,
-		   SM8350_SLAVE_UFS_CARD_CFG,
-		   SM8350_SLAVE_UFS_MEM_CFG,
-		   SM8350_SLAVE_USB3_0,
-		   SM8350_SLAVE_USB3_1,
-		   SM8350_SLAVE_VENUS_CFG,
-		   SM8350_SLAVE_VSENSE_CTRL_CFG,
-		   SM8350_SLAVE_A1NOC_CFG,
-		   SM8350_SLAVE_A2NOC_CFG,
-		   SM8350_SLAVE_DDRSS_CFG,
-		   SM8350_SLAVE_CNOC_MNOC_CFG,
-		   SM8350_SLAVE_SNOC_CFG,
-		   SM8350_SLAVE_BOOT_IMEM,
-		   SM8350_SLAVE_IMEM,
-		   SM8350_SLAVE_PIMEM,
-		   SM8350_SLAVE_SERVICE_CNOC,
-		   SM8350_SLAVE_QDSS_STM,
-		   SM8350_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_ahb2phy0,
+			&qhs_ahb2phy1,
+			&qhs_aoss,
+			&qhs_apss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute_cfg,
+			&qhs_cpr_cx,
+			&qhs_cpr_mmcx,
+			&qhs_cpr_mx,
+			&qhs_crypto0_cfg,
+			&qhs_cx_rdpm,
+			&qhs_dcc_cfg,
+			&qhs_display_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_hwkm,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_ipc_router,
+			&qhs_lpass_cfg,
+			&qhs_mss_cfg,
+			&qhs_mx_rdpm,
+			&qhs_pcie0_cfg,
+			&qhs_pcie1_cfg,
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
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qns_a1_noc_cfg,
+			&qns_a2_noc_cfg,
+			&qns_ddrss_cfg,
+			&qns_mnoc_cfg,
+			&qns_snoc_cfg,
+			&qxs_boot_imem,
+			&qxs_imem,
+			&qxs_pimem,
+			&srvc_cnoc,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SM8350_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_PCIE_0,
-		   SM8350_SLAVE_PCIE_1
-	},
+	.link_nodes = { &xs_pcie_0,
+			&xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM8350_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 56,
-	.links = { SM8350_SLAVE_AHB2PHY_SOUTH,
-		   SM8350_SLAVE_AHB2PHY_NORTH,
-		   SM8350_SLAVE_AOSS,
-		   SM8350_SLAVE_APPSS,
-		   SM8350_SLAVE_CAMERA_CFG,
-		   SM8350_SLAVE_CLK_CTL,
-		   SM8350_SLAVE_CDSP_CFG,
-		   SM8350_SLAVE_RBCPR_CX_CFG,
-		   SM8350_SLAVE_RBCPR_MMCX_CFG,
-		   SM8350_SLAVE_RBCPR_MX_CFG,
-		   SM8350_SLAVE_CRYPTO_0_CFG,
-		   SM8350_SLAVE_CX_RDPM,
-		   SM8350_SLAVE_DCC_CFG,
-		   SM8350_SLAVE_DISPLAY_CFG,
-		   SM8350_SLAVE_GFX3D_CFG,
-		   SM8350_SLAVE_HWKM,
-		   SM8350_SLAVE_IMEM_CFG,
-		   SM8350_SLAVE_IPA_CFG,
-		   SM8350_SLAVE_IPC_ROUTER_CFG,
-		   SM8350_SLAVE_LPASS,
-		   SM8350_SLAVE_CNOC_MSS,
-		   SM8350_SLAVE_MX_RDPM,
-		   SM8350_SLAVE_PCIE_0_CFG,
-		   SM8350_SLAVE_PCIE_1_CFG,
-		   SM8350_SLAVE_PDM,
-		   SM8350_SLAVE_PIMEM_CFG,
-		   SM8350_SLAVE_PKA_WRAPPER_CFG,
-		   SM8350_SLAVE_PMU_WRAPPER_CFG,
-		   SM8350_SLAVE_QDSS_CFG,
-		   SM8350_SLAVE_QSPI_0,
-		   SM8350_SLAVE_QUP_0,
-		   SM8350_SLAVE_QUP_1,
-		   SM8350_SLAVE_QUP_2,
-		   SM8350_SLAVE_SDCC_2,
-		   SM8350_SLAVE_SDCC_4,
-		   SM8350_SLAVE_SECURITY,
-		   SM8350_SLAVE_SPSS_CFG,
-		   SM8350_SLAVE_TCSR,
-		   SM8350_SLAVE_TLMM,
-		   SM8350_SLAVE_UFS_CARD_CFG,
-		   SM8350_SLAVE_UFS_MEM_CFG,
-		   SM8350_SLAVE_USB3_0,
-		   SM8350_SLAVE_USB3_1,
-		   SM8350_SLAVE_VENUS_CFG,
-		   SM8350_SLAVE_VSENSE_CTRL_CFG,
-		   SM8350_SLAVE_A1NOC_CFG,
-		   SM8350_SLAVE_A2NOC_CFG,
-		   SM8350_SLAVE_DDRSS_CFG,
-		   SM8350_SLAVE_CNOC_MNOC_CFG,
-		   SM8350_SLAVE_SNOC_CFG,
-		   SM8350_SLAVE_BOOT_IMEM,
-		   SM8350_SLAVE_IMEM,
-		   SM8350_SLAVE_PIMEM,
-		   SM8350_SLAVE_SERVICE_CNOC,
-		   SM8350_SLAVE_QDSS_STM,
-		   SM8350_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_ahb2phy0,
+			&qhs_ahb2phy1,
+			&qhs_aoss,
+			&qhs_apss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute_cfg,
+			&qhs_cpr_cx,
+			&qhs_cpr_mmcx,
+			&qhs_cpr_mx,
+			&qhs_crypto0_cfg,
+			&qhs_cx_rdpm,
+			&qhs_dcc_cfg,
+			&qhs_display_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_hwkm,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_ipc_router,
+			&qhs_lpass_cfg,
+			&qhs_mss_cfg,
+			&qhs_mx_rdpm,
+			&qhs_pcie0_cfg,
+			&qhs_pcie1_cfg,
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
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qns_a1_noc_cfg,
+			&qns_a2_noc_cfg,
+			&qns_ddrss_cfg,
+			&qns_mnoc_cfg,
+			&qns_snoc_cfg,
+			&qxs_boot_imem,
+			&qxs_imem,
+			&qxs_pimem,
+			&srvc_cnoc,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
-	.id = SM8350_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_LLCC_CFG,
-		   SM8350_SLAVE_GEM_NOC_CFG
-	},
+	.link_nodes = { &qhs_llcc,
+			&qns_gemnoc, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SM8350_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SM8350_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SM8350_MASTER_APPSS_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC,
-		   SM8350_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM8350_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SM8350_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 5,
-	.links = { SM8350_SLAVE_MSS_PROC_MS_MPU_CFG,
-		   SM8350_SLAVE_MCDMA_MS_MPU_CFG,
-		   SM8350_SLAVE_SERVICE_GEM_NOC_1,
-		   SM8350_SLAVE_SERVICE_GEM_NOC_2,
-		   SM8350_SLAVE_SERVICE_GEM_NOC
-	},
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg,
+			&qhs_modem_ms_mpu_cfg,
+			&srvc_even_gemnoc,
+			&srvc_odd_gemnoc,
+			&srvc_sys_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8350_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8350_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8350_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8350_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM8350_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8350_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8350_SLAVE_GEM_NOC_CNOC,
-		   SM8350_SLAVE_LLCC,
-		   SM8350_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_gem_noc_cnoc,
+			&qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SM8350_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 6,
-	.links = { SM8350_SLAVE_LPASS_CORE_CFG,
-		   SM8350_SLAVE_LPASS_LPI_CFG,
-		   SM8350_SLAVE_LPASS_MPU_CFG,
-		   SM8350_SLAVE_LPASS_TOP_CFG,
-		   SM8350_SLAVE_SERVICES_LPASS_AML_NOC,
-		   SM8350_SLAVE_SERVICE_LPASS_AG_NOC
-	},
+	.link_nodes = { &qhs_lpass_core,
+			&qhs_lpass_lpi,
+			&qhs_lpass_mpu,
+			&qhs_lpass_top,
+			&srvc_niu_aml_noc,
+			&srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8350_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SM8350_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SM8350_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SM8350_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_cfg = {
 	.name = "qnm_mnoc_cfg",
-	.id = SM8350_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SM8350_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
-	.id = SM8350_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM8350_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM8350_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SM8350_MASTER_MDP1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SM8350_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SM8350_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SM8350_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8350_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM8350_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SM8350_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SM8350_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8350_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8350_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM8350_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8350_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8350_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM8350_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM8350_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SM8350_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8350_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM8350_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8350_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8350_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_cfg = {
 	.name = "qhs_compute_cfg",
-	.id = SM8350_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM8350_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SM8350_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM8350_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8350_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SM8350_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SM8350_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8350_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8350_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
-	.id = SM8350_SLAVE_HWKM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8350_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8350_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SM8350_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SM8350_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8350_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SM8350_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SM8350_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SM8350_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SM8350_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM8350_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM8350_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pka_wrapper_cfg = {
 	.name = "qhs_pka_wrapper_cfg",
-	.id = SM8350_SLAVE_PKA_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
 	.name = "qhs_pmu_wrapper_cfg",
-	.id = SM8350_SLAVE_PMU_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8350_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8350_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SM8350_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM8350_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SM8350_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8350_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8350_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SM8350_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SM8350_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8350_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SM8350_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SM8350_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8350_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8350_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SM8350_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8350_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8350_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a1_noc_cfg = {
 	.name = "qns_a1_noc_cfg",
-	.id = SM8350_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2_noc_cfg = {
 	.name = "qns_a2_noc_cfg",
-	.id = SM8350_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SM8350_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mnoc_cfg = {
 	.name = "qns_mnoc_cfg",
-	.id = SM8350_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SM8350_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = SM8350_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8350_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM8350_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM8350_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SM8350_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SM8350_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8350_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8350_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM8350_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SM8350_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SM8350_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_modem_ms_mpu_cfg = {
 	.name = "qhs_modem_ms_mpu_cfg",
-	.id = SM8350_SLAVE_MCDMA_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SM8350_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8350_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SM8350_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SM8350_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SM8350_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SM8350_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SM8350_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SM8350_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SM8350_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SM8350_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SM8350_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SM8350_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8350_SLAVE_EBI1,
 	.channels = 4,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8350_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM8350_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8350_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SM8350_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8350_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SM8350_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM8350_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8350_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8350_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8350_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM8350_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1484,6 +1484,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1515,6 +1516,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1594,6 +1596,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1610,6 +1613,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1646,6 +1650,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1666,6 +1671,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1683,6 +1689,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1713,6 +1720,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1732,6 +1740,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1757,6 +1766,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8350_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8350.h b/drivers/interconnect/qcom/sm8350.h
deleted file mode 100644
index 074c6131ab3674376aa4ebfb79d62a2f655df338..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm8350.h
+++ /dev/null
@@ -1,158 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm SM8350 interconnect IDs
- *
- * Copyright (c) 2021, Linaro Limited
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8350_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM8350_H
-
-#define SM8350_MASTER_GPU_TCU				0
-#define SM8350_MASTER_SYS_TCU				1
-#define SM8350_MASTER_APPSS_PROC			2
-#define SM8350_MASTER_LLCC				3
-#define SM8350_MASTER_CNOC_LPASS_AG_NOC			4
-#define SM8350_MASTER_CDSP_NOC_CFG			5
-#define SM8350_MASTER_QDSS_BAM				6
-#define SM8350_MASTER_QSPI_0				7
-#define SM8350_MASTER_QUP_0				8
-#define SM8350_MASTER_QUP_1				9
-#define SM8350_MASTER_QUP_2				10
-#define SM8350_MASTER_A1NOC_CFG				11
-#define SM8350_MASTER_A2NOC_CFG				12
-#define SM8350_MASTER_A1NOC_SNOC			13
-#define SM8350_MASTER_A2NOC_SNOC			14
-#define SM8350_MASTER_CAMNOC_HF				15
-#define SM8350_MASTER_CAMNOC_ICP			16
-#define SM8350_MASTER_CAMNOC_SF				17
-#define SM8350_MASTER_COMPUTE_NOC			18
-#define SM8350_MASTER_CNOC_DC_NOC			19
-#define SM8350_MASTER_GEM_NOC_CFG			20
-#define SM8350_MASTER_GEM_NOC_CNOC			21
-#define SM8350_MASTER_GEM_NOC_PCIE_SNOC			22
-#define SM8350_MASTER_GFX3D				23
-#define SM8350_MASTER_CNOC_MNOC_CFG			24
-#define SM8350_MASTER_MNOC_HF_MEM_NOC			25
-#define SM8350_MASTER_MNOC_SF_MEM_NOC			26
-#define SM8350_MASTER_ANOC_PCIE_GEM_NOC			27
-#define SM8350_MASTER_SNOC_CFG				28
-#define SM8350_MASTER_SNOC_GC_MEM_NOC			29
-#define SM8350_MASTER_SNOC_SF_MEM_NOC			30
-#define SM8350_MASTER_VIDEO_P0				31
-#define SM8350_MASTER_VIDEO_P1				32
-#define SM8350_MASTER_VIDEO_PROC			33
-#define SM8350_MASTER_QUP_CORE_0			34
-#define SM8350_MASTER_QUP_CORE_1			35
-#define SM8350_MASTER_QUP_CORE_2			36
-#define SM8350_MASTER_CRYPTO				37
-#define SM8350_MASTER_IPA				38
-#define SM8350_MASTER_MDP0				39
-#define SM8350_MASTER_MDP1				40
-#define SM8350_MASTER_CDSP_PROC				41
-#define SM8350_MASTER_PIMEM				42
-#define SM8350_MASTER_ROTATOR				43
-#define SM8350_MASTER_GIC				44
-#define SM8350_MASTER_PCIE_0				45
-#define SM8350_MASTER_PCIE_1				46
-#define SM8350_MASTER_QDSS_DAP				47
-#define SM8350_MASTER_QDSS_ETR				48
-#define SM8350_MASTER_SDCC_2				49
-#define SM8350_MASTER_SDCC_4				50
-#define SM8350_MASTER_UFS_CARD				51
-#define SM8350_MASTER_UFS_MEM				52
-#define SM8350_MASTER_USB3_0				53
-#define SM8350_MASTER_USB3_1				54
-#define SM8350_SLAVE_EBI1				55
-#define SM8350_SLAVE_AHB2PHY_SOUTH			56
-#define SM8350_SLAVE_AHB2PHY_NORTH			57
-#define SM8350_SLAVE_AOSS				58
-#define SM8350_SLAVE_APPSS				59
-#define SM8350_SLAVE_CAMERA_CFG				60
-#define SM8350_SLAVE_CLK_CTL				61
-#define SM8350_SLAVE_CDSP_CFG				62
-#define SM8350_SLAVE_RBCPR_CX_CFG			63
-#define SM8350_SLAVE_RBCPR_MMCX_CFG			64
-#define SM8350_SLAVE_RBCPR_MX_CFG			65
-#define SM8350_SLAVE_CRYPTO_0_CFG			66
-#define SM8350_SLAVE_CX_RDPM				67
-#define SM8350_SLAVE_DCC_CFG				68
-#define SM8350_SLAVE_DISPLAY_CFG			69
-#define SM8350_SLAVE_GFX3D_CFG				70
-#define SM8350_SLAVE_HWKM				71
-#define SM8350_SLAVE_IMEM_CFG				72
-#define SM8350_SLAVE_IPA_CFG				73
-#define SM8350_SLAVE_IPC_ROUTER_CFG			74
-#define SM8350_SLAVE_LLCC_CFG				75
-#define SM8350_SLAVE_LPASS				76
-#define SM8350_SLAVE_LPASS_CORE_CFG			77
-#define SM8350_SLAVE_LPASS_LPI_CFG			78
-#define SM8350_SLAVE_LPASS_MPU_CFG			79
-#define SM8350_SLAVE_LPASS_TOP_CFG			80
-#define SM8350_SLAVE_MSS_PROC_MS_MPU_CFG		81
-#define SM8350_SLAVE_MCDMA_MS_MPU_CFG			82
-#define SM8350_SLAVE_CNOC_MSS				83
-#define SM8350_SLAVE_MX_RDPM				84
-#define SM8350_SLAVE_PCIE_0_CFG				85
-#define SM8350_SLAVE_PCIE_1_CFG				86
-#define SM8350_SLAVE_PDM				87
-#define SM8350_SLAVE_PIMEM_CFG				88
-#define SM8350_SLAVE_PKA_WRAPPER_CFG			89
-#define SM8350_SLAVE_PMU_WRAPPER_CFG			90
-#define SM8350_SLAVE_QDSS_CFG				91
-#define SM8350_SLAVE_QSPI_0				92
-#define SM8350_SLAVE_QUP_0				93
-#define SM8350_SLAVE_QUP_1				94
-#define SM8350_SLAVE_QUP_2				95
-#define SM8350_SLAVE_SDCC_2				96
-#define SM8350_SLAVE_SDCC_4				97
-#define SM8350_SLAVE_SECURITY				98
-#define SM8350_SLAVE_SPSS_CFG				99
-#define SM8350_SLAVE_TCSR				100
-#define SM8350_SLAVE_TLMM				101
-#define SM8350_SLAVE_UFS_CARD_CFG			102
-#define SM8350_SLAVE_UFS_MEM_CFG			103
-#define SM8350_SLAVE_USB3_0				104
-#define SM8350_SLAVE_USB3_1				105
-#define SM8350_SLAVE_VENUS_CFG				106
-#define SM8350_SLAVE_VSENSE_CTRL_CFG			107
-#define SM8350_SLAVE_A1NOC_CFG				108
-#define SM8350_SLAVE_A1NOC_SNOC				109
-#define SM8350_SLAVE_A2NOC_CFG				110
-#define SM8350_SLAVE_A2NOC_SNOC				111
-#define SM8350_SLAVE_DDRSS_CFG				112
-#define SM8350_SLAVE_GEM_NOC_CNOC			113
-#define SM8350_SLAVE_GEM_NOC_CFG			114
-#define SM8350_SLAVE_SNOC_GEM_NOC_GC			115
-#define SM8350_SLAVE_SNOC_GEM_NOC_SF			116
-#define SM8350_SLAVE_LLCC				117
-#define SM8350_SLAVE_MNOC_HF_MEM_NOC			118
-#define SM8350_SLAVE_MNOC_SF_MEM_NOC			119
-#define SM8350_SLAVE_CNOC_MNOC_CFG			120
-#define SM8350_SLAVE_CDSP_MEM_NOC			121
-#define SM8350_SLAVE_MEM_NOC_PCIE_SNOC			122
-#define SM8350_SLAVE_ANOC_PCIE_GEM_NOC			123
-#define SM8350_SLAVE_SNOC_CFG				124
-#define SM8350_SLAVE_QUP_CORE_0				125
-#define SM8350_SLAVE_QUP_CORE_1				126
-#define SM8350_SLAVE_QUP_CORE_2				127
-#define SM8350_SLAVE_BOOT_IMEM				128
-#define SM8350_SLAVE_IMEM				129
-#define SM8350_SLAVE_PIMEM				130
-#define SM8350_SLAVE_SERVICE_NSP_NOC			131
-#define SM8350_SLAVE_SERVICE_A1NOC			132
-#define SM8350_SLAVE_SERVICE_A2NOC			133
-#define SM8350_SLAVE_SERVICE_CNOC			134
-#define SM8350_SLAVE_SERVICE_GEM_NOC_1			135
-#define SM8350_SLAVE_SERVICE_MNOC			136
-#define SM8350_SLAVE_SERVICES_LPASS_AML_NOC		137
-#define SM8350_SLAVE_SERVICE_LPASS_AG_NOC		138
-#define SM8350_SLAVE_SERVICE_GEM_NOC_2			139
-#define SM8350_SLAVE_SERVICE_SNOC			140
-#define SM8350_SLAVE_SERVICE_GEM_NOC			141
-#define SM8350_SLAVE_PCIE_0				142
-#define SM8350_SLAVE_PCIE_1				143
-#define SM8350_SLAVE_QDSS_STM				144
-#define SM8350_SLAVE_TCU				145
-
-#endif

-- 
2.39.5


