Return-Path: <linux-pm+bounces-25320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0EA86FA6
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0568189EDE0
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 20:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3EA18C910;
	Sat, 12 Apr 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PPx1dBZw"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC851148832;
	Sat, 12 Apr 2025 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744490758; cv=pass; b=dlGk4ZzhELUwHEUgXhnceCJnCr1+RJzUi9/ZDCesVl1sRAvr/jQh/Q8LrqyJZryuy/sjOpAE3xw9RjzLsR16ms1TLb2S8Zopf/PzXwch4g3J5D8B3SPRxX8C6+jU4tSDiATaAlgWH+H+BwP7e2yBIZLUkkiZ5ApUzBglYUIuDAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744490758; c=relaxed/simple;
	bh=ntwujtdB35n8FOylzS58DbsgUrHCSdjp+UwNAlfu7KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZPb+EXhGNiTEIzR5R2iIrAQFZc/SERIKUKX0DmtOilRcN7Vp5Zi2M9qdZcAYdlgerUe48SCXDoQ+w3OZ3b4kyZ5ly1st3Z3Ayvp6+dOQUVK1vzB52kEGCa2BpMAGO1o6atJQhJ7+Ldl5E+5E7joPYIOBkhjV2ih4Umx58IlpYwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PPx1dBZw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744490727; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LkB4JmyPpInWvLyByLSXnrVwUoHwkko0u0pgw7pRQuJ8cnCjbEUOJ0QByfp1DVNc87WcDJdTrMjvwo8H5qW2VpVBpJSWsVzj6R8om4Q30l/xCX+SBth+ukcVpfgfLtb8nc4UDysXMqumpybjoBdxeRZGQZxCobR+eaW0vXtS3KU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744490727; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ck4o/n3lpkxAXlPzedzjCk/JD+YtxzckBUpPpLxJb6o=; 
	b=Fzo2zKJFej2Ingwr3PPjnkPU4k2Tx7JeYwULVE9T7dUQInM5NcUNgiiYYNchX5aEEP6QRjH5WAr+2NFI+YpjblMo9DFui1YVEBcp+0sJkYh36Ew8f4qO92ZsCuoIJyzelTt8XS6bhYnUHDb7odjMJQGE/jII9Wblk1Nl1Nwd0M4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744490727;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=Ck4o/n3lpkxAXlPzedzjCk/JD+YtxzckBUpPpLxJb6o=;
	b=PPx1dBZwrk2/pChhtqkioqIHh5RKqd9VDJ4kk/HvIClo890Q6K1dNuh56IWPb7gc
	kiUJs3fF6Kw2hc9BMcgj1UeuW0RqTiv3p5yuVarNCaePg7fDCPrXxjid8mD7W4TBTVd
	eSCsikskvXbgOKRioptue4ke9eea40NL27KpXMJE=
Received: by mx.zohomail.com with SMTPS id 1744490726578169.77104371916073;
	Sat, 12 Apr 2025 13:45:26 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 12 Apr 2025 22:45:08 +0200
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com>
X-B4-Tracking: v=1; b=H4sIANPQ+mcC/3WOyw6CMBREf4V07TW9ffBa+R+GRSlFGoFqi0Rj+
 Hdr3RldzmTOzDxJMN6aQOrsSbxZbbBujoLtMqIHNZ8M2C5qwiiTlGMB/sxlkYOZJg29vUPR6RJ
 VzgrBGInUxZtop8Zj89HeXG+xePmYpFXBgHbTZJc6W/M9SvAayTs82LA4/0hvVkzpv8MrAkInu
 ehEpQT28qDdOKrWebWP7e8viRW0/M1ySquSlS22HL/YZtu2F2uNYI0bAQAA
X-Change-ID: 20250317-rk3576-emmc-fix-7dc81a627422
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

RK3576's power domains have a peculiar problem where the PD_NVM
power domain, of which the sdhci controller is a part, seemingly does
not have idempotent disable/enable. The end effect is that if PD_NVM
gets turned off by the generic power domain logic because all the
devices depending on it are suspended, then the next time the sdhci
device is unsuspended, it'll hang the SoC as soon as it tries accessing
the CQHCI registers.

RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
added to the generic power domains API to handle what appears to be a
similar hardware issue.

Use this new function to ask for the same treatment in the sdhci
controller by giving rk3576 its own platform data with its own postinit
function. The benefit of doing this instead of marking the power domains
always on in the power domain core is that we only do this if we know
the platform we're running on actually uses the sdhci controller. For
others, keeping PD_NVM always on would be a waste, as they won't run
into this specific issue. The only other IP in PD_NVM that could be
affected is FSPI0. If it gets a mainline driver, it will probably want
to do the same thing.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- Rewrite patch to use dev_pm_genpd_rpm_always_on in sdhci driver
  instead, after Ulf Hansson made me aware of its existence
- Link to v1: https://lore.kernel.org/r/20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 09b9ab15e4995f0bddf57dd309c010c849be40d9..a00aec05eff2da8197cc64690ba9665be756e54a 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -745,6 +746,28 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 	}
 }
 
+static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int ret;
+
+	/*
+	 * This works around what appears to be a silicon bug, which makes the
+	 * PD_NVM power domain, which the sdhci controller on the RK3576 is in,
+	 * never come back the same way once it's turned off once. This can
+	 * happen during early kernel boot if no driver is using either PD_NVM
+	 * or its child power domain PD_SDGMAC for a short moment, leading to it
+	 * being turned off to save power. By keeping it on, sdhci suspending
+	 * won't lead to PD_NVM becoming a candidate for getting turned off.
+	 */
+	ret = dev_pm_genpd_rpm_always_on(dev, true);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "failed to set PD rpm always on, SoC may hang later: %pe\n",
+			 ERR_PTR(ret));
+
+	dwcmshc_rk35xx_postinit(host, dwc_priv);
+}
+
 static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1176,6 +1199,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 	.postinit = dwcmshc_rk35xx_postinit,
 };
 
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_rk35xx_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	},
+	.init = dwcmshc_rk35xx_init,
+	.postinit = dwcmshc_rk3576_postinit,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_th1520_ops,
@@ -1274,6 +1309,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
 	},
+	{
+		.compatible = "rockchip,rk3576-dwcmshc",
+		.data = &sdhci_dwcmshc_rk3576_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3568-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,

---
base-commit: 64e9fdfc89a76fed38d8ddeed72d42ec71957ed9
change-id: 20250317-rk3576-emmc-fix-7dc81a627422

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


