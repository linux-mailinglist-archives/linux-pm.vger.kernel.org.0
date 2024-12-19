Return-Path: <linux-pm+bounces-19496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB639F75AA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9216871D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564EC21885D;
	Thu, 19 Dec 2024 07:32:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845C2185B9
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593545; cv=none; b=StldxzPyq197ASC3JMi3ZvZoS7hlge9jkjiQ9YiEz01HtxU3Of3/TCu07kwM22BxPhgACu/CfQ91G/5tJzaD2Wb/gKsq9AXme2C+b3bFn8bakpy6grbHLNoIBV8pIKDaYPm6bHYA4H/MvBuZBSSovpcgAsQ/8IEuLx3jIykcILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593545; c=relaxed/simple;
	bh=e2IbsiOoO3EPFUAOqg25iHCtvCfjnHRVHByLTl6MTlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gIfFCkEgBQQFJBcAA/Q5vkQBgjZUh5iAV5HeV22TJKmGFFnFiW2dIyBdgjXSxUigmRuIPrOLqlO/0jUAbeVOjp+wr3xTdwBL8ketQOLuXiuiupJTLYPoi2LWiIoUyibiVTNn4ITBLufvh4AfccKjZk1oQO0aZDbYSvpM/a287+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0O-00088Z-1R; Thu, 19 Dec 2024 08:31:32 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0L-004APu-25;
	Thu, 19 Dec 2024 08:31:30 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0q;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:28 +0100
Subject: [PATCH 07/11] regulator: allow user configuration of hardware
 protection action
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-7-263a0c1df802@pengutronix.de>
References: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
In-Reply-To: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
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

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/regulator/core.c        |  4 ++--
 drivers/regulator/irq_helpers.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8cb948a91e60d958c6b5ec97d736e6e3bf4b47eb..74c8f1262f2cd4e796ba8f4f1bdf17b685a615c1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5137,8 +5137,8 @@ static void regulator_handle_critical(struct regulator_dev *rdev,
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


