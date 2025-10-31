Return-Path: <linux-pm+bounces-37201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45865C25AD3
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5F984F7D2D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440652580F3;
	Fri, 31 Oct 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pdaE6ta+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZyRqWq6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601E199920
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921943; cv=none; b=bXy5ZIbIfqC0suBahmCpzV9dl4MJ5evcHWMjK3XRj3SqqtN5fwkAT17hFoqTaMXkzA/nJsAhtZ3RPUuTOOMQU9xM6Z38ahGaGyIy0ZZFzqedtKoAdxRZEFu8NPPuKK1Vz/1etvvbGSQ2cRuu5NNoT97C8VGodVIY80wcgCyHI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921943; c=relaxed/simple;
	bh=5lkn2pwzilYQkT+jE/7X2Z8h+e1PxeRpBZvpaFHGYu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvLjX646zUZK+eny/fz74oZJpUGkRJ1u8kZsmRqcGt3HTsNCgRoBny35aKgA6lSek01kDm2zlfrXgN3Db5qvRb298fWm7QQ7MFt7DutOs11rCEj4Obo06QbQOHxefwQGZxcfGCL+HShTeBbAux44SAOgorrlF7GqhlPUM5vSh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pdaE6ta+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NZyRqWq6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VCYuOP102826
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aiixlibv08ijwiAjdIk/d0cM9GyzsLH7CZ36o5fLQqU=; b=pdaE6ta+t3Niz8cp
	0ISgWo7fh+R9039hIFoHgwH3uLw8qFKHKYk2NFKE/q7yQmFEiMCTcKG/RGokBxtI
	iBeYANJ0etIQgY10bqvb4n4+JsOGN3BUtivH/9Ip0eN0lAKPnl45X45zYbWVSwAH
	xoWwmSyMKyWd0k+wktfd3tqVHMniszrDySInt71r2c/iD23SM7TM7ocpAfkYbFT4
	G3yYE8+v52sua+RUCpA+c7DpM8d1jd7N/eGDDtwG3tDqL5h3ez7WqdaEl2yFpIZm
	tg8OA+MKJ2VkPGJBRH/SNWw/WV41jxxDpV/4j1DXhoVPcfuZxOYHmDfXqkiZqP8f
	Al3Png==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkfxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eba930d6ecso59293561cf.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921935; x=1762526735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aiixlibv08ijwiAjdIk/d0cM9GyzsLH7CZ36o5fLQqU=;
        b=NZyRqWq6d5w/5+b+TPk1R3FCGGzrYHVOjASHi4Kr+W7Jm023zd7FzqpHiu/aFvP+o5
         FRs450FVZN/KHczosHEwrs6qciIm8YDTMl9hlaEuIu+Y0mF/eibEYEw1Vsjo5d9w7iUZ
         EzqwRiO4QJNy+1mMXisSyNcef5vlvjWdUYyK7MzFLTCe+fTeVFvpP20fP5yIlzkh4Hff
         q2kVU7qLTOt4Mm+Bj9P8MPJ6skKtgoDHtwms4xowvyW7HdwHO35mjv3R9p0mJ0Iu4KF5
         6tNyOAuIOW/VaH6Sclzua7qe3x76TDpCTsLcC4FHZTMipzQVZ7NXqAOZtWD9O5JwqWD9
         B1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921935; x=1762526735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aiixlibv08ijwiAjdIk/d0cM9GyzsLH7CZ36o5fLQqU=;
        b=Tbg4sgWh3Si/9SFtxrNzg1dHffpxDru1vlK9pjGDXe5Ig04mzCPHjfZNUFwVzF4GCh
         JFoOUPIWcqyllu9P16encvGaWr9+LfELNwZqE/qDMPBahZdMKPurXXgQrxSE5wZj0umI
         A1FzcIkVtZEI9HJfAGs14NSkq1joNFxswGLK0I+pLREmggl+QKjb1/NVJK6zPbJybBhC
         uzC+HtKhKczsu0eoIdrMo4GZ2xCY5Fu0zdoqeAjM3H2llpxH28FeA7dUaZ23+t/zOT04
         3V21as7UZSiGdXKTeQR6QOQwlI6MgdszKFz/JPbBQR5WPoVZlfaylFyyPpQM+5vWT/NS
         kp/g==
X-Forwarded-Encrypted: i=1; AJvYcCWEE6AGX83sPHQsPUy7DITd7VKLe7gcjNbNticwmF8VerwFwm7xemSwdrf6NRvNXtwSAYrhoG2U2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC89HiYtFdq0DM3U/wPNEWOKaqoVJcu4rp7zzuNNpkNQmoQ7oy
	xoNxGhrsHffv6ke2g0Kp0vUVpZg6U+QXucqjJZ9/Zc+U1+tk69h8xKy6hWyixQnwn8IfLvcbUte
	eXKqgcRvD01We0LVZ3citR6J855CfUnkAOpiIxH+0AY1qSxgCeuwd7Wt82Bq1sA==
X-Gm-Gg: ASbGncvLVtgWyCBM+rsxdaM1pXY5PWnMhDSZVbnSy3rFnxxWiWWgWhdjWyIEqp5Ex2x
	S7vh8YxUBo4ZBjcuIGfwW87t1W/eOn3lgpzlc+NhpkWdLI6sZbfl4+RpPuYqrhBtudPm2fQT7ny
	RMvBy/sjBc98nmn64Z1VbqMT5p2WPGukeMZqXscIliil6XJrqWWe0FZFioFfuUgua1boQQDk5Q/
	5LUA5fO9zhPIPKjdK3g4jOmcQly/curK++rlKAE6aoW6OBp4o1N/Zhk4SChKZm8lzKFmt/0BErp
	YVXELulMPkfwpGeV9QXfEroBAQ9lR5ts4d1vAt5UTohBRbQ3STruU94p3sKirf4tHuxUpNhhKp8
	C5+H0OgMtqVCmwxJMagcGiL3pz4kNnJOTQBjwIj8iR/qyfwWWig7ZJkBocpgVk9JNLQt6R5IVag
	u5KGb2XoNSYWka
X-Received: by 2002:ac8:5ac2:0:b0:4eb:a5c7:f59a with SMTP id d75a77b69052e-4ed30f9ca14mr43118051cf.39.1761921933918;
        Fri, 31 Oct 2025 07:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVpEr2avWafo58RMBHmhhqvzrs4esZ9ibguWMX/0aNW1QZEaC1oYupEBZzXTjB/VqFc5UpZQ==
X-Received: by 2002:ac8:5ac2:0:b0:4eb:a5c7:f59a with SMTP id d75a77b69052e-4ed30f9ca14mr43117051cf.39.1761921933110;
        Fri, 31 Oct 2025 07:45:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:18 +0200
Subject: [PATCH v3 02/25] interconnect: qcom: sc7280: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-2-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=56506;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5lkn2pwzilYQkT+jE/7X2Z8h+e1PxeRpBZvpaFHGYu8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuBmaT0spQc94R1Qm9I4HKFL4SsPS3jcXkFP
 S4h1UEePgGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLgQAKCRCLPIo+Aiko
 1ZAaCACzofAOfgNI7orNnGiTnhKI3EjUVHZiZwXJBx/HEPWSlnxH05+FQ7+Yl6orLKX4JB07Kxc
 2PSpcbaA3z+OBSSN8QDCr2oRhtA7jsq1Pb5oV8/pSC1z3T0ubvwLxP2HgBEL1CCfxcSF0z7kymL
 oAjsWTpI8Cg55C2auKsCw87E3+akoueogLjzLapXNceGelvPlHXQH9T73qs/VVNOqwtwMLSJxoE
 suqZ8o1uueAlXFlRGQM4em8rLOF+uX303AA0tAqdhbKuwt9yO3WFwx1NGQDqjCBMUPL18zavTFd
 UMCvGc9tCMlhrzMxv3nx3O+F6RHk9RoKUyf7s5V4d1LQ84ud
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfXwcLuZ+d1ZnyE
 5AJrdqumfwYZx4g8ArVen7wDT2KPooxWm2uOdXQ4ygERrhkx3EMHxSqBiWIySj9Qq4eYWWEiJQW
 KvpJslqFhptueLoFLahqdgNBY7J7w/mVeyoMl5RakDEACJH18GCQW++vjFKXFYe8y/UHZj9Sx47
 7GHoe6qnQN1nIzzII+NxpnIPvjZCtzQqyx0LJZ/xDAmiRRrJSur9rwqF0JokhssLEUEASdtiQvn
 RNNi/Ifdpuj+hy7DSHKS48ZwUJi+w464A4zji2x23xIn0LBjb16Ew8pRcEhLdAmbFEW/niGsJBK
 pbYkjlXARch4WTLtY/pepW4hVom0dMNCiTIwNk/lt/7SLY6E31TRqZgtlMroKkI/6aTJCRNP0Qs
 jjfL7bOnHD8aFCiLOe98pWUUhnCSUA==
X-Proofpoint-GUID: biqlBKXgpIKBkrHtdOPha5wpxZ4wwKFK
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cb90 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Ff9FSdKCichPPiV-r7MA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: biqlBKXgpIKBkrHtdOPha5wpxZ4wwKFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sc7280.c | 629 +++++++++++++++++--------------------
 drivers/interconnect/qcom/sc7280.h | 154 ---------
 2 files changed, 287 insertions(+), 496 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 905403a3a930a2e1cd01f62e375e60c6b2d524f7..3dc8b81f917d5de69f67112bd313326b4658f77c 100644
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
@@ -29,12 +170,11 @@ static struct qcom_icc_node qhm_qspi = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SC7280_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -44,12 +184,11 @@ static struct qcom_icc_node qhm_qup0 = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SC7280_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -59,21 +198,19 @@ static struct qcom_icc_node qhm_qup1 = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qnm_a1noc_cfg = {
 	.name = "qnm_a1noc_cfg",
-	.id = SC7280_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SC7280_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -83,12 +220,11 @@ static struct qcom_icc_node xm_sdc1 = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SC7280_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -98,12 +234,11 @@ static struct qcom_icc_node xm_sdc2 = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SC7280_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -113,12 +248,11 @@ static struct qcom_icc_node xm_sdc4 = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SC7280_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -128,21 +262,19 @@ static struct qcom_icc_node xm_ufs_mem = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb2 = {
 	.name = "xm_usb2",
-	.id = SC7280_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SC7280_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -152,12 +284,11 @@ static struct qcom_icc_node xm_usb3_0 = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SC7280_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -167,21 +298,19 @@ static struct qcom_icc_node qhm_qdss_bam = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_a2noc_cfg = {
 	.name = "qnm_a2noc_cfg",
-	.id = SC7280_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
-	.id = SC7280_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -191,12 +320,11 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SC7280_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -206,12 +334,11 @@ static struct qcom_icc_node qxm_crypto = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SC7280_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -221,30 +348,27 @@ static struct qcom_icc_node qxm_ipa = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SC7280_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SC7280_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SC7280_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -254,135 +378,126 @@ static struct qcom_icc_node xm_qdss_etr = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SC7280_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SC7280_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qnm_cnoc3_cnoc2 = {
 	.name = "qnm_cnoc3_cnoc2",
-	.id = SC7280_MASTER_CNOC3_CNOC2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 44,
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
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_compute_cfg, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto0_cfg,
+			&qhs_cx_rdpm, &qhs_dcc_cfg,
+			&qhs_display_cfg, &qhs_gpuss_cfg,
+			&qhs_hwkm, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_lpass_cfg, &qhs_mss_cfg,
+			&qhs_mx_rdpm, &qhs_pcie0_cfg,
+			&qhs_pcie1_cfg, &qhs_pdm,
+			&qhs_pimem_cfg, &qhs_pka_wrapper_cfg,
+			&qhs_pmu_wrapper_cfg, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_sdc2, &qhs_sdc4,
+			&qhs_security, &qhs_tcsr,
+			&qhs_tlmm, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qns_a1_noc_cfg, &qns_a2_noc_cfg,
+			&qns_mnoc_cfg, &qns_snoc_cfg },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SC7280_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 45,
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
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_compute_cfg, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto0_cfg,
+			&qhs_cx_rdpm, &qhs_dcc_cfg,
+			&qhs_display_cfg, &qhs_gpuss_cfg,
+			&qhs_hwkm, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_lpass_cfg, &qhs_mss_cfg,
+			&qhs_mx_rdpm, &qhs_pcie0_cfg,
+			&qhs_pcie1_cfg, &qhs_pdm,
+			&qhs_pimem_cfg, &qhs_pka_wrapper_cfg,
+			&qhs_pmu_wrapper_cfg, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_sdc2, &qhs_sdc4,
+			&qhs_security, &qhs_tcsr,
+			&qhs_tlmm, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qns_a1_noc_cfg, &qns_a2_noc_cfg,
+			&qns_cnoc2_cnoc3, &qns_mnoc_cfg,
+			&qns_snoc_cfg },
 };
 
 static struct qcom_icc_node qnm_cnoc2_cnoc3 = {
 	.name = "qnm_cnoc2_cnoc3",
-	.id = SC7280_MASTER_CNOC2_CNOC3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 9,
-	.links = { SC7280_SLAVE_AOSS, SC7280_SLAVE_APPSS,
-		   SC7280_SLAVE_CNOC_A2NOC, SC7280_SLAVE_DDRSS_CFG,
-		   SC7280_SLAVE_BOOT_IMEM, SC7280_SLAVE_IMEM,
-		   SC7280_SLAVE_PIMEM, SC7280_SLAVE_QDSS_STM,
-		   SC7280_SLAVE_TCU },
+	.link_nodes = { &qhs_aoss, &qhs_apss,
+			&qns_cnoc_a2noc, &qns_ddrss_cfg,
+			&qxs_boot_imem, &qxs_imem,
+			&qxs_pimem, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SC7280_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 9,
-	.links = { SC7280_SLAVE_AOSS, SC7280_SLAVE_APPSS,
-		   SC7280_SLAVE_CNOC3_CNOC2, SC7280_SLAVE_DDRSS_CFG,
-		   SC7280_SLAVE_BOOT_IMEM, SC7280_SLAVE_IMEM,
-		   SC7280_SLAVE_PIMEM, SC7280_SLAVE_QDSS_STM,
-		   SC7280_SLAVE_TCU },
+	.link_nodes = { &qhs_aoss, &qhs_apss,
+			&qns_cnoc3_cnoc2, &qns_ddrss_cfg,
+			&qxs_boot_imem, &qxs_imem,
+			&qxs_pimem, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SC7280_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC7280_SLAVE_PCIE_0, SC7280_SLAVE_PCIE_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
-	.id = SC7280_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SC7280_SLAVE_LLCC_CFG, SC7280_SLAVE_GEM_NOC_CFG },
+	.link_nodes = { &qhs_llcc, &qns_gemnoc },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SC7280_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -392,12 +507,11 @@ static struct qcom_icc_node alm_gpu_tcu = {
 		.urg_fwd = 0,
 	},
 	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SC7280_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -407,22 +521,20 @@ static struct qcom_icc_node alm_sys_tcu = {
 		.urg_fwd = 0,
 	},
 	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SC7280_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
-		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SC7280_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -432,23 +544,21 @@ static struct qcom_icc_node qnm_cmpnoc = {
 		.urg_fwd = 1,
 	},
 	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SC7280_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 5,
-	.links = { SC7280_SLAVE_MSS_PROC_MS_MPU_CFG, SC7280_SLAVE_MCDMA_MS_MPU_CFG,
-		   SC7280_SLAVE_SERVICE_GEM_NOC_1, SC7280_SLAVE_SERVICE_GEM_NOC_2,
-		   SC7280_SLAVE_SERVICE_GEM_NOC },
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg, &qhs_modem_ms_mpu_cfg,
+			&srvc_even_gemnoc, &srvc_odd_gemnoc,
+			&srvc_sys_gemnoc },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SC7280_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -458,12 +568,11 @@ static struct qcom_icc_node qnm_gpu = {
 		.urg_fwd = 0,
 	},
 	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SC7280_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -473,12 +582,11 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SC7280_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -488,21 +596,19 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 		.urg_fwd = 1,
 	},
 	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SC7280_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SC7280_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -512,12 +618,11 @@ static struct qcom_icc_node qnm_snoc_gc = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SC7280_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -527,42 +632,38 @@ static struct qcom_icc_node qnm_snoc_sf = {
 		.urg_fwd = 1,
 	},
 	.num_links = 3,
-	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
-		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SC7280_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 6,
-	.links = { SC7280_SLAVE_LPASS_CORE_CFG, SC7280_SLAVE_LPASS_LPI_CFG,
-		   SC7280_SLAVE_LPASS_MPU_CFG, SC7280_SLAVE_LPASS_TOP_CFG,
-		   SC7280_SLAVE_SERVICES_LPASS_AML_NOC, SC7280_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
+			&qhs_lpass_mpu, &qhs_lpass_top,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SC7280_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qnm_mnoc_cfg = {
 	.name = "qnm_mnoc_cfg",
-	.id = SC7280_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SC7280_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -572,12 +673,11 @@ static struct qcom_icc_node qnm_video0 = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cpu = {
 	.name = "qnm_video_cpu",
-	.id = SC7280_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -587,12 +687,11 @@ static struct qcom_icc_node qnm_video_cpu = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
-	.id = SC7280_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -602,12 +701,11 @@ static struct qcom_icc_node qxm_camnoc_hf = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
-	.id = SC7280_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -617,12 +715,11 @@ static struct qcom_icc_node qxm_camnoc_icp = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SC7280_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -632,12 +729,11 @@ static struct qcom_icc_node qxm_camnoc_sf = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SC7280_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -647,57 +743,51 @@ static struct qcom_icc_node qxm_mdp0 = {
 		.urg_fwd = 1,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SC7280_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SC7280_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SC7280_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SC7280_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SC7280_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SC7280_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -707,12 +797,11 @@ static struct qcom_icc_node qxm_pimem = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SC7280_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &(const struct qcom_icc_qosbox) {
@@ -722,741 +811,585 @@ static struct qcom_icc_node xm_gic = {
 		.urg_fwd = 0,
 	},
 	.num_links = 1,
-	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SC7280_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SC7280_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SC7280_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SC7280_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SC7280_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SC7280_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SC7280_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SC7280_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SC7280_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SC7280_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SC7280_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_compute_cfg = {
 	.name = "qhs_compute_cfg",
-	.id = SC7280_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CDSP_NOC_CFG },
+	.link_nodes = { &qhm_nsp_noc_config },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SC7280_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SC7280_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SC7280_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SC7280_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SC7280_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SC7280_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SC7280_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
-	.id = SC7280_SLAVE_HWKM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SC7280_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SC7280_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SC7280_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SC7280_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SC7280_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SC7280_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SC7280_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SC7280_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SC7280_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SC7280_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pka_wrapper_cfg = {
 	.name = "qhs_pka_wrapper_cfg",
-	.id = SC7280_SLAVE_PKA_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
 	.name = "qhs_pmu_wrapper_cfg",
-	.id = SC7280_SLAVE_PMU_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SC7280_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SC7280_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SC7280_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SC7280_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SC7280_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SC7280_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SC7280_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SC7280_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SC7280_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SC7280_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SC7280_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb2 = {
 	.name = "qhs_usb2",
-	.id = SC7280_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SC7280_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SC7280_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SC7280_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_a1_noc_cfg = {
 	.name = "qns_a1_noc_cfg",
-	.id = SC7280_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_A1NOC_CFG },
+	.link_nodes = { &qnm_a1noc_cfg },
 };
 
 static struct qcom_icc_node qns_a2_noc_cfg = {
 	.name = "qns_a2_noc_cfg",
-	.id = SC7280_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_A2NOC_CFG },
+	.link_nodes = { &qnm_a2noc_cfg },
 };
 
 static struct qcom_icc_node qns_cnoc2_cnoc3 = {
 	.name = "qns_cnoc2_cnoc3",
-	.id = SC7280_SLAVE_CNOC2_CNOC3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC2_CNOC3 },
+	.link_nodes = { &qnm_cnoc2_cnoc3 },
 };
 
 static struct qcom_icc_node qns_mnoc_cfg = {
 	.name = "qns_mnoc_cfg",
-	.id = SC7280_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qnm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SC7280_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SC7280_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SC7280_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_cnoc3_cnoc2 = {
 	.name = "qns_cnoc3_cnoc2",
-	.id = SC7280_SLAVE_CNOC3_CNOC2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC3_CNOC2 },
+	.link_nodes = { &qnm_cnoc3_cnoc2 },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SC7280_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc_datapath },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SC7280_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qnm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = SC7280_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SC7280_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SC7280_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SC7280_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SC7280_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SC7280_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SC7280_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SC7280_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SC7280_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7280_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qnm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SC7280_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_modem_ms_mpu_cfg = {
 	.name = "qhs_modem_ms_mpu_cfg",
-	.id = SC7280_SLAVE_MCDMA_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SC7280_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SC7280_SLAVE_LLCC,
 	.channels = 2,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SC7280_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SC7280_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SC7280_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SC7280_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SC7280_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SC7280_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SC7280_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SC7280_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SC7280_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SC7280_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SC7280_SLAVE_EBI1,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SC7280_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7280_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SC7280_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7280_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SC7280_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SC7280_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7280_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SC7280_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SC7280_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7280_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SC7280_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7280_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SC7280_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1687,6 +1620,7 @@ static const struct regmap_config sc7280_aggre1_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
@@ -1719,6 +1653,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
@@ -1740,6 +1675,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1810,6 +1746,7 @@ static const struct regmap_config sc7280_cnoc2_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc2 = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_cnoc2_regmap_config,
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
@@ -1851,6 +1788,7 @@ static const struct regmap_config sc7280_cnoc3_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_cnoc3 = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_cnoc3_regmap_config,
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
@@ -1876,6 +1814,7 @@ static const struct regmap_config sc7280_dc_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_dc_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
@@ -1921,6 +1860,7 @@ static const struct regmap_config sc7280_gem_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_gem_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1950,6 +1890,7 @@ static const struct regmap_config sc7280_lpass_ag_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1976,6 +1917,7 @@ static const struct regmap_config sc7280_mc_virt_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_mc_virt = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_mc_virt_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
@@ -2012,6 +1954,7 @@ static const struct regmap_config sc7280_mmss_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_mmss_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -2040,6 +1983,7 @@ static const struct regmap_config sc7280_nsp_noc_regmap_config = {
 };
 
 static const struct qcom_icc_desc sc7280_nsp_noc = {
+	.alloc_dyn_id = true,
 	.config = &sc7280_nsp_noc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -2074,6 +2018,7 @@ static const struct regmap_config sc7280_system_noc_regmap_config = {
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
2.47.3


