Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12E72FD2A7
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbhATO1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 09:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389628AbhATOZD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 09:25:03 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F4C0617A0
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 06:23:40 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id K2PS2400g4C55Sk012PSaA; Wed, 20 Jan 2021 15:23:37 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l2EOL-005BZX-He; Wed, 20 Jan 2021 15:23:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l2EOL-009FIO-3H; Wed, 20 Jan 2021 15:23:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] soc: renesas: rcar-sysc: Mark device node OF_POPULATED after init
Date:   Wed, 20 Jan 2021 15:23:23 +0100
Message-Id: <20210120142323.2203705-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The R-Car System Controller (SYSC) driver registers PM domains from an
early_initcall().  It does not use a platform driver, as secondary CPU
startup on R-Car H1 needs to control the CPU power domains, before
initialization of the driver framework.

As fw_devlink only considers platform devices, it does not know that the
System Controller is ready.  Hence probing of on-chip devices that are
part of the SYSC PM domain fail:

    probe deferral - supplier e6180000.system-controller not ready

Fix this by setting the OF_POPULATED flag for the SYSC device node after
successful initialization.  This will make of_link_to_phandle() ignore
the SYSC device node as a dependency, and consumer devices will be
probed again.

Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 9b235fc900273405..a00bb098e1fe7488 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -439,6 +439,8 @@ static int __init rcar_sysc_pd_init(void)
 	}
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
+	if (!error)
+		of_node_set_flag(np, OF_POPULATED);
 
 out_put:
 	of_node_put(np);
-- 
2.25.1

