Return-Path: <linux-pm+bounces-41317-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGwLMLphcmnfjQAAu9opvQ
	(envelope-from <linux-pm+bounces-41317-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 18:43:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A74796B8F6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A01D63099CB1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C327602C;
	Thu, 22 Jan 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilre768F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFC30EF67;
	Thu, 22 Jan 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102219; cv=none; b=DaBUs0OBuuGjduksLuBXbGwjXZCUxzk6iPgTNOI0AZJY++BkADqvzt3aSkGXewZl6JhwDUshVFfCNUmHYkIFa+Pu7R6WaYtJrqjOl9E3yxWaoa3WCPTEvXuEMWlFlcJKHa67+SDimwtF9HjBxq1+Uh3hhVAou9RQfkX6YieY2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102219; c=relaxed/simple;
	bh=RebAKdOcdLux7Bzs3USnBVZCC294iJ88uiAmw8sBU+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CarL06w/4BfoMmz6PyVUvb+ft9u7c9hk1kUv7GL9cYTNvqL3K4nDjm+cpypTQOuScrM72SXFwB/+nHSu7KQ2ahlBmKZGrPC6Z7jMs0B7wVBE8iUXPGmO00flP0QCPmF1fJJhVY32Jak6DA3mGE7d5rD9M48QFCnDEQx04Q77CnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilre768F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 784A4C116D0;
	Thu, 22 Jan 2026 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102217;
	bh=RebAKdOcdLux7Bzs3USnBVZCC294iJ88uiAmw8sBU+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ilre768FSl+v+eNpRPqlnMZv+QuGcAuyqq2V5gOnsgCs5SeaRt6dB9XsqxTQNTPEO
	 wpVI5Eic23g9SL2Dnp8LxSdue1lYtX6lOsEDM6K+XkNfK0AoONvEAFXFIwmNBBzSqe
	 Ixlfr86ayMwnTo3lXrYuQaxohkx5myvRETcsNAVSPQQqBD6Mw8bIXM6SxiPpIVicZs
	 D8ml4UcA52igw8JwgtZqBk8YEsuPeaHl85zj5tgSqRoar0vLeubQn8Imkula2eWoqp
	 ySkWaFNcQB0qJy8sMdmKT7WSFepKYsiIZhJwyjEV8SU24fM6i5kXYCsJN3B4LpIj70
	 uII917TJ2YRsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6785FD3EE99;
	Thu, 22 Jan 2026 17:16:57 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 22 Jan 2026 22:46:52 +0530
Subject: [PATCH v6 2/4] PCI/pwrctrl: Add support for handling PCIe M.2
 connectors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-pci-m2-v6-2-575da9f97239@oss.qualcomm.com>
References: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
In-Reply-To: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
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
 bh=ZDVloXuAnO5BeZ3Skc5JZ2mUrMigYYbAnv9HygHmgvQ=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsgsim7PCz6YI33g9rXvN9hzzsdcXsjbIKPvGipr/OnRa
 mGH2QyqnYzGLAyMXAyyYoos6UudtRo9Tt9YEqE+HWYQKxPIFAYuTgGYSEcS+19Zi/uH/zz3WvIv
 0uavk1t5WcYmp5P6983ca1RWm+sf/KdYYOmoG+q6+dP2InHVmOup9ha2Pe9nzon26mjZMLfJQOW
 mK/9+xor3TzaEGFp7b5h38vKJ4MYJzUZZHp6OqZHVSyqkl7hs1LVKu1fEo6nAtPNxd1dc5/GzB2
 5+m/Rmes3nfcffPTtcNctIk9Wi6qp/sV3KhAA/K9/wLL8VOyPu82V37jRfbeE/xcEzr+pp+a3Az
 xKt4nHT5OwtS/z/1alsOnfse/eBD9XLVjnMLGyRnil0/f21qct9NntG6xoYt5a5SNh5vTk4/+7D
 FVwOG5RKPv/qUjcT/yUg8VYhKnpR4W1fXpHgCzqCUpNUAQ==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41317-lists,linux-pm=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: A74796B8F6
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

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
2.51.0



