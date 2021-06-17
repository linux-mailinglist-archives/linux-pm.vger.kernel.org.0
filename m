Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1146A3ABCAF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFQT3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 15:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhFQT3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 15:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623958030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQmh7ZMRcTa4U3fkTEEvT4cBfYjelBxHLSz3icfQLpg=;
        b=WjLDVLa2GHijtvARJhfYDebmQMmCqQJRfRFnbukxuA5i1NkaWW5qcdzDlqOCN+OVRZ/r9g
        E3PSF2WIeAGzjC6ciXBn9CL8zE+cmGDLgB8+zDLMWQ++a4fpZ+fJ/7jFhUXoUqaT/yN80J
        BiuttaDHJZyt37q6BsShQyrclhBdn9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-3ZCYEkWYNP2wC-KYm08ZGQ-1; Thu, 17 Jun 2021 15:27:06 -0400
X-MC-Unique: 3ZCYEkWYNP2wC-KYm08ZGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93517EC1A3;
        Thu, 17 Jun 2021 19:27:05 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-79.ams2.redhat.com [10.36.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA39560864;
        Thu, 17 Jun 2021 19:27:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: axp288_fuel_gauge: Make "T3 MRD" no_battery_list DMI entry more generic
Date:   Thu, 17 Jun 2021 21:27:02 +0200
Message-Id: <20210617192702.77106-2-hdegoede@redhat.com>
In-Reply-To: <20210617192702.77106-1-hdegoede@redhat.com>
References: <20210617192702.77106-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It turns out that the "T3 MRD" DMI_BOARD_NAME value is used in a lot of
different Cherry Trail x5-z8300 / x5-z8350 based Mini-PC / HDMI-stick
models from Ace PC / Meegopad / MinisForum / Wintel (and likely also
other vendors).

Most of the other DMI strings on these boxes unfortunately contain various
generic values like "Default string" or "$(DEFAULT_STRING)", so we cannot
match on them. These devices do have their chassis-type correctly set to a
value of "3" (desktop) which is a pleasant surprise, so also match on that.

This should avoid the quirk accidentally also getting applied to laptops /
tablets (which do actually have a battery). Although in my quite large
database of Bay and Cherry Trail based devices DMIdecode dumps I don't
have any laptops / tables with a board-name of "T3 MRD", so this should
not be an issue.

BugLink: https://askubuntu.com/questions/1206714/how-can-a-mini-pc-be-stopped-from-being-detected-as-a-laptop-with-a-battery/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index b74c4acba25d..a9c28a725818 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -723,15 +723,6 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MEEGOPAD T02"),
 		},
 	},
-	{
-		/* Meegopad T08 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "To be filled by OEM."),
-			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
-			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
-		},
-	},
 	{	/* Mele PCG03 Mini PC */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
@@ -745,6 +736,15 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
 		}
 	},
+	{
+		/* Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "5.11"),
+		},
+	},
 	{}
 };
 
-- 
2.31.1

