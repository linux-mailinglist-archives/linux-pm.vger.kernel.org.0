Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B43307178
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 09:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhA1I35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 03:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhA1I3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 03:29:43 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC52BC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 00:28:57 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id N8Up2400H4C55Sk068UpAC; Thu, 28 Jan 2021 09:28:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52fY-001JNE-RG; Thu, 28 Jan 2021 09:28:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52fY-009Fsb-6J; Thu, 28 Jan 2021 09:28:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] soc: renesas: rcar-sysc: Mark device node OF_POPULATED after init
Date:   Thu, 28 Jan 2021 09:28:47 +0100
Message-Id: <20210128082847.2205950-1-geert+renesas@glider.be>
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

As fw_devlink only considers devices, it does not know that the System
Controller is ready.  Hence probing of on-chip devices that are part of
the SYSC PM domain fails if fw_devlink is enabled:

    probe deferral - supplier e6180000.system-controller not ready

Fix this by setting the OF_POPULATED flag for the SYSC device node after
successful initialization.  This will make of_link_to_phandle() ignore
the SYSC device node as a dependency, and consumer devices will be
probed again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Saravana Kannan <saravanak@google.com>
---
As this seems to be harmless if commit e590474768f1cc04 ("driver core:
Set fw_devlink=on by default") won't make v5.12, I plan to queue this in
renesas-devel for v5.12.

v2:
  - Add Reviewed-by,
  - s/platform devices/devices/,
  - Drop Fixes tag,
  - Drop RFC.
---
 drivers/soc/renesas/rcar-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index d51ddc7d5232b9db..53387a72ca00ce79 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -434,6 +434,8 @@ static int __init rcar_sysc_pd_init(void)
 	}
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
+	if (!error)
+		of_node_set_flag(np, OF_POPULATED);
 
 out_put:
 	of_node_put(np);
-- 
2.25.1

