Return-Path: <linux-pm+bounces-30147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A070BAF988B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAA3BB131
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579830AAC8;
	Fri,  4 Jul 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGcGpseA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F12E5B02
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646938; cv=none; b=WlAjzKGIBa8MA4WtaZcgFxtZZTexm1M6B3hYZ3Unb3ecP0CTErzrByh9O12F8kU5j0gbxbtzkAeqP/shh7RlP4XluOKFdhELMcsLR5H2JYuxhyHzsUfaipL03KpVd0BCedHEh+cH/ahtNvgtTapmkX23qPGlkgptPVmrUkVcjlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646938; c=relaxed/simple;
	bh=xEL5M+IyeK5AUNfzjYDvHQNE0PXdT1iFFcnbPBl5Y9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+RoI9Aj4u/ozPBRLnWG3WbcjwdI7pW/gxiwoRy/mLiPKbi8pc1xB9L01s2i01CrJmFNWQfmO1vCgSXrx5+T5ap2E3q1n7v/3I8nc+mkUrax3K8SyBiIlLy16LvpEJ4gcIIYO05q0v+l2bxFOFHknx4qiAYwL7Dp1jUnWtk+F8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGcGpseA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564924va006969
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RwNpK1GKEqeYtEd5dQF44akDhiAEiviM+Qu6JMqHO40=; b=IGcGpseADJyvRfgO
	sN21Nv4jS/JvuD9WQ96u+J/MURMN08Ce6quUWpD0+CpWCZ8qsSJqZL0Z1Ux285+f
	B90nYNZ+3zb22NJ8v5P/b3LgrZhK+56XSLcOOSD7AIE7nqnEnFgweOokMT8m99SI
	TGzwZ0mHmwlmvoCMZFA+S51JtDAf66EGMAoPrVqCdvXrudD6aWZ4IOM7UsKWZyz7
	DlxXkaG48MppLqVtsddgqov2LBcLb0c0o0560OgD5ueR9Px29IiFkyugdncqjgZe
	3xSpcVDfChktgHWBxOixfWMQCjoyTKl92k6VD7j3crEyGgQjwtXmeKfYQTXN2eC5
	cKi/2Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qmmag4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d09bc05b77so171944985a.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646932; x=1752251732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwNpK1GKEqeYtEd5dQF44akDhiAEiviM+Qu6JMqHO40=;
        b=pX0bPQ0bTAo00iw7z00JzoffljmzhayWf/eXKMVHTGREeWcyKwmFINrG7cyGzTVuUq
         LQBSWqf7G4Rq4WtA4fyNVOiV6wtJvo6FYFDXWzDeVWvOqAsegaPsltHflygHwOyONBQ1
         chuhbMP21r8Xcr0ry2u9LiFHb047jEAX1EjVz+3wB3ubSUahN7a8/HSCCSm3kWdN2c19
         6dLAi7mP4Fw4gsyrkyzJUN17FPQbtw0tkK8ENlpCFVRgIAaJJ3wPlbUtsTRyhmVGdxLY
         rIOSqHhENpvBp4W87SVReyRhMZzJiIKYXhdvU2kQsEfuamEF7GX0JK5LTNfC4h0D2fUt
         w27A==
X-Forwarded-Encrypted: i=1; AJvYcCUjdf+vd+zou53QdWlF1gPMsh/nc+SNCUwXI317EuKr9PYsbHEgFqPDDdtuLLBLQ54q09vkDlSkHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOHlg0bNwj2wGd/KJaJHVs3pf9D3l+SU99Lps7rMP7jxSrWcQ
	Zs+zzzamdXqrd79VuXyKE39mhn/snzolwyuHaUH9X5XH0ZZaN+woFjkaCk1IkXrGVvLyMVmhp2n
	mSzik77jW8xFfd6GCuM/6uD7Ptb990fpQZDDDv9ZFRWLG8A8hAGOCG3rC8mBOcA==
X-Gm-Gg: ASbGncsDwwo9hX4PkCIScu5CiNKncg4BOJfKWEaQDei7P8hmB4tJFqMpr5NKUR6qq/c
	QzoCGHNiL/doo7MBVlGbNLpx55OoPFTRRsgUWl6mTGcb8r/AvQ2/lHMfxroGQ5Fz1UmAy+GSL98
	JiR0fw111W9qLuw0LA4KmcbliFHXhBlekjMd4GG5HjB8jHjU9lTR6ivAwSK09hkffBvGQxDcYFb
	m5l1obxKHV4LKN6WDgYsdPoFxSIKCfj6sGWDnugnIhAC+xtIndgojo2ek2UV+6bXMrTvyNKbGkZ
	+oa83/gBUOxJqz0a+dn3bOVv31WSrCs2tdz7oYiSzZf4McuKu3e6hnembRSvsCJMDjHe8JAQbrn
	hP7ceatNY6MhaMQRmA66stY4KWoC5vYlBYVk=
X-Received: by 2002:a05:620a:4412:b0:7d3:b64d:8102 with SMTP id af79cd13be357-7d5df180de2mr354498885a.52.1751646931457;
        Fri, 04 Jul 2025 09:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSLUfCQAQARqK1beNwEN9cbSon0BczTkYrSzkGcJ0R0Qdh+b1P+Tv8FC+FzwMAXbBT75vW2A==
X-Received: by 2002:a05:620a:4412:b0:7d3:b64d:8102 with SMTP id af79cd13be357-7d5df180de2mr354491685a.52.1751646930635;
        Fri, 04 Jul 2025 09:35:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:17 +0300
Subject: [PATCH v2 05/28] interconnect: qcom: sc7280: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-5-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=59313;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xEL5M+IyeK5AUNfzjYDvHQNE0PXdT1iFFcnbPBl5Y9E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALFXxeK7OUBadrFbKh1Tv5la/Wh3jEqd6OMy
 TuGnZJKHj+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxQAKCRCLPIo+Aiko
 1b+hB/sHHHMpPhgK1P0VI16hamFkdvxeLZ9aWLW59euaUiotZ8td2xeJ3UAvCZ14uhK/f+60arU
 piRr+4uPNQlAWV0i4lGBNP2Nx+4jJeUXMpUM95UV70xdD6rHgfaGRDBB9xuAlhAexfaoYDG464R
 5Fsrej4kQemntc46tlrcvFMMkroTQ5bHNZ410cpLY6hWfpyLOV6ywfyuWl1nbr1YFdk8HczxNqx
 WpBndI3zr5tNRHIK5h7RISQT6xdyiGb/KYrmd9ZEs84etWm+vpIUOMvLuzvma4OcHJZ49Wg7cbN
 RUs+jaJ/197l/hx0xvgUydd+lQBxscFrUVNm+bZj2VWFsylp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=686802d5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=hjLe2Y_6_fibv8VcIgMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: OIzIQOjXcCTfsQ2vZeAYIwN_tY3yEpLK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXxHfbcaMcsXKf
 DQ/so/MMKj62ZzVqegu0g1T2cCMAoWHFCZeIoshrw4aKNYf0Kq2M2/QXTLQFKsaLzMQCAumocuW
 SHMneSTZ/MTO6o4aNeVgRKGwSU+8UJiVDNziUmIKfN6Otceo98Sdryj3ck6sh3DxdnsVhW97iqh
 RSHWy87eqmhuiXfECXqhE0rU25SMpZI60l6hJF/YhqCje0YT9NqldokqzaPQQWdtNKs9sDVUf8m
 cOofVAlfJznT7Mode05tSYG3IZ9Kty5hTfobXUgvdfIr5g2YAA1aiLc0I3JrUdZ+szK61Ii/xJ1
 sV5wdddUy8dHbTzcS0FnKI3fYtkigpyMlhT8TZ5tuDMSn0gy3CYobZ9n6iNZOMqVILb5zS4Vpaw
 uczBJDWVSSO0cUM4R3NUAgz9CYQ9vItLqP+F+2OY8yQehbkHPDwvPztsWmePTp7qQZgybzT+
X-Proofpoint-GUID: OIzIQOjXcCTfsQ2vZeAYIwN_tY3yEpLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sc7280.c | 771 +++++++++++++++++--------------------
 drivers/interconnect/qcom/sc7280.h | 154 --------
 2 files changed, 354 insertions(+), 571 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 54e4ce9009bd498a840832e3f63dd9abfb86f837..c39e79d82b482ae3e35b292fe1a2d4cfc911d969 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -15,11 +15,152 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sc7280.h"
+
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qnm_a1noc_cfg;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qnm_a2noc_cfg;
+static struct qcom_icc_node qnm_cnoc_datapath;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qnm_cnoc3_cnoc2;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qnm_cnoc2_cnoc3;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
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
+static struct qcom_icc_node qnm_mnoc_cfg;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video_cpu;
+static struct qcom_icc_node qxm_camnoc_hf;
+static struct qcom_icc_node qxm_camnoc_icp;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
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
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
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
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb2;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_a1_noc_cfg;
+static struct qcom_icc_node qns_a2_noc_cfg;
+static struct qcom_icc_node qns_cnoc2_cnoc3;
+static struct qcom_icc_node qns_mnoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc3_cnoc2;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qxs_boot_imem;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
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
-	.id = SC7280_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -28,13 +169,11 @@ static struct qcom_icc_node qhm_qspi = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SC7280_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -43,13 +182,11 @@ static struct qcom_icc_node qhm_qup0 = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SC7280_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -58,22 +195,18 @@ static struct qcom_icc_node qhm_qup1 = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a1noc_cfg = {
 	.name = "qnm_a1noc_cfg",
-	.id = SC7280_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SC7280_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -82,13 +215,11 @@ static struct qcom_icc_node xm_sdc1 = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SC7280_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -97,13 +228,11 @@ static struct qcom_icc_node xm_sdc2 = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SC7280_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -112,13 +241,11 @@ static struct qcom_icc_node xm_sdc4 = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SC7280_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -127,22 +254,18 @@ static struct qcom_icc_node xm_ufs_mem = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb2 = {
 	.name = "xm_usb2",
-	.id = SC7280_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SC7280_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -151,13 +274,11 @@ static struct qcom_icc_node xm_usb3_0 = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SC7280_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -166,22 +287,18 @@ static struct qcom_icc_node qhm_qdss_bam = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_a2noc_cfg = {
 	.name = "qnm_a2noc_cfg",
-	.id = SC7280_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
-	.id = SC7280_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -190,13 +307,11 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SC7280_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -205,13 +320,11 @@ static struct qcom_icc_node qxm_crypto = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SC7280_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -220,31 +333,25 @@ static struct qcom_icc_node qxm_ipa = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SC7280_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SC7280_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SC7280_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -253,136 +360,118 @@ static struct qcom_icc_node xm_qdss_etr = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SC7280_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SC7280_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc3_cnoc2 = {
 	.name = "qnm_cnoc3_cnoc2",
-	.id = SC7280_MASTER_CNOC3_CNOC2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 44,
-	.links = { SC7280_SLAVE_AHB2PHY_SOUTH, SC7280_SLAVE_AHB2PHY_NORTH,
-		   SC7280_SLAVE_CAMERA_CFG, SC7280_SLAVE_CLK_CTL,
-		   SC7280_SLAVE_CDSP_CFG, SC7280_SLAVE_RBCPR_CX_CFG,
-		   SC7280_SLAVE_RBCPR_MX_CFG, SC7280_SLAVE_CRYPTO_0_CFG,
-		   SC7280_SLAVE_CX_RDPM, SC7280_SLAVE_DCC_CFG,
-		   SC7280_SLAVE_DISPLAY_CFG, SC7280_SLAVE_GFX3D_CFG,
-		   SC7280_SLAVE_HWKM, SC7280_SLAVE_IMEM_CFG,
-		   SC7280_SLAVE_IPA_CFG, SC7280_SLAVE_IPC_ROUTER_CFG,
-		   SC7280_SLAVE_LPASS, SC7280_SLAVE_CNOC_MSS,
-		   SC7280_SLAVE_MX_RDPM, SC7280_SLAVE_PCIE_0_CFG,
-		   SC7280_SLAVE_PCIE_1_CFG, SC7280_SLAVE_PDM,
-		   SC7280_SLAVE_PIMEM_CFG, SC7280_SLAVE_PKA_WRAPPER_CFG,
-		   SC7280_SLAVE_PMU_WRAPPER_CFG, SC7280_SLAVE_QDSS_CFG,
-		   SC7280_SLAVE_QSPI_0, SC7280_SLAVE_QUP_0,
-		   SC7280_SLAVE_QUP_1, SC7280_SLAVE_SDCC_1,
-		   SC7280_SLAVE_SDCC_2, SC7280_SLAVE_SDCC_4,
-		   SC7280_SLAVE_SECURITY, SC7280_SLAVE_TCSR,
-		   SC7280_SLAVE_TLMM, SC7280_SLAVE_UFS_MEM_CFG,
-		   SC7280_SLAVE_USB2, SC7280_SLAVE_USB3_0,
-		   SC7280_SLAVE_VENUS_CFG, SC7280_SLAVE_VSENSE_CTRL_CFG,
-		   SC7280_SLAVE_A1NOC_CFG, SC7280_SLAVE_A2NOC_CFG,
-		   SC7280_SLAVE_CNOC_MNOC_CFG, SC7280_SLAVE_SNOC_CFG },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+		   &qhs_camera_cfg, &qhs_clk_ctl,
+		   &qhs_compute_cfg, &qhs_cpr_cx,
+		   &qhs_cpr_mx, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_dcc_cfg,
+		   &qhs_display_cfg, &qhs_gpuss_cfg,
+		   &qhs_hwkm, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_lpass_cfg, &qhs_mss_cfg,
+		   &qhs_mx_rdpm, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_pdm,
+		   &qhs_pimem_cfg, &qhs_pka_wrapper_cfg,
+		   &qhs_pmu_wrapper_cfg, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_qup0,
+		   &qhs_qup1, &qhs_sdc1,
+		   &qhs_sdc2, &qhs_sdc4,
+		   &qhs_security, &qhs_tcsr,
+		   &qhs_tlmm, &qhs_ufs_mem_cfg,
+		   &qhs_usb2, &qhs_usb3_0,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qns_a1_noc_cfg, &qns_a2_noc_cfg,
+		   &qns_mnoc_cfg, &qns_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SC7280_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 45,
-	.links = { SC7280_SLAVE_AHB2PHY_SOUTH, SC7280_SLAVE_AHB2PHY_NORTH,
-		   SC7280_SLAVE_CAMERA_CFG, SC7280_SLAVE_CLK_CTL,
-		   SC7280_SLAVE_CDSP_CFG, SC7280_SLAVE_RBCPR_CX_CFG,
-		   SC7280_SLAVE_RBCPR_MX_CFG, SC7280_SLAVE_CRYPTO_0_CFG,
-		   SC7280_SLAVE_CX_RDPM, SC7280_SLAVE_DCC_CFG,
-		   SC7280_SLAVE_DISPLAY_CFG, SC7280_SLAVE_GFX3D_CFG,
-		   SC7280_SLAVE_HWKM, SC7280_SLAVE_IMEM_CFG,
-		   SC7280_SLAVE_IPA_CFG, SC7280_SLAVE_IPC_ROUTER_CFG,
-		   SC7280_SLAVE_LPASS, SC7280_SLAVE_CNOC_MSS,
-		   SC7280_SLAVE_MX_RDPM, SC7280_SLAVE_PCIE_0_CFG,
-		   SC7280_SLAVE_PCIE_1_CFG, SC7280_SLAVE_PDM,
-		   SC7280_SLAVE_PIMEM_CFG, SC7280_SLAVE_PKA_WRAPPER_CFG,
-		   SC7280_SLAVE_PMU_WRAPPER_CFG, SC7280_SLAVE_QDSS_CFG,
-		   SC7280_SLAVE_QSPI_0, SC7280_SLAVE_QUP_0,
-		   SC7280_SLAVE_QUP_1, SC7280_SLAVE_SDCC_1,
-		   SC7280_SLAVE_SDCC_2, SC7280_SLAVE_SDCC_4,
-		   SC7280_SLAVE_SECURITY, SC7280_SLAVE_TCSR,
-		   SC7280_SLAVE_TLMM, SC7280_SLAVE_UFS_MEM_CFG,
-		   SC7280_SLAVE_USB2, SC7280_SLAVE_USB3_0,
-		   SC7280_SLAVE_VENUS_CFG, SC7280_SLAVE_VSENSE_CTRL_CFG,
-		   SC7280_SLAVE_A1NOC_CFG, SC7280_SLAVE_A2NOC_CFG,
-		   SC7280_SLAVE_CNOC2_CNOC3, SC7280_SLAVE_CNOC_MNOC_CFG,
-		   SC7280_SLAVE_SNOC_CFG },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+		   &qhs_camera_cfg, &qhs_clk_ctl,
+		   &qhs_compute_cfg, &qhs_cpr_cx,
+		   &qhs_cpr_mx, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_dcc_cfg,
+		   &qhs_display_cfg, &qhs_gpuss_cfg,
+		   &qhs_hwkm, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_lpass_cfg, &qhs_mss_cfg,
+		   &qhs_mx_rdpm, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_pdm,
+		   &qhs_pimem_cfg, &qhs_pka_wrapper_cfg,
+		   &qhs_pmu_wrapper_cfg, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_qup0,
+		   &qhs_qup1, &qhs_sdc1,
+		   &qhs_sdc2, &qhs_sdc4,
+		   &qhs_security, &qhs_tcsr,
+		   &qhs_tlmm, &qhs_ufs_mem_cfg,
+		   &qhs_usb2, &qhs_usb3_0,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qns_a1_noc_cfg, &qns_a2_noc_cfg,
+		   &qns_cnoc2_cnoc3, &qns_mnoc_cfg,
+		   &qns_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc2_cnoc3 = {
 	.name = "qnm_cnoc2_cnoc3",
-	.id = SC7280_MASTER_CNOC2_CNOC3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 9,
-	.links = { SC7280_SLAVE_AOSS, SC7280_SLAVE_APPSS,
-		   SC7280_SLAVE_CNOC_A2NOC, SC7280_SLAVE_DDRSS_CFG,
-		   SC7280_SLAVE_BOOT_IMEM, SC7280_SLAVE_IMEM,
-		   SC7280_SLAVE_PIMEM, SC7280_SLAVE_QDSS_STM,
-		   SC7280_SLAVE_TCU },
+	.link_nodes = { &qhs_aoss, &qhs_apss,
+		   &qns_cnoc_a2noc, &qns_ddrss_cfg,
+		   &qxs_boot_imem, &qxs_imem,
+		   &qxs_pimem, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SC7280_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 9,
-	.links = { SC7280_SLAVE_AOSS, SC7280_SLAVE_APPSS,
-		   SC7280_SLAVE_CNOC3_CNOC2, SC7280_SLAVE_DDRSS_CFG,
-		   SC7280_SLAVE_BOOT_IMEM, SC7280_SLAVE_IMEM,
-		   SC7280_SLAVE_PIMEM, SC7280_SLAVE_QDSS_STM,
-		   SC7280_SLAVE_TCU },
+	.link_nodes = { &qhs_aoss, &qhs_apss,
+		   &qns_cnoc3_cnoc2, &qns_ddrss_cfg,
+		   &qxs_boot_imem, &qxs_imem,
+		   &qxs_pimem, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SC7280_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SC7280_SLAVE_PCIE_0, SC7280_SLAVE_PCIE_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
-	.id = SC7280_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SC7280_SLAVE_LLCC_CFG, SC7280_SLAVE_GEM_NOC_CFG },
+	.link_nodes = { &qhs_llcc, &qns_gemnoc, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SC7280_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -391,13 +480,11 @@ static struct qcom_icc_node alm_gpu_tcu = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SC7280_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -406,23 +493,19 @@ static struct qcom_icc_node alm_sys_tcu = {
 		.prio = 6,
 		.urg_fwd = 0,
 	},
-	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SC7280_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
-		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SC7280_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -431,24 +514,20 @@ static struct qcom_icc_node qnm_cmpnoc = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SC7280_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 5,
-	.links = { SC7280_SLAVE_MSS_PROC_MS_MPU_CFG, SC7280_SLAVE_MCDMA_MS_MPU_CFG,
-		   SC7280_SLAVE_SERVICE_GEM_NOC_1, SC7280_SLAVE_SERVICE_GEM_NOC_2,
-		   SC7280_SLAVE_SERVICE_GEM_NOC },
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg, &qhs_modem_ms_mpu_cfg,
+		   &srvc_even_gemnoc, &srvc_odd_gemnoc,
+		   &srvc_sys_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SC7280_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -457,13 +536,11 @@ static struct qcom_icc_node qnm_gpu = {
 		.prio = 0,
 		.urg_fwd = 0,
 	},
-	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SC7280_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -472,13 +549,11 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SC7280_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -487,22 +562,18 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SC7280_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SC7280_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -511,13 +582,11 @@ static struct qcom_icc_node qnm_snoc_gc = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SC7280_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -526,43 +595,35 @@ static struct qcom_icc_node qnm_snoc_sf = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 3,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
-		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SC7280_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 6,
-	.links = { SC7280_SLAVE_LPASS_CORE_CFG, SC7280_SLAVE_LPASS_LPI_CFG,
-		   SC7280_SLAVE_LPASS_MPU_CFG, SC7280_SLAVE_LPASS_TOP_CFG,
-		   SC7280_SLAVE_SERVICES_LPASS_AML_NOC, SC7280_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
+		   &qhs_lpass_mpu, &qhs_lpass_top,
+		   &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SC7280_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_cfg = {
 	.name = "qnm_mnoc_cfg",
-	.id = SC7280_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SC7280_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -571,13 +632,11 @@ static struct qcom_icc_node qnm_video0 = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cpu = {
 	.name = "qnm_video_cpu",
-	.id = SC7280_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -586,13 +645,11 @@ static struct qcom_icc_node qnm_video_cpu = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
-	.id = SC7280_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -601,13 +658,11 @@ static struct qcom_icc_node qxm_camnoc_hf = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
-	.id = SC7280_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -616,13 +671,11 @@ static struct qcom_icc_node qxm_camnoc_icp = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SC7280_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -631,13 +684,11 @@ static struct qcom_icc_node qxm_camnoc_sf = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SC7280_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -646,58 +697,46 @@ static struct qcom_icc_node qxm_mdp0 = {
 		.prio = 0,
 		.urg_fwd = 1,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SC7280_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SC7280_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SC7280_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SC7280_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SC7280_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SC7280_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -706,13 +745,11 @@ static struct qcom_icc_node qxm_pimem = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SC7280_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -721,742 +758,630 @@ static struct qcom_icc_node xm_gic = {
 		.prio = 2,
 		.urg_fwd = 0,
 	},
-	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SC7280_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SC7280_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SC7280_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SC7280_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SC7280_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SC7280_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SC7280_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SC7280_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SC7280_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SC7280_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SC7280_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_cfg = {
 	.name = "qhs_compute_cfg",
-	.id = SC7280_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CDSP_NOC_CFG },
+	.link_nodes = { &qhm_nsp_noc_config, NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SC7280_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SC7280_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SC7280_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SC7280_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SC7280_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SC7280_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SC7280_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
-	.id = SC7280_SLAVE_HWKM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SC7280_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SC7280_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SC7280_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SC7280_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SC7280_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SC7280_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SC7280_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SC7280_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SC7280_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SC7280_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pka_wrapper_cfg = {
 	.name = "qhs_pka_wrapper_cfg",
-	.id = SC7280_SLAVE_PKA_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
 	.name = "qhs_pmu_wrapper_cfg",
-	.id = SC7280_SLAVE_PMU_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SC7280_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SC7280_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SC7280_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SC7280_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SC7280_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SC7280_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SC7280_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SC7280_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SC7280_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SC7280_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SC7280_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb2 = {
 	.name = "qhs_usb2",
-	.id = SC7280_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SC7280_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SC7280_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SC7280_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a1_noc_cfg = {
 	.name = "qns_a1_noc_cfg",
-	.id = SC7280_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_A1NOC_CFG },
+	.link_nodes = { &qnm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_a2_noc_cfg = {
 	.name = "qns_a2_noc_cfg",
-	.id = SC7280_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_A2NOC_CFG },
+	.link_nodes = { &qnm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_cnoc2_cnoc3 = {
 	.name = "qns_cnoc2_cnoc3",
-	.id = SC7280_SLAVE_CNOC2_CNOC3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC2_CNOC3 },
+	.link_nodes = { &qnm_cnoc2_cnoc3, NULL },
 };
 
 static struct qcom_icc_node qns_mnoc_cfg = {
 	.name = "qns_mnoc_cfg",
-	.id = SC7280_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qnm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SC7280_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SC7280_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SC7280_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc3_cnoc2 = {
 	.name = "qns_cnoc3_cnoc2",
-	.id = SC7280_SLAVE_CNOC3_CNOC2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC3_CNOC2 },
+	.link_nodes = { &qnm_cnoc3_cnoc2, NULL },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SC7280_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc_datapath, NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SC7280_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qnm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = SC7280_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SC7280_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SC7280_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SC7280_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SC7280_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SC7280_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SC7280_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SC7280_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SC7280_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SC7280_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qnm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SC7280_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_modem_ms_mpu_cfg = {
 	.name = "qhs_modem_ms_mpu_cfg",
-	.id = SC7280_SLAVE_MCDMA_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SC7280_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SC7280_SLAVE_LLCC,
 	.channels = 2,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SC7280_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SC7280_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SC7280_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SC7280_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SC7280_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SC7280_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SC7280_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SC7280_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SC7280_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SC7280_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SC7280_SLAVE_EBI1,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SC7280_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC7280_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SC7280_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC7280_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SC7280_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SC7280_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SC7280_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SC7280_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SC7280_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SC7280_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SC7280_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SC7280_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SC7280_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1660,6 +1585,7 @@ static const struct regmap_config sc7280_aggre1_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
@@ -1692,6 +1618,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
@@ -1713,6 +1640,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1783,6 +1711,7 @@ static const struct regmap_config sc7280_cnoc2_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc2 = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_cnoc2_regmap_config,
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
@@ -1824,6 +1753,7 @@ static const struct regmap_config sc7280_cnoc3_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc3 = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_cnoc3_regmap_config,
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
@@ -1849,6 +1779,7 @@ static const struct regmap_config sc7280_dc_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_dc_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
@@ -1894,6 +1825,7 @@ static const struct regmap_config sc7280_gem_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_gem_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1923,6 +1855,7 @@ static const struct regmap_config sc7280_lpass_ag_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1949,6 +1882,7 @@ static const struct regmap_config sc7280_mc_virt_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_mc_virt = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_mc_virt_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
@@ -1985,6 +1919,7 @@ static const struct regmap_config sc7280_mmss_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_mmss_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -2013,6 +1948,7 @@ static const struct regmap_config sc7280_nsp_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_nsp_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_nsp_noc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -2047,6 +1983,7 @@ static const struct regmap_config sc7280_system_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_system_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
deleted file mode 100644
index 175e400305c513a5f0d08468da7f4c72eb1a04e6..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sc7280.h
+++ /dev/null
@@ -1,154 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SC7280 interconnect IDs
- *
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SC7280_H
-#define __DRIVERS_INTERCONNECT_QCOM_SC7280_H
-
-#define SC7280_MASTER_GPU_TCU			0
-#define SC7280_MASTER_SYS_TCU			1
-#define SC7280_MASTER_APPSS_PROC			2
-#define SC7280_MASTER_LLCC			3
-#define SC7280_MASTER_CNOC_LPASS_AG_NOC			4
-#define SC7280_MASTER_CDSP_NOC_CFG			5
-#define SC7280_MASTER_QDSS_BAM			6
-#define SC7280_MASTER_QSPI_0			7
-#define SC7280_MASTER_QUP_0			8
-#define SC7280_MASTER_QUP_1			9
-#define SC7280_MASTER_A1NOC_CFG			10
-#define SC7280_MASTER_A2NOC_CFG			11
-#define SC7280_MASTER_A1NOC_SNOC			12
-#define SC7280_MASTER_A2NOC_SNOC			13
-#define SC7280_MASTER_COMPUTE_NOC			14
-#define SC7280_MASTER_CNOC2_CNOC3			15
-#define SC7280_MASTER_CNOC3_CNOC2			16
-#define SC7280_MASTER_CNOC_A2NOC			17
-#define SC7280_MASTER_CNOC_DC_NOC			18
-#define SC7280_MASTER_GEM_NOC_CFG			19
-#define SC7280_MASTER_GEM_NOC_CNOC			20
-#define SC7280_MASTER_GEM_NOC_PCIE_SNOC			21
-#define SC7280_MASTER_GFX3D			22
-#define SC7280_MASTER_CNOC_MNOC_CFG			23
-#define SC7280_MASTER_MNOC_HF_MEM_NOC			24
-#define SC7280_MASTER_MNOC_SF_MEM_NOC			25
-#define SC7280_MASTER_ANOC_PCIE_GEM_NOC			26
-#define SC7280_MASTER_SNOC_CFG			27
-#define SC7280_MASTER_SNOC_GC_MEM_NOC			28
-#define SC7280_MASTER_SNOC_SF_MEM_NOC			29
-#define SC7280_MASTER_VIDEO_P0			30
-#define SC7280_MASTER_VIDEO_PROC			31
-#define SC7280_MASTER_QUP_CORE_0			32
-#define SC7280_MASTER_QUP_CORE_1			33
-#define SC7280_MASTER_CAMNOC_HF			34
-#define SC7280_MASTER_CAMNOC_ICP			35
-#define SC7280_MASTER_CAMNOC_SF			36
-#define SC7280_MASTER_CRYPTO			37
-#define SC7280_MASTER_IPA			38
-#define SC7280_MASTER_MDP0			39
-#define SC7280_MASTER_CDSP_PROC			40
-#define SC7280_MASTER_PIMEM			41
-#define SC7280_MASTER_GIC			42
-#define SC7280_MASTER_PCIE_0			43
-#define SC7280_MASTER_PCIE_1			44
-#define SC7280_MASTER_QDSS_DAP			45
-#define SC7280_MASTER_QDSS_ETR			46
-#define SC7280_MASTER_SDCC_1			47
-#define SC7280_MASTER_SDCC_2			48
-#define SC7280_MASTER_SDCC_4			49
-#define SC7280_MASTER_UFS_MEM			50
-#define SC7280_MASTER_USB2			51
-#define SC7280_MASTER_USB3_0			52
-#define SC7280_SLAVE_EBI1			53
-#define SC7280_SLAVE_AHB2PHY_SOUTH			54
-#define SC7280_SLAVE_AHB2PHY_NORTH			55
-#define SC7280_SLAVE_AOSS			56
-#define SC7280_SLAVE_APPSS			57
-#define SC7280_SLAVE_CAMERA_CFG			58
-#define SC7280_SLAVE_CLK_CTL			59
-#define SC7280_SLAVE_CDSP_CFG			60
-#define SC7280_SLAVE_RBCPR_CX_CFG			61
-#define SC7280_SLAVE_RBCPR_MX_CFG			62
-#define SC7280_SLAVE_CRYPTO_0_CFG			63
-#define SC7280_SLAVE_CX_RDPM			64
-#define SC7280_SLAVE_DCC_CFG			65
-#define SC7280_SLAVE_DISPLAY_CFG			66
-#define SC7280_SLAVE_GFX3D_CFG			67
-#define SC7280_SLAVE_HWKM			68
-#define SC7280_SLAVE_IMEM_CFG			69
-#define SC7280_SLAVE_IPA_CFG			70
-#define SC7280_SLAVE_IPC_ROUTER_CFG			71
-#define SC7280_SLAVE_LLCC_CFG			72
-#define SC7280_SLAVE_LPASS			73
-#define SC7280_SLAVE_LPASS_CORE_CFG			74
-#define SC7280_SLAVE_LPASS_LPI_CFG			75
-#define SC7280_SLAVE_LPASS_MPU_CFG			76
-#define SC7280_SLAVE_LPASS_TOP_CFG			77
-#define SC7280_SLAVE_MSS_PROC_MS_MPU_CFG			78
-#define SC7280_SLAVE_MCDMA_MS_MPU_CFG			79
-#define SC7280_SLAVE_CNOC_MSS			80
-#define SC7280_SLAVE_MX_RDPM			81
-#define SC7280_SLAVE_PCIE_0_CFG			82
-#define SC7280_SLAVE_PCIE_1_CFG			83
-#define SC7280_SLAVE_PDM			84
-#define SC7280_SLAVE_PIMEM_CFG			85
-#define SC7280_SLAVE_PKA_WRAPPER_CFG			86
-#define SC7280_SLAVE_PMU_WRAPPER_CFG			87
-#define SC7280_SLAVE_QDSS_CFG			88
-#define SC7280_SLAVE_QSPI_0			89
-#define SC7280_SLAVE_QUP_0			90
-#define SC7280_SLAVE_QUP_1			91
-#define SC7280_SLAVE_SDCC_1			92
-#define SC7280_SLAVE_SDCC_2			93
-#define SC7280_SLAVE_SDCC_4			94
-#define SC7280_SLAVE_SECURITY			95
-#define SC7280_SLAVE_TCSR			96
-#define SC7280_SLAVE_TLMM			97
-#define SC7280_SLAVE_UFS_MEM_CFG			98
-#define SC7280_SLAVE_USB2			99
-#define SC7280_SLAVE_USB3_0			100
-#define SC7280_SLAVE_VENUS_CFG			101
-#define SC7280_SLAVE_VSENSE_CTRL_CFG			102
-#define SC7280_SLAVE_A1NOC_CFG			103
-#define SC7280_SLAVE_A1NOC_SNOC			104
-#define SC7280_SLAVE_A2NOC_CFG			105
-#define SC7280_SLAVE_A2NOC_SNOC			106
-#define SC7280_SLAVE_CNOC2_CNOC3			107
-#define SC7280_SLAVE_CNOC3_CNOC2			108
-#define SC7280_SLAVE_CNOC_A2NOC			109
-#define SC7280_SLAVE_DDRSS_CFG			110
-#define SC7280_SLAVE_GEM_NOC_CNOC			111
-#define SC7280_SLAVE_GEM_NOC_CFG			112
-#define SC7280_SLAVE_SNOC_GEM_NOC_GC			113
-#define SC7280_SLAVE_SNOC_GEM_NOC_SF			114
-#define SC7280_SLAVE_LLCC			115
-#define SC7280_SLAVE_MNOC_HF_MEM_NOC			116
-#define SC7280_SLAVE_MNOC_SF_MEM_NOC			117
-#define SC7280_SLAVE_CNOC_MNOC_CFG			118
-#define SC7280_SLAVE_CDSP_MEM_NOC			119
-#define SC7280_SLAVE_MEM_NOC_PCIE_SNOC			120
-#define SC7280_SLAVE_ANOC_PCIE_GEM_NOC			121
-#define SC7280_SLAVE_SNOC_CFG			122
-#define SC7280_SLAVE_QUP_CORE_0			123
-#define SC7280_SLAVE_QUP_CORE_1			124
-#define SC7280_SLAVE_BOOT_IMEM			125
-#define SC7280_SLAVE_IMEM			126
-#define SC7280_SLAVE_PIMEM			127
-#define SC7280_SLAVE_SERVICE_NSP_NOC			128
-#define SC7280_SLAVE_SERVICE_A1NOC			129
-#define SC7280_SLAVE_SERVICE_A2NOC			130
-#define SC7280_SLAVE_SERVICE_GEM_NOC_1			131
-#define SC7280_SLAVE_SERVICE_MNOC			132
-#define SC7280_SLAVE_SERVICES_LPASS_AML_NOC			133
-#define SC7280_SLAVE_SERVICE_LPASS_AG_NOC			134
-#define SC7280_SLAVE_SERVICE_GEM_NOC_2			135
-#define SC7280_SLAVE_SERVICE_SNOC			136
-#define SC7280_SLAVE_SERVICE_GEM_NOC			137
-#define SC7280_SLAVE_PCIE_0			138
-#define SC7280_SLAVE_PCIE_1			139
-#define SC7280_SLAVE_QDSS_STM			140
-#define SC7280_SLAVE_TCU			141
-
-#endif

-- 
2.39.5


