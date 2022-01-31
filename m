Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23C24A4B1D
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379951AbiAaP6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379950AbiAaP6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQhKiL5PZm0ua4bYfpZe/JtLpub25Q5rMxkcjoyDS4c=;
        b=Rfj2mXhAU4Y1UeE0GxqF4ldizu/V1yBBFaG0cchH+MDDyDUbWRO2IQ9+0xsXNBoK9S+huG
        oe5a8hsD3t80uDzqf35ewOYbVV+GNeTBk1d1vsIV3TXcz1SyrGeeoU2bVEiOJyfS/iXXtt
        oMEYyKdrv25kG0tCWZ4S+d1ZlccSOX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-NbI8JgiFPeiI9FAhnMDtGQ-1; Mon, 31 Jan 2022 10:58:10 -0500
X-MC-Unique: NbI8JgiFPeiI9FAhnMDtGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75134363A4;
        Mon, 31 Jan 2022 15:58:09 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1850679529;
        Mon, 31 Jan 2022 15:58:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 7/8] power: supply: bq24190_charger: Disallow ccc_ireg and cvc_vreg to be higher then the fwnode values
Date:   Mon, 31 Jan 2022 16:57:29 +0100
Message-Id: <20220131155730.309513-8-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the fwnode data as parsed by power_supply_get_battery_info() provides
max values for ccc_ireg and cvc_vreg then do not allow the user to later
set these to higher values then those specified by the firmware,
otherwise the battery might get damaged.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 974e4b6b8d4d..04aa25f2d033 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1019,6 +1019,9 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 	if (v)
 		curr *= 5;
 
+	if (curr > bdi->ichg_max)
+		return -EINVAL;
+
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
@@ -1052,6 +1055,9 @@ static int bq24190_charger_set_voltage(struct bq24190_dev_info *bdi,
 {
 	int ret;
 
+	if (val->intval > bdi->vreg_max)
+		return -EINVAL;
+
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CVC,
 			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
 			bq24190_cvc_vreg_values,
@@ -1743,11 +1749,11 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 		/* These are optional, so no warning when not set */
 		v = info->constant_charge_current_max_ua;
 		if (v >= bq24190_ccc_ichg_values[0] && v <= bdi->ichg_max)
-			bdi->ichg = v;
+			bdi->ichg = bdi->ichg_max = v;
 
 		v = info->constant_charge_voltage_max_uv;
 		if (v >= bq24190_cvc_vreg_values[0] && v <= bdi->vreg_max)
-			bdi->vreg = v;
+			bdi->vreg = bdi->vreg_max = v;
 	}
 
 	return 0;
-- 
2.33.1

