Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC224AB142
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 19:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiBFSgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 13:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbiBFSgF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 13:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D2EC06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644172563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQhKiL5PZm0ua4bYfpZe/JtLpub25Q5rMxkcjoyDS4c=;
        b=RgYR0OJ8eks6CNo76ItZlLdZ42ehZdN4p6lCtoJ6OZstzdGl5SAn4p38ye6hAKtw6vQcEs
        ErmZXo8OLsg/SP6iDKI1zZhLECdWuia8i7S8F0CBn2Tn6CMgWHESXGL3Tj2Gfv/eZNWyyG
        6qx9/OdiW8rP2++/goWzdIcv3X2GkBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-pVgKgX0wMVugeRNZaNDWMw-1; Sun, 06 Feb 2022 13:36:02 -0500
X-MC-Unique: pVgKgX0wMVugeRNZaNDWMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5D3B2F46;
        Sun,  6 Feb 2022 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53A085EE4;
        Sun,  6 Feb 2022 18:36:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH v2 7/8] power: supply: bq24190_charger: Disallow ccc_ireg and cvc_vreg to be higher then the fwnode values
Date:   Sun,  6 Feb 2022 19:35:42 +0100
Message-Id: <20220206183543.51200-8-hdegoede@redhat.com>
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

If the fwnode data as parsed by power_supply_get_battery_info() provides
max values for ccc_ireg and cvc_vreg then do not allow the user to later
set these to higher values then those specified by the firmware,
otherwise the battery might get damaged.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 974e4b6b8d4d..04aa25f2d033 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1019,6 +1019,9 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 	if (v)
 		curr *= 5;
 
+	if (curr > bdi->ichg_max)
+		return -EINVAL;
+
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
@@ -1052,6 +1055,9 @@ static int bq24190_charger_set_voltage(struct bq24190_dev_info *bdi,
 {
 	int ret;
 
+	if (val->intval > bdi->vreg_max)
+		return -EINVAL;
+
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CVC,
 			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
 			bq24190_cvc_vreg_values,
@@ -1743,11 +1749,11 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 		/* These are optional, so no warning when not set */
 		v = info->constant_charge_current_max_ua;
 		if (v >= bq24190_ccc_ichg_values[0] && v <= bdi->ichg_max)
-			bdi->ichg = v;
+			bdi->ichg = bdi->ichg_max = v;
 
 		v = info->constant_charge_voltage_max_uv;
 		if (v >= bq24190_cvc_vreg_values[0] && v <= bdi->vreg_max)
-			bdi->vreg = v;
+			bdi->vreg = bdi->vreg_max = v;
 	}
 
 	return 0;
-- 
2.33.1

