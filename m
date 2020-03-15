Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE43E185DE8
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgCOPOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 11:14:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50947 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgCOPOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 11:14:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id a5so14921907wmb.0;
        Sun, 15 Mar 2020 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTmBMMe4KbD8WN5NJMbIUdKcNvEYuvy6jdxWIP8QH9U=;
        b=XV1kVB5ILnqZP9cflLPsvoZwjvOlv383myLoyryJCL7zMMDuIRYJmlNKt1j61jWb+F
         VljtuQaxFvUmC704l8r8QB84O25OScRUuhLNu6U5yyQo3k2oXubwkzjFgtPYjPtrDZxN
         +w6zf+1ea8BmbwUsID9Uz3Lh73+OVd7agesR9viTS5qnknIC37y8H40/ez0PQ+aFpB6O
         3XH9X5L6KVMhIvnx00WaW00E2o2IGSvm+UZhYY2RKcmH/NuL0qEt61MGbdb21JuTMKOY
         jxUlYx5ktSDy9/bRByoBwIc6Pfv8458EGCkGIE1IDVo4enaRonGcYGv67fEh6+JwJ8xo
         PxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KTmBMMe4KbD8WN5NJMbIUdKcNvEYuvy6jdxWIP8QH9U=;
        b=epxZ4CRQFSVd+j2tjDrhrvLZy/o+hoAr5Ze0pYRu6CAQtb6TBNPHZkFvBOfxZlbVt3
         gC/CYAfPNHHffzdPLuyRy4wwBdi73RMJTUIC9r72EmpEn4fwhQCBYeDlJ7lSEDpVtg2S
         Ihp8iq1nbSm0iMVw4EAtLg0Snrfg9G5Qk8uSzofPzZH/rGZCC2E0BEeQb66AsefcTeum
         P68dNKb2tMB5xOF65D+qnk5o2PBY3vE7aicPfxT4wRqUTE8pcaxE47iw29TYqrSfk2HG
         0Egij269EYRG27xWTdcDYhoduETekIiHkpOddzMyzdsdD39spW9/Ud9kqSi63iVEosek
         49ew==
X-Gm-Message-State: ANhLgQ3MrRCl5rAI5UM7f4KIphfUAmDj6jBv0atOdw6vvOXyuu92Tems
        /J/hPEYtz4CXHGPX1oQ51v8=
X-Google-Smtp-Source: ADFU+vtlldQZUUaRXlo4mMqCnDaHgDok7CohEmMvGdHPuEc33x2Q5LarXEZk6egs47ZwUH+winnFkg==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr8231655wmd.16.1584285288830;
        Sun, 15 Mar 2020 08:14:48 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id i67sm67746869wri.50.2020.03.15.08.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 08:14:48 -0700 (PDT)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH 14/15] power: supply: cpcap-battery: Make it behave like bq27200
Date:   Sun, 15 Mar 2020 18:12:05 +0300
Message-Id: <20200315151206.30909-14-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200315151206.30909-1-spinal.by@gmail.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now we begin to update the charge_now value immediately after connecting
or disconnecting the charger. No more hidden mAh buffer when the battery
is fully charged or discharged.

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 44 +++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 938117638983..4e872bd36ccf 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -468,35 +468,27 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 
 	if (cpcap_battery_full(ddata)) {
 		full = cpcap_battery_get_full(ddata);
-		/* Update full state value? */
-		if (!full->voltage) {
-			memcpy(full, latest, sizeof(*full));
-
-			empty = cpcap_battery_get_empty(ddata);
-			if (empty->voltage) {
-				ddata->charge_full =
-					empty->counter_uah - full->counter_uah;
-				empty->voltage = -1;
-			} else if (ddata->charge_full) {
-				/* Initialize with user provided data */
-				empty->counter_uah =
-					full->counter_uah + ddata->charge_full;
-				/* Mark it as initialized */
-				empty->voltage = -1;
-			}
+		memcpy(full, latest, sizeof(*full));
+
+		empty = cpcap_battery_get_empty(ddata);
+		if (empty->voltage && empty->voltage != -1) {
+			empty->voltage = -1;
+			ddata->charge_full =
+				empty->counter_uah - full->counter_uah;
+		} else if (ddata->charge_full) {
+			empty->voltage = -1;
+			empty->counter_uah =
+				full->counter_uah + ddata->charge_full;
 		}
 	} else if (cpcap_battery_low(ddata)) {
 		empty = cpcap_battery_get_empty(ddata);
-		/* Update empty state value? */
-		if (!empty->voltage || empty->voltage == -1) {
-			memcpy(empty, latest, sizeof(*empty));
-
-			full = cpcap_battery_get_full(ddata);
-			if (full->voltage) {
-				ddata->charge_full =
-					empty->counter_uah - full->counter_uah;
-				full->voltage = 0;
-			}
+		memcpy(empty, latest, sizeof(*empty));
+
+		full = cpcap_battery_get_full(ddata);
+		if (full->voltage) {
+			full->voltage = 0;
+			ddata->charge_full =
+				empty->counter_uah - full->counter_uah;
 		}
 	}
 
-- 
2.11.0

