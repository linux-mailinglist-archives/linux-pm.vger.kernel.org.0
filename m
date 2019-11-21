Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC3104908
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 04:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKUDUA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 22:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfKUDT7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:59 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B5220721;
        Thu, 21 Nov 2019 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306398;
        bh=X0Vkav8AN/Y4ly6J0JOv/ouzlDy9mO5Na/nrav0JajA=;
        h=From:To:Cc:Subject:Date:From;
        b=YM/oP5LlNOO07WQZHM+AY4YXVDFIs7yu3TVPAUKE7NvZeDCzIg2L2ru5OnR1Fcuy2
         49nzzfKgsOFBt99HlG4mA/FqIFpgCa4lEAMY74dwgEllt6KuPSTaQoqBlAbKKA+QGf
         Cr4MmU3+rKAHitF3cIz3cFllJ2ZJgSmDlAYvyO2s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2] power: reset: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:55 +0100
Message-Id: <1574306395-12906-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/power/reset/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c721939767eb..0498363203e8 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -141,14 +141,14 @@ config POWER_RESET_LTC2952
 	  down via the LTC2952. Bindings are made in the device tree.
 
 config POWER_RESET_MT6323
-       bool "MediaTek MT6323 power-off driver"
-       depends on MFD_MT6397
-       help
-         The power-off driver is responsible for externally shutdown down
-         the power of a remote MediaTek SoC MT6323 is connected to through
-         controlling a tiny circuit BBPU inside MT6323 RTC.
-
-         Say Y if you have a board where MT6323 could be found.
+	bool "MediaTek MT6323 power-off driver"
+	depends on MFD_MT6397
+	help
+	  The power-off driver is responsible for externally shutdown down
+	  the power of a remote MediaTek SoC MT6323 is connected to through
+	  controlling a tiny circuit BBPU inside MT6323 RTC.
+
+	  Say Y if you have a board where MT6323 could be found.
 
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
-- 
2.7.4

