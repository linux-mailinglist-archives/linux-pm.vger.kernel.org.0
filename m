Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB325160417
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2020 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBPNEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Feb 2020 08:04:36 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:54232 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbgBPNEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Feb 2020 08:04:36 -0500
X-Halon-ID: d9ace9aa-50bc-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id d9ace9aa-50bc-11ea-aa6d-005056917f90;
        Sun, 16 Feb 2020 14:04:31 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Date:   Sun, 16 Feb 2020 14:02:52 +0100
Message-Id: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add an entry to make myself a maintainer of the Renesas R-Car thermal
drivers.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f290e..713e4fd8efb4f60d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14206,6 +14206,15 @@ F:	Documentation/devicetree/bindings/i2c/renesas,iic.txt
 F:	drivers/i2c/busses/i2c-rcar.c
 F:	drivers/i2c/busses/i2c-sh_mobile.c
 
+RENESAS R-CAR THERMAL DRIVERS
+M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
+F:	Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+F:	drivers/thermal/rcar_gen3_thermal.c
+F:	drivers/thermal/rcar_thermal.c
+
 RENESAS RIIC DRIVER
 M:	Chris Brandt <chris.brandt@renesas.com>
 S:	Supported
-- 
2.25.0

