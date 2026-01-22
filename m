Return-Path: <linux-pm+bounces-41318-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B4wMEZjcmnfjQAAu9opvQ
	(envelope-from <linux-pm+bounces-41318-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 18:49:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F056BAE0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00D1630AB177
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87B313E2E;
	Thu, 22 Jan 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M29OVZ14"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B237107F;
	Thu, 22 Jan 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102219; cv=none; b=mMMpPWTsAkc0xk6dRNo7o8En/JK1rgCiwC5Pv9eza/ZF1UAxqd8MJOz91pGKQ+u7arkpz5eMaEVLHbkrkW7tctYodRpQ4fxkobVmj/UZ+OrRm+fg08zhO7oLt1atdvWth+VKZpVffnhZiN9ejPFMs0Ln8KivHwpCyOnNm2doj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102219; c=relaxed/simple;
	bh=uPRpcrMOaYMruw+LV+JEloEWJR5gGfWdOJtHvSgr5JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMGaJIHijXEtrkYH5AATjI6gT2tqTRnPSqzWZexkxE64Cllca0UqtRTYOFduZa8dYj2FpvdgZLgvms55sqB+9WByfh629MV9ea9BcuwUnT4/eEN5Torbw9jY4B4rVBcqHv1Z9por3qjmGK7J7fAE/BYCz7Wqqrlxf8dR1gQ4g60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M29OVZ14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8789FC2BCAF;
	Thu, 22 Jan 2026 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102217;
	bh=uPRpcrMOaYMruw+LV+JEloEWJR5gGfWdOJtHvSgr5JU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M29OVZ14S3w8hSekJ5OXHdSKXxpqkIy1VbvfpvpjzdUjmB4imwF531lX99ZvgJnva
	 NXPDbOylHR22feVilx/oH4d6V3/ZqNgl7xAjEzz7YEj1JX4as50QTqzV7rYeGdVUuz
	 WeSqSB4bpNpfeq4okJqrLuTOlWqyL5Tw+h/r1g4ACMAYXn//UlFMxwDZQcEo8U5rCP
	 ce8vpzGNjtwsGLlS4DhZScbwnKfXxpQv9HmpJI1SQ+6gmPfI3otUn5e/XKUhVyONOm
	 y7INkkfZOMuCHeTPQj72nV0Yawzo17mq7ZFDilQHro31SmpGWRig8rKBskIY4QybpI
	 lxBkNtP7/OwRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77425D3EE9D;
	Thu, 22 Jan 2026 17:16:57 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 22 Jan 2026 22:46:53 +0530
Subject: [PATCH v6 3/4] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-pci-m2-v6-3-575da9f97239@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=smE99RkHH/faoB1zmIkyAwcapkpSsjVsJxAileZoxaE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpcluHA0O3bTT6GBQKs4Bu0/0Naq3FTjxCqXovG
 NOe4mh+GOeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaXJbhwAKCRBVnxHm/pHO
 9cfIB/sGcr8YJfw/XQuIliox5JDL3oiCWObJ6JZ386V5PCHHcvxQir+n8t/gVfSS/0ZNuBqebWO
 cv7QP/+WPeUslJZxTf+50wzKOt7Wt/Kj0O3/IrdoeFTt9LqhZ9fq3xvgJTQsz3Y/LX+SY2tB5hJ
 IhitRK4DPRiG0eLAcx5uVw4PTQSeZ4Vqb+KYynrCuuglmkDbzG5wAepctYwn1OZ6zpZkDbZC4vr
 3Q1aRCFoMN5qH8ablj7WFUEtMWTbdOA2MlFyKrFvbRvX8Bv6dBY459F5YGi8ov0Xh5H+IT2bA/V
 HLdEZrYEws3DXkh4i/MTtXpXLba50XJIzDt2ZN0HBvCTQ7k0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41318-lists,linux-pm=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:replyto]
X-Rspamd-Queue-Id: 23F056BAE0
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..cd7efd20a74a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2585,7 +2586,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.51.0



