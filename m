Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADD63A508
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiK1JaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiK1JaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB91901D
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbIsOq0599aapcA3NKxnBaZO5RpjRbeD+eqdLLoK6yE=;
        b=ROieq3Sv0Jbh+9BlQtQ4eIi0GJH1Trgach6iCkRnexeEuYudnht/XQwxgVQ6Pd1TW31jlF
        NJFIwo6y0q0+PJTBhkC+M/rOPXR8Fo/Foj21g8MotminlimDc47sFVeruDIcGAHtsoM5XR
        3cUoo86S3mnVOFIE7fzEWWxlkfbW25c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-H3jNyg6SNh2cdiH_q0uiJA-1; Mon, 28 Nov 2022 04:29:08 -0500
X-MC-Unique: H3jNyg6SNh2cdiH_q0uiJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D455F802314;
        Mon, 28 Nov 2022 09:29:07 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E50B1FD48;
        Mon, 28 Nov 2022 09:29:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 6/9] power: supply: bq25890: Always take HiZ mode into account for ADC rate
Date:   Mon, 28 Nov 2022 10:28:53 +0100
Message-Id: <20221128092856.71619-7-hdegoede@redhat.com>
In-Reply-To: <20221128092856.71619-1-hdegoede@redhat.com>
References: <20221128092856.71619-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 0d188c0d94ff..9b3a173b316a 100644
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
2.37.3

