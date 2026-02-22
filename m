Return-Path: <linux-pm+bounces-42976-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EISaA20Cm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42976-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:19:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2516F319
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B446F3044160
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4628314C;
	Sun, 22 Feb 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="ISn0kRq1"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF3261B8F;
	Sun, 22 Feb 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766228; cv=none; b=JJvu2b6alF8BDLt2OppWeXLWJNre+0pGCtiYwtEaRp41qWbEqnnjNfDy6tzULLoV3/w4xdDTTM4Alz7qVXuJNYl0rUR2c4927x/srWZ0XGxBRSQj+0FdXR452tx14p6pRhOgSspCPj0WQHPuCW84VKW0yW2/47kod7yGB/y+gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766228; c=relaxed/simple;
	bh=rl1o85olwtyeKiJ3a29MjyFoNpl95KpuhJbSkCQ0s98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbQd6lNvO1AKx08QtgmTLOQh6SgIixF57Z4zHoFwBwx14VnsyHeqRdKF4zyzHAqAqCYqXpKOlyBC0KrJiDXTceJwQtpa8z1IdIwgnCmGztc4L7IpB6kKylMedIxII7kgdiJXPNph2Qpzg3/KN68Sm7f4xVI/sU++yNZZ9UecpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=ISn0kRq1 reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 8FA611C01BB;
	Sun, 22 Feb 2026 14:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Thr0KRft/tWkuxu4K0+Lc8O1rk4lpDG7j9bc8bU5PYs=;
	b=ISn0kRq1cp7ntNPh3GoWBYisx6jhyBfsAQEFuAX8dk4wmMry2bwM0lg/4lrX8CFv44u+gq
	cJ84O0hUk/HdFtA3ktdwGLe/E7DTMrDAvPJieDnM3FwwNbvwQ9p6V0kIubi8Ij2acQzF1P
	Df0uUbef2AwhJEQlZNT3GEKnJ1CjDx9SGb+W4jUrfj8WqDR+TQ1BcJ4TIS2LGjWUKJ3Wx6
	HWNTRkQxz7ArKwO18X9O4vKH6h7XHLrIwiTl6DcQAsp8UYmdKaz4wT5CyZ4wEO2cjJhSKS
	dvZtKNbL7L9ArpGc5yQHJmqpPV72dcdYKS95nqmXIWcMNlJPuqs4ks9tiy5x+g==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sun, 22 Feb 2026 14:16:49 +0100
Subject: [PATCH 5/6] power: reset: sc27xx: Add platform_device_id table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260222-sc27xx-mfd-cells-v1-5-69526fe74c77@abscue.de>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42976-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[abscue.de];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com];
	R_DKIM_PERMFAIL(0.00)[abscue.de:s=dkim];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[abscue.de:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[otto.pflueger@abscue.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.539];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,abscue.de:mid,abscue.de:email]
X-Rspamd-Queue-Id: A9A2516F319
X-Rspamd-Action: no action

Make the poweroff driver for SC27xx-series PMICs probe automatically.
Since the device representing the poweroff functionality of the SC27xx
PMIC is not supposed to have a dedicated device tree node without any
corresponding DT resources [1], an of_device_id table cannot be used
here. Instead, use a platform_device_id table to match the poweroff
sub-device instantiated by the parent MFD driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>

[1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/
---
 drivers/power/reset/sc27xx-poweroff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 393bd1c33b73..6376706bf561 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -6,6 +6,7 @@
 
 #include <linux/cpu.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -70,11 +71,18 @@ static int sc27xx_poweroff_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id sc27xx_poweroff_id_table[] = {
+	{ "sc2731-poweroff" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sc27xx_poweroff_id_table);
+
 static struct platform_driver sc27xx_poweroff_driver = {
 	.probe = sc27xx_poweroff_probe,
 	.driver = {
 		.name = "sc27xx-poweroff",
 	},
+	.id_table = sc27xx_poweroff_id_table,
 };
 module_platform_driver(sc27xx_poweroff_driver);
 

-- 
2.51.0


