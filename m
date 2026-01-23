Return-Path: <linux-pm+bounces-41382-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIZ6HUisc2nOxwAAu9opvQ
	(envelope-from <linux-pm+bounces-41382-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:13:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BB78D9F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79F87302D97D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D22EA72A;
	Fri, 23 Jan 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rtc6PZ4b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QDfyYgWl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933D31D750
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188400; cv=none; b=C1v/3X9XcoeSSQxyUCWwk+WTaTkcrVEen8mCVDzWTmfsrzGZAS7UJ+EDpnHYlTsgwNyoLGpAke5ZlP1zUcgVkObgxOm6bVJ2qAM3WEevl+cy0rSPdb7WfqBoALODOPWQzi3q/BGUtYpur9u+AYRX7xRKfJPrPcE2xh1a+zFK/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188400; c=relaxed/simple;
	bh=BTXu/yJiPMGX78g/l1K5zEChPeiBMEFX5SoI7IFGwz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FuMkCXWl6tmsJee6gYRSVvXZ3U7av4g3mTmSbpbsRotjU2i5GKye/Vj6ezh+ZTbuolmm0TfHgdKxLxYJUun2Ci+LWp2kOzDOU/F/QB5P9uJeMECLWBBY7wup/e8TJ7LHynLKki+RTgWsjoAq5g5SaDKynfmwcQI+H8YOWPuabgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rtc6PZ4b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QDfyYgWl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF7mm02909018
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mtGSugAHFAxg8YKtqMrFd1RDpXtQGRkU5hzKJcNwoP0=; b=Rtc6PZ4bFwZPCsHs
	PCZWeTtR3MfqM5bHLdZD6tE3qo11AcxBdEEnxZ6cJyU/mJ5iu6ZJXaJIJjVY+Y+l
	JB9lPIhZOaBZDyUwSfn7OR/kTwT3z6dlxoDLESPV0mWzaznkb7+b3Uk5Cl5LjIeh
	1hbuwAqlUbGJoVIoMfYl+kwpnRtze/hyBIZhKyILdjRmHh/iVy2aEusgutcEK9uN
	14L1O8LdQtnmH73qmuWblR70TWkW7a8HfyauUL7g200f7rARoR1gB0EGHOxHtk2I
	0AtxCVZ37crclVQIEs+IMqabq75+gU7S+fvQym2wnl8NeLc3mILRHUyPF0l7w6Sx
	d5I/Ow==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buvs1ug6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:13:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so2225351a91.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769188394; x=1769793194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtGSugAHFAxg8YKtqMrFd1RDpXtQGRkU5hzKJcNwoP0=;
        b=QDfyYgWlnL4ldOAMOqdtZEaV84PXdW65murnuQQ9R3UdN97H5DnFHvJadB9B96g2Dy
         +2s3/2wyj7w+qZ92U+P/1Y8PClFNInM8jVCqEuqrouuFFz34TYf8QEcG2+Le1Z9Tb6cx
         Vuo/5lBzp35GuODuIiZRsG/XEpHvCUFYIvGGSng/elOUlDdjf9gDanxP4PjtDhyEkjRa
         STfFksn8PaEwVYJo77JsMRAj+kHZ+hZ/Q1awOgJgfnqgu0R6ZI7BaZsmuIPHq8D6pUQi
         ZQGvudpp9DgMVuqJRq2IJUf0O09qKhWo+F9fSOorVbkMd35ruhgupYK1LFi9ljDcEym0
         CICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188394; x=1769793194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtGSugAHFAxg8YKtqMrFd1RDpXtQGRkU5hzKJcNwoP0=;
        b=KVKqNhZGNZk76p2NClmyMAiRuWPIt88eRO/vLYk2xjhcpvO9onARtxUaT/p0NOa+70
         axTiadja+tG04zTu6YSjNTnMaW9txYy5BJGwhbVggz6BHZiubLozyzhjZvvKAvK3b4Om
         ADtCiesSXE1Nuk8sFKScH8V0hdBzXKXUQmmOtnuPZD1jdGcApfO+N6x8PGKsA1u/85bX
         Ppb2pW80Drs7joEixR65veN9IuuNlbWw81OwdIuYYQJFt38XIy1l7B4T/8vhV0GhpTYY
         kp8bj8mkZvJ1T2+hGUgiHMfsnp1nr7ThQiDFwDMnnJC7thgUaF56aZ8oxrZK9gDj2BOQ
         cIfg==
X-Forwarded-Encrypted: i=1; AJvYcCX/92jmYEsm3HONlyz3d6vYzfd6hijzPM8sYqaA0TK+JJ+zdb80BO+1ZE1McU+KNM08IXDMHERSLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNGIjLNYUK4hwafB9DzvA8vjl/lQJhJJ5rJLZZOrEn65Eo/hS
	brH4YflOgy9hOgn3bMWzVflDCmdZUhxijt+7zQAO6c/EbGNWa2ev5WI8l2x1YWsI2LDm+AZL08b
	Dlqa0zHXvao3EA+ehPHEVHhV02A5g1YkAYdcW/nAjRHxL096PYM9bYxs2PZcgpw==
X-Gm-Gg: AZuq6aJ3GgH7HnSU/nH+w0pDWKSQZJhk7LWyTVSH843A1YHaGlu62ixK6/7VRZ7+O9D
	QCiCUxTw3uy61R9i7BUvnAiMEX+a56tPZPa1hYLN6umBIznBOc0YkDz44dtHMvyHoTbTU/QjB0h
	426sRC44Xm6BtINeHz13/a3uM0nkCTh7h1+3drNi68HuLX793rU97z2ZgVxejd48Ao7AWYlxHqE
	/N+s/5G+2DgSPU3n1BJT/UgkKrw6jkYvDY+1LSm3zD3qF5qXgPHXeJFcy3n69EzaveHWE2mZx+1
	3d4BXDbg27dYvx31m7CXuLdsEo06AUm3GTx8Xqg5ZO2yighCfYUXgv8VL3zt59h4tucqh5bQrCI
	D4UvVRPOcfejO3D7rKSqWI5BVCxKK6l7A
X-Received: by 2002:a17:90b:35cc:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-35366feb386mr2671127a91.1.1769188393634;
        Fri, 23 Jan 2026 09:13:13 -0800 (PST)
X-Received: by 2002:a17:90b:35cc:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-35366feb386mr2671101a91.1.1769188393094;
        Fri, 23 Jan 2026 09:13:13 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536ef9ddb9sm1191358a91.3.2026.01.23.09.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:13:12 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 17:12:36 +0000
Subject: [PATCH 2/2] interconnect: qcom: glymur: Add Mahua SoC support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-mahua_icc-v1-2-bc82cb087f1e@oss.qualcomm.com>
References: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
In-Reply-To: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: B6lx3dc_JNS0ooTqltztwLKVtjIG4RCL
X-Proofpoint-ORIG-GUID: B6lx3dc_JNS0ooTqltztwLKVtjIG4RCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEyOSBTYWx0ZWRfX/Thna7wE3Kyk
 R3q8HXZnffI8TRp2fmfmzkmC/Vtri4oJackMJxTbZuTE0vYzjRi48KilNZ4ciV8hS+UMkfTKjmB
 LmdZnqBacGk85s3Ge3xnOjlDsKK48fkl/cEoUFqveTTnJrkOSaYNaUbDPLP9wHXwV6EsoFRQynK
 yR9GLqIZEu903lmofPWp0EYIKJNwYodrUNBYsE48NaIVIkGR75rw62AwN3yrM4K+0CzyejyuMIY
 c1OkoX9ErFQY+T8f9wbrJNsNIBg04JL5Oxzm/3rguuOgMyd5ZZOiPXQijAd4MFbeoNzXDb6gUbJ
 m1gXPbGGGaEKZ4NVIF/k8V7dtN5ihhEkq9MCtxOorF9UVxxwmuIVg84qF5l3VSfx7dG4R0FCm4R
 R5eED7paX0ZxwQ2ZOkPXVzTNE62Fc+ROm38gkaX7PP9XD7icy9pRFWW7vF7oDLIGtN2TeTCIOOA
 R/ulMCj+s4gqK4nrULQ==
X-Authority-Analysis: v=2.4 cv=faSgCkQF c=1 sm=1 tr=0 ts=6973ac2a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kREcFzCeUyQouyS3LoIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41382-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C0BB78D9F
X-Rspamd-Action: no action

Mahua is a derivative of the Glymur SoC. This patch extends the
Glymur driver to support Mahua by:

  1. Adding new node definitions for interconnects that differ from Glymur
     (Config NoC, High-Speed Coherent NoC, PCIe West ANOC/Slave NoC).
  2. Reusing existing Glymur definitions for identical NoCs.
  3. Overriding the channel and buswidth, with Mahua specific values for
     the differing NoCs

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/glymur.c | 153 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/glymur.c b/drivers/interconnect/qcom/glymur.c
index e5c07795a6c67ab8a59daf2fc4b8a5fa6dd014d6..65b03b2d5cdc69df0d54e209aed9c8e90309f577 100644
--- a/drivers/interconnect/qcom/glymur.c
+++ b/drivers/interconnect/qcom/glymur.c
@@ -9,6 +9,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/property.h>
 #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
 
 #include "bcm-voter.h"
@@ -2040,6 +2041,60 @@ static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static struct qcom_icc_node * const mahua_cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_AHB2PHY_2] = &qhs_ahb2phy2,
+	[SLAVE_AHB2PHY_3] = &qhs_ahb2phy3,
+	[SLAVE_AV1_ENC_CFG] = &qhs_av1_enc_cfg,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PCIE_2_CFG] = &qhs_pcie2_cfg,
+	[SLAVE_PCIE_3B_CFG] = &qhs_pcie3b_cfg,
+	[SLAVE_PCIE_4_CFG] = &qhs_pcie4_cfg,
+	[SLAVE_PCIE_5_CFG] = &qhs_pcie5_cfg,
+	[SLAVE_PCIE_6_CFG] = &qhs_pcie6_cfg,
+	[SLAVE_PCIE_RSCC] = &qhs_pcie_rscc,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SMMUV3_CFG] = &qhs_smmuv3_cfg,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB2] = &qhs_usb2_0_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0_cfg,
+	[SLAVE_USB3_1] = &qhs_usb3_1_cfg,
+	[SLAVE_USB3_2] = &qhs_usb3_2_cfg,
+	[SLAVE_USB3_MP] = &qhs_usb3_mp_cfg,
+	[SLAVE_USB4_0] = &qhs_usb4_0_cfg,
+	[SLAVE_USB4_1] = &qhs_usb4_1_cfg,
+	[SLAVE_USB4_2] = &qhs_usb4_2_cfg,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_CNOC_PCIE_SLAVE_EAST_CFG] = &qss_cnoc_pcie_slave_east_cfg,
+	[SLAVE_CNOC_PCIE_SLAVE_WEST_CFG] = &qss_cnoc_pcie_slave_west_cfg,
+	[SLAVE_LPASS_QTB_CFG] = &qss_lpass_qtb_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
+	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
+	[SLAVE_PCIE_EAST_ANOC_CFG] = &qss_pcie_east_anoc_cfg,
+	[SLAVE_PCIE_WEST_ANOC_CFG] = &qss_pcie_west_anoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
 static const struct regmap_config glymur_cnoc_cfg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -2056,6 +2111,14 @@ static const struct qcom_icc_desc glymur_cnoc_cfg = {
 	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
 };
 
+static const struct qcom_icc_desc mahua_cnoc_cfg = {
+	.config = &glymur_cnoc_cfg_regmap_config,
+	.nodes = mahua_cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(mahua_cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
 static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
 	&bcm_cn0,
 };
@@ -2115,6 +2178,27 @@ static struct qcom_icc_node * const hscnoc_nodes[] = {
 	[SLAVE_PCIE_WEST] = &qns_pcie_west,
 };
 
+static struct qcom_icc_node * const mahua_hscnoc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_PCIE_TCU] = &alm_pcie_qtc,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_AGGRE_NOC_EAST] = &qnm_aggre_noc_east,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_noc,
+	[MASTER_PCIE_EAST] = &qnm_pcie_east,
+	[MASTER_PCIE_WEST] = &qnm_pcie_west,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_HSCNOC_CNOC] = &qns_hscnoc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_PCIE_EAST] = &qns_pcie_east,
+	[SLAVE_PCIE_WEST] = &qns_pcie_west,
+};
+
 static const struct regmap_config glymur_hscnoc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -2131,6 +2215,14 @@ static const struct qcom_icc_desc glymur_hscnoc = {
 	.num_bcms = ARRAY_SIZE(hscnoc_bcms),
 };
 
+static const struct qcom_icc_desc mahua_hscnoc = {
+	.config = &glymur_hscnoc_regmap_config,
+	.nodes = mahua_hscnoc_nodes,
+	.num_nodes = ARRAY_SIZE(mahua_hscnoc_nodes),
+	.bcms = hscnoc_bcms,
+	.num_bcms = ARRAY_SIZE(hscnoc_bcms),
+};
+
 static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
 	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
@@ -2388,6 +2480,16 @@ static struct qcom_icc_node * const pcie_west_anoc_nodes[] = {
 	[SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC] = &srvc_pcie_west_aggre_noc,
 };
 
+static struct qcom_icc_node * const mahua_pcie_west_anoc_nodes[] = {
+	[MASTER_PCIE_WEST_ANOC_CFG] = &qsm_pcie_west_anoc_cfg,
+	[MASTER_PCIE_2] = &xm_pcie_2,
+	[MASTER_PCIE_3B] = &xm_pcie_3b,
+	[MASTER_PCIE_4] = &xm_pcie_4,
+	[MASTER_PCIE_6] = &xm_pcie_6,
+	[SLAVE_PCIE_WEST_MEM_NOC] = &qns_pcie_west_mem_noc,
+	[SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC] = &srvc_pcie_west_aggre_noc,
+};
+
 static const struct regmap_config glymur_pcie_west_anoc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -2405,6 +2507,15 @@ static const struct qcom_icc_desc glymur_pcie_west_anoc = {
 	.qos_requires_clocks = true,
 };
 
+static const struct qcom_icc_desc mahua_pcie_west_anoc = {
+	.config = &glymur_pcie_west_anoc_regmap_config,
+	.nodes = mahua_pcie_west_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(mahua_pcie_west_anoc_nodes),
+	.bcms = pcie_west_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_west_anoc_bcms),
+	.qos_requires_clocks = true,
+};
+
 static struct qcom_icc_bcm * const pcie_west_slv_noc_bcms[] = {
 	&bcm_sn6,
 };
@@ -2421,6 +2532,17 @@ static struct qcom_icc_node * const pcie_west_slv_noc_nodes[] = {
 	[SLAVE_PCIE_6] = &xs_pcie_6,
 };
 
+static struct qcom_icc_node * const mahua_pcie_west_slv_noc_nodes[] = {
+	[MASTER_HSCNOC_PCIE_WEST] = &qnm_hscnoc_pcie_west,
+	[MASTER_CNOC_PCIE_WEST_SLAVE_CFG] = &qsm_cnoc_pcie_west_slave_cfg,
+	[SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG] = &qhs_hscnoc_pcie_west_ms_mpu_cfg,
+	[SLAVE_SERVICE_PCIE_WEST] = &srvc_pcie_west,
+	[SLAVE_PCIE_2] = &xs_pcie_2,
+	[SLAVE_PCIE_3B] = &xs_pcie_3b,
+	[SLAVE_PCIE_4] = &xs_pcie_4,
+	[SLAVE_PCIE_6] = &xs_pcie_6,
+};
+
 static const struct regmap_config glymur_pcie_west_slv_noc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -2437,6 +2559,14 @@ static const struct qcom_icc_desc glymur_pcie_west_slv_noc = {
 	.num_bcms = ARRAY_SIZE(pcie_west_slv_noc_bcms),
 };
 
+static const struct qcom_icc_desc mahua_pcie_west_slv_noc = {
+	.config = &glymur_pcie_west_slv_noc_regmap_config,
+	.nodes = mahua_pcie_west_slv_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mahua_pcie_west_slv_noc_nodes),
+	.bcms = pcie_west_slv_noc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_west_slv_noc_bcms),
+};
+
 static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn1,
@@ -2470,6 +2600,22 @@ static const struct qcom_icc_desc glymur_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
+static int glymur_qnoc_probe(struct platform_device *pdev)
+{
+	if (device_is_compatible(&pdev->dev, "qcom,mahua-mc-virt")) {
+		llcc_mc.channels = 8;
+		ebi.channels = 8;
+	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-hscnoc")) {
+		qns_llcc.channels = 8;
+		chm_apps.channels = 4;
+		qnm_pcie_west.buswidth = 32;
+	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-pcie-west-anoc")) {
+		qns_pcie_west_mem_noc.buswidth = 32;
+	}
+
+	return qcom_icc_rpmh_probe(pdev);
+}
+
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,glymur-aggre1-noc", .data = &glymur_aggre1_noc},
 	{ .compatible = "qcom,glymur-aggre2-noc", .data = &glymur_aggre2_noc},
@@ -2477,12 +2623,15 @@ static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,glymur-aggre4-noc", .data = &glymur_aggre4_noc},
 	{ .compatible = "qcom,glymur-clk-virt", .data = &glymur_clk_virt},
 	{ .compatible = "qcom,glymur-cnoc-cfg", .data = &glymur_cnoc_cfg},
+	{ .compatible = "qcom,mahua-cnoc-cfg", .data = &mahua_cnoc_cfg},
 	{ .compatible = "qcom,glymur-cnoc-main", .data = &glymur_cnoc_main},
 	{ .compatible = "qcom,glymur-hscnoc", .data = &glymur_hscnoc},
+	{ .compatible = "qcom,mahua-hscnoc", .data = &mahua_hscnoc},
 	{ .compatible = "qcom,glymur-lpass-ag-noc", .data = &glymur_lpass_ag_noc},
 	{ .compatible = "qcom,glymur-lpass-lpiaon-noc", .data = &glymur_lpass_lpiaon_noc},
 	{ .compatible = "qcom,glymur-lpass-lpicx-noc", .data = &glymur_lpass_lpicx_noc},
 	{ .compatible = "qcom,glymur-mc-virt", .data = &glymur_mc_virt},
+	{ .compatible = "qcom,mahua-mc-virt", .data = &glymur_mc_virt},
 	{ .compatible = "qcom,glymur-mmss-noc", .data = &glymur_mmss_noc},
 	{ .compatible = "qcom,glymur-nsinoc", .data = &glymur_nsinoc},
 	{ .compatible = "qcom,glymur-nsp-noc", .data = &glymur_nsp_noc},
@@ -2490,14 +2639,16 @@ static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,glymur-pcie-east-anoc", .data = &glymur_pcie_east_anoc},
 	{ .compatible = "qcom,glymur-pcie-east-slv-noc", .data = &glymur_pcie_east_slv_noc},
 	{ .compatible = "qcom,glymur-pcie-west-anoc", .data = &glymur_pcie_west_anoc},
+	{ .compatible = "qcom,mahua-pcie-west-anoc", .data = &mahua_pcie_west_anoc},
 	{ .compatible = "qcom,glymur-pcie-west-slv-noc", .data = &glymur_pcie_west_slv_noc},
+	{ .compatible = "qcom,mahua-pcie-west-slv-noc", .data = &mahua_pcie_west_slv_noc},
 	{ .compatible = "qcom,glymur-system-noc", .data = &glymur_system_noc},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qcom_icc_rpmh_probe,
+	.probe = glymur_qnoc_probe,
 	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-glymur",

-- 
2.43.0


