Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D6185DD7
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgCOPOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgCOPOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id r15so18080809wrx.6;
        Sun, 15 Mar 2020 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x/WyZRIq4+b0pwp83cJG0lNJFv0mIkL8qj75+kmAOTc=;
        b=ZrLPgwFdNJd74irDBRduDCjvW25Jx0CnkV13zS6Uk4duWuv6UQkoTaekN48Gb23eaN
         rdkYnZPjmhAy12nihMVKDFfifyQNpVtpaRz5OoQ0uC8a4EyjVO6e8+xARSo+vXr9TuuV
         W2vg6KqnfVzfYIvlb8d0rk+4ddChgJyel6L7p4w9tMdbdGkCsB8as7NMpD9l6StxMp5v
         8Ngw2csKd38dtIuYa5urnuyJCUA3eSe+DMP74jjg/TrFswOGB7OANjz7X0NvsS3bY15G
         OMq4L2e/SgRiGBEszha9qjHfVTbg7BE7OcLvxMLY5ba08pBrgvRwYVbrU8tJQ7iN5ZuR
         V7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/WyZRIq4+b0pwp83cJG0lNJFv0mIkL8qj75+kmAOTc=;
        b=EBiVwf7mAwxFEenCuvnJd7nVDawou1ZDUVEpUx+IvUQ6GFWjGtHTZs42dQscaeDAUH
         iXe2BPFOGXNXxMOBuubSEFjghJ33DGooT8ck6JM3rKwZFjkwQiagNNOWaseZfVMr8lxA
         F34FM6FG501xbGcQVEfQgtePsRvj0/sYt02tv0nVBOEYz9G8w2trdsI2re4NZWma918w
         wPrxYTp2epPWBW9iF2UT8pHEVHtRnjw94Glu5KlDBCVLMfG8W+nb/O90qwy7U6mXy3Db
         H31VexZmCpoC0FY8s8PRLx98IjxNx+h6UaHmmcwmK3l5DkaddMxa1OrJ+FRcLVL2vEiD
         HL7A==
X-Gm-Message-State: ANhLgQ3mYiQaBJl9x74ZPCs4Uq65s0tuzfH978nhfBwezawkBwHmklxZ
        6wwV94ovG40hr2lUzsSS2AE=
X-Google-Smtp-Source: ADFU+vs09v3JkFbt/v5CIkmn8NyAUmTurKgd6Hng8MJhCWT8/36Ri8LORDMIRYKi0VwSS+egNFO0KQ==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr6684953wrq.58.1584285279192;
        Sun, 15 Mar 2020 08:14:39 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:38 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 06/15] power: supply: cpcap-battery: Initialize with user provided data
Date:   Sun, 15 Mar 2020 18:11:57 +0300
Message-Id: <20200315151206.30909-6-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the user provides us with charge_full value (which it could save in a
permanent storage between reboots), initialize low and high counter_uah
with calculated values.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 39 +++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index db1b519e87c6..669ed1513201 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -434,7 +434,7 @@ static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
 
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 {
-	struct cpcap_battery_state_data state, *latest, *previous, *tmp;
+	struct cpcap_battery_state_data state, *latest, *previous, *low, *high;
 	ktime_t now;
 	int error;
 
@@ -464,15 +464,40 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	memcpy(latest, &state, sizeof(*latest));
 
 	if (cpcap_battery_full(ddata)) {
-		tmp = cpcap_battery_get_highest(ddata);
+		high = cpcap_battery_get_highest(ddata);
 		/* Update highest charge seen? */
-		if (latest->counter_uah <= tmp->counter_uah)
-			memcpy(tmp, latest, sizeof(*tmp));
+		if (latest->counter_uah <= high->counter_uah ||
+		    !high->voltage) {
+			memcpy(high, latest, sizeof(*high));
+
+			low = cpcap_battery_get_lowest(ddata);
+			if (low->voltage && low->voltage != -1)
+				ddata->charge_full =
+					low->counter_uah - high->counter_uah;
+			else if (ddata->charge_full) {
+				/* Initialize with user provided data */
+				low->counter_uah =
+					high->counter_uah + ddata->charge_full;
+				/* Mark it as initialized */
+				low->voltage = -1;
+			}
+		}
 	} else if (cpcap_battery_low(ddata)) {
-		tmp = cpcap_battery_get_lowest(ddata);
+		low = cpcap_battery_get_lowest(ddata);
 		/* Update lowest charge seen? */
-		if (latest->counter_uah >= tmp->counter_uah)
-			memcpy(tmp, latest, sizeof(*tmp));
+		if (latest->counter_uah >= low->counter_uah ||
+		    !low->voltage) {
+			memcpy(low, latest, sizeof(*low));
+
+			high = cpcap_battery_get_highest(ddata);
+			if (high->voltage)
+				ddata->charge_full =
+					low->counter_uah - high->counter_uah;
+			else if (ddata->charge_full)
+				/* Initialize with user provided data */
+				high->counter_uah =
+					low->counter_uah - ddata->charge_full;
+		}
 	}
 
 	return 0;
-- 
2.11.0

