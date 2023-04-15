Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E16E3322
	for <lists+linux-pm@lfdr.de>; Sat, 15 Apr 2023 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDOSZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Apr 2023 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDOSZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2023 14:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840444A1
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2023 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681583035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lno82ZTayyFWZpf5JUdaIrLP0T/3X9BajPt9gWC2dsE=;
        b=bV/dhdK/REBhA/SIzcbxpTMRJMbZ1IIPUt8SISjkc4rOU5bd2+0MMg/xKOzyKL7kl4iGUE
        qJIvAqIhIAHbwamuhj/dLrwa22YwT7ndKF8Kh2qiOexHcme7Mje+jK0DDRlhNC+BRNocR3
        cD5ZoFeF07PzlEnVLf2JmHqRR/dJnGc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-lPVHhBqVNeWYoueiBHma_w-1; Sat, 15 Apr 2023 14:23:54 -0400
X-MC-Unique: lPVHhBqVNeWYoueiBHma_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9780C1C05153;
        Sat, 15 Apr 2023 18:23:53 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B62F0728FC;
        Sat, 15 Apr 2023 18:23:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 10/10] power: supply: bq24190: Call power_supply_changed() after updating input current
Date:   Sat, 15 Apr 2023 20:23:41 +0200
Message-Id: <20230415182341.86916-11-hdegoede@redhat.com>
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

The bq24192 model relies on external charger-type detection and once
that is done the bq24190_charger code will update the input current.

In this case, when the initial power_supply_changed() call is made
from the interrupt handler, the input settings are 5V/0.5A which
on many devices is not enough power to charge (while the device is on).

On many devices the fuel-gauge relies in its external_power_changed
callback to timely signal userspace about charging <-> discharging
status changes. Add a power_supply_changed() call after updating
the input current. This allows the fuel-gauge driver to timely recheck
if the battery is charging after the new input current has been applied
and then it can immediately notify userspace about this.

Fixes: 18f8e6f695ac ("power: supply: bq24190_charger: Get input_current_limit from our supplier")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index de67b985f0a9..dc33f00fcc06 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1262,6 +1262,7 @@ static void bq24190_input_current_limit_work(struct work_struct *work)
 	bq24190_charger_set_property(bdi->charger,
 				     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 				     &val);
+	power_supply_changed(bdi->charger);
 }
 
 /* Sync the input-current-limit with our parent supply (if we have one) */
-- 
2.39.1

