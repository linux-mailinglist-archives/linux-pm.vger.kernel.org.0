Return-Path: <linux-pm+bounces-30146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC2AF987E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BB16DC28
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F63093D1;
	Fri,  4 Jul 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ixsDlz+8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B82309DCA
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646935; cv=none; b=J0DjmLHpVg2aRsZCVZp7pKNsRLCwcPb9hLjKX7fQIbE+/iCGyerjMi57EByK+0Dk2aB4r8ciV7vcXUdIfisjpZQL4fKgqVDrNeQRFTbJ7+UDbyM/TY2e5l69Wooez66tPRlwGpCrQHdcsV9Ug5C0v/baj0OXLWiqhegQn2bGg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646935; c=relaxed/simple;
	bh=pVxV8zjHcQ9NxikU+1e/gZLn5//6/fURrkFvfHGQyPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UenvlhNKOaXZLiFtsVNonM9UqJ3Xi5FoeCMGFBNC0VXIDtf//F8Ri/bVIbFanPY59W7jqQXPKexVP3QYyOptcQa/F/iIzr7sr/yk5+aI6/+rwCyqeQpjBEgswJzMh2nKX54Sr56DTevyMxRo7L9fVI8WhvhcgwDTTw0hacxgeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ixsDlz+8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564B6Hh7020132
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mQt2eSsc7rdj1MJcUJgXM2xlRYuBqGSqqA0YN8x6LrU=; b=ixsDlz+8zULi1Lz5
	y61ItP3lprencZnL25Jj8jYqNK3ahk1qUeV8tin9CINtQioQeuntOUQfRF6+KiX8
	DQmbkAf/TkmfJ2j4ay1pGAbAZZ49PiT2nBOXpv9kF3vhiBh536I00v52ooKCweXk
	39f3kvX+Qd/2jvw2xJoBhnoUl48voRnpqk1F17Z4rDqJkwP/GFBIYX/5s73TlGbQ
	QFVfNVvD8N9yQU1u6KraYGJeDLVVMn1tQGuk6655LvgILfc89FgMWHaw1AmlvecR
	ehoYNpifhS5Zo2gxKklyj1huoLEGAuMD2yf/F3jhPyBhr6MykKz6LmIi/pncBf28
	6nfcUQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pdsh8sy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d097fd7b32so229983285a.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646930; x=1752251730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQt2eSsc7rdj1MJcUJgXM2xlRYuBqGSqqA0YN8x6LrU=;
        b=PnrMHWyZrEQ1FggZMBEUzP+6jP72TBXUGog3JkOrFb9AUCZKTQzyZq4rZZ2ct7ynRt
         YznSZ6AGqWktDW7XsToX6VwGZbYapRd2BHyQJRAiXMUUOtDAki6k42jeNUs/5lXljZ2X
         +ocBteR/cSH8xx4OsM6sb/lz9g0uHF/1la1W9S8Lx/wywhVJ9sNRtEwkcbqRDvkLzZfV
         WCBN8cvgPozm4jMnb/9vCd55lTq9c2GQEPiZGDlxFk+WvY/Bx1BvD2gbPef+ckLqs8Qk
         g+gxHzQUMmf8z7qDH0jrh5HeNvAk217QuYA7Ygkm4XBbot7Jem1holZHpGTEOTm9PoaE
         zIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl+iypD0BA98BMZ+/B8mqjpQ9xOJukfmVjvxPmWcJKJXYYnI0hqzDV/4UUY3Jz6MafCpY4u1nSTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzad7ARDPD0d3RE/Toa7prMydYYGi/xFO1T3CRCmgpkSaw7WDg
	FJJbKxq2Mi0sWAL33v10MI9SDG3gQX3MGg1lHDL05UC6nkRbVhk+s7z1ujw7bxazREuX8vXDEQ/
	OGvitCD4Y5VBSQgG2V633yKMgyk36kDu8GEiPY9x0qH172U8EgIhWnZauUTES7w==
X-Gm-Gg: ASbGncut5q4pPTfqzqOQ95ZpzcZbJ9DUhhMPZhTLQ/RX5/kAjdiIT5GM4AvuiyCcALT
	6l0tLPYbiFM6PZ7Dmt2smeQ1E98Nbag7aiAxDGZ38PcVU6OxJSucXRMjAgzm4v6n4ur1wsCNPKL
	UjYygkiq3Fy6Hbk/Bon1QGIUgaIQfjExP946wP2pQVRPTWNfSC9NMQVcpQUqVUXKDak4ew+NKP8
	UnJk3JZBUIJqdj4MhsNHgrfpcBlX/LT2cYKji++uH5CWIoZS02/a0mcL6iOrQZRWp8w9tX+Vyst
	QHTG9iZvBREO6B3v88Qt7oCGUgM/8goBLhQtAylYK1VzZSYFIZea6BpLA8dQe2ZMpLB68/sJKes
	2O9yZXgknEJRi9FW6CFtNJqnVtV87t5QPT+w=
X-Received: by 2002:a05:620a:29d4:b0:7d3:90ab:804 with SMTP id af79cd13be357-7d5dcd24191mr457600385a.58.1751646929988;
        Fri, 04 Jul 2025 09:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9v7hkDTTW2KMU11cx0XinBgXdfjyoUfRj2sosVgMVoryGp5tkozBZmttTeEoeta5O3CYeqA==
X-Received: by 2002:a05:620a:29d4:b0:7d3:90ab:804 with SMTP id af79cd13be357-7d5dcd24191mr457594985a.58.1751646929205;
        Fri, 04 Jul 2025 09:35:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:16 +0300
Subject: [PATCH v2 04/28] interconnect: qcom: rpmh: make link_nodes a
 NULL_terminated array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-4-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=42183;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pVxV8zjHcQ9NxikU+1e/gZLn5//6/fURrkFvfHGQyPA=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0YG09GQB5MdUj2LhEOfiH/8c8snSyHLKUEnS9tbUeySc
 4POEodORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEykP5mDYdUmk01TZx94b1/T
 furfje6csP8FUQl3Le55fJXZYv9bf8nuS9UHT9or667SfPqAr+jYfU/rW6suNvnFfvK9ekW/oPJ
 6xxuD1+k/1v7/6nmjXy9L9fiSC+pl06cJCgYY7vu6OmBZ8s+vpwp2l5eamjeuTw+vZtxx8uBWls
 vKn1O39+tt6A7PF1zlsG61jcR2sVCOE/78+1VFJ0xv+KunktS2O938cVNARr61r3Ps4mleDaUbt
 y2tfyOfOWliaejh81f3fJFRPH5MNqz9CtuX4tayLHuekCORL9kX8VYmZ96/c3Ka3c1PDWZxVbKi
 Uc4PfnZlqnklXrPKElcJV3LjTJ9zs69KVOB1Q7Ky7l8jAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXx5ySag57W9XW
 hMEa8JQS3D6sd79qUh5Fr6lw/AOjvbf9aSbYO81MJA6YwCkV6QfF63ooJQpyuJMZjjLkq1MtiKb
 p8XThkdJkd9ny0lPACkes6a5vDaCQbaxhoC5Ofc7e5Lg0OS3n4DBk+ErjkLuhfpaY59pUTRO+uc
 1055CzI/0ofK5EZSSQdIpY8asI3kJeuUIkGwibA1/BiQJ5WTTJaM34A7QAogxUZUx1iuzo4krDQ
 b4SDtjDKBlIPZjwkNtCag6oDbds3oYzfnTaunnwpKY4t0/0fUe/kVj4k8OMEWLLHDujr9EW02bC
 yoDPi6kGtP83YkeB5pcv565JRQx1Q8xnh2v9l74Bp3qHkF90XKckm/OiI2YR1alWsRIxj9RlldF
 ZO47igon+TtKhMzPkpzOcQNjny/iEHWjz41buCdYKkY66WJ1AlVU6i10JTI78oFxyLqceuuY
X-Authority-Analysis: v=2.4 cv=RJKzH5i+ c=1 sm=1 tr=0 ts=686802d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=awKHyal4sbTCVpb1gUYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: WbJwDlEqaZGPFTZEkGEnCK4JDjQOsTHI
X-Proofpoint-GUID: WbJwDlEqaZGPFTZEkGEnCK4JDjQOsTHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 mlxlogscore=986 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

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
index 7854e3a60d97eb3cdb0a5c1f1b77a96afc104009..941692cbaf208c66a27dda2e6902b2f26f605840 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -302,10 +302,11 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
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


