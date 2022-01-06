Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36236486374
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiAFLGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238255AbiAFLGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpZwPW5uLZqgBcXjmX/3wTTtHQm+TlsQWAQ2uAoGqbI=;
        b=ShFWr2n9q2KDmeXO0pemWjUfHN6E/tTFOCKeJ5labHZCTVLa7Nl2w54N835ewYlvPsXMRA
        hGX3dIYQExhKPK/Xam/EJs88zG9/Gy5TI0La4Lf+cgQQYGyRrFAobmxV8h9wA8QKaDsSzc
        bubuoRQiy9n3Z3ZcjsWLDFg3o5Twiwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-SjJ6WmBENwKjrlb6G4Orlw-1; Thu, 06 Jan 2022 06:06:39 -0500
X-MC-Unique: SjJ6WmBENwKjrlb6G4Orlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2687818C8C00;
        Thu,  6 Jan 2022 11:06:38 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E103F752B4;
        Thu,  6 Jan 2022 11:06:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 4/7] power: supply: axp288_fuel_gauge: Use devm_power_supply_register()
Date:   Thu,  6 Jan 2022 12:06:05 +0100
Message-Id: <20220106110608.66231-4-hdegoede@redhat.com>
In-Reply-To: <20220106110608.66231-1-hdegoede@redhat.com>
References: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_power_supply_register() instead of
power_supply_register().

Note as a side-effect this changes the release order so that now
first the IRQs get free-ed and then the psy gets unregistered.
This is actually a bug-fix since this fixes the IRQ possibly trying
to reference the unregistered psy.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index aaf2d5542316..cefde85e3309 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -740,7 +740,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		return ret;
 
 	psy_cfg.drv_data = info;
-	info->bat = power_supply_register(dev, &fuel_gauge_desc, &psy_cfg);
+	info->bat = devm_power_supply_register(dev, &fuel_gauge_desc, &psy_cfg);
 	if (IS_ERR(info->bat)) {
 		ret = PTR_ERR(info->bat);
 		dev_err(dev, "failed to register battery: %d\n", ret);
@@ -763,8 +763,6 @@ static int axp288_fuel_gauge_remove(struct platform_device *pdev)
 	struct axp288_fg_info *info = platform_get_drvdata(pdev);
 	int i;
 
-	power_supply_unregister(info->bat);
-
 	for (i = 0; i < AXP288_FG_INTR_NUM; i++)
 		if (info->irq[i] >= 0)
 			free_irq(info->irq[i], info);
-- 
2.33.1

