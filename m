Return-Path: <linux-pm+bounces-41519-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD0XFxd/eGkFqQEAu9opvQ
	(envelope-from <linux-pm+bounces-41519-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:02:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D1916B8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 10:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5456730054DF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250F331A71;
	Tue, 27 Jan 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bueu+ub8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdG/yofo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364F3321B9
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504517; cv=none; b=iVu+ZJOkGt9/XXt0o/imAd2+JkRgwBHnRd1KsrU5VDdjrmUht3+MrQMSQsA0J97wopJf1Gzvp3/HSmmkTpRWicd2yNfdQgXBwO29wqmlRgmp+5OP54/Wp4tem4b4kYAKBeaosxA7Leiv5zyDawUM40rDOv0S6i/N5JdZqW3Ajnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504517; c=relaxed/simple;
	bh=56ae32zXAwB4yeJh7BN36GG8HpisYrjWcmiT0rFfBIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/Ghbuq0sBkUnS4375k/i7E7bwemlAn8TcZjYcLyfuV54rNkAskDWH+unRN0yp1zGK8B3Y0W8YhAKFJwC587F/jQPG5cGf5g5OTASwU1he2abGHG2t32jyEdpD4jnFVtyF7VlrUuJmtFj68rpcw196rW5x8dJOpotj6OLcj7TX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bueu+ub8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdG/yofo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UBtg171521
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=U12jOmQt/q2
	c358pZqIplU94Mtdyqq3tugyJECKdPb8=; b=bueu+ub85hKXbZlm2FBfsq/qpNQ
	dK15MTXoUzT1NaR92kD72boV1nUbHtTtnpUI/xL5vdbVC5dA1MsFEfo5FwA47The
	laMV97XtBooO4nLK9Zh54fNoUa1g9cgjlx3+Hd7HOXYPcBaxjXTojfN+ZrIO5T2n
	qoP4abkoqLjtEKSbA0Nmd2nZhkcaQn8vdNEntA06QhecPTmKjetDdPnhEXvzFtbd
	6d5Qu2FHCr6XsIc6W6BmmjbLYOj8hfJtSXoAgRKu5Hyib0MCKfQhfKHQIouX26PA
	Nd9zR+oBPe/MszPe/kWRKCLuQIU5WCH6ghl1I5kQNOWFOZNFWEoXM17Qulg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a240g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:01:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso5175021a91.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769504514; x=1770109314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U12jOmQt/q2c358pZqIplU94Mtdyqq3tugyJECKdPb8=;
        b=PdG/yofohI758kVbWFDADEbllevmZb0tubmooaUwcFuWZIVec5mAbEhyxgEo7scyxf
         /wVJBNt/G/aWotDrEYqD5Z+hb8bM1gtIQJfmjIIYg8xCO9rAmAKjkkhwOZmDn7qhxcej
         ZjGSYsqKZ+fF2YrPMa7Lv/RPQsCdtx28bIRa77RJ0z4wcjMRxSkYooH8nnEFjpkpVAbZ
         1ZMmhWM1HYf2dfoxozOu3Qv/d6UtIbbMYRS3fuUZ+R/DKDGKK70c2gdZbpoparC0Dbmd
         ixyuG4p4nt5X4XIYKkr0b6McNu1efb7LgIE3Mt9BqB/UIyDNbkKWJMVtOX4U/9YCO0vu
         RgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504514; x=1770109314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U12jOmQt/q2c358pZqIplU94Mtdyqq3tugyJECKdPb8=;
        b=XGyBC9A1vxbpMs3fy4k3mUs6InFfMatrxkVENPiHNAVqjJg1gYLI8tRv/GE8emw9Vd
         e+Tc0GwMTrgSuxRZbbYWGRvTMrHA1HT4L33Lg5XZt6htL4OvkUoAd9jcLJN9yUzDqsMw
         NzMKdKXQnHFbH6KS9pSrykWo8o8yU72qz5H2Di2PwTRps01mKeY4V7bfpdfAdZQDlBex
         OZ/FzcioA9rnMSFQtEsPP6ySweViRkbE0W/JLzu/1Sfh8xYGWttNE1R3ap0SRcEZi8xP
         2korXqB08GbwZIK4GLnU71debwvOwMO6wOAPnooctCtnHbXuSBbO42RK2QIZwTvLEm/H
         SnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW62sWiMDllJ3yt1gNlW9GfkQSi81AG82mdl4CFY1w0zOgvBrS5MVkjHRJAzgkcCMoUyrExHjXXOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBv2XUB8gMaEr3qVrfkNAYHSINUKz/kSQlhvOe64q8ZVLUzzP1
	atEiHNFqenrOnzEVDF96/wv60mvq5hMXJdbWyQGR+9+N3LxF4gApF8aUN9ZVFpZy4+kSBFl7VRD
	WNTRKm1uRGPOiQKYKDii2s9aEz4xGCWtC82O10Yw3gdS35t7UkobCHFGdWn/caQ==
X-Gm-Gg: AZuq6aINDwSXhUlxlKnhVKFmxv+OKhRlo6Pn1t6CsEUHmy4/41r8Uk4mYYOztSQQoTF
	VS9VNdv1W/s5YE7XELKajsH+BnKGwhKVDFxL6CItgtgDogEcpzOuV7x7rEqxAIycpCRIKhkFAC+
	JbiniYAoP9y5IoEFKysXvGp8AMs+ht0wlPZF09XGVm3J6rOOKY0f7Auq2rq+6zYTuSDIyDtohCt
	NFtow6psB5v+XzODxC/6mPQJycYugvDNWZzJXRXePKMYlyIvi2YqgpENGS+OskBUXMLLvo05jgu
	L930DiXj0jVH8Eo1Gmcq7Wg7rHpN0qkJqqWHnkaxhuh46w3vo9WwaekihKnrB9g1uayCWW6e1JH
	sDd4k5a8CArqsO/36m8B6/MCnu2Saq7jMITvIWoumzBg=
X-Received: by 2002:a17:90b:3d44:b0:352:f296:26f9 with SMTP id 98e67ed59e1d1-353ffb68eedmr1069824a91.17.1769504514121;
        Tue, 27 Jan 2026 01:01:54 -0800 (PST)
X-Received: by 2002:a17:90b:3d44:b0:352:f296:26f9 with SMTP id 98e67ed59e1d1-353ffb68eedmr1069801a91.17.1769504513454;
        Tue, 27 Jan 2026 01:01:53 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873bf53sm11579228b3a.45.2026.01.27.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:01:53 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 2/3] interconnect: qcom: qcs8300: enable QoS configuration
Date: Tue, 27 Jan 2026 14:31:15 +0530
Message-ID: <20260127090116.1438780-3-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3MyBTYWx0ZWRfX3Wd2S7qiY8QS
 R1EoCVzkFfqda0Qc/EVLky4rx/dvL1wlF+8kIP6EF05drpK/jBf4X6ZGBJk/fQd0dScXvCDcqYZ
 eypgNfHMGh5Ay6149zz8cCMzBX4NkYAg3plfqiT4mP0LjC3hMv3YUlSunFaSedFFQvb7VV8qP2x
 Xdasc1oFzSC5QFHf3hHJeYfeuf9gA8Z0Nl9Z5RfiaIuKQ/gmcnF4/bMHBDGkLOfIZgK8DxCmTvW
 9m5uSVns60qYuf1o9jGuZx+SNBm8mVgbCTH3tcr+WazEZY6CsG80nba4GXhDEU0gR6Vaj4lp2zo
 q8dGk9zQ9/Wf1g+PhZ8mWvKb38tAS15jRbfYfNJJ8RIl3JQkyq28cCL7qwdJ9t1UHfPYVcyI1iD
 k6zcYkPWKhEk3QKm+Cl0X/Gw8EhgRccV0/TGC9bZZgM8u3zOXieGeSi92tua8mMO4WQgLaECQyB
 9n3sevJKWrqeSuQDNPg==
X-Proofpoint-ORIG-GUID: nkc4XA28k8WioEkgJ8G1TH9c-w4x8Ayh
X-Proofpoint-GUID: nkc4XA28k8WioEkgJ8G1TH9c-w4x8Ayh
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=69787f03 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=50RLIELzVHUOQg1pcnMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41519-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B0D1916B8
X-Rspamd-Action: no action

Enable QoS configuration for master ports with predefined priority
and urgency forwarding.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qcs8300.c | 375 ++++++++++++++++++++++++++++
 1 file changed, 375 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index bc403a9bf68c..ebf167182572 100644
--- a/drivers/interconnect/qcom/qcs8300.c
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -186,6 +186,13 @@ static struct qcom_icc_node qxm_qup3 = {
 	.name = "qxm_qup3",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -194,6 +201,13 @@ static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -202,6 +216,13 @@ static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -210,6 +231,13 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -218,6 +246,13 @@ static struct qcom_icc_node xm_usb2_2 = {
 	.name = "xm_usb2_2",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -226,6 +261,13 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x17000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -234,6 +276,13 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -242,6 +291,13 @@ static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x17000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -250,6 +306,13 @@ static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -258,6 +321,13 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -266,6 +336,13 @@ static struct qcom_icc_node qxm_crypto_0 = {
 	.name = "qxm_crypto_0",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x18000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -274,6 +351,13 @@ static struct qcom_icc_node qxm_crypto_1 = {
 	.name = "qxm_crypto_1",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1a000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -282,6 +366,13 @@ static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -290,6 +381,13 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -298,6 +396,13 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x19000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -390,6 +495,13 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xaf000 },
+		.prio_fwd_disable = 1,
+		.prio = 1,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -398,6 +510,13 @@ static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb0000 },
+		.prio_fwd_disable = 1,
+		.prio = 3,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -406,6 +525,13 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb1000 },
+		.prio_fwd_disable = 1,
+		.prio = 6,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -423,6 +549,13 @@ static struct qcom_icc_node qnm_cmpnoc0 = {
 	.name = "qnm_cmpnoc0",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf6000, 0xf7000 },
+		.prio_fwd_disable = 1,
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -448,6 +581,13 @@ static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf0000, 0xf1000 },
+		.prio_fwd_disable = 1,
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -456,6 +596,13 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf2000, 0xf3000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_llcc, &qns_pcie },
 };
@@ -464,6 +611,13 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf4000, 0xf5000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 3,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 			&qns_pcie },
@@ -473,6 +627,13 @@ static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb3000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -481,6 +642,13 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb4000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
@@ -489,6 +657,13 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb5000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 3,
 	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 			&qns_pcie },
@@ -541,6 +716,13 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -549,6 +731,13 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -557,6 +746,13 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a080 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -565,6 +761,13 @@ static struct qcom_icc_node qnm_mdp0_0 = {
 	.name = "qnm_mdp0_0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa080 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -573,6 +776,13 @@ static struct qcom_icc_node qnm_mdp0_1 = {
 	.name = "qnm_mdp0_1",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa180 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -597,6 +807,13 @@ static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a100 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -605,6 +822,13 @@ static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a200 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -613,6 +837,13 @@ static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a280 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
@@ -637,6 +868,13 @@ static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_mem_noc },
 };
@@ -645,6 +883,13 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_mem_noc },
 };
@@ -653,6 +898,13 @@ static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_gemnoc_sf },
 };
@@ -677,6 +929,13 @@ static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_gemnoc_sf },
 };
@@ -693,6 +952,13 @@ static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_gemnoc_gc },
 };
@@ -701,6 +967,13 @@ static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_gemnoc_gc },
 };
@@ -1599,11 +1872,21 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
 };
 
+static const struct regmap_config qcs8300_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x17080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_aggre1_noc = {
+	.config = &qcs8300_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1624,11 +1907,21 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
 };
 
+static const struct regmap_config qcs8300_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1a080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_aggre2_noc = {
+	.config = &qcs8300_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
@@ -1740,7 +2033,16 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static const struct regmap_config qcs8300_config_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x13080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_config_noc = {
+	.config = &qcs8300_config_noc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1753,7 +2055,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
+static const struct regmap_config qcs8300_dc_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x5080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_dc_noc = {
+	.config = &qcs8300_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1786,11 +2097,21 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC2] = &srvc_sys_gemnoc_2,
 };
 
+static const struct regmap_config qcs8300_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xf7080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_gem_noc = {
+	.config = &qcs8300_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const gpdsp_anoc_bcms[] = {
@@ -1803,7 +2124,16 @@ static struct qcom_icc_node * const gpdsp_anoc_nodes[] = {
 	[SLAVE_GP_DSP_SAIL_NOC] = &qns_gp_dsp_sail_noc,
 };
 
+static const struct regmap_config qcs8300_gpdsp_anoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xd080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_gpdsp_anoc = {
+	.config = &qcs8300_gpdsp_anoc_regmap_config,
 	.nodes = gpdsp_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
 	.bcms = gpdsp_anoc_bcms,
@@ -1826,7 +2156,16 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
+static const struct regmap_config qcs8300_lpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x17200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_lpass_ag_noc = {
+	.config = &qcs8300_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1872,7 +2211,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC_SF] = &srvc_mnoc_sf,
 };
 
+static const struct regmap_config qcs8300_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x40000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_mmss_noc = {
+	.config = &qcs8300_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1892,7 +2240,16 @@ static struct qcom_icc_node * const nspa_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
+static const struct regmap_config qcs8300_nspa_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x16080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_nspa_noc = {
+	.config = &qcs8300_nspa_noc_regmap_config,
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -1909,7 +2266,16 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
 };
 
+static const struct regmap_config qcs8300_pcie_anoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xc080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_pcie_anoc = {
+	.config = &qcs8300_pcie_anoc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1937,7 +2303,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
+static const struct regmap_config qcs8300_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs8300_system_noc = {
+	.config = &qcs8300_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
2.43.0


