Return-Path: <linux-pm+bounces-39982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BFCE533C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E99303BE04
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F422259A;
	Sun, 28 Dec 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7iSvRsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bdQ0ZMrv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90520E6E2
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941302; cv=none; b=Kzth74o0DqjILDmwRt8+uWU0mlB9tXy7gxm2frG6JGjt8Y9cYYq6Qo1jsjxeoWy7716BXaTWQjGwPvncTgxsdKYhoqR5MmGroerS2+axhC0N9daVbX9XU56NOjpRHp3s+tD1AD6nHwc9Z18HZj+0G+vDQ6sG22I0+EdlOmagPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941302; c=relaxed/simple;
	bh=AO6DA+THdUbk+4mox05j2FvqW5j/957nknRRq0lgeZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWQE6G16RqZXPc7VMj3PgefKbQkJrQUFRbr2GswDlhLeMKCNE54M8Cc4NcJYUmNQqQwTgmeyyHlKybL+6Syq/hnWBq1Q+nPSXtR3Wx81+eN2jrGcgfC6Kqc7AXxCE8kyvQYciLMbfVY5lzWonlJK5BR0cMtY+pYvrbvNP4W87A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7iSvRsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bdQ0ZMrv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSCUlRb2986068
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O6Foh2+wdOecjl7PjsSTEaLNWnsQbdXhe0iMFqdYSf0=; b=D7iSvRsh2zi2RHRB
	YdhRbbAsKM+FCVwdFmbtkMp8WVrH54MNO0OhotvUJEYUHGrQbVcKP4HgJYTqdukM
	WCDWxcg8IhNZdsG/lIpjJJ/oLC5SF+oPu/4N4Croi4TFdmiFPzUrpSt4iQCuLkdi
	nHSzsKV74zH4gt/ZStiXsnoRO/lcQUEh5peuwMT7TCQj8jVEKHopc1wzETNn8wkW
	k4DGEEsqzLOooA3e4nS3vTxRmzhGexjDP4Moe8F7TSutDAZ60rr3kP1Q29foS4R6
	xzaPfOoKdnwc8zKtlMKot9Hdz4S/UuuCt074oK0xTTcwIPbK/yeUHat/dKIMfzPt
	pRkJgQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7u5je4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:01:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ba9c366057so21949783b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941298; x=1767546098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6Foh2+wdOecjl7PjsSTEaLNWnsQbdXhe0iMFqdYSf0=;
        b=bdQ0ZMrvAY4mBngKn7tSTrIMFh8UqUdnF0EJ3LJ3RX5XEUnlJYKaDsBfGCoqFpfO2Q
         CePdw/ekRrudbgDy0buv5zSiYmI7sCSrX0P/UZiFhWL3OsLK61zcnWBBKclD2z0bBJfz
         7MKfU8Hl9q0qnbK+JY5xuIFdpxW42sKpJ9xM2fmHaKPsT526Rn47NCiH+yHHQU8mC63Q
         HU+RpN9eEKzMc6mYg00CtbVzRmeyZj+A6nlW9KQtKphpLPJshzc/gPnRn6LyzE/11K+s
         ThLKBoQ1dfsMtT0VS/GS/3wA+ro9iw4YwOfMJtzVLJlqpmfzSvhU7KU5B1lZAG2D+94S
         H5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941298; x=1767546098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6Foh2+wdOecjl7PjsSTEaLNWnsQbdXhe0iMFqdYSf0=;
        b=pz3ziUOev5X3InwPI9wbCphHqns80F4ag8Y8yN12nfINBQf3Xf18TcepM3dTcwshiZ
         e3DLLBujvctM/ibZI1/ulydxwNvuP8P9nhrZf9Jk6T9n2R/DvPDCr71UTzHu/2kVWrbK
         CM29ZVdZ3O6xJotk70MOuEXPnT8K4Dn+ii0Iy7wI8GqUhyHdeUsMsELpX2CloeU01p+L
         1ibgMKjSS89pN8BGKRSV5V+PPA81yyWxOkkMWkkJWLzWvLRyf5u9EG+PtX5ZwkgqF+SI
         eguteq/eJsWXAmZVdgPGbZUw8TblEe+obO9iw9anoi9VpQNIMeXBDMR7n0XImCTSIQZX
         ebOw==
X-Forwarded-Encrypted: i=1; AJvYcCWtG2XVHswAPXce6m1GMWctuVoOPcWQA4mPIhyD58OemhJNtjKg2sWumcGQBkucCKWebCAUdb2AVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSAZB/oo10aWJ1+NkQqgIFvcJb1sNZuazSBKQ21WpudkCmrZQ
	oLllpluuq3wmLtowihTIKxmU1UW7u5AGiNvVgVNZLnSNoAA5BNtoLy6kIwrW64z+wCX7kkCEJ7p
	D0YH8T4myyOOUeQbbKJbTd/KcUta5cx6sM6BH4J/Z9QRBTTu0TANNcIf5c7tA4w==
X-Gm-Gg: AY/fxX6JCYKPMvDQKfnmq3f9ABmmdnSfRCSgOVA15FznMn1CffmpUbyUuR6mVs85VSV
	3owocQ4mAqGZ1KUdwSpXAp7QgWxJ8zh06Dobaa7v0cdx99Bc4PVSYerOUJYqoj9F78yxeP/mIJe
	LZQHMdFeeSvPTcuAtJRYyM8sJRe8LBRDVNZION7dLqSsuhxkwGw9bgsN3brgrLtSipdpLw+8WMs
	EbgGylUhVqtriuOvE1QsskhpwC/oYjuWAkWpWoV/jJhKyldzP0fh+NXnBNbglgr8+FqkY3Ch5gS
	xPa/F5EYtA0DBX9omLjGQzbnKjPNylmfBYopEmdF0A8ojzcfmBX1EN659r6+ZjPKEwFxyNiSbhF
	buthgEkLQRK8JpH2jaouUxqDCcf43wByzHPc=
X-Received: by 2002:a05:6a00:2c86:b0:7e8:450c:61a8 with SMTP id d2e1a72fcca58-7ff6705c5b4mr24960265b3a.63.1766941297654;
        Sun, 28 Dec 2025 09:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiAFTZ8ex25xK3kPmcrFizu8q326IIEvwoBzq5IZ1fWaQ27rEXg5Vo2OhiV4GIKFe3bx9oDQ==
X-Received: by 2002:a05:6a00:2c86:b0:7e8:450c:61a8 with SMTP id d2e1a72fcca58-7ff6705c5b4mr24960193b3a.63.1766941296368;
        Sun, 28 Dec 2025 09:01:36 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:36 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:31:03 +0530
Subject: [PATCH v4 3/5] PCI/pwrctrl: Add support for handling PCIe M.2
 connectors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-pci-m2-v4-3-5684868b0d5f@oss.qualcomm.com>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
In-Reply-To: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=AO6DA+THdUbk+4mox05j2FvqW5j/957nknRRq0lgeZo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZfNqK+Fro47r7/XxC1e1nbiRuyWbDsEZNP
 d/8r8W/zyCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9e5eB/4ud4BPdyBhFUZ/uAfAI8eQV+h6yOv40h3VlyX4wvbAXOpu7EM9FDokADrdtrwpQqLySLg
 qJQhF/ls5tL9Ewxixulc0x0acUkCIgNC98lKgoyflgGw5mjMbnSo9lx3kgY5ZuhzRaEBdQr4urC
 kCrOIao3W0C2GQrObc9n2NNG1jMeKaYw/rEW+K05P3QP9XJyTpx3MOWbi9DSOZiRAGzldaq+Zxh
 OVEZIriC1nVan5rwz6QNlETpMaedl6ckZbx4tNJyzr+AeHQ4k7zI0FmRWn/T/4UCvD/LXGQaf/B
 WGgjdfSxBV3YFXkS3k60DrBlvoHxXfYBoF68St1spm/MglcA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: bGLja4aZTFK1lj4xiVlr2gS2ekdiN9an
X-Proofpoint-ORIG-GUID: bGLja4aZTFK1lj4xiVlr2gS2ekdiN9an
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX2lAHv2zjFjA2
 SLUpKRWOZwn12Byx0hf3Bfue0fv0VbDPUaX9DIKqA6k72yhfQGioDud7LuCIgeESfq4x8NOiHDh
 mPRcS381TqRVVxlXsBrRUh6S4kuX4egSfSZ6yrEUWbOhFo3j7EcDldyXQAOMVpbcwZbw14XdGrm
 OzOoEQ4slT9vU80kURfbddgVU+Bv3bU72xmyhif1ZhgYkOHKy8l7qHVbhahQsMCTiVE3s9naoVS
 5TtCPNhLVGBt3sH14VMCVawDITV7FHCLobPRmlYeRHybRpM2D5lHNmU6+U5JUsP2Nv4Gfgg2J2j
 Co/XTx/Lldttzf3dLONACo3Ee8sj/gy4lt5zq6Xi5lmwtCrHx3PPhTG8DhhMQ6pIiYqYgOYOXRM
 RtStDkWrxk49il2SSyCix7ozUygY4xmvjKlBg1wipcmmhm469ePf3sPa2TEdtUTnjuXogeeEn78
 io7FDRXMg9W9geSKg3A==
X-Authority-Analysis: v=2.4 cv=DptbOW/+ c=1 sm=1 tr=0 ts=69516272 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=T-2iuOupZRtFYbKAKI8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280156

Add support for handling the PCIe M.2 connectors as Power Sequencing
devices. These connectors are exposed as the Power Sequencing devices
as they often support multiple interfaces like PCIe/SATA, USB/UART to the
host machine and each interfaces could be driven by different client
drivers at the same time.

This driver handles the PCIe interface of these connectors. It first checks
for the presence of the graph port in the Root Port node with the help of
of_graph_is_present() API, if present, it acquires/poweres ON the
corresponding pwrseq device.

Once the pwrseq device is powered ON, the driver will skip parsing the Root
Port/Slot resources and registers with the pwrctrl framework.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/Kconfig |  1 +
 drivers/pci/pwrctrl/slot.c  | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index e0f999f299bb..cd3aa15bad00 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -13,6 +13,7 @@ config PCI_PWRCTRL_PWRSEQ
 
 config PCI_PWRCTRL_SLOT
 	tristate "PCI Power Control driver for PCI slots"
+	select POWER_SEQUENCING
 	select PCI_PWRCTRL
 	help
 	  Say Y here to enable the PCI Power Control driver to control the power
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..d46c2365208a 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -8,8 +8,10 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_graph.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -17,12 +19,18 @@ struct pci_pwrctrl_slot_data {
 	struct pci_pwrctrl ctx;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
+	struct pwrseq_desc *pwrseq;
 };
 
 static void devm_pci_pwrctrl_slot_power_off(void *data)
 {
 	struct pci_pwrctrl_slot_data *slot = data;
 
+	if (slot->pwrseq) {
+		pwrseq_power_off(slot->pwrseq);
+		return;
+	}
+
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
@@ -38,6 +46,20 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	if (!slot)
 		return -ENOMEM;
 
+	if (of_graph_is_present(dev_of_node(dev))) {
+		slot->pwrseq = devm_pwrseq_get(dev, "pcie");
+		if (IS_ERR(slot->pwrseq))
+			return dev_err_probe(dev, PTR_ERR(slot->pwrseq),
+				     "Failed to get the power sequencer\n");
+
+		ret = pwrseq_power_on(slot->pwrseq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				     "Failed to power-on the device\n");
+
+		goto skip_resources;
+	}
+
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
 	if (ret < 0) {
@@ -53,17 +75,20 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
-				       slot);
-	if (ret)
-		return ret;
-
 	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
+		regulator_bulk_disable(slot->num_supplies, slot->supplies);
+		regulator_bulk_free(slot->num_supplies, slot->supplies);
 		return dev_err_probe(dev, PTR_ERR(clk),
 				     "Failed to enable slot clock\n");
 	}
 
+skip_resources:
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+				       slot);
+	if (ret)
+		return ret;
+
 	pci_pwrctrl_init(&slot->ctx, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);

-- 
2.48.1


