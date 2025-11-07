Return-Path: <linux-pm+bounces-37627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C2C40C60
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2691886AC9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1F331A48;
	Fri,  7 Nov 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="26mY4/HW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986C29ACFD
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531738; cv=none; b=h7qBh+mBweibpPdkF81fSqx/OcYTFtNCu/YnLXAH42PI6koR8+dLty7BIIAzSNQOEtcFAt7kYd2n3X6OuzOpfJ4xZcPI/NKxGgmjwFp7//lFheC4QCuAPOGFWdBs94yssamBZ+OOqlpH798mpoqe+fBDiVNCHre09p5A42DRAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531738; c=relaxed/simple;
	bh=PpqpMgS1hpomQ6JwbVbN+tPs9Mxa/GpmHN/usrG63lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obaW8VRsZfueLWYJl4fH4f88MrNlR1AxoZ6i+xtajXeYRk7StpzXJdeQztstTG17ffKrcYhkDR+IXmrMR5zSog1WsQiJ0wbDmcQCH/olMegzvH78YWT5K1FvhC8ivQRXGaX6+gJXGMoAM+xKe6P/erbs+bsSpY5dbsuaHU0zf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=26mY4/HW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7277324204so162763666b.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762531733; x=1763136533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ixmMs187HyTCXiOg3SqybOsPw0p4b6tY7BYTbThlck=;
        b=26mY4/HWDITbrQkl8OIzUaU6fkduBtx+igNla+294kT7vucZEeoX0lcOoC8+bi/UAQ
         YBHI94jnRak17oSDk2UEaXCxHG2cv45I/5lSqveUswdGiE4tXSYEJygOAhWJAj+kaDsh
         ieL1PbgUtdWkEmEgobFbazuvMIy+L9tvnIj+WbldbbwZtCU/y8LcP+Bh0EGGlvOAU+c4
         dwkkBIyiElpLEQENcfoHiwJJkbdlX/xQ49TnRZha2aiB8Ao2uyFkdKu5INqQZNEfvEKi
         dp8bjUS/A5PZ/UqlzQy0qSfRNJ2MlE/Kx1MGPjiLxaupslK0Danq6yGbSbcag46hMmj/
         fmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531733; x=1763136533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ixmMs187HyTCXiOg3SqybOsPw0p4b6tY7BYTbThlck=;
        b=o/Z94RPpLgvhy3a92wkhe0aWevswk8aoDFxbmYEx69qU83rwZZNHHGKwULa7RsMTZV
         Nh5BuNPrdNsb7AeYwudmJkgSSa16lDs2QX3MaNAL6ZGoNp79dIdi57s2lVGT0cymJ5Lw
         Di9Y9m0OHQMUWs4n8I3/pEtzdIsyyUxRZyWaugRSL+G5+bSP8rCZ9hp9RaEmRc9XnM4r
         DmXJlP4s1qE6NPNuelVUMGKNvaPkIZkq9/mA/jMxQlj49aeui0p+yyXRTDCCaiK0oj7A
         DCZUoEu8xBW4N4QEOi2kbcrHqz8jSvT/i4oMziWMjWW7bv2bJurdWveYgTD0nCHmX0dZ
         2d2w==
X-Forwarded-Encrypted: i=1; AJvYcCWDhUleLs/6CE/MEJ3hSJNpPrErnM5bBoRtDA6AteqgTTYNF2H0AH+vxUI8GxrejiB3Xw6MigVusg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5M/NbXMYOjX66OkPRmqTueonNf6QxwxqL/nj7/zUK3alEKfE7
	XvHqcwP+zKd9cc6Yn4WuKpU1YvOKOeLA1s3/H/5VDm9q7p7bHTLBtCk/s/AYj8SK+Bw=
X-Gm-Gg: ASbGncuj2hX3VeX1c36J5hQ1cl69C6z3apd8jTKRNsbb44GuD3oD20R4aUbu9oNRxkf
	A77gZt/g/irWMLEd0NmiHUwDqZ4laSJGcYFpc/1gOymYNz94tEefd0RQKLQp7j/0s4RvyVXvFse
	QY51ih+24lFzaV6iqPCbTsyGirqg1FSCFP93OL+irWulykURezCH0ItoNNAQfgrYt03MT9FoID3
	AjPweaBjsiSSW7ZykRfnc0G/2QcF6yLAJJGEKgcFw43AEI9BhhjPI4hvINaa+DwBvd2kqQ03nAo
	E9DuPQ0DPxN1jMVZxCOMSC5/Sz6GGdqim1QSxhnpqjMkqjfTNqywWmwKgCEPyrKh5Y378L8eZlg
	ILB2UjdVhCcuZb8d414Jh4kazLej/YlKD5bk0WGQFknKmhQe9dQHvc0tnKjUSPsCD8Bh7MxaKEt
	ipeFsTD75+jEtW5356AhH6uhvtlhkvp5j15kQsoteNtxvNnGyWOlhtW3E=
X-Google-Smtp-Source: AGHT+IGRv7zDul3pvBNfDIiuYqSlparnu5fBZGEE8fRzHUUJvdA2eaRiJDSA7LVo3W+rpRWwBx/V0A==
X-Received: by 2002:a17:906:953:b0:b72:c1e9:5f1e with SMTP id a640c23a62f3a-b72c1e9615fmr299315266b.3.1762531732925;
        Fri, 07 Nov 2025 08:08:52 -0800 (PST)
Received: from [172.16.220.100] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713959sm4444376a12.5.2025.11.07.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:08:52 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 07 Nov 2025 17:08:50 +0100
Subject: [PATCH 4/5] interconnect: qcom: sm6350: enable QoS configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-sm6350-icc-qos-v1-4-8275e5fc3f61@fairphone.com>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
In-Reply-To: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762531729; l=15099;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=PpqpMgS1hpomQ6JwbVbN+tPs9Mxa/GpmHN/usrG63lM=;
 b=PUTrVMKteKXqivWAazJTOUHP/hxxIYZVjk8dt+qH7Y1W2PXkDO1b5Yc/HmN3pGA3Jnw7SuTP7
 Qx2gW13BpvJDZ3kw0jQD8BOWLf0M5kRstaa7X2RyTWtyEMaKdvaZAl0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Enable QoS configuration for master ports with predefined values for
priority and urgency forwarding.

While this does require some "clocks" to be specified in devicetree to
work correctly, thanks to ".qos_requires_clocks = true," this is
backwards compatible with old DT as QoS programming will be skipped for
aggre1_noc and aggre2_noc when clocks are not provided.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/interconnect/qcom/sm6350.c | 288 +++++++++++++++++++++++++++++++++++++
 1 file changed, 288 insertions(+)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 246549cb761e..d96bec1cbb26 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -150,26 +150,50 @@ static struct qcom_icc_node qhm_a1noc_cfg = {
 	.link_nodes = { &srvc_aggre1_noc },
 };
 
+static struct qcom_icc_qosbox qhm_qup_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qhm_qup_0 = {
 	.name = "qhm_qup_0",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qup_0_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
+static struct qcom_icc_qosbox xm_emmc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x7000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_emmc = {
 	.name = "xm_emmc",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_emmc_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
 
+static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x8000 },
+	.prio = 4,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_ufs_mem_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a1noc_snoc },
 };
@@ -182,58 +206,113 @@ static struct qcom_icc_node qhm_a2noc_cfg = {
 	.link_nodes = { &srvc_aggre2_noc },
 };
 
+static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qdss_bam_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
+static struct qcom_icc_qosbox qhm_qup_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
 static struct qcom_icc_node qhm_qup_1 = {
 	.name = "qhm_qup_1",
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qup_1_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
+static struct qcom_icc_qosbox qxm_crypto_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x6000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_crypto_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
+static struct qcom_icc_qosbox qxm_ipa_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x7000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_ipa_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
+static struct qcom_icc_qosbox xm_qdss_etr_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
+static struct qcom_icc_qosbox xm_sdc2_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x18000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_sdc2_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
 
+static struct qcom_icc_qosbox xm_usb3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_usb3_0_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_a2noc_snoc },
 };
@@ -278,18 +357,34 @@ static struct qcom_icc_node qup1_core_master = {
 	.link_nodes = { &qup1_core_slave },
 };
 
+static struct qcom_icc_qosbox qnm_npu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0xf000, 0x11000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_npu_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_cdsp_gemnoc },
 };
 
+static struct qcom_icc_qosbox qxm_npu_dsp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x13000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_npu_dsp = {
 	.name = "qxm_npu_dsp",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_npu_dsp_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_cdsp_gemnoc },
 };
@@ -401,19 +496,35 @@ static struct qcom_icc_node qhm_cnoc_dc_noc = {
 			&qhs_gemnoc },
 };
 
+static struct qcom_icc_qosbox acm_apps_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x2f100, 0x2f000 },
+	.prio = 0,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &acm_apps_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_llcc,
 			&qns_gem_noc_snoc },
 };
 
+static struct qcom_icc_qosbox acm_sys_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x35000 },
+	.prio = 6,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &acm_sys_tcu_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_llcc,
 			&qns_gem_noc_snoc },
@@ -429,53 +540,101 @@ static struct qcom_icc_node qhm_gemnoc_cfg = {
 			&qhs_mdsp_ms_mpu_cfg },
 };
 
+static struct qcom_icc_qosbox qnm_cmpnoc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x2e000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_cmpnoc_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_llcc,
 			&qns_gem_noc_snoc },
 };
 
+static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x30000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_mnoc_hf_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_llcc,
 			&qns_gem_noc_snoc },
 };
 
+static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x34000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_mnoc_sf_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_llcc,
 			&qns_gem_noc_snoc },
 };
 
+static struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x32000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_snoc_gc_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
 
+static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x31000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &qnm_snoc_sf_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_llcc },
 };
 
+static struct qcom_icc_qosbox qxm_gpu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x33000, 0x33080 },
+	.prio = 0,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qxm_gpu_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_llcc,
 			&qns_gem_noc_snoc },
@@ -497,50 +656,98 @@ static struct qcom_icc_node qhm_mnoc_cfg = {
 	.link_nodes = { &srvc_mnoc },
 };
 
+static struct qcom_icc_qosbox qnm_video0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf000 },
+	.prio = 2,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_video0_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
+static struct qcom_icc_qosbox qnm_video_cvp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xe000 },
+	.prio = 5,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_video_cvp_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
+static struct qcom_icc_qosbox qxm_camnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0xa000, 0xb000 },
+	.prio = 3,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qxm_camnoc_hf_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
 
+static struct qcom_icc_qosbox qxm_camnoc_icp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd000 },
+	.prio = 5,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_camnoc_icp_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
+static struct qcom_icc_qosbox qxm_camnoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9000 },
+	.prio = 3,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qxm_camnoc_sf_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_sf },
 };
 
+static struct qcom_icc_qosbox qxm_mdp0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 3,
+	.urg_fwd = 1,
+};
+
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qxm_mdp0_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_mem_noc_hf },
 };
@@ -616,19 +823,35 @@ static struct qcom_icc_node qnm_gemnoc = {
 			&xs_qdss_stm },
 };
 
+static struct qcom_icc_qosbox qxm_pimem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd000 },
+	.prio = 2,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_pimem_qos,
 	.num_links = 2,
 	.link_nodes = { &qns_gemnoc_gc,
 			&qxs_imem },
 };
 
+static struct qcom_icc_qosbox xm_gic_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb000 },
+	.prio = 3,
+	.urg_fwd = 0,
+};
+
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_gic_qos,
 	.num_links = 1,
 	.link_nodes = { &qns_gemnoc_gc },
 };
@@ -1388,11 +1611,21 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
+static const struct regmap_config sm6350_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_aggre1_noc = {
+	.config = &sm6350_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
@@ -1413,11 +1646,21 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
+static const struct regmap_config sm6350_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f880,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_aggre2_noc = {
+	.config = &sm6350_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
 	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+	.qos_requires_clocks = true,
 };
 
 static struct qcom_icc_bcm * const clk_virt_bcms[] = {
@@ -1459,7 +1702,16 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 	[SLAVE_CDSP_GEM_NOC] = &qns_cdsp_gemnoc,
 };
 
+static const struct regmap_config sm6350_compute_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f880,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_compute_noc = {
+	.config = &sm6350_compute_noc_regmap_config,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1532,7 +1784,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[SLAVE_LLCC_CFG] = &qhs_llcc,
 };
 
+static const struct regmap_config sm6350_dc_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x3200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_dc_noc = {
+	.config = &sm6350_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1561,7 +1822,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
 };
 
+static const struct regmap_config sm6350_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x3e200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_gem_noc = {
+	.config = &sm6350_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1588,7 +1858,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
+static const struct regmap_config sm6350_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1c100,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_mmss_noc = {
+	.config = &sm6350_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1643,7 +1922,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static const struct regmap_config sm6350_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x17080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sm6350_system_noc = {
+	.config = &sm6350_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,

-- 
2.51.2


