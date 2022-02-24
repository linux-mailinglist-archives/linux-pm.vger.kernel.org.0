Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458EB4C38C7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 23:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiBXW2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 17:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBXW2u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 17:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8773D18FACC
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 14:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645741698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qn/GMDFP7OA7p3nnvStuDZM5BMirPgGstGqTu4CGSmA=;
        b=Q8qEAQ1Yc0eDV/pHRphxUDMAKaXcCbiA1qUuWpDQ1CRpEYqlxl+3bUUF2aMjdBVNizjrbx
        kF64mRQvQ5b7P8O0qSzIM9EO/WOtcoQ67nZR/EeYqezTnJmCOGEr7O6irBxjDQPAYBYxZu
        DcxG9w16CmkwcW3O1naJIJy5BGVjN1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-qRPtQ14nNJ2CHNAC6hXnGg-1; Thu, 24 Feb 2022 17:28:15 -0500
X-MC-Unique: qRPtQ14nNJ2CHNAC6hXnGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46BDA501E0;
        Thu, 24 Feb 2022 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CAE14D716;
        Thu, 24 Feb 2022 22:28:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] power: supply: axp288_*: Use acpi_quirk_skip_acpi_ac_and_battery()
Date:   Thu, 24 Feb 2022 23:28:03 +0100
Message-Id: <20220224222805.1689234-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

Normally the native AXP288 fg/charger drivers are preferred but one some
devices the ACPI drivers should be used instead.

The ACPI AC and battery drivers used to both have their own detection if
a PMIC on which native drivers should be preffered was present as well as
their own list of exceptions for devices like the ECS EF20EA, which has
an AXP288 PMIC but uses a separate fuel-gauge.

And the axp288_fuel_guage driver also has a dmi_system_id table entry
for the ECS EF20EA to avoid loading on this board. Where as for
the axp288_charger code it was decided that it was ok to have both
a /sys/class/power_supply/ADP1 from ACPI as well as a /axp288_charger .

So that is 3 separate "ECS EF20EA" dmi_system_id table entries in
3 different drivers (which should really be 4). In 5.17-rc1 a patch
adding a new acpi_quirk_skip_acpi_ac_and_battery() helper was merged
to remove the code duplication for this from the ACPI AC and battery
drivers:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57a18322227134e37b693ef8ef216ed7ce7ba7d6

This series makes the AXP288 charger and fuelgauge drivers also use
this helper. This allows removing the "ECS EF20EA" dmi_system_id table
entry from the fuel-gauge code and fixes the duplicate
/sys/class/power_supply/axp288_charger power_supply device on these
boards.

This also gives us a single place to add further exceptions if
necessary, rather then needing to do this in 4 different places.

Regards,

Hans


Hans de Goede (2):
  power: supply: axp288_charger: Use
    acpi_quirk_skip_acpi_ac_and_battery()
  power: supply: axp288_fuel_gauge: Use
    acpi_quirk_skip_acpi_ac_and_battery()

 drivers/power/supply/Kconfig             |  4 ++--
 drivers/power/supply/axp288_charger.c    |  7 +++++++
 drivers/power/supply/axp288_fuel_gauge.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.35.1

