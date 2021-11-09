Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8652644AE81
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 14:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKINNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 08:13:34 -0500
Received: from comms.puri.sm ([159.203.221.185]:47342 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhKINNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 08:13:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 1B7C1E03CC;
        Tue,  9 Nov 2021 05:10:48 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9rq4FAoVgiPD; Tue,  9 Nov 2021 05:10:47 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/2] media: i2c: hi846: check return value of regulator_bulk_disable()
Date:   Tue,  9 Nov 2021 14:10:12 +0100
Message-Id: <20211109131013.2684058-2-martin.kepplinger@puri.sm>
In-Reply-To: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
References: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

regulator_bulk_disable can fail and thus suspend() can. Handle that error
gracefully.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/media/i2c/hi846.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 4b94bdf2e5cb..ed55c3894284 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1858,7 +1858,7 @@ static int hi846_power_on(struct hi846 *hi846)
 	return ret;
 }
 
-static void hi846_power_off(struct hi846 *hi846)
+static int hi846_power_off(struct hi846 *hi846)
 {
 	if (hi846->rst_gpio)
 		gpiod_set_value_cansleep(hi846->rst_gpio, 1);
@@ -1867,7 +1867,7 @@ static void hi846_power_off(struct hi846 *hi846)
 		gpiod_set_value_cansleep(hi846->shutdown_gpio, 1);
 
 	clk_disable_unprepare(hi846->clock);
-	regulator_bulk_disable(HI846_NUM_SUPPLIES, hi846->supplies);
+	return regulator_bulk_disable(HI846_NUM_SUPPLIES, hi846->supplies);
 }
 
 static int __maybe_unused hi846_suspend(struct device *dev)
@@ -1879,9 +1879,7 @@ static int __maybe_unused hi846_suspend(struct device *dev)
 	if (hi846->streaming)
 		hi846_stop_streaming(hi846);
 
-	hi846_power_off(hi846);
-
-	return 0;
+	return hi846_power_off(hi846);
 }
 
 static int __maybe_unused hi846_resume(struct device *dev)
-- 
2.30.2

