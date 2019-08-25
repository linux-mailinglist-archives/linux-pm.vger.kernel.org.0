Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132B19C4BD
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfHYPlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 11:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfHYPlz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Aug 2019 11:41:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 548875AFE3;
        Sun, 25 Aug 2019 15:41:55 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-48.ams2.redhat.com [10.36.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6038219C70;
        Sun, 25 Aug 2019 15:41:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: axp288_fuel_gauge: Add Minix Neo Z83-4 to the blacklist
Date:   Sun, 25 Aug 2019 17:41:52 +0200
Message-Id: <20190825154152.80087-2-hdegoede@redhat.com>
In-Reply-To: <20190825154152.80087-1-hdegoede@redhat.com>
References: <20190825154152.80087-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 25 Aug 2019 15:41:55 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Minix Neo Z83-4 is another mini PC using the AXP288 PMIC where the
EFI code does not disable the charger part of the PMIC causing us to report
battery readings (of always 100%) to userspace even though there is no
battery in this wall-outlet powered device.

Add it to the blacklist to avoid the bogus battery status reporting.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 6db2e86098e9..e1bc4e6e6f30 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -726,6 +726,13 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
 		},
 	},
+	{
+		/* Minix Neo Z83-4 mini PC */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
+		}
+	},
 	{}
 };
 
-- 
2.23.0

