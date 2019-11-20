Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B71103C0E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfKTNkE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 08:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfKTNkE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:04 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30612251E;
        Wed, 20 Nov 2019 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257204;
        bh=NbjKcDj6HcwRNfUTgYj1amPDpxxy27dz4hvCv6UCJEg=;
        h=From:To:Cc:Subject:Date:From;
        b=e72+Y0wjRQTNy0OpHFoACzCsx4eYs68hgZKxaVVfTNRY7rntmTvnYSdGLj7fGHxUQ
         s0ZJBi4hoOcCVbEuYYygfHcs94n4kvJCDZAjZiiQIjLnP5PQdyo2BZ+XyRZP3OLfnU
         ScqkXAFDywUCyIGvDAMrEv3KjvOD+XhDqanxwZ4M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:59 +0800
Message-Id: <20191120133959.14109-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 27164a1d3c7c..9a5591ab90d0 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -73,10 +73,10 @@ config WM831X_POWER
 	  provided by Wolfson Microelectronics WM831x PMICs.
 
 config WM8350_POWER
-        tristate "WM8350 PMU support"
-        depends on MFD_WM8350
-        help
-          Say Y here to enable support for the power management unit
+	tristate "WM8350 PMU support"
+	depends on MFD_WM8350
+	help
+	  Say Y here to enable support for the power management unit
 	  provided by the Wolfson Microelectronics WM8350 PMIC.
 
 config TEST_POWER
@@ -209,16 +209,16 @@ config BATTERY_WM97XX
 	  Say Y to enable support for battery measured by WM97xx aux port.
 
 config BATTERY_SBS
-        tristate "SBS Compliant gas gauge"
-        depends on I2C
-        help
+	tristate "SBS Compliant gas gauge"
+	depends on I2C
+	help
 	  Say Y to include support for SBS battery driver for SBS-compliant
 	  gas gauges.
 
 config CHARGER_SBS
-        tristate "SBS Compliant charger"
-        depends on I2C
-        help
+	tristate "SBS Compliant charger"
+	depends on I2C
+	help
 	  Say Y to include support for SBS compliant battery chargers.
 
 config MANAGER_SBS
@@ -484,11 +484,11 @@ config CHARGER_MANAGER
 	depends on REGULATOR
 	select EXTCON
 	help
-          Say Y to enable charger-manager support, which allows multiple
-          chargers attached to a battery and multiple batteries attached to a
-          system. The charger-manager also can monitor charging status in
-          runtime and in suspend-to-RAM by waking up the system periodically
-          with help of suspend_again support.
+	  Say Y to enable charger-manager support, which allows multiple
+	  chargers attached to a battery and multiple batteries attached to a
+	  system. The charger-manager also can monitor charging status in
+	  runtime and in suspend-to-RAM by waking up the system periodically
+	  with help of suspend_again support.
 
 config CHARGER_LT3651
 	tristate "Analog Devices LT3651 charger"
-- 
2.17.1

