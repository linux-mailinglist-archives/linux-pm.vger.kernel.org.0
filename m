Return-Path: <linux-pm+bounces-22248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A40DA38D85
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8486C3B3EF4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE823ED5F;
	Mon, 17 Feb 2025 20:40:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476523CEE7
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824847; cv=none; b=KpYLOnZNncNRmDZkvktuKj9rd/xJay8u4BLHn5R6Fj/nxqh2rQRoeq+yWmLKUXdA1fm4sfqzokF8NYYpJSIiYIYNZWy9bcE1j2egNIQc8JuCuWL3te1ixryjlx7haloM0UaYHd/EIS4YY2lzXfwD5MiDsmOWZKRDm4B1zFKyiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824847; c=relaxed/simple;
	bh=4nLtAYwNhdMmiIGRj/ER05/DtHHQuE84Uw7M/82Zq24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMA4keDTI3e6DgAQKztV2D1CMgwhAszhrlvwsa7AOQMzMT//O6J6HJYxtFfNvu0EyZU9AtOjb6UW1lFk0Kkc0limVAVdaFp4Nev1OmOiG50vMEOE5vN6mP4XxrKBJI+Yzrh2vi8MCiU4wVN0/UzkfkKXj2LgDbBtOc0HhzZFgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uZ-0007oH-CW; Mon, 17 Feb 2025 21:40:15 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-001TG1-2x;
	Mon, 17 Feb 2025 21:40:13 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-000W9t-2V;
	Mon, 17 Feb 2025 21:40:13 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 17 Feb 2025 21:39:48 +0100
Subject: [PATCH v3 08/12] regulator: allow user configuration of hardware
 protection action
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-hw_protection-reboot-v3-8-e1c09b090c0c@pengutronix.de>
References: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
In-Reply-To: <20250217-hw_protection-reboot-v3-0-e1c09b090c0c@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

When the core detects permanent regulator hardware failure or imminent
power failure of a critical supply, it will call hw_protection_shutdown
in an attempt to do a limited orderly shutdown followed by powering off
the system.

This doesn't work out well for many unattended embedded systems that don't
have support for shutdown and that power on automatically when power is
supplied:

  - A brief power cycle gets detected by the driver
  - The kernel powers down the system and SoC goes into shutdown mode
  - Power is restored
  - The system remains oblivious to the restored power
  - System needs to be manually power cycled for a duration long enough
    to drain the capacitors

Allow users to fix this by calling the newly introduced
hw_protection_trigger() instead: This way the hw_protection commandline
or sysfs parameter is used to dictate the policy of dealing with the
regulator fault.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/regulator/core.c        |  4 ++--
 drivers/regulator/irq_helpers.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4ddf0efead682fd006657cdad1dc335f08f1da3e..280559509dcfc7a7f6d0f541ce776512dfe04f73 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5262,8 +5262,8 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
 	if (!reason)
 		return;
 
-	hw_protection_shutdown(reason,
-			       rdev->constraints->uv_less_critical_window_ms);
+	hw_protection_trigger(reason,
+			      rdev->constraints->uv_less_critical_window_ms);
 }
 
 /**
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 0aa188b2bbb26797b7907cbfb581459ef41df286..5742faee8071dd8104c094587d66693f48fb0f9b 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -64,16 +64,16 @@ static void regulator_notifier_isr_work(struct work_struct *work)
 reread:
 	if (d->fatal_cnt && h->retry_cnt > d->fatal_cnt) {
 		if (!d->die)
-			return hw_protection_shutdown("Regulator HW failure? - no IC recovery",
-						      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+			return hw_protection_trigger("Regulator HW failure? - no IC recovery",
+						     REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 		ret = d->die(rid);
 		/*
 		 * If the 'last resort' IC recovery failed we will have
 		 * nothing else left to do...
 		 */
 		if (ret)
-			return hw_protection_shutdown("Regulator HW failure. IC recovery failed",
-						      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+			return hw_protection_trigger("Regulator HW failure. IC recovery failed",
+						     REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 
 		/*
 		 * If h->die() was implemented we assume recovery has been
@@ -263,14 +263,14 @@ static irqreturn_t regulator_notifier_isr(int irq, void *data)
 	if (d->fatal_cnt && h->retry_cnt > d->fatal_cnt) {
 		/* If we have no recovery, just try shut down straight away */
 		if (!d->die) {
-			hw_protection_shutdown("Regulator failure. Retry count exceeded",
-					       REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+			hw_protection_trigger("Regulator failure. Retry count exceeded",
+					      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 		} else {
 			ret = d->die(rid);
 			/* If die() failed shut down as a last attempt to save the HW */
 			if (ret)
-				hw_protection_shutdown("Regulator failure. Recovery failed",
-						       REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+				hw_protection_trigger("Regulator failure. Recovery failed",
+						      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 		}
 	}
 

-- 
2.39.5


