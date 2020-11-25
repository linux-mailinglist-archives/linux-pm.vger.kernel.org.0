Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE572C383F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 05:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgKYEqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 23:46:21 -0500
Received: from comms.puri.sm ([159.203.221.185]:48066 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgKYEqV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 23:46:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 37F43E0399;
        Tue, 24 Nov 2020 20:46:21 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t2ineu87QF7d; Tue, 24 Nov 2020 20:46:20 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 2/4] power: max17042_battery: Improve accuracy of current_now and current_avg readings
Date:   Wed, 25 Nov 2020 05:46:17 +0100
Message-ID: <4526762.6nKOPmpm47@pliszka>
In-Reply-To: <2264396.HPVdm0XNkV@pliszka>
References: <2264396.HPVdm0XNkV@pliszka>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dividing 1562500 by r_sns value usually doesn't result in an integer.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 2e9672fe4df1..86adccb0f32d 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -395,8 +395,8 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			val->intval = sign_extend32(data, 15);
-			val->intval *= 1562500 / chip->pdata->r_sns;
+			data64 = sign_extend64(data, 15) * 1562500ll;
+			val->intval = div_s64(data64, chip->pdata->r_sns);
 		} else {
 			return -EINVAL;
 		}
@@ -407,8 +407,8 @@ static int max17042_get_property(struct power_supply *psy,
 			if (ret < 0)
 				return ret;
 
-			val->intval = sign_extend32(data, 15);
-			val->intval *= 1562500 / chip->pdata->r_sns;
+			data64 = sign_extend64(data, 15) * 1562500ll;
+			val->intval = div_s64(data64, chip->pdata->r_sns);
 		} else {
 			return -EINVAL;
 		}
-- 
2.29.2



