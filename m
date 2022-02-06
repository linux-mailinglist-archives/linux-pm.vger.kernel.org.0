Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1714AB13F
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiBFSgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 13:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiBFSgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 13:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E4AC06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644172562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaYyzPY8rVZtuVN9ayumSFX8EOvUvD+OtdVBt+eL/PE=;
        b=T4O1HDBet0pIKJ67WtRZHIyKg9h3+6YOry6WVNdRxsAT4pkaVmufScNWWcDOxqtwNR/DjZ
        mtRhr0JAXHrcs2Tzqu2lj2RZBtMow10n/7kas/fZ0hm2OWfBG3A8SviPtGXiAn/OvAgQEh
        DA8lMUQBkWXKn2CK3yXwjKGUzHDakHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-LlH_Pv5LNF6YwduqPN7VFQ-1; Sun, 06 Feb 2022 13:35:58 -0500
X-MC-Unique: LlH_Pv5LNF6YwduqPN7VFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2650801B2E;
        Sun,  6 Feb 2022 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0761485EE4;
        Sun,  6 Feb 2022 18:35:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH v2 4/8] power: supply: bq24190_charger: Always call power_supply_get_battery_info()
Date:   Sun,  6 Feb 2022 19:35:39 +0100
Message-Id: <20220206183543.51200-5-hdegoede@redhat.com>
In-Reply-To: <20220206183543.51200-1-hdegoede@redhat.com>
References: <20220206183543.51200-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

