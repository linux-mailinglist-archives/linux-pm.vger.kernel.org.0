Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26B179D4E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 02:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgCEB1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 20:27:39 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:12009 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgCEB1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 20:27:39 -0500
X-Halon-ID: 7329fe21-5e80-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 7329fe21-5e80-11ea-aa6d-005056917f90;
        Thu, 05 Mar 2020 02:27:28 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Date:   Thu,  5 Mar 2020 02:27:21 +0100
Message-Id: <20200305012721.425330-1-niklas.soderlund@ragnatech.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Add an entry to make myself a maintainer of the Renesas R-Car thermal
drivers.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e075c..2514551ac932b817 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14205,6 +14205,15 @@ F:	Documentation/devicetree/bindings/i2c/renesas,iic.txt
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
2.25.1

