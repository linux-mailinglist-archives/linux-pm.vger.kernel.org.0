Return-Path: <linux-pm+bounces-26013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA647A981FA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DB8189A721
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201327B4EA;
	Wed, 23 Apr 2025 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EeQspoWr"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614027A93A;
	Wed, 23 Apr 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394859; cv=pass; b=t9d9Nw/+fdd2or1tNOEntRTURodTNrcGrYzFBPOr3J9gDs4Z/oMN9mWRIgCIPAQG+Rna90T6wC+tO9WsRUuMmBf4wXmDprUiTtKp9/6/lcg3gHOHI2UC90TplE705k6S+ZdP2DiP/br7dKeZCD4+0FkeT6/pgPbj3GKxqt2/JWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394859; c=relaxed/simple;
	bh=LGO4kk+bq2xXbKOrta1rlVIrB6tbMRDchCZNNF4pD+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=af2r4n/quTYVmXRvRKTtMOcKy1hHAjuHC0fcB13heCaYMyR4eVQLWEj7gj4Uzn0M3RduOlO8xcEDJ4x43ONybVxsBHa/nA1FMnBgV9qHRkP4rwyE5sjHsBHCXbO9RazGiZVj3pOg9KLOgHRY/eHB0Jt6KlCU6P2euFMIjvon8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=EeQspoWr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745394828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l2QuKe/naQtdCK/UHh5fyBtiP47dQkbaOA1fo4k3vk0lt3/LssUVniRCYGSiocb+TOGDUKsYSYKPGUx9bvWQAx3+KylYPcHNY7Oce1Bj7j01l4Sj0CBcmVtLkSSlqyV3vx8g0rJQdiCtLd1xMY7vmSZKpESKYXr6wwV3keXBcjk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745394828; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Oijd0aKBdyplMTnNPJrIqrieZmKmWwupu3pm2u3MJ64=; 
	b=I0eHXxv5l1nsUJD8DGsbw644Z6TIdJ13y3TFHmlJYPiscH8PgMhQ2fjSlQRU6pfcNxbeAvDPTT6+VoQlo2/V2aOWmmsUO0WQ11xzvnoU4fw38B16cRlHrJC4X5GD1S73J5A5bTYzojG6oTPDQ//MlAocdlSGEQOxx1bLiD6+nf0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745394828;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=Oijd0aKBdyplMTnNPJrIqrieZmKmWwupu3pm2u3MJ64=;
	b=EeQspoWrECM8FVvMhgq0pxQ/UpzK7XmT0IycpYq3W6VvHXwbyCzFjicjSZzF0i/l
	whh9XZv+NwxWQPWd+exftk33dP/V3kyOaL/uyuKlK7u++wPwiZE+os13oRmI+z38W/N
	zJBF15oaarzdvGT2+83SaHD9tlrjQf92yYh/YIK4=
Received: by mx.zohomail.com with SMTPS id 1745394825558639.0210285939858;
	Wed, 23 Apr 2025 00:53:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 23 Apr 2025 09:53:32 +0200
Subject: [PATCH v3] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-rk3576-emmc-fix-v3-1-0bf80e29967f@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHucCGgC/3WOwW7DIBBEf8XiXCJ2AZvklP+IesCwTlDj0IKLW
 kX+92DnECltjjOaeTNXlikFymzXXFmiEnKIlyrkW8PcyV6OxIOvmqFALSR0PH1I3bWcxtHxIfz
 wzjsDtsVOIbLa+kxU7ZV4eL/rRF/fFTzdTdbbTNzFcQzTrintBjRPTrIlfAp5iul3fVNgTb8cL
 sCBey2VV1urYNB7F89n28dkN5W+fFm7Spj/u1KIrUHTQy/hqbt8KfjYV4B/GVgZRgpqtbReDeK
 ZMc/zDQ3pxEpfAQAA
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

RK3576's power domains have a peculiar design where the PD_NVM power
domain, of which the sdhci controller is a part, seemingly does not have
idempotent runtime disable/enable. The end effect is that if PD_NVM gets
turned off by the generic power domain logic because all the devices
depending on it are suspended, then the next time the sdhci device is
unsuspended, it'll hang the SoC as soon as it tries accessing the CQHCI
registers.

RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
added to the generic power domains API to handle what appears to be a
similar hardware design.

Use this new function to ask for the same treatment in the sdhci
controller by giving rk3576 its own platform data with its own postinit
function. The benefit of doing this instead of marking the power domains
always on in the power domain core is that we only do this if we know
the platform we're running on actually uses the sdhci controller. For
others, keeping PD_NVM always on would be a waste, as they won't run
into this specific issue. The only other IP in PD_NVM that could be
affected is FSPI0. If it gets a mainline driver, it will probably want
to do the same thing.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v3:
- Reword comment and commit message to correct that this is not a
  silicon bug, but seemingly intentional design with regards to runtime
  power management.
- Link to v2: https://lore.kernel.org/r/20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com

Changes in v2:
- Rewrite patch to use dev_pm_genpd_rpm_always_on in sdhci driver
  instead, after Ulf Hansson made me aware of its existence
- Link to v1: https://lore.kernel.org/r/20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 09b9ab15e4995f0bddf57dd309c010c849be40d9..a20d03fdd6a93ecc5229c71f825bade5ac730370 100644
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
@@ -745,6 +746,29 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 	}
 }
 
+static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int ret;
+
+	/*
+	 * This works around the design of the RK3576's power domains, which
+	 * makes the PD_NVM power domain, which the sdhci controller on the
+	 * RK3576 is in, never come back the same way once it's run-time
+	 * suspended once. This can happen during early kernel boot if no driver
+	 * is using either PD_NVM or its child power domain PD_SDGMAC for a
+	 * short moment, leading to it being turned off to save power. By
+	 * keeping it on, sdhci suspending won't lead to PD_NVM becoming a
+	 * candidate for getting turned off.
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
@@ -1176,6 +1200,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
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
@@ -1274,6 +1310,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
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
base-commit: f34da179a4517854b2ffbe4bce8c3405bd9be04e
change-id: 20250317-rk3576-emmc-fix-7dc81a627422

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


