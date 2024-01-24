Return-Path: <linux-pm+bounces-2682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B683A990
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 13:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D9B1F27E9F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B665198;
	Wed, 24 Jan 2024 12:22:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572D634F6
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098950; cv=none; b=XDgA5m50PM0zoe1gpbzRwr3RxodXsWWGr3j/DBOCBmUIzn3TNZY9gO/iiWGCFrW5lTAvKn8WL3IfGI4/K2MVkiVinyLt3A2afUz137gacy7EUO0jrshs+QZiQ6p91u2QP0xNLeak2h8HlA+I1Jl1Am2bekVVOCOrEVEFVYaemq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098950; c=relaxed/simple;
	bh=HDAeY4bWfoe9Y+7OHDYHhF+4G8dpj+H9p3pWeswLx5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P110x6owebO3FguGtxMXp0U1cMXu3bnooUXypEyW/suttZ7NdW+9xd71ovkQbyQlu11QHGEWLYGsHtmlyiqU46Ujeop9A7MfBE1rjn0tVIE8sEM1ygHuLjUCcG3SJpP8WFke9xnoj6f/PPEyjrYVIiPKzE9BBFtdWBqEXxGdgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGd-0007oC-1C; Wed, 24 Jan 2024 13:22:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-0023Zn-46; Wed, 24 Jan 2024 13:22:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-003424-03;
	Wed, 24 Jan 2024 13:22:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v2 8/8] thermal: core: Record PSCR before hw_protection_shutdown()
Date: Wed, 24 Jan 2024 13:22:04 +0100
Message-Id: <20240124122204.730370-9-o.rempel@pengutronix.de>
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
index dfaa6341694a..0511d82351c5 100644
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
@@ -329,6 +330,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 
 	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
 
+	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
+
 	if (shutdown)
 		hw_protection_shutdown(msg, poweroff_delay_ms);
 	else
-- 
2.39.2


