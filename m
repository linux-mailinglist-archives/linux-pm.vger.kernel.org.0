Return-Path: <linux-pm+bounces-38888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C27C9263D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1CBF4E54B5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4932F741;
	Fri, 28 Nov 2025 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LB0GeDGH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KZyang7N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAC32E72F
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342119; cv=none; b=N/1SId4s9DTJeszPhgnZKfOmYw06J4wKZDNgRX1pTpoQUhv/9FakTLDwlbi6Hhfjfh5FeToKV+3pPlNg1DAh6+mxQrm/y0IIc+iT3KKflzUGhLyPI4Ts+OOXttou6HN8BXrZojCRZwmgXzDYsr3L2HgtduUO0/npb4vodDX0Sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342119; c=relaxed/simple;
	bh=9km1I2pgcMQ/91FFoTJHoH798zlB7m1AcKvuKFLa6oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KsoL6WzKtARWPu6ggxDFO63jRyOH7GPu4JapeNnOUXTddTTejMZLIY/u04N2Bc552ooxSL4RrHoVeSJ0lfyaJhW2t8KSjhNWXW2qXiupcBv2OmhrlZ2CgIig1HO2oR4Zeu2ltEGhodl/SJpTtZxHfaGQAWCV54P/PErn/n7xr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LB0GeDGH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KZyang7N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8O53p3476504
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=5smLdyW+9D5/Ow32GcC7gR3VsO37MrITtebluZTL3kE=; b=LB
	0GeDGH2tZVHp6krPk774BZAZIRC3jch0pmDlN379fuauRydIFq5gHKjmMOr0JcpA
	/f952lmRaCAV5PbPmW0KBEYVhfIM+e2YI/4KtXViO8euEK9rFhrP17AznFDvnVcc
	ENvYYXz4/w+nCvpLdsdAnbG5+OSKj6DwVkl13nthg+jKBhEstdd83dQl7rS2mPIG
	YuRvt+1l2cvijR5vrbrAwoSY89Dh+QjAVu1j6z2ulwy5kPz/xecGFwftzU5K5V1n
	9G418CHUyqk9yHHm5qNVuKcYOjyMnhBGTrKdGQVukDGl/xnXUxt0hUSaUreyDckk
	YF88ZOGpWU3cyNR/zJGg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aptpuaryk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 15:01:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956a694b47so25661055ad.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764342116; x=1764946916; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5smLdyW+9D5/Ow32GcC7gR3VsO37MrITtebluZTL3kE=;
        b=KZyang7NQRqPVi+hcJFNIG5N1c1wQD9wa7/k8aibcChSWFZjapWeikhp0o4I3t0hIF
         x11jd9Q72/OwQocxWT95V67k5ixNUcaeDNUknJHmrzmPHhiY2v/ODOCSsMVFoeQEdzyZ
         CTv9spqXxqS5b3j2YnwaYFvgN2Qv0BCt7hbTj4eEkPwPvXk983/bBIy0CUbFvwb+jcda
         DVQT0RLUocv4oH1uPTYgnOhlVaTIGOB2FasDogab/p2Pt/JDhRZXz9gBEOJr7DIS+p8k
         LDCuvHD0cc0TvmiWxg4rLaZcts7Vz6ykTkd/sHXLIR4MkS0ygs00LD5UMamr8rGAl/Sm
         z7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764342116; x=1764946916;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5smLdyW+9D5/Ow32GcC7gR3VsO37MrITtebluZTL3kE=;
        b=Gw4Nbb7xyTTaL2aQhtfSdKb5tnLCtG2ES1yGsANoDu2Zcfx2w9Tji0+GjE4xiom+Eg
         z5adV2Hn9zJbwapZ4FD7L4sc0VMDGyZUvkkHN8OXAJcWrRVkZTFT+UkldlVUITQ8fq2d
         FRYFl0tobg3Uh4aX0hDyfo7Q3SK9agwUausGz99YtIBcegQ3aVPcFLhjBlEQTPk/XZBV
         jUDROmP/7dM2jtYjbwB62FnQpybAtNa0vo5xi11bHPiBsQ9ijO+XcmQbWaaLxoNqSp0W
         mqSi8kDnZHUHGOlzds6TW5KpnfmhDQQ1gl00UpS7WN6nqAAVOTn3Q/4MaFWFUx160Toh
         sl3g==
X-Forwarded-Encrypted: i=1; AJvYcCVcmlgFWPcZCqauYyTKppncdKML6jEktJiRehnE6xH5F5lCKhwBsxIYDO2FvwoaYgUIG2/0jOJV2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9J4KfHgvKTGRZa8c+UyFy+5s5NAAg1Q2YNnc0M6BMu+ASbnJF
	iyreYBmjwBQ2EVJmOWw4Imv8Iuf28SvwuWYIAeRshNCLPHeA468vnGRbXno+CTZx9+QXct1U0oA
	xcGZnUW698rDlGccl8JPsqvQL0oRxYJj3thJ00aWtxWg7ZEIZSwNGHZEBB1g8ng==
X-Gm-Gg: ASbGncuvDTXa4WIWjSiu9qgvyOqxcrRNNNrI327Rv1SNVtuaEcykygyjSh0fnfCYPcG
	EiaGElcqoK4waN5rPfZOCdkt6t9OEf7DIUZjnCxlBakZvxTtYBeQppZmUwQlF5BaLBeJ/xpN57u
	/wH0tW6RDH5BS3XzT04hkJw2U87pZPNroB4iPJxrhA5s7msdx9tZMgimdWlLtCCx4+ICwp2zbJF
	09zTQ32oIqZl7RYOEGZ6Zf3pjxF+m9VpL3yeHbitAuft1WZr8VEhEOhaWkO1e/Qf7DXje/jOntR
	N4vMas5eMCnto5tlTQuncNhpfI0qVC4Z5epqqberGfVAp+YXzacK+DLgitwgaX4TdZf/jaVhg0R
	x2Bf+B+/ypc/UK3kC8mA8XSbR/kiCVbrwMF8WYNrIpbc=
X-Received: by 2002:a17:902:f612:b0:295:557e:746d with SMTP id d9443c01a7336-29bab2f5310mr184664885ad.57.1764342115233;
        Fri, 28 Nov 2025 07:01:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg1BvFuOzfuWovnbrO5J2BcJOIyPe/nmdguPIrpfX5VmA/D36JkC3ND0qIeGhX+4fBxzZeOg==
X-Received: by 2002:a17:902:f612:b0:295:557e:746d with SMTP id d9443c01a7336-29bab2f5310mr184663885ad.57.1764342114379;
        Fri, 28 Nov 2025 07:01:54 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb7cf89sm48930635ad.99.2025.11.28.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:01:54 -0800 (PST)
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
Subject: [PATCH 2/3] interconnect: qcom: qcs8300: enable QoS configuration
Date: Fri, 28 Nov 2025 20:31:05 +0530
Message-Id: <20251128150106.13849-3-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: fmyLicheU4FFzJoITFqW9-UA2S5SHLJw
X-Proofpoint-ORIG-GUID: fmyLicheU4FFzJoITFqW9-UA2S5SHLJw
X-Authority-Analysis: v=2.4 cv=WIZyn3sR c=1 sm=1 tr=0 ts=6929b964 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XWZIYzOgiBrVy7gtqr4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDExMCBTYWx0ZWRfXzT2BHaUJrujU
 ADqWKLOPr4UVd0bbrME8wkEvqnOdyUHUXV0EjicSmHdKzSch+mS+zaCy5d3DSVZjxxfuI865Rfz
 j4tCMS0UL9bGCM5xcJz4AzsSAhcWF4r+bi8CXDrRcSD2oRsGWCpkNfubLPUoRd4uVnAp0YvVQkO
 P1csk8TDSRnbgC1HlHPLi65Xob+Pntfdk3+7csglQkc+FJxZmno5BzUXnncmSVhJTBecwU4JFcC
 ee4RXIp65MvcEzLsOCI3FF/CnArxtAOpmdcnjslU3CDyqtFCBYWDMq+7ckg6/0mdsTtiqJ3cUHc
 sg/VldMKP/bMc+fK91wEAtGIMfAKsOa2ZEcmTGFHd5oLqZQgHp+CvMdlXqEgS5QGAFtNKlTDPli
 7Q2Iazzxv2gNA+x9AGAzM7Sepdlx1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280110
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Enable QoS configuration for master ports with predefined priority
and urgency forwarding.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qcs8300.c | 375 ++++++++++++++++++++++++++++
 1 file changed, 375 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index 70a377bbcf29..3f4fe62148d3 100644
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
2.17.1


