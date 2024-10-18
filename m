Return-Path: <linux-pm+bounces-15934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C589A38A2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B651C23CB5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B79A18FDDA;
	Fri, 18 Oct 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLFnDZpB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35218FC7B
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240421; cv=none; b=GPH702YY33hIZG1DzV5axb2m1ZVbycvWm2wzdYZxhePTVBFXdB3T45ZW33eL4Go5417JgUpfncaBOpZF7dCZtd7o3VWPhPRpClhrYnqOcIamnvfGQj5JYOGfDZ/47T2fxQOjNS2YAdTkBqz4PB9RlhiAVyimGEurWMpb/+U3IhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240421; c=relaxed/simple;
	bh=5hSgSPE9VeYgrMZV7aggcLcjFoy8/Fi+jPWchTsXq1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iEqf221EztteB0r3/mLtXVzKW9gykjxBwQ9ACUo4iC0vR3D5GuPrM9nCL/k6Iqe5CRztEDBx44CgOI+5NknSvH9T9Wju8lLBm4SDTPajMR+Ld2GxpMXlOloyZ8fBRNzA0QrgMFDkJokEMxIDjDFy7ttMiyTgC9Yerq6bSOkz664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLFnDZpB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so18876701fa.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729240416; x=1729845216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GTdMzH6XbjrBS7ZBKT1al1tcbwlrW8UiApOzr7SiUc=;
        b=iLFnDZpBXIrOBIQuJWo8Q+9HybJzPDuLloqbARmef8ScRMPSqodGfVXE/wYQmfCb2T
         pRD6BfJ0Px1s21Dr2PRo2V8FyLS244m/HD4T5P0HOdopNHOqs2tEW6dL7USOJ3u0wXzA
         tIoNVwucBuEjYe6dF59u/mjxbSlnDTYYVMh1NgVLoE1i2U1G9zl/4btL88WEieWAajj+
         N77+60J7Bk9E5mGDF1WIzp0uT7c70KD9c66OuxlutSfUwBGZFkK6D7vpU6NPSy8QMfVM
         yzu5FvHrIy7fVaHLokYUqjYvzQ0DKwxGe//6SGV7nwOci6oMTS3MxDe/rn9u1jZTypf3
         IFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240416; x=1729845216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GTdMzH6XbjrBS7ZBKT1al1tcbwlrW8UiApOzr7SiUc=;
        b=akPseDHb3N+r8yucacCmZRD2W8RxFRIk9AW6QwY3PhAuj9z0nBssWGPiRYUJhDnqIr
         a7k6PESZWZudSK9ESgMriUAncmKQkqYXIdnn2hjcuBM8N2AFiRtZ7FZBkbi1SFlhn2Db
         OjZ5G/KwuxgcC02K85Oe+sJFdcssqWPJjtQukI0/weB3d7yUWgSw6guSO9UqiudXNXeF
         gct2MqCrn92rNqvhD59Q4ZCmH/S0SPrLVZQAJ0m1sIcgYL/jgx0ngOxsCnLIW3YyVkEL
         s+cBTTL0c+fqd7R6Q3DM8jBCR0zMOyocLC9oGFrQsUDe3OLZtfYTv9S6MGdxZ97QeF7i
         qcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXh9MAtNQFZ7NlFxZOWmt6nG3lpQhVKh2x92733InC6DHs+UIuWqTaciP6KD71l/5acuPJDz6OTyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHnj836mrvOufLFvrtOhVjM1j2cXzX4UuA80OS8VkmKA6BwxYL
	Ckd0p6sEVB5GbxhfL2xBpD7/oKgklFo7nQ92QHe8LMTLDAe/xdLfx5+syCJ/JW8=
X-Google-Smtp-Source: AGHT+IH8Vm29O0Wdug7v8Wxdb4yNbOleemxLf6PLWYPevDICRlH2jXCJSiHkYvple8ONw/YpXaSTmg==
X-Received: by 2002:a05:651c:b09:b0:2fb:4d7e:b942 with SMTP id 38308e7fff4ca-2fb82e9f307mr6649261fa.10.1729240415250;
        Fri, 18 Oct 2024 01:33:35 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809f9b62sm1628761fa.96.2024.10.18.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:33:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 11:33:25 +0300
Subject: [PATCH v2 2/2] interconnect: qcom: add support for SAR2130P
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sar2130p-icc-v2-2-c58c73dcd19d@linaro.org>
References: <20241018-sar2130p-icc-v2-0-c58c73dcd19d@linaro.org>
In-Reply-To: <20241018-sar2130p-icc-v2-0-c58c73dcd19d@linaro.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Odelu Kukatla <quic_okukatla@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=52858;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5hSgSPE9VeYgrMZV7aggcLcjFoy8/Fi+jPWchTsXq1Y=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEh1Xi0JQFT6dcjmHzpY4vdDW0n7GfwXAeAA7k
 9qTVIc1As6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxIdVwAKCRAU23LtvoBl
 uIdLEACYbCjNeC/KJpKFy3b+di3PW0V3xscjfPgMre6r2qSyO59cpy5qNtwJ787N+sAXJIcJcj4
 pZWZKbNInT0eebcKw4rVfDOBOxzFeXjfylI9hlS7VOcexq7SUaqYSvzcLh581EFbk5V9EHQXcLP
 sjfCO3UwAaHsw3BE0rGzioZ5Lt4oSieEsHU5xAc3BV9T5pzd3TGlanwQaUXLA19LNzgVvmMz0zO
 885kJi9DRDFngPAvc6ek7KNjgTpXWWNfqBCghQJn4DnvzNSo+dEAKMCsqEuwTyqn8XSYNqXFZUJ
 0cOit6ZQHWrza2pFyHD5H843KUFEljliESSLoI7y/KVsREg4jObVoGvBYwRyKgXbCl1K8fKVQ+5
 rE2yxsB/eEZW8izwhdJtyShhBBDJXFnCD09Dgc9k6iHUp7CQIZE6k8qy/Nq6q/Os3Ir/Q1Tnq3g
 WnFaKBC83VQXlKw7eNNyyvlT1AODG8kB2V7jtjwlNFLnNoH7lEtnbozRhj5jX7P4FryJcNleSAL
 km00q7D2BNLC7a98d6ujXnqYnlSNCm2C1egKWAGAnyAJEACOZdxxtwrw9F0B7SHjNE5O/J3KtlK
 nHd5bYkmJFlsUL4gCYpHc+WeYU1sRBRNo7Y/gNAC7kkP0dnqcF8jKy6TCnYYk/vMdac6D12VEnd
 l5lhTosUGOIJ7CA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add driver for the interconnects as present on the Qualcomm
SAR2130P platform. This is based on the msm-5.10 tree, tag
KERNEL.PLATFORM.1.0.r4-00400-NEO.0.

Co-developed-by: Odelu Kukatla <quic_okukatla@quicinc.com>
Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/Kconfig    |    9 +
 drivers/interconnect/qcom/Makefile   |    2 +
 drivers/interconnect/qcom/sar2130p.c | 1930 ++++++++++++++++++++++++++++++++++
 3 files changed, 1941 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index de96d466134066d785a49c6b71942e38359f98f4..bfcbfa8b2e52c9bb1a16f81605cd6eac2fb09ae5 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -137,6 +137,15 @@ config INTERCONNECT_QCOM_SA8775P
 	  This is a driver for the Qualcomm Network-on-Chip on sa8775p-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SAR2130P
+	tristate "Qualcomm SAR2130P interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on SAR2130P-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SC7180
 	tristate "Qualcomm SC7180 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index bfeea8416fcf9ea2b518f40cee26c1ae784b5924..24c3e1a6e01474ea4b7ea7444d35dcce70a04a1d 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -18,6 +18,7 @@ qnoc-qcs404-objs			:= qcs404.o
 qnoc-qdu1000-objs			:= qdu1000.o
 icc-rpmh-obj				:= icc-rpmh.o
 qnoc-sa8775p-objs			:= sa8775p.o
+qnoc-sar2130p-objs			:= sar2130p.o
 qnoc-sc7180-objs			:= sc7180.o
 qnoc-sc7280-objs                        := sc7280.o
 qnoc-sc8180x-objs			:= sc8180x.o
@@ -55,6 +56,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QDU1000) += qnoc-qdu1000.o
 obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SA8775P) += qnoc-sa8775p.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SAR2130P) += qnoc-sar2130p.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC7280) += qnoc-sc7280.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SC8180X) += qnoc-sc8180x.o
diff --git a/drivers/interconnect/qcom/sar2130p.c b/drivers/interconnect/qcom/sar2130p.c
new file mode 100644
index 0000000000000000000000000000000000000000..9eac0ac7681273d6f4350f4431b81ce94dbada3f
--- /dev/null
+++ b/drivers/interconnect/qcom/sar2130p.c
@@ -0,0 +1,1930 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2024, Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/sort.h>
+#include <dt-bindings/interconnect/qcom,sar2130p-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-common.h"
+#include "icc-rpmh.h"
+
+enum {
+	SAR2130P_MASTER_QUP_CORE_0,
+	SAR2130P_MASTER_QUP_CORE_1,
+	SAR2130P_MASTER_GEM_NOC_CNOC,
+	SAR2130P_MASTER_GEM_NOC_PCIE_SNOC,
+	SAR2130P_MASTER_QDSS_DAP,
+	SAR2130P_MASTER_GPU_TCU,
+	SAR2130P_MASTER_SYS_TCU,
+	SAR2130P_MASTER_APPSS_PROC,
+	SAR2130P_MASTER_GFX3D,
+	SAR2130P_MASTER_MNOC_HF_MEM_NOC,
+	SAR2130P_MASTER_MNOC_SF_MEM_NOC,
+	SAR2130P_MASTER_COMPUTE_NOC,
+	SAR2130P_MASTER_ANOC_PCIE_GEM_NOC,
+	SAR2130P_MASTER_SNOC_GC_MEM_NOC,
+	SAR2130P_MASTER_SNOC_SF_MEM_NOC,
+	SAR2130P_MASTER_WLAN_Q6,
+	SAR2130P_MASTER_CNOC_LPASS_AG_NOC,
+	SAR2130P_MASTER_LPASS_PROC,
+	SAR2130P_MASTER_LLCC,
+	SAR2130P_MASTER_CAMNOC_HF,
+	SAR2130P_MASTER_CAMNOC_ICP,
+	SAR2130P_MASTER_CAMNOC_SF,
+	SAR2130P_MASTER_LSR,
+	SAR2130P_MASTER_MDP,
+	SAR2130P_MASTER_CNOC_MNOC_CFG,
+	SAR2130P_MASTER_VIDEO,
+	SAR2130P_MASTER_VIDEO_CV_PROC,
+	SAR2130P_MASTER_VIDEO_PROC,
+	SAR2130P_MASTER_VIDEO_V_PROC,
+	SAR2130P_MASTER_CDSP_NOC_CFG,
+	SAR2130P_MASTER_CDSP_PROC,
+	SAR2130P_MASTER_PCIE_0,
+	SAR2130P_MASTER_PCIE_1,
+	SAR2130P_MASTER_GIC_AHB,
+	SAR2130P_MASTER_QDSS_BAM,
+	SAR2130P_MASTER_QSPI_0,
+	SAR2130P_MASTER_QUP_0,
+	SAR2130P_MASTER_QUP_1,
+	SAR2130P_MASTER_A2NOC_SNOC,
+	SAR2130P_MASTER_CNOC_DATAPATH,
+	SAR2130P_MASTER_LPASS_ANOC,
+	SAR2130P_MASTER_SNOC_CFG,
+	SAR2130P_MASTER_CRYPTO,
+	SAR2130P_MASTER_PIMEM,
+	SAR2130P_MASTER_GIC,
+	SAR2130P_MASTER_QDSS_ETR,
+	SAR2130P_MASTER_QDSS_ETR_1,
+	SAR2130P_MASTER_SDCC_1,
+	SAR2130P_MASTER_USB3_0,
+	SAR2130P_SLAVE_QUP_CORE_0,
+	SAR2130P_SLAVE_QUP_CORE_1,
+	SAR2130P_SLAVE_AHB2PHY_SOUTH,
+	SAR2130P_SLAVE_AOSS,
+	SAR2130P_SLAVE_CAMERA_CFG,
+	SAR2130P_SLAVE_CLK_CTL,
+	SAR2130P_SLAVE_CDSP_CFG,
+	SAR2130P_SLAVE_RBCPR_CX_CFG,
+	SAR2130P_SLAVE_RBCPR_MMCX_CFG,
+	SAR2130P_SLAVE_RBCPR_MXA_CFG,
+	SAR2130P_SLAVE_RBCPR_MXC_CFG,
+	SAR2130P_SLAVE_CPR_NSPCX,
+	SAR2130P_SLAVE_CRYPTO_0_CFG,
+	SAR2130P_SLAVE_CX_RDPM,
+	SAR2130P_SLAVE_DISPLAY_CFG,
+	SAR2130P_SLAVE_GFX3D_CFG,
+	SAR2130P_SLAVE_IMEM_CFG,
+	SAR2130P_SLAVE_IPC_ROUTER_CFG,
+	SAR2130P_SLAVE_LPASS,
+	SAR2130P_SLAVE_MX_RDPM,
+	SAR2130P_SLAVE_PCIE_0_CFG,
+	SAR2130P_SLAVE_PCIE_1_CFG,
+	SAR2130P_SLAVE_PDM,
+	SAR2130P_SLAVE_PIMEM_CFG,
+	SAR2130P_SLAVE_PRNG,
+	SAR2130P_SLAVE_QDSS_CFG,
+	SAR2130P_SLAVE_QSPI_0,
+	SAR2130P_SLAVE_QUP_0,
+	SAR2130P_SLAVE_QUP_1,
+	SAR2130P_SLAVE_SDCC_1,
+	SAR2130P_SLAVE_TCSR,
+	SAR2130P_SLAVE_TLMM,
+	SAR2130P_SLAVE_TME_CFG,
+	SAR2130P_SLAVE_USB3_0,
+	SAR2130P_SLAVE_VENUS_CFG,
+	SAR2130P_SLAVE_VSENSE_CTRL_CFG,
+	SAR2130P_SLAVE_WLAN_Q6_CFG,
+	SAR2130P_SLAVE_DDRSS_CFG,
+	SAR2130P_SLAVE_CNOC_MNOC_CFG,
+	SAR2130P_SLAVE_SNOC_CFG,
+	SAR2130P_SLAVE_IMEM,
+	SAR2130P_SLAVE_PIMEM,
+	SAR2130P_SLAVE_SERVICE_CNOC,
+	SAR2130P_SLAVE_PCIE_0,
+	SAR2130P_SLAVE_PCIE_1,
+	SAR2130P_SLAVE_QDSS_STM,
+	SAR2130P_SLAVE_TCU,
+	SAR2130P_SLAVE_GEM_NOC_CNOC,
+	SAR2130P_SLAVE_LLCC,
+	SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC,
+	SAR2130P_SLAVE_LPASS_CORE_CFG,
+	SAR2130P_SLAVE_LPASS_LPI_CFG,
+	SAR2130P_SLAVE_LPASS_MPU_CFG,
+	SAR2130P_SLAVE_LPASS_TOP_CFG,
+	SAR2130P_SLAVE_LPASS_SNOC,
+	SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC,
+	SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC,
+	SAR2130P_SLAVE_EBI1,
+	SAR2130P_SLAVE_MNOC_HF_MEM_NOC,
+	SAR2130P_SLAVE_MNOC_SF_MEM_NOC,
+	SAR2130P_SLAVE_SERVICE_MNOC,
+	SAR2130P_SLAVE_CDSP_MEM_NOC,
+	SAR2130P_SLAVE_SERVICE_NSP_NOC,
+	SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC,
+	SAR2130P_SLAVE_A2NOC_SNOC,
+	SAR2130P_SLAVE_SNOC_GEM_NOC_GC,
+	SAR2130P_SLAVE_SNOC_GEM_NOC_SF,
+	SAR2130P_SLAVE_SERVICE_SNOC,
+};
+
+static const struct regmap_config icc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SAR2130P_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SAR2130P_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SAR2130P_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 43,
+	.links = { SAR2130P_SLAVE_AHB2PHY_SOUTH, SAR2130P_SLAVE_AOSS,
+		   SAR2130P_SLAVE_CAMERA_CFG, SAR2130P_SLAVE_CLK_CTL,
+		   SAR2130P_SLAVE_CDSP_CFG, SAR2130P_SLAVE_RBCPR_CX_CFG,
+		   SAR2130P_SLAVE_RBCPR_MMCX_CFG, SAR2130P_SLAVE_RBCPR_MXA_CFG,
+		   SAR2130P_SLAVE_RBCPR_MXC_CFG, SAR2130P_SLAVE_CPR_NSPCX,
+		   SAR2130P_SLAVE_CRYPTO_0_CFG, SAR2130P_SLAVE_CX_RDPM,
+		   SAR2130P_SLAVE_DISPLAY_CFG, SAR2130P_SLAVE_GFX3D_CFG,
+		   SAR2130P_SLAVE_IMEM_CFG, SAR2130P_SLAVE_IPC_ROUTER_CFG,
+		   SAR2130P_SLAVE_LPASS, SAR2130P_SLAVE_MX_RDPM,
+		   SAR2130P_SLAVE_PCIE_0_CFG, SAR2130P_SLAVE_PCIE_1_CFG,
+		   SAR2130P_SLAVE_PDM, SAR2130P_SLAVE_PIMEM_CFG,
+		   SAR2130P_SLAVE_PRNG, SAR2130P_SLAVE_QDSS_CFG,
+		   SAR2130P_SLAVE_QSPI_0, SAR2130P_SLAVE_QUP_0,
+		   SAR2130P_SLAVE_QUP_1, SAR2130P_SLAVE_SDCC_1,
+		   SAR2130P_SLAVE_TCSR, SAR2130P_SLAVE_TLMM,
+		   SAR2130P_SLAVE_TME_CFG, SAR2130P_SLAVE_USB3_0,
+		   SAR2130P_SLAVE_VENUS_CFG, SAR2130P_SLAVE_VSENSE_CTRL_CFG,
+		   SAR2130P_SLAVE_WLAN_Q6_CFG, SAR2130P_SLAVE_DDRSS_CFG,
+		   SAR2130P_SLAVE_CNOC_MNOC_CFG, SAR2130P_SLAVE_SNOC_CFG,
+		   SAR2130P_SLAVE_IMEM, SAR2130P_SLAVE_PIMEM,
+		   SAR2130P_SLAVE_SERVICE_CNOC, SAR2130P_SLAVE_QDSS_STM,
+		   SAR2130P_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SAR2130P_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_PCIE_0, SAR2130P_SLAVE_PCIE_1 },
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SAR2130P_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 43,
+	.links = { SAR2130P_SLAVE_AHB2PHY_SOUTH, SAR2130P_SLAVE_AOSS,
+		   SAR2130P_SLAVE_CAMERA_CFG, SAR2130P_SLAVE_CLK_CTL,
+		   SAR2130P_SLAVE_CDSP_CFG, SAR2130P_SLAVE_RBCPR_CX_CFG,
+		   SAR2130P_SLAVE_RBCPR_MMCX_CFG, SAR2130P_SLAVE_RBCPR_MXA_CFG,
+		   SAR2130P_SLAVE_RBCPR_MXC_CFG, SAR2130P_SLAVE_CPR_NSPCX,
+		   SAR2130P_SLAVE_CRYPTO_0_CFG, SAR2130P_SLAVE_CX_RDPM,
+		   SAR2130P_SLAVE_DISPLAY_CFG, SAR2130P_SLAVE_GFX3D_CFG,
+		   SAR2130P_SLAVE_IMEM_CFG, SAR2130P_SLAVE_IPC_ROUTER_CFG,
+		   SAR2130P_SLAVE_LPASS, SAR2130P_SLAVE_MX_RDPM,
+		   SAR2130P_SLAVE_PCIE_0_CFG, SAR2130P_SLAVE_PCIE_1_CFG,
+		   SAR2130P_SLAVE_PDM, SAR2130P_SLAVE_PIMEM_CFG,
+		   SAR2130P_SLAVE_PRNG, SAR2130P_SLAVE_QDSS_CFG,
+		   SAR2130P_SLAVE_QSPI_0, SAR2130P_SLAVE_QUP_0,
+		   SAR2130P_SLAVE_QUP_1, SAR2130P_SLAVE_SDCC_1,
+		   SAR2130P_SLAVE_TCSR, SAR2130P_SLAVE_TLMM,
+		   SAR2130P_SLAVE_TME_CFG, SAR2130P_SLAVE_USB3_0,
+		   SAR2130P_SLAVE_VENUS_CFG, SAR2130P_SLAVE_VSENSE_CTRL_CFG,
+		   SAR2130P_SLAVE_WLAN_Q6_CFG, SAR2130P_SLAVE_DDRSS_CFG,
+		   SAR2130P_SLAVE_CNOC_MNOC_CFG, SAR2130P_SLAVE_SNOC_CFG,
+		   SAR2130P_SLAVE_IMEM, SAR2130P_SLAVE_PIMEM,
+		   SAR2130P_SLAVE_SERVICE_CNOC, SAR2130P_SLAVE_QDSS_STM,
+		   SAR2130P_SLAVE_TCU },
+};
+
+static const struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9e000 },
+	.prio = 1,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SAR2130P_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &alm_gpu_tcu_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox alm_sys_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9f000 },
+	.prio = 6,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SAR2130P_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &alm_sys_tcu_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SAR2130P_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC,
+		   SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static const struct qcom_icc_qosbox qnm_gpu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0xe000, 0x4e000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SAR2130P_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_gpu_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0xf000, 0x4f000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SAR2130P_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_mnoc_hf_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9d000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SAR2130P_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &qnm_mnoc_sf_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x10000, 0x50000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_nsp_gemnoc = {
+	.name = "qnm_nsp_gemnoc",
+	.id = SAR2130P_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_nsp_gemnoc_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox qnm_pcie_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa2000 },
+	.prio = 2,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SAR2130P_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_pcie_qos,
+	.num_links = 2,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox qnm_snoc_gc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa0000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SAR2130P_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_snoc_gc_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_LLCC },
+};
+
+static const struct qcom_icc_qosbox qnm_snoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa1000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SAR2130P_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_snoc_sf_qos,
+	.num_links = 3,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC,
+		   SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qxm_wlan_q6 = {
+	.name = "qxm_wlan_q6",
+	.id = SAR2130P_MASTER_WLAN_Q6,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SAR2130P_SLAVE_GEM_NOC_CNOC, SAR2130P_SLAVE_LLCC,
+		   SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhm_config_noc = {
+	.name = "qhm_config_noc",
+	.id = SAR2130P_MASTER_CNOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 6,
+	.links = { SAR2130P_SLAVE_LPASS_CORE_CFG, SAR2130P_SLAVE_LPASS_LPI_CFG,
+		   SAR2130P_SLAVE_LPASS_MPU_CFG, SAR2130P_SLAVE_LPASS_TOP_CFG,
+		   SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC, SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qxm_lpass_dsp = {
+	.name = "qxm_lpass_dsp",
+	.id = SAR2130P_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 4,
+	.links = { SAR2130P_SLAVE_LPASS_TOP_CFG, SAR2130P_SLAVE_LPASS_SNOC,
+		   SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC, SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SAR2130P_MASTER_LLCC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_EBI1 },
+};
+
+static const struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1c000 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SAR2130P_MASTER_CAMNOC_HF,
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &qnm_camnoc_hf_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1c080 },
+	.prio = 4,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SAR2130P_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_camnoc_icp_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1c100 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SAR2130P_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &qnm_camnoc_sf_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_lsr_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x1f000, 0x1f080 },
+	.prio = 3,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_lsr = {
+	.name = "qnm_lsr",
+	.id = SAR2130P_MASTER_LSR,
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_lsr_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_mdp_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x1d000, 0x1d080 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.id = SAR2130P_MASTER_MDP,
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_mdp_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_cfg = {
+	.name = "qnm_mnoc_cfg",
+	.id = SAR2130P_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SERVICE_MNOC },
+};
+
+static const struct qcom_icc_qosbox qnm_video_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x1e000, 0x1e080 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_video = {
+	.name = "qnm_video",
+	.id = SAR2130P_MASTER_VIDEO,
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_video_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1e100 },
+	.prio = 4,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_video_cv_cpu = {
+	.name = "qnm_video_cv_cpu",
+	.id = SAR2130P_MASTER_VIDEO_CV_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_video_cv_cpu_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_video_cvp_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1e180 },
+	.prio = 0,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_video_cvp = {
+	.name = "qnm_video_cvp",
+	.id = SAR2130P_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &qnm_video_cvp_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1e200 },
+	.prio = 4,
+	.urg_fwd = 1,
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.id = SAR2130P_MASTER_VIDEO_V_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_video_v_cpu_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qhm_nsp_noc_config = {
+	.name = "qhm_nsp_noc_config",
+	.id = SAR2130P_MASTER_CDSP_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SERVICE_NSP_NOC },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SAR2130P_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_CDSP_MEM_NOC },
+};
+
+static const struct qcom_icc_qosbox xm_pcie3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x9000 },
+	.prio = 3,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SAR2130P_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_pcie3_0_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static const struct qcom_icc_qosbox xm_pcie3_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0xa000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SAR2130P_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_pcie3_1_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static const struct qcom_icc_qosbox qhm_gic_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1d000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_gic = {
+	.name = "qhm_gic",
+	.id = SAR2130P_MASTER_GIC_AHB,
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_gic_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static const struct qcom_icc_qosbox qhm_qdss_bam_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x22000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SAR2130P_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qdss_bam_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox qhm_qspi_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x23000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SAR2130P_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qspi_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox qhm_qup0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x24000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SAR2130P_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qup0_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox qhm_qup1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x25000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SAR2130P_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &qhm_qup1_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SAR2130P_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static const struct qcom_icc_qosbox qnm_cnoc_datapath_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x26000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_cnoc_datapath = {
+	.name = "qnm_cnoc_datapath",
+	.id = SAR2130P_MASTER_CNOC_DATAPATH,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_cnoc_datapath_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox qnm_lpass_noc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1e000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_lpass_noc = {
+	.name = "qnm_lpass_noc",
+	.id = SAR2130P_MASTER_LPASS_ANOC,
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_lpass_noc_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_snoc_cfg = {
+	.name = "qnm_snoc_cfg",
+	.id = SAR2130P_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SERVICE_SNOC },
+};
+
+static const struct qcom_icc_qosbox qxm_crypto_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x27000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SAR2130P_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qxm_crypto_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox qxm_pimem_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1f000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SAR2130P_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qxm_pimem_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static const struct qcom_icc_qosbox xm_gic_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x21000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SAR2130P_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_gic_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static const struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1b000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.id = SAR2130P_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_0_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x1c000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.id = SAR2130P_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_qdss_etr_1_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox xm_sdc1_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x29000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SAR2130P_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_sdc1_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static const struct qcom_icc_qosbox xm_usb3_0_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x28000 },
+	.prio = 2,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SAR2130P_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &xm_usb3_0_qos,
+	.num_links = 1,
+	.links = { SAR2130P_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SAR2130P_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SAR2130P_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SAR2130P_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SAR2130P_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SAR2130P_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SAR2130P_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_compute_cfg = {
+	.name = "qhs_compute_cfg",
+	.id = SAR2130P_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_CDSP_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SAR2130P_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mmcx = {
+	.name = "qhs_cpr_mmcx",
+	.id = SAR2130P_SLAVE_RBCPR_MMCX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxa = {
+	.name = "qhs_cpr_mxa",
+	.id = SAR2130P_SLAVE_RBCPR_MXA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxc = {
+	.name = "qhs_cpr_mxc",
+	.id = SAR2130P_SLAVE_RBCPR_MXC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_nspcx = {
+	.name = "qhs_cpr_nspcx",
+	.id = SAR2130P_SLAVE_CPR_NSPCX,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SAR2130P_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SAR2130P_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SAR2130P_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SAR2130P_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SAR2130P_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SAR2130P_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg = {
+	.name = "qhs_lpass_cfg",
+	.id = SAR2130P_SLAVE_LPASS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_CNOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SAR2130P_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SAR2130P_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SAR2130P_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SAR2130P_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SAR2130P_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SAR2130P_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SAR2130P_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SAR2130P_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SAR2130P_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SAR2130P_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SAR2130P_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SAR2130P_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SAR2130P_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.id = SAR2130P_SLAVE_TME_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SAR2130P_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SAR2130P_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SAR2130P_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_wlan_q6 = {
+	.name = "qhs_wlan_q6",
+	.id = SAR2130P_SLAVE_WLAN_Q6_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_ddrss_cfg = {
+	.name = "qns_ddrss_cfg",
+	.id = SAR2130P_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mnoc_cfg = {
+	.name = "qns_mnoc_cfg",
+	.id = SAR2130P_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qns_snoc_cfg = {
+	.name = "qns_snoc_cfg",
+	.id = SAR2130P_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SAR2130P_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SAR2130P_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SAR2130P_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SAR2130P_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SAR2130P_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SAR2130P_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SAR2130P_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SAR2130P_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SAR2130P_SLAVE_LLCC,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SAR2130P_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhs_lpass_core = {
+	.name = "qhs_lpass_core",
+	.id = SAR2130P_SLAVE_LPASS_CORE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_lpi = {
+	.name = "qhs_lpass_lpi",
+	.id = SAR2130P_SLAVE_LPASS_LPI_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_mpu = {
+	.name = "qhs_lpass_mpu",
+	.id = SAR2130P_SLAVE_LPASS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_top = {
+	.name = "qhs_lpass_top",
+	.id = SAR2130P_SLAVE_LPASS_TOP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_sysnoc = {
+	.name = "qns_sysnoc",
+	.id = SAR2130P_SLAVE_LPASS_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_LPASS_ANOC },
+};
+
+static struct qcom_icc_node srvc_niu_aml_noc = {
+	.name = "srvc_niu_aml_noc",
+	.id = SAR2130P_SLAVE_SERVICES_LPASS_AML_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_niu_lpass_agnoc = {
+	.name = "srvc_niu_lpass_agnoc",
+	.id = SAR2130P_SLAVE_SERVICE_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SAR2130P_SLAVE_EBI1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SAR2130P_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SAR2130P_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SAR2130P_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SAR2130P_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node service_nsp_noc = {
+	.name = "service_nsp_noc",
+	.id = SAR2130P_SLAVE_SERVICE_NSP_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SAR2130P_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SAR2130P_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SAR2130P_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SAR2130P_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SAR2130P_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SAR2130P_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.enable_mask = BIT(0),
+	.keepalive = true,
+	.num_nodes = 48,
+	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
+		   &xm_qdss_dap, &qhs_ahb2phy0,
+		   &qhs_aoss, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_compute_cfg,
+		   &qhs_cpr_cx, &qhs_cpr_mmcx,
+		   &qhs_cpr_mxa, &qhs_cpr_mxc,
+		   &qhs_cpr_nspcx, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_display_cfg,
+		   &qhs_gpuss_cfg, &qhs_imem_cfg,
+		   &qhs_ipc_router, &qhs_lpass_cfg,
+		   &qhs_mx_rdpm, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_pdm,
+		   &qhs_pimem_cfg, &qhs_prng,
+		   &qhs_qdss_cfg, &qhs_qspi,
+		   &qhs_qup0, &qhs_qup1,
+		   &qhs_sdc1, &qhs_tcsr,
+		   &qhs_tlmm, &qhs_tme_cfg,
+		   &qhs_usb3_0, &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg, &qhs_wlan_q6,
+		   &qns_ddrss_cfg, &qns_mnoc_cfg,
+		   &qns_snoc_cfg, &qxs_imem,
+		   &qxs_pimem, &srvc_cnoc,
+		   &xs_pcie_0, &xs_pcie_1,
+		   &xs_qdss_stm, &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.enable_mask = BIT(0),
+	.num_nodes = 2,
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.enable_mask = BIT(0),
+	.num_nodes = 11,
+	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
+		   &qnm_camnoc_sf, &qnm_lsr,
+		   &qnm_mdp, &qnm_mnoc_cfg,
+		   &qnm_video, &qnm_video_cv_cpu,
+		   &qnm_video_cvp, &qnm_video_v_cpu,
+		   &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.enable_mask = BIT(0),
+	.num_nodes = 13,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
+		   &chm_apps, &qnm_gpu,
+		   &qnm_mnoc_hf, &qnm_mnoc_sf,
+		   &qnm_nsp_gemnoc, &qnm_pcie,
+		   &qnm_snoc_gc, &qnm_snoc_sf,
+		   &qxm_wlan_q6, &qns_gem_noc_cnoc,
+		   &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.enable_mask = BIT(0),
+	.num_nodes = 4,
+	.nodes = { &qhm_gic, &qxm_pimem,
+		   &xm_gic, &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qnm_lpass_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
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
+static const struct qcom_icc_desc sar2130p_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CDSP_CFG] = &qhs_compute_cfg,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
+	[SLAVE_RBCPR_MXA_CFG] = &qhs_cpr_mxa,
+	[SLAVE_RBCPR_MXC_CFG] = &qhs_cpr_mxc,
+	[SLAVE_CPR_NSPCX] = &qhs_cpr_nspcx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_LPASS] = &qhs_lpass_cfg,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_WLAN_Q6_CFG] = &qhs_wlan_q6,
+	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &qns_mnoc_cfg,
+	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sar2130p_config_noc = {
+	.config = &icc_regmap_config,
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
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
+static const struct qcom_icc_desc sar2130p_gem_noc = {
+	.config = &icc_regmap_config,
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
+	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
+	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
+	[SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
+	[SLAVE_LPASS_MPU_CFG] = &qhs_lpass_mpu,
+	[SLAVE_LPASS_TOP_CFG] = &qhs_lpass_top,
+	[SLAVE_LPASS_SNOC] = &qns_sysnoc,
+	[SLAVE_SERVICES_LPASS_AML_NOC] = &srvc_niu_aml_noc,
+	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
+};
+
+static const struct qcom_icc_desc sar2130p_lpass_ag_noc = {
+	.config = &icc_regmap_config,
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
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
+static const struct qcom_icc_desc sar2130p_mc_virt = {
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
+	[MASTER_LSR] = &qnm_lsr,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
+	[MASTER_VIDEO] = &qnm_video,
+	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
+	[MASTER_VIDEO_PROC] = &qnm_video_cvp,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+};
+
+static const struct qcom_icc_desc sar2130p_mmss_noc = {
+	.config = &icc_regmap_config,
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
+	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
+};
+
+static const struct qcom_icc_desc sar2130p_nsp_noc = {
+	.config = &icc_regmap_config,
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn7,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+};
+
+static const struct qcom_icc_desc sar2130p_pcie_anoc = {
+	.config = &icc_regmap_config,
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn3,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_GIC_AHB] = &qhm_gic,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_CNOC_DATAPATH] = &qnm_cnoc_datapath,
+	[MASTER_LPASS_ANOC] = &qnm_lpass_noc,
+	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+};
+
+static const struct qcom_icc_desc sar2130p_system_noc = {
+	.config = &icc_regmap_config,
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sar2130p-clk-virt", .data = &sar2130p_clk_virt},
+	{ .compatible = "qcom,sar2130p-config-noc", .data = &sar2130p_config_noc},
+	{ .compatible = "qcom,sar2130p-gem-noc", .data = &sar2130p_gem_noc},
+	{ .compatible = "qcom,sar2130p-lpass-ag-noc", .data = &sar2130p_lpass_ag_noc},
+	{ .compatible = "qcom,sar2130p-mc-virt", .data = &sar2130p_mc_virt},
+	{ .compatible = "qcom,sar2130p-mmss-noc", .data = &sar2130p_mmss_noc},
+	{ .compatible = "qcom,sar2130p-nsp-noc", .data = &sar2130p_nsp_noc},
+	{ .compatible = "qcom,sar2130p-pcie-anoc", .data = &sar2130p_pcie_anoc},
+	{ .compatible = "qcom,sar2130p-system-noc", .data = &sar2130p_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sar2130p",
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
+
+module_exit(qnoc_driver_exit);
+MODULE_DESCRIPTION("Qualcomm SAR2130P NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.39.5


