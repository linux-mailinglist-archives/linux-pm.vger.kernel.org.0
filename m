Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A702C516E9A
	for <lists+linux-pm@lfdr.de>; Mon,  2 May 2022 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiEBLQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 May 2022 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiEBLQL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2022 07:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B39592ADA
        for <linux-pm@vger.kernel.org>; Mon,  2 May 2022 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651489962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zRBDLSfl0BWqE/4c/SUx+32lrTgwl8OIz3dieAxXig=;
        b=JQXEPFabp5AQ74dLX0xqq8mbp/aL2vPPERs8wbqt/y9EdzDg0ceWps52CuEo+9tUDO9/ft
        KDfR2boUtHgoZybdjIsDJBfoKn8WBGpYOxpSlM1wSfKyp7jZDUzfU6afiq2/EUukhbMXnB
        sh/Egv6zQS5D572OknpihEcbjDeiN4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-8wgCmUQ9NN2OV89qjX4cMg-1; Mon, 02 May 2022 07:12:39 -0400
X-MC-Unique: 8wgCmUQ9NN2OV89qjX4cMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DDFF185A7A4;
        Mon,  2 May 2022 11:12:39 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D62214C4D78;
        Mon,  2 May 2022 11:12:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: axp288_fuel_gauge: Drop BIOS version check from "T3 MRD" DMI quirk
Date:   Mon,  2 May 2022 13:12:35 +0200
Message-Id: <20220502111235.331877-2-hdegoede@redhat.com>
In-Reply-To: <20220502111235.331877-1-hdegoede@redhat.com>
References: <20220502111235.331877-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some "T3 MRD" mini-PCs / HDMI-sticks without a battery use a different
value then "5.11" for their DMI BIOS version field.

Drop the BIOS version check so that the no-battery "T3 MRD" DMI quirk
applies to these too.

Fixes: 3a06b912a5ce ("power: supply: axp288_fuel_gauge: Make "T3 MRD" no_battery_list DMI entry more generic")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 5b8aa4a980cd..8e6f8a655079 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -609,7 +609,6 @@ static const struct dmi_system_id axp288_quirks[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
 			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
 			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			DMI_MATCH(DMI_BIOS_VERSION, "5.11"),
 		},
 		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
-- 
2.36.0

