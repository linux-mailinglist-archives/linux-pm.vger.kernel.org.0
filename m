Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2917639C31
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiK0SDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0SDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF16552
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qur4XSKKOTLC+ygpjnu5mHbM7ctBSFY1Du/y79I9hEo=;
        b=H/yhfsi65DCuNRL/cV6RlIiZaoy1uaTBVTdN7LfM5Nemu+S3mAvtkLmJX812dWjCFVkkCV
        55QA3Cd4fvgR1U/K+0kWa8lFsfgxXX46n45X8Hz9teOsaDcgg86uOSOtcx72xSOP8tefDT
        MuXfqn2B8puKhBp3GbPBOcem74SXyfM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-YG2qnFb9MT2l8oKviIkimw-1; Sun, 27 Nov 2022 13:02:45 -0500
X-MC-Unique: YG2qnFb9MT2l8oKviIkimw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC0543804500;
        Sun, 27 Nov 2022 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2582D140EBF5;
        Sun, 27 Nov 2022 18:02:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 01/10] power: supply: bq25890: Only use pdata->regulator_init_data for vbus
Date:   Sun, 27 Nov 2022 19:02:24 +0100
Message-Id: <20221127180233.103678-2-hdegoede@redhat.com>
In-Reply-To: <20221127180233.103678-1-hdegoede@redhat.com>
References: <20221127180233.103678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bq25890_platform_data.regulator_init_data is intended to only provide
regulator init_data for the vbus regulator.

Remove this from the regulator_config before registering the vsys
regulator. Otherwise the regulator_register() call for vsys will fail
because it tries to register duplicate consumer_dev_name + supply
names from init_data->consumer_supplies[], leading to the entire
probe of the bq25890 driver failing:

[   32.017501] bq25890-charger i2c-bq25892_main: Failed to set supply vbus
[   32.017525] bq25890-charger i2c-bq25892_main: error -EBUSY: registering vsys regulator
[   32.124978] bq25890-charger: probe of i2c-bq25892_main failed with error -16

Fixes: 14a3d159abf8 ("power: supply: bq25890: Add Vsys regulator")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index bfdd2213ba69..512c81662eea 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1161,6 +1161,8 @@ static int bq25890_register_regulator(struct bq25890_device *bq)
 				     "registering vbus regulator");
 	}
 
+	/* pdata->regulator_init_data is for vbus only */
+	cfg.init_data = NULL;
 	reg = devm_regulator_register(bq->dev, &bq25890_vsys_desc, &cfg);
 	if (IS_ERR(reg)) {
 		return dev_err_probe(bq->dev, PTR_ERR(reg),
-- 
2.38.1

