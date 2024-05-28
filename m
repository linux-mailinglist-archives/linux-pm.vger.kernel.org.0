Return-Path: <linux-pm+bounces-8206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1658D11B9
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 04:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F7E284847
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 02:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB471094E;
	Tue, 28 May 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5GwziaY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B7286AE;
	Tue, 28 May 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862724; cv=none; b=jElCP3xUr6Sg8Ys20wdv8eT8TP2N13eNa6QaXABAp9E2AmMfkxVL936/I5bG2eTQe7L9FZxr9NOJIfRcXSep3p0+Shz5uw4X+OlEIeDe43zcoNbfh4+vICDCXj1jUl900XjerM7KkCXG5oc+G5OUfDc6pHZGXvepU6RjGyv5kuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862724; c=relaxed/simple;
	bh=fwEiQiX4cnxFfIKH2+2+aLGcHFwRzp3EH0PqQdljIpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjKjPCJBmvuh0SunzCIYyXwWs8YnVbeecWygFOoiIFGyRFIcYcpQ/pn/62wfJSkjgZBVqCVCunUcVjZCWjbs+DaLdU1O+qeukzYvBsVPRqCybaZAiQL4Rp31spGYe8sK9Px4g9nNC0lURESuA2lCYT9GOG8XQmfDM8L8A8IPRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5GwziaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9657FC2BBFC;
	Tue, 28 May 2024 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862724;
	bh=fwEiQiX4cnxFfIKH2+2+aLGcHFwRzp3EH0PqQdljIpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=I5GwziaY5qC6YC+KXL5uKqcWFd+8+C6RJbBOE/9OGBxxwVSxWb2cz8uFKFrXLe9/U
	 5zrLeizFI1PLkFhlxlKHj+wGwMJiy4hFkLzaSExz7eDN8f1wTtR1+TKOCiWblb+99z
	 8SOi15LI9OkRaCZwldQXMpUhCzLVxrrkBRGv23YVH84b8klsXKxuHUjx6JlKkuH1MT
	 znq6Eapbx8prbfDxukibFr4CzGHFZezZSJ6Pgn0SDgF6qDXlVCZpAPdnFn9/8Fe7E1
	 /7SPeDD16cOyAV93g+yiAC4Ij7P8MsZOwLJtKivnChoR0KVTMxVk/HrS9NDy+v2VBF
	 Wu4y4moR9mW8w==
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
Subject: [PATCH AUTOSEL 6.8 1/4] power: supply: cros_usbpd: provide ID table for avoiding fallback match
Date: Mon, 27 May 2024 22:18:36 -0400
Message-ID: <20240528021840.3905128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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


