Return-Path: <linux-pm+bounces-37209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F7C25AE2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73B444F482E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D6296BC2;
	Fri, 31 Oct 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUjYChbr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VpUkdIrW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0B27F4C7
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921956; cv=none; b=gBMJ2pm6W79f6kINURiEkRTZSZQdxMkBLG2N036EiG9SojIUcF/FrjX16gEs7N8c0XdzF/eHd5ZRq3uEyV87F7fOIqLSd6enx7+nmvTCQ8muq6YRKUgit2fU7LX3+j6gTGjgZwTIHSur24T1JxYOJno/j6ke1kKYq8EipIqZ9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921956; c=relaxed/simple;
	bh=+Z1cqenfgqhA/rn7/ywt+zbtXZ02TEAV2U7wLBZfmNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFNbdDieq3qv3ycjqiGytZ3MaVv5YtenyRDrKdmj4m4ucHQHSXjOhTXcKKgixxZmc+FBV9E99HPmBAKBMOqEDpPDf4vHo2+zm3hgji47MW67GxM/DJLLlHKgAlYtjgapIpZfXNM+/55u1SsycKOo80AH1UXMK4U8rSrJYFUvcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OUjYChbr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VpUkdIrW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V7ugcK832459
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dux+zn8xQAq4yCWXi0Yp75fgDLbXimSCDiZJ2TidwJU=; b=OUjYChbr73dz0u2b
	gKiShT5XzARYjf2aoXetx9aqPP5pRwj1YJLDtr9BiI/qrBpMwR7/l43DrLFQaXIC
	iLXhxw7b0dUIel1GDexZU1AliUtK/+/FaT6r8NRUB1lJQjj+fDvvpAPkp/yFWYUg
	iIjwelYkXNrUP4WbaXOra6hX/CptH5cWbnC59hcI8m4ieoGXpAN67jSyjt6HwdNX
	83q42btVK0VQfvlMHdCfHJvirZPxpre3NGQ70wZzv54N3TwY4LameE6fbprGWDK8
	9yXKcy5FlK+5uLWAGUcMNlIYu5HgVEeiMwok6s2Nc8Y/HVXAifCSSHtOQGauaHk9
	YZg1yg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb2hdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8bb155690so26329111cf.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921947; x=1762526747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dux+zn8xQAq4yCWXi0Yp75fgDLbXimSCDiZJ2TidwJU=;
        b=VpUkdIrWV03a0NaUZJPqUwM2QR2AcsIWUMtOleLJ5YGG64Aam6ePl0S4B4TyPAmNKg
         uiZgjspDX6IIXdi2ngkYAhpDtGaoMWbMgYs6En5jrwDxjksrjqJLAERoHWuuRlthNAJ5
         dyutZara90SxtSw0nWFpmWE3yO/ZwX3SGZTc5zONXF7gPFIKFOmz4gm6/LVjNgN8mKXi
         CfclXITdF9/2KVN8ORAAbx0+6CdOn6h+scDFTWhcqOjQ0n1ppFsjOVwGzRLCLtrojT4b
         mmVFugfCFRnCfYePbhFErdzzubJZgL5YPft3lhCTuW6YiMPuLS+TcQbzRs4CY3xGU8s2
         ZTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921947; x=1762526747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dux+zn8xQAq4yCWXi0Yp75fgDLbXimSCDiZJ2TidwJU=;
        b=GYlK/CHz4u30Ed4uqaDcdkJ3NKTZ0kA1+pTwCy/D1dP6rwBH6L0Sz/tS47JDqheAPP
         fuON6XJeACH4EzG6r27C4QOLV3bWJ51a5bLNNqcX1g4Sc/BfpnK5R8BNcsIJLHx6v1Uu
         1OJ6Y3cSfarNcc/sfDUeMeu3B/GpSGcR5JJYlxkVZ7AW3gKbpXzY94JjNT8rJVDV7tnL
         vG3HBJz+PoYQIw3ikD3iq62mZ3E59DNORcjMKaRGKwo+a5/2ybJ15LFDcKd5buubGfqt
         RLVjPeRnhsEw3OBzWyhvSfUgTqbj8YQB5id5tGWda4FzqZIQWPSRVijQVZnbTomdgsNW
         KRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVtgjBGY2QzPvp+Qno2AaisVWtD5R+zcStN3qNySUqXaLSEUQPbJ1g9wBm9hG/I/DOGtA0cGR4/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGOLtpvDp99pAZq0+y/sn7SQP4hKakFaSQ9CslQHRRaVb+6ux
	MtWIPVlyg1A0wbX7UwV7vdA+oJm+B0ONu6CiTfQtqpV8Z2C5obHkbTA064KyDe6mtfQKUxqDk1c
	hP0863C/QfkRZRexrxnlPsC2xlkdld60Br0nZ2TcRg+QtPDz0MuuYDN0r8TIMpKwiF+5v1w==
X-Gm-Gg: ASbGncu7NIPrscDvX3cIV2uAGrEdxlAuL59V1u8f0Vy8OVQ84Mr9M8dq4F2Wy+tVLaz
	SksAAbZi73su79p0O0DJR3Pgbry8nyeMeKETHRLbx6kQzBkgaypga59f3jfjsF2OGZbPzxvOp9/
	trw+fuLtNU9o25aA8uGDDjFfzM9QH820p9dl0gkUDd0pztZ8kBx1dNlnuzjqFlRn0unwgXbOz9J
	IKd7ntaLWasrvtybwrqN6Pq3hlju+hln8Aa/w9BIaOJ/1Zu0ZExD8Ob+7ZgO+RuZ7EEvOW2dXZ0
	trPclnev9cJUojcZnWpOmfJjPj+8/coOjX4pVlUI87a8AVXNyUeWtgiHF3D8xDMHgwCjIQhMRrj
	RoobYYps30ldK99pgEa59vPwXdPItWNaLaRa8ey8HXqm0ygwg5i5L1+K8We2+XPbd5OiOcXoECJ
	4Nug77hKm7YyUc
X-Received: by 2002:ac8:5987:0:b0:4e8:a850:e7db with SMTP id d75a77b69052e-4ed3107fd38mr46647031cf.71.1761921946948;
        Fri, 31 Oct 2025 07:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMVKznv+vztxj1m8DS2RJMs1D/vlQVmog+rXGYlsOfYpzp8L7KT12P4Zlq/VrfFRy4Ehga3Q==
X-Received: by 2002:ac8:5987:0:b0:4e8:a850:e7db with SMTP id d75a77b69052e-4ed3107fd38mr46646381cf.71.1761921946241;
        Fri, 31 Oct 2025 07:45:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:27 +0200
Subject: [PATCH v3 11/25] interconnect: qcom: sar2130p: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-11-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=48200;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+Z1cqenfgqhA/rn7/ywt+zbtXZ02TEAV2U7wLBZfmNw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuE15s+8xx06bMdke1P+NhZKXsltqoyDwxhN
 sjE68teTpGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLhAAKCRCLPIo+Aiko
 1eczB/4u5D7Ce1fmpDckqwqlLEYrId2x45NS/bt4xvdVxXYODhlwSbJhtbb4upZ2cNgatCPozOL
 uGDJ1+5xDZy3+S9bzsN51SSa+HXtOvoX5sLa7o1J+QHzDkdkrm4G0/2gS8cMmf3UnNwh4NItPLx
 5JDUZOsrQ+lHHp76dMu/CsWauMV0t0U4smuUi2dnEM/EgfsnMr1f3m+FxUkKIJdUuvgSoBPFwUr
 Pj/rgL6kvNSYU6YyeODIa3vFQcqumZsP+9Wl2NBynhBXiSOhmzjtLdWx+I0r/wAYeG5MZp9f1zi
 KGIBHWrIRbpJlR/mR/queGdIfGJsiEFie4i43z2cNFm/UsDd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: RJdDCn3Wv_VVDKNPBawyKIXuB7Zpn9dr
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=6904cb9c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5dq9NBdq3jRoY9AzvBUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: RJdDCn3Wv_VVDKNPBawyKIXuB7Zpn9dr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX3ZpVk3C0mN+g
 wmI7ee8HFh65tWTJTII4x+eVJaoyL3w3I0HkxJHQKOiG2dRdwx+x0TbVLcdYuHD6YsulnH9D2bD
 ro7iuIcbAt1NnhwRo+t5vvj7XXhH0dVXUyRwQi4ware0I4zFHdTWRBN9TbmqoCR+GeWRomVC6Od
 EHl7cMRfQ1dMRlDQFy6P2vyS0k2190Jeuirqtush1IJ0qklyVGXcscWGSagSlRPA+G4RVwwtkkp
 SNJutz7BPLypV2vc7ehnT1ws9Rs5rGPUfZ2GueQSF0dYEv5w2KEalvGW1WZLes5pdP+V05gtHYs
 jaF4PCg1kcRt012mZoP847PHDJ+IxlGX+CVZJbmp5QvboN6dBOUzjlNHqmhqGSK38RkFHuKNOYr
 VM9XQ49jLHBPG/Nh7If2ZyW8DwWTBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sar2130p.c | 639 +++++++++++++----------------------
 1 file changed, 238 insertions(+), 401 deletions(-)

diff --git a/drivers/interconnect/qcom/sar2130p.c b/drivers/interconnect/qcom/sar2130p.c
index 9eac0ac7681273d6f4350f4431b81ce94dbada3f..a0b04929058f7e92a60e441b2cc82ee8984daf41 100644
--- a/drivers/interconnect/qcom/sar2130p.c
+++ b/drivers/interconnect/qcom/sar2130p.c
@@ -20,125 +20,123 @@
 #include "icc-common.h"
 #include "icc-rpmh.h"
 
-enum {
-	SAR2130P_MASTER_QUP_CORE_0,
-	SAR2130P_MASTER_QUP_CORE_1,
-	SAR2130P_MASTER_GEM_NOC_CNOC,
-	SAR2130P_MASTER_GEM_NOC_PCIE_SNOC,
-	SAR2130P_MASTER_QDSS_DAP,
-	SAR2130P_MASTER_GPU_TCU,
-	SAR2130P_MASTER_SYS_TCU,
-	SAR2130P_MASTER_APPSS_PROC,
-	SAR2130P_MASTER_GFX3D,
-	SAR2130P_MASTER_MNOC_HF_MEM_NOC,
-	SAR2130P_MASTER_MNOC_SF_MEM_NOC,
-	SAR2130P_MASTER_COMPUTE_NOC,
-	SAR2130P_MASTER_ANOC_PCIE_GEM_NOC,
-	SAR2130P_MASTER_SNOC_GC_MEM_NOC,
-	SAR2130P_MASTER_SNOC_SF_MEM_NOC,
-	SAR2130P_MASTER_WLAN_Q6,
-	SAR2130P_MASTER_CNOC_LPASS_AG_NOC,
-	SAR2130P_MASTER_LPASS_PROC,
-	SAR2130P_MASTER_LLCC,
-	SAR2130P_MASTER_CAMNOC_HF,
-	SAR2130P_MASTER_CAMNOC_ICP,
-	SAR2130P_MASTER_CAMNOC_SF,
-	SAR2130P_MASTER_LSR,
-	SAR2130P_MASTER_MDP,
-	SAR2130P_MASTER_CNOC_MNOC_CFG,
-	SAR2130P_MASTER_VIDEO,
-	SAR2130P_MASTER_VIDEO_CV_PROC,
-	SAR2130P_MASTER_VIDEO_PROC,
-	SAR2130P_MASTER_VIDEO_V_PROC,
-	SAR2130P_MASTER_CDSP_NOC_CFG,
-	SAR2130P_MASTER_CDSP_PROC,
-	SAR2130P_MASTER_PCIE_0,
-	SAR2130P_MASTER_PCIE_1,
-	SAR2130P_MASTER_GIC_AHB,
-	SAR2130P_MASTER_QDSS_BAM,
-	SAR2130P_MASTER_QSPI_0,
-	SAR2130P_MASTER_QUP_0,
-	SAR2130P_MASTER_QUP_1,
-	SAR2130P_MASTER_A2NOC_SNOC,
-	SAR2130P_MASTER_CNOC_DATAPATH,
-	SAR2130P_MASTER_LPASS_ANOC,
-	SAR2130P_MASTER_SNOC_CFG,
-	SAR2130P_MASTER_CRYPTO,
-	SAR2130P_MASTER_PIMEM,
-	SAR2130P_MASTER_GIC,
-	SAR2130P_MASTER_QDSS_ETR,
-	SAR2130P_MASTER_QDSS_ETR_1,
-	SAR2130P_MASTER_SDCC_1,
-	SAR2130P_MASTER_USB3_0,
-	SAR2130P_SLAVE_QUP_CORE_0,
-	SAR2130P_SLAVE_QUP_CORE_1,
-	SAR2130P_SLAVE_AHB2PHY_SOUTH,
-	SAR2130P_SLAVE_AOSS,
-	SAR2130P_SLAVE_CAMERA_CFG,
-	SAR2130P_SLAVE_CLK_CTL,
-	SAR2130P_SLAVE_CDSP_CFG,
-	SAR2130P_SLAVE_RBCPR_CX_CFG,
-	SAR2130P_SLAVE_RBCPR_MMCX_CFG,
-	SAR2130P_SLAVE_RBCPR_MXA_CFG,
-	SAR2130P_SLAVE_RBCPR_MXC_CFG,
-	SAR2130P_SLAVE_CPR_NSPCX,
-	SAR2130P_SLAVE_CRYPTO_0_CFG,
-	SAR2130P_SLAVE_CX_RDPM,
-	SAR2130P_SLAVE_DISPLAY_CFG,
-	SAR2130P_SLAVE_GFX3D_CFG,
-	SAR2130P_SLAVE_IMEM_CFG,
-	SAR2130P_SLAVE_IPC_ROUTER_CFG,
-	SAR2130P_SLAVE_LPASS,
-	SAR2130P_SLAVE_MX_RDPM,
-	SAR2130P_SLAVE_PCIE_0_CFG,
-	SAR2130P_SLAVE_PCIE_1_CFG,
-	SAR2130P_SLAVE_PDM,
-	SAR2130P_SLAVE_PIMEM_CFG,
-	SAR2130P_SLAVE_PRNG,
-	SAR2130P_SLAVE_QDSS_CFG,
-	SAR2130P_SLAVE_QSPI_0,
-	SAR2130P_SLAVE_QUP_0,
-	SAR2130P_SLAVE_QUP_1,
-	SAR2130P_SLAVE_SDCC_1,
-	SAR2130P_SLAVE_TCSR,
-	SAR2130P_SLAVE_TLMM,
-	SAR2130P_SLAVE_TME_CFG,
-	SAR2130P_SLAVE_USB3_0,
-	SAR2130P_SLAVE_VENUS_CFG,
-	SAR2130P_SLAVE_VSENSE_CTRL_CFG,
-	SAR2130P_SLAVE_WLAN_Q6_CFG,
-	SAR2130P_SLAVE_DDRSS_CFG,
-	SAR2130P_SLAVE_CNOC_MNOC_CFG,
-	SAR2130P_SLAVE_SNOC_CFG,
-	SAR2130P_SLAVE_IMEM,
-	SAR2130P_SLAVE_PIMEM,
-	SAR2130P_SLAVE_SERVICE_CNOC,
-	SAR2130P_SLAVE_PCIE_0,
-	SAR2130P_SLAVE_PCIE_1,
-	SAR2130P_SLAVE_QDSS_STM,
-	SAR2130P_SLAVE_TCU,
-	SAR2130P_SLAVE_GEM_NOC_CNOC,
-	SAR2130P_SLAVE_LLCC,
-	SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC,
-	SAR2130P_SLAVE_LPASS_CORE_CFG,
-	SAR2130P_SLAVE_LPASS_LPI_CFG,
-	SAR2130P_SLAVE_LPASS_MPU_CFG,
-	SAR2130P_SLAVE_LPASS_TOP_CFG,
-	SAR2130P_SLAVE_LPASS_SNOC,
-	SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC,
-	SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC,
-	SAR2130P_SLAVE_EBI1,
-	SAR2130P_SLAVE_MNOC_HF_MEM_NOC,
-	SAR2130P_SLAVE_MNOC_SF_MEM_NOC,
-	SAR2130P_SLAVE_SERVICE_MNOC,
-	SAR2130P_SLAVE_CDSP_MEM_NOC,
-	SAR2130P_SLAVE_SERVICE_NSP_NOC,
-	SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC,
-	SAR2130P_SLAVE_A2NOC_SNOC,
-	SAR2130P_SLAVE_SNOC_GEM_NOC_GC,
-	SAR2130P_SLAVE_SNOC_GEM_NOC_SF,
-	SAR2130P_SLAVE_SERVICE_SNOC,
-};
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_nsp_gemnoc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_wlan_q6;
+static struct qcom_icc_node qhm_config_noc;
+static struct qcom_icc_node qxm_lpass_dsp;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_lsr;
+static struct qcom_icc_node qnm_mdp;
+static struct qcom_icc_node qnm_mnoc_cfg;
+static struct qcom_icc_node qnm_video;
+static struct qcom_icc_node qnm_video_cv_cpu;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qhm_nsp_noc_config;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_cnoc_datapath;
+static struct qcom_icc_node qnm_lpass_noc;
+static struct qcom_icc_node qnm_snoc_cfg;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mxa;
+static struct qcom_icc_node qhs_cpr_mxc;
+static struct qcom_icc_node qhs_cpr_nspcx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_lpass_cfg;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qhs_wlan_q6;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_mnoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node qhs_lpass_core;
+static struct qcom_icc_node qhs_lpass_lpi;
+static struct qcom_icc_node qhs_lpass_mpu;
+static struct qcom_icc_node qhs_lpass_top;
+static struct qcom_icc_node qns_sysnoc;
+static struct qcom_icc_node srvc_niu_aml_noc;
+static struct qcom_icc_node srvc_niu_lpass_agnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node service_nsp_noc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node srvc_snoc;
 
 static const struct regmap_config icc_regmap_config = {
 	.reg_bits = 32,
@@ -149,89 +147,84 @@ static const struct regmap_config icc_regmap_config = {
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SAR2130P_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SAR2130P_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SAR2130P_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 43,
-	.links = { SAR2130P_SLAVE_AHB2PHY_SOUTH, SAR2130P_SLAVE_AOSS,
-		   SAR2130P_SLAVE_CAMERA_CFG, SAR2130P_SLAVE_CLK_CTL,
-		   SAR2130P_SLAVE_CDSP_CFG, SAR2130P_SLAVE_RBCPR_CX_CFG,
-		   SAR2130P_SLAVE_RBCPR_MMCX_CFG, SAR2130P_SLAVE_RBCPR_MXA_CFG,
-		   SAR2130P_SLAVE_RBCPR_MXC_CFG, SAR2130P_SLAVE_CPR_NSPCX,
-		   SAR2130P_SLAVE_CRYPTO_0_CFG, SAR2130P_SLAVE_CX_RDPM,
-		   SAR2130P_SLAVE_DISPLAY_CFG, SAR2130P_SLAVE_GFX3D_CFG,
-		   SAR2130P_SLAVE_IMEM_CFG, SAR2130P_SLAVE_IPC_ROUTER_CFG,
-		   SAR2130P_SLAVE_LPASS, SAR2130P_SLAVE_MX_RDPM,
-		   SAR2130P_SLAVE_PCIE_0_CFG, SAR2130P_SLAVE_PCIE_1_CFG,
-		   SAR2130P_SLAVE_PDM, SAR2130P_SLAVE_PIMEM_CFG,
-		   SAR2130P_SLAVE_PRNG, SAR2130P_SLAVE_QDSS_CFG,
-		   SAR2130P_SLAVE_QSPI_0, SAR2130P_SLAVE_QUP_0,
-		   SAR2130P_SLAVE_QUP_1, SAR2130P_SLAVE_SDCC_1,
-		   SAR2130P_SLAVE_TCSR, SAR2130P_SLAVE_TLMM,
-		   SAR2130P_SLAVE_TME_CFG, SAR2130P_SLAVE_USB3_0,
-		   SAR2130P_SLAVE_VENUS_CFG, SAR2130P_SLAVE_VSENSE_CTRL_CFG,
-		   SAR2130P_SLAVE_WLAN_Q6_CFG, SAR2130P_SLAVE_DDRSS_CFG,
-		   SAR2130P_SLAVE_CNOC_MNOC_CFG, SAR2130P_SLAVE_SNOC_CFG,
-		   SAR2130P_SLAVE_IMEM, SAR2130P_SLAVE_PIMEM,
-		   SAR2130P_SLAVE_SERVICE_CNOC, SAR2130P_SLAVE_QDSS_STM,
-		   SAR2130P_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_aoss,
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_compute_cfg, &qhs_cpr_cx,
+			&qhs_cpr_mmcx, &qhs_cpr_mxa,
+			&qhs_cpr_mxc, &qhs_cpr_nspcx,
+			&qhs_crypto0_cfg, &qhs_cx_rdpm,
+			&qhs_display_cfg, &qhs_gpuss_cfg,
+			&qhs_imem_cfg, &qhs_ipc_router,
+			&qhs_lpass_cfg, &qhs_mx_rdpm,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pdm, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tme_cfg, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qhs_wlan_q6, &qns_ddrss_cfg,
+			&qns_mnoc_cfg, &qns_snoc_cfg,
+			&qxs_imem, &qxs_pimem,
+			&srvc_cnoc, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SAR2130P_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_PCIE_0, SAR2130P_SLAVE_PCIE_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SAR2130P_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 43,
-	.links = { SAR2130P_SLAVE_AHB2PHY_SOUTH, SAR2130P_SLAVE_AOSS,
-		   SAR2130P_SLAVE_CAMERA_CFG, SAR2130P_SLAVE_CLK_CTL,
-		   SAR2130P_SLAVE_CDSP_CFG, SAR2130P_SLAVE_RBCPR_CX_CFG,
-		   SAR2130P_SLAVE_RBCPR_MMCX_CFG, SAR2130P_SLAVE_RBCPR_MXA_CFG,
-		   SAR2130P_SLAVE_RBCPR_MXC_CFG, SAR2130P_SLAVE_CPR_NSPCX,
-		   SAR2130P_SLAVE_CRYPTO_0_CFG, SAR2130P_SLAVE_CX_RDPM,
-		   SAR2130P_SLAVE_DISPLAY_CFG, SAR2130P_SLAVE_GFX3D_CFG,
-		   SAR2130P_SLAVE_IMEM_CFG, SAR2130P_SLAVE_IPC_ROUTER_CFG,
-		   SAR2130P_SLAVE_LPASS, SAR2130P_SLAVE_MX_RDPM,
-		   SAR2130P_SLAVE_PCIE_0_CFG, SAR2130P_SLAVE_PCIE_1_CFG,
-		   SAR2130P_SLAVE_PDM, SAR2130P_SLAVE_PIMEM_CFG,
-		   SAR2130P_SLAVE_PRNG, SAR2130P_SLAVE_QDSS_CFG,
-		   SAR2130P_SLAVE_QSPI_0, SAR2130P_SLAVE_QUP_0,
-		   SAR2130P_SLAVE_QUP_1, SAR2130P_SLAVE_SDCC_1,
-		   SAR2130P_SLAVE_TCSR, SAR2130P_SLAVE_TLMM,
-		   SAR2130P_SLAVE_TME_CFG, SAR2130P_SLAVE_USB3_0,
-		   SAR2130P_SLAVE_VENUS_CFG, SAR2130P_SLAVE_VSENSE_CTRL_CFG,
-		   SAR2130P_SLAVE_WLAN_Q6_CFG, SAR2130P_SLAVE_DDRSS_CFG,
-		   SAR2130P_SLAVE_CNOC_MNOC_CFG, SAR2130P_SLAVE_SNOC_CFG,
-		   SAR2130P_SLAVE_IMEM, SAR2130P_SLAVE_PIMEM,
-		   SAR2130P_SLAVE_SERVICE_CNOC, SAR2130P_SLAVE_QDSS_STM,
-		   SAR2130P_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_aoss,
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_compute_cfg, &qhs_cpr_cx,
+			&qhs_cpr_mmcx, &qhs_cpr_mxa,
+			&qhs_cpr_mxc, &qhs_cpr_nspcx,
+			&qhs_crypto0_cfg, &qhs_cx_rdpm,
+			&qhs_display_cfg, &qhs_gpuss_cfg,
+			&qhs_imem_cfg, &qhs_ipc_router,
+			&qhs_lpass_cfg, &qhs_mx_rdpm,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pdm, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tme_cfg, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qhs_wlan_q6, &qns_ddrss_cfg,
+			&qns_mnoc_cfg, &qns_snoc_cfg,
+			&qxs_imem, &qxs_pimem,
+			&srvc_cnoc, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
@@ -244,12 +237,11 @@ static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SAR2130P_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &alm_gpu_tcu_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
@@ -262,22 +254,20 @@ static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SAR2130P_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &alm_sys_tcu_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SAR2130P_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC,
-		   SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static const struct qcom_icc_qosbox qnm_gpu_qos = {
@@ -290,12 +280,11 @@ static const struct qcom_icc_qosbox qnm_gpu_qos = {
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SAR2130P_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_gpu_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
@@ -307,12 +296,11 @@ static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SAR2130P_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_mnoc_hf_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
@@ -324,12 +312,11 @@ static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SAR2130P_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &qnm_mnoc_sf_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
@@ -342,12 +329,11 @@ static const struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
 
 static struct qcom_icc_node qnm_nsp_gemnoc = {
 	.name = "qnm_nsp_gemnoc",
-	.id = SAR2130P_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_nsp_gemnoc_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox qnm_pcie_qos = {
@@ -359,12 +345,11 @@ static const struct qcom_icc_qosbox qnm_pcie_qos = {
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SAR2130P_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &qnm_pcie_qos,
 	.num_links = 2,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox qnm_snoc_gc_qos = {
@@ -376,12 +361,11 @@ static const struct qcom_icc_qosbox qnm_snoc_gc_qos = {
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SAR2130P_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_snoc_gc_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
@@ -393,53 +377,48 @@ static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SAR2130P_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &qnm_snoc_sf_qos,
 	.num_links = 3,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC,
-		   SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qxm_wlan_q6 = {
 	.name = "qxm_wlan_q6",
-	.id = SAR2130P_MASTER_WLAN_Q6,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC,
-		   SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = SAR2130P_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 6,
-	.links = { SAR2130P_SLAVE_LPASS_CORE_CFG, SAR2130P_SLAVE_LPASS_LPI_CFG,
-		   SAR2130P_SLAVE_LPASS_MPU_CFG, SAR2130P_SLAVE_LPASS_TOP_CFG,
-		   SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC, SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
+			&qhs_lpass_mpu, &qhs_lpass_top,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node qxm_lpass_dsp = {
 	.name = "qxm_lpass_dsp",
-	.id = SAR2130P_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 4,
-	.links = { SAR2130P_SLAVE_LPASS_TOP_CFG, SAR2130P_SLAVE_LPASS_SNOC,
-		   SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC, SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_top, &qns_sysnoc,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SAR2130P_MASTER_LLCC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static const struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
@@ -451,12 +430,11 @@ static const struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SAR2130P_MASTER_CAMNOC_HF,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &qnm_camnoc_hf_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static const struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
@@ -468,12 +446,11 @@ static const struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SAR2130P_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_camnoc_icp_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static const struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
@@ -485,12 +462,11 @@ static const struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SAR2130P_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &qnm_camnoc_sf_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static const struct qcom_icc_qosbox qnm_lsr_qos = {
@@ -502,12 +478,11 @@ static const struct qcom_icc_qosbox qnm_lsr_qos = {
 
 static struct qcom_icc_node qnm_lsr = {
 	.name = "qnm_lsr",
-	.id = SAR2130P_MASTER_LSR,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_lsr_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static const struct qcom_icc_qosbox qnm_mdp_qos = {
@@ -519,21 +494,19 @@ static const struct qcom_icc_qosbox qnm_mdp_qos = {
 
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
-	.id = SAR2130P_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_mdp_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_cfg = {
 	.name = "qnm_mnoc_cfg",
-	.id = SAR2130P_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static const struct qcom_icc_qosbox qnm_video_qos = {
@@ -545,12 +518,11 @@ static const struct qcom_icc_qosbox qnm_video_qos = {
 
 static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
-	.id = SAR2130P_MASTER_VIDEO,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_video_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static const struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
@@ -562,12 +534,11 @@ static const struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
-	.id = SAR2130P_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_video_cv_cpu_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static const struct qcom_icc_qosbox qnm_video_cvp_qos = {
@@ -579,12 +550,11 @@ static const struct qcom_icc_qosbox qnm_video_cvp_qos = {
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SAR2130P_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &qnm_video_cvp_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static const struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
@@ -596,30 +566,27 @@ static const struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = SAR2130P_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_video_v_cpu_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = SAR2130P_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = SAR2130P_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc },
 };
 
 static const struct qcom_icc_qosbox xm_pcie3_0_qos = {
@@ -632,12 +599,11 @@ static const struct qcom_icc_qosbox xm_pcie3_0_qos = {
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SAR2130P_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_pcie3_0_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static const struct qcom_icc_qosbox xm_pcie3_1_qos = {
@@ -650,12 +616,11 @@ static const struct qcom_icc_qosbox xm_pcie3_1_qos = {
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SAR2130P_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_pcie3_1_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static const struct qcom_icc_qosbox qhm_gic_qos = {
@@ -668,12 +633,11 @@ static const struct qcom_icc_qosbox qhm_gic_qos = {
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = SAR2130P_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_gic_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
@@ -686,12 +650,11 @@ static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SAR2130P_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qdss_bam_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox qhm_qspi_qos = {
@@ -704,12 +667,11 @@ static const struct qcom_icc_qosbox qhm_qspi_qos = {
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SAR2130P_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qspi_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox qhm_qup0_qos = {
@@ -722,12 +684,11 @@ static const struct qcom_icc_qosbox qhm_qup0_qos = {
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SAR2130P_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qup0_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox qhm_qup1_qos = {
@@ -740,21 +701,19 @@ static const struct qcom_icc_qosbox qhm_qup1_qos = {
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SAR2130P_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qup1_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SAR2130P_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static const struct qcom_icc_qosbox qnm_cnoc_datapath_qos = {
@@ -767,12 +726,11 @@ static const struct qcom_icc_qosbox qnm_cnoc_datapath_qos = {
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
-	.id = SAR2130P_MASTER_CNOC_DATAPATH,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_cnoc_datapath_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox qnm_lpass_noc_qos = {
@@ -785,21 +743,19 @@ static const struct qcom_icc_qosbox qnm_lpass_noc_qos = {
 
 static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
-	.id = SAR2130P_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &qnm_lpass_noc_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = SAR2130P_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static const struct qcom_icc_qosbox qxm_crypto_qos = {
@@ -812,12 +768,11 @@ static const struct qcom_icc_qosbox qxm_crypto_qos = {
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SAR2130P_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qxm_crypto_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox qxm_pimem_qos = {
@@ -830,12 +785,11 @@ static const struct qcom_icc_qosbox qxm_pimem_qos = {
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SAR2130P_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qxm_pimem_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static const struct qcom_icc_qosbox xm_gic_qos = {
@@ -848,12 +802,11 @@ static const struct qcom_icc_qosbox xm_gic_qos = {
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SAR2130P_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_gic_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static const struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
@@ -866,12 +819,11 @@ static const struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = SAR2130P_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_qdss_etr_0_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
@@ -884,12 +836,11 @@ static const struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = SAR2130P_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_qdss_etr_1_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox xm_sdc1_qos = {
@@ -902,12 +853,11 @@ static const struct qcom_icc_qosbox xm_sdc1_qos = {
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SAR2130P_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_sdc1_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static const struct qcom_icc_qosbox xm_usb3_0_qos = {
@@ -920,571 +870,449 @@ static const struct qcom_icc_qosbox xm_usb3_0_qos = {
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SAR2130P_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_usb3_0_qos,
 	.num_links = 1,
-	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SAR2130P_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SAR2130P_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SAR2130P_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SAR2130P_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SAR2130P_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SAR2130P_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_compute_cfg = {
 	.name = "qhs_compute_cfg",
-	.id = SAR2130P_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_CDSP_NOC_CFG },
+	.link_nodes = { &qhm_nsp_noc_config },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SAR2130P_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SAR2130P_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mxa = {
 	.name = "qhs_cpr_mxa",
-	.id = SAR2130P_SLAVE_RBCPR_MXA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mxc = {
 	.name = "qhs_cpr_mxc",
-	.id = SAR2130P_SLAVE_RBCPR_MXC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_nspcx = {
 	.name = "qhs_cpr_nspcx",
-	.id = SAR2130P_SLAVE_CPR_NSPCX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SAR2130P_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SAR2130P_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SAR2130P_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SAR2130P_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SAR2130P_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SAR2130P_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SAR2130P_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc },
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SAR2130P_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SAR2130P_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SAR2130P_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SAR2130P_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SAR2130P_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SAR2130P_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SAR2130P_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SAR2130P_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SAR2130P_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SAR2130P_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SAR2130P_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SAR2130P_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SAR2130P_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = SAR2130P_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SAR2130P_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SAR2130P_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SAR2130P_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_wlan_q6 = {
 	.name = "qhs_wlan_q6",
-	.id = SAR2130P_SLAVE_WLAN_Q6_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SAR2130P_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mnoc_cfg = {
 	.name = "qns_mnoc_cfg",
-	.id = SAR2130P_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qnm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = SAR2130P_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_snoc_cfg },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SAR2130P_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SAR2130P_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SAR2130P_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SAR2130P_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SAR2130P_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SAR2130P_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SAR2130P_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SAR2130P_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SAR2130P_SLAVE_LLCC,
 	.channels = 2,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = SAR2130P_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = SAR2130P_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = SAR2130P_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = SAR2130P_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_sysnoc = {
 	.name = "qns_sysnoc",
-	.id = SAR2130P_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_LPASS_ANOC },
+	.link_nodes = { &qnm_lpass_noc },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SAR2130P_SLAVE_EBI1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SAR2130P_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SAR2130P_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SAR2130P_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SAR2130P_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_nsp_gemnoc },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = SAR2130P_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SAR2130P_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SAR2130P_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SAR2130P_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SAR2130P_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SAR2130P_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1646,6 +1474,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1708,6 +1537,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_config_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
@@ -1738,6 +1568,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_gem_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1761,6 +1592,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1779,6 +1611,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1807,6 +1640,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_mmss_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -1826,6 +1660,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_nsp_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -1844,6 +1679,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
@@ -1883,6 +1719,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sar2130p_system_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),

-- 
2.47.3


