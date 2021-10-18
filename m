Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2A431DD3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhJRNzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 09:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234138AbhJRNxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 09:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634565064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWw0K7RgUOjSJJ1WfQxi7QXCSVGoMY40WVLfY8ZdmWQ=;
        b=jD1JyF1MrCoStwDtA7TQ3yW2zQXEvQAtXKBG1aBck/IFpZRpu77xT5+LXPtIy51+ZHZhsj
        nfw1LFxPyBYlzzqIUPskoFX/LCdA+3hK4NHHyYalEhOGDz39SUxRjMX4DAeuBlbs3EG7Wt
        tQLWcFjPpBSTlycfBNLoR9SZH9kNpBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-rINODGhkMpCUDQLBS95_ZA-1; Mon, 18 Oct 2021 09:51:03 -0400
X-MC-Unique: rINODGhkMpCUDQLBS95_ZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4397D1006AA4;
        Mon, 18 Oct 2021 13:51:02 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 229A422719;
        Mon, 18 Oct 2021 13:51:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/3] power: supply: axp288-charger: Simplify axp288_get_charger_health()
Date:   Mon, 18 Oct 2021 15:50:53 +0200
Message-Id: <20211018135053.213310-4-hdegoede@redhat.com>
In-Reply-To: <20211018135053.213310-1-hdegoede@redhat.com>
References: <20211018135053.213310-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that axp288_charger_usb_update_property() reads and caches all
relevant registers, axp288_get_charger_health() can be simplified
by directly returning the health.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index d09c8f36b73a..ed058b598223 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -304,22 +304,17 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 
 static int axp288_get_charger_health(struct axp288_chrg_info *info)
 {
-	int health = POWER_SUPPLY_HEALTH_UNKNOWN;
-
 	if (!(info->input_status & PS_STAT_VBUS_PRESENT))
-		goto health_read_fail;
+		return POWER_SUPPLY_HEALTH_UNKNOWN;
 
 	if (!(info->input_status & PS_STAT_VBUS_VALID))
-		health = POWER_SUPPLY_HEALTH_DEAD;
+		return POWER_SUPPLY_HEALTH_DEAD;
 	else if (info->op_mode & CHRG_STAT_PMIC_OTP)
-		health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		return POWER_SUPPLY_HEALTH_OVERHEAT;
 	else if (info->op_mode & CHRG_STAT_BAT_SAFE_MODE)
-		health = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
 	else
-		health = POWER_SUPPLY_HEALTH_GOOD;
-
-health_read_fail:
-	return health;
+		return POWER_SUPPLY_HEALTH_GOOD;
 }
 
 static int axp288_charger_usb_set_property(struct power_supply *psy,
-- 
2.31.1

