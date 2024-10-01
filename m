Return-Path: <linux-pm+bounces-15024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B713F98C142
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F241F21C9D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512301C8FD7;
	Tue,  1 Oct 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhXZBah1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224601C5782;
	Tue,  1 Oct 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795545; cv=none; b=J3k7cVXB0tjq6SQSVrw5Xf1jWClURgJPxPytafDaNvs7p7eVpvXySHAtwvyZj8zFsraZzWC0A3kI2YuU1QAKWmeoM/kKLRZ3NSKFX1URoVZOVzdWoZeGSmJRnSflRvS7jWdo3GdPa4UiNZiqdPV8q5afoE4LWLwLSth24iJKhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795545; c=relaxed/simple;
	bh=vOb2cBg3YKOeU1ZQj9lyC4Y3LiyaLbKnBFaVZsWE8tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=efReEvhenN6yW4bXJmJIIdgZBu923tfbZVlgcEfode4D2Hb9VSwcmm3ddxdDP7i+FNmg0uabwjLhc3+bbg+pdzY1osQcSb6IfKkkBAGaxWB0wfrxJDUCmOzXMDukfza+8ZxvDEMJt6zjvn0GIWwofO6+YbQ1/+xlwOKRt+KKR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhXZBah1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3CC4CEC6;
	Tue,  1 Oct 2024 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727795544;
	bh=vOb2cBg3YKOeU1ZQj9lyC4Y3LiyaLbKnBFaVZsWE8tU=;
	h=From:Date:Subject:To:Cc:From;
	b=GhXZBah1Y6sKXkPJI7tFDxk20ayMPtxsnaNyUwQeoVsKfqciNGf3JYQKHL7WGbOoG
	 E+JIbvZcF6g0ido/TbG24JklHmVPopw0iuZ8sMbADdQlsBFUpWyWt7zlbZDsgkXZLX
	 u69IvToo3r30hSgP+lhik7L/DGTzfPCpqELVAIByURdU698WQMxQm7WiGX0VseyC/e
	 BlUBl7s17UKGtZw82x0GdjBKVENNfjQ0FKJbu2WS7QiWYv3faisL8A+E6BcqJRGBzC
	 KWbFSRV3pcweX59QdzEowGU0MiZAua6SSrtvUaBXvhauK0FIlDi8Nt9Ck/1Jx9Kfir
	 23JK5jbUiDa9Q==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 01 Oct 2024 18:12:18 +0300
Subject: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFER/GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyNj3cRcMyPdnIJc3dLiJN00EyMDS0PzpBRzA3MloJaCotS0zAqwcdG
 xtbUAp0RjS14AAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>, 
 msp@baylibre.com, srk@ti.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, stable@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3335; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=vOb2cBg3YKOeU1ZQj9lyC4Y3LiyaLbKnBFaVZsWE8tU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm/BFUmouOCKLwG6BHWujLlPbceU+uDh1JXzuaN
 T5ReiYdaGeJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZvwRVAAKCRDSWmvTvnYw
 k+9iEADHF+B7kkPnLXj5BsQ6N26i2Onk+8W6BI9VD6ucCARaZaNEOAxf+PHo+mo0srj2T3ad+C4
 eWghHfB0UrOK9uSQ6vW+pGxJFVJttdgx2o+QPMMrQiyVK6vnZ2YMGI8WgPE/EndyWClyuVLCB0Z
 cdihhJWLOObontSlsdwbjCNTjGMIjdgzSCFMH9x7fFE+ypmXHbJxvaNDH7XwqOMANfjS32db925
 isHnZvzNcrdJ5lD4IR3HXq2qK+aN2ln6AThY6EVi2qeEd8Db2vZSq6W30BzTjsLLY7Rg2/4qlHz
 HTQGgHye1in1Yvk4y0D2W6Yr532LcFz0GmlhTt7u4xAKnxkb8dmuNezTsZTUcJpKt7jFP/kJSby
 eGuykYnZHzKANbAuzBjipu18wYPgNa4hi8zfsyOAyJM15L2MLoK4sEnnkBZTmO/c0UzypUQZUNQ
 yiokqis4ws4QC4g6XeH3u5awmFEhaKsepnpQyTcsYTuQ6W60Ir8z477YAVEJVSTRJS3dFe+HUyC
 E6fdGtfrKK6h+Ey7uL0dqxR172US/ToOURzaZLVtzQOQUUkrkCOC4qWUiOZlCiC0vj1/v1sKPRv
 VbXY0Y3easAjSPRIbur2BAPFqzfQ2mdicU1RxXcqg5hcmqI7LJ9WX9/pD6NBE+UBnCbF+GbTesJ
 UE802tTXBsx4Rvg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
system suspend is broken on AM62 TI platforms.

Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
bits (hence forth called 2 SUSPHY bits) were being set during core
initialization and even during core re-initialization after a system
suspend/resume.

These bits are required to be set for system suspend/resume to work correctly
on AM62 platforms.

Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
driver is not loaded and started.
For Host mode, the 2 SUSPHY bits are set before the first system suspend but
get cleared at system resume during core re-init and are never set again.

This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
before system suspend and restored to the original state during system resume.

Cc: stable@vger.kernel.org # v6.9+
Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/core.c | 16 ++++++++++++++++
 drivers/usb/dwc3/core.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..1233922d4d54 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2336,6 +2336,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	u32 reg;
 	int i;
 
+	dwc->susphy_state = !!(dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+			    DWC3_GUSB2PHYCFG_SUSPHY);
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
@@ -2387,6 +2390,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	return 0;
 }
 
@@ -2454,6 +2462,14 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/* dwc3_core_init_for_resume() disables SUSPHY so just handle
+		 * the enable case
+		 */
+		if (dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..b2ed5aba4c72 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1150,6 +1150,7 @@ struct dwc3_scratchpad_array {
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1382,6 +1383,7 @@ struct dwc3 {
 	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
+	unsigned		susphy_state:1;
 
 	u16			imod_interval;
 

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240923-am62-lpm-usb-f420917bd707

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


