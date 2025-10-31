Return-Path: <linux-pm+bounces-37200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA55C25B15
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDD189152A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352D257849;
	Fri, 31 Oct 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9g+wzeB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SZO8bTPE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D641FDE31
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921943; cv=none; b=JTldGXLY9XoPEigqvv9iZtm4cYM8WF167DMvckcSP3dJi3U5lmqpAnngHIvlZEaOJo7HewgjYuBaELb8pkcHo31XkjmH0qywjT7fABnBIe9U5PGzyZSyhy7WAbsoYfrstyd09CoIq2f6XAdn42AFUAw2S859etYsLaeoyPdsQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921943; c=relaxed/simple;
	bh=HFvvLztzgvS0FnVg0PxuhH9UCXR3qoci32ULkEPobqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcfUP5u73ZsEJof/xuJhN8O1KKnvZQX+B++BanJUOckSdy71lK++kurpSCKqaeH3y89EkiahuMRIOzatonJtBcpg/2GBwAFgt9Wa0FCLKN1Cdk3KP/mEXMjh5WWH9ChniMRxomqE0mEMzu7mQFg69ejoBfVDYO4Xacp3Jtn2D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9g+wzeB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SZO8bTPE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V6SGHj3116501
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1E0l6koJ5F8y/dHl94YojtL0IxjAi/j7i/9ys9rpM2I=; b=W9g+wzeBMwUpYHIQ
	xs9/GJU6sMRSAemBqqMVhXVQnj+zg5HT4aIu3Cer/TuFJeMdgyaz1PXLe5R9ZdQA
	3BgUt33JLHMG1H+xbF5HAGMDXJFV4RnB5wAe10UsiSJeVE9wR/7YlB5pDFnNVok5
	O0EK2bcnC/97XujgssrQGQY864Uvt6Z0rz47mRutZAmAiHvqUD+2BLybHJTP7RyK
	4zg6dhz4w/ZQVxbHoUH9I+x/Q+3xlilYDtGYTzZ3hpKNm7DkYs5Qmvd2JSlHsa79
	fl092pqxAu8e0nUpxaa5JTaeCy5w4Bzwo5z+3dCxsZ+msBvdExRtHJD97ATI+kNG
	jnldzA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b44g5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87a0e9be970so64251086d6.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921936; x=1762526736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1E0l6koJ5F8y/dHl94YojtL0IxjAi/j7i/9ys9rpM2I=;
        b=SZO8bTPEoNlkYE8B+4epjPKBDfR/slxA22L/Xn5OPkr68lXbEUek0cQHt+QHCI5TVh
         CIi1TxW84KUcaS8MVODNc4QvN13cnc9JdQ0QPdayqH0TfPqLmA6AEthAhVc4oQ6rhA15
         pInlL9cbOCvErDrWLkBkuVL7fBib1G3c2MKsQ9hiYa2iYaWk8hznSfVn2MJfkMUKOzl8
         DbNTu2wi8UnGStIYs5t7MlHPB9cZdyFWE+dCHbLqk57U5YYBXu+IYq29i3zVqdmFrm3b
         j2FOKaGoonHxIRn/+p3AQE3ws891YtCjoYwFAczz7O2KKsbbLmv5ER1Uj2hXJL2uYvWQ
         ctTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921936; x=1762526736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E0l6koJ5F8y/dHl94YojtL0IxjAi/j7i/9ys9rpM2I=;
        b=HwKnvwd+bavYUtWl2ycR08S6QeE3yaduT+tvAfo8KSwKo5yQ+vnzqcl75rchXB+IOX
         lADFv5DbfYIwk54d776k0IXg1GgCoBkwR1M+BknthVROs9g+iibEME+jpTn5s9NGEcs3
         h3X4EKk+MCqoEq1Cg4yNJ6LKz8aELKbxeMRPDSAWA0NY0QY6V8w5A7M09ciLwFCzOspy
         7IE5bgvhG4wsUvrPxSg8lSszBzPJjH6yXJZE7f9Hh6JN6Oe00Ec/SMSSb0sNGilm/1TM
         JoeQo37Cc9etJKp/Af2Q5diAQLQ4i4viTixUJ874P5fElwoHtbwP6zT4sEAgUEteq7g7
         Qy5A==
X-Forwarded-Encrypted: i=1; AJvYcCUkeSWZ9JNuVX1Ry55U7AVTV7lOLNzBTaec0lZkukIkgB8+amdwbR0YqFcdgm60B8W+YmzmoPAmkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkKwJh3VGyTkcX3D888P1z1OjauOhM0d+EtaEW999unvfJLQh
	LulXj7fIF3G6EICfZctotu/FPJjAeT+/DevMCpP97741t4pbkakG592hp5fop9zBgwn8RQrNX3s
	0f2v0XqKKA0DB8Fl7IEAzcmTpff0ckSGW57XmNcsbwy8Gh2Ly/7Vd/+S+H6vY8g==
X-Gm-Gg: ASbGncu5e+p4oeQk/WsrOM9O5hoGNRWdusBM8GNCqBU7dL3QSBw/zzPL58iVrWtz8wh
	xyIMAIzrLAP2z+WSY5hL/qDGLJyt83Ffsejk/DeBSiKA0v180N5byCYsY1JKx6FrVovwdJF7OvH
	CngCXkXGYMYhEDl6dQ2jZpZ1l7mK26cixaz3G/g8qxZff7710UHz7xw6pUIwL8gE6BOkPNgtfiW
	8s+KbIsvrtf9YoPW+JnwDePBTTzjhjtjkOFlpw8e0JKW7mtEnxxYmxkO9nk24SG/o7usuFiwOTp
	KIrq9EnMssl6H7G3sZwTOCOsDrSulpIdT2f+RhUX6QZSDiMgjx3RoTxjoGxUk2L9y8NiGEdMYrA
	O1xvwd4yNfJBnVP0B8oZgo8L+zgI326SiV0O3W9G+Ye98jOHYnV+i+mgPM+nexSohp0XLyvVofH
	3qG5fEnIX7cmyM
X-Received: by 2002:ac8:5703:0:b0:4ec:f9f0:9fd with SMTP id d75a77b69052e-4ed30df258emr42049541cf.19.1761921935027;
        Fri, 31 Oct 2025 07:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGXWO39ayPCRc/LkLyvaOuLzRDSz4J6FevJDCPAVgu+Yq6wu9qAhY40NFmsa3B2tdkkKhLg==
X-Received: by 2002:ac8:5703:0:b0:4ec:f9f0:9fd with SMTP id d75a77b69052e-4ed30df258emr42048771cf.19.1761921934267;
        Fri, 31 Oct 2025 07:45:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:19 +0200
Subject: [PATCH v3 03/25] interconnect: qcom: sc8180x: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-3-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=55777;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HFvvLztzgvS0FnVg0PxuhH9UCXR3qoci32ULkEPobqA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQybL6UbdD6LNzsdYTcOO3LVR0Lf/W9FTwtkoV+gr8D/fh
 X1h2OFORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEwkmIX9f0F9fEw3v57c6WU2
 InF5+oEzWTQ3uSdd/nSatXGuwYHZ1X1eSrVaScsrt3oJFq8+pO8txSZVpB0T8c1Y91GNdeOc9MW
 fG9QW7m7u/1jwpS6Zm2fp3mmR/UrujIK9Z7J86+76ex5538j+uSrtcobHik8syTlnbuZ9OGEeKx
 JTMzFyTr3/ke6Cs7dmtrkcWBgdv0v0rVeSzJmnj2U+WPaner2cLri6U39j07u4Z6uaDHO2b7qoU
 XHBffLC80FF1xsucthY2FZu+bl9duoUqUM3GRt37H2suKLpzYb6Gc7mB221WWWYqkyVhBTW3Pny
 67aq4eWj0a0l9ZMMrq4LFPn1q+WJ0UXRayHn7068b58CAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX1S0TJ5G7LKVD
 YC5oDzCAde8BaDCSkYe9ZowstQF16byabJwq01VwbOMnDHBLylz964rj/PuNTVvNRPs8lmox2gM
 QOtVZfd+m1dsuaFN7Dn7JoC4C+a9QdONbiZhZZC3g/HewJGVJG087YioMaH7rDM+oJfYteWpjdW
 Oc6jdMYAPbvs2kn+WqPYu9PLXqB/ze5B9v5zLtjPyBruY+jc9UcJ3KFukYRssMt+Y9svbAswrwK
 uVHbigMF3UoykD6xZxr7XlnewaDIxOKVWrA1EKyYvC84WbDA+Y6ffCcTjaLwGay7rfQrBkqKzTA
 jsYYzpA+9O8skLCHB37lVIkIqUBCSo+pdrqkeDADiNfXIveGcKpnpx+QxplsDDtsgmTKzck2ZW3
 hgCraM5bk1Zi9lISYeCQvqsebV+gPQ==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6904cb90 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Jf1gYuq5Jsd5zLRqTbsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: RPwgehqpOQrJnkvggSCi4P5EctzbOs3S
X-Proofpoint-GUID: RPwgehqpOQrJnkvggSCi4P5EctzbOs3S
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
 drivers/interconnect/qcom/sc8180x.c | 659 ++++++++++++++++++------------------
 drivers/interconnect/qcom/sc8180x.h | 179 ----------
 2 files changed, 335 insertions(+), 503 deletions(-)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 4dd1d2f2e8216271c15b91b726d4f0c46994ae78..b80a255ba8c322f72f436a351ee3ea4a354be1fa 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -14,1331 +14,1331 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sc8180x.h"
+
+static struct qcom_icc_node mas_qhm_a1noc_cfg;
+static struct qcom_icc_node mas_xm_ufs_card;
+static struct qcom_icc_node mas_xm_ufs_g4;
+static struct qcom_icc_node mas_xm_ufs_mem;
+static struct qcom_icc_node mas_xm_usb3_0;
+static struct qcom_icc_node mas_xm_usb3_1;
+static struct qcom_icc_node mas_xm_usb3_2;
+static struct qcom_icc_node mas_qhm_a2noc_cfg;
+static struct qcom_icc_node mas_qhm_qdss_bam;
+static struct qcom_icc_node mas_qhm_qspi;
+static struct qcom_icc_node mas_qhm_qspi1;
+static struct qcom_icc_node mas_qhm_qup0;
+static struct qcom_icc_node mas_qhm_qup1;
+static struct qcom_icc_node mas_qhm_qup2;
+static struct qcom_icc_node mas_qhm_sensorss_ahb;
+static struct qcom_icc_node mas_qxm_crypto;
+static struct qcom_icc_node mas_qxm_ipa;
+static struct qcom_icc_node mas_xm_emac;
+static struct qcom_icc_node mas_xm_pcie3_0;
+static struct qcom_icc_node mas_xm_pcie3_1;
+static struct qcom_icc_node mas_xm_pcie3_2;
+static struct qcom_icc_node mas_xm_pcie3_3;
+static struct qcom_icc_node mas_xm_qdss_etr;
+static struct qcom_icc_node mas_xm_sdc2;
+static struct qcom_icc_node mas_xm_sdc4;
+static struct qcom_icc_node mas_qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node mas_qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node mas_qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node mas_qnm_npu;
+static struct qcom_icc_node mas_qnm_snoc;
+static struct qcom_icc_node mas_qhm_cnoc_dc_noc;
+static struct qcom_icc_node mas_acm_apps;
+static struct qcom_icc_node mas_acm_gpu_tcu;
+static struct qcom_icc_node mas_acm_sys_tcu;
+static struct qcom_icc_node mas_qhm_gemnoc_cfg;
+static struct qcom_icc_node mas_qnm_cmpnoc;
+static struct qcom_icc_node mas_qnm_gpu;
+static struct qcom_icc_node mas_qnm_mnoc_hf;
+static struct qcom_icc_node mas_qnm_mnoc_sf;
+static struct qcom_icc_node mas_qnm_pcie;
+static struct qcom_icc_node mas_qnm_snoc_gc;
+static struct qcom_icc_node mas_qnm_snoc_sf;
+static struct qcom_icc_node mas_qxm_ecc;
+static struct qcom_icc_node mas_llcc_mc;
+static struct qcom_icc_node mas_qhm_mnoc_cfg;
+static struct qcom_icc_node mas_qxm_camnoc_hf0;
+static struct qcom_icc_node mas_qxm_camnoc_hf1;
+static struct qcom_icc_node mas_qxm_camnoc_sf;
+static struct qcom_icc_node mas_qxm_mdp0;
+static struct qcom_icc_node mas_qxm_mdp1;
+static struct qcom_icc_node mas_qxm_rot;
+static struct qcom_icc_node mas_qxm_venus0;
+static struct qcom_icc_node mas_qxm_venus1;
+static struct qcom_icc_node mas_qxm_venus_arm9;
+static struct qcom_icc_node mas_qhm_snoc_cfg;
+static struct qcom_icc_node mas_qnm_aggre1_noc;
+static struct qcom_icc_node mas_qnm_aggre2_noc;
+static struct qcom_icc_node mas_qnm_gemnoc;
+static struct qcom_icc_node mas_qxm_pimem;
+static struct qcom_icc_node mas_xm_gic;
+static struct qcom_icc_node mas_qup_core_0;
+static struct qcom_icc_node mas_qup_core_1;
+static struct qcom_icc_node mas_qup_core_2;
+static struct qcom_icc_node slv_qns_a1noc_snoc;
+static struct qcom_icc_node slv_srvc_aggre1_noc;
+static struct qcom_icc_node slv_qns_a2noc_snoc;
+static struct qcom_icc_node slv_qns_pcie_mem_noc;
+static struct qcom_icc_node slv_srvc_aggre2_noc;
+static struct qcom_icc_node slv_qns_camnoc_uncomp;
+static struct qcom_icc_node slv_qns_cdsp_mem_noc;
+static struct qcom_icc_node slv_qhs_a1_noc_cfg;
+static struct qcom_icc_node slv_qhs_a2_noc_cfg;
+static struct qcom_icc_node slv_qhs_ahb2phy_refgen_center;
+static struct qcom_icc_node slv_qhs_ahb2phy_refgen_east;
+static struct qcom_icc_node slv_qhs_ahb2phy_refgen_west;
+static struct qcom_icc_node slv_qhs_ahb2phy_south;
+static struct qcom_icc_node slv_qhs_aop;
+static struct qcom_icc_node slv_qhs_aoss;
+static struct qcom_icc_node slv_qhs_camera_cfg;
+static struct qcom_icc_node slv_qhs_clk_ctl;
+static struct qcom_icc_node slv_qhs_compute_dsp;
+static struct qcom_icc_node slv_qhs_cpr_cx;
+static struct qcom_icc_node slv_qhs_cpr_mmcx;
+static struct qcom_icc_node slv_qhs_cpr_mx;
+static struct qcom_icc_node slv_qhs_crypto0_cfg;
+static struct qcom_icc_node slv_qhs_ddrss_cfg;
+static struct qcom_icc_node slv_qhs_display_cfg;
+static struct qcom_icc_node slv_qhs_emac_cfg;
+static struct qcom_icc_node slv_qhs_glm;
+static struct qcom_icc_node slv_qhs_gpuss_cfg;
+static struct qcom_icc_node slv_qhs_imem_cfg;
+static struct qcom_icc_node slv_qhs_ipa;
+static struct qcom_icc_node slv_qhs_mnoc_cfg;
+static struct qcom_icc_node slv_qhs_npu_cfg;
+static struct qcom_icc_node slv_qhs_pcie0_cfg;
+static struct qcom_icc_node slv_qhs_pcie1_cfg;
+static struct qcom_icc_node slv_qhs_pcie2_cfg;
+static struct qcom_icc_node slv_qhs_pcie3_cfg;
+static struct qcom_icc_node slv_qhs_pdm;
+static struct qcom_icc_node slv_qhs_pimem_cfg;
+static struct qcom_icc_node slv_qhs_prng;
+static struct qcom_icc_node slv_qhs_qdss_cfg;
+static struct qcom_icc_node slv_qhs_qspi_0;
+static struct qcom_icc_node slv_qhs_qspi_1;
+static struct qcom_icc_node slv_qhs_qupv3_east0;
+static struct qcom_icc_node slv_qhs_qupv3_east1;
+static struct qcom_icc_node slv_qhs_qupv3_west;
+static struct qcom_icc_node slv_qhs_sdc2;
+static struct qcom_icc_node slv_qhs_sdc4;
+static struct qcom_icc_node slv_qhs_security;
+static struct qcom_icc_node slv_qhs_snoc_cfg;
+static struct qcom_icc_node slv_qhs_spss_cfg;
+static struct qcom_icc_node slv_qhs_tcsr;
+static struct qcom_icc_node slv_qhs_tlmm_east;
+static struct qcom_icc_node slv_qhs_tlmm_south;
+static struct qcom_icc_node slv_qhs_tlmm_west;
+static struct qcom_icc_node slv_qhs_tsif;
+static struct qcom_icc_node slv_qhs_ufs_card_cfg;
+static struct qcom_icc_node slv_qhs_ufs_mem0_cfg;
+static struct qcom_icc_node slv_qhs_ufs_mem1_cfg;
+static struct qcom_icc_node slv_qhs_usb3_0;
+static struct qcom_icc_node slv_qhs_usb3_1;
+static struct qcom_icc_node slv_qhs_usb3_2;
+static struct qcom_icc_node slv_qhs_venus_cfg;
+static struct qcom_icc_node slv_qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node slv_srvc_cnoc;
+static struct qcom_icc_node slv_qhs_gemnoc;
+static struct qcom_icc_node slv_qhs_llcc;
+static struct qcom_icc_node slv_qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node slv_qns_ecc;
+static struct qcom_icc_node slv_qns_gem_noc_snoc;
+static struct qcom_icc_node slv_qns_llcc;
+static struct qcom_icc_node slv_srvc_gemnoc;
+static struct qcom_icc_node slv_srvc_gemnoc1;
+static struct qcom_icc_node slv_ebi;
+static struct qcom_icc_node slv_qns2_mem_noc;
+static struct qcom_icc_node slv_qns_mem_noc_hf;
+static struct qcom_icc_node slv_srvc_mnoc;
+static struct qcom_icc_node slv_qhs_apss;
+static struct qcom_icc_node slv_qns_cnoc;
+static struct qcom_icc_node slv_qns_gemnoc_gc;
+static struct qcom_icc_node slv_qns_gemnoc_sf;
+static struct qcom_icc_node slv_qxs_imem;
+static struct qcom_icc_node slv_qxs_pimem;
+static struct qcom_icc_node slv_srvc_snoc;
+static struct qcom_icc_node slv_xs_pcie_0;
+static struct qcom_icc_node slv_xs_pcie_1;
+static struct qcom_icc_node slv_xs_pcie_2;
+static struct qcom_icc_node slv_xs_pcie_3;
+static struct qcom_icc_node slv_xs_qdss_stm;
+static struct qcom_icc_node slv_xs_sys_tcu_cfg;
+static struct qcom_icc_node slv_qup_core_0;
+static struct qcom_icc_node slv_qup_core_1;
+static struct qcom_icc_node slv_qup_core_2;
 
 static struct qcom_icc_node mas_qhm_a1noc_cfg = {
 	.name = "mas_qhm_a1noc_cfg",
-	.id = SC8180X_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_SERVICE_A1NOC }
+	.link_nodes = { &slv_srvc_aggre1_noc },
 };
 
 static struct qcom_icc_node mas_xm_ufs_card = {
 	.name = "mas_xm_ufs_card",
-	.id = SC8180X_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_ufs_g4 = {
 	.name = "mas_xm_ufs_g4",
-	.id = SC8180X_MASTER_UFS_GEN4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_ufs_mem = {
 	.name = "mas_xm_ufs_mem",
-	.id = SC8180X_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_usb3_0 = {
 	.name = "mas_xm_usb3_0",
-	.id = SC8180X_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_usb3_1 = {
 	.name = "mas_xm_usb3_1",
-	.id = SC8180X_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_usb3_2 = {
 	.name = "mas_xm_usb3_2",
-	.id = SC8180X_MASTER_USB3_2,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_a2noc_cfg = {
 	.name = "mas_qhm_a2noc_cfg",
-	.id = SC8180X_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_SERVICE_A2NOC }
+	.link_nodes = { &slv_srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node mas_qhm_qdss_bam = {
 	.name = "mas_qhm_qdss_bam",
-	.id = SC8180X_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_qspi = {
 	.name = "mas_qhm_qspi",
-	.id = SC8180X_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_qspi1 = {
 	.name = "mas_qhm_qspi1",
-	.id = SC8180X_MASTER_QSPI_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_qup0 = {
 	.name = "mas_qhm_qup0",
-	.id = SC8180X_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_qup1 = {
 	.name = "mas_qhm_qup1",
-	.id = SC8180X_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_qup2 = {
 	.name = "mas_qhm_qup2",
-	.id = SC8180X_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_sensorss_ahb = {
 	.name = "mas_qhm_sensorss_ahb",
-	.id = SC8180X_MASTER_SENSORS_AHB,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qxm_crypto = {
 	.name = "mas_qxm_crypto",
-	.id = SC8180X_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qxm_ipa = {
 	.name = "mas_qxm_ipa",
-	.id = SC8180X_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_emac = {
 	.name = "mas_xm_emac",
-	.id = SC8180X_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_pcie3_0 = {
 	.name = "mas_xm_pcie3_0",
-	.id = SC8180X_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+	.link_nodes = { &slv_qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node mas_xm_pcie3_1 = {
 	.name = "mas_xm_pcie3_1",
-	.id = SC8180X_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+	.link_nodes = { &slv_qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node mas_xm_pcie3_2 = {
 	.name = "mas_xm_pcie3_2",
-	.id = SC8180X_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+	.link_nodes = { &slv_qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node mas_xm_pcie3_3 = {
 	.name = "mas_xm_pcie3_3",
-	.id = SC8180X_MASTER_PCIE_3,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_ANOC_PCIE_GEM_NOC }
+	.link_nodes = { &slv_qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node mas_xm_qdss_etr = {
 	.name = "mas_xm_qdss_etr",
-	.id = SC8180X_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_sdc2 = {
 	.name = "mas_xm_sdc2",
-	.id = SC8180X_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_xm_sdc4 = {
 	.name = "mas_xm_sdc4",
-	.id = SC8180X_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_SLV }
+	.link_nodes = { &slv_qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node mas_qxm_camnoc_hf0_uncomp = {
 	.name = "mas_qxm_camnoc_hf0_uncomp",
-	.id = SC8180X_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_CAMNOC_UNCOMP }
+	.link_nodes = { &slv_qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node mas_qxm_camnoc_hf1_uncomp = {
 	.name = "mas_qxm_camnoc_hf1_uncomp",
-	.id = SC8180X_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_CAMNOC_UNCOMP }
+	.link_nodes = { &slv_qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node mas_qxm_camnoc_sf_uncomp = {
 	.name = "mas_qxm_camnoc_sf_uncomp",
-	.id = SC8180X_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_CAMNOC_UNCOMP }
+	.link_nodes = { &slv_qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node mas_qnm_npu = {
 	.name = "mas_qnm_npu",
-	.id = SC8180X_MASTER_NPU,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_CDSP_MEM_NOC }
+	.link_nodes = { &slv_qns_cdsp_mem_noc },
 };
 
 static struct qcom_icc_node mas_qnm_snoc = {
 	.name = "mas_qnm_snoc",
-	.id = SC8180X_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 56,
-	.links = { SC8180X_SLAVE_TLMM_SOUTH,
-		   SC8180X_SLAVE_CDSP_CFG,
-		   SC8180X_SLAVE_SPSS_CFG,
-		   SC8180X_SLAVE_CAMERA_CFG,
-		   SC8180X_SLAVE_SDCC_4,
-		   SC8180X_SLAVE_AHB2PHY_CENTER,
-		   SC8180X_SLAVE_SDCC_2,
-		   SC8180X_SLAVE_PCIE_2_CFG,
-		   SC8180X_SLAVE_CNOC_MNOC_CFG,
-		   SC8180X_SLAVE_EMAC_CFG,
-		   SC8180X_SLAVE_QSPI_0,
-		   SC8180X_SLAVE_QSPI_1,
-		   SC8180X_SLAVE_TLMM_EAST,
-		   SC8180X_SLAVE_SNOC_CFG,
-		   SC8180X_SLAVE_AHB2PHY_EAST,
-		   SC8180X_SLAVE_GLM,
-		   SC8180X_SLAVE_PDM,
-		   SC8180X_SLAVE_PCIE_1_CFG,
-		   SC8180X_SLAVE_A2NOC_CFG,
-		   SC8180X_SLAVE_QDSS_CFG,
-		   SC8180X_SLAVE_DISPLAY_CFG,
-		   SC8180X_SLAVE_TCSR,
-		   SC8180X_SLAVE_UFS_MEM_0_CFG,
-		   SC8180X_SLAVE_CNOC_DDRSS,
-		   SC8180X_SLAVE_PCIE_0_CFG,
-		   SC8180X_SLAVE_QUP_1,
-		   SC8180X_SLAVE_QUP_2,
-		   SC8180X_SLAVE_NPU_CFG,
-		   SC8180X_SLAVE_CRYPTO_0_CFG,
-		   SC8180X_SLAVE_GRAPHICS_3D_CFG,
-		   SC8180X_SLAVE_VENUS_CFG,
-		   SC8180X_SLAVE_TSIF,
-		   SC8180X_SLAVE_IPA_CFG,
-		   SC8180X_SLAVE_CLK_CTL,
-		   SC8180X_SLAVE_SECURITY,
-		   SC8180X_SLAVE_AOP,
-		   SC8180X_SLAVE_AHB2PHY_WEST,
-		   SC8180X_SLAVE_AHB2PHY_SOUTH,
-		   SC8180X_SLAVE_SERVICE_CNOC,
-		   SC8180X_SLAVE_UFS_CARD_CFG,
-		   SC8180X_SLAVE_USB3_1,
-		   SC8180X_SLAVE_USB3_2,
-		   SC8180X_SLAVE_PCIE_3_CFG,
-		   SC8180X_SLAVE_RBCPR_CX_CFG,
-		   SC8180X_SLAVE_TLMM_WEST,
-		   SC8180X_SLAVE_A1NOC_CFG,
-		   SC8180X_SLAVE_AOSS,
-		   SC8180X_SLAVE_PRNG,
-		   SC8180X_SLAVE_VSENSE_CTRL_CFG,
-		   SC8180X_SLAVE_QUP_0,
-		   SC8180X_SLAVE_USB3,
-		   SC8180X_SLAVE_RBCPR_MMCX_CFG,
-		   SC8180X_SLAVE_PIMEM_CFG,
-		   SC8180X_SLAVE_UFS_MEM_1_CFG,
-		   SC8180X_SLAVE_RBCPR_MX_CFG,
-		   SC8180X_SLAVE_IMEM_CFG }
+	.link_nodes = { &slv_qhs_tlmm_south,
+			&slv_qhs_compute_dsp,
+			&slv_qhs_spss_cfg,
+			&slv_qhs_camera_cfg,
+			&slv_qhs_sdc4,
+			&slv_qhs_ahb2phy_refgen_center,
+			&slv_qhs_sdc2,
+			&slv_qhs_pcie2_cfg,
+			&slv_qhs_mnoc_cfg,
+			&slv_qhs_emac_cfg,
+			&slv_qhs_qspi_0,
+			&slv_qhs_qspi_1,
+			&slv_qhs_tlmm_east,
+			&slv_qhs_snoc_cfg,
+			&slv_qhs_ahb2phy_refgen_east,
+			&slv_qhs_glm,
+			&slv_qhs_pdm,
+			&slv_qhs_pcie1_cfg,
+			&slv_qhs_a2_noc_cfg,
+			&slv_qhs_qdss_cfg,
+			&slv_qhs_display_cfg,
+			&slv_qhs_tcsr,
+			&slv_qhs_ufs_mem0_cfg,
+			&slv_qhs_ddrss_cfg,
+			&slv_qhs_pcie0_cfg,
+			&slv_qhs_qupv3_east0,
+			&slv_qhs_qupv3_east1,
+			&slv_qhs_npu_cfg,
+			&slv_qhs_crypto0_cfg,
+			&slv_qhs_gpuss_cfg,
+			&slv_qhs_venus_cfg,
+			&slv_qhs_tsif,
+			&slv_qhs_ipa,
+			&slv_qhs_clk_ctl,
+			&slv_qhs_security,
+			&slv_qhs_aop,
+			&slv_qhs_ahb2phy_refgen_west,
+			&slv_qhs_ahb2phy_south,
+			&slv_srvc_cnoc,
+			&slv_qhs_ufs_card_cfg,
+			&slv_qhs_usb3_1,
+			&slv_qhs_usb3_2,
+			&slv_qhs_pcie3_cfg,
+			&slv_qhs_cpr_cx,
+			&slv_qhs_tlmm_west,
+			&slv_qhs_a1_noc_cfg,
+			&slv_qhs_aoss,
+			&slv_qhs_prng,
+			&slv_qhs_vsense_ctrl_cfg,
+			&slv_qhs_qupv3_west,
+			&slv_qhs_usb3_0,
+			&slv_qhs_cpr_mmcx,
+			&slv_qhs_pimem_cfg,
+			&slv_qhs_ufs_mem1_cfg,
+			&slv_qhs_cpr_mx,
+			&slv_qhs_imem_cfg },
 };
 
 static struct qcom_icc_node mas_qhm_cnoc_dc_noc = {
 	.name = "mas_qhm_cnoc_dc_noc",
-	.id = SC8180X_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_LLCC_CFG,
-		   SC8180X_SLAVE_GEM_NOC_CFG }
+	.link_nodes = { &slv_qhs_llcc,
+			&slv_qhs_gemnoc },
 };
 
 static struct qcom_icc_node mas_acm_apps = {
 	.name = "mas_acm_apps",
-	.id = SC8180X_MASTER_AMPSS_M0,
 	.channels = 4,
 	.buswidth = 64,
 	.num_links = 3,
-	.links = { SC8180X_SLAVE_ECC,
-		   SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_ecc,
+			&slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_acm_gpu_tcu = {
 	.name = "mas_acm_gpu_tcu",
-	.id = SC8180X_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_acm_sys_tcu = {
 	.name = "mas_acm_sys_tcu",
-	.id = SC8180X_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_qhm_gemnoc_cfg = {
 	.name = "mas_qhm_gemnoc_cfg",
-	.id = SC8180X_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 3,
-	.links = { SC8180X_SLAVE_SERVICE_GEM_NOC_1,
-		   SC8180X_SLAVE_SERVICE_GEM_NOC,
-		   SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG }
+	.link_nodes = { &slv_srvc_gemnoc1,
+			&slv_srvc_gemnoc,
+			&slv_qhs_mdsp_ms_mpu_cfg },
 };
 
 static struct qcom_icc_node mas_qnm_cmpnoc = {
 	.name = "mas_qnm_cmpnoc",
-	.id = SC8180X_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SC8180X_SLAVE_ECC,
-		   SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_ecc,
+			&slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_qnm_gpu = {
 	.name = "mas_qnm_gpu",
-	.id = SC8180X_MASTER_GRAPHICS_3D,
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_qnm_mnoc_hf = {
 	.name = "mas_qnm_mnoc_hf",
-	.id = SC8180X_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_LLCC }
+	.link_nodes = { &slv_qns_llcc },
 };
 
 static struct qcom_icc_node mas_qnm_mnoc_sf = {
 	.name = "mas_qnm_mnoc_sf",
-	.id = SC8180X_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_qnm_pcie = {
 	.name = "mas_qnm_pcie",
-	.id = SC8180X_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_LLCC,
-		   SC8180X_SLAVE_GEM_NOC_SNOC }
+	.link_nodes = { &slv_qns_llcc,
+			&slv_qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node mas_qnm_snoc_gc = {
 	.name = "mas_qnm_snoc_gc",
-	.id = SC8180X_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_LLCC }
+	.link_nodes = { &slv_qns_llcc },
 };
 
 static struct qcom_icc_node mas_qnm_snoc_sf = {
 	.name = "mas_qnm_snoc_sf",
-	.id = SC8180X_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_LLCC }
+	.link_nodes = { &slv_qns_llcc },
 };
 
 static struct qcom_icc_node mas_qxm_ecc = {
 	.name = "mas_qxm_ecc",
-	.id = SC8180X_MASTER_ECC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_LLCC }
+	.link_nodes = { &slv_qns_llcc },
 };
 
 static struct qcom_icc_node mas_llcc_mc = {
 	.name = "mas_llcc_mc",
-	.id = SC8180X_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_EBI_CH0 }
+	.link_nodes = { &slv_ebi },
 };
 
 static struct qcom_icc_node mas_qhm_mnoc_cfg = {
 	.name = "mas_qhm_mnoc_cfg",
-	.id = SC8180X_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_SERVICE_MNOC }
+	.link_nodes = { &slv_srvc_mnoc },
 };
 
 static struct qcom_icc_node mas_qxm_camnoc_hf0 = {
 	.name = "mas_qxm_camnoc_hf0",
-	.id = SC8180X_MASTER_CAMNOC_HF0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+	.link_nodes = { &slv_qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node mas_qxm_camnoc_hf1 = {
 	.name = "mas_qxm_camnoc_hf1",
-	.id = SC8180X_MASTER_CAMNOC_HF1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+	.link_nodes = { &slv_qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node mas_qxm_camnoc_sf = {
 	.name = "mas_qxm_camnoc_sf",
-	.id = SC8180X_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+	.link_nodes = { &slv_qns2_mem_noc },
 };
 
 static struct qcom_icc_node mas_qxm_mdp0 = {
 	.name = "mas_qxm_mdp0",
-	.id = SC8180X_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+	.link_nodes = { &slv_qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node mas_qxm_mdp1 = {
 	.name = "mas_qxm_mdp1",
-	.id = SC8180X_MASTER_MDP_PORT1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_HF_MEM_NOC }
+	.link_nodes = { &slv_qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node mas_qxm_rot = {
 	.name = "mas_qxm_rot",
-	.id = SC8180X_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+	.link_nodes = { &slv_qns2_mem_noc },
 };
 
 static struct qcom_icc_node mas_qxm_venus0 = {
 	.name = "mas_qxm_venus0",
-	.id = SC8180X_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+	.link_nodes = { &slv_qns2_mem_noc },
 };
 
 static struct qcom_icc_node mas_qxm_venus1 = {
 	.name = "mas_qxm_venus1",
-	.id = SC8180X_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+	.link_nodes = { &slv_qns2_mem_noc },
 };
 
 static struct qcom_icc_node mas_qxm_venus_arm9 = {
 	.name = "mas_qxm_venus_arm9",
-	.id = SC8180X_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_MNOC_SF_MEM_NOC }
+	.link_nodes = { &slv_qns2_mem_noc },
 };
 
 static struct qcom_icc_node mas_qhm_snoc_cfg = {
 	.name = "mas_qhm_snoc_cfg",
-	.id = SC8180X_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_SERVICE_SNOC }
+	.link_nodes = { &slv_srvc_snoc },
 };
 
 static struct qcom_icc_node mas_qnm_aggre1_noc = {
 	.name = "mas_qnm_aggre1_noc",
-	.id = SC8180X_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 6,
-	.links = { SC8180X_SLAVE_SNOC_GEM_NOC_SF,
-		   SC8180X_SLAVE_PIMEM,
-		   SC8180X_SLAVE_OCIMEM,
-		   SC8180X_SLAVE_APPSS,
-		   SC8180X_SNOC_CNOC_SLV,
-		   SC8180X_SLAVE_QDSS_STM }
+	.link_nodes = { &slv_qns_gemnoc_sf,
+			&slv_qxs_pimem,
+			&slv_qxs_imem,
+			&slv_qhs_apss,
+			&slv_qns_cnoc,
+			&slv_xs_qdss_stm },
 };
 
 static struct qcom_icc_node mas_qnm_aggre2_noc = {
 	.name = "mas_qnm_aggre2_noc",
-	.id = SC8180X_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 11,
-	.links = { SC8180X_SLAVE_SNOC_GEM_NOC_SF,
-		   SC8180X_SLAVE_PIMEM,
-		   SC8180X_SLAVE_PCIE_3,
-		   SC8180X_SLAVE_OCIMEM,
-		   SC8180X_SLAVE_APPSS,
-		   SC8180X_SLAVE_PCIE_2,
-		   SC8180X_SNOC_CNOC_SLV,
-		   SC8180X_SLAVE_PCIE_0,
-		   SC8180X_SLAVE_PCIE_1,
-		   SC8180X_SLAVE_TCU,
-		   SC8180X_SLAVE_QDSS_STM }
+	.link_nodes = { &slv_qns_gemnoc_sf,
+			&slv_qxs_pimem,
+			&slv_xs_pcie_3,
+			&slv_qxs_imem,
+			&slv_qhs_apss,
+			&slv_xs_pcie_2,
+			&slv_qns_cnoc,
+			&slv_xs_pcie_0,
+			&slv_xs_pcie_1,
+			&slv_xs_sys_tcu_cfg,
+			&slv_xs_qdss_stm },
 };
 
 static struct qcom_icc_node mas_qnm_gemnoc = {
 	.name = "mas_qnm_gemnoc",
-	.id = SC8180X_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 6,
-	.links = { SC8180X_SLAVE_PIMEM,
-		   SC8180X_SLAVE_OCIMEM,
-		   SC8180X_SLAVE_APPSS,
-		   SC8180X_SNOC_CNOC_SLV,
-		   SC8180X_SLAVE_TCU,
-		   SC8180X_SLAVE_QDSS_STM }
+	.link_nodes = { &slv_qxs_pimem,
+			&slv_qxs_imem,
+			&slv_qhs_apss,
+			&slv_qns_cnoc,
+			&slv_xs_sys_tcu_cfg,
+			&slv_xs_qdss_stm },
 };
 
 static struct qcom_icc_node mas_qxm_pimem = {
 	.name = "mas_qxm_pimem",
-	.id = SC8180X_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_SNOC_GEM_NOC_GC,
-		   SC8180X_SLAVE_OCIMEM }
+	.link_nodes = { &slv_qns_gemnoc_gc,
+			&slv_qxs_imem },
 };
 
 static struct qcom_icc_node mas_xm_gic = {
 	.name = "mas_xm_gic",
-	.id = SC8180X_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SC8180X_SLAVE_SNOC_GEM_NOC_GC,
-		   SC8180X_SLAVE_OCIMEM }
+	.link_nodes = { &slv_qns_gemnoc_gc,
+			&slv_qxs_imem },
 };
 
 static struct qcom_icc_node mas_qup_core_0 = {
 	.name = "mas_qup_core_0",
-	.id = SC8180X_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_QUP_CORE_0 }
+	.link_nodes = { &slv_qup_core_0 },
 };
 
 static struct qcom_icc_node mas_qup_core_1 = {
 	.name = "mas_qup_core_1",
-	.id = SC8180X_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_QUP_CORE_1 }
+	.link_nodes = { &slv_qup_core_1 },
 };
 
 static struct qcom_icc_node mas_qup_core_2 = {
 	.name = "mas_qup_core_2",
-	.id = SC8180X_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_SLAVE_QUP_CORE_2 }
+	.link_nodes = { &slv_qup_core_2 },
 };
 
 static struct qcom_icc_node slv_qns_a1noc_snoc = {
 	.name = "slv_qns_a1noc_snoc",
-	.id = SC8180X_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_A1NOC_SNOC_MAS }
+	.link_nodes = { &mas_qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node slv_srvc_aggre1_noc = {
 	.name = "slv_srvc_aggre1_noc",
-	.id = SC8180X_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qns_a2noc_snoc = {
 	.name = "slv_qns_a2noc_snoc",
-	.id = SC8180X_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC8180X_A2NOC_SNOC_MAS }
+	.link_nodes = { &mas_qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node slv_qns_pcie_mem_noc = {
 	.name = "slv_qns_pcie_mem_noc",
-	.id = SC8180X_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_GEM_NOC_PCIE_SNOC }
+	.link_nodes = { &mas_qnm_pcie },
 };
 
 static struct qcom_icc_node slv_srvc_aggre2_noc = {
 	.name = "slv_srvc_aggre2_noc",
-	.id = SC8180X_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qns_camnoc_uncomp = {
 	.name = "slv_qns_camnoc_uncomp",
-	.id = SC8180X_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32
 };
 
 static struct qcom_icc_node slv_qns_cdsp_mem_noc = {
 	.name = "slv_qns_cdsp_mem_noc",
-	.id = SC8180X_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_COMPUTE_NOC }
+	.link_nodes = { &mas_qnm_cmpnoc },
 };
 
 static struct qcom_icc_node slv_qhs_a1_noc_cfg = {
 	.name = "slv_qhs_a1_noc_cfg",
-	.id = SC8180X_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_A1NOC_CFG }
+	.link_nodes = { &mas_qhm_a1noc_cfg },
 };
 
 static struct qcom_icc_node slv_qhs_a2_noc_cfg = {
 	.name = "slv_qhs_a2_noc_cfg",
-	.id = SC8180X_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_A2NOC_CFG }
+	.link_nodes = { &mas_qhm_a2noc_cfg },
 };
 
 static struct qcom_icc_node slv_qhs_ahb2phy_refgen_center = {
 	.name = "slv_qhs_ahb2phy_refgen_center",
-	.id = SC8180X_SLAVE_AHB2PHY_CENTER,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ahb2phy_refgen_east = {
 	.name = "slv_qhs_ahb2phy_refgen_east",
-	.id = SC8180X_SLAVE_AHB2PHY_EAST,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ahb2phy_refgen_west = {
 	.name = "slv_qhs_ahb2phy_refgen_west",
-	.id = SC8180X_SLAVE_AHB2PHY_WEST,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ahb2phy_south = {
 	.name = "slv_qhs_ahb2phy_south",
-	.id = SC8180X_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_aop = {
 	.name = "slv_qhs_aop",
-	.id = SC8180X_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_aoss = {
 	.name = "slv_qhs_aoss",
-	.id = SC8180X_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_camera_cfg = {
 	.name = "slv_qhs_camera_cfg",
-	.id = SC8180X_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_clk_ctl = {
 	.name = "slv_qhs_clk_ctl",
-	.id = SC8180X_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_compute_dsp = {
 	.name = "slv_qhs_compute_dsp",
-	.id = SC8180X_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_cpr_cx = {
 	.name = "slv_qhs_cpr_cx",
-	.id = SC8180X_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_cpr_mmcx = {
 	.name = "slv_qhs_cpr_mmcx",
-	.id = SC8180X_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_cpr_mx = {
 	.name = "slv_qhs_cpr_mx",
-	.id = SC8180X_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_crypto0_cfg = {
 	.name = "slv_qhs_crypto0_cfg",
-	.id = SC8180X_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ddrss_cfg = {
 	.name = "slv_qhs_ddrss_cfg",
-	.id = SC8180X_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_CNOC_DC_NOC }
+	.link_nodes = { &mas_qhm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node slv_qhs_display_cfg = {
 	.name = "slv_qhs_display_cfg",
-	.id = SC8180X_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_emac_cfg = {
 	.name = "slv_qhs_emac_cfg",
-	.id = SC8180X_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_glm = {
 	.name = "slv_qhs_glm",
-	.id = SC8180X_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_gpuss_cfg = {
 	.name = "slv_qhs_gpuss_cfg",
-	.id = SC8180X_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_qhs_imem_cfg = {
 	.name = "slv_qhs_imem_cfg",
-	.id = SC8180X_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ipa = {
 	.name = "slv_qhs_ipa",
-	.id = SC8180X_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_mnoc_cfg = {
 	.name = "slv_qhs_mnoc_cfg",
-	.id = SC8180X_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_CNOC_MNOC_CFG }
+	.link_nodes = { &mas_qhm_mnoc_cfg },
 };
 
 static struct qcom_icc_node slv_qhs_npu_cfg = {
 	.name = "slv_qhs_npu_cfg",
-	.id = SC8180X_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_pcie0_cfg = {
 	.name = "slv_qhs_pcie0_cfg",
-	.id = SC8180X_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_pcie1_cfg = {
 	.name = "slv_qhs_pcie1_cfg",
-	.id = SC8180X_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_pcie2_cfg = {
 	.name = "slv_qhs_pcie2_cfg",
-	.id = SC8180X_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_pcie3_cfg = {
 	.name = "slv_qhs_pcie3_cfg",
-	.id = SC8180X_SLAVE_PCIE_3_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_pdm = {
 	.name = "slv_qhs_pdm",
-	.id = SC8180X_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_pimem_cfg = {
 	.name = "slv_qhs_pimem_cfg",
-	.id = SC8180X_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_prng = {
 	.name = "slv_qhs_prng",
-	.id = SC8180X_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_qdss_cfg = {
 	.name = "slv_qhs_qdss_cfg",
-	.id = SC8180X_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_qspi_0 = {
 	.name = "slv_qhs_qspi_0",
-	.id = SC8180X_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_qspi_1 = {
 	.name = "slv_qhs_qspi_1",
-	.id = SC8180X_SLAVE_QSPI_1,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_qupv3_east0 = {
 	.name = "slv_qhs_qupv3_east0",
-	.id = SC8180X_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_qupv3_east1 = {
 	.name = "slv_qhs_qupv3_east1",
-	.id = SC8180X_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_qupv3_west = {
 	.name = "slv_qhs_qupv3_west",
-	.id = SC8180X_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_sdc2 = {
 	.name = "slv_qhs_sdc2",
-	.id = SC8180X_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_sdc4 = {
 	.name = "slv_qhs_sdc4",
-	.id = SC8180X_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_security = {
 	.name = "slv_qhs_security",
-	.id = SC8180X_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_snoc_cfg = {
 	.name = "slv_qhs_snoc_cfg",
-	.id = SC8180X_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_SNOC_CFG }
+	.link_nodes = { &mas_qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node slv_qhs_spss_cfg = {
 	.name = "slv_qhs_spss_cfg",
-	.id = SC8180X_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_tcsr = {
 	.name = "slv_qhs_tcsr",
-	.id = SC8180X_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_tlmm_east = {
 	.name = "slv_qhs_tlmm_east",
-	.id = SC8180X_SLAVE_TLMM_EAST,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_tlmm_south = {
 	.name = "slv_qhs_tlmm_south",
-	.id = SC8180X_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_tlmm_west = {
 	.name = "slv_qhs_tlmm_west",
-	.id = SC8180X_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_tsif = {
 	.name = "slv_qhs_tsif",
-	.id = SC8180X_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ufs_card_cfg = {
 	.name = "slv_qhs_ufs_card_cfg",
-	.id = SC8180X_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ufs_mem0_cfg = {
 	.name = "slv_qhs_ufs_mem0_cfg",
-	.id = SC8180X_SLAVE_UFS_MEM_0_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_ufs_mem1_cfg = {
 	.name = "slv_qhs_ufs_mem1_cfg",
-	.id = SC8180X_SLAVE_UFS_MEM_1_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_usb3_0 = {
 	.name = "slv_qhs_usb3_0",
-	.id = SC8180X_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_usb3_1 = {
 	.name = "slv_qhs_usb3_1",
-	.id = SC8180X_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_usb3_2 = {
 	.name = "slv_qhs_usb3_2",
-	.id = SC8180X_SLAVE_USB3_2,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_venus_cfg = {
 	.name = "slv_qhs_venus_cfg",
-	.id = SC8180X_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_vsense_ctrl_cfg = {
 	.name = "slv_qhs_vsense_ctrl_cfg",
-	.id = SC8180X_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_srvc_cnoc = {
 	.name = "slv_srvc_cnoc",
-	.id = SC8180X_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_gemnoc = {
 	.name = "slv_qhs_gemnoc",
-	.id = SC8180X_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_GEM_NOC_CFG }
+	.link_nodes = { &mas_qhm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node slv_qhs_llcc = {
 	.name = "slv_qhs_llcc",
-	.id = SC8180X_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_mdsp_ms_mpu_cfg = {
 	.name = "slv_qhs_mdsp_ms_mpu_cfg",
-	.id = SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qns_ecc = {
 	.name = "slv_qns_ecc",
-	.id = SC8180X_SLAVE_ECC,
 	.channels = 1,
 	.buswidth = 32
 };
 
 static struct qcom_icc_node slv_qns_gem_noc_snoc = {
 	.name = "slv_qns_gem_noc_snoc",
-	.id = SC8180X_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_GEM_NOC_SNOC }
+	.link_nodes = { &mas_qnm_gemnoc },
 };
 
 static struct qcom_icc_node slv_qns_llcc = {
 	.name = "slv_qns_llcc",
-	.id = SC8180X_SLAVE_LLCC,
 	.channels = 8,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_LLCC }
+	.link_nodes = { &mas_llcc_mc },
 };
 
 static struct qcom_icc_node slv_srvc_gemnoc = {
 	.name = "slv_srvc_gemnoc",
-	.id = SC8180X_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_srvc_gemnoc1 = {
 	.name = "slv_srvc_gemnoc1",
-	.id = SC8180X_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_ebi = {
 	.name = "slv_ebi",
-	.id = SC8180X_SLAVE_EBI_CH0,
 	.channels = 8,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qns2_mem_noc = {
 	.name = "slv_qns2_mem_noc",
-	.id = SC8180X_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_MNOC_SF_MEM_NOC }
+	.link_nodes = { &mas_qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node slv_qns_mem_noc_hf = {
 	.name = "slv_qns_mem_noc_hf",
-	.id = SC8180X_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_MNOC_HF_MEM_NOC }
+	.link_nodes = { &mas_qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node slv_srvc_mnoc = {
 	.name = "slv_srvc_mnoc",
-	.id = SC8180X_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qhs_apss = {
 	.name = "slv_qhs_apss",
-	.id = SC8180X_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_qns_cnoc = {
 	.name = "slv_qns_cnoc",
-	.id = SC8180X_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_SNOC_CNOC_MAS }
+	.link_nodes = { &mas_qnm_snoc },
 };
 
 static struct qcom_icc_node slv_qns_gemnoc_gc = {
 	.name = "slv_qns_gemnoc_gc",
-	.id = SC8180X_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_SNOC_GC_MEM_NOC }
+	.link_nodes = { &mas_qnm_snoc_gc },
 };
 
 static struct qcom_icc_node slv_qns_gemnoc_sf = {
 	.name = "slv_qns_gemnoc_sf",
-	.id = SC8180X_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SC8180X_MASTER_SNOC_SF_MEM_NOC }
+	.link_nodes = { &mas_qnm_snoc_sf },
 };
 
 static struct qcom_icc_node slv_qxs_imem = {
 	.name = "slv_qxs_imem",
-	.id = SC8180X_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_qxs_pimem = {
 	.name = "slv_qxs_pimem",
-	.id = SC8180X_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_srvc_snoc = {
 	.name = "slv_srvc_snoc",
-	.id = SC8180X_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_xs_pcie_0 = {
 	.name = "slv_xs_pcie_0",
-	.id = SC8180X_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_xs_pcie_1 = {
 	.name = "slv_xs_pcie_1",
-	.id = SC8180X_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_xs_pcie_2 = {
 	.name = "slv_xs_pcie_2",
-	.id = SC8180X_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_xs_pcie_3 = {
 	.name = "slv_xs_pcie_3",
-	.id = SC8180X_SLAVE_PCIE_3,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_xs_qdss_stm = {
 	.name = "slv_xs_qdss_stm",
-	.id = SC8180X_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_xs_sys_tcu_cfg = {
 	.name = "slv_xs_sys_tcu_cfg",
-	.id = SC8180X_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8
 };
 
 static struct qcom_icc_node slv_qup_core_0 = {
 	.name = "slv_qup_core_0",
-	.id = SC8180X_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qup_core_1 = {
 	.name = "slv_qup_core_1",
-	.id = SC8180X_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4
 };
 
 static struct qcom_icc_node slv_qup_core_2 = {
 	.name = "slv_qup_core_2",
-	.id = SC8180X_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4
 };
@@ -1790,6 +1790,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8180x_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1797,6 +1798,7 @@ static const struct qcom_icc_desc sc8180x_aggre1_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1804,6 +1806,7 @@ static const struct qcom_icc_desc sc8180x_aggre2_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_camnoc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1811,6 +1814,7 @@ static const struct qcom_icc_desc sc8180x_camnoc_virt = {
 };
 
 static const struct qcom_icc_desc sc8180x_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1818,6 +1822,7 @@ static const struct qcom_icc_desc sc8180x_compute_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1825,11 +1830,13 @@ static const struct qcom_icc_desc sc8180x_config_noc = {
 };
 
 static const struct qcom_icc_desc sc8180x_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
 
 static const struct qcom_icc_desc sc8180x_gem_noc  = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1837,6 +1844,7 @@ static const struct qcom_icc_desc sc8180x_gem_noc  = {
 };
 
 static const struct qcom_icc_desc sc8180x_mc_virt  = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1844,6 +1852,7 @@ static const struct qcom_icc_desc sc8180x_mc_virt  = {
 };
 
 static const struct qcom_icc_desc sc8180x_mmss_noc  = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1851,6 +1860,7 @@ static const struct qcom_icc_desc sc8180x_mmss_noc  = {
 };
 
 static const struct qcom_icc_desc sc8180x_system_noc  = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
@@ -1871,6 +1881,7 @@ static struct qcom_icc_node * const qup_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc8180x_qup_virt = {
+	.alloc_dyn_id = true,
 	.nodes = qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
 	.bcms = qup_virt_bcms,
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
deleted file mode 100644
index f8d90598335a1d334a6b783bfe8569ab3c46b4f2..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sc8180x.h
+++ /dev/null
@@ -1,179 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SC8180X interconnect IDs
- *
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SC8180X_H
-#define __DRIVERS_INTERCONNECT_QCOM_SC8180X_H
-
-#define SC8180X_MASTER_A1NOC_CFG		1
-#define SC8180X_MASTER_UFS_CARD			2
-#define SC8180X_MASTER_UFS_GEN4			3
-#define SC8180X_MASTER_UFS_MEM			4
-#define SC8180X_MASTER_USB3			5
-#define SC8180X_MASTER_USB3_1			6
-#define SC8180X_MASTER_USB3_2			7
-#define SC8180X_MASTER_A2NOC_CFG		8
-#define SC8180X_MASTER_QDSS_BAM			9
-#define SC8180X_MASTER_QSPI_0			10
-#define SC8180X_MASTER_QSPI_1			11
-#define SC8180X_MASTER_QUP_0			12
-#define SC8180X_MASTER_QUP_1			13
-#define SC8180X_MASTER_QUP_2			14
-#define SC8180X_MASTER_SENSORS_AHB		15
-#define SC8180X_MASTER_CRYPTO_CORE_0		16
-#define SC8180X_MASTER_IPA			17
-#define SC8180X_MASTER_EMAC			18
-#define SC8180X_MASTER_PCIE			19
-#define SC8180X_MASTER_PCIE_1			20
-#define SC8180X_MASTER_PCIE_2			21
-#define SC8180X_MASTER_PCIE_3			22
-#define SC8180X_MASTER_QDSS_ETR			23
-#define SC8180X_MASTER_SDCC_2			24
-#define SC8180X_MASTER_SDCC_4			25
-#define SC8180X_MASTER_CAMNOC_HF0_UNCOMP	26
-#define SC8180X_MASTER_CAMNOC_HF1_UNCOMP	27
-#define SC8180X_MASTER_CAMNOC_SF_UNCOMP		28
-#define SC8180X_MASTER_NPU			29
-#define SC8180X_SNOC_CNOC_MAS			30
-#define SC8180X_MASTER_CNOC_DC_NOC		31
-#define SC8180X_MASTER_AMPSS_M0			32
-#define SC8180X_MASTER_GPU_TCU			33
-#define SC8180X_MASTER_SYS_TCU			34
-#define SC8180X_MASTER_GEM_NOC_CFG		35
-#define SC8180X_MASTER_COMPUTE_NOC		36
-#define SC8180X_MASTER_GRAPHICS_3D		37
-#define SC8180X_MASTER_MNOC_HF_MEM_NOC		38
-#define SC8180X_MASTER_MNOC_SF_MEM_NOC		39
-#define SC8180X_MASTER_GEM_NOC_PCIE_SNOC	40
-#define SC8180X_MASTER_SNOC_GC_MEM_NOC		41
-#define SC8180X_MASTER_SNOC_SF_MEM_NOC		42
-#define SC8180X_MASTER_ECC			43
-/* 44 was used by MASTER_IPA_CORE, now represented as RPMh clock */
-#define SC8180X_MASTER_LLCC			45
-#define SC8180X_MASTER_CNOC_MNOC_CFG		46
-#define SC8180X_MASTER_CAMNOC_HF0		47
-#define SC8180X_MASTER_CAMNOC_HF1		48
-#define SC8180X_MASTER_CAMNOC_SF		49
-#define SC8180X_MASTER_MDP_PORT0		50
-#define SC8180X_MASTER_MDP_PORT1		51
-#define SC8180X_MASTER_ROTATOR			52
-#define SC8180X_MASTER_VIDEO_P0			53
-#define SC8180X_MASTER_VIDEO_P1			54
-#define SC8180X_MASTER_VIDEO_PROC		55
-#define SC8180X_MASTER_SNOC_CFG			56
-#define SC8180X_A1NOC_SNOC_MAS			57
-#define SC8180X_A2NOC_SNOC_MAS			58
-#define SC8180X_MASTER_GEM_NOC_SNOC		59
-#define SC8180X_MASTER_PIMEM			60
-#define SC8180X_MASTER_GIC			61
-#define SC8180X_MASTER_MNOC_HF_MEM_NOC_DISPLAY	62
-#define SC8180X_MASTER_MNOC_SF_MEM_NOC_DISPLAY	63
-#define SC8180X_MASTER_LLCC_DISPLAY		64
-#define SC8180X_MASTER_MDP_PORT0_DISPLAY	65
-#define SC8180X_MASTER_MDP_PORT1_DISPLAY	66
-#define SC8180X_MASTER_ROTATOR_DISPLAY		67
-#define SC8180X_A1NOC_SNOC_SLV			68
-#define SC8180X_SLAVE_SERVICE_A1NOC		69
-#define SC8180X_A2NOC_SNOC_SLV			70
-#define SC8180X_SLAVE_ANOC_PCIE_GEM_NOC		71
-#define SC8180X_SLAVE_SERVICE_A2NOC		72
-#define SC8180X_SLAVE_CAMNOC_UNCOMP		73
-#define SC8180X_SLAVE_CDSP_MEM_NOC		74
-#define SC8180X_SLAVE_A1NOC_CFG			75
-#define SC8180X_SLAVE_A2NOC_CFG			76
-#define SC8180X_SLAVE_AHB2PHY_CENTER		77
-#define SC8180X_SLAVE_AHB2PHY_EAST		78
-#define SC8180X_SLAVE_AHB2PHY_WEST		79
-#define SC8180X_SLAVE_AHB2PHY_SOUTH		80
-#define SC8180X_SLAVE_AOP			81
-#define SC8180X_SLAVE_AOSS			82
-#define SC8180X_SLAVE_CAMERA_CFG		83
-#define SC8180X_SLAVE_CLK_CTL			84
-#define SC8180X_SLAVE_CDSP_CFG			85
-#define SC8180X_SLAVE_RBCPR_CX_CFG		86
-#define SC8180X_SLAVE_RBCPR_MMCX_CFG		87
-#define SC8180X_SLAVE_RBCPR_MX_CFG		88
-#define SC8180X_SLAVE_CRYPTO_0_CFG		89
-#define SC8180X_SLAVE_CNOC_DDRSS		90
-#define SC8180X_SLAVE_DISPLAY_CFG		91
-#define SC8180X_SLAVE_EMAC_CFG			92
-#define SC8180X_SLAVE_GLM			93
-#define SC8180X_SLAVE_GRAPHICS_3D_CFG		94
-#define SC8180X_SLAVE_IMEM_CFG			95
-#define SC8180X_SLAVE_IPA_CFG			96
-#define SC8180X_SLAVE_CNOC_MNOC_CFG		97
-#define SC8180X_SLAVE_NPU_CFG			98
-#define SC8180X_SLAVE_PCIE_0_CFG		99
-#define SC8180X_SLAVE_PCIE_1_CFG		100
-#define SC8180X_SLAVE_PCIE_2_CFG		101
-#define SC8180X_SLAVE_PCIE_3_CFG		102
-#define SC8180X_SLAVE_PDM			103
-#define SC8180X_SLAVE_PIMEM_CFG			104
-#define SC8180X_SLAVE_PRNG			105
-#define SC8180X_SLAVE_QDSS_CFG			106
-#define SC8180X_SLAVE_QSPI_0			107
-#define SC8180X_SLAVE_QSPI_1			108
-#define SC8180X_SLAVE_QUP_1			109
-#define SC8180X_SLAVE_QUP_2			110
-#define SC8180X_SLAVE_QUP_0			111
-#define SC8180X_SLAVE_SDCC_2			112
-#define SC8180X_SLAVE_SDCC_4			113
-#define SC8180X_SLAVE_SECURITY			114
-#define SC8180X_SLAVE_SNOC_CFG			115
-#define SC8180X_SLAVE_SPSS_CFG			116
-#define SC8180X_SLAVE_TCSR			117
-#define SC8180X_SLAVE_TLMM_EAST			118
-#define SC8180X_SLAVE_TLMM_SOUTH		119
-#define SC8180X_SLAVE_TLMM_WEST			120
-#define SC8180X_SLAVE_TSIF			121
-#define SC8180X_SLAVE_UFS_CARD_CFG		122
-#define SC8180X_SLAVE_UFS_MEM_0_CFG		123
-#define SC8180X_SLAVE_UFS_MEM_1_CFG		124
-#define SC8180X_SLAVE_USB3			125
-#define SC8180X_SLAVE_USB3_1			126
-#define SC8180X_SLAVE_USB3_2			127
-#define SC8180X_SLAVE_VENUS_CFG			128
-#define SC8180X_SLAVE_VSENSE_CTRL_CFG		129
-#define SC8180X_SLAVE_SERVICE_CNOC		130
-#define SC8180X_SLAVE_GEM_NOC_CFG		131
-#define SC8180X_SLAVE_LLCC_CFG			132
-#define SC8180X_SLAVE_MSS_PROC_MS_MPU_CFG	133
-#define SC8180X_SLAVE_ECC			134
-#define SC8180X_SLAVE_GEM_NOC_SNOC		135
-#define SC8180X_SLAVE_LLCC			136
-#define SC8180X_SLAVE_SERVICE_GEM_NOC		137
-#define SC8180X_SLAVE_SERVICE_GEM_NOC_1		138
-/* 139 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SC8180X_SLAVE_EBI_CH0			140
-#define SC8180X_SLAVE_MNOC_SF_MEM_NOC		141
-#define SC8180X_SLAVE_MNOC_HF_MEM_NOC		142
-#define SC8180X_SLAVE_SERVICE_MNOC		143
-#define SC8180X_SLAVE_APPSS			144
-#define SC8180X_SNOC_CNOC_SLV			145
-#define SC8180X_SLAVE_SNOC_GEM_NOC_GC		146
-#define SC8180X_SLAVE_SNOC_GEM_NOC_SF		147
-#define SC8180X_SLAVE_OCIMEM			148
-#define SC8180X_SLAVE_PIMEM			149
-#define SC8180X_SLAVE_SERVICE_SNOC		150
-#define SC8180X_SLAVE_PCIE_0			151
-#define SC8180X_SLAVE_PCIE_1			152
-#define SC8180X_SLAVE_PCIE_2			153
-#define SC8180X_SLAVE_PCIE_3			154
-#define SC8180X_SLAVE_QDSS_STM			155
-#define SC8180X_SLAVE_TCU			156
-#define SC8180X_SLAVE_LLCC_DISPLAY		157
-#define SC8180X_SLAVE_EBI_CH0_DISPLAY		158
-#define SC8180X_SLAVE_MNOC_SF_MEM_NOC_DISPLAY	159
-#define SC8180X_SLAVE_MNOC_HF_MEM_NOC_DISPLAY	160
-
-#define SC8180X_MASTER_QUP_CORE_0		163
-#define SC8180X_MASTER_QUP_CORE_1		164
-#define SC8180X_MASTER_QUP_CORE_2		165
-#define SC8180X_SLAVE_QUP_CORE_0		166
-#define SC8180X_SLAVE_QUP_CORE_1		167
-#define SC8180X_SLAVE_QUP_CORE_2		168
-
-#endif

-- 
2.47.3


