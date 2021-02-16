Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1755B31CAA5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBPMkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 07:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBPMkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 07:40:49 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B83C061756
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 04:40:03 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed60:c5d6:9422:c618:ee58])
        by andre.telenet-ops.be with bizsmtp
        id Vog02400c2PLE0701og0oF; Tue, 16 Feb 2021 13:40:01 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lBze4-007Pal-DB; Tue, 16 Feb 2021 13:40:00 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lBze3-00DLHK-Tg; Tue, 16 Feb 2021 13:39:59 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] soc: renesas: rmobile-sysc: Mark fwnode when PM domain is added
Date:   Tue, 16 Feb 2021 13:39:58 +0100
Message-Id: <20210216123958.3180014-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, there are two drivers binding to the R-Mobile System
Controller (SYSC):
  - The rmobile-sysc driver registers PM domains from a core_initcall(),
    and does not use a platform driver,
  - The optional rmobile-reset driver registers a reset handler, and
    does use a platform driver.

As fw_devlink only considers devices, commit bab2d712eeaf9d60 ("PM:
domains: Mark fwnodes when their powerdomain is added/removed") works
only for PM Domain drivers where the DT node is a real device node, and
not for PM Domain drivers using a hierarchical representation inside a
subnode.  Hence if fw_devlink is enabled, probing of on-chip devices
that are part of the SYSC PM domain is deferred until the optional
rmobile-reset driver has been bound.   If the rmobile-reset driver is
not available, this will never happen, and thus lead to complete system
boot failures.

Fix this by explicitly marking the fwnode initialized.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is v2 of "soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
reset handling".
To be queued in renesas-devel as a fix for v5.12 if v5.12-rc1 will have
fw_devlink enabled.

v2:
  - Call fwnode_dev_initialized() instead of setting OF_POPULATED,
  - Drop reset handling move, as fwnode_dev_initialized() does not
    prevent the rmobile-reset driver from binding against the same
    device.
---
 drivers/soc/renesas/rmobile-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index bf64d052f9245db5..204e6135180b919c 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -342,6 +342,8 @@ static int __init rmobile_init_pm_domains(void)
 			of_node_put(np);
 			break;
 		}
+
+		fwnode_dev_initialized(&np->fwnode, true);
 	}
 
 	put_special_pds();
-- 
2.25.1

