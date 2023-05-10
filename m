Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648916FE250
	for <lists+linux-pm@lfdr.de>; Wed, 10 May 2023 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEJQXa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 May 2023 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjEJQX3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 May 2023 12:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E12C7295
        for <linux-pm@vger.kernel.org>; Wed, 10 May 2023 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683735765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7LdhAJieegVHrXtma/ffaQ+dm+tSLZToc/pLp+pQaYE=;
        b=fwsRWtTlzv6NwEzoEfsW8KPziIv2EE4FW/bCA9K/xCKquK1DYvJFyaneB/EUS+K2w3n8L/
        azHJut4y13v1iAakF2F9b7iHeN0bDaArnjm2tD7EFBTVTYs2zdB2zia28hTnTcaUrMfpvx
        j9dGRWyTNoc44VcT4cXuW5KtHfxqsj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-Ay-rr86bMduvR9CcyruC3w-1; Wed, 10 May 2023 12:22:39 -0400
X-MC-Unique: Ay-rr86bMduvR9CcyruC3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55D54863E8A;
        Wed, 10 May 2023 16:22:37 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B9004078906;
        Wed, 10 May 2023 16:22:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Subject: [PATCH RESEND 0/4] Fix oops about sleeping in led_trigger_blink()
Date:   Wed, 10 May 2023 18:22:30 +0200
Message-Id: <20230510162234.291439-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

This is a resend with al the subsys maintainers of files touched
by the small led_trigger_blink() / led_trigger_blink_oneshot()
API/prototype change in the first patch in this series.

ARCNet, power-supply, USB, MAC80211 and netfilter maintainers,
may we please have your ack for merging patch 1/4 through Lee's
LED tree: https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/
?

Orginal cover letter:

Here is a patch series to fix an oops about sleeping in led_trigger_blink()
+ one other small bugfix.

Fixes: 0b9536c95709 ("leds: Add ability to blink via simple trigger")

tag, but Fixes tags tend to lead to patches getting automatically added
to the stable series and I would prefer to see this series get some
significant testing time in mainline first, so I have chosen to omit
the tag.

Regards,

Hans


Hans de Goede (4):
  leds: Change led_trigger_blink[_oneshot]() delay parameters to
    pass-by-value
  leds: Fix set_brightness_delayed() race
  leds: Fix oops about sleeping in led_trigger_blink()
  leds: Clear LED_INIT_DEFAULT_TRIGGER when clearing current trigger

 drivers/leds/led-core.c                  | 81 ++++++++++++++++++++----
 drivers/leds/led-triggers.c              | 17 ++---
 drivers/leds/trigger/ledtrig-disk.c      |  9 +--
 drivers/leds/trigger/ledtrig-mtd.c       |  8 +--
 drivers/net/arcnet/arcnet.c              |  8 +--
 drivers/power/supply/power_supply_leds.c |  5 +-
 drivers/usb/common/led.c                 |  4 +-
 include/linux/leds.h                     | 43 ++++++++++---
 net/mac80211/led.c                       |  2 +-
 net/mac80211/led.h                       |  8 +--
 net/netfilter/xt_LED.c                   |  3 +-
 11 files changed, 125 insertions(+), 63 deletions(-)

-- 
2.40.1

