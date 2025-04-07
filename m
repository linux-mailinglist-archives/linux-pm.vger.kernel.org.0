Return-Path: <linux-pm+bounces-24884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC543A7E401
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766827A6046
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28581F9F70;
	Mon,  7 Apr 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpjmQL00"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153421F874A
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039012; cv=none; b=m03qmBGZOjmMlFA0X5FY9ELWHDkEMF50CcNTgwhvSF3Yg1yX2VxKPIaFDGg2ueGXwFPmjcCfizoDIsVtZMI7TaIjzj6hJ3Xeb4udoW71y2RKCiLHygJ/qJk8pKbm7MhVq/ojLSI5xrsBRWdoLrJEPSLeAebXD1UkBb0oaeKVg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039012; c=relaxed/simple;
	bh=cDLudgH4vxsTURBTPMUP0AJF/BNkK6tvrJJJ8lvQWq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MuAxir5BttQzW4nIglbWquSEonC5fvM2lidVTPZgGx0UtRn3p9aoqN5HsZH/wnE555rB84HKUJ3mAQyrmnM0KwkIjOYyFG6HrwLpg4mjXUAdrkR4KNEZbYhpb0P4uxP40a6QmYrL0uLEyVrpprN6FWX7vW310Z4AQylWHLMZeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpjmQL00; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so28736295e9.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744039008; x=1744643808; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHxtS4J0SeOr3ZxzwmX/3kxegsMDHDTrAnucHkGuZ+0=;
        b=PpjmQL006M7wYQolpE2vHaXnuzcRjthLQ6pSpAqLxyFRfjMNeEh3+R+VDDnm98SqgU
         78847pYAovj/I0zZ9qr9caPvctGUO1hZQUiuq9Og/QrVCknb5aaO/8okUvrXub1XZPx7
         asbQ5qVtiG24IlxMkIfc4wNSjKB37Ti/sz0ZPnqYiA/6bG5rCdsq5Wph7gNJKXnRgjru
         TIS1IQfUx7TDoLlvv5WnmHlMIXhl79bABUMoFVlAIQJrvkeRpNKNhwvEolpmGy5MOyR0
         f1K/tENEXccLiCLEsKKDpjr5a2APPMjDmjF6v6QWohHjp+PMDUaukjs/NRDMUf0hI/ng
         YGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039008; x=1744643808;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHxtS4J0SeOr3ZxzwmX/3kxegsMDHDTrAnucHkGuZ+0=;
        b=wAQGksoq9p1zct1XnTQB1F1is5EDhp8Uex3Qu08pQireW9KltbEQ57j3kbQxhvMOK9
         tjfEj6uXtFD9iZ7e7knsB1t33WeE4dZ/YEIMtgO8zeE2utwiXGZDtmz9E/rYZSf6GNUa
         /mR4Wmku4KtZHgUkKnbRexu4CcBjudt+Tt9VM+wiROPFAL8QKEQaF8+IDAkAagKHOZqw
         a2mtfI6wMXJXEu62BC7y2aOgse4yNRxWO1Z1ALWOz48oDNLi96rOqiY2LZj6AAu//ISm
         dFSrW7lijFCDPtQuXjePfjFoSjKgm/UGhvSrUPOuKZRNcoMmsWb0KLbauCFH9YaXldcy
         gEvw==
X-Forwarded-Encrypted: i=1; AJvYcCXNOfARWmimuDy2E92HZeYLHKecAJyTdZkG6cXE4lDxQfG83e7hXVFKfkpHNiQpDc4/I0R6wyPTEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRdhHEebvcrJHPP7gpUxjTzTrKo2eFFo+/E+49r9NImPl/9gt
	23PU0sTj8UXIIwEcw4K0jp4q7jiEXvyKYK0jzx61P5YNCGkKo8/i/SNYS2hpGGx42buH4FB6HKv
	C
X-Gm-Gg: ASbGncvaYlj7Urh1lv2mlr7tGU0Wcv9HhxaFK2KRIpkx5aKUAimpslTGRo1JJiM6tFy
	I8Jnn2lXVbfU3elOkbyOWoP2tr2wSRKgkGC0/WHC1pGYO4g5OjsRSdosWNee5EaIge7pfUNIACW
	11hEjCFsPvcvnLxIajh67i5SRZh7qrPChjzI+1GpJOigSU5WhxXLGiI8XxW65GnxAaCRELVytF2
	+e/MLCrPfzzxLSqtCxHX+l56TXcEhmurbT/On+CXTbUHL7Dt8RxUMk2j027iGsjj/GLxpslSsRs
	lZCu8sVWguUkw0F4t4gh3oOGnUt/WksV1fY0MWAVvm3jgLrtckoD62muHP7DQTVHC/DBgoWh+LE
	q
X-Google-Smtp-Source: AGHT+IGtlkm2FnAmTm6aoUfMgNSbdvxD00Rg2GzYVOxFFiE6AbUXYoWZBf5/we9KAdQpaE3i86pUlA==
X-Received: by 2002:a05:600c:22c9:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43ebef8f412mr128932725e9.12.1744039008311;
        Mon, 07 Apr 2025 08:16:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8d67sm133453965e9.12.2025.04.07.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:16:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 07 Apr 2025 17:16:47 +0200
Subject: [PATCH] interconnect: qcom: sm8650: enable QoS configuration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF7s82cC/x3MMQ6DMAwF0Ksgz7WUIkIpV6kYwPy2HiAhBoSEu
 Hujjm95JxmSwqgtTkrY1TTMGfdbQfLt5w9Yx2wqXeld5R68hqjCNjW1d7xFWxP6iVWEl2CMQfw
 AVM2zHikfMeGtx/9/ddf1A7SrQMFvAAAA
X-Change-ID: 20250407-topic-sm8650-upstream-icc-qos-ebc5bee4896d
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cDLudgH4vxsTURBTPMUP0AJF/BNkK6tvrJJJ8lvQWq4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn8+xfKS4DhRl3NOYz28ToCMz8mPGG4xvTWWCmi5B0
 R4Q/EnuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/PsXwAKCRB33NvayMhJ0eBuD/
 9UvBnVf3Aj2HZHSdtv31UIWuaizdmmnK65SlLhh37lIU5pkXvei/4dOtiuKDYuh3PL2+YDfd8efoSI
 HCwG/dMw8qC/FYsCVnvZua1D6InN/JxqvYWZFN//hR0N5hr7LNzBztAVkR6JgXo3NviQMKK0nx8zpW
 oqcusLkjMQehyrreXCqSVheZKBwSU/Mva4/oHtlRCA54UxkKKhLTSavAd/caYyOgp2khH8tr4Sx5pj
 Z3DHtj/8cLr0WzTUPjzug8tTIYJoxvtvZaYoldh3xMBrqHrtwBkLWXP0mIryCMJmJMqyq6GpOknwLY
 BLDG3p/keZsr8KPEZW5Jkp0tsPxGLIxcDMq5HxCD+6L+jGesY4Y6dRPVYfcS6q3WpE0ZRaHQbPHlgt
 FhfNpHtlGzYAZ37bdVPo936m8soKJbwXnQOlaZV3NwuNgbQkLyIQtSDWVkBle3E6T/4rIxN//D6vAx
 fDcxJx4SRhXF277rm8Vu0rEohwV+mocA3JNmi+hfjgB7wexqPbN4kg31/dcglXExGWDa50KXGA8ROi
 NHOLTabpXA1c7c3jpCaHXhFBzhBEPPSd0YRiOZSuF/gB8KRU5oHlvGbyocri8Kf1X/pem3cehJXrNs
 31FJht1HLoYMK4QorZScyW8giDoa8Szotzpv8ZBl8SFwxQPOdi7KSs7t2RQg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable QoS configuration for master ports with predefined values
for priority and urgency forwarding.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/interconnect/qcom/sm8650.c | 327 +++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index 20ac5bc5e1fbafe74800ad6f22839bac006ca7db..f6911891503a7ed65be8bc37ed600e87d4cfcc42 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -17,20 +17,45 @@
 #include "icc-rpmh.h"
 #include "sm8650.h"
 
+static const struct regmap_config icc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
+static struct qcom_icc_qosbox qhm_qspi_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
 	.id = SM8650_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qspi_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A1NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox qhm_qup1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xd000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
 	.id = SM8650_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qup1_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A1NOC_SNOC },
 };
@@ -44,65 +69,128 @@ static struct qcom_icc_node qxm_qup02 = {
 	.links = { SM8650_SLAVE_A1NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_sdc4_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xe000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
 	.id = SM8650_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_sdc4_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A1NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
 	.id = SM8650_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &xm_ufs_mem_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A1NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_usb3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x10000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
 	.id = SM8650_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_usb3_0_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A1NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x12000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
 	.id = SM8650_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qdss_bam_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox qhm_qup2_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x13000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
 	.id = SM8650_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &qhm_qup2_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox qxm_crypto_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x15000 },
+	.prio = 2,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
 	.id = SM8650_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_crypto_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox qxm_ipa_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x16000 },
+	.prio = 2,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
 	.id = SM8650_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qxm_ipa_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
@@ -116,29 +204,56 @@ static struct qcom_icc_node qxm_sp = {
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x17000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
 	.id = SM8650_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_0_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x18000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
 	.id = SM8650_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_1_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
 
+static struct qcom_icc_qosbox xm_sdc2_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x19000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
 	.id = SM8650_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_sdc2_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_A2NOC_SNOC },
 };
@@ -223,29 +338,56 @@ static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.links = { SM8650_SLAVE_PCIE_0, SM8650_SLAVE_PCIE_1 },
 };
 
+static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xbf000 },
+	.prio = 1,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
 	.id = SM8650_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &alm_gpu_tcu_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc1000 },
+	.prio = 6,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
 	.id = SM8650_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &alm_sys_tcu_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox alm_ubwc_p_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc5000 },
+	.prio = 1,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node alm_ubwc_p_tcu = {
 	.name = "alm_ubwc_p_tcu",
 	.id = SM8650_MASTER_UBWC_P_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &alm_ubwc_p_tcu_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
@@ -260,20 +402,38 @@ static struct qcom_icc_node chm_apps = {
 		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
 };
 
+static struct qcom_icc_qosbox qnm_gpu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x31000, 0x71000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
 	.id = SM8650_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_gpu_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb5000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_lpass_gemnoc = {
 	.name = "qnm_lpass_gemnoc",
 	.id = SM8650_MASTER_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &qnm_lpass_gemnoc_qos,
 	.num_links = 3,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
 		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
@@ -289,67 +449,130 @@ static struct qcom_icc_node qnm_mdsp = {
 		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
 };
 
+static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x33000, 0x73000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
 	.id = SM8650_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_mnoc_hf_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x35000, 0x75000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
 	.id = SM8650_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_mnoc_sf_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x37000, 0x77000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node qnm_nsp_gemnoc = {
 	.name = "qnm_nsp_gemnoc",
 	.id = SM8650_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_nsp_gemnoc_qos,
 	.num_links = 3,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
 		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
 };
 
+static struct qcom_icc_qosbox qnm_pcie_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb7000 },
+	.prio = 2,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
 	.id = SM8650_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &qnm_pcie_qos,
 	.num_links = 2,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xbb000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
 	.id = SM8650_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &qnm_snoc_sf_qos,
 	.num_links = 3,
 	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
 		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
 };
 
+static struct qcom_icc_qosbox qnm_ubwc_p_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc3000 },
+	.prio = 1,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node qnm_ubwc_p = {
 	.name = "qnm_ubwc_p",
 	.id = SM8650_MASTER_UBWC_P,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &qnm_ubwc_p_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_LLCC },
 };
 
+static struct qcom_icc_qosbox xm_gic_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb9000 },
+	.prio = 4,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
 	.id = SM8650_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_gic_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_LLCC },
 };
@@ -390,38 +613,74 @@ static struct qcom_icc_node llcc_mc = {
 	.links = { SM8650_SLAVE_EBI1 },
 };
 
+static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x28000, 0x29000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
 	.id = SM8650_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_camnoc_hf_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_HF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x2a000 },
+	.prio = 4,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
 	.id = SM8650_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_camnoc_icp_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x2b000, 0x2c000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
 	.id = SM8650_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_camnoc_sf_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_mdp_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x2d000, 0x2e000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
 	.id = SM8650_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_mdp_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_HF_MEM_NOC },
 };
@@ -435,38 +694,74 @@ static struct qcom_icc_node qnm_vapss_hcp = {
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_video_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x30000, 0x31000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
 	.id = SM8650_MASTER_VIDEO,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_video_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x32000 },
+	.prio = 4,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
 	.id = SM8650_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_video_cv_cpu_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_video_cvp_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x33000, 0x34000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
 	.id = SM8650_MASTER_VIDEO_PROC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &qnm_video_cvp_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
 
+static struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x35000 },
+	.prio = 4,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
 	.id = SM8650_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &qnm_video_v_cpu_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
 };
@@ -498,20 +793,38 @@ static struct qcom_icc_node qsm_pcie_anoc_cfg = {
 	.links = { SM8650_SLAVE_SERVICE_PCIE_ANOC },
 };
 
+static struct qcom_icc_qosbox xm_pcie3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb000 },
+	.prio = 3,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
 	.id = SM8650_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &xm_pcie3_0_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_ANOC_PCIE_GEM_NOC },
 };
 
+static struct qcom_icc_qosbox xm_pcie3_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
 	.id = SM8650_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &xm_pcie3_1_qos,
 	.num_links = 1,
 	.links = { SM8650_SLAVE_ANOC_PCIE_GEM_NOC },
 };
@@ -1325,6 +1638,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_aggre1_noc = {
+	.config = &icc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 };
@@ -1346,6 +1660,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_aggre2_noc = {
+	.config = &icc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1368,6 +1683,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_clk_virt = {
+	.config = &icc_regmap_config,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1429,6 +1745,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_config_noc = {
+	.config = &icc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1456,6 +1773,7 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_cnoc_main = {
+	.config = &icc_regmap_config,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
 	.bcms = cnoc_main_bcms,
@@ -1488,6 +1806,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_gem_noc = {
+	.config = &icc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1500,6 +1819,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_ag_noc = {
+	.config = &icc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 };
@@ -1514,6 +1834,7 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_lpiaon_noc = {
+	.config = &icc_regmap_config,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
 	.bcms = lpass_lpiaon_noc_bcms,
@@ -1526,6 +1847,7 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_lpicx_noc = {
+	.config = &icc_regmap_config,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
 };
@@ -1541,6 +1863,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_mc_virt = {
+	.config = &icc_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1569,6 +1892,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_mmss_noc = {
+	.config = &icc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1585,6 +1909,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_nsp_noc = {
+	.config = &icc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1604,6 +1929,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_pcie_anoc = {
+	.config = &icc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1623,6 +1949,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_system_noc = {
+	.config = &icc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,

---
base-commit: 2bdde620f7f2bff2ff1cb7dc166859eaa0c78a7c
change-id: 20250407-topic-sm8650-upstream-icc-qos-ebc5bee4896d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


