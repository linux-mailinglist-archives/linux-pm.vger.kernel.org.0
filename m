Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902A63A50A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiK1JaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiK1JaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970FBC33
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669627746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TFUPPx15t5qAgnQGrzm3SVik7awGDnlmdP/292MHE0o=;
        b=etvjN0T66pA3B8q2enqyHPMb6qxaK/FDI/Akhq1AMFTs7SSKLZreddSzs8jHeVVSz/2MUB
        khIr6TJgPwA5KJKsZhFYHlxHJESIYMH6OcFzr7K0BH67pNY/lD/3nvF/hFToeSpXvRHb8M
        qt0IHZeULBt/GBgyzbJ87WTGQvMh7Qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-R0iAQaYbNeCha9v1y_Hghw-1; Mon, 28 Nov 2022 04:29:00 -0500
X-MC-Unique: R0iAQaYbNeCha9v1y_Hghw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59DDA106D0D6;
        Mon, 28 Nov 2022 09:29:00 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21168FD48;
        Mon, 28 Nov 2022 09:28:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/9] power: supply: bq25890: Fixes for 6.2 + further work for 6.3
Date:   Mon, 28 Nov 2022 10:28:47 +0100
Message-Id: <20221128092856.71619-1-hdegoede@redhat.com>
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

Hi Sebastian, Marek,

Here is v2 of my bq25890 series from yesterday, addressing the few
small remarks from Marek + adding Marek's Reviewed-by to most of
my patches. Note I dropped patch 1/10 from the v1 series since that
has already been merged.

Here is a (slightly updated) copy of the v1 cover letter:

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

1. Patches 1-2:

Generic bugfixes for the bq25890 charger in its current state
in linux-power-supply/for-next.

2. Patches 3-4:

Marek's HiZ support work, thank you Marek.

3. Patches 5-6:

Some fixes / improvements from me to Marek's HiZ support.

4. Patch 7-9:

The actual support for boards with 2 chargers.

Regards,

Hans


Hans de Goede (7):
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
 drivers/power/supply/bq25890_charger.c     | 226 ++++++++++++++++-----
 2 files changed, 179 insertions(+), 49 deletions(-)

-- 
2.37.3

