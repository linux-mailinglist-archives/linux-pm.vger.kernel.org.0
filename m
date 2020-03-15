Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD34E185DD9
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgCOPOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42269 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCOPOm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so18078850wrm.9;
        Sun, 15 Mar 2020 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XdkapQL+yBOybxGhePAhyn5C5HK16exdBokBiPplJoM=;
        b=gOdMIEdcRD6QOopL0Afs77sac4j9vlxRA9ihE7AHZF/iGfnsBPDNhlm2Imxm/msA80
         kjp8L2k7gIVg4oT5iZkEkIWJPzE5yTtCPYSB3YncdBiAn7qPWUoIpihiLRvd76eXIdiv
         6P2Opotuuw0+hVgPjIUXjN3piSOmWduW/yKG1KR27qX8Enm3MCYHtETWFTufhu8B5n//
         eZQtRxVm2vjUZmH9js9/eqxlbJwRbDfzDUVy7FS6GbNC5PGqKy7oNGDVico4AI/Rltif
         kgrEZPKhP866u94Nw8vMNLh1UIlv3JQgiTF3KjnbB7uEwXH0KZta5mzoZnrcRYxLMoOL
         pPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XdkapQL+yBOybxGhePAhyn5C5HK16exdBokBiPplJoM=;
        b=fSvT0PxI+JGeWI6VpNft06SBpewZJ+3uPwwgx3UWzYrdHbBQO1fFE6kgXsuqyKzdat
         g1aHK3dQfffug6/YsnpVEBbMt79DLsieBr/DyCQwtD3lcuhpt3fLQgaDJTK5xv69Svit
         xveGrwdT4Aksn6smqRkiERD2ZubGsxyC/+BUuWMWNFsuXD2fLjOUgjYpjOC6ieOlM8rP
         5c4qxyxRVZ8Enqu0lS6RX9mstYpx9ZdnAPYE+OEGvcyft8vaNH/e8uWosyaol/89Px1y
         xw6kzpE5KB/A97xp6qipiH7EW4exBygLYbndtvrcqyKX0lUlOq9XqM/KcZRqNA9pikAL
         SQoQ==
X-Gm-Message-State: ANhLgQ3CZV5Ba6eoKxQIo4L1YQcQp0IcUXAr8CGX5/cXLzm0GuF2L5ja
        TvA7zSRrYE3XBcFmaB4WH8I=
X-Google-Smtp-Source: ADFU+vulIJLGWZsnPgFBLWyFsQK9ORzdCgo4lIzw5GzDG5Mc3K5LOM+cWr9z04wXjDiJyPVe22ZFrA==
X-Received: by 2002:a5d:5545:: with SMTP id g5mr13929668wrw.290.1584285280336;
        Sun, 15 Mar 2020 08:14:40 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:39 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 07/15] power: supply: cpcap-battery: Rewrite capacity reporting
Date:   Sun, 15 Mar 2020 18:11:58 +0300
Message-Id: <20200315151206.30909-7-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Return -ENODATA instead of confusing rough values
* Calculate percentage using charge_full value provided

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 669ed1513201..f712a3bda315 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -573,10 +573,10 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 				      union power_supply_propval *val)
 {
 	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
-	struct cpcap_battery_state_data *latest, *previous, *low, *high;
+	struct cpcap_battery_state_data *latest, *previous, *low;
 	u32 sample;
 	s32 accumulator;
-	int cached, delta, est;
+	int cached;
 	s64 tmp;
 
 	cached = cpcap_battery_update_status(ddata);
@@ -654,25 +654,12 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		val->intval = div64_s64(tmp, 100);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		est = cpcap_battery_get_rough_percentage(ddata);
-		high = cpcap_battery_get_highest(ddata);
-		if (high->voltage) {
-			delta = latest->counter_uah - high->counter_uah;
-			val->intval = (ddata->config.info.charge_full_design -
-				       delta) * 100;
-			val->intval /= ddata->config.info.charge_full_design;
-			delta = abs(val->intval - est);
-			break;
-		}
 		low = cpcap_battery_get_lowest(ddata);
-		if (low->voltage) {
-			delta = low->counter_uah - latest->counter_uah;
-			val->intval = (delta * 100) /
-				ddata->config.info.charge_full_design;
-			delta = abs(val->intval - est);
-			break;
-		}
-		val->intval = est;
+		if (!low->voltage || !ddata->charge_full)
+			return -ENODATA;
+		val->intval = (low->counter_uah -
+			       latest->counter_uah) * 100;
+		val->intval /= ddata->charge_full;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		val->intval = cpcap_battery_get_rough_capacity(ddata);
-- 
2.11.0

