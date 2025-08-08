Return-Path: <linux-pm+bounces-32067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A68B1E9E2
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED9D1C253A7
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0127E05E;
	Fri,  8 Aug 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fiNKD3/l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E827C162
	for <linux-pm@vger.kernel.org>; Fri,  8 Aug 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661845; cv=none; b=RH8M6STmDflWfV1bNIFjk6lDTkw0/065/ou7day3rzgDdREVqs3Ek+RzbUgi7UaKaoR/Ae4Wau/8YmYOuerFjfHHMrLmBJEvA6HyR8ckUD20/SeaXcjURL2nCk0oCN9waCLowwdtJO4nX4eyc6DvGKOWDT0FFabSOI7WD8m9CsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661845; c=relaxed/simple;
	bh=wRE/A8kPesfCce5pnxjzIZo9ulA7b+2n38Egjqz7cU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TMsvT6hXE+FKmenw9rYz6zplDBEbcf03Sc2HkGOUxivROJ1elTh04hMIvFCMMMYpQFdFG/q6lDGtUOFFj1hr7GxDE/WCuYPFhqwMNgfW7lVEhSfLqLbnAUzp9w9cnKdxbO7bzbWCE74p6ZZcnxFp0Z4cTmlQIkYcLkyrtxLf3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fiNKD3/l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786a77g011702
	for <linux-pm@vger.kernel.org>; Fri, 8 Aug 2025 14:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=X1jUhpus4nUviPIA90y3v3oCHbECaPzX5ramSTBCMdg=; b=fi
	NKD3/lmRPj5auxTaCcGnBNBdROugdYXHay0udNlXQ6g12GNoB7NZi6hM/qHyWGax
	3ah11q5M92OxBJy98N1mNM4Iq+cI7VkAekCER0u2VyayW95cor9GasC+ZAJN+fj2
	zUNyPEGbRmW0SJDWpJ3e/enE5mKnsVRDVe57I4W4Qa8gnpVpxPaHwbahcSgckQCw
	aImpOzz/ElzE8eYN6ijugpDaoq48VG0cnZuFrLOzmRHLJDNRIbzSuOT36Rgidzeb
	MT5JWA4IZdzDgCvpfsljJF/CO4V7H414e/T5kpjiz1wTft1UteTxetkMKVHqIrLB
	IzQBxbW/QvExiT6GaN0Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy4yx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 Aug 2025 14:04:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76be7fe3d65so4635418b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 08 Aug 2025 07:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661840; x=1755266640;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1jUhpus4nUviPIA90y3v3oCHbECaPzX5ramSTBCMdg=;
        b=e7FDxo+wA7i3V5vhz2d2VIHxvjgsWdqop2B7XMYQCdkZrkmzpA5t4eRJNdt3vybpOp
         Gvw7yG2UoJ1FKofwxqYA5KQH7RDye8cr0knNdkS8uJT4mxRSubNzeqFXbG5Y17kOjgbY
         PsHpbJfthYkajsArfIUnsyZKhCnR6ZVIsoDOXsbOMdf+PXzeKZu8pOYp8tUMs13EOyab
         F3IQleI0wm1CA3MxAx6CrNamfI0omkrSUDfQrqruptwd9yykoegc9tEDyVrEqXsPMY+/
         8yAfJIuiK1gLYlUoRwKLIdDguKeCmCvrnXMB+P0MToZR4FsypKusWZAjLLMPEYixl+j5
         jWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSrKpMtTi87fA41Sikcur8GXrtLjXYRmuCIBYrYHhDKKxe7hT7FNw8pmjtCXnZYuGWYON6aQfuBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhbqhk7jL/nRme6nyT41ya7H/bpwxuv2cKULLiMbTeLv87ylex
	xqQGS1nIFaZhTnuZO1NABevmV8pTLIHq2ENAovgZ7cYnuaydHFnOxlwsYuSw7x4+dqmLo/Swpgp
	UNyvXxkY8koiGXEaDZhWfRFao+tGKEl39s+P40tjQIAOyDQiBUKu6yDR2TkSFIg==
X-Gm-Gg: ASbGncvIfYaLO4pQFGa2UNdNZEVKhNj/uMlQHVyFN2gOodT5l5F0MVve4uRxXucJ9yV
	O60l8QMBbKcgj0VN/Yr8EtggrDRr94KtqNzPQO03PSNeKK9f5KoYCZX2po0eVmLYxHKOrZsrESW
	w2uu+f3dzccWDd3QO4ctfHhffg6xPIeQcGVhySmz0VqEVQ7Wx8LnE9sVoYuCrgrVbu4MQOWy8Pw
	cHVVAT463unFbMoeRN3uCFhu0Dg6XokTTsNGM+6zLJDbIdcXcWI+u/f+rzmPP0ymjN+FLlqgP8x
	BgjKb5MDmh6/dhaYNQfsIkeaxEOWocapxBjGMrdmKZ+aTVdNUAknkcZ5bA/2BQKfF03AsazGyQ=
	=
X-Received: by 2002:a05:6a00:3998:b0:76b:d8c8:2533 with SMTP id d2e1a72fcca58-76c461c99e6mr5583171b3a.24.1754661839483;
        Fri, 08 Aug 2025 07:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmke0SjKcj6jzCrc6Ci/fc/vKhpyG7BqmGupOWkg+VaHH175rZE935035iLs/JYskb+1XZMg==
X-Received: by 2002:a05:6a00:3998:b0:76b:d8c8:2533 with SMTP id d2e1a72fcca58-76c461c99e6mr5583090b3a.24.1754661838927;
        Fri, 08 Aug 2025 07:03:58 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm8595621b3a.117.2025.08.08.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:03:58 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 2/3] interconnect: qcom: sa8775p: enable QoS configuration
Date: Fri,  8 Aug 2025 19:32:59 +0530
Message-Id: <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=689603d2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=I8WKV2cH2hVkXcs4O-MA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: PpfqikNyLLDO-p2qgm5W_bnLYHVuT_AF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX8nIUboZPJClB
 pBPUtRB03jIF7wljNgMpMGzfxmSg8/6zs2+CGTDVd1CNCDo5KysJKomwE3eSOlLmRu9rUCMXHqZ
 OVdSVVvopK8P7DqidE94a52MSwvMvUWLj8CN/knPBEPO1VuS6SwK4ep/1DyQl7jJke71D9Hgvqh
 dRxadvS5/ViIXrynDigi2aOUI1H66KPl+KSwNr8uKyXmR/6fh3aby9Aj+xS6F+xYlSgOUtDvaFT
 BQgG9+jazuS5gM332ay5T+pL9tMlWM+h4lIj0f41O8u3+rZXvOucAyLC1UxGd8Fqu778P+4Cpdl
 sPULMNAoYAcIQrp0v4Ci+WejmZktk51zYkMiXFOgZOdKYL2m3iUwWyrhn2xWqrbZEhzyn5ef/Qt
 PH59RIXO
X-Proofpoint-ORIG-GUID: PpfqikNyLLDO-p2qgm5W_bnLYHVuT_AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Enable QoS configuration for master ports with predefined
priority and urgency forwarding.

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


