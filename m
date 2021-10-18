Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA540431DD5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhJRNzP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 09:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234169AbhJRNxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 09:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634565065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbjaDHTrTLCbvIh14r9ttu+A+qP55yZcf8yXCeCOYQs=;
        b=Y3DzwgDznSBS9Fffoy1gMMb3ALDRqwQabFrvCkLrcSDEp0Mk0k8jiU4V0BmVg76JqJAftv
        o7wY5a33GKOdDvMaHQ1j08X6nGbRdEfabeESbSTuYkRID1VsVdCKdzqw2/AnMWkcN4rJ+L
        1Yg65Sj5+IcbC70bMS1UBg2y6csaYHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-X8dXCel_NsasXEs7kSIpow-1; Mon, 18 Oct 2021 09:51:01 -0400
X-MC-Unique: X8dXCel_NsasXEs7kSIpow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65A1362F8;
        Mon, 18 Oct 2021 13:51:00 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B39708E0;
        Mon, 18 Oct 2021 13:50:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/3] power: supply: axp288-charger: Remove unnecessary is_present and is_online helpers
Date:   Mon, 18 Oct 2021 15:50:52 +0200
Message-Id: <20211018135053.213310-3-hdegoede@redhat.com>
In-Reply-To: <20211018135053.213310-1-hdegoede@redhat.com>
References: <20211018135053.213310-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that axp288_charger_usb_update_property() reads and caches all
relevant registers, the axp288_charger_is_present() and
axp288_charger_is_online() helpers are not necessary anymore.

Directly check the cached input_status instead, allowing the removal
of these 2 helpers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 058e2cd4b4aa..d09c8f36b73a 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -302,24 +302,6 @@ static int axp288_charger_enable_charger(struct axp288_chrg_info *info,
 	return ret;
 }
 
-static int axp288_charger_is_present(struct axp288_chrg_info *info)
-{
-	int present = 0;
-
-	if (info->input_status & PS_STAT_VBUS_PRESENT)
-		present = 1;
-	return present;
-}
-
-static int axp288_charger_is_online(struct axp288_chrg_info *info)
-{
-	int online = 0;
-
-	if (info->input_status & PS_STAT_VBUS_VALID)
-		online = 1;
-	return online;
-}
-
 static int axp288_get_charger_health(struct axp288_chrg_info *info)
 {
 	int health = POWER_SUPPLY_HEALTH_UNKNOWN;
@@ -447,7 +429,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 			val->intval = 0;
 			break;
 		}
-		val->intval = axp288_charger_is_present(info);
+		val->intval = (info->input_status & PS_STAT_VBUS_PRESENT) ? 1 : 0;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		/* Check for OTG case first */
@@ -455,7 +437,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 			val->intval = 0;
 			break;
 		}
-		val->intval = axp288_charger_is_online(info);
+		val->intval = (info->input_status & PS_STAT_VBUS_VALID) ? 1 : 0;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		val->intval = axp288_get_charger_health(info);
-- 
2.31.1

