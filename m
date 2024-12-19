Return-Path: <linux-pm+bounces-19498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07E9F7645
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87601890AE8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D02218E99;
	Thu, 19 Dec 2024 07:50:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EE218E8F
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594642; cv=none; b=Q62ecdzKa/eleCHVbkqsfjJ0mp5heQOdPIy+tFRuECwjQhmXKUs8f35mJHtjJwMyZCWT6wh9B1KQ3bJ0EmUR2lA+V+p+dHjX5VglaV8yF78phIQOex8cFrsMXJD++BAshDi78YIG8NN+CbmnzW19ZNp1XJQeHgfsTR6w+A02umA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594642; c=relaxed/simple;
	bh=Dwk6bXNu5eZTvBfMa7fJbM+NhBSxfOByQaqOb5V8mPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XExNRfiezIeDvk2w2fz4cdW+7IItZ7FoEOT2LOjwJj7fWFVfUdL/vXgA9FVrdp7AHxPPVfADXrMW/ZySxwYlLo3GU3xDJaxCvTsmEziOehbtWa55vwuZqWoNhvXhSF+i9B18VWELV7DGBcH/DQXAhSnjSHhX5Gk+KeDqfIrF9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBId-0003kT-Pr; Thu, 19 Dec 2024 08:50:23 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOBIc-004AWh-0Q;
	Thu, 19 Dec 2024 08:50:22 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tOB0M-00GkbH-0u;
	Thu, 19 Dec 2024 08:31:30 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 19 Dec 2024 08:31:32 +0100
Subject: [PATCH 11/11] reboot: retire hw_protection_reboot and
 hw_protection_shutdown helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-hw_protection-reboot-v1-11-263a0c1df802@pengutronix.de>
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

The hw_protection_reboot and hw_protection_shutdown functions mix
mechanism with policy: They let the driver requesting an emergency
action for hardware protection also decide how to deal with it.

This is inadequate in the general case as a driver reporting e.g. an
imminent power failure can't know whether a shutdown or a reboot would
be more appropriate for a given hardware platform.

With the addition of the hw_protection parameter, it's now possible to
configure at runtime the default emergency action and drivers are
expected to use hw_protection_trigger to have this parameter dictate
policy.

As no current users of either hw_protection_shutdown or
hw_protection_shutdown helpers remain, remove them, as not to tempt
driver authors to call them.

Existing users now either defer to hw_protection_trigger or call
__hw_protection_trigger with a suitable argument directly when
they have inside knowledge on whether a reboot or shutdown would
be more appropriate.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 281696f509932e444eadd453fb0233aa7a07fbce..5c709463a7f85189e169bbaeb8bb7b115b20c996 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -200,16 +200,6 @@ static inline void hw_protection_trigger(const char *reason, int ms_until_forced
 	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_DEFAULT);
 }
 
-static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
-{
-	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_REBOOT);
-}
-
-static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
-{
-	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_SHUTDOWN);
-}
-
 /*
  * Emergency restart, callable from an interrupt handler.
  */

-- 
2.39.5


