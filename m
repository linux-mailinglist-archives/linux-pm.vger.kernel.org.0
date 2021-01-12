Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A542F2D05
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbhALKhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 05:37:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbhALKhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 05:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610447769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=49K2GmLe3yvvnwSXmavMajBxWRKZVVQN5UTWagMKPGA=;
        b=Ty7NgpzXqyM+T+A8UhP8v0W9qP8gGL9vypozlxR1AJFF+WrEZjHadyBMP4ByuttVNONXRo
        ihXQCFE4XiuDkXVltbHMvpC80h0TKJr+/urew1ETmS5c77RE/I/dOIo2cc5CyIX6/cmlqh
        +5D3oZXrjTAa1DlXlAWm5P6YBKccaIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-2YT48bjSM1yyQgQQyHAfFA-1; Tue, 12 Jan 2021 05:36:08 -0500
X-MC-Unique: 2YT48bjSM1yyQgQQyHAfFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A145801AC2;
        Tue, 12 Jan 2021 10:36:07 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-212.ams2.redhat.com [10.36.115.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D97C360BE5;
        Tue, 12 Jan 2021 10:36:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Rasmus Porsager <rasmus@beat.dk>
Subject: [PATCH] power: supply: axp288_fuel_gauge: Add Mele PCG03 to the deny-list
Date:   Tue, 12 Jan 2021 11:36:05 +0100
Message-Id: <20210112103605.45012-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Mele PCG03 is another mini PC using the AXP288 PMIC where the EFI
code does not disable the charger part of the PMIC causing us to report
a discharging battery with a random battery charge to userspace.

Add it to the deny-list to avoid the bogus battery status reporting.

Cc: Rasmus Porsager <rasmus@beat.dk>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 148eb8105803..39e16ecb7638 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -732,6 +732,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
 		},
 	},
+	{	/* Mele PCG03 Mini PC */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Mini PC"),
+		},
+	},
 	{
 		/* Minix Neo Z83-4 mini PC */
 		.matches = {
-- 
2.28.0

