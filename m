Return-Path: <linux-pm+bounces-35601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF4BAD196
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE7D1714A9
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD71DE8BB;
	Tue, 30 Sep 2025 13:47:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9F140E34;
	Tue, 30 Sep 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240041; cv=none; b=NazzUnWjOQ5OML9EfbVwho0HE1i37ZY8Au+HiZRHYyR30FbMIA8sLGSArMza0cwUPyCRMkL8rdQYqB7qYLsod4gZNDHMkN85lesiDvzWnSCLO/t0626KAMegmgWcoZTyC1F7I9dAxY7FbG3Nt+M4CA/THNEddrk/qEjOwtVypOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240041; c=relaxed/simple;
	bh=2idP7XfuOlIH30Laum8D98ZYbwM6hN+ME77j6Yv3Py0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3n/lY9SEmszYA5CaNeVBduPwLog1TkYmi95sfdqcusICLMbgftfoUVu9al0B85KqOvYsMrEnx2+z1Zabq5XIzeP+LQKbRKDw1XlHXJOwZ4lXH2E92zZ+h2sf4bYCyGB0dLW1j5l6BABiHbCD3wdYtmpv5Q1JqgGqxqqfDa7acY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C994C4CEF0;
	Tue, 30 Sep 2025 13:47:17 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: renesas: Fix RZ/G3E fall-out
Date: Tue, 30 Sep 2025 15:47:11 +0200
Message-ID: <3f5420c70643d9b35b39d9b336295d589eaf7013.1759239979.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  - Restore sort order in MAINTAINERS and Kconfig,
  - Remove empty trailing line from Makefile.

Fixes: 19d3a401a617c68e ("thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas RZ/G3E SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS                      | 14 +++++++-------
 drivers/thermal/renesas/Kconfig  | 14 +++++++-------
 drivers/thermal/renesas/Makefile |  1 -
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb73b4db917596bd..fc755a50fb150498 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21881,13 +21881,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 F:	drivers/iio/potentiometer/x9250.c
 
-RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
-M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
-L:	linux-pm@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
-F:	drivers/thermal/renesas/rzg3s_thermal.c
-
 RENESAS RZ/G3E THERMAL SENSOR UNIT DRIVER
 M:	John Madieu <john.madieu.xa@bp.renesas.com>
 L:	linux-pm@vger.kernel.org
@@ -21895,6 +21888,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 F:	drivers/thermal/renesas/rzg3e_thermal.c
 
+RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
+M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+F:	drivers/thermal/renesas/rzg3s_thermal.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index c762c1c30d5a211a..5735c8728a31fcb5 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -27,6 +27,13 @@ config RZG2L_THERMAL
 	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
 	  thermal framework.
 
+config RZG3E_THERMAL
+	tristate "Renesas RZ/G3E thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  Enable this to plug the RZ/G3E thermal sensor driver into the Linux
+	  thermal framework.
+
 config RZG3S_THERMAL
 	tristate "Renesas RZ/G3S thermal driver"
 	depends on ARCH_R9A08G045 || COMPILE_TEST
@@ -34,10 +41,3 @@ config RZG3S_THERMAL
 	help
 	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
 	  thermal framework.
-
-config RZG3E_THERMAL
-	tristate "Renesas RZ/G3E thermal driver"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	help
-	  Enable this to plug the RZ/G3E thermal sensor driver into the Linux
-	  thermal framework.
diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
index 0ea59224757226cc..8f5ae9af277cab5e 100644
--- a/drivers/thermal/renesas/Makefile
+++ b/drivers/thermal/renesas/Makefile
@@ -5,4 +5,3 @@ obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
 obj-$(CONFIG_RZG3E_THERMAL)	+= rzg3e_thermal.o
 obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
-
-- 
2.43.0


