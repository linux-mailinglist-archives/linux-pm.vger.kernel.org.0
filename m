Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD0639C2E
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiK0SDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiK0SDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD465A6
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdklo9qCNFrSeqHOZqlOdcw+YlfKEwcEZ0JXpqyOGTU=;
        b=H1aO0/OXH2yqEXVvp9AT7rZB4hq7xulw5qonYbrXpW2zyW2n4evyd3wWoUPZTdCj+BlH3L
        YBghAkk5wkuBRNu3YLTrP6e+2CwxndsVU4vlJ86juMpQM5EcRZ/VSIPXyz5icN6vvGgNOM
        61naUh7XXcXSl0qPK32dXSPVB5tHKJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-hINbwBCrNcymbpDxMdbxig-1; Sun, 27 Nov 2022 13:02:49 -0500
X-MC-Unique: hINbwBCrNcymbpDxMdbxig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5204385A588;
        Sun, 27 Nov 2022 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FCC8140EBF5;
        Sun, 27 Nov 2022 18:02:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 06/10] power: supply: bq25890: Fix setting of F_CONV_RATE rate when disabling HiZ mode
Date:   Sun, 27 Nov 2022 19:02:29 +0100
Message-Id: <20221127180233.103678-7-hdegoede@redhat.com>
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

The recent "power: supply: bq25890: Add HiZ mode support" change
leaves F_CONV_RATE rate unset when disabling HiZ mode (setting
POWER_SUPPLY_PROP_ONLINE to 1) while a charger is connected.

Separate the resetting HiZ mode when necessary because of a charger
(re)plug event into its own if which runs first.

And fix the setting of F_CONV_RATE rate by adding helper variables for
the old and new F_CONV_RATE state which check both the online and hiz bits
and then compare the helper variables to see if a F_CONV_RATE update is
necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 41 +++++++++++---------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 2dffc5df0969..bd6858231271 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -795,6 +795,7 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
 
 static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 {
+	bool adc_conv_rate, new_adc_conv_rate;
 	struct bq25890_state new_state;
 	int ret;
 
@@ -805,33 +806,25 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
 	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
 		return IRQ_NONE;
 
-	/* power removed or HiZ */
-	if ((!new_state.online || new_state.hiz) && bq->state.online) {
-		/* disable ADC */
-		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
+	/*
+	 * Restore HiZ bit in case it was set by user. The chip does not retain
+	 * this bit on cable replug, hence the bit must be reset manually here.
+	 */
+	if (new_state.online && !bq->state.online && bq->force_hiz) {
+		ret = bq25890_field_write(bq, F_EN_HIZ, bq->force_hiz);
 		if (ret < 0)
 			goto error;
-	} else if (new_state.online && !bq->state.online) {
-		/*
-		 * Restore HiZ bit in case it was set by user.
-		 * The chip does not retain this bit once the
-		 * cable is re-plugged, hence the bit must be
-		 * reset manually here.
-		 */
-		if (bq->force_hiz) {
-			ret = bq25890_field_write(bq, F_EN_HIZ, bq->force_hiz);
-			if (ret < 0)
-				goto error;
-			new_state.hiz = 1;
-		}
+		new_state.hiz = 1;
+	}
 
-		if (!new_state.hiz) {
-			/* power inserted and not HiZ */
-			/* enable ADC, to have control of charge current/voltage */
-			ret = bq25890_field_write(bq, F_CONV_RATE, 1);
-			if (ret < 0)
-				goto error;
-		}
+	/* Should period ADC sampling be enabled? */
+	adc_conv_rate = bq->state.online && !bq->state.hiz;
+	new_adc_conv_rate = new_state.online && !new_state.hiz;
+
+	if (new_adc_conv_rate != adc_conv_rate) {
+		ret = bq25890_field_write(bq, F_CONV_RATE, new_adc_conv_rate);
+		if (ret < 0)
+			goto error;
 	}
 
 	bq->state = new_state;
-- 
2.38.1

