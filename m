Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8228E10E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgJNNOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJNNOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 09:14:18 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0B8C061755
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 06:14:18 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id fpEG2300i4C55Sk01pEGWb; Wed, 14 Oct 2020 15:14:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSgbg-0007vE-I1; Wed, 14 Oct 2020 15:14:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSgbg-0003jg-Fx; Wed, 14 Oct 2020 15:14:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sebastian Reichel <sre@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] power: reset: POWER_RESET_OCELOT_RESET should depend on Ocelot or Sparx5
Date:   Wed, 14 Oct 2020 15:14:15 +0200
Message-Id: <20201014131415.14034-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To add support for Sparx5, the dependency on MSCC_OCELOT was removed.
However, this increases exposure of the driver question not only to
Sparx5 platforms, but to everyone.  Hence re-add the dependency on
MSCC_OCELOT, and extend it with ARCH_SPARX5, to prevent asking the user
about this driver when configuring a kernel without Ocelot and Sparx5
support.

Fixes: ec871696b7776767 ("power: reset: ocelot: Add support for Sparx5")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6361569aacb7eedf..d55b3727e00eb768 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -129,6 +129,7 @@ config POWER_RESET_QCOM_PON
 
 config POWER_RESET_OCELOT_RESET
 	bool "Microsemi Ocelot reset driver"
+	depends on MSCC_OCELOT || ARCH_SPARX5 || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  This driver supports restart for Microsemi Ocelot SoC and similar.
-- 
2.17.1

