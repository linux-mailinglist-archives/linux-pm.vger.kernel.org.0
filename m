Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D76140EA5
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 17:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAQQGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 11:06:12 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:42869 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgAQQGL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 11:06:11 -0500
X-Halon-ID: 46b97440-3943-11ea-a00b-005056917a89
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p54ac5d7b.dip0.t-ipconnect.de [84.172.93.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 46b97440-3943-11ea-a00b-005056917a89;
        Fri, 17 Jan 2020 17:06:10 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 2/2] thermal: rcar_gen3_thermal: Remove temperature bound
Date:   Fri, 17 Jan 2020 17:05:54 +0100
Message-Id: <20200117160554.3812787-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117160554.3812787-1-niklas.soderlund+renesas@ragnatech.se>
References: <20200117160554.3812787-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hardware manual states that the operation of the sensor is not
guaranteed with temperatures above 125°C, not that the readings are
invalid. Remove the bound check and try to deliver temperature readings
even if we are outside the guaranteed operation range.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v2
- s/ragne/range/

* Changes since v1
- Preserve the guaranteed operating range in a comment.
---
 drivers/thermal/rcar_gen3_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 1460cf9d9f1c397b..72877bdc072daaed 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -182,9 +182,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 				tsc->coef.a2);
 	mcelsius = FIXPT_TO_MCELSIUS(val);
 
-	/* Make sure we are inside specifications */
-	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
-		return -EIO;
+	/* Guaranteed operating range is -40C to 125C. */
 
 	/* Round value to device granularity setting */
 	*temp = rcar_gen3_thermal_round(mcelsius);
-- 
2.24.1

