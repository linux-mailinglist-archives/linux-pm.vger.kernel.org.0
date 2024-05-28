Return-Path: <linux-pm+bounces-8207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA5E8D11C6
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 04:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1591F251F9
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2717C74;
	Tue, 28 May 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3MwJj4v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951A44C76;
	Tue, 28 May 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862738; cv=none; b=W9m56rtQqcZIuwtmBuBU/b3Ky32ssOrcwDoVGIjnlUymcpy9Ixyk2hkX9GuitmTN/E1xFuuTqK4uJK8dba1BCsKqYFXOeAiO0uCt+DJoZ77IsCe1WiYKPWgTv0MrAvWtm9EagBlWnNdZbRBYO/r3I5QAIBxiad1fBRAL5/inPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862738; c=relaxed/simple;
	bh=fwEiQiX4cnxFfIKH2+2+aLGcHFwRzp3EH0PqQdljIpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kS4W+gGZso2izjh1Yoxw5TPgFtUF/xfRdN+Jc71gGHqxeWHN9enhKqG6T4LeEbt4JGyydp52pJuvHgexg0lyBBOg25849G7QYdh27Tp2z07N+ds/Vuk00cS3r/FPu1Sxt4tVVDb5g3mzwKOBHQ9d7KS+zZzbWRyVYAIULvOYKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3MwJj4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7531C2BBFC;
	Tue, 28 May 2024 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862738;
	bh=fwEiQiX4cnxFfIKH2+2+aLGcHFwRzp3EH0PqQdljIpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=k3MwJj4vNt+ASjRsgmr+DFjehx9VoPWYIOz29fUUY8g7bCNzYUMqyVNfS8b0v2/Ee
	 c7Qo9xILYnqwbv6qm754pXdQYiBGCJoUJAOYt1NnFFbM5fTCLSJ0emZMD2iZ2IL2ul
	 wfhkhCAuc+xJdrfnONS8bRU014q0PGGncGacI1AfwaQ/uyDzkboAMaBWp98votNLlK
	 whslK0Eo/UXeTVpeaCR0lQ4MwVMTWqOZnnDwHvdgNaver6AoYttAv9GvFecFN0bgCY
	 MC8aTeH+NUSZH/6SLfgNtss991An0M4HYqR21ELB2llXafmUwZFr4Arxb+TFmrmhUP
	 jjU08e81FBB8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/4] power: supply: cros_usbpd: provide ID table for avoiding fallback match
Date: Mon, 27 May 2024 22:18:50 -0400
Message-ID: <20240528021854.3905245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 0f8678c34cbfdc63569a9b0ede1fe235ec6ec693 ]

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20240401030052.2887845-4-tzungbi@kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index b6c96376776a9..8008e31c0c098 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014 - 2018 Google, Inc
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -711,16 +712,22 @@ static int cros_usbpd_charger_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_usbpd_charger_pm_ops, NULL,
 			 cros_usbpd_charger_resume);
 
+static const struct platform_device_id cros_usbpd_charger_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_charger_id);
+
 static struct platform_driver cros_usbpd_charger_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &cros_usbpd_charger_pm_ops,
 	},
-	.probe = cros_usbpd_charger_probe
+	.probe = cros_usbpd_charger_probe,
+	.id_table = cros_usbpd_charger_id,
 };
 
 module_platform_driver(cros_usbpd_charger_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0


