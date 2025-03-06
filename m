Return-Path: <linux-pm+bounces-23549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFAA54696
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8767A4296
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331CC20B218;
	Thu,  6 Mar 2025 09:39:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DA209F50
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253961; cv=none; b=iYUBHikTrvIpwYNZamdY0Q/4VZ6cflqGFJAZJwxW/GuFVWmcRhfSguU9bv7y7QfOODHFACy+w+B0SyfU5Nmj4CQfUJ8QrAdLZ8NioS7mBTHyfbs2oxokOygVw0FHvcy+lmLikAIgN92VQVvzZklIVCXODyrlHsguKxVQN9rnD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253961; c=relaxed/simple;
	bh=X22BauJ/yxhjyd9bdHmx73unUwfLqnlpQZoxOrJ9bLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTxZIky+K9lCrGB/Xf2c4EeLKlSmCjg0m1rpteqlySU3LDZUezwL56Je3on6fxW2I34fZr2X4dMYUuY3eXeBxkWQTJWSmW70anQOV3fpmsi/YKrbqTdFejz2RqBHTazAvZXSTypL3BDU3XUd8lpA8JS0518VIkfWAWWA+nSGPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7h0-0002QS-Iy; Thu, 06 Mar 2025 10:39:02 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7gz-004I9j-2O;
	Thu, 06 Mar 2025 10:39:01 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tq7gz-009ECn-28;
	Thu, 06 Mar 2025 10:39:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v4 7/7] thermal: core: Record PSCR before hw_protection_shutdown()
Date: Thu,  6 Mar 2025 10:38:59 +0100
Message-Id: <20250306093900.2199442-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306093900.2199442-1-o.rempel@pengutronix.de>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
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

Enhance the thermal core to record the Power State Change Reason (PSCR)
prior to invoking hw_protection_shutdown(). This change integrates the
PSCR framework with the thermal subsystem, ensuring that reasons for
power state changes, such as overtemperature events, are stored in a
dedicated non-volatile memory (NVMEM) cell.

This 'black box' recording is crucial for post-mortem analysis, enabling
a deeper understanding of system failures and abrupt shutdowns,
especially in scenarios where PMICs or watchdog timers are incapable of
logging such events.  The recorded data can be utilized during system
recovery routines in the bootloader or early kernel stages of subsequent
boots, significantly enhancing system diagnostics, reliability, and
debugging capabilities.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2328ac0d8561..af4e9cf22bf6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -16,6 +16,7 @@
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
 #include <linux/thermal.h>
+#include <linux/pscrr.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
 #include <linux/of.h>
@@ -380,6 +381,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 
 	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
 
+	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
+
 	if (shutdown)
 		hw_protection_shutdown(msg, poweroff_delay_ms);
 	else
-- 
2.39.5


