Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36224AB13B
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbiBFSf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 13:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBFSf6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 13:35:58 -0500
X-Greylist: delayed 1009 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 10:35:58 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20EBFC043184
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644172557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L9zIs8S3tgH2vq8VrJwlQwi2AV084SQK46MI0XA6GhA=;
        b=OqF5qolzSq6BeY696LWJ4jJYzl6hf6prDsFlL9wX4XLHXfW32c84vuzxhmQrVqLZv6odNB
        7WGjeWPz5Hekqk8q1oyvejGsTX0sCviVpGVAPFURjHGnMG/rVTvQnLFrJdI6oOSjAurlxr
        pie84AyrUaIocn8mfnBDRcWVHnh2JEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-EwICki6ENwawglIrGsA2Qw-1; Sun, 06 Feb 2022 13:35:54 -0500
X-MC-Unique: EwICki6ENwawglIrGsA2Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A52B180FCDC;
        Sun,  6 Feb 2022 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA32685EED;
        Sun,  6 Feb 2022 18:35:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/8] power: supply: bq24190 updates + new ug3105 driver
Date:   Sun,  6 Feb 2022 19:35:35 +0100
Message-Id: <20220206183543.51200-1-hdegoede@redhat.com>
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

Hi Sebastian,

Here is v2 of the series of patches which:

1. Modifies power_supply_get_battery_info() to also work with non
   of/dt device-properties

2. Modifies bq24190_charger to use and apply more settings returned
   by power_supply_get_battery_info()

3. Adds a new driver for the ug3105 battery monitoring chip, note
   this chip is not really a full/standalone fuel-gauge so
   the functionality of the is limited

The only change in v2 is using the correct "upisemi" vendor prefix in
the new ug3105 driver.

Regards,

Hans


Hans de Goede (8):
  power: supply: core: Use fwnode_property_*() in
    power_supply_get_battery_info()
  power: supply: core: Add support for generic fwnodes to
    power_supply_get_battery_info()
  power: supply: bq24190_charger: Turn off 5V boost regulator on
    shutdown
  power: supply: bq24190_charger: Always call
    power_supply_get_battery_info()
  power: supply: bq24190_charger: Store ichg-max and vreg-max in
    bq24190_dev_info
  power: supply: bq24190_charger: Program charger with fwnode supplied
    ccc_ireg and cvc_vreg
  power: supply: bq24190_charger: Disallow ccc_ireg and cvc_vreg to be
    higher then the fwnode values
  power: supply: ug3105_battery: Add driver for uPI uG3105 battery
    monitor

 drivers/power/supply/Kconfig             |  15 +
 drivers/power/supply/Makefile            |   1 +
 drivers/power/supply/bq24190_charger.c   | 114 ++++--
 drivers/power/supply/power_supply_core.c |  93 +++--
 drivers/power/supply/ug3105_battery.c    | 486 +++++++++++++++++++++++
 5 files changed, 643 insertions(+), 66 deletions(-)
 create mode 100644 drivers/power/supply/ug3105_battery.c

-- 
2.33.1

