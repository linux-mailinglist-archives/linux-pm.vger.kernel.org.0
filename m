Return-Path: <linux-pm+bounces-41882-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JLmIVxNgGlQ6AIAu9opvQ
	(envelope-from <linux-pm+bounces-41882-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:08:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B14C911E
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E49B302A573
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 07:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84230E0D4;
	Mon,  2 Feb 2026 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dX7BQ35K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jjwbN3c3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C330DEC0
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770016000; cv=none; b=HH0GZ7OFhfgHLW3JMhMDuxjJYNnqEEcejWHI4+X6/XG7xvD/2SEOFKtIcEM/m3FGxWGT5VwEpBWmNCACDt5waScm74gDpuUFkvTeD0WIbXu1zvCFTKJFm8s+PAl7sVMSvSH/73B6sSNE0/Jl4Sz1+3T6ix6jZsc4K5whC0l4qtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770016000; c=relaxed/simple;
	bh=B7tlSaRxoVzDVzgWIvLFZJvfgJWCbLmlyzh9k+uC7R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3JIY5HbZABZIRlom8Ub7Bsr0Lb9yKl+LWa+uEUwZB0NBy0kW5a1sOCRvcvVC5EZ9Q7qoeyKzLqtqHIUVqwzPjR+oy/Xd4/B8MmRGKPiWw4KnuxYjyFEv5mNJDt1+7S99xwldJQwqMiDunC5pLZP8qVldIxHw0O3l0H0WSQlOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dX7BQ35K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jjwbN3c3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611KaOw5429991
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 07:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LhcnCaZGEe3
	cTjSbYgHfJXBp6F4JDXqmAu7e6xxYU4w=; b=dX7BQ35KC71lPZDDga7/C4w8RBZ
	wLKWZPmst4ouQ0OLMHEpT71X6I7nrAuUi0kAbk+Up3mlgi5wHdyzGm4Yl4n+ud4k
	m5tx1khV/oDqTGCWeSvp77Hm9TywP95qNLsn42wUuseKY4OXllUl9ErRg7Xd7uxb
	2IHG3I/WSBNI4rb7+/PWNhJZOmyVh0Cb+95spJL7x/Iz2/kRqFL/pnD0EgXM1fjX
	UNGBrox67bZOqNX8uWJb6ScnB/IojZMJQYDnEAFSfNFoTKh9/fvZjgDLLVxAC4mj
	V+IeCPlo9L2Yk+PJgvieTMSMBttMpzG9g1eFqpYGGajVw46iUQdzmdGpSzQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avx49cj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 07:06:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f42368322so3577011b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 23:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770015995; x=1770620795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhcnCaZGEe3cTjSbYgHfJXBp6F4JDXqmAu7e6xxYU4w=;
        b=jjwbN3c3zC/GIAwjMeHiB3Qi/Rp7DMq1vFgtG9F5RtgTxh6BkPFPclXHpDP3B+GAEi
         ir83BYm/6fsVThATYim/mYVoSXx2wisrhiOv2HVnSUhNlRSUE7jY+aaW5mfsBzvM6oyu
         7WWsXJ98CuKNn3IqtFXBxqF2lrm21pqaCdKp50HLagwflBxGdGQH/e4O9Fg+c7o32LlI
         xLv3JiywI4AB1s+A+f5DPxGMGSiMrI8ZiSL56c+AAWOt1vPSsHGRC8rcKhwH2igRD3/L
         xpK30lUyitHQeqWAtkvlBlOmVgHwoW6XDIGjpDFrjjuc+4n8ioml18QMdUQsh838Snpz
         lVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770015995; x=1770620795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhcnCaZGEe3cTjSbYgHfJXBp6F4JDXqmAu7e6xxYU4w=;
        b=IlMLLnXccykhf9HKLYYe0IIWBbf5SoQcGSGz2xYGA5I6zPhxw3DpS2rQy3gICpmaVO
         N2b9eHaNZZtnwHaFtNTA7O+5FptqP3Mr/z+lKNIV7xgRd4ASDAOgUnAWGT/9IoyRu/Nn
         RPdBpbVbnqBJOR+NUODq8Bc2Y1fdunse8JMk0dp2949waDY/e9kkl7TaYk+Bn8hEa90n
         oveMYZN35mY+N6X4Z1XKQFbOtydy5FFJuimryBxW2CFsyYupKNJhfZKYT0ygSgM23iLT
         q4dvool0/ihxt6Kd3GFJCMCm4cyGcnr1LVbPxsHYVc3RAXB9RoR/6ShzG8FliT8hHOja
         /H2A==
X-Forwarded-Encrypted: i=1; AJvYcCWdvjzPGxAAZoJyoHxCd/CpHlaiCHJMYKsmEoQWXcAJ1xrVdMoFh2H8wQ2g9N/okywMa2oySO5UdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzohrDcAaX0uWeAda05SHffbHoCVfWWMlMhncPR3T41+iwEkrHu
	0Uca0gGGfj9fQxVMmbigyOlZaxUnI0qiMTrYmy8h/MKuSsMQrSrZhw4sXnBByCkxyLn6bfntr8Y
	2GBFs+4BNKMKv507bN38hLtmv/hsVRaiygNxSesnvgRmKNGQ6Heg89fH93WgUI5zj0vMa+g==
X-Gm-Gg: AZuq6aIHVytvfDmXgy99U9/jvXsSrDyj1EglTQG537W9c9GKHGQRCg0Tk0eC7bB4Bi9
	quS9+tpvuEI6nylohslw1fRd/9TBC+1TRwut7TkV5CBEwc/p8GGrvnpwW/Bi9WbjxcSpe2JvmYu
	XMZbiuWD8rBvdC22vXl46qnmqGpVOxoyvwvANeE9ZOG/D9T8Iye789fnIST690Sjr6KXtcKiSLS
	ZSeCnZX/VZnoCjd2zbTU03mALCfKfjkZt+cPZ7y8P+AlLHhO6Wo1hO9ssuOXsPB4dYjM5+K9fBs
	ixgc/JRq72rp/BGV7YAuAnAW68SwWJT0KcjvDqLPaDJpWARSZ7UBH41V3l58oMCXAFLrR2KmCWG
	4g7eGr4DFc5YtMDo9jRZFvjFtlnPJp8jZxWxawKtLV7Y=
X-Received: by 2002:a05:6a00:1c93:b0:81f:5acb:55e5 with SMTP id d2e1a72fcca58-823aa40f7e3mr9467831b3a.2.1770015994776;
        Sun, 01 Feb 2026 23:06:34 -0800 (PST)
X-Received: by 2002:a05:6a00:1c93:b0:81f:5acb:55e5 with SMTP id d2e1a72fcca58-823aa40f7e3mr9467810b3a.2.1770015994315;
        Sun, 01 Feb 2026 23:06:34 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54fcasm16265727b3a.66.2026.02.01.23.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:06:34 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 2/3] interconnect: qcom: qcs615: enable QoS configuration
Date: Mon,  2 Feb 2026 12:35:33 +0530
Message-ID: <20260202070534.1281652-3-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k9arxptG5JkMNrZ-aB8zZqxmu6rMaJPF
X-Proofpoint-GUID: k9arxptG5JkMNrZ-aB8zZqxmu6rMaJPF
X-Authority-Analysis: v=2.4 cv=P4w3RyAu c=1 sm=1 tr=0 ts=69804cfc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_F59LTAU7XM1lwoZ_igA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA2MCBTYWx0ZWRfXynrYGQmjAxWp
 RC+rZogyvXGcLvgyxaD8SCmPCpWB2MvIU1rlkLPaiLDmks6icvBb0l8gzbeHAtUcV1TPgXIpDkc
 AyVtbggDRQVmeMhFEijJR8DgEVlU+wlRHig4VD587Yr4BvNuUF8mUxNBEqa1oNVpNy1QH4IfM3z
 hi15twx8zcSp2denIIhFH6HtyAyqHKLYsuUIlSatF0jARulIKzyST97H14Mr9zw7udu4r8Yptn/
 KM9R90Ifk7oE8OsPBh9Xj49hTVnFZMRqCaHd4n4VdbKkaY5HwnbIOELmud4i0WGsFWiH47i6Zu6
 xq187avcTJ93DPhAjSdyj1RSfpKdPAC7JQj+HmaffFvr48Kd2SRHaToBFwmUSoZiplqaiqqty8p
 EobBQNrYcGQNCoE/e1Wes9M/HNv96IHbLdSCuwLAz5gPE0qRXagWzWcPqXVGiJ/58G+IDSFDDBZ
 6cUXNQDjMb22ElTjU9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41882-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45B14C911E
X-Rspamd-Action: no action

Enable QoS configuration for master ports with predefined priority
and urgency forwarding.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qcs615.c | 247 +++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index 797956eb6ff5..017a6017421f 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -142,6 +142,12 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -150,6 +156,12 @@ static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x17000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -158,6 +170,12 @@ static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x10000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -166,6 +184,12 @@ static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -174,6 +198,12 @@ static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x4000 },
+		.prio = 2,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -182,6 +212,12 @@ static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x5000 },
+		.prio = 2,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -190,6 +226,12 @@ static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x6000 },
+		.prio = 2,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_lpass_snoc },
 };
@@ -198,6 +240,12 @@ static struct qcom_icc_node xm_emac_avb = {
 	.name = "xm_emac_avb",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -206,6 +254,12 @@ static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_pcie_snoc },
 };
@@ -214,6 +268,12 @@ static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -222,6 +282,12 @@ static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xe000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -230,6 +296,12 @@ static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -238,6 +310,12 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -246,6 +324,12 @@ static struct qcom_icc_node xm_usb2 = {
 	.name = "xm_usb2",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -254,6 +338,12 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -356,6 +446,12 @@ static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x2e000, 0x2e100 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 3,
 	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc,
 			&qns_sys_pcie },
@@ -365,6 +461,12 @@ static struct qcom_icc_node acm_gpu_tcu = {
 	.name = "acm_gpu_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x36000 },
+		.prio = 6,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
@@ -373,6 +475,12 @@ static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x37000 },
+		.prio = 6,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
@@ -389,6 +497,12 @@ static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x34000, 0x34080 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
@@ -397,6 +511,12 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2f000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
@@ -405,6 +525,12 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x35000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
@@ -413,6 +539,12 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x31000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
@@ -421,6 +553,12 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x30000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
@@ -445,6 +583,12 @@ static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -453,6 +597,12 @@ static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -461,6 +611,12 @@ static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x9000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns2_mem_noc },
 };
@@ -469,6 +625,12 @@ static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -477,6 +639,12 @@ static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xe000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns2_mem_noc },
 };
@@ -485,6 +653,12 @@ static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xf000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns2_mem_noc },
 };
@@ -493,6 +667,12 @@ static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.link_nodes = { &qns2_mem_noc },
 };
@@ -559,6 +739,12 @@ static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 2,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_memnoc_gc, &qxs_imem },
 };
@@ -567,6 +753,12 @@ static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd000 },
+		.prio = 2,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.link_nodes = { &qns_memnoc_gc, &qxs_imem },
 };
@@ -1213,11 +1405,21 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
+static const struct regmap_config qcs615_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x3f200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs615_aggre1_noc = {
+	.config = &qcs615_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const camnoc_virt_bcms[] = {
@@ -1289,7 +1491,16 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
 };
 
+static const struct regmap_config qcs615_config_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x5080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs615_config_noc = {
+	.config = &qcs615_config_noc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1302,7 +1513,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 };
 
+static const struct regmap_config qcs615_dc_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x3200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs615_dc_noc = {
+	.config = &qcs615_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1331,7 +1551,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
 };
 
+static const struct regmap_config qcs615_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x3e200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs615_gem_noc = {
+	.config = &qcs615_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1376,7 +1605,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
+static const struct regmap_config qcs615_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1c100,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs615_mmss_noc = {
+	.config = &qcs615_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1418,7 +1656,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static const struct regmap_config qcs615_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f300,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc qcs615_system_noc = {
+	.config = &qcs615_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
2.43.0


