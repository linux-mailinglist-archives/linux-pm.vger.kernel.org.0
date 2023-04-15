Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9356E3324
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 20:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDOSZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjDOSZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 14:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D994B44A4
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681583036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMopYM1FfOU8Bqr8dThzHPXxdRANDCda5wKV+pphZeU=;
        b=IddL1vHOJHXMC17NnyfJkzjxwXfPV12zX2MMiFbqEEQZQPPbFrlln3qvQ/D9Gg/Hss4tdD
        DNTGfj2ORfQHn189YBqlOq93W51A2CXuT3c+z/FqLSW0VrWuqJ0hhXOKputaxMz4Ubm/Bg
        gA3gDv2ZiarRJCE9r4bodzeMsUwqL4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-qG1DrYVEOOavdgChl_Bn4A-1; Sat, 15 Apr 2023 14:23:52 -0400
X-MC-Unique: qG1DrYVEOOavdgChl_Bn4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83A2385A588;
        Sat, 15 Apr 2023 18:23:52 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A534A51FF;
        Sat, 15 Apr 2023 18:23:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 09/10] power: supply: bq25890: Call power_supply_changed() after updating input current or voltage
Date:   Sat, 15 Apr 2023 20:23:40 +0200
Message-Id: <20230415182341.86916-10-hdegoede@redhat.com>
In-Reply-To: <20230415182341.86916-1-hdegoede@redhat.com>
References: <20230415182341.86916-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bq25892 model relies on external charger-type detection and once
that is done the bq25890_charger code will update the input current
and if pumpexpress is used also the input voltage.

In this case, when the initial power_supply_changed() call is made
from the interrupt handler, the input settings are 5V/0.5A which
on many devices is not enough power to charge (while the device is on).

On many devices the fuel-gauge relies in its external_power_changed
callback to timely signal userspace about charging <-> discharging
status changes. Add a power_supply_changed() call after updating
the input current or voltage. This allows the fuel-gauge driver
to timely recheck if the battery is charging after the new input
settings have been applied and then it can immediately notify
userspace about this.

Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging voltages through Pump Express+ protocol")
Fixes: eab25b4f93aa ("power: supply: bq25890: On the bq25892 set the IINLIM based on external charger detection")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index bfe08d7bfaf3..63001d6b2edb 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -775,6 +775,7 @@ static void bq25890_charger_external_power_changed(struct power_supply *psy)
 	}
 
 	bq25890_field_write(bq, F_IINLIM, input_current_limit);
+	power_supply_changed(psy);
 }
 
 static int bq25890_get_chip_state(struct bq25890_device *bq,
@@ -1106,6 +1107,8 @@ static void bq25890_pump_express_work(struct work_struct *data)
 	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
 		 voltage);
 
+	power_supply_changed(bq->charger);
+
 	return;
 error_print:
 	bq25890_field_write(bq, F_PUMPX_EN, 0);
-- 
2.39.1

