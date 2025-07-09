Return-Path: <linux-pm+bounces-30485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81019AFE9D8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8524642C99
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170D2E173E;
	Wed,  9 Jul 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="L5yDGgLF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36F2DEA88
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066913; cv=none; b=ZecODPNeWvOfIZ7cY5nIM5tnyaD8/F4j+JaWruj0Y1je4U0HeMKkgiX5GITmT5GQ3ZccTxslH/2lmEP2L+Hq26+n2rpsMuv6tR9iH9xhxGPmotTH7a5layYJTd/6+38NofbZhH8o3G63U08zK+ctVrJC+RNyObLhR4EV8/DYi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066913; c=relaxed/simple;
	bh=uOtsvxX28VHKModFsruRnvvHqq2mOzlx97Yx5Sz+a3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ3PZzkTwJZ5HLlmGWDtB74dT1DgeKFpWP/SGy8O5w3v0UpOSJJJsBPBK8GegKFeS3QJPTKPsjNBbSDHs/lEuHM2eKwtZsgy4dG8zTdlf/f7CNm1xxCkbiH40woFsgYec9NdE0dsiJieJ9uw+0lx2hKNZt2aoXt5k833hdriSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=L5yDGgLF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso10691094a12.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752066907; x=1752671707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z53nTTMieFb81wED7x/CZyEzN0HYoqL0ttbx9jBS6Xk=;
        b=L5yDGgLFamG7tFegiU2/GKbDrdmIARV0ryyVkvODxLbULe7uQ0q4O6TDORROsyBwCf
         4Suc6a6sc4huAfo6sebDeWm/vUp4Yp755yBBAC5XPe6NIJ7JmwrIWd/NietxrKh6ukGf
         LdWk0MJOH+hcrBpWuPCTcEEmPjG/xtYCWh+jV2Rb5zHuiZ57qyhT1NA430EBPKqHvFlF
         v/udxENmwPisC8qPtNwJgtf//tWD25RzhbJw8LtrI58iC5vYo9QD6ADs0Q0CF5MOoQW5
         X/8IVgZflfVrOBGYyVu0gqhEsr4GN9fZsIdAPBBc4mn9weUAwD5cF0ApJFSKkGkxNUWE
         JeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066907; x=1752671707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z53nTTMieFb81wED7x/CZyEzN0HYoqL0ttbx9jBS6Xk=;
        b=KWiOiN/slydyx5P2/9s79QRtwy4v/qgHl3A1RhuGfZqk4+mO619aCYauf0QNRBkfbp
         1ea4UE2BMj7acPSnil1klzRg39V37s3GLk9EODOxsEv7tS7fUyOiH8lcIEMbJ8DbrOfw
         7O6JZ8HGF2erEXLp5DALbdCaf64XafHdbSA5MMVuCv1Goc3HvY9MBP90HZTV5gnygaYQ
         zE6IQMFRZeRWyyRUVPb4Q3ujD/AQFVMpChDdiVAKzpOtUAN3hHIljZJMEol2f1Dz66On
         F34sSQEAiPVspURes7HkN+/zGeFJ0ZhqU+h5EQhWbOceLNtrYmv6Tgc9zI7tZZhOjnPs
         /fcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHPjpjxtTB0gfJyfmEsuTInCV7EcrOhllGUoKIpzHz0EtTZVbMYXTmQzT/q7zhvyMizy2g9sV6Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzD2n3oi3E5ujRBBqzTkYDpPYyd7NsrnqsfDEJ/qOdxAcdCfm8
	qUp5cBDww3MiD8GqPwAWnopadd7nzY1R4UzOawZE2tnFOtM1LMY0sJmTZK3r9FxXCS4=
X-Gm-Gg: ASbGnctO2YQ9Jzw/muV8TBpI4u+EDuWCTakOPkqNbIkqmlIuL9yaRcHNPZtnU9zW1lH
	RS0B6T2bQuyjiK3Gp7ycLHmFOeCobQJ9KdZoMOMNnRaCyvFBb3Jp20ceUtfYbehvECO5XVstb/y
	8iNY73F7GZBoyuuRD5dCyQtLPRkwheuzarEZGQ3zuIN6ZwCKe2JTcqVSC+Zqdnp1g+KAkz8oUKV
	OVggBo9wdgSBXILMCwf/nq/F6oSbaUKzg3LKBa3qrSyY8MsGwTVhKPky8CxrdTO8K9wpSo8u0in
	8GfowMNJtmZpNbpMoWH2qiJIAQrxsUeFG+LYgM+rzO3TfxT+f7kXGJFDf5RmUSk0L2JuvAlEcDm
	u2W1yoa/sCvofX3Jw6iTk+OL3PC73C+Be
X-Google-Smtp-Source: AGHT+IHlFzlPIgyRrecMiKDMPNHQaYxvTV1S9AFsqnggu5RdTTTdpTGjujDl7zjum47sA3WiSn66pQ==
X-Received: by 2002:a17:906:9fca:b0:ae3:5e2a:493 with SMTP id a640c23a62f3a-ae6cf799fcemr234278466b.49.1752066906349;
        Wed, 09 Jul 2025 06:15:06 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d91ffsm1105542766b.14.2025.07.09.06.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:15:06 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 15:14:50 +0200
Subject: [PATCH v3 2/2] interconnect: qcom: Add Milos interconnect provider
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-icc-v3-2-c446203c3b3a@fairphone.com>
References: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
In-Reply-To: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752066904; l=49867;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uOtsvxX28VHKModFsruRnvvHqq2mOzlx97Yx5Sz+a3I=;
 b=BjGIQcxjW75PpfEXz1M5kq7vOSo7Gdg8cEkmHb4NbO5y6b6NzNf8cw4iLGpm/z3zkNs0wLfne
 fXsDZadoswbALIFoAmOhZjVOdANd3mCOcfppPxqeqOE7/1wZQcbKGhI
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add driver for the Qualcomm interconnect buses found in Milos based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/milos.c  | 1837 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1848 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 1219f4f23d40ecfe6ec54af590a2d71ef01c9384..31dc4781abefb50a8b6ca1d8a6efed369c47e1a6 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -283,6 +283,15 @@ config INTERCONNECT_QCOM_SM7150
 	  This is a driver for the Qualcomm Network-on-Chip on sm7150-based
 	  platforms.
 
+config INTERCONNECT_QCOM_MILOS
+	tristate "Qualcomm Milos interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on Milos-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 7887b1e8d69b6b0193464835dbe57414f99554bf..f16ac242eba5509a8649bb4670dd0848320e5be9 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
 
 interconnect_qcom-y			:= icc-common.o
 icc-bcm-voter-objs			:= bcm-voter.o
+qnoc-milos-objs				:= milos.o
 qnoc-msm8909-objs			:= msm8909.o
 qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8937-objs			:= msm8937.o
@@ -45,6 +46,7 @@ qnoc-x1e80100-objs			:= x1e80100.o
 icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
+obj-$(CONFIG_INTERCONNECT_QCOM_MILOS) += qnoc-milos.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8909) += qnoc-msm8909.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8937) += qnoc-msm8937.o
diff --git a/drivers/interconnect/qcom/milos.c b/drivers/interconnect/qcom/milos.c
new file mode 100644
index 0000000000000000000000000000000000000000..d18248883a3e104982d71214dbfe1e6b3f0a7b11
--- /dev/null
+++ b/drivers/interconnect/qcom/milos.c
@@ -0,0 +1,1837 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/qcom,milos-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-common.h"
+#include "icc-rpmh.h"
+
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qsm_cfg;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_lpass_gemnoc;
+static struct qcom_icc_node qnm_mdsp;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_nsp_gemnoc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_wlan_q6;
+static struct qcom_icc_node qxm_lpass_dsp;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mdp;
+static struct qcom_icc_node qnm_video;
+static struct qcom_icc_node qsm_hf_mnoc_cfg;
+static struct qcom_icc_node qsm_sf_mnoc_cfg;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node qsm_pcie_anoc_cfg;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_apss_noc;
+static struct qcom_icc_node qnm_cnoc_data;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mxa;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_mx_2_rdpm;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qhs_wlan_q6;
+static struct qcom_icc_node qss_mnoc_hf_cfg;
+static struct qcom_icc_node qss_mnoc_sf_cfg;
+static struct qcom_icc_node qss_nsp_qtb_cfg;
+static struct qcom_icc_node qss_pcie_anoc_cfg;
+static struct qcom_icc_node qss_wlan_q6_throttle_cfg;
+static struct qcom_icc_node srvc_cnoc_cfg;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qss_apss;
+static struct qcom_icc_node qss_cfg;
+static struct qcom_icc_node qss_ddrss_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_cnoc_main;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc_hf;
+static struct qcom_icc_node srvc_mnoc_sf;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_pcie_aggre_noc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+
+static struct qcom_icc_qosbox qhm_qup1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qup1_qos,
+	.link_nodes = { &qns_a1noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_ufs_mem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf200 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_ufs_mem_qos,
+	.link_nodes = { &qns_a1noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_usb3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x10000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_usb3_0_qos,
+	.link_nodes = { &qns_a1noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x14000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qdss_bam_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox qhm_qspi_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x12000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qspi_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox qhm_qup0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x13000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qup0_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox qxm_crypto_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x15000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qxm_crypto_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox qxm_ipa_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x16000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qxm_ipa_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x17000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_0_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x18000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_1_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_sdc1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1a000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_sdc1_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_sdc2_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x19000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_sdc2_qos,
+	.link_nodes = { &qns_a2noc_snoc, NULL },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qup0_core_slave, NULL },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qup1_core_slave, NULL },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+		   &qhs_camera_cfg, &qhs_clk_ctl,
+		   &qhs_cpr_cx, &qhs_cpr_mxa,
+		   &qhs_crypto0_cfg, &qhs_cx_rdpm,
+		   &qhs_gpuss_cfg, &qhs_imem_cfg,
+		   &qhs_mss_cfg, &qhs_mx_2_rdpm,
+		   &qhs_mx_rdpm, &qhs_pdm,
+		   &qhs_qdss_cfg, &qhs_qspi,
+		   &qhs_qup0, &qhs_qup1,
+		   &qhs_sdc1, &qhs_sdc2,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb3_0,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qhs_wlan_q6, &qss_mnoc_hf_cfg,
+		   &qss_mnoc_sf_cfg, &qss_nsp_qtb_cfg,
+		   &qss_pcie_anoc_cfg, &qss_wlan_q6_throttle_cfg,
+		   &srvc_cnoc_cfg, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg, NULL },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qhs_aoss, &qhs_display_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_pcie0_cfg, &qhs_pcie1_cfg,
+		   &qhs_prng, &qhs_tme_cfg,
+		   &qss_apss, &qss_cfg,
+		   &qss_ddrss_cfg, &qxs_imem,
+		   &qxs_pimem, &srvc_cnoc_main, NULL },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1, NULL },
+};
+
+static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf1000 },
+	.prio = 1,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &alm_gpu_tcu_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
+};
+
+static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf3000 },
+	.prio = 6,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &alm_sys_tcu_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.channels = 3,
+	.buswidth = 32,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_gpu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x31000, 0x71000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_gpu_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf5000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_lpass_gemnoc = {
+	.name = "qnm_lpass_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_lpass_gemnoc_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x33000, 0x73000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_mnoc_hf_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x35000, 0x75000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_mnoc_sf_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x37000, 0x77000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_nsp_gemnoc = {
+	.name = "qnm_nsp_gemnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_nsp_gemnoc_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_pcie_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf7000 },
+	.prio = 2,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_pcie_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xf9000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_snoc_gc_qos,
+	.link_nodes = { &qns_llcc, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xfb000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_snoc_sf_qos,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
+};
+
+static struct qcom_icc_node qxm_wlan_q6 = {
+	.name = "qxm_wlan_q6",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+		   &qns_pcie, NULL },
+};
+
+static struct qcom_icc_node qxm_lpass_dsp = {
+	.name = "qxm_lpass_dsp",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc, NULL },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.channels = 2,
+	.buswidth = 4,
+	.link_nodes = { &ebi, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0xa8000, 0xa9000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_camnoc_hf_qos,
+	.link_nodes = { &qns_mem_noc_hf, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x2a000 },
+	.prio = 5,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_camnoc_icp_qos,
+	.link_nodes = { &qns_mem_noc_sf, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x2b000, 0x2c000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_camnoc_sf_qos,
+	.link_nodes = { &qns_mem_noc_sf, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_mdp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xad000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &qnm_mdp_qos,
+	.link_nodes = { &qns_mem_noc_hf, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_video_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x30000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_video = {
+	.name = "qnm_video",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &qnm_video_qos,
+	.link_nodes = { &qns_mem_noc_sf, NULL },
+};
+
+static struct qcom_icc_node qsm_hf_mnoc_cfg = {
+	.name = "qsm_hf_mnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &srvc_mnoc_hf, NULL },
+};
+
+static struct qcom_icc_node qsm_sf_mnoc_cfg = {
+	.name = "qsm_sf_mnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &srvc_mnoc_sf, NULL },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.channels = 2,
+	.buswidth = 32,
+	.link_nodes = { &qns_nsp_gemnoc, NULL },
+};
+
+static struct qcom_icc_node qsm_pcie_anoc_cfg = {
+	.name = "qsm_pcie_anoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &srvc_pcie_aggre_noc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_pcie3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xb000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_pcie3_0_qos,
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_pcie3_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xc000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_pcie3_1_qos,
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qns_gemnoc_sf, NULL },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qns_gemnoc_sf, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_apss_noc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1c000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_apss_noc = {
+	.name = "qnm_apss_noc",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qnm_apss_noc_qos,
+	.link_nodes = { &qns_gemnoc_sf, NULL },
+};
+
+static struct qcom_icc_qosbox qnm_cnoc_data_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1d000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_cnoc_data = {
+	.name = "qnm_cnoc_data",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_cnoc_data_qos,
+	.link_nodes = { &qns_gemnoc_sf, NULL },
+};
+
+static struct qcom_icc_qosbox qxm_pimem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1e000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qxm_pimem_qos,
+	.link_nodes = { &qns_gemnoc_gc, NULL },
+};
+
+static struct qcom_icc_qosbox xm_gic_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1f000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_gic_qos,
+	.link_nodes = { &qns_gemnoc_gc, NULL },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qnm_aggre1_noc, NULL },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qnm_aggre2_noc, NULL },
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_cpr_mxa = {
+	.name = "qhs_cpr_mxa",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_mx_2_rdpm = {
+	.name = "qhs_mx_2_rdpm",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_wlan_q6 = {
+	.name = "qhs_wlan_q6",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qss_mnoc_hf_cfg = {
+	.name = "qss_mnoc_hf_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qsm_hf_mnoc_cfg, NULL },
+};
+
+static struct qcom_icc_node qss_mnoc_sf_cfg = {
+	.name = "qss_mnoc_sf_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qsm_sf_mnoc_cfg, NULL },
+};
+
+static struct qcom_icc_node qss_nsp_qtb_cfg = {
+	.name = "qss_nsp_qtb_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qss_pcie_anoc_cfg = {
+	.name = "qss_pcie_anoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qsm_pcie_anoc_cfg, NULL },
+};
+
+static struct qcom_icc_node qss_wlan_q6_throttle_cfg = {
+	.name = "qss_wlan_q6_throttle_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node srvc_cnoc_cfg = {
+	.name = "srvc_cnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qss_apss = {
+	.name = "qss_apss",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &qsm_cfg, NULL },
+};
+
+static struct qcom_icc_node qss_ddrss_cfg = {
+	.name = "qss_ddrss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node srvc_cnoc_main = {
+	.name = "srvc_cnoc_main",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.channels = 2,
+	.buswidth = 16,
+	.link_nodes = { &llcc_mc, NULL },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qnm_lpass_gemnoc, NULL },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.channels = 2,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.link_nodes = { &qnm_mnoc_hf, NULL },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.link_nodes = { &qnm_mnoc_sf, NULL },
+};
+
+static struct qcom_icc_node srvc_mnoc_hf = {
+	.name = "srvc_mnoc_hf",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node srvc_mnoc_sf = {
+	.name = "srvc_mnoc_sf",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.link_nodes = { &qnm_nsp_gemnoc, NULL },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { &qnm_pcie, NULL },
+};
+
+static struct qcom_icc_node srvc_pcie_aggre_noc = {
+	.name = "srvc_pcie_aggre_noc",
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { NULL },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.channels = 1,
+	.buswidth = 8,
+	.link_nodes = { &qnm_snoc_gc, NULL },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.channels = 1,
+	.buswidth = 16,
+	.link_nodes = { &qnm_snoc_sf, NULL },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = 0x1,
+	.nodes = { &ebi, NULL },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.nodes = { &qxm_crypto, NULL },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.enable_mask = 0x1,
+	.keepalive = true,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_cpr_cx,
+		   &qhs_cpr_mxa, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_gpuss_cfg,
+		   &qhs_imem_cfg, &qhs_mss_cfg,
+		   &qhs_mx_2_rdpm, &qhs_mx_rdpm,
+		   &qhs_pdm, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_sdc1,
+		   &qhs_sdc2, &qhs_tcsr,
+		   &qhs_tlmm, &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0, &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg, &qhs_wlan_q6,
+		   &qss_mnoc_hf_cfg, &qss_mnoc_sf_cfg,
+		   &qss_nsp_qtb_cfg, &qss_pcie_anoc_cfg,
+		   &qss_wlan_q6_throttle_cfg, &srvc_cnoc_cfg,
+		   &xs_qdss_stm, &xs_sys_tcu_cfg,
+		   &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
+		   &qhs_aoss, &qhs_ipa,
+		   &qhs_ipc_router, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_prng,
+		   &qhs_tme_cfg, &qss_apss,
+		   &qss_cfg, &qss_ddrss_cfg,
+		   &qxs_imem, &qxs_pimem,
+		   &srvc_cnoc_main, &xs_pcie_0,
+		   &xs_pcie_1, NULL },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.nodes = { &qhs_qup0, &qhs_qup1,
+		   &qhs_display_cfg, NULL },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.enable_mask = 0x1,
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc, NULL },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.nodes = { &ebi, NULL },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.nodes = { &qns_mem_noc_hf, NULL },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.enable_mask = 0x1,
+	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
+		   &qnm_camnoc_sf, &qns_mem_noc_sf, NULL },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.nodes = { &qup0_core_slave, NULL },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.nodes = { &qup1_core_slave, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.nodes = { &qns_llcc, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.enable_mask = 0x1,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
+		   &chm_apps, &qnm_gpu,
+		   &qnm_mdsp, &qnm_mnoc_hf,
+		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
+		   &qnm_pcie, &qnm_snoc_gc,
+		   &qnm_snoc_sf, &qxm_wlan_q6,
+		   &qns_gem_noc_cnoc, &qns_pcie, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.nodes = { &qns_gemnoc_gc, &qns_gemnoc_sf, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.enable_mask = 0x1,
+	.nodes = { &qxm_pimem, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.nodes = { &qnm_aggre1_noc, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.nodes = { &qnm_aggre2_noc, NULL },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.nodes = { &qns_pcie_mem_noc, NULL },
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct regmap_config milos_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x16400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_aggre1_noc = {
+	.config = &milos_aggre1_noc_regmap_config,
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct regmap_config milos_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_aggre2_noc = {
+	.config = &milos_aggre2_noc_regmap_config,
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+};
+
+static const struct qcom_icc_desc milos_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MXA_CFG] = &qhs_cpr_mxa,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_MX_2_RDPM] = &qhs_mx_2_rdpm,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_SDC1] = &qhs_sdc1,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_WLAN] = &qhs_wlan_q6,
+	[SLAVE_CNOC_MNOC_HF_CFG] = &qss_mnoc_hf_cfg,
+	[SLAVE_CNOC_MNOC_SF_CFG] = &qss_mnoc_sf_cfg,
+	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
+	[SLAVE_WLAN_Q6_THROTTLE_CFG] = &qss_wlan_q6_throttle_cfg,
+	[SLAVE_SERVICE_CNOC_CFG] = &srvc_cnoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct regmap_config milos_cnoc_cfg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x6e00,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_cnoc_cfg = {
+	.config = &milos_cnoc_cfg_regmap_config,
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_APPSS] = &qss_apss,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc_main,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+};
+
+static const struct regmap_config milos_cnoc_main_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x14400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_cnoc_main = {
+	.config = &milos_cnoc_main_regmap_config,
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass_gemnoc,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_gemnoc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_WLAN_Q6] = &qxm_wlan_q6,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+};
+
+static const struct regmap_config milos_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xff080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_gem_noc = {
+	.config = &milos_gem_noc_regmap_config,
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct regmap_config milos_lpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x17200,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_lpass_ag_noc = {
+	.config = &milos_lpass_ag_noc_regmap_config,
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc milos_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_VIDEO] = &qnm_video,
+	[MASTER_CNOC_MNOC_HF_CFG] = &qsm_hf_mnoc_cfg,
+	[MASTER_CNOC_MNOC_SF_CFG] = &qsm_sf_mnoc_cfg,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC_HF] = &srvc_mnoc_hf,
+	[SLAVE_SERVICE_MNOC_SF] = &srvc_mnoc_sf,
+};
+
+static const struct regmap_config milos_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xdb800,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_mmss_noc = {
+	.config = &milos_mmss_noc_regmap_config,
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+};
+
+static const struct regmap_config milos_nsp_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xe080,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_nsp_noc = {
+	.config = &milos_nsp_noc_regmap_config,
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_ANOC_CFG] = &qsm_pcie_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
+};
+
+static const struct regmap_config milos_pcie_anoc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x12400,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_pcie_anoc = {
+	.config = &milos_pcie_anoc_regmap_config,
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_APSS_NOC] = &qnm_apss_noc,
+	[MASTER_CNOC_SNOC] = &qnm_cnoc_data,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct regmap_config milos_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x40000,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_desc milos_system_noc = {
+	.config = &milos_system_noc_regmap_config,
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,milos-aggre1-noc", .data = &milos_aggre1_noc },
+	{ .compatible = "qcom,milos-aggre2-noc", .data = &milos_aggre2_noc },
+	{ .compatible = "qcom,milos-clk-virt", .data = &milos_clk_virt },
+	{ .compatible = "qcom,milos-cnoc-cfg", .data = &milos_cnoc_cfg },
+	{ .compatible = "qcom,milos-cnoc-main", .data = &milos_cnoc_main },
+	{ .compatible = "qcom,milos-gem-noc", .data = &milos_gem_noc },
+	{ .compatible = "qcom,milos-lpass-ag-noc", .data = &milos_lpass_ag_noc },
+	{ .compatible = "qcom,milos-mc-virt", .data = &milos_mc_virt },
+	{ .compatible = "qcom,milos-mmss-noc", .data = &milos_mmss_noc },
+	{ .compatible = "qcom,milos-nsp-noc", .data = &milos_nsp_noc },
+	{ .compatible = "qcom,milos-pcie-anoc", .data = &milos_pcie_anoc },
+	{ .compatible = "qcom,milos-system-noc", .data = &milos_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-milos",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("Milos NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.50.0


