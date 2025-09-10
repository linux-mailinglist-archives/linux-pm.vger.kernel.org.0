Return-Path: <linux-pm+bounces-34424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDF8B523A7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F6C1C82BB2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECAC3126DF;
	Wed, 10 Sep 2025 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b0PBYpbe"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB922333B;
	Wed, 10 Sep 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540685; cv=none; b=E4b4NZpi6+UnstAeeGuSMlgDJjTorPJr6Dyk8ElsBl3MId/gmxfqX0w/rTM6WA7HYiwhB5RF6D2oVR677n4nYTns3zadQRD5+nzUhKVbi5PZNCkEXhByInmBk+zQRYyMBsS+P/I83pUhMb14WsxQBKEb0eEXw13xk+S9TJCBS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540685; c=relaxed/simple;
	bh=xlW8quooVNdXtWkJmB0hXmDsnuvk2Jn7NEuIxTagAbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hldWtpfezsBObAhR3hq+c9q9W8QpuJK6VqJHM47ZkTQNE7gySSkVexA+r+841sLWauNf5aqEY1UZpzD0NuJ+3+oolFP5loNfaIzq4UY3D81HE02/JxGjUzoG7vDDHhsK7HlkGU1nN7pWVh/lpb0ZZixIf73//23fX6SAQKABcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b0PBYpbe; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALGtFR225957;
	Wed, 10 Sep 2025 16:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757539015;
	bh=9fBHeMDXGKZ0BRvRgsZi/dMbQnS2+VArdU+vF0c8rxs=;
	h=From:Date:Subject:To:CC;
	b=b0PBYpbeYOt0tDT6XLM5y9curno1o8hraInd2u198z0svC1s0wRXbRNsDY1R5FjlJ
	 7TWFpyLC6CxTqqa0zdi5vuZCitT5yUBuuch6ie8BnSSnmbZ3DMtJopDh7cp2sKy6lm
	 zO0IahuIJovkQEdJTDldrVDUW66fzFsRhmvwsvjU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALGtjB569811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 16:16:55 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:16:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:16:54 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALGsDL792374;
	Wed, 10 Sep 2025 16:16:54 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Wed, 10 Sep 2025 16:16:35 -0500
Subject: [PATCH v2] pmdomain: ti_sci: Handle wakeup constraint if device
 has pinctrl wakeup state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250910-uart-daisy-chain-pmdomain-v2-1-6d0215f4af32@ti.com>
X-B4-Tracking: v=1; b=H4sIALLqwWgC/02Myw6CMBBFf4XM2iHtIAKu/A/jorRFJtKWtPgK4
 d+trtzdk9xzVkg2sk1wLFaI9sGJg89AuwL0qPzVIpvMQIJq0UmBdxUXNIrTG/OBPc7OBPcdfVv
 1ZHrSldaQ/TnagV+/9vmSeYjB4TJGq/6KYk9SHkRTVg3VbdegxBs+eZo4nRYudXCwbR8cJZjmp
 gAAAA==
X-Change-ID: 20250910-uart-daisy-chain-pmdomain-b83b2db2c3cc
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>, <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For TI K3 SoCs with IO daisy-chaining using pinctrl wakeup state, avoid
sending wakeup constraints to the PM co-processor. This allows the SoC to
enter deeper low power states while still maintaining wakeup capability
for peripherals using IO daisy-chain wakeup via pinctrl wakeup state,
similar to the existing wake IRQ mechanism added in commit b06bc47279919
("pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups").

Detect the pinctrl wakeup state in the suspend path, and if it exists,
skip sending the constraint.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Implementation
--------------
This patch is intended to be implemented along with the following
series. This patch has no dependencies on any of the other series:

1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
   wakeup state": (this patch) skips setting constraints for wakeup
   sources that use pinctrl state 'wakeup'.

2. "serial: 8250: omap: Add wakeup support": Implements wakeup from
   the UARTs for TI K3 SoCs
   https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-8250-omap

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
   functionality to wakeup the system from the Main UART
   https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts

Testing
-------
Tested on a AM62P SK EVM board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

This github branch has all the necessary patches to test the series
using linux-next:
https://github.com/kwillis01/linux/tree/uart-daisy-chain

Version History
---------------
Changes from v1 to v2:
 - Reworded commit message to be concise and to reference commit
   b06bc47279919

v1: https://lore.kernel.org/all/20250904211607.3725897-1-k-willis@ti.com/
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 82df7e44250bb64f9c4a2108b5e97bd782a5976d..884905fd0686c1b94aba68c03da038e577428adf 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
@@ -84,9 +85,24 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
 	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	struct pinctrl *pinctrl = devm_pinctrl_get(dev);
+	struct pinctrl_state *pinctrl_state_wakeup;
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using pinctrl wakeup state,
+		 * we do not want to set a constraint
+		 */
+		if (!IS_ERR_OR_NULL(pinctrl)) {
+			pinctrl_state_wakeup = pinctrl_lookup_state(pinctrl, "wakeup");
+			if (!IS_ERR_OR_NULL(pinctrl_state_wakeup)) {
+				dev_dbg(dev, "%s: has wake pinctrl wakeup state, not setting " \
+						"constraints\n", __func__);
+				return;
+			}
+		}
+
 		/*
 		 * If device can wakeup using IO daisy chain wakeups,
 		 * we do not want to set a constraint.

---
base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
change-id: 20250910-uart-daisy-chain-pmdomain-b83b2db2c3cc

Best regards,
-- 
Kendall Willis <k-willis@ti.com>


