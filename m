Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF64A4B1C
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiAaP6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379948AbiAaP6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaYyzPY8rVZtuVN9ayumSFX8EOvUvD+OtdVBt+eL/PE=;
        b=g77k0Y672zoNof5AtYf+X/sFLObwt4/8RAVIT2VxWGzD2nL3mY+Ay6Dn0rvOyxCkU9j9bN
        pzRGAHFj9SAMugh7r0uXbKJjCt3PN7Tq6VOKkK3gjRlT933Ywc7CaABbwJsMc3hGg+CZWy
        4DFncEN8X/3v7cZxzKlqEO14q8J50HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-FgZ7Y7YXMAqOHJNAfPoqTw-1; Mon, 31 Jan 2022 10:58:02 -0500
X-MC-Unique: FgZ7Y7YXMAqOHJNAfPoqTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A02881853024;
        Mon, 31 Jan 2022 15:58:01 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F91979529;
        Mon, 31 Jan 2022 15:58:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 4/8] power: supply: bq24190_charger: Always call power_supply_get_battery_info()
Date:   Mon, 31 Jan 2022 16:57:26 +0100
Message-Id: <20220131155730.309513-5-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

power_supply_get_battery_info() now also supports getting battery_info
on boards not using dt/of. Remove the of_node check. If neither of nor
other battery-info is present the function will fail making this change
a no-op in that case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 7414830a70e4..83873119ba24 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1693,8 +1693,7 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 			dev_warn(bdi->dev, "invalid value for %s: %u\n", s, v);
 	}
 
-	if (bdi->dev->of_node &&
-	    !power_supply_get_battery_info(bdi->charger, &info)) {
+	if (!power_supply_get_battery_info(bdi->charger, &info)) {
 		v = info->precharge_current_ua / 1000;
 		if (v >= BQ24190_REG_PCTCC_IPRECHG_MIN
 		 && v <= BQ24190_REG_PCTCC_IPRECHG_MAX)
-- 
2.33.1

