Return-Path: <linux-pm+bounces-28740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADEADA4F5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04713AFCE0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8BE1A4F3C;
	Mon, 16 Jun 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAz5otef"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44E1519AC
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033725; cv=none; b=F9TJJOXszm7TapuAGTRW7P2wW5RGjuIvVC0VIuQbI4B1slxhqL0i529FgggO4eFnMg5z5KDpUjtOcuLl1CZN4t2WwMV7ZkcY7V30X/B0UCjKV8A6/kzEwhsRq+4nbJm6d3y6zdHRgE34TBZxRgyfaKX6Cn0svQ/oAZPQ8VAp4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033725; c=relaxed/simple;
	bh=HipqwULebF0YB0OR/1iw+APV1Q5+uzhAMGVFlYK4uBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5erfkCLUhC+ZX8M/NwTOHEgxo0bGoAizl1astOM+3i07jBTsoViDsN/4jRsvbTAoWSDvLZSJbkjMwGDGha6uv6Am/MoagriNKM8I/VmKrEDS9AE7eMyynEq2cQEYfwLQtnoAKwfNceHxT8d5KbDeUQCFnSMGZm6UqyO792CuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAz5otef; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FLPTOP018985
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zZF4tgC8IPY1wGCpE5LPmdgXjnjqTPmDBS7LzlDBPFc=; b=fAz5otefRAwaQfTo
	QbHuLzjNXCyB27RY42IowEQ5syn/MC79fB1nR+X+xW/sYCrRRYv0NF/97pCV7QHw
	pq+dmQB7OUdk55PRCRQrbeH32svp9HTE4l62bdZWghBZojVrE2KByVqcac53VYqU
	H4gU7ZANQWSDr4vBjWIZCF5dYmYudd1BO+2r4H0g/1vcOTAW8E9rUcTJYR0waneH
	FOm5GbIv6hzd/6mYmb7p0qK5RDCjkoEA9VRcDFyFNhxttmu5QiJ7HR1dZ/K8aAI5
	vH1C7C3ax2mJcDiH/MkLbu5UhtEVlNMT6th9pHb2/xLpUtxWqe+nbJ/sMwfQumI8
	JbYPqQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791ugahr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:28:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb3487d422so53889366d6.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033719; x=1750638519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZF4tgC8IPY1wGCpE5LPmdgXjnjqTPmDBS7LzlDBPFc=;
        b=KCRsyPc/v9iw2c3I/iMnVpCVRIuBaHO4XCFJ7xvRHBA4abruvLrbrbUXezNJaxAwux
         Vc83nmMv8n8TrZ38hLzO2/DlPam5psP0s5VPC9XA9RiymIHExqwJxWn9A8u3MTXtGfZ3
         MWN09Rswd4D5zmc5VN49fcwEParAej/2noRWsMrl0wmyEoIspB8+Ib2/7yO0DjgFU9vn
         U6WubVr4OFsU+gUQjAJ7y1NdlmJin03qjjR5Dw1DpfqTuA4S7WA811/0owL+Lez/Dr+Q
         AOpaMU4zlDZ6iFrWE91bWaI3HFyM+b9FIaMqzjoWuuL9gD1mA3zcwcluCQdZTvTmKJob
         cOgw==
X-Forwarded-Encrypted: i=1; AJvYcCV7pHJdYamKVqahxUphTOLdVtWRGcMfdTPAjfSWNSvkJRHEvBpO4EJWlCdqkRu2YByZ0B9wkwAR0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKi+b54UYsTyPzjOcFAgsWH5i2VtYDcGHpJG6kPfh6T3FV4Wr
	2kL+HSCe9d5Mrf1gMD1xkekVdIA/Ml0DsE5APcKdpmI7rgFyo0axOg3HmTaSRlZt/xwkqR+Xoq9
	f3HkD/AGLLh0efpjWxBKrJ14Octo2DtWee9aRPuKUtkmu448OTDatjYT45J60mQ==
X-Gm-Gg: ASbGncsJc+NAtv/NGNWBR99Pj184eoA4TcGiCyw+RMApLzFwJHWdULdLFgPcUQDV7uu
	SKDhooFeiB9ZT9nJf0WH6SqKMsl3M8iy0SKqqSaf9n4x1vZkGAzdQ/i8GGrpM2uCdVhKXKiqXf9
	Mlq5csAMJbiAvpugNV9P2rSWl341QNutKvhvczTzIpwrzZRI2QCsZctVgjEq8ox9KOxJfTkKiva
	Hk6XxybnHtVv0UW8gCOj3OO33DQB/F4RLASuPK4u4qsUmNZXmKFX75YyxG6P0Gl6rfqHXK5qP1+
	YgM/bXeq1zQg3NCz/yXjZwr4+SyD0Orsvcr+OhmTRLrTXYov8vxX7yJQVwl3M4dMbanCbLmc4DI
	pa5YliRfXbvAfjbJjep13r3CcjqC6tyk/FiY=
X-Received: by 2002:a05:6214:f66:b0:6fa:c81a:6230 with SMTP id 6a1803df08f44-6fb47741e71mr119090476d6.12.1750033718669;
        Sun, 15 Jun 2025 17:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhmayro2NCWanAnGF/UezLGMf6iWl0CEJ5Fv5fVmrAOdRl0qp+xiClWo64PTY/oqmFY1SEMQ==
X-Received: by 2002:a05:6214:f66:b0:6fa:c81a:6230 with SMTP id 6a1803df08f44-6fb47741e71mr119090116d6.12.1750033718111;
        Sun, 15 Jun 2025 17:28:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:16 +0300
Subject: [PATCH 04/28] interconnect: qcom: rpmh: make link_nodes a
 NULL_terminated array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-4-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=42183;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HipqwULebF0YB0OR/1iw+APV1Q5+uzhAMGVFlYK4uBU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UhggUO7ZtzhqNXrwHY/Nz/oQnVOmiL2wmIG
 GLZM1ODoKmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIQAKCRCLPIo+Aiko
 1WZOB/wNPztKok3FppVbWvE4ej3Zdabi8omQ0cUPZfVzfjPyxIXk6kJy7v31FXQWHP/mLwKHdyR
 i8wCngYePMOCM8wasHUrJvxXBatEmcOVPapJEntbcXANF867CWBGd+FY2xmNbbh1mLFg/GtQxWP
 SCZa7gbXo6R/FBjS4rsfe3gsMJYNZvrjgpTdTCLIvPdxsDVIxIrjyegDLKwZC7EEOlijjjGEcrz
 XgOqcNInjf3LY6TwL4VtYOnKMnEw9bl5NbIsYeUrkjpFCsWunlgc2yVafXNL7Pd3q8kzCcyGNGp
 q+EmGNSGrl5FzfuZZAXVDUsiJvIPp9GqpHcCIwPK2GeeSeIp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfXyE6foOfGWXMX
 37g05Wyh6EPM5XLQ5b+yeml18lrxu6jt8G/8R0/gVcI6lQ9DFFZ7q8gVzFDufLouSqfX1geWObd
 r1z5hNDQ2HenILjW3GyGtB+vZz+T86JLkren90jyhXPjEBVQ0R+bKZC3dsD3hgp+XBcU0C3ebKg
 dm/acKM5RR6UrmMBBXPPdvfDyIS9UOU/KkUuVVbqnpjczwk6w56duATYwb2TY19TT5zCTn56j13
 VJdxXyAHgcuZKOsienM6FmHbk89SQJQrhjg3jisQLBXwfqik+4kn1fvg56UuCWFMPx8olJ98N3E
 rfG5zCox+wRxmJSk3BOcQ/NMYZfGmYqupCL2vfHyFgAQAV0PFpGqr9wrFPc+9ky19XZ140f9I2V
 D7FGh870gLdHfZYfi0fIVHb1l/PE5g1N7LtHjVIJ8QXzmIQJQX9/XC17OFqY+L5M+sWwHISH
X-Proofpoint-GUID: 3aEnxGljElryXG-x4WhDgmNYfjvaVHus
X-Authority-Analysis: v=2.4 cv=NtnRc9dJ c=1 sm=1 tr=0 ts=684f6538 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=awKHyal4sbTCVpb1gUYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 3aEnxGljElryXG-x4WhDgmNYfjvaVHus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160001

Having the .num_links as a separate struct field can provoke errors as
it is easy to omit it or to put an incorrect value into that field. Turn
.link_nodes into a NULL-terminated array, removing a need for a separate
.num_links field if .link_nodes is being used. This creates a deviation
between non-dynamic and dynamic ID cases, but it won't stay like that
for too long.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.c |   7 +-
 drivers/interconnect/qcom/icc-rpmh.h |   4 +-
 drivers/interconnect/qcom/sa8775p.c  | 395 ++++++++++++++++++-----------------
 3 files changed, 207 insertions(+), 199 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 5b7d71d5b30043d94490800c1ef8a820f3fdd02d..2668850ec108452ed5f9f2c8622b536d25870801 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -297,10 +297,11 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		node->data = qn;
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qn->num_links; j++) {
-			if (desc->alloc_dyn_id)
+		if (desc->alloc_dyn_id) {
+			for (j = 0; qn->link_nodes[j]; j++)
 				icc_link_nodes(node, &qn->link_nodes[j]->node);
-			else
+		} else {
+			for (j = 0; j < qn->num_links; j++)
 				icc_link_create(node, qn->links[j]);
 		}
 
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 0018aa74187edcac9a0492c737771d957a133cc0..742941a296ac0a2e3d3e7147c25f750965a36647 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -83,7 +83,6 @@ struct qcom_icc_qosbox {
  * @name: the node name used in debugfs
  * @links: an array of nodes where we can go next while traversing
  * @id: a unique node identifier
- * @link_nodes: links associated with this node
  * @node: icc_node associated with this node
  * @num_links: the total number of @links
  * @channels: num of channels at this node
@@ -93,12 +92,12 @@ struct qcom_icc_qosbox {
  * @bcms: list of bcms associated with this logical node
  * @num_bcms: num of @bcms
  * @qosbox: QoS config data associated with node
+ * @link_nodes: links associated with this node
  */
 struct qcom_icc_node {
 	const char *name;
 	u16 links[MAX_LINKS];
 	u16 id;
-	struct qcom_icc_node **link_nodes;
 	struct icc_node *node;
 	u16 num_links;
 	u16 channels;
@@ -108,6 +107,7 @@ struct qcom_icc_node {
 	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
 	size_t num_bcms;
 	const struct qcom_icc_qosbox *qosbox;
+	struct qcom_icc_node *link_nodes[];
 };
 
 /**
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index 6bbe2fe03f791dd5d3606114d71d62057ddc52d2..a7049eb22d1e064afea17812637b720f907de90e 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -213,192 +213,168 @@ static struct qcom_icc_node qxm_qup3 = {
 	.name = "qxm_qup3",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_1 = {
 	.name = "xm_emac_1",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb2_2 = {
 	.name = "xm_usb2_2",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto_0 = {
 	.name = "qxm_crypto_0",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto_1 = {
 	.name = "qxm_crypto_1",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup0_core_slave },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup1_core_slave },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup2_core_slave },
+	.link_nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup3_core_master = {
 	.name = "qup3_core_master",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup3_core_slave },
+	.link_nodes = { &qup3_core_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 82,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_ahb2phy0, &qhs_ahb2phy1,
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 		      &qhs_ahb2phy2, &qhs_ahb2phy3,
 		      &qhs_anoc_throttle_cfg, &qhs_aoss,
 		      &qhs_apss, &qhs_boot_rom,
@@ -438,1166 +414,1197 @@ static struct qcom_icc_node qnm_gemnoc_cnoc = {
 		      &qns_mnoc_sf_cfg, &qns_pcie_anoc_cfg,
 		      &qns_snoc_cfg, &qxs_boot_imem,
 		      &qxs_imem, &qxs_pimem,
-		      &xs_qdss_stm, &xs_sys_tcu_cfg },
+		      &xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie_0, &xs_pcie_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_llcc, &qns_gemnoc },
+	.link_nodes = { &qhs_llcc, &qns_gemnoc, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
 	.channels = 4,
 	.buswidth = 32,
-	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
-		      &qns_pcie },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc0 = {
 	.name = "qnm_cmpnoc0",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc1 = {
 	.name = "qnm_cmpnoc1",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_even_gemnoc, &srvc_odd_gemnoc,
-		      &srvc_sys_gemnoc, &srvc_sys_gemnoc_2 },
+	.link_nodes = { &srvc_even_gemnoc, &srvc_odd_gemnoc,
+			&srvc_sys_gemnoc, &srvc_sys_gemnoc_2, NULL },
 };
 
 static struct qcom_icc_node qnm_gpdsp_sail = {
 	.name = "qnm_gpdsp_sail",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc, &qns_pcie },
+	.link_nodes = { &qns_llcc, &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
-		      &qns_pcie },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
-		      &qns_pcie },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qxm_dsp0 = {
 	.name = "qxm_dsp0",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gp_dsp_sail_noc },
+	.link_nodes = { &qns_gp_dsp_sail_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_dsp1 = {
 	.name = "qxm_dsp1",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gp_dsp_sail_noc },
+	.link_nodes = { &qns_gp_dsp_sail_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 6,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_lpass_core, &qhs_lpass_lpi,
-		      &qhs_lpass_mpu, &qhs_lpass_top,
-		      &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
+			&qhs_lpass_mpu, &qhs_lpass_top,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_lpass_dsp = {
 	.name = "qxm_lpass_dsp",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_lpass_top, &qns_sysnoc,
-		      &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
+	.link_nodes = { &qhs_lpass_top, &qns_sysnoc,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &ebi },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp0_0 = {
 	.name = "qnm_mdp0_0",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp0_1 = {
 	.name = "qnm_mdp0_1",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp1_0 = {
 	.name = "qnm_mdp1_0",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mdp1_1 = {
 	.name = "qnm_mdp1_1",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf_cfg = {
 	.name = "qnm_mnoc_hf_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_hf },
+	.link_nodes = { &srvc_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf_cfg = {
 	.name = "qnm_mnoc_sf_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_sf },
+	.link_nodes = { &srvc_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &service_nsp_noc },
+	.link_nodes = { &service_nsp_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hcp, &qns_nsp_gemnoc },
+	.link_nodes = { &qns_hcp, &qns_nsp_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qhm_nspb_noc_config = {
 	.name = "qhm_nspb_noc_config",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &service_nspb_noc },
+	.link_nodes = { &service_nspb_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_nspb = {
 	.name = "qxm_nspb",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_nspb_hcp, &qns_nspb_gemnoc },
+	.link_nodes = { &qns_nspb_hcp, &qns_nspb_gemnoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_snoc },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre1_noc },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre2_noc },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup3_core_slave = {
 	.name = "qup3_core_slave",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy3 = {
 	.name = "qhs_ahb2phy3",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_anoc_throttle_cfg = {
 	.name = "qhs_anoc_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_boot_rom = {
 	.name = "qhs_boot_rom",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
 	.name = "qhs_camera_nrt_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute0_cfg = {
 	.name = "qhs_compute0_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhm_nsp_noc_config },
+	.link_nodes = { &qhm_nsp_noc_config, NULL },
 };
 
 static struct qcom_icc_node qhs_compute1_cfg = {
 	.name = "qhs_compute1_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhm_nspb_noc_config },
+	.link_nodes = { &qhm_nspb_noc_config, NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_nspcx = {
 	.name = "qhs_cpr_nspcx",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display0_cfg = {
 	.name = "qhs_display0_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display0_rt_throttle_cfg = {
 	.name = "qhs_display0_rt_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display1_cfg = {
 	.name = "qhs_display1_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display1_rt_throttle_cfg = {
 	.name = "qhs_display1_rt_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac0_cfg = {
 	.name = "qhs_emac0_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emac1_cfg = {
 	.name = "qhs_emac1_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gp_dsp0_cfg = {
 	.name = "qhs_gp_dsp0_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gp_dsp1_cfg = {
 	.name = "qhs_gp_dsp1_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpdsp0_throttle_cfg = {
 	.name = "qhs_gpdsp0_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpdsp1_throttle_cfg = {
 	.name = "qhs_gpdsp1_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg = {
 	.name = "qhs_gpu_tcu_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhm_config_noc },
+	.link_nodes = { &qhm_config_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_throttle_cfg = {
 	.name = "qhs_lpass_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mxc_rdpm = {
 	.name = "qhs_mxc_rdpm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_rsc_cfg = {
 	.name = "qhs_pcie_rsc_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg = {
 	.name = "qhs_pcie_tcu_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_throttle_cfg = {
 	.name = "qhs_pcie_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pke_wrapper_cfg = {
 	.name = "qhs_pke_wrapper_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qm_cfg = {
 	.name = "qhs_qm_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qm_mpu_cfg = {
 	.name = "qhs_qm_mpu_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup3 = {
 	.name = "qhs_qup3",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sail_throttle_cfg = {
 	.name = "qhs_sail_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_throttle_cfg = {
 	.name = "qhs_snoc_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tsc_cfg = {
 	.name = "qhs_tsc_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb2_0 = {
 	.name = "qhs_usb2_0",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
 	.name = "qhs_venus_cvp_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg = {
 	.name = "qhs_venus_v_cpu_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg = {
 	.name = "qhs_venus_vcodec_throttle_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cnoc_dc_noc },
+	.link_nodes = { &qnm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qns_gpdsp_noc_cfg = {
 	.name = "qns_gpdsp_noc_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mnoc_hf_cfg = {
 	.name = "qns_mnoc_hf_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf_cfg },
+	.link_nodes = { &qnm_mnoc_hf_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_mnoc_sf_cfg = {
 	.name = "qns_mnoc_sf_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf_cfg },
+	.link_nodes = { &qnm_mnoc_sf_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_anoc_cfg = {
 	.name = "qns_pcie_anoc_cfg",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_cfg },
+	.link_nodes = { &qnm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
 	.channels = 1,
 	.buswidth = 16,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
 	.channels = 1,
 	.buswidth = 16,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cfg },
+	.link_nodes = { &qnm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cnoc },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
 	.channels = 6,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &llcc_mc },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_pcie },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc_2 = {
 	.name = "srvc_sys_gemnoc_2",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gp_dsp_sail_noc = {
 	.name = "qns_gp_dsp_sail_noc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gpdsp_sail },
+	.link_nodes = { &qnm_gpdsp_sail, NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_sysnoc = {
 	.name = "qns_sysnoc",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_noc },
+	.link_nodes = { &qnm_lpass_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
 	.channels = 8,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc_hf = {
 	.name = "srvc_mnoc_hf",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc_sf = {
 	.name = "srvc_mnoc_sf",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_hcp = {
 	.name = "qns_hcp",
 	.channels = 2,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cmpnoc0 },
+	.link_nodes = { &qnm_cmpnoc0, NULL },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_nspb_gemnoc = {
 	.name = "qns_nspb_gemnoc",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cmpnoc1 },
+	.link_nodes = { &qnm_cmpnoc1, NULL },
 };
 
 static struct qcom_icc_node qns_nspb_hcp = {
 	.name = "qns_nspb_hcp",
 	.channels = 2,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node service_nspb_noc = {
 	.name = "service_nspb_noc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_gc },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_sf },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {

-- 
2.39.5


