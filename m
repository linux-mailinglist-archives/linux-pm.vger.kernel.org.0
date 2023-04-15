Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1F6E324A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDOQIb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDOQIa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 12:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214735AA
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681574859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1EJ37WgJCTQ77uRKWmCCAlQ9CDy6OtFYG+v/4bf9BA4=;
        b=fchAYQ2Qt2xcnawckqPKxe/ZhauhjZpIKEPa5ykfj0CaatG6HL0K2egTbSHzgIKXQRtU5i
        wodGUQ/jKD4Ek+mkiefAeEhkK8cyIHBlsjFJR1UNA+G121grkieqUdFXCAupm4M7r5lwVK
        DPl7kDe1OCt5GpOW32KNl1WTI45doUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-h_bbmOpqM4qhsMtTsiNIVQ-1; Sat, 15 Apr 2023 12:07:37 -0400
X-MC-Unique: h_bbmOpqM4qhsMtTsiNIVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67C0D80D0EA;
        Sat, 15 Apr 2023 16:07:37 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3D7E2166B26;
        Sat, 15 Apr 2023 16:07:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6] power: supply: ab8500: Fix external_power_changed race
Date:   Sat, 15 Apr 2023 18:07:29 +0200
Message-Id: <20230415160734.70475-2-hdegoede@redhat.com>
In-Reply-To: <20230415160734.70475-1-hdegoede@redhat.com>
References: <20230415160734.70475-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ab8500_btemp_external_power_changed() dereferences di->btemp_psy,
which gets sets in ab8500_btemp_probe() like this:

        di->btemp_psy = devm_power_supply_register(dev, &ab8500_btemp_desc,
                                                   &psy_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where ab8500_btemp_external_power_changed() may get called while
di->btemp_psy has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in di->btemp_psy,
so ab8500_btemp_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

And the same applies to ab8500_fg_external_power_changed().

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this has been compile tested only
---
 drivers/power/supply/ab8500_btemp.c | 6 ++----
 drivers/power/supply/ab8500_fg.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 307ee6f71042..6f83e99d2eb7 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -624,10 +624,8 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 41a7bff9ac37..53560fbb6dcd 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2407,10 +2407,8 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->fg_psy, ab8500_fg_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_fg_get_ext_psy_data);
 }
 
 /**
-- 
2.39.1

