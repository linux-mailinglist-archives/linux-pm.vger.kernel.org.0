Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5377639C35
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK0SD5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiK0SDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 13:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC6163A1
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669572173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MTY4DO2FIOhTmDrW9V5N/y/N6qxknBVOFxutodlRLvY=;
        b=CdCM39/c8o89LzLUV9Nah1Lo/NY8JcgB7jWlgm5XwEW74ke4FiS1IeaWgOnJm87Db7cF6E
        Qf595L3LKh6TD0kdAX1Ifx8u5DiNpCjhYQGWeQdbcIsyFviKVJfGd2hcx2sknM66UpuCdJ
        w4/aIn4P2GcPn6hzX/OSb8yJ7IE+ftQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-W1G1sF4SNwyk_PxXfBaCsQ-1; Sun, 27 Nov 2022 13:02:44 -0500
X-MC-Unique: W1G1sF4SNwyk_PxXfBaCsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5A0029AA388;
        Sun, 27 Nov 2022 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F8E5140EBF5;
        Sun, 27 Nov 2022 18:02:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 00/10] power: supply: bq25890: Fixes for 6.2 + further work for 6.3
Date:   Sun, 27 Nov 2022 19:02:23 +0100
Message-Id: <20221127180233.103678-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian, Marek,

I have been working on getting a Lenovo Yoga Tab 3 Pro (YT3-X90F) to
work with the mainline kernel. This tablet has 2 batteries with
2 bq25892 chargers both connected to a single Micro-USB connector.

Supporting the 2 charger board also requires the recent HiZ mode patches
from Marek, to avoid merging order problems / conflicts I have included
a copy of Marek's series here so this series obsoletes the:

[PATCH 1/2] power: supply: bq25890: Factor out chip state update
[PATCH 2/2] power: supply: bq25890: Add HiZ mode support
[PATCH v2 1/2] power: supply: bq25890: Factor out chip state update
[PATCH v2 2/2] power: supply: bq25890: Add HiZ mode support

patches from Marek.

While working on adding support for this I also noticed some generic issues
with the bq25890 driver currently in linux-power-supply/for-next and I also
have some fixes to the HiZ support on top of Marek's support.

So this entire series consist of 4 parts:

1. Patches 1-3:

Generic bugfixes for the bq25890 charger in its current state
in linux-power-supply/for-next. Patch 1/10 fixes an actual regression on
some boards with for-next so that one definitely needs to go to 6.2.
The other 2 fixes can go to either 6.2 or 6.3

2. Patches 4-5:

Marek's HiZ support work, thank you Marek.

3. Patches 6-7:

Some fixes / improvements from me to Marek's HiZ support.

4. Patch 8-10:

The actual support for boards with 2 chargers.

Stating the obvious here: given where we are in the cycle I expect
parts 2-4 / patches 4-10 to all be 6.3 material. 

Regards,

Hans



Hans de Goede (8):
  power: supply: bq25890: Only use pdata->regulator_init_data for vbus
  power: supply: bq25890: Ensure pump_express_work is cancelled on
    remove
  power: supply: bq25890: Fix usb-notifier probe and remove races
  power: supply: bq25890: Fix setting of F_CONV_RATE rate when disabling
    HiZ mode
  power: supply: bq25890: Always take HiZ mode into account for ADC rate
  power: supply: bq25890: Support boards with more then one charger IC
  power: supply: bq25890: Add support for having a secondary charger IC
  power: supply: bq25890: Add new linux,iinlim-percentage property

Marek Vasut (2):
  power: supply: bq25890: Factor out chip state update
  power: supply: bq25890: Add HiZ mode support

 drivers/platform/x86/x86-android-tablets.c |   2 +-
 drivers/power/supply/bq25890_charger.c     | 213 ++++++++++++++++-----
 2 files changed, 169 insertions(+), 46 deletions(-)

-- 
2.38.1

