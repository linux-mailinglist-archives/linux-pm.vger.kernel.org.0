Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19DF47B56B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Dec 2021 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhLTV6o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Dec 2021 16:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhLTV6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Dec 2021 16:58:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F9C061574
        for <linux-pm@vger.kernel.org>; Mon, 20 Dec 2021 13:58:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzQg2-0003Gj-0z; Mon, 20 Dec 2021 22:58:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzQfz-005hf7-9C; Mon, 20 Dec 2021 22:58:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzQfy-0004zP-1q; Mon, 20 Dec 2021 22:58:34 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, alvin@alvinhc.com, kernel@pengutronix.de
Subject: [PATCH] thermal: Kconfig: simplify dependency of THERMAL_HWMON
Date:   Mon, 20 Dec 2021 22:58:28 +0100
Message-Id: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Vx/IjIbdeZBNJrAQ/iFk1muIDdJf2G9zBzfzBp9xIWo=; m=52Y3EctR1Aqc9yZIcWlFsG0AZz6g53mPo8Cw5h//DPs=; p=xwTY5+HecNg9IcnTbDUnqJcjyDfZBJWnWKq7+h5T26s=; g=7e1ea4e72c6fbddf819070f0bb86a03c1556a175
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHA/IAACgkQwfwUeK3K7Ak8/Af9GTh 6OQQd3szG9dVUvcGBkjlNhOyYX2QCRy5/EKFx5Xmrk3wcOM8N+NS6MPCQynIRuvdh3TyC2xsFT3VW ta0T2eqSk6uDAwTIWPguFtycnU+IM/YmopNL0JAYG2XuTiqx4yYM4VLEP2btBb0ZeViPeThWjAbs6 V7QCcGEpeJtPiUH2+DSFyWL8819KJwMEM6wDBwr+cjxQnkRCQvwekEHiMmLWEFrVWTCggUDAAie7f 4tGF/yTfRJWKtLtIIcAyIw6s6OIReYtg0e/G6pXDSoH9xOoBgVzFkmSbyqPHSRAlUGVAzHTpNCeBx fZINRWP+BVydLlvynQRRQdnCc4YKJXg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

THERMAL is bool (since commit 554b3529fe01 ("thermal/drivers/core:
Remove the module Kconfig's option") in v5.2-rc1) and so cannot be
configured as a module. As THERMAL_HWMON also depends on THERMAL (via a
big if block in drivers/thermal/Kconfig) the condition

	depends on HWMON=y || HWMON=THERMAL

is equivalent to the simpler

	depends on HWMON=y

. Use the latter.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I want to use this patch as an opportunity to question if THERMAL being
a bool and not a tristate is still considered the right thing to do.

This dependency attracted attention in the context of the armel Debian
kernel which has HWMON=m for binary size reason. When THERMAL was
changed to bool this resulted in THERMAL_HWMON not being available any
more.

Best regards
Uwe

 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..726bf396c8a9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -52,7 +52,7 @@ config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 config THERMAL_HWMON
 	bool
 	prompt "Expose thermal sensors as hwmon device"
-	depends on HWMON=y || HWMON=THERMAL
+	depends on HWMON
 	default y
 	help
 	  In case a sensor is registered with the thermal
-- 
2.33.0

