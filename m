Return-Path: <linux-pm+bounces-16196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA39A9D8B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91582832F4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546211917E9;
	Tue, 22 Oct 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TFU1buJo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9B18FC99;
	Tue, 22 Oct 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587322; cv=none; b=qCIRPdj2npKEFJhfOu87xMdwM3MqK3/vhjoYssLn7iN5HeX+SHG3qCdChGzAo3UVpGBjnIc+b6SgfBlbCyx0LS0vf/iY33IjVKO4mYokNMT0XNP+3iF161R2ASz6lVIwCpKBTA62lihbvQ4raUt/AU85lOdXjrC5eRzNhGcrbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587322; c=relaxed/simple;
	bh=sT4p+yBPhYLN4rIyh6LNKq8QiXwhbXA2cS3QlmxGMJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VvJFGFej14bwrH070wgjFLvdubSGWUCpG4vJhjUXvjW8umS+ao+c0Nj1RDfJhXCQSwQPpCXtF0CY7Yu7/2bGnz+QOXRBavhJLwGIwBubIwb4vHnG4AjfqPQEZ4h0uqrrsfnn52NCeRfmbyr7IqqzHtiOGarBrLLKyIlb6d1dM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TFU1buJo; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 38BA3C2EBF;
	Tue, 22 Oct 2024 08:23:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C2BCE0008;
	Tue, 22 Oct 2024 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729585429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZGkLsgNGgtfDauf8zg5VUFvg7kUsgGMuwlTOhxVF9X4=;
	b=TFU1buJotNx+cqphHj/84TYUcdwdxPWa3Gy8i4ZRHnJ0bJ3F7sE6aByM6+/H4Rxf6qz1eX
	3iK4yxHGf1ZCUybvBvwf/Bt302pZbNS3vLtk31xGbCLljvrea0RjuI/xEPV+CWjBNAZWEA
	FG+Ov8yEtf8yAgJQgqCHKXyw7qE091vjrZX3ms0/vVYliFljyx2oQTgRBdACCHQQQyGJTh
	uqsuKD+/acDp9Y1EwKp8/9EQGRBj70XPdpPDyeknndQjNvhRgI7VpY327M2T8ex1M8uW5x
	+8Qg8LiST+kQz/0QVsn2fY0eT8d1f5VAjVGuaGNFDIWChC8S4m3OettrdtnGaQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 22 Oct 2024 10:23:36 +0200
Subject: [PATCH v2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP flag
 for all PM domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAdhF2cC/33NQQ6CMBCF4auYWTtm2oJUV97DsMAySBPokBaJh
 nB3Kwdw+b/F91ZIHD0nuB5WiLz45CXk0McDuL4JT0bf5gZNuiCrLmh1SShjM2EQdBKSDIzplSY
 OLSqqjCHbmkoVkIkpcuffO3+vc/c+zRI/+9uifusOKyL7H14UEnLVkTmXjnRHt4fIPPhwcjJCv
 W3bFwlM0f7KAAAA
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: tony@atomide.com, khilman@kernel.org, u-kumar1@ti.com, 
 gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
 theo.lebrun@bootlin.com, richard.genoud@bootlin.com, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

With this flag, if a device is marked on the wakeup path, the corresponding
PM domain is kept powered on.

This commit fixes the no_console_suspend support for some TI platforms
(tested on J7200). In case of no_console_suspend the serial core marks the
device on the wakeup path, but without this patch the power domain is
powered off anyway.

Suggested-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
This is the second version of the series to fix no_console_suspend in the
8250_omap driver.
For this second version, the patch 2/2 "serial: 8250_omap: mark the serial
as on the wakeup path if no_console_suspend" was removed. No need to mark
the serial as on the wakeup path from the driver, as it is already done by
the serial core [1].

Regards,

Thomas

[1] https://elixir.bootlin.com/linux/v6.12-rc3/source/drivers/tty/serial/serial_core.c#L2407
---
Changes in v2:
- remove patch 2/2 "serial: 8250_omap: mark the serial as on the wakeup
  path if no_console_suspend"
- Link to v1: https://lore.kernel.org/r/20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..38448b4a035a 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -186,6 +186,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 
 				pd->pd.power_off = ti_sci_pd_power_off;
 				pd->pd.power_on = ti_sci_pd_power_on;
+				pd->pd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
 

---
base-commit: eec50dadcc91583e08dcabdf83147f6538831b5f
change-id: 20240819-8250-omap-no-console-suspend-1073308d3714

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


