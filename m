Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9721B7080DE
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjERMMm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 08:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjERMMl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 08:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BEDE46;
        Thu, 18 May 2023 05:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B003A64EC0;
        Thu, 18 May 2023 12:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA4C433EF;
        Thu, 18 May 2023 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684411959;
        bh=HQbrGsVEWGpBhnO+Kgnh4OFttxZ6LnaXdPUMdYq0FQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUWMgZFdbGzjVGrh45IXRwY5fY9S25C+cCktX+MQhc9z2Gdb82NKa+siLaasFrQAh
         EAjWyKqZygY3e//EKQxNPP/PANdDrwjP5PpU6V0ZE3VH3RyHFAnkR/OdLyL0twtgoX
         cvQQ3RMPjPbhd637yWeLZAKwJbjm1tGjobsvkwsAesU7sloVoZDo5AWMP2ri5eHtLD
         uh/wgXl3GTty6q7wLW5gAR2LINbwHYyOcVuEtqD+1cMonQNZ7z5GLhImoc49lgcPgN
         6+Va9pcqeldMG43kRT5DPhxxkirg7FN+5NPrmhio0atSP11NgsUIplUieTg3MTSYi9
         315kjE7Vl/d2Q==
Date:   Thu, 18 May 2023 13:12:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH RESEND 1/4] leds: Change led_trigger_blink[_oneshot]()
 delay parameters to pass-by-value
Message-ID: <20230518121232.GG404509@google.com>
References: <20230510162234.291439-1-hdegoede@redhat.com>
 <20230510162234.291439-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162234.291439-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 10 May 2023, Hans de Goede wrote:

> led_blink_set[_oneshot]()'s delay_on and delay_off function parameters
> are pass by reference, so that hw-blink implementations can report
> back the actual achieved delays when the values have been rounded
> to something the hw supports.
> 
> This is really only interesting for the sysfs API / the timer trigger.
> Other triggers don't really care about this and none of the callers of
> led_trigger_blink[_oneshot]() do anything with the returned delay values.
> 
> Change the led_trigger_blink[_oneshot]() delay parameters to pass-by-value,
> there are 2 reasons for this:
> 
> 1. led_cdev->blink_set() may sleep, while led_trigger_blink() may not.
> So on hw where led_cdev->blink_set() sleeps the call needs to be deferred
> to a workqueue, in which case the actual achieved delays are unknown
> (this is a preparation patch for the deferring).
> 
> 2. Since the callers don't care about the actual achieved delays, allowing
> callers to directly pass a value leads to simpler code for most callers.
> 
> Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Tested-by: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/leds/led-triggers.c              | 16 ++++++++--------
>  drivers/leds/trigger/ledtrig-disk.c      |  9 +++------
>  drivers/leds/trigger/ledtrig-mtd.c       |  8 ++------
>  drivers/net/arcnet/arcnet.c              |  8 ++------
>  drivers/power/supply/power_supply_leds.c |  5 +----
>  drivers/usb/common/led.c                 |  4 +---
>  include/linux/leds.h                     | 16 ++++++++--------
>  net/mac80211/led.c                       |  2 +-
>  net/mac80211/led.h                       |  8 ++------
>  net/netfilter/xt_LED.c                   |  3 +--
>  10 files changed, 29 insertions(+), 50 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
