Return-Path: <linux-pm+bounces-35611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E5BAF6C9
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B651C590C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D770275113;
	Wed,  1 Oct 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="py3LoUqV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8E274B57
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304061; cv=none; b=t9c51UmwrFCaiy0RJCzGP3yYPLledfVEvJnqwGUDJDE9V63Rl34oyRgQyGOsKbaQUynhRSZdXVRabColzbKOSb9s3zjTSqT97nvbo8LtrswfK7otfXSvmkMB3N0qjnD2K8pHALLx1x1CJ7qsNIoX5mMxDNKYd836cIiId76B1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304061; c=relaxed/simple;
	bh=XF+ND61W3M6Uj74fpNETYqhyxpnvfDkz6HI1UbMqQeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZMH4mXHqUqQevo6exv/JSrPFKGXwkE6FHtFYRflrfwiHe3UqR4afo4sr2Fv19hawypwKGf17VTPVrrzvhuG3DGaLQnfKTqsDtel6mvsxOeCXVJ5906LvMn1hiyomTQlJ2k/+xnpJhbjxwuXsRGpIUZUhMoTxG3bXpLVg0+UTHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=py3LoUqV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULYf6d014690
	for <linux-pm@vger.kernel.org>; Wed, 1 Oct 2025 07:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=/3cCgL3JaA7/PB7mF3hIdDErwjZ4ZetjtDpdoIFHrIY=; b=py
	3LoUqVWhI4kLXvc2nmpwYlPUTfxK1RH+i2GtTFGK7BBPae9ctN4JFex+C2qMiJKR
	fGIC1pl1VyLpuhrpOg7UnLu9QjNrxqGpr4zdZHN/p7w1fWBp30ZAf9aYgbDQwzSL
	f7TrczpiDiWG/ReBHxCiWF1xgwQh10ZNSvXss0l1+BSrN8KxLgnkTPAh0Hp13l8q
	nMU30dkMFRm1aWyrMA4sCEzM/qzpzwWerTS68RGNNBiBowfyIYDeABOOeUgD+e4z
	DGsah+wuFwIN9gON0jIXcuNU2oykB5xbie5/Vnc9udTaWy7fvX8z5p5ChMEBKkvH
	2SixtsMhQOemBcYm2hNw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr3qf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 07:34:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so4381822a12.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 00:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304057; x=1759908857;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3cCgL3JaA7/PB7mF3hIdDErwjZ4ZetjtDpdoIFHrIY=;
        b=K+tYo+Xmu3ApSAvJYv1IFlj42ANhPAcNbGS+4PjFmHaBAEbRjmMT29sbnMEmO1ccz+
         Mms7gFm2qjteXRJ/KeJZhIcZDUWjX74LupJqH6S2zR68VgQYujlJRSPMGAkLpnWplHJt
         ul3PgI+cmGd/gLCAR0sf9qsQx5jd8N14SBZTv/jY9Ys9uDSBnSlce99Y23Q47zf+WDOu
         //GZJa8EBmBwauzY1KF6o19H0gmvEWE7RDUyrju8UWtq3NE/jvDtGrfrdvXW9zd3+U6o
         YsnzRm+aCAblpRNd7QHSNK7J4GiqTrV23Is33VVznq77REu4zVebW/gH/uRaOSCaJRJ3
         ggvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlVOMDlBzEyT16X1or85iCrvFw3OfpWEEdBIQpZPivK+TjND1Rn4/E6DOtdBa8DKJU6TwItZEQfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/A+R9w8duU1zg0N90pvV3xnFziv0c4JrzuF2CW6NBkbqoHhN
	QN4pVt5835Ej8Nh0x5tg12nXV5aD8Nc73wBudEN8p2hvPFCuib9KqnzHR0/tBenhZiK0ZSF39x+
	y5yNw8sf676ppgqM5/vcywY/3Q0uoQUnsrTI9sW8mW226yAMII00QhXHecOLgzw==
X-Gm-Gg: ASbGncsGMuOGmulVPSc4JUEihAfqQ2i/BWnCuKRmODvrYJ1bJGHZnGWmBXxpiuy7ZaW
	qeUPfuNSigZNpcDLWZAUt5OdzrHY0ox15fq6ZqVAYxQp2QBFEWQ4pg9eNlxfVHK8ShrapTGocRE
	HI0PRWwq9TjjgwFbXmcDt2UwB4G1h7ZY6egyuzFxnEHNEY/PLdzryPWYxJmqKtek2xxKUgUGrBz
	N0feqM2Y/vGWrwrBC8ahFGYhT698wtV6z/xoHr1ksx1nF8lgbdAgYKn7XyvONBKlR5BVQjUrc+p
	uiQxMUhWo/s7fyMe+eLfkd4NbHlDAYZ1E9hcyStd082dxFr2BVfNKg2aKmJxvVZSTiaVKhmQso1
	swSk=
X-Received: by 2002:a17:90b:4a07:b0:32d:c63d:4db1 with SMTP id 98e67ed59e1d1-339a6f57edcmr2327390a91.34.1759304056939;
        Wed, 01 Oct 2025 00:34:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE643ADHqZB2Fi2rzDOyHC9Ty9RCwruxRH4fMTLgt6P++JyROam2ISurvJ6qDX2G/vilYiuWQ==
X-Received: by 2002:a17:90b:4a07:b0:32d:c63d:4db1 with SMTP id 98e67ed59e1d1-339a6f57edcmr2327356a91.34.1759304056259;
        Wed, 01 Oct 2025 00:34:16 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm1642127a91.17.2025.10.01.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:34:15 -0700 (PDT)
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
Subject: [PATCH v2 2/3] interconnect: qcom: sa8775p: enable QoS configuration
Date: Wed,  1 Oct 2025 13:03:43 +0530
Message-Id: <20251001073344.6599-3-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: k6zNatgb4hZiwqWNcY2SFcbByEB3_lkf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXy3th4UX9uhSZ
 6LWJMhTWLEUd2FT233ODNHKXRbd2pFilLqrPcYPAgPvgj8vJEre4RIciQnSRvodlf3Ozwae2a/T
 myKo+f8+1uSBCtbf0oYFLHbSUP9+k/4uvkzGbSnM7Wv1kOgJ1w1VviDcLx/CHwAJkXguIC1pGwd
 XCTzjx003RcJu67uNOZ7FN4Lz/t+fh5EWcOiFqbbeR6C8cKKvLw9s5aUQhpSPbJSBxxeTED6m6x
 DX4NsEU+Qp7Yefen0KSeNoiDJo5O3AuoR4xuhrEaS6QBiMxRdiaBtxka/F7XJvH6DzcCryw6Wx/
 BP+av0Oefp8BBOSCOfafWQnRIxQb646Z5CTc19Rb0akPHj1WwKfAP2H6tvq6b1MEcXRyx++UKo7
 0SCoEAoWfsHYISPhU9Yf4DHVxVPssw==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dcd97a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=I8WKV2cH2hVkXcs4O-MA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: k6zNatgb4hZiwqWNcY2SFcbByEB3_lkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Enable QoS configuration for master ports with predefinedi priority
and urgency forwarding.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
 1 file changed, 439 insertions(+)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index 04b4abbf4487..5bf27dbe818d 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -213,6 +213,13 @@ static struct qcom_icc_node qxm_qup3 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -221,6 +228,13 @@ static struct qcom_icc_node xm_emac_0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -229,6 +243,13 @@ static struct qcom_icc_node xm_emac_1 = {
 	.name = "xm_emac_1",
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -237,6 +258,13 @@ static struct qcom_icc_node xm_sdc1 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -245,6 +273,13 @@ static struct qcom_icc_node xm_ufs_mem = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -253,6 +288,13 @@ static struct qcom_icc_node xm_usb2_2 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -261,6 +303,13 @@ static struct qcom_icc_node xm_usb3_0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -269,6 +318,13 @@ static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
 };
@@ -277,6 +333,13 @@ static struct qcom_icc_node qhm_qdss_bam = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -285,6 +348,13 @@ static struct qcom_icc_node qhm_qup0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -293,6 +363,13 @@ static struct qcom_icc_node qhm_qup1 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -301,6 +378,13 @@ static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -309,6 +393,13 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -317,6 +408,13 @@ static struct qcom_icc_node qxm_crypto_0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -325,6 +423,13 @@ static struct qcom_icc_node qxm_crypto_1 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -333,6 +438,13 @@ static struct qcom_icc_node qxm_ipa = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -341,6 +453,13 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -349,6 +468,13 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -357,6 +483,13 @@ static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1b000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
 };
@@ -461,6 +594,13 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb4000 },
+		.prio_fwd_disable = 1,
+		.prio = 1,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -469,6 +609,13 @@ static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb5000 },
+		.prio_fwd_disable = 1,
+		.prio = 3,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -477,6 +624,13 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb6000 },
+		.prio_fwd_disable = 1,
+		.prio = 6,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -494,6 +648,13 @@ static struct qcom_icc_node qnm_cmpnoc0 = {
 	.name = "qnm_cmpnoc0",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf3000, 0xf4000 },
+		.prio_fwd_disable = 1,
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -502,6 +663,13 @@ static struct qcom_icc_node qnm_cmpnoc1 = {
 	.name = "qnm_cmpnoc1",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf5000, 0xf6000 },
+		.prio_fwd_disable = 1,
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -527,6 +695,13 @@ static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xed000, 0xee000 },
+		.prio_fwd_disable = 1,
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -535,6 +710,13 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xef000, 0xf0000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc, &qns_pcie },
 };
@@ -543,6 +725,13 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0xf1000, 0xf2000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 3,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
 		      &qns_pcie },
@@ -552,6 +741,13 @@ static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb8000 },
+		.prio_fwd_disable = 1,
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
 };
@@ -560,6 +756,13 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb9000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
 };
@@ -568,6 +771,13 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xba000 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 3,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
 		      &qns_pcie },
@@ -620,6 +830,13 @@ static struct qcom_icc_node qnm_camnoc_hf = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
@@ -628,6 +845,13 @@ static struct qcom_icc_node qnm_camnoc_icp = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
@@ -636,6 +860,13 @@ static struct qcom_icc_node qnm_camnoc_sf = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
@@ -644,6 +875,13 @@ static struct qcom_icc_node qnm_mdp0_0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
@@ -652,6 +890,13 @@ static struct qcom_icc_node qnm_mdp0_1 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
@@ -660,6 +905,13 @@ static struct qcom_icc_node qnm_mdp1_0 = {
 	.name = "qnm_mdp1_0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa100 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
@@ -668,6 +920,13 @@ static struct qcom_icc_node qnm_mdp1_1 = {
 	.name = "qnm_mdp1_1",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa200 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
 };
@@ -692,6 +951,13 @@ static struct qcom_icc_node qnm_video0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
@@ -700,6 +966,13 @@ static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2a180 },
+		.prio_fwd_disable = 0,
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
@@ -708,6 +981,13 @@ static struct qcom_icc_node qnm_video_cvp = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
@@ -716,6 +996,13 @@ static struct qcom_icc_node qnm_video_v_cpu = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
 };
@@ -756,6 +1043,13 @@ static struct qcom_icc_node xm_pcie3_0 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
 };
@@ -764,6 +1058,13 @@ static struct qcom_icc_node xm_pcie3_1 = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
 };
@@ -772,6 +1073,13 @@ static struct qcom_icc_node qhm_gic = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
 };
@@ -796,6 +1104,13 @@ static struct qcom_icc_node qnm_lpass_noc = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
 };
@@ -812,6 +1127,13 @@ static struct qcom_icc_node qxm_pimem = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
 };
@@ -820,6 +1142,13 @@ static struct qcom_icc_node xm_gic = {
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
 	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
 };
@@ -1836,12 +2165,22 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
 };
 
+static const struct regmap_config sa8775p_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x18080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_aggre1_noc = {
+	.config = &sa8775p_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
 	.alloc_dyn_id = true,
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1864,12 +2203,22 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
 };
 
+static const struct regmap_config sa8775p_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1b080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_aggre2_noc = {
+	.config = &sa8775p_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
 	.alloc_dyn_id = true,
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
@@ -1995,7 +2344,16 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static const struct regmap_config sa8775p_config_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x13080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_config_noc = {
+	.config = &sa8775p_config_noc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -2012,7 +2370,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
+static const struct regmap_config sa8775p_dc_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x5080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_dc_noc = {
+	.config = &sa8775p_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -2049,7 +2416,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC2] = &srvc_sys_gemnoc_2,
 };
 
+static const struct regmap_config sa8775p_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xf6080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_gem_noc = {
+	.config = &sa8775p_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -2068,7 +2444,16 @@ static struct qcom_icc_node * const gpdsp_anoc_nodes[] = {
 	[SLAVE_GP_DSP_SAIL_NOC] = &qns_gp_dsp_sail_noc,
 };
 
+static const struct regmap_config sa8775p_gpdsp_anoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xe080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_gpdsp_anoc = {
+	.config = &sa8775p_gpdsp_anoc_regmap_config,
 	.nodes = gpdsp_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
 	.bcms = gpdsp_anoc_bcms,
@@ -2092,7 +2477,16 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
+static const struct regmap_config sa8775p_lpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x17200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_lpass_ag_noc = {
+	.config = &sa8775p_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -2143,7 +2537,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC_SF] = &srvc_mnoc_sf,
 };
 
+static const struct regmap_config sa8775p_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x40000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_mmss_noc = {
+	.config = &sa8775p_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -2164,7 +2567,16 @@ static struct qcom_icc_node * const nspa_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
+static const struct regmap_config sa8775p_nspa_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x16080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_nspa_noc = {
+	.config = &sa8775p_nspa_noc_regmap_config,
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -2177,6 +2589,14 @@ static struct qcom_icc_bcm * const nspb_noc_bcms[] = {
 	&bcm_nsb1,
 };
 
+static const struct regmap_config sa8775p_nspb_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x16080,
+	.fast_io = true,
+};
+
 static struct qcom_icc_node * const nspb_noc_nodes[] = {
 	[MASTER_CDSPB_NOC_CFG] = &qhm_nspb_noc_config,
 	[MASTER_CDSP_PROC_B] = &qxm_nspb,
@@ -2186,6 +2606,7 @@ static struct qcom_icc_node * const nspb_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sa8775p_nspb_noc = {
+	.config = &sa8775p_nspb_noc_regmap_config,
 	.nodes = nspb_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
 	.bcms = nspb_noc_bcms,
@@ -2203,7 +2624,16 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
 };
 
+static const struct regmap_config sa8775p_pcie_anoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xc080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_pcie_anoc = {
+	.config = &sa8775p_pcie_anoc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -2232,7 +2662,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
+static const struct regmap_config sa8775p_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sa8775p_system_noc = {
+	.config = &sa8775p_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
2.17.1


