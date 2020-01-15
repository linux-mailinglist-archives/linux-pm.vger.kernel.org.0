Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A213C1FC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAOMyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 07:54:21 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:45644 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAOMyV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 07:54:21 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id qcuJ2100D5USYZQ01cuJMg; Wed, 15 Jan 2020 13:54:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iriBe-00045p-Lh; Wed, 15 Jan 2020 13:54:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iriBe-0001Ne-JN; Wed, 15 Jan 2020 13:54:18 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: rcar_thermal: Use usleep_range() instead of udelay()
Date:   Wed, 15 Jan 2020 13:54:17 +0100
Message-Id: <20200115125417.5263-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

rcar_thermal_update_temp() takes a mutex, so it is always called in a
context that can sleep.  Hence replace the 300 µs busy loop by a call to
usleep_range(), to allow other threads to run.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index d0873de718da9218..a8dd96d2d24c4ce5 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -219,7 +219,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
 		 * to get stable temperature.
 		 * see "Usage Notes" on datasheet
 		 */
-		udelay(300);
+		usleep_range(300, 400);
 
 		new = rcar_thermal_read(priv, THSSR) & CTEMP;
 		if (new == old) {
-- 
2.17.1

