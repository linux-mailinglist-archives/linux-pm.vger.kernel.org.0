Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C420C7182B0
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjEaNop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbjEaNoH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 09:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539CA1B8;
        Wed, 31 May 2023 06:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB3E463B56;
        Wed, 31 May 2023 13:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59585C433EF;
        Wed, 31 May 2023 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540529;
        bh=PsRJJ5ZxMa7cs8GT5ohChX59MmmNPMIucMA3Mt/cmNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2oCwmg/QrPsNCboPb3x4oHCjz33r4bMagGjVMIKvD5Dr/NmGmCpinFbgG+XElUMN
         hL+jqRQtee/osc6i5TUMz8qHSHckZSHCFH8t6T8yU0PxRv4U9+ZBMzoK1tIHPXv90P
         L1EIJDXFfDVaed+H09VcjS5tBIQJpYbPeA900DOjbv7OPM0RIhlFE6mF9yUnP+mDeb
         mogWft4CM7xWzBpZVgUP63otHSkes+D6IqszHLSulw2Unb7WjBVNxVxcURKOwPsBl1
         qrlIA0YAWNZgSPXimDH9nIp0hC1v3/kyEH+JvjHqTge8CEF53Sj/szx0tcO4gmYNeu
         ThuVeUEYinDVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/33] power: supply: sc27xx: Fix external_power_changed race
Date:   Wed, 31 May 2023 09:41:28 -0400
Message-Id: <20230531134159.3383703-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 4d5c129d6c8993fe96e9ae712141eedcb9ca68c2 ]

sc27xx_fgu_external_power_changed() dereferences data->battery,
which gets sets in ab8500_btemp_probe() like this:

	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
                                                   &fgu_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where sc27xx_fgu_external_power_changed() may get called while
data->battery has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in data->battery,
so sc27xx_fgu_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

After this change sc27xx_fgu_external_power_changed() is reduced to just
"power_supply_changed(psy);" and it has the same prototype. While at it
simply replace it with making the external_power_changed callback
directly point to power_supply_changed.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 632977f84b954..bd23c4d9fed43 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -733,13 +733,6 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 	return ret;
 }
 
-static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
-{
-	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
-
-	power_supply_changed(data->battery);
-}
-
 static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
@@ -774,7 +767,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
 	.set_property		= sc27xx_fgu_set_property,
-	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.external_power_changed	= power_supply_changed,
 	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 	.no_thermal		= true,
 };
-- 
2.39.2

