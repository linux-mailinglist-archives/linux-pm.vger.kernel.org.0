Return-Path: <linux-pm+bounces-30165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1FDAF98D4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10EB4A4674
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D25D19259F;
	Fri,  4 Jul 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+J5RK9X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C057327FE4
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646978; cv=none; b=Oh4Ug/nhBvThGRIFJUo9PtuquGNJ58OnEmj0MWtth0MH+g+EKOgbVrZnFpPD5JgGCfUAcH+b/PADJMpOQ0nMo7WQEsafHyjmgly1QZHqujcB5KTnRpDpQlOFd3/PwHOFWMe7yoXZ/xzzKGcjjlhvt3U+4Wm/zINF+fHRG1u2WmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646978; c=relaxed/simple;
	bh=83XKM1F3DSDMdy5GvIFH1Xj+6yWDV4sBOu4RriD+XyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kPRul+j/7luWhb5JVK2oIWleHZA1vPxNGSrMPj53Hs4kbTXbxHRnGq5d43MdlkfhQHyWTasQhxcEOBbjZzcWuyVtlf4YEsVuZn4meJm75+KvP0vnSC0Cc3W4vwva0YlF6v5lgRxjy8iRnz+p2kHW6kEy3IByB52YqPI++kR/WL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+J5RK9X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56483wV1025364
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rmt61yKH/rbforAXfZV8FsJcSUL14xvw0Wn9uXZW4zE=; b=i+J5RK9XkXwlKjZu
	esvUKz6vYKStfWIVGMxDxOA5N3VmuMT4ulvbemwgUew29+j9VFhEJ+bZjE+K7U62
	S8evlOlE3a9Chj8+/sBA0NU/SQzoZBDtNMcCyLR2GDxC1sN8x+vFZ8Q9sCkYBP+e
	NJNTUqt5xurmLrNsii2TZkNALyByRYvTf2jyVzzV0gnVdtilLH3VFR5q7WSsivi5
	U6tIZeOXkRO1zgJLqyO8m67sZ4aqBZJLl2XqtSFZOKyKj1bjbpYbmKnjMRlWQ7cy
	4VwGUnNE6R0WUtgfS4j4qzBSaRRDhacprBIAz7s4bx/mkup6jHW9YatMe2buZzbI
	t1JTLQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kd651j17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:36:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d4576e83cdso285331685a.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646964; x=1752251764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rmt61yKH/rbforAXfZV8FsJcSUL14xvw0Wn9uXZW4zE=;
        b=l8mCBi853AJWqORrRpJOHd3xExEufuIsLJLuIgHbAjFH90RZ4aOwEcEQm5/0eh+2pF
         SB5jRST+6eoPU4oO5zUa7QRg0VlcuTyL84wEfPVWM57Rz6KlbqQGJVlBakk/atYzHpdT
         j5VfgPSYprVfIMNauR0/x9I1nGdnltW0GHdZJUTYbZQa55NX1/XJgraB8GQCO6qKsslj
         swt9mfjxXyzc1kSr+GHFXgDOSm7bJ0WU1VE/wSRCQs1+avA+rMn/lTunQgc3l+/2G+I4
         hHU0AEw6yLr9XBEbduP9petGvqJtjkKfmrJRf0Pi3YptGwLSaEklugai1qTg9JbIR+s9
         jRdw==
X-Forwarded-Encrypted: i=1; AJvYcCW2fPY69/m24jJ17a9hMMFxxrF8V22CLWQiSl1V3f+Db9EcgncplF33stpy84df9e7qaOJT8PUMXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQ3bib1j0GyBDkmwm2Sgu6YpiqHoX2cluD+J/Yn9PjKftqwn4
	l57bUIzuJAyhyFYUE/OaOyXrLTgXBFPi/cyz8U9sx8jJNYJCGpabTZNwbMpyiuy8ERADxixDLgF
	qxTvMf/jPmXAE47yhpgdIsP9DZI23vp5nR9uvr6rQSEcMAeC4PJQxEL+1tRqafw==
X-Gm-Gg: ASbGncsDiV8JZkfYVIwiqQjVhlMAd10kI79/Jxe68iP7dDXAykvCEQkIZ0wLvxMGE8g
	KkAQTr4E4KzD1GAI7tvO8J/k3bh2XDFgFzYCLch6SNfHwOXXeePv/Ay+vqMCkdqIvpIpTjUjkMS
	9vobr70bY5nfGjyfx/4qdnaVl+/wiGOxkw4OxaqrHgTM+uRyVgvO7IhCSLoZ8FXMr3TRjqh6Ilr
	dIZUZ5YYsdCYmjWvXluFsoS8DpntzqAVeZt7wTqVcLMB4FzYT4HB9YIig/oOPg6gUpDrteqLJrI
	sVZx2dAxi1YUPB6VAJk2lXFO2npp0lrc4c4XYylxqq5og15LoLDc43q8flR5/cnj5By3p+7uSGP
	qxJxoQ8XHI0TfNkscPRfArEJ9ogtMJNGCwAY=
X-Received: by 2002:a05:620a:2991:b0:7d3:f68c:5778 with SMTP id af79cd13be357-7d5ddbfe672mr499825285a.54.1751646963022;
        Fri, 04 Jul 2025 09:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBmM442FhJwwYMrBft9hRz6iTvnr+zTsDpKg60o579owERoXzPPxPj6/5NXpOr1TBrV/qvbA==
X-Received: by 2002:a05:620a:2991:b0:7d3:f68c:5778 with SMTP id af79cd13be357-7d5ddbfe672mr499818685a.54.1751646962257;
        Fri, 04 Jul 2025 09:36:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:36:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:34 +0300
Subject: [PATCH v2 22/28] interconnect: qcom: sm8150: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-22-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=52352;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=83XKM1F3DSDMdy5GvIFH1Xj+6yWDV4sBOu4RriD+XyY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALICfJSPOHpcHzZC3hhOXWZN9Tw8nMfDEMhu
 so2lJgVASGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCyAAKCRCLPIo+Aiko
 1f/CB/4qnvsN3fwCr3howEle6Y3Xebr0v/WQSmP1RuP24I2InhhVhp2J8bHVU/3XLMEtlxhVMHJ
 6UJw1FRYewXaiurt1ihtpuJwn4lbMrfNWH/p7STXUGCNbSWTYuvpvni/jSbKtklefsYXufEp8zT
 AWFEBjs7sE5h7o+0FMgr5QOyq9Ky0PGEILc7PVNrNCFzlBjIUHbXjTPCwFeON/iIOdqywkz5gNa
 BkWLAn8D6vTS1xLhp0lqO+ZVHe4GhsFZqKzoq7OCP0mtl7kp2JPFNyvCoM4sOQah/xaMn2XpTSf
 vj5tNwdqL4rKWnzU6dXAI1gpBPdidP52mTJVqxiw+V9iZ+4d
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z+PsHGRA c=1 sm=1 tr=0 ts=686802f4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xGeYJCKw5NWn-kRsI3kA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXxiBIfIRy4EUX
 18WbiYTSQkHFAMJ5xahzp0X3tNo0izrFcy9SvX2eH0Mww2yO0tI2BIqEWHzSVVW72YCpti4E/uP
 KK5jvyb20l20AWf+oij8EiDj7I7WNi0hDHlLMZOF+WbtdtPRcDgopxUAjIHSO+il7AaPHUlGy4m
 eAw2wWbevLWSO7GL89DRSfxBSKlXoxXZf+kJydAOodncoHSrYlcgpCE2tK5ygVXihqUwR7XhBzx
 K6LqVAVyJmdd8k9hzdWenQaCUKIKQdHOJvIpyna+rF6MDwKRnZe8LshNEEOLEsWVd3i/jhhdtx6
 2yDvmPzhPhiHCOS01fAJffFYLcevRcVIgqUQGjFVGcY4E6bGTAI8IjcMHBsrO+t1SwVIKLHZ4Ob
 OPwy4F1J68kqlCzZBF5xQ2yvveIAgLv/GYFJUbWXbgjTDuLVIF5zDt7JoZp1HQwLMUAXMgfp
X-Proofpoint-GUID: jdeBmArfwm-fs_0UBqyK0LOA8MfVnqCR
X-Proofpoint-ORIG-GUID: jdeBmArfwm-fs_0UBqyK0LOA8MfVnqCR
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
 drivers/interconnect/qcom/sm8150.c | 854 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sm8150.h | 152 -------
 2 files changed, 417 insertions(+), 589 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index c5dc5b55ae564683dd169de621fffcd7449a70f5..a545e780cacd77b0e8834c879d62c1fc1b3a433d 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -14,1270 +14,1240 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sm8150.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node xm_emac;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qhm_sensorss_ahb;
+static struct qcom_icc_node qhm_tsif;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qnm_npu;
+static struct qcom_icc_node qhm_spdm;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc_dc_noc;
+static struct qcom_icc_node acm_apps;
+static struct qcom_icc_node acm_gpu_tcu;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_ecc;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qxm_camnoc_hf0;
+static struct qcom_icc_node qxm_camnoc_hf1;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_mdp1;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qxm_venus0;
+static struct qcom_icc_node qxm_venus1;
+static struct qcom_icc_node qxm_venus_arm9;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qns_cdsp_mem_noc;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy_south;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_dsp;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_emac_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_npu_cfg;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_phy_refgen_north;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qupv3_east;
+static struct qcom_icc_node qhs_qupv3_north;
+static struct qcom_icc_node qhs_qupv3_south;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spdm;
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_ssc_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_east;
+static struct qcom_icc_node qhs_tlmm_north;
+static struct qcom_icc_node qhs_tlmm_south;
+static struct qcom_icc_node qhs_tlmm_west;
+static struct qcom_icc_node qhs_tsif;
+static struct qcom_icc_node qhs_ufs_card_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_usb3_1;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_memnoc;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_ecc;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns2_mem_noc;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = SM8150_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SM8150_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emac = {
 	.name = "xm_emac",
-	.id = SM8150_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8150_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8150_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SM8150_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SM8150_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8150_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8150_MASTER_QSPI,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8150_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8150_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_sensorss_ahb = {
 	.name = "qhm_sensorss_ahb",
-	.id = SM8150_MASTER_SENSORS_AHB,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_tsif = {
 	.name = "qhm_tsif",
-	.id = SM8150_MASTER_TSIF,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SM8150_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8150_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8150_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM8150_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SM8150_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM8150_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8150_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8150_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SM8150_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
 	.name = "qxm_camnoc_hf1_uncomp",
-	.id = SM8150_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SM8150_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SM8150_MASTER_NPU,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_cdsp_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_spdm = {
 	.name = "qhm_spdm",
-	.id = SM8150_MASTER_SPDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_CNOC_A2NOC },
+	.link_nodes = { &qns_cnoc_a2noc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SM8150_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 50,
-	.links = { SM8150_SLAVE_TLMM_SOUTH,
-		   SM8150_SLAVE_CDSP_CFG,
-		   SM8150_SLAVE_SPSS_CFG,
-		   SM8150_SLAVE_CAMERA_CFG,
-		   SM8150_SLAVE_SDCC_4,
-		   SM8150_SLAVE_SDCC_2,
-		   SM8150_SLAVE_CNOC_MNOC_CFG,
-		   SM8150_SLAVE_EMAC_CFG,
-		   SM8150_SLAVE_UFS_MEM_CFG,
-		   SM8150_SLAVE_TLMM_EAST,
-		   SM8150_SLAVE_SSC_CFG,
-		   SM8150_SLAVE_SNOC_CFG,
-		   SM8150_SLAVE_NORTH_PHY_CFG,
-		   SM8150_SLAVE_QUP_0,
-		   SM8150_SLAVE_GLM,
-		   SM8150_SLAVE_PCIE_1_CFG,
-		   SM8150_SLAVE_A2NOC_CFG,
-		   SM8150_SLAVE_QDSS_CFG,
-		   SM8150_SLAVE_DISPLAY_CFG,
-		   SM8150_SLAVE_TCSR,
-		   SM8150_SLAVE_CNOC_DDRSS,
-		   SM8150_SLAVE_RBCPR_MMCX_CFG,
-		   SM8150_SLAVE_NPU_CFG,
-		   SM8150_SLAVE_PCIE_0_CFG,
-		   SM8150_SLAVE_GRAPHICS_3D_CFG,
-		   SM8150_SLAVE_VENUS_CFG,
-		   SM8150_SLAVE_TSIF,
-		   SM8150_SLAVE_IPA_CFG,
-		   SM8150_SLAVE_CLK_CTL,
-		   SM8150_SLAVE_AOP,
-		   SM8150_SLAVE_QUP_1,
-		   SM8150_SLAVE_AHB2PHY_SOUTH,
-		   SM8150_SLAVE_USB3_1,
-		   SM8150_SLAVE_SERVICE_CNOC,
-		   SM8150_SLAVE_UFS_CARD_CFG,
-		   SM8150_SLAVE_QUP_2,
-		   SM8150_SLAVE_RBCPR_CX_CFG,
-		   SM8150_SLAVE_TLMM_WEST,
-		   SM8150_SLAVE_A1NOC_CFG,
-		   SM8150_SLAVE_AOSS,
-		   SM8150_SLAVE_PRNG,
-		   SM8150_SLAVE_VSENSE_CTRL_CFG,
-		   SM8150_SLAVE_QSPI,
-		   SM8150_SLAVE_USB3,
-		   SM8150_SLAVE_SPDM_WRAPPER,
-		   SM8150_SLAVE_CRYPTO_0_CFG,
-		   SM8150_SLAVE_PIMEM_CFG,
-		   SM8150_SLAVE_TLMM_NORTH,
-		   SM8150_SLAVE_RBCPR_MX_CFG,
-		   SM8150_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_tlmm_south,
+			&qhs_compute_dsp,
+			&qhs_spss_cfg,
+			&qhs_camera_cfg,
+			&qhs_sdc4,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_tlmm_east,
+			&qhs_ssc_cfg,
+			&qhs_snoc_cfg,
+			&qhs_phy_refgen_north,
+			&qhs_qupv3_south,
+			&qhs_glm,
+			&qhs_pcie1_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_cpr_mmcx,
+			&qhs_npu_cfg,
+			&qhs_pcie0_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_ipa,
+			&qhs_clk_ctl,
+			&qhs_aop,
+			&qhs_qupv3_north,
+			&qhs_ahb2phy_south,
+			&qhs_usb3_1,
+			&srvc_cnoc,
+			&qhs_ufs_card_cfg,
+			&qhs_qupv3_east,
+			&qhs_cpr_cx,
+			&qhs_tlmm_west,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_qspi,
+			&qhs_usb3_0,
+			&qhs_spdm,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_tlmm_north,
+			&qhs_cpr_mx,
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM8150_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 51,
-	.links = { SM8150_SLAVE_TLMM_SOUTH,
-		   SM8150_SLAVE_CDSP_CFG,
-		   SM8150_SLAVE_SPSS_CFG,
-		   SM8150_SLAVE_CAMERA_CFG,
-		   SM8150_SLAVE_SDCC_4,
-		   SM8150_SLAVE_SDCC_2,
-		   SM8150_SLAVE_CNOC_MNOC_CFG,
-		   SM8150_SLAVE_EMAC_CFG,
-		   SM8150_SLAVE_UFS_MEM_CFG,
-		   SM8150_SLAVE_TLMM_EAST,
-		   SM8150_SLAVE_SSC_CFG,
-		   SM8150_SLAVE_SNOC_CFG,
-		   SM8150_SLAVE_NORTH_PHY_CFG,
-		   SM8150_SLAVE_QUP_0,
-		   SM8150_SLAVE_GLM,
-		   SM8150_SLAVE_PCIE_1_CFG,
-		   SM8150_SLAVE_A2NOC_CFG,
-		   SM8150_SLAVE_QDSS_CFG,
-		   SM8150_SLAVE_DISPLAY_CFG,
-		   SM8150_SLAVE_TCSR,
-		   SM8150_SLAVE_CNOC_DDRSS,
-		   SM8150_SLAVE_CNOC_A2NOC,
-		   SM8150_SLAVE_RBCPR_MMCX_CFG,
-		   SM8150_SLAVE_NPU_CFG,
-		   SM8150_SLAVE_PCIE_0_CFG,
-		   SM8150_SLAVE_GRAPHICS_3D_CFG,
-		   SM8150_SLAVE_VENUS_CFG,
-		   SM8150_SLAVE_TSIF,
-		   SM8150_SLAVE_IPA_CFG,
-		   SM8150_SLAVE_CLK_CTL,
-		   SM8150_SLAVE_AOP,
-		   SM8150_SLAVE_QUP_1,
-		   SM8150_SLAVE_AHB2PHY_SOUTH,
-		   SM8150_SLAVE_USB3_1,
-		   SM8150_SLAVE_SERVICE_CNOC,
-		   SM8150_SLAVE_UFS_CARD_CFG,
-		   SM8150_SLAVE_QUP_2,
-		   SM8150_SLAVE_RBCPR_CX_CFG,
-		   SM8150_SLAVE_TLMM_WEST,
-		   SM8150_SLAVE_A1NOC_CFG,
-		   SM8150_SLAVE_AOSS,
-		   SM8150_SLAVE_PRNG,
-		   SM8150_SLAVE_VSENSE_CTRL_CFG,
-		   SM8150_SLAVE_QSPI,
-		   SM8150_SLAVE_USB3,
-		   SM8150_SLAVE_SPDM_WRAPPER,
-		   SM8150_SLAVE_CRYPTO_0_CFG,
-		   SM8150_SLAVE_PIMEM_CFG,
-		   SM8150_SLAVE_TLMM_NORTH,
-		   SM8150_SLAVE_RBCPR_MX_CFG,
-		   SM8150_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_tlmm_south,
+			&qhs_compute_dsp,
+			&qhs_spss_cfg,
+			&qhs_camera_cfg,
+			&qhs_sdc4,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_tlmm_east,
+			&qhs_ssc_cfg,
+			&qhs_snoc_cfg,
+			&qhs_phy_refgen_north,
+			&qhs_qupv3_south,
+			&qhs_glm,
+			&qhs_pcie1_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qns_cnoc_a2noc,
+			&qhs_cpr_mmcx,
+			&qhs_npu_cfg,
+			&qhs_pcie0_cfg,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_ipa,
+			&qhs_clk_ctl,
+			&qhs_aop,
+			&qhs_qupv3_north,
+			&qhs_ahb2phy_south,
+			&qhs_usb3_1,
+			&srvc_cnoc,
+			&qhs_ufs_card_cfg,
+			&qhs_qupv3_east,
+			&qhs_cpr_cx,
+			&qhs_tlmm_west,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_qspi,
+			&qhs_usb3_0,
+			&qhs_spdm,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_tlmm_north,
+			&qhs_cpr_mx,
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SM8150_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_GEM_NOC_CFG,
-		   SM8150_SLAVE_LLCC_CFG
-	},
+	.link_nodes = { &qhs_memnoc,
+			&qhs_llcc, NULL },
 };
 
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
-	.id = SM8150_MASTER_AMPSS_M0,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SM8150_SLAVE_ECC,
-		   SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_ecc,
+			&qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node acm_gpu_tcu = {
 	.name = "acm_gpu_tcu",
-	.id = SM8150_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = SM8150_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SM8150_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_SERVICE_GEM_NOC,
-		   SM8150_SLAVE_MSS_PROC_MS_MPU_CFG
-	},
+	.link_nodes = { &srvc_gemnoc,
+			&qhs_mdsp_ms_mpu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM8150_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SM8150_SLAVE_ECC,
-		   SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_ecc,
+			&qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8150_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8150_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8150_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8150_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_LLCC,
-		   SM8150_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM8150_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8150_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qxm_ecc = {
 	.name = "qxm_ecc",
-	.id = SM8150_MASTER_ECC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8150_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SM8150_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
-	.id = SM8150_MASTER_CAMNOC_HF0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
-	.id = SM8150_MASTER_CAMNOC_HF1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SM8150_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM8150_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SM8150_MASTER_MDP_PORT1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SM8150_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = SM8150_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus1 = {
 	.name = "qxm_venus1",
-	.id = SM8150_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = SM8150_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SM8150_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8150_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 6,
-	.links = { SM8150_SLAVE_SNOC_GEM_NOC_SF,
-		   SM8150_SLAVE_PIMEM,
-		   SM8150_SLAVE_OCIMEM,
-		   SM8150_SLAVE_APPSS,
-		   SM8150_SNOC_CNOC_SLV,
-		   SM8150_SLAVE_QDSS_STM
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
-	.id = SM8150_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 9,
-	.links = { SM8150_SLAVE_SNOC_GEM_NOC_SF,
-		   SM8150_SLAVE_PIMEM,
-		   SM8150_SLAVE_OCIMEM,
-		   SM8150_SLAVE_APPSS,
-		   SM8150_SNOC_CNOC_SLV,
-		   SM8150_SLAVE_PCIE_0,
-		   SM8150_SLAVE_PCIE_1,
-		   SM8150_SLAVE_TCU,
-		   SM8150_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qns_gemnoc_sf,
+			&qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_pcie_0,
+			&xs_pcie_1,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = SM8150_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 6,
-	.links = { SM8150_SLAVE_PIMEM,
-		   SM8150_SLAVE_OCIMEM,
-		   SM8150_SLAVE_APPSS,
-		   SM8150_SNOC_CNOC_SLV,
-		   SM8150_SLAVE_TCU,
-		   SM8150_SLAVE_QDSS_STM
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
-	.id = SM8150_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_SNOC_GEM_NOC_GC,
-		   SM8150_SLAVE_OCIMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8150_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8150_SLAVE_SNOC_GEM_NOC_GC,
-		   SM8150_SLAVE_OCIMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8150_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8150_A1NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM8150_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8150_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8150_A2NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8150_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8150_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM8150_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SM8150_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cdsp_mem_noc = {
 	.name = "qns_cdsp_mem_noc",
-	.id = SM8150_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SM8150_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SM8150_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_south = {
 	.name = "qhs_ahb2phy_south",
-	.id = SM8150_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SM8150_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8150_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8150_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8150_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_dsp = {
 	.name = "qhs_compute_dsp",
-	.id = SM8150_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM8150_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SM8150_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM8150_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8150_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SM8150_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8150_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac_cfg = {
 	.name = "qhs_emac_cfg",
-	.id = SM8150_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SM8150_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8150_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8150_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8150_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SM8150_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_npu_cfg = {
 	.name = "qhs_npu_cfg",
-	.id = SM8150_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SM8150_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SM8150_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_phy_refgen_north = {
 	.name = "qhs_phy_refgen_north",
-	.id = SM8150_SLAVE_NORTH_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM8150_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM8150_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8150_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8150_SLAVE_QSPI,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_east = {
 	.name = "qhs_qupv3_east",
-	.id = SM8150_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_north = {
 	.name = "qhs_qupv3_north",
-	.id = SM8150_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_south = {
 	.name = "qhs_qupv3_south",
-	.id = SM8150_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8150_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8150_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SM8150_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_spdm = {
 	.name = "qhs_spdm",
-	.id = SM8150_SLAVE_SPDM_WRAPPER,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SM8150_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ssc_cfg = {
 	.name = "qhs_ssc_cfg",
-	.id = SM8150_SLAVE_SSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8150_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_east = {
 	.name = "qhs_tlmm_east",
-	.id = SM8150_SLAVE_TLMM_EAST,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_north = {
 	.name = "qhs_tlmm_north",
-	.id = SM8150_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_south = {
 	.name = "qhs_tlmm_south",
-	.id = SM8150_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_west = {
 	.name = "qhs_tlmm_west",
-	.id = SM8150_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tsif = {
 	.name = "qhs_tsif",
-	.id = SM8150_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SM8150_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8150_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8150_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SM8150_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8150_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8150_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SM8150_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc, NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM8150_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM8150_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_memnoc = {
 	.name = "qhs_memnoc",
-	.id = SM8150_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8150_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SM8150_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_ecc = {
 	.name = "qns_ecc",
-	.id = SM8150_SLAVE_ECC,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SM8150_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8150_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8150_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SM8150_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8150_SLAVE_EBI_CH0,
 	.channels = 4,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns2_mem_noc = {
 	.name = "qns2_mem_noc",
-	.id = SM8150_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8150_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8150_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8150_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM8150_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SM8150_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_SNOC_CNOC_MAS },
+	.link_nodes = { &qnm_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM8150_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8150_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8150_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8150_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8150_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM8150_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM8150_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SM8150_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SM8150_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8150_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8150_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1524,6 +1494,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1559,6 +1530,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1577,6 +1549,7 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_camnoc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1594,6 +1567,7 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1662,6 +1636,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1678,6 +1653,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1713,6 +1689,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1730,6 +1707,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1760,6 +1738,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1801,6 +1780,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8150_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
deleted file mode 100644
index 1d587c94eb06e1b06b0dcd582807b87aa59af075..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm8150.h
+++ /dev/null
@@ -1,152 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SM8250 interconnect IDs
- *
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8150_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM8150_H
-
-#define SM8150_A1NOC_SNOC_MAS			0
-#define SM8150_A1NOC_SNOC_SLV			1
-#define SM8150_A2NOC_SNOC_MAS			2
-#define SM8150_A2NOC_SNOC_SLV			3
-#define SM8150_MASTER_A1NOC_CFG			4
-#define SM8150_MASTER_A2NOC_CFG			5
-#define SM8150_MASTER_AMPSS_M0			6
-#define SM8150_MASTER_CAMNOC_HF0		7
-#define SM8150_MASTER_CAMNOC_HF0_UNCOMP		8
-#define SM8150_MASTER_CAMNOC_HF1		9
-#define SM8150_MASTER_CAMNOC_HF1_UNCOMP		10
-#define SM8150_MASTER_CAMNOC_SF			11
-#define SM8150_MASTER_CAMNOC_SF_UNCOMP		12
-#define SM8150_MASTER_CNOC_A2NOC		13
-#define SM8150_MASTER_CNOC_DC_NOC		14
-#define SM8150_MASTER_CNOC_MNOC_CFG		15
-#define SM8150_MASTER_COMPUTE_NOC		16
-#define SM8150_MASTER_CRYPTO_CORE_0		17
-#define SM8150_MASTER_ECC			18
-#define SM8150_MASTER_EMAC			19
-#define SM8150_MASTER_GEM_NOC_CFG		20
-#define SM8150_MASTER_GEM_NOC_PCIE_SNOC		21
-#define SM8150_MASTER_GEM_NOC_SNOC		22
-#define SM8150_MASTER_GIC			23
-#define SM8150_MASTER_GPU_TCU			24
-#define SM8150_MASTER_GRAPHICS_3D		25
-#define SM8150_MASTER_IPA			26
-/* 27 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SM8150_MASTER_LLCC			28
-#define SM8150_MASTER_MDP_PORT0			29
-#define SM8150_MASTER_MDP_PORT1			30
-#define SM8150_MASTER_MNOC_HF_MEM_NOC		31
-#define SM8150_MASTER_MNOC_SF_MEM_NOC		32
-#define SM8150_MASTER_NPU			33
-#define SM8150_MASTER_PCIE			34
-#define SM8150_MASTER_PCIE_1			35
-#define SM8150_MASTER_PIMEM			36
-#define SM8150_MASTER_QDSS_BAM			37
-#define SM8150_MASTER_QDSS_DAP			38
-#define SM8150_MASTER_QDSS_ETR			39
-#define SM8150_MASTER_QSPI			40
-#define SM8150_MASTER_QUP_0			41
-#define SM8150_MASTER_QUP_1			42
-#define SM8150_MASTER_QUP_2			43
-#define SM8150_MASTER_ROTATOR			44
-#define SM8150_MASTER_SDCC_2			45
-#define SM8150_MASTER_SDCC_4			46
-#define SM8150_MASTER_SENSORS_AHB		47
-#define SM8150_MASTER_SNOC_CFG			48
-#define SM8150_MASTER_SNOC_GC_MEM_NOC		49
-#define SM8150_MASTER_SNOC_SF_MEM_NOC		50
-#define SM8150_MASTER_SPDM			51
-#define SM8150_MASTER_SYS_TCU			52
-#define SM8150_MASTER_TSIF			53
-#define SM8150_MASTER_UFS_MEM			54
-#define SM8150_MASTER_USB3			55
-#define SM8150_MASTER_USB3_1			56
-#define SM8150_MASTER_VIDEO_P0			57
-#define SM8150_MASTER_VIDEO_P1			58
-#define SM8150_MASTER_VIDEO_PROC		59
-#define SM8150_SLAVE_A1NOC_CFG			60
-#define SM8150_SLAVE_A2NOC_CFG			61
-#define SM8150_SLAVE_AHB2PHY_SOUTH		62
-#define SM8150_SLAVE_ANOC_PCIE_GEM_NOC		63
-#define SM8150_SLAVE_AOP			64
-#define SM8150_SLAVE_AOSS			65
-#define SM8150_SLAVE_APPSS			66
-#define SM8150_SLAVE_CAMERA_CFG			67
-#define SM8150_SLAVE_CAMNOC_UNCOMP		68
-#define SM8150_SLAVE_CDSP_CFG			69
-#define SM8150_SLAVE_CDSP_MEM_NOC		70
-#define SM8150_SLAVE_CLK_CTL			71
-#define SM8150_SLAVE_CNOC_A2NOC			72
-#define SM8150_SLAVE_CNOC_DDRSS			73
-#define SM8150_SLAVE_CNOC_MNOC_CFG		74
-#define SM8150_SLAVE_CRYPTO_0_CFG		75
-#define SM8150_SLAVE_DISPLAY_CFG		76
-#define SM8150_SLAVE_EBI_CH0			77
-#define SM8150_SLAVE_ECC			78
-#define SM8150_SLAVE_EMAC_CFG			79
-#define SM8150_SLAVE_GEM_NOC_CFG		80
-#define SM8150_SLAVE_GEM_NOC_SNOC		81
-#define SM8150_SLAVE_GLM			82
-#define SM8150_SLAVE_GRAPHICS_3D_CFG		83
-#define SM8150_SLAVE_IMEM_CFG			84
-#define SM8150_SLAVE_IPA_CFG			85
-/* 86 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SM8150_SLAVE_LLCC			87
-#define SM8150_SLAVE_LLCC_CFG			88
-#define SM8150_SLAVE_MNOC_HF_MEM_NOC		89
-#define SM8150_SLAVE_MNOC_SF_MEM_NOC		90
-#define SM8150_SLAVE_MSS_PROC_MS_MPU_CFG	91
-#define SM8150_SLAVE_NORTH_PHY_CFG		92
-#define SM8150_SLAVE_NPU_CFG			93
-#define SM8150_SLAVE_OCIMEM			94
-#define SM8150_SLAVE_PCIE_0			95
-#define SM8150_SLAVE_PCIE_0_CFG			96
-#define SM8150_SLAVE_PCIE_1			97
-#define SM8150_SLAVE_PCIE_1_CFG			98
-#define SM8150_SLAVE_PIMEM			99
-#define SM8150_SLAVE_PIMEM_CFG			100
-#define SM8150_SLAVE_PRNG			101
-#define SM8150_SLAVE_QDSS_CFG			102
-#define SM8150_SLAVE_QDSS_STM			103
-#define SM8150_SLAVE_QSPI			104
-#define SM8150_SLAVE_QUP_0			105
-#define SM8150_SLAVE_QUP_1			106
-#define SM8150_SLAVE_QUP_2			107
-#define SM8150_SLAVE_RBCPR_CX_CFG		108
-#define SM8150_SLAVE_RBCPR_MMCX_CFG		109
-#define SM8150_SLAVE_RBCPR_MX_CFG		110
-#define SM8150_SLAVE_SDCC_2			111
-#define SM8150_SLAVE_SDCC_4			112
-#define SM8150_SLAVE_SERVICE_A1NOC		113
-#define SM8150_SLAVE_SERVICE_A2NOC		114
-#define SM8150_SLAVE_SERVICE_CNOC		115
-#define SM8150_SLAVE_SERVICE_GEM_NOC		116
-#define SM8150_SLAVE_SERVICE_MNOC		117
-#define SM8150_SLAVE_SERVICE_SNOC		118
-#define SM8150_SLAVE_SNOC_CFG			119
-#define SM8150_SLAVE_SNOC_GEM_NOC_GC		120
-#define SM8150_SLAVE_SNOC_GEM_NOC_SF		121
-#define SM8150_SLAVE_SPDM_WRAPPER		122
-#define SM8150_SLAVE_SPSS_CFG			123
-#define SM8150_SLAVE_SSC_CFG			124
-#define SM8150_SLAVE_TCSR			125
-#define SM8150_SLAVE_TCU			126
-#define SM8150_SLAVE_TLMM_EAST			127
-#define SM8150_SLAVE_TLMM_NORTH			128
-#define SM8150_SLAVE_TLMM_SOUTH			129
-#define SM8150_SLAVE_TLMM_WEST			130
-#define SM8150_SLAVE_TSIF			131
-#define SM8150_SLAVE_UFS_CARD_CFG		132
-#define SM8150_SLAVE_UFS_MEM_CFG		133
-#define SM8150_SLAVE_USB3			134
-#define SM8150_SLAVE_USB3_1			135
-#define SM8150_SLAVE_VENUS_CFG			136
-#define SM8150_SLAVE_VSENSE_CTRL_CFG		137
-#define SM8150_SNOC_CNOC_MAS			138
-#define SM8150_SNOC_CNOC_SLV			139
-
-#endif

-- 
2.39.5


