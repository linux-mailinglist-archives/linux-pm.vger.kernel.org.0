Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60544639C32
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK0SDx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0SDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B468A65B6
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3tojER/XEoxSgi1f6HQVJc3jUZzZS7fVXAPtb8z5gE=;
        b=Y5MC1PA4UUcQYfhDfeM63xq1gOOzRFmYIpIULII1BgGjJj8v7AAXbT+peRreMukn599MYZ
        Yu4iwyb1KXfCqGPS1Ug1pABb81T0i0kKRVR3A2ACK34MgZTgcVXVY94hPHhEpN8uAemLih
        qUEtGImlHH0HzaBbHa/tDw8KVPBLz3s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-VsmWldCpO1yM2V4p14rPkQ-1; Sun, 27 Nov 2022 13:02:50 -0500
X-MC-Unique: VsmWldCpO1yM2V4p14rPkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3911F3C0D188;
        Sun, 27 Nov 2022 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85E20140EBF5;
        Sun, 27 Nov 2022 18:02:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 07/10] power: supply: bq25890: Always take HiZ mode into account for ADC rate
Date:   Sun, 27 Nov 2022 19:02:30 +0100
Message-Id: <20221127180233.103678-8-hdegoede@redhat.com>
In-Reply-To: <20221127180233.103678-1-hdegoede@redhat.com>
References: <20221127180233.103678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code to check if F_CONV_RATE has been set, or if a manual ADC
conversion needs to be triggered, as well as the code to set
the initial F_CONV_RATE value at probe both where not taking
HiZ mode into account. Add checks for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index bd6858231271..03e31c5b0df5 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -467,7 +467,7 @@ static void bq25890_update_state(struct bq25890_device *bq,
 	/* update state in case we lost an interrupt */
 	__bq25890_handle_irq(bq);
 	*state = bq->state;
-	do_adc_conv = !state->online && bq25890_is_adc_property(psp);
+	do_adc_conv = (!state->online || state->hiz) && bq25890_is_adc_property(psp);
 	if (do_adc_conv)
 		bq25890_field_write(bq, F_CONV_START, 1);
 	mutex_unlock(&bq->lock);
@@ -956,7 +956,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 	}
 
 	/* Configure ADC for continuous conversions when charging */
-	ret = bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
+	ret = bq25890_field_write(bq, F_CONV_RATE, bq->state.online && !bq->state.hiz);
 	if (ret < 0) {
 		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
 		return ret;
-- 
2.38.1

