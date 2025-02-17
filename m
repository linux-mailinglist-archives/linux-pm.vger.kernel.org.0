Return-Path: <linux-pm+bounces-22260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ECDA38DBA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B86173030
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EF923AE7E;
	Mon, 17 Feb 2025 20:56:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70423C376
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825777; cv=none; b=iFGMztylRnIKZDgp2etUuu/1/GYR7kEYVW263UvJLBOY2Lbm2zvWWo+8jGbxki3fCXxvtG6kx1/i2c+Q5tQ7tIUuc64RmiPEdH2DuVg+NlYf85wV0kjRKfS8kBrSmi+QkdMxXFWbIXUujhM0q3irfPdu8zDFU6Bao+m24MZhZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825777; c=relaxed/simple;
	bh=7xlQqT6SyHmrrrZ7lcI+lzDoY6cGIt6c6FPPGn5CXb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnOWrSF8buA/vXlQVJ+oblBoiMAUkbiwQJGwkbmDQrCI+t1SBFfb2r14AjZc+totj+DjKmWzuizigWSJgnUE13sS9u7P7P36oDl0F8HMW3ZcaQMYHJ+3ePEaqFz31/N1cs+jQOZHbmRzx3wiAIp2HMOX2GuOdablCt57JHHs7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk89U-00028h-TM; Mon, 17 Feb 2025 21:55:40 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk89S-001THa-1I;
	Mon, 17 Feb 2025 21:55:38 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tk7uX-000W9t-2Z;
	Mon, 17 Feb 2025 21:40:13 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 17 Feb 2025 21:39:52 +0100
Subject: [PATCH v3 12/12] reboot: retire hw_protection_reboot and
 hw_protection_shutdown helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-hw_protection-reboot-v3-12-e1c09b090c0c@pengutronix.de>
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

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 include/linux/reboot.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 79e02876f2ba2b5508f6f26567cbcd5cbe97a277..aa08c3bbbf59a9dec65d775d280902b1455427c2 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -211,16 +211,6 @@ static inline void hw_protection_trigger(const char *reason, int ms_until_forced
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


