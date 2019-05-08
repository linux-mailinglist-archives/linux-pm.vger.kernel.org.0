Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23D71766F
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfEHLI5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 07:08:57 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49692 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfEHLI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 07:08:57 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E78DA25AF6B;
        Wed,  8 May 2019 21:08:54 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id E49929403E0; Wed,  8 May 2019 13:08:52 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2] thermal: rcar_thermal: update calculation formula for R-Car Gen3 SoCs
Date:   Wed,  8 May 2019 13:08:45 +0200
Message-Id: <20190508110845.13043-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Update calculation for the R-Car Gen3 and RZ/G2 SoCs which have a
thermal IP block controlled by this driver. That is the:

* R-Car D3 (r8a77995)
* R-Car E2 (r8a77990)
* R-Car V3M (r8a77970)
* RZ/G2E (r8a774c0)

The calculation update is as documented in the R-Car Gen3 User's Manual,
v1.50 Nov 2018:

- When CTEMP is less than 24
   T = CTEMP[5:0] * 5.5 - 72
- When CTEMP is equal to/greater than 24
   T = CTEMP[5:0] * 5 - 60

This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2 [Simon Horman]
* Enhance changelog to mention all affected SoCs
* Update whitespace
---
 drivers/thermal/rcar_thermal.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 97462e9b40d8..d0873de718da 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -52,6 +52,7 @@ struct rcar_thermal_chip {
 	unsigned int irq_per_ch : 1;
 	unsigned int needs_suspend_resume : 1;
 	unsigned int nirqs;
+	unsigned int ctemp_bands;
 };
 
 static const struct rcar_thermal_chip rcar_thermal = {
@@ -60,6 +61,7 @@ static const struct rcar_thermal_chip rcar_thermal = {
 	.irq_per_ch = 0,
 	.needs_suspend_resume = 0,
 	.nirqs = 1,
+	.ctemp_bands = 1,
 };
 
 static const struct rcar_thermal_chip rcar_gen2_thermal = {
@@ -68,6 +70,7 @@ static const struct rcar_thermal_chip rcar_gen2_thermal = {
 	.irq_per_ch = 0,
 	.needs_suspend_resume = 0,
 	.nirqs = 1,
+	.ctemp_bands = 1,
 };
 
 static const struct rcar_thermal_chip rcar_gen3_thermal = {
@@ -80,6 +83,7 @@ static const struct rcar_thermal_chip rcar_gen3_thermal = {
 	 * interrupts to detect a temperature change, rise or fall.
 	 */
 	.nirqs = 2,
+	.ctemp_bands = 2,
 };
 
 struct rcar_thermal_priv {
@@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 		return ret;
 
 	mutex_lock(&priv->lock);
-	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
+	if (priv->chip->ctemp_bands == 1)
+		tmp = MCELSIUS((priv->ctemp * 5) - 65);
+	else if (priv->ctemp < 24)
+		tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
+	else
+		tmp = MCELSIUS((priv->ctemp * 5) - 60);
 	mutex_unlock(&priv->lock);
 
 	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
-- 
2.11.0

