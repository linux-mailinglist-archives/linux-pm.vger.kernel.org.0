Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A7585E66
	for <lists+linux-pm@lfdr.de>; Sun, 31 Jul 2022 12:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiGaKCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 Jul 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGaKCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jul 2022 06:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FA03DF6A
        for <linux-pm@vger.kernel.org>; Sun, 31 Jul 2022 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659261756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vayguMlD77QjDBXfS0xZu3bAQP0f8I6/l5OuMHXvdMM=;
        b=JHvABvDxL/AX/DCygsfOADAc+SYXI3Gus7WBewB0neDF92M1D2YyP4hBiGzHDAsBWqJ+va
        DbdvJ/tbY90j7KJr42c120sdzqljZh/4z9XLEs5Him7cryeVbAxW5bsg1g5HbmjYyDXR1j
        Piju08JifXwMOTaBnhSovv9PFMjgZag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Rzwj82_WOYuCD3DKLXneqw-1; Sun, 31 Jul 2022 06:02:34 -0400
X-MC-Unique: Rzwj82_WOYuCD3DKLXneqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A7DB8037B3;
        Sun, 31 Jul 2022 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 923332026D64;
        Sun, 31 Jul 2022 10:02:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: bq25890: Disable PUMPX_EN on errors
Date:   Sun, 31 Jul 2022 12:02:28 +0200
Message-Id: <20220731100228.32920-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When bq25890_pump_express_work encounters an errors disable
the PUMPX_EN flag, just like the work does on a successful exit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 852a6fec4339..056260b2cb76 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -946,6 +946,7 @@ static void bq25890_pump_express_work(struct work_struct *data)
 
 	return;
 error_print:
+	bq25890_field_write(bq, F_PUMPX_EN, 0);
 	dev_err(bq->dev, "Failed to request hi-voltage charging\n");
 }
 
-- 
2.37.1

