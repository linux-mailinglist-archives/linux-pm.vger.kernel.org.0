Return-Path: <linux-pm+bounces-15537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC899A207
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 12:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350B1B22882
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85125212646;
	Fri, 11 Oct 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLErmwLa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545F210C11;
	Fri, 11 Oct 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644022; cv=none; b=M/wt1kAzA9FZEU/nyrNNVA+/aZ/Ai8EB71NpA9hW/bgTqKSYxKDdAnYNTCgbpN3CP+QIR1Ccr6qMvZwsbAyVdNsMhThXf0iYrVwv1q7ae/HmyeS6shotUxVJ7iJUUCAtK7gxGuWHdqGMHVKwgyxqCQPyGUnht6vSWP1+FCij2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644022; c=relaxed/simple;
	bh=SMSAwURTM1d5RipIGE/rB4foIsdd0HI1hdITJc1eIWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eZGydDBvoHBYn276TR2bKUH4wjZ7jsE0mt6xFGxNaSdCyFKgz3k7dhamXizfa+WZDxjib/oangdy9MXMXFevXLW1n11s3er/W4bLQ74LkZYMWBRWv4sDYn94WZjLM7Kz+1P21OsVOQrdU7QhIEL5Sa57Y/M2oy8nms2vq8rYbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLErmwLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003D0C4CECC;
	Fri, 11 Oct 2024 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728644021;
	bh=SMSAwURTM1d5RipIGE/rB4foIsdd0HI1hdITJc1eIWQ=;
	h=From:Date:Subject:To:Cc:From;
	b=cLErmwLayP9ONrUIcQ5NUPsnImMlfKAGPKJ94ZbYel10Dj+DNS407zuPUdOltR1yI
	 dE/kXlW62n+LiAwl7WoS1VqzWbeal8kj9AKZKJiiAc5SjxZYmhieBXIdmTB3iEUPNf
	 CiNfXwBJipRyhScvz9EijSkBxBloCXYUx5PK5pOqrROd534d/exqMc9UwOxIZGtuiE
	 4jR0DzKmL9lboZa4+81fz4Wsla1bXdMAFVlzsTKxZfY8t24yPBzPxo4Ir3sDU4UHWm
	 ZOD7ZXdqdBvuEldcvkFJ02vCVNb/A87pmYSCjAVj5kdYfWXh+SPA/KtFNvfu+R1UGQ
	 UTW3BFMKp1zsA==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 11 Oct 2024 13:53:24 +0300
Subject: [PATCH v3] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKMDCWcC/13MSw6CMBSF4a2Qjq3pvWCbOmIfxgGlF2jklVYbD
 WHvFkbi8Jzk/xYWyDsK7JotzFN0wU1jGvkpY3VXjS1xZ9NmKLAQGnNeDRJ5Pw/8FQxvChQalLF
 KKJaS2VPj3jt3u6fdufCc/GfXI2zvDoEQcIQicOBagzQKQF4aVT7Ij9SfJ9+yTYr4W+u/GlNtK
 5S1qC0aoEO9rusXCIoagucAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4130; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=SMSAwURTM1d5RipIGE/rB4foIsdd0HI1hdITJc1eIWQ=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnCQOxqBmfPC7eJ+c6SU8SoLZDV4m1FX17mmtof
 Pg59HytZ4OJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZwkDsQAKCRDSWmvTvnYw
 kxCiEACzojewd1nrTI35G+GeuXLP49y/iaIJEt2DCqrgIZY0S58KivuWPzK3Y9X/576gwoYO3kl
 0NM6jUpW26tCZYFxxkT6IdaFbtwNTB7qYqAcnUFHURd46OlD06etXmtjDlLT8i9wxK1+mZDSMUP
 F9Pi5/ZipbtYeUVG6f7p+dNH+pqo9Vr3Q44RdThtCgaekEAJSUF00ZvV0bDJMymcOIqsvvGtxkC
 IeIP8fBSdx64NamC6Nimr7pYI8cP4DkMma1j1StVp/bwJ4fiZlz4lV6UAXSY27rOJkXwfSrNteE
 IHSBGIZP3Abml1QGT2jPjnyyjFRcHo39XrQ3L/uVDE06QoImjWZOezAQTZ821BwjfhMOrKQeXwk
 GkBTJwyrZ8+SrqrgdlQ1UUtsAqWtEojqpJVKLx8J7Gm4k1oqrwa6YymSIcVcseSz70rhlu0CITp
 vVU3wu+n8l9P1+Nmwcz1+0IITxyGjiGhwZ/hDqfuS359JypOos5OTmik2ZVFe1QktKaGpWYRUA9
 YQ6vJNhomn991yh4QK76hhu57RC7uGjLGNb5EoPl2fT31zAyOkvUemJKJCKXRaGMgJmqn8vs0Gb
 QCXZQ2cj1gkjWLNvWUiRTeykn3uBW8jtNnwf48ODXw/tZ+ROfQcl8hKzn+rSOezSxJLcL/RNgtE
 DVucmURkWBVLcsA==
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
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changes in v3:
- Fix single line comment style
- add DWC3_GUSB3PIPECTL_SUSPHY to documentation of susphy_state
- Added Acked-by tag
- Link to v2: https://lore.kernel.org/r/20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org

Changes in v2:
- Fix comment style
- Use both USB3 and USB2 SUSPHY bits to determine susphy_state during system suspend/resume.
- Restore SUSPHY bits at system resume regardless if it was set or cleared before system suspend.
- Link to v1: https://lore.kernel.org/r/20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org
---
 drivers/usb/dwc3/core.c | 19 +++++++++++++++++++
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..ca77f0b186c4 100644
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
 
@@ -2454,6 +2468,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
+	if (!PMSG_IS_AUTO(msg)) {
+		/* restore SUSPHY state to that before system suspend. */
+		dwc3_enable_susphy(dwc, dwc->susphy_state);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..31de4b57ae7c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1150,6 +1150,8 @@ struct dwc3_scratchpad_array {
  * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
+ * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
+ *		  before PM suspend.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1382,6 +1384,7 @@ struct dwc3 {
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


