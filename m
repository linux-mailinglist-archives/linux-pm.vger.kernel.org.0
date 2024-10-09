Return-Path: <linux-pm+bounces-15396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31F996B2D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2106B281E20
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4CC19EED7;
	Wed,  9 Oct 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ0/iYub"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD419E810;
	Wed,  9 Oct 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478641; cv=none; b=o8ZUAvos7Nhk5YZb6a7BRfkCdPcf7NJMOJmSskcZsU3bDlktANeYyhwg+6ldD6Oqz9G5MWH3E1ZqOtrJuOxONx6D1IYyRIYyNiNehxhps1MEolorAgF+5MnvT+B9lfCOjql01GkbLHQIiOnnQNYzaurX/PpFhTAhuCFEQqCx9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478641; c=relaxed/simple;
	bh=8IhCRjWIMJnbPDun3mNQX2qTN/yRRn/AqPO6F6oY/Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TUISo4IMUuSWQtj/G8x06md+29qsJEUETqJVejz4m5x6ZLIPdrdC/CwVUX8km2qp5oXDPIZ3oEfji9nvmT/sk1rk7ZqftWVDU5HGUQIat3uwVHkjC1HAz/VAOWQdgNhCY2OCwMpJ452RcDGIaqnZ2s1LYiAFFLdWtPLA0W7fpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ0/iYub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEEDC4CEC5;
	Wed,  9 Oct 2024 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478641;
	bh=8IhCRjWIMJnbPDun3mNQX2qTN/yRRn/AqPO6F6oY/Co=;
	h=From:Date:Subject:To:Cc:From;
	b=HQ0/iYubJ0Bdk/HVfSKAkbmmCq4G0XPANKQYzz4gDSSk7LFvnS3FBzLeupHL9XxRN
	 yHQlaRxPg2BNm5G/g5m8LNNe3Io3ggTKdyjQX6L1dvhKUmZ1WDIxRnzdH95iTbYo8x
	 rfj71JW4EzHJ9frAUkjhd7dzPAdDGCMzuwziHl0kOAqtBqEUG5v27yIEnpO1kiM0tx
	 3YP39fGxTB5rrNX/mlJqz1xvD5ZNkJo1Uxel5m7YEsYYHcFRxJaKUmcPzea1UK7SUN
	 jPTmaNsuEoBVmDExfNeTu68S8J18a9e27rE8K+k2HhK+8sbhbfQ5ZokVzeEMT21X1i
	 InCh31sJ/3+wg==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 09 Oct 2024 15:57:10 +0300
Subject: [PATCH v2] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKV9BmcC/1XMQQ6CMBCF4auQWTumU7FNXXkPwwJkCo1ASatEQ
 3p3a3cu/5e8b4fIwXGES7VD4M1F55cc8lDBfWyXgdH1uUEKWQsjT9jOSuK0zviKHdpaCkO667X
 QkC9rYOvehbs1uUcXnz58ir7Rby0QCUH/0EZIaAypThOps9XXB4eFp6MPAzQppS8FS7ikqQAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=8IhCRjWIMJnbPDun3mNQX2qTN/yRRn/AqPO6F6oY/Co=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnBn2p1PV78RWX1ZBB+teMidYY/dgel65dGlr2d
 tcgrZOBVlSJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZwZ9qQAKCRDSWmvTvnYw
 kwvGD/kBIQd5JF9Nci5wIBzSKekzEDc4VdPHkPEpdEl6HBoY9TEIwgylyGw+vzsK5kGe9mfwx0d
 NsYYGtHmtlrD1YIAuZKjUVzyEk5A1N223565sLkw6lg/wYlYMeV5Ehiq6Vw0Z/bS7xS3YB6+Q4E
 rs5eHREPKUMJdaVGU9ViWOfPtdpoo8Tk4Q9N8wrCzfYAxfZgCqw20jGGfR4EP4dSKKNPr64AUtd
 ZF0aYp45Psxt8kC71iPX+5uKZ38ShhXFPon7dAb49l8KfaHmStz1Nxc60pj7e54NvypyRkz+u3x
 JV6QhTI8lR95BUTYttAbznR1BP2gjnjbSBJQ+8/dymV4CnMYtoWQPfIK7Jou8+IxYpa318e4ckS
 MZpTWAV9J618BnXDb1aweJyOhKojmo9mmTntOQLVvwuqeO34Frs5m3W/mNu6kq2PTaEpYRI7HQN
 lMVEfBcgb8t6Lhv8IhhVKwqDSro8H+ZEGXFU9ejgT4f3pbnvKtyDS4qi5a3CFyrZ6lCq+wndtKS
 03vG5fwXwbkmI+yl16YI5aInfBeNtmeBsD33Ikr4E3I38A9yu3+TSBrXHFsKEBRqRKGTzmcIGtE
 VazhjBYRo0a8prczK0mXV9l8W8tIKznVhCIdFHqFgV46i4aZJd77VQy/kgOF7wxD51a05NsCIdM
 EkzVY8IRwPNm5og==
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
Changes in v2:
- Fix comment style
- Use both USB3 and USB2 SUSPHY bits to determine susphy_state during system suspend/resume.
- Restore SUSPHY bits at system resume regardless if it was set or cleared before system suspend.
- Link to v1: https://lore.kernel.org/r/20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org
---
 drivers/usb/dwc3/core.c | 21 +++++++++++++++++++++
 drivers/usb/dwc3/core.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..20209de2b295 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2336,6 +2336,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	u32 reg;
 	int i;
 
+	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+			    DWC3_GUSB2PHYCFG_SUSPHY) ||
+			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+			    DWC3_GUSB3PIPECTL_SUSPHY);
+
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
@@ -2387,6 +2392,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
+
 	return 0;
 }
 
@@ -2454,6 +2468,13 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/*
+		 * restore SUSPHY state to that before system suspend.
+		 */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
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


