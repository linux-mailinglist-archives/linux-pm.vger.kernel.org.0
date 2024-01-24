Return-Path: <linux-pm+bounces-2684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F1383A992
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8C1F27FDC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C46519F;
	Wed, 24 Jan 2024 12:22:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614C634FC
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098950; cv=none; b=OV3IDmZV+8320RGChtbYsAgEKD3DgbHStpBZAuQho1/q+CLVLyb42waHc+1OrJphMaLn+oiZ3RjDcntKuKbOhgfpz2bPu/0TNINsjLFiQcMhgTzY49dDWdE+rrFpeqWh6szvQ7RtqjWEP5snnioivWEw7Ag+YtMfl7iOZh3Fttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098950; c=relaxed/simple;
	bh=aGoYIr6WP6qwdiccu6/EeWFB5o3ysjwmHOnTwOOjDkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gj17KBUjK3Ijbw2LSRYqCyEvKFLMW4Aha0ceClTJ6uPLMvBUkvXjOW7Vk9wIkbiC2cmLYGyURhmDB3JQOlCO8H+xVebBBnC5Nc0gmVw9usIG4Z6f2cpWNLj7PEX7Bj8kH1KCe942KCgaGr9O8oNfKPXLrOymQwoduE+oKePwbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGd-0007oB-1C; Wed, 24 Jan 2024 13:22:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-0023Zk-2z; Wed, 24 Jan 2024 13:22:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-00341u-00;
	Wed, 24 Jan 2024 13:22:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v2 7/8] regulator: set Power State Change Reason before hw_protection_shutdown()
Date: Wed, 24 Jan 2024 13:22:03 +0100
Message-Id: <20240124122204.730370-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124122204.730370-1-o.rempel@pengutronix.de>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Store the state change reason to some black box, for later
investigation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a968dabb48f5..a811a5ff2273 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/pscrr.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
@@ -5095,6 +5096,7 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 static void regulator_handle_critical(struct regulator_dev *rdev,
 				      unsigned long event)
 {
+	enum pscr pscr;
 	const char *reason = NULL;
 
 	if (!rdev->constraints->system_critical)
@@ -5103,17 +5105,21 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
 	switch (event) {
 	case REGULATOR_EVENT_UNDER_VOLTAGE:
 		reason = "System critical regulator: voltage drop detected";
+		pscr = PSCR_UNDER_VOLTAGE;
 		break;
 	case REGULATOR_EVENT_OVER_CURRENT:
 		reason = "System critical regulator: over-current detected";
+		pscr = PSCR_OVER_CURRENT;
 		break;
 	case REGULATOR_EVENT_FAIL:
 		reason = "System critical regulator: unknown error";
+		pscr = PSCR_REGULATOR_FAILURE;
 	}
 
 	if (!reason)
 		return;
 
+	set_power_state_change_reason(pscr);
 	hw_protection_shutdown(reason,
 			       rdev->constraints->uv_less_critical_window_ms);
 }
-- 
2.39.2


