Return-Path: <linux-pm+bounces-37210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD70C25AE5
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52DB44F5EF2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2D29B78E;
	Fri, 31 Oct 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eldghs3O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcRINvc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1C27FB2D
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921957; cv=none; b=rcN9Kh4ObW6vK4VKkqm5GumNtE7VB6Dc41FZcbjtvCtdb02rUEirCPRht30j4X6a39Qce9+K+ln+b/vv4D4agFp56/Kb+h3y4r7UPe9BFFuXRBOuMoyJ2OK4RsxHPzEpX/fG+TbAnEO0EcBXQqtyfV2fNPR7V5xvwl5EffyhlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921957; c=relaxed/simple;
	bh=+C8IwhjBDXc6M2c+7RSw1HQJDVe9PMGDSdG1eq2Ci3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brEhu0KnFNb50ut4ILcImK6DlRqFzd8vs/wphPKB9neKs6EvlFBvB75tG2cOR4yPrWz6Nj0sQK6c3NuW0GLtIYvgG0G2cUqa77H1A4dz0CZKYyr907icqGuO9/QmDYyJ2YcrGfhm8qHKdpYaWWjbmD7csuF9j1iXX+Vyp76wL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eldghs3O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcRINvc/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VCqRL8102840
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5HAt8OqdciR85q+Z7WMSAmeCMf5A5ZmNrti4Ws0nN6k=; b=eldghs3OPnhlG1l3
	yRCkIiuv4bF3RgTUUGekP6pwTUDtA/vEnOb5f6AdQN1RGUunjpiSJvK6q4mwpxtI
	1IW2x4gBkPffZR40sVsaRIO0jvIZJPv8K0KL951Tcz6MfwSAaUtIY0EoyDFXA08l
	B9pSR63LFG3oS1GhtogsmPpMEYrTEIaxISKryObE1NP44rHYq+pVYCqUMdembKfQ
	v5KqFRt/E3oJSFhfc+N5jFa5TpSC0oQrAW0QAttQKyvxKYiSyBA2s4df5AReOfl1
	M6nym17aMYk2M0eCmgirYH2AzExbmb4GTjRnI+hVintHfU7GHADp943z1ZRZmu+V
	+c4kjw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkfyu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eceefa36d0so55281501cf.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921949; x=1762526749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HAt8OqdciR85q+Z7WMSAmeCMf5A5ZmNrti4Ws0nN6k=;
        b=UcRINvc/ZmfenrYO6/zTslGfC90id4qdipM9n3/eqfKp4xMh76OkY/6t0qwoVUovyl
         YJ+Fpy0MpPNqAMGw76UeW1hmFVA+PHinJOOrjzK4AWtG9I7iC/ujab7UPoV1yzQOXxoZ
         Zm1Vv+6nh9Vq3F5RDuPHRnYl5dkAtbjxh935TMHrGqEgGRlLXYnC4Kx1kIOBZHB509Ks
         VZat/fjbhUcN9+rlabDiJvJJ6cvIL1pLYtwp1rIdOKOvAdksq7j/JfSbtuZ4xMWjsGbQ
         Bj4xqQNS5ReIoWIHppF+i2SI+qKY5UsHpN7MlBc8Z0178soTRqxfMnKpyZWrjHr7hoFK
         VAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921949; x=1762526749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HAt8OqdciR85q+Z7WMSAmeCMf5A5ZmNrti4Ws0nN6k=;
        b=VWmLv717DzswGmHDTIjMjwYojsQdl2LaR49BpA93ZSKB6mlAa5HSncmbckmPm61YCq
         lKlCVcvqdLsSAzY9u3oliaJ8HEnx4EXuc4/ubEO4GK/tCqxfZuX52KzQICw7ma8Xio0g
         C8aObvFGpbbZ71PjQzgSaDwg+I2xE1YBE3jGPRb4ORBa6LkPOdW/DrhSomyUwo670rEN
         lRvT2fIEnASBcEmDH5FUIIFEoT2CyG8IoOthU5UWfN0/sL1m8M/k+UwoKMpI6pW0e7/o
         Cot3oEGmSmZeIK46cCTyN82tuxKPwKJ9UgPPz67cGTu/450VuWlFmRoSNDlrBNlTxcGf
         90PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlsqyUj8UsuSOHOfFJ76co62sZtcZ2y19nUTBIVzlnsf87YEP2cHK5JvkoLA7FOZHG6KtrnORzRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtS5CN5d3kM0Kg70Z+Y5T5p0RDHmd39yz08WdgaLwdgfj4ZsE
	9wmn7oV/y/K0M5EhgVEZm/WIetRl8IOvWfD1RwmVhGz91j1Nm1vu2GtGxQJ9yCSLMF8NnHMxCu1
	EdgREGMKLnWOFBaS3N+bf2zuGLBmfSkYR6KPrLNrvXY3YoIMcCCTaOlT6bcxuSw==
X-Gm-Gg: ASbGncsvWjcMlNN2/AO/iIv+dA+hL5Jp4uWLK2syW0/vjUy8kJLHMGtSxbZBNcJUpkq
	XzLBwWIxJhe/wqHLvnxYHJvAmla7rsNf15G5b8yl/iHgtzSEJe+bPzF4vQyG9y1djR3tzmGVGZd
	Fl2/nBV6QVOmKZmvMTOLu4M4pw/vmYo1BWXRBBzTXhZoKVCS1OE0R0a1YleDLENqcIx2VLru7wD
	oS3DYa5kO181xF8jd537IQol/BRH73kNXZjdGmhDxli+lpNu/XSmgop9zJXJf8ImaNdJR7Tl4z4
	zN3f+xZb7P5AlF2EJ1vnjCB5uMeW7FDw1pg3/5WhzlpM9gZHkYC+XQAh9iD94VQjxWj6iWF1UFZ
	PzIsZ1eLg0xSO1I0sjoL+XYCJBHRfgiMXRv2zb/Y0TKa3jocBGG8VVmDQeG6WpIYWO7lLH8+6hG
	4hWa90EheTRg4v
X-Received: by 2002:a05:622a:4119:b0:4ec:f36e:5129 with SMTP id d75a77b69052e-4ed30dd65b2mr47239101cf.25.1761921948232;
        Fri, 31 Oct 2025 07:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxsc1iAE64L30kXqTe9rDeOxzS2j6GwsThMXVJxBjOQbIX5FprhGfuaxfYPVftosjDH0oNNw==
X-Received: by 2002:a05:622a:4119:b0:4ec:f36e:5129 with SMTP id d75a77b69052e-4ed30dd65b2mr47238371cf.25.1761921947521;
        Fri, 31 Oct 2025 07:45:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:28 +0200
Subject: [PATCH v3 12/25] interconnect: qcom: sc7180: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-12-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=49838;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+C8IwhjBDXc6M2c+7RSw1HQJDVe9PMGDSdG1eq2Ci3g=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGkEy4SjkRKymcdFOFBwzflc4BsIjCu4gz0Y4ztknDop3QOlF
 IkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJpBMuEAAoJEIs8ij4CKSjVPOwIAJbV
 4Aj1aNl7U0SGAON77vyT8pNFxXgeQjwEdEXhp2O7+/333r0VIkQ8s70lduT7rqp0fb4y9eKF1Ur
 NmPdvvolYU/+E5GpC/MprKJmSLUY5nzB8VkFedL3q4faoZfLRyZpFuviP8EPT0gRWtT/HmMD6WE
 lnm388yDBHW3FCPBFLOrWWOgspdZwZUuOvAsRRi/4PsQDw7Q5yHesnRyOqM330/ENU0g10tr1L9
 idSd0m1eYol3bG1Gv5jNqz2OVLibGgqgH28ZEm3yAqJzMP/fs1dRlkNSOaTr6I8+0cu2a+RQjjy
 MRz12qrMbmll7vTxf1r1rMMoiMI+l8wV2G3ZAuw=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX+WIPnN0tEgR4
 3hQxGYF3EUcDCDTFUGapiN1eRoBkpF1H4ZWw7ql87ab44pi4SZflnk0mOqOBtSHoGB/LKH5gp5n
 9/yOLWKi3CJssyMivUsAMnV8KhJlOi1DbnNbC+qWDPTOV1NctuDK/NxKM9zTfrnfOTOONvS1smH
 O8U0nvJUuWu3SgayiQZoWEG8mFZ200PupPF96OINgW1QJo3vqHPryBlYL68p9p2mEEuV0Kk050g
 lp9JPBtuOSzDLdnkDna8mh8FEPOP7JCYue23U66Ik//BnEBGP8PBYwndXFjGX6JJycvrDt0uUj5
 ccx59Qfh2rP2abypRcyhpTbZJnFO9YC+IeWCn3Fw+GlgvyLALgkM+bkX1OoyO08BBd2swYmUieS
 xaFzXB1Z4WehDiWL5k3NpE7/wTb8vw==
X-Proofpoint-GUID: pyZqL9nyIL8GBBUnfPxrHSfsbojGi7bI
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cb9d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=LDT4bjSBCSF81FSiPqYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: pyZqL9nyIL8GBBUnfPxrHSfsbojGi7bI
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
 drivers/interconnect/qcom/sc7180.c | 690 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sc7180.h | 149 --------
 2 files changed, 344 insertions(+), 495 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index af2be15438403e4b46fca464b84abd1e0ebebe76..9f94b987c4448a04dc984ad09b0733c33c9bb76a 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -14,1224 +14,1210 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sc7180.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup_0;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_emmc;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup_1;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node qhm_usb3;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qnm_npu;
+static struct qcom_icc_node qxm_npu_dsp;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc_dc_noc;
+static struct qcom_icc_node acm_apps0;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_gpu;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qxm_camnoc_hf0;
+static struct qcom_icc_node qxm_camnoc_hf1;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qxm_venus0;
+static struct qcom_icc_node qxm_venus_arm9;
+static struct qcom_icc_node amm_npu_sys;
+static struct qcom_icc_node qhm_npu_cfg;
+static struct qcom_icc_node qup_core_master_1;
+static struct qcom_icc_node qup_core_master_2;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qns_cdsp_gemnoc;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_boot_rom;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_camera_nrt_throttle_cfg;
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_display_rt_throttle_cfg;
+static struct qcom_icc_node qhs_display_throttle_cfg;
+static struct qcom_icc_node qhs_emmc_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_npu_cfg;
+static struct qcom_icc_node qhs_npu_dma_throttle_cfg;
+static struct qcom_icc_node qhs_npu_dsp_throttle_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qm_cfg;
+static struct qcom_icc_node qhs_qm_mpu_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_1;
+static struct qcom_icc_node qhs_tlmm_2;
+static struct qcom_icc_node qhs_tlmm_3;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_venus_throttle_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_gemnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_cal_dp0;
+static struct qcom_icc_node qhs_cp;
+static struct qcom_icc_node qhs_dma_bwmon;
+static struct qcom_icc_node qhs_dpm;
+static struct qcom_icc_node qhs_isense;
+static struct qcom_icc_node qhs_llm;
+static struct qcom_icc_node qhs_tcm;
+static struct qcom_icc_node qns_npu_sys;
+static struct qcom_icc_node srvc_noc;
+static struct qcom_icc_node qup_core_slave_1;
+static struct qcom_icc_node qup_core_slave_2;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = SC7180_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SC7180_MASTER_QSPI,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup_0 = {
 	.name = "qhm_qup_0",
-	.id = SC7180_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SC7180_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emmc = {
 	.name = "xm_emmc",
-	.id = SC7180_MASTER_EMMC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SC7180_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SC7180_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SC7180_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup_1 = {
 	.name = "qhm_qup_1",
-	.id = SC7180_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SC7180_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SC7180_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SC7180_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_usb3 = {
 	.name = "qhm_usb3",
-	.id = SC7180_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SC7180_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
 	.name = "qxm_camnoc_hf1_uncomp",
-	.id = SC7180_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SC7180_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SC7180_MASTER_NPU,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc },
 };
 
 static struct qcom_icc_node qxm_npu_dsp = {
 	.name = "qxm_npu_dsp",
-	.id = SC7180_MASTER_NPU_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SC7180_MASTER_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 51,
-	.links = { SC7180_SLAVE_A1NOC_CFG,
-		   SC7180_SLAVE_A2NOC_CFG,
-		   SC7180_SLAVE_AHB2PHY_SOUTH,
-		   SC7180_SLAVE_AHB2PHY_CENTER,
-		   SC7180_SLAVE_AOP,
-		   SC7180_SLAVE_AOSS,
-		   SC7180_SLAVE_BOOT_ROM,
-		   SC7180_SLAVE_CAMERA_CFG,
-		   SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SC7180_SLAVE_CLK_CTL,
-		   SC7180_SLAVE_RBCPR_CX_CFG,
-		   SC7180_SLAVE_RBCPR_MX_CFG,
-		   SC7180_SLAVE_CRYPTO_0_CFG,
-		   SC7180_SLAVE_DCC_CFG,
-		   SC7180_SLAVE_CNOC_DDRSS,
-		   SC7180_SLAVE_DISPLAY_CFG,
-		   SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG,
-		   SC7180_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SC7180_SLAVE_EMMC_CFG,
-		   SC7180_SLAVE_GLM,
-		   SC7180_SLAVE_GFX3D_CFG,
-		   SC7180_SLAVE_IMEM_CFG,
-		   SC7180_SLAVE_IPA_CFG,
-		   SC7180_SLAVE_CNOC_MNOC_CFG,
-		   SC7180_SLAVE_CNOC_MSS,
-		   SC7180_SLAVE_NPU_CFG,
-		   SC7180_SLAVE_NPU_DMA_BWMON_CFG,
-		   SC7180_SLAVE_NPU_PROC_BWMON_CFG,
-		   SC7180_SLAVE_PDM,
-		   SC7180_SLAVE_PIMEM_CFG,
-		   SC7180_SLAVE_PRNG,
-		   SC7180_SLAVE_QDSS_CFG,
-		   SC7180_SLAVE_QM_CFG,
-		   SC7180_SLAVE_QM_MPU_CFG,
-		   SC7180_SLAVE_QSPI_0,
-		   SC7180_SLAVE_QUP_0,
-		   SC7180_SLAVE_QUP_1,
-		   SC7180_SLAVE_SDCC_2,
-		   SC7180_SLAVE_SECURITY,
-		   SC7180_SLAVE_SNOC_CFG,
-		   SC7180_SLAVE_TCSR,
-		   SC7180_SLAVE_TLMM_WEST,
-		   SC7180_SLAVE_TLMM_NORTH,
-		   SC7180_SLAVE_TLMM_SOUTH,
-		   SC7180_SLAVE_UFS_MEM_CFG,
-		   SC7180_SLAVE_USB3,
-		   SC7180_SLAVE_VENUS_CFG,
-		   SC7180_SLAVE_VENUS_THROTTLE_CFG,
-		   SC7180_SLAVE_VSENSE_CTRL_CFG,
-		   SC7180_SLAVE_SERVICE_CNOC
-	},
+	.link_nodes = { &qhs_a1_noc_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_ahb2phy0,
+			&qhs_ahb2phy2,
+			&qhs_aop,
+			&qhs_aoss,
+			&qhs_boot_rom,
+			&qhs_camera_cfg,
+			&qhs_camera_nrt_throttle_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_clk_ctl,
+			&qhs_cpr_cx,
+			&qhs_cpr_mx,
+			&qhs_crypto0_cfg,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_cfg,
+			&qhs_display_rt_throttle_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_emmc_cfg,
+			&qhs_glm,
+			&qhs_gpuss_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mnoc_cfg,
+			&qhs_mss_cfg,
+			&qhs_npu_cfg,
+			&qhs_npu_dma_throttle_cfg,
+			&qhs_npu_dsp_throttle_cfg,
+			&qhs_pdm,
+			&qhs_pimem_cfg,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qm_cfg,
+			&qhs_qm_mpu_cfg,
+			&qhs_qspi,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_sdc2,
+			&qhs_security,
+			&qhs_snoc_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm_1,
+			&qhs_tlmm_2,
+			&qhs_tlmm_3,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3,
+			&qhs_venus_cfg,
+			&qhs_venus_throttle_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&srvc_cnoc },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SC7180_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 51,
-	.links = { SC7180_SLAVE_A1NOC_CFG,
-		   SC7180_SLAVE_A2NOC_CFG,
-		   SC7180_SLAVE_AHB2PHY_SOUTH,
-		   SC7180_SLAVE_AHB2PHY_CENTER,
-		   SC7180_SLAVE_AOP,
-		   SC7180_SLAVE_AOSS,
-		   SC7180_SLAVE_BOOT_ROM,
-		   SC7180_SLAVE_CAMERA_CFG,
-		   SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SC7180_SLAVE_CLK_CTL,
-		   SC7180_SLAVE_RBCPR_CX_CFG,
-		   SC7180_SLAVE_RBCPR_MX_CFG,
-		   SC7180_SLAVE_CRYPTO_0_CFG,
-		   SC7180_SLAVE_DCC_CFG,
-		   SC7180_SLAVE_CNOC_DDRSS,
-		   SC7180_SLAVE_DISPLAY_CFG,
-		   SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG,
-		   SC7180_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SC7180_SLAVE_EMMC_CFG,
-		   SC7180_SLAVE_GLM,
-		   SC7180_SLAVE_GFX3D_CFG,
-		   SC7180_SLAVE_IMEM_CFG,
-		   SC7180_SLAVE_IPA_CFG,
-		   SC7180_SLAVE_CNOC_MNOC_CFG,
-		   SC7180_SLAVE_CNOC_MSS,
-		   SC7180_SLAVE_NPU_CFG,
-		   SC7180_SLAVE_NPU_DMA_BWMON_CFG,
-		   SC7180_SLAVE_NPU_PROC_BWMON_CFG,
-		   SC7180_SLAVE_PDM,
-		   SC7180_SLAVE_PIMEM_CFG,
-		   SC7180_SLAVE_PRNG,
-		   SC7180_SLAVE_QDSS_CFG,
-		   SC7180_SLAVE_QM_CFG,
-		   SC7180_SLAVE_QM_MPU_CFG,
-		   SC7180_SLAVE_QSPI_0,
-		   SC7180_SLAVE_QUP_0,
-		   SC7180_SLAVE_QUP_1,
-		   SC7180_SLAVE_SDCC_2,
-		   SC7180_SLAVE_SECURITY,
-		   SC7180_SLAVE_SNOC_CFG,
-		   SC7180_SLAVE_TCSR,
-		   SC7180_SLAVE_TLMM_WEST,
-		   SC7180_SLAVE_TLMM_NORTH,
-		   SC7180_SLAVE_TLMM_SOUTH,
-		   SC7180_SLAVE_UFS_MEM_CFG,
-		   SC7180_SLAVE_USB3,
-		   SC7180_SLAVE_VENUS_CFG,
-		   SC7180_SLAVE_VENUS_THROTTLE_CFG,
-		   SC7180_SLAVE_VSENSE_CTRL_CFG,
-		   SC7180_SLAVE_SERVICE_CNOC
-	},
+	.link_nodes = { &qhs_a1_noc_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_ahb2phy0,
+			&qhs_ahb2phy2,
+			&qhs_aop,
+			&qhs_aoss,
+			&qhs_boot_rom,
+			&qhs_camera_cfg,
+			&qhs_camera_nrt_throttle_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_clk_ctl,
+			&qhs_cpr_cx,
+			&qhs_cpr_mx,
+			&qhs_crypto0_cfg,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_cfg,
+			&qhs_display_rt_throttle_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_emmc_cfg,
+			&qhs_glm,
+			&qhs_gpuss_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mnoc_cfg,
+			&qhs_mss_cfg,
+			&qhs_npu_cfg,
+			&qhs_npu_dma_throttle_cfg,
+			&qhs_npu_dsp_throttle_cfg,
+			&qhs_pdm,
+			&qhs_pimem_cfg,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qm_cfg,
+			&qhs_qm_mpu_cfg,
+			&qhs_qspi,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_sdc2,
+			&qhs_security,
+			&qhs_snoc_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm_1,
+			&qhs_tlmm_2,
+			&qhs_tlmm_3,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3,
+			&qhs_venus_cfg,
+			&qhs_venus_throttle_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&srvc_cnoc },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SC7180_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_GEM_NOC_CFG,
-		   SC7180_SLAVE_LLCC_CFG
-	},
+	.link_nodes = { &qhs_gemnoc,
+			&qhs_llcc },
 };
 
 static struct qcom_icc_node acm_apps0 = {
 	.name = "acm_apps0",
-	.id = SC7180_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
-		   SC7180_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_snoc,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = SC7180_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
-		   SC7180_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_snoc,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SC7180_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_MSS_PROC_MS_MPU_CFG,
-		   SC7180_SLAVE_SERVICE_GEM_NOC
-	},
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg,
+			&srvc_gemnoc },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SC7180_MASTER_COMPUTE_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
-		   SC7180_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_snoc,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SC7180_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SC7180_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
-		   SC7180_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_snoc,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SC7180_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SC7180_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
-	.id = SC7180_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_GEM_NOC_SNOC,
-		   SC7180_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_gem_noc_snoc,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SC7180_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SC7180_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
-	.id = SC7180_MASTER_CAMNOC_HF0,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
-	.id = SC7180_MASTER_CAMNOC_HF1,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SC7180_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SC7180_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SC7180_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = SC7180_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = SC7180_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node amm_npu_sys = {
 	.name = "amm_npu_sys",
-	.id = SC7180_MASTER_NPU_SYS,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys },
 };
 
 static struct qcom_icc_node qhm_npu_cfg = {
 	.name = "qhm_npu_cfg",
-	.id = SC7180_MASTER_NPU_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 8,
-	.links = { SC7180_SLAVE_NPU_CAL_DP0,
-		   SC7180_SLAVE_NPU_CP,
-		   SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG,
-		   SC7180_SLAVE_NPU_DPM,
-		   SC7180_SLAVE_ISENSE_CFG,
-		   SC7180_SLAVE_NPU_LLM_CFG,
-		   SC7180_SLAVE_NPU_TCM,
-		   SC7180_SLAVE_SERVICE_NPU_NOC
-	},
+	.link_nodes = { &qhs_cal_dp0,
+			&qhs_cp,
+			&qhs_dma_bwmon,
+			&qhs_dpm,
+			&qhs_isense,
+			&qhs_llm,
+			&qhs_tcm,
+			&srvc_noc },
 };
 
 static struct qcom_icc_node qup_core_master_1 = {
 	.name = "qup_core_master_1",
-	.id = SC7180_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup_core_slave_1 },
 };
 
 static struct qcom_icc_node qup_core_master_2 = {
 	.name = "qup_core_master_2",
-	.id = SC7180_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup_core_slave_2 },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SC7180_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SC7180_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 6,
-	.links = { SC7180_SLAVE_APPSS,
-		   SC7180_SLAVE_SNOC_CNOC,
-		   SC7180_SLAVE_SNOC_GEM_NOC_SF,
-		   SC7180_SLAVE_IMEM,
-		   SC7180_SLAVE_PIMEM,
-		   SC7180_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qns_gemnoc_sf,
+			&qxs_imem,
+			&qxs_pimem,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SC7180_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 7,
-	.links = { SC7180_SLAVE_APPSS,
-		   SC7180_SLAVE_SNOC_CNOC,
-		   SC7180_SLAVE_SNOC_GEM_NOC_SF,
-		   SC7180_SLAVE_IMEM,
-		   SC7180_SLAVE_PIMEM,
-		   SC7180_SLAVE_QDSS_STM,
-		   SC7180_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qns_gemnoc_sf,
+			&qxs_imem,
+			&qxs_pimem,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = SC7180_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 6,
-	.links = { SC7180_SLAVE_APPSS,
-		   SC7180_SLAVE_SNOC_CNOC,
-		   SC7180_SLAVE_IMEM,
-		   SC7180_SLAVE_PIMEM,
-		   SC7180_SLAVE_QDSS_STM,
-		   SC7180_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qxs_imem,
+			&qxs_pimem,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SC7180_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC7180_SLAVE_SNOC_GEM_NOC_GC,
-		   SC7180_SLAVE_IMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SC7180_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7180_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SC7180_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SC7180_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7180_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SC7180_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SC7180_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node qns_cdsp_gemnoc = {
 	.name = "qns_cdsp_gemnoc",
-	.id = SC7180_SLAVE_CDSP_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SC7180_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SC7180_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SC7180_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = SC7180_SLAVE_AHB2PHY_CENTER,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SC7180_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SC7180_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_boot_rom = {
 	.name = "qhs_boot_rom",
-	.id = SC7180_SLAVE_BOOT_ROM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SC7180_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
 	.name = "qhs_camera_nrt_throttle_cfg",
-	.id = SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
-	.id = SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SC7180_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SC7180_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SC7180_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SC7180_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SC7180_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SC7180_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SC7180_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display_rt_throttle_cfg = {
 	.name = "qhs_display_rt_throttle_cfg",
-	.id = SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display_throttle_cfg = {
 	.name = "qhs_display_throttle_cfg",
-	.id = SC7180_SLAVE_DISPLAY_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_emmc_cfg = {
 	.name = "qhs_emmc_cfg",
-	.id = SC7180_SLAVE_EMMC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SC7180_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SC7180_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SC7180_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SC7180_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SC7180_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SC7180_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_npu_cfg = {
 	.name = "qhs_npu_cfg",
-	.id = SC7180_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_NPU_NOC_CFG },
+	.link_nodes = { &qhm_npu_cfg },
 };
 
 static struct qcom_icc_node qhs_npu_dma_throttle_cfg = {
 	.name = "qhs_npu_dma_throttle_cfg",
-	.id = SC7180_SLAVE_NPU_DMA_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_npu_dsp_throttle_cfg = {
 	.name = "qhs_npu_dsp_throttle_cfg",
-	.id = SC7180_SLAVE_NPU_PROC_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SC7180_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SC7180_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SC7180_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SC7180_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qm_cfg = {
 	.name = "qhs_qm_cfg",
-	.id = SC7180_SLAVE_QM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qm_mpu_cfg = {
 	.name = "qhs_qm_mpu_cfg",
-	.id = SC7180_SLAVE_QM_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SC7180_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SC7180_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SC7180_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SC7180_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SC7180_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SC7180_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SC7180_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm_1 = {
 	.name = "qhs_tlmm_1",
-	.id = SC7180_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm_2 = {
 	.name = "qhs_tlmm_2",
-	.id = SC7180_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm_3 = {
 	.name = "qhs_tlmm_3",
-	.id = SC7180_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SC7180_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SC7180_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SC7180_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_throttle_cfg = {
 	.name = "qhs_venus_throttle_cfg",
-	.id = SC7180_SLAVE_VENUS_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SC7180_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SC7180_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gemnoc = {
 	.name = "qhs_gemnoc",
-	.id = SC7180_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC7180_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SC7180_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SC7180_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SC7180_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SC7180_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7180_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SC7180_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SC7180_SLAVE_EBI1,
 	.channels = 2,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SC7180_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SC7180_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC7180_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SC7180_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cal_dp0 = {
 	.name = "qhs_cal_dp0",
-	.id = SC7180_SLAVE_NPU_CAL_DP0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cp = {
 	.name = "qhs_cp",
-	.id = SC7180_SLAVE_NPU_CP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dma_bwmon = {
 	.name = "qhs_dma_bwmon",
-	.id = SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dpm = {
 	.name = "qhs_dpm",
-	.id = SC7180_SLAVE_NPU_DPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_isense = {
 	.name = "qhs_isense",
-	.id = SC7180_SLAVE_ISENSE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_llm = {
 	.name = "qhs_llm",
-	.id = SC7180_SLAVE_NPU_LLM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcm = {
 	.name = "qhs_tcm",
-	.id = SC7180_SLAVE_NPU_TCM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_npu_sys = {
 	.name = "qns_npu_sys",
-	.id = SC7180_SLAVE_NPU_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node srvc_noc = {
 	.name = "srvc_noc",
-	.id = SC7180_SLAVE_SERVICE_NPU_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup_core_slave_1 = {
 	.name = "qup_core_slave_1",
-	.id = SC7180_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup_core_slave_2 = {
 	.name = "qup_core_slave_2",
-	.id = SC7180_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SC7180_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SC7180_SLAVE_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_MASTER_SNOC_CNOC },
+	.link_nodes = { &qnm_snoc },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SC7180_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC7180_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SC7180_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC7180_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SC7180_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SC7180_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SC7180_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SC7180_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SC7180_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
@@ -1485,6 +1471,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1508,6 +1495,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1526,6 +1514,7 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_camnoc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1545,6 +1534,7 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1613,6 +1603,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1626,6 +1617,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1654,6 +1646,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1671,6 +1664,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1698,6 +1692,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1719,6 +1714,7 @@ static struct qcom_icc_node * const npu_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_npu_noc = {
+	.alloc_dyn_id = true,
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 };
@@ -1735,6 +1731,7 @@ static struct qcom_icc_node * const qup_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_qup_virt = {
+	.alloc_dyn_id = true,
 	.nodes = qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
 	.bcms = qup_virt_bcms,
@@ -1770,6 +1767,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7180_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
deleted file mode 100644
index 2b718922c10903fbb4f127e9b1d15f99f385c5c5..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sc7180.h
+++ /dev/null
@@ -1,149 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SC7180 interconnect IDs
- *
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SC7180_H
-#define __DRIVERS_INTERCONNECT_QCOM_SC7180_H
-
-#define SC7180_MASTER_APPSS_PROC			0
-#define SC7180_MASTER_SYS_TCU				1
-#define SC7180_MASTER_NPU_SYS				2
-/* 3 was used by MASTER_IPA_CORE, now represented as RPMh clock */
-#define SC7180_MASTER_LLCC				4
-#define SC7180_MASTER_A1NOC_CFG				5
-#define SC7180_MASTER_A2NOC_CFG				6
-#define SC7180_MASTER_CNOC_DC_NOC			7
-#define SC7180_MASTER_GEM_NOC_CFG			8
-#define SC7180_MASTER_CNOC_MNOC_CFG			9
-#define SC7180_MASTER_NPU_NOC_CFG			10
-#define SC7180_MASTER_QDSS_BAM				11
-#define SC7180_MASTER_QSPI				12
-#define SC7180_MASTER_QUP_0				13
-#define SC7180_MASTER_QUP_1				14
-#define SC7180_MASTER_SNOC_CFG				15
-#define SC7180_MASTER_A1NOC_SNOC			16
-#define SC7180_MASTER_A2NOC_SNOC			17
-#define SC7180_MASTER_COMPUTE_NOC			18
-#define SC7180_MASTER_GEM_NOC_SNOC			19
-#define SC7180_MASTER_MNOC_HF_MEM_NOC			20
-#define SC7180_MASTER_MNOC_SF_MEM_NOC			21
-#define SC7180_MASTER_NPU				22
-#define SC7180_MASTER_SNOC_CNOC				23
-#define SC7180_MASTER_SNOC_GC_MEM_NOC			24
-#define SC7180_MASTER_SNOC_SF_MEM_NOC			25
-#define SC7180_MASTER_QUP_CORE_0			26
-#define SC7180_MASTER_QUP_CORE_1			27
-#define SC7180_MASTER_CAMNOC_HF0			28
-#define SC7180_MASTER_CAMNOC_HF1			29
-#define SC7180_MASTER_CAMNOC_HF0_UNCOMP			30
-#define SC7180_MASTER_CAMNOC_HF1_UNCOMP			31
-#define SC7180_MASTER_CAMNOC_SF				32
-#define SC7180_MASTER_CAMNOC_SF_UNCOMP			33
-#define SC7180_MASTER_CRYPTO				34
-#define SC7180_MASTER_GFX3D				35
-#define SC7180_MASTER_IPA				36
-#define SC7180_MASTER_MDP0				37
-#define SC7180_MASTER_NPU_PROC				38
-#define SC7180_MASTER_PIMEM				39
-#define SC7180_MASTER_ROTATOR				40
-#define SC7180_MASTER_VIDEO_P0				41
-#define SC7180_MASTER_VIDEO_PROC			42
-#define SC7180_MASTER_QDSS_DAP				43
-#define SC7180_MASTER_QDSS_ETR				44
-#define SC7180_MASTER_SDCC_2				45
-#define SC7180_MASTER_UFS_MEM				46
-#define SC7180_MASTER_USB3				47
-#define SC7180_MASTER_EMMC				48
-#define SC7180_SLAVE_EBI1				49
-/* 50 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SC7180_SLAVE_A1NOC_CFG				51
-#define SC7180_SLAVE_A2NOC_CFG				52
-#define SC7180_SLAVE_AHB2PHY_SOUTH			53
-#define SC7180_SLAVE_AHB2PHY_CENTER			54
-#define SC7180_SLAVE_AOP				55
-#define SC7180_SLAVE_AOSS				56
-#define SC7180_SLAVE_APPSS				57
-#define SC7180_SLAVE_BOOT_ROM				58
-#define SC7180_SLAVE_NPU_CAL_DP0			59
-#define SC7180_SLAVE_CAMERA_CFG				60
-#define SC7180_SLAVE_CAMERA_NRT_THROTTLE_CFG		61
-#define SC7180_SLAVE_CAMERA_RT_THROTTLE_CFG		62
-#define SC7180_SLAVE_CLK_CTL				63
-#define SC7180_SLAVE_NPU_CP				64
-#define SC7180_SLAVE_RBCPR_CX_CFG			65
-#define SC7180_SLAVE_RBCPR_MX_CFG			66
-#define SC7180_SLAVE_CRYPTO_0_CFG			67
-#define SC7180_SLAVE_DCC_CFG				68
-#define SC7180_SLAVE_CNOC_DDRSS				69
-#define SC7180_SLAVE_DISPLAY_CFG			70
-#define SC7180_SLAVE_DISPLAY_RT_THROTTLE_CFG		71
-#define SC7180_SLAVE_DISPLAY_THROTTLE_CFG		72
-#define SC7180_SLAVE_NPU_INT_DMA_BWMON_CFG		73
-#define SC7180_SLAVE_NPU_DPM				74
-#define SC7180_SLAVE_EMMC_CFG				75
-#define SC7180_SLAVE_GEM_NOC_CFG			76
-#define SC7180_SLAVE_GLM				77
-#define SC7180_SLAVE_GFX3D_CFG				78
-#define SC7180_SLAVE_IMEM_CFG				79
-#define SC7180_SLAVE_IPA_CFG				80
-#define SC7180_SLAVE_ISENSE_CFG				81
-#define SC7180_SLAVE_LLCC_CFG				82
-#define SC7180_SLAVE_NPU_LLM_CFG			83
-#define SC7180_SLAVE_MSS_PROC_MS_MPU_CFG		84
-#define SC7180_SLAVE_CNOC_MNOC_CFG			85
-#define SC7180_SLAVE_CNOC_MSS				86
-#define SC7180_SLAVE_NPU_CFG				87
-#define SC7180_SLAVE_NPU_DMA_BWMON_CFG			88
-#define SC7180_SLAVE_NPU_PROC_BWMON_CFG			89
-#define SC7180_SLAVE_PDM				90
-#define SC7180_SLAVE_PIMEM_CFG				91
-#define SC7180_SLAVE_PRNG				92
-#define SC7180_SLAVE_QDSS_CFG				93
-#define SC7180_SLAVE_QM_CFG				94
-#define SC7180_SLAVE_QM_MPU_CFG				95
-#define SC7180_SLAVE_QSPI_0				96
-#define SC7180_SLAVE_QUP_0				97
-#define SC7180_SLAVE_QUP_1				98
-#define SC7180_SLAVE_SDCC_2				99
-#define SC7180_SLAVE_SECURITY				100
-#define SC7180_SLAVE_SNOC_CFG				101
-#define SC7180_SLAVE_NPU_TCM				102
-#define SC7180_SLAVE_TCSR				103
-#define SC7180_SLAVE_TLMM_WEST				104
-#define SC7180_SLAVE_TLMM_NORTH				105
-#define SC7180_SLAVE_TLMM_SOUTH				106
-#define SC7180_SLAVE_UFS_MEM_CFG			107
-#define SC7180_SLAVE_USB3				108
-#define SC7180_SLAVE_VENUS_CFG				109
-#define SC7180_SLAVE_VENUS_THROTTLE_CFG			110
-#define SC7180_SLAVE_VSENSE_CTRL_CFG			111
-#define SC7180_SLAVE_A1NOC_SNOC				112
-#define SC7180_SLAVE_A2NOC_SNOC				113
-#define SC7180_SLAVE_CAMNOC_UNCOMP			114
-#define SC7180_SLAVE_CDSP_GEM_NOC			115
-#define SC7180_SLAVE_SNOC_CNOC				116
-#define SC7180_SLAVE_GEM_NOC_SNOC			117
-#define SC7180_SLAVE_SNOC_GEM_NOC_GC			118
-#define SC7180_SLAVE_SNOC_GEM_NOC_SF			119
-#define SC7180_SLAVE_LLCC				120
-#define SC7180_SLAVE_MNOC_HF_MEM_NOC			121
-#define SC7180_SLAVE_MNOC_SF_MEM_NOC			122
-#define SC7180_SLAVE_NPU_COMPUTE_NOC			123
-#define SC7180_SLAVE_QUP_CORE_0				124
-#define SC7180_SLAVE_QUP_CORE_1				125
-#define SC7180_SLAVE_IMEM				126
-#define SC7180_SLAVE_PIMEM				127
-#define SC7180_SLAVE_SERVICE_A1NOC			128
-#define SC7180_SLAVE_SERVICE_A2NOC			129
-#define SC7180_SLAVE_SERVICE_CNOC			130
-#define SC7180_SLAVE_SERVICE_GEM_NOC			131
-#define SC7180_SLAVE_SERVICE_MNOC			132
-#define SC7180_SLAVE_SERVICE_NPU_NOC			133
-#define SC7180_SLAVE_SERVICE_SNOC			134
-#define SC7180_SLAVE_QDSS_STM				135
-#define SC7180_SLAVE_TCU				136
-
-#endif

-- 
2.47.3


