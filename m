Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F157080E3
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjERMNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERMNT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 08:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E485186;
        Thu, 18 May 2023 05:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C36564ADE;
        Thu, 18 May 2023 12:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D78C433EF;
        Thu, 18 May 2023 12:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684411998;
        bh=bNE3a8+8j3b+iCKw7mB1aKhpPajasE3pkDjruBxK0DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BY4YmgU5mDlsjVger5nDRq+IjH3B/nAuk28ANc1ySLtWNl/ev2V2lTSrnA/d8pcY4
         xwi9n4tc58W33W7qM1zKIcGxJ/Nc5h+E10Wfd3so2s171qKBOe9zNP5Ion7qJAs9g1
         ZTRiGmZzgUoduLrh6t37eUwvwN+e23c9PnQ0UuT74zZYAd7PX1vIdsrjbv3Kq/nbfJ
         pr6DxmLa37waoqtTl7PJUqeEmehDYkOWKl/kPB1bnqOw/WcnkmaCv4HZED99twQ3KQ
         uKAbXo0lVNzdyb6YLFrQ5uSTELzGjUZY5FhvXUMP3GbpZId0UmhzHSRvN0SE5Cu48j
         Cp8W4qkund0xw==
Date:   Thu, 18 May 2023 13:13:11 +0100
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
Subject: Re: [PATCH RESEND 2/4] leds: Fix set_brightness_delayed() race
Message-ID: <20230518121311.GH404509@google.com>
References: <20230510162234.291439-1-hdegoede@redhat.com>
 <20230510162234.291439-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162234.291439-3-hdegoede@redhat.com>
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

> When a trigger wants to switch from blinking to LED on it needs to call:
> 	led_set_brightness(LED_OFF);
> 	led_set_brightness(LED_FULL);
> 
> To first call disables blinking and the second then turns the LED on
> (the power-supply charging-blink-full-solid triggers do this).
> 
> These calls happen immediately after each other, so it is possible
> that set_brightness_delayed() from the first call has not run yet
> when the led_set_brightness(LED_FULL) call finishes.
> 
> If this race hits then this is causing problems for both
> sw- and hw-blinking:
> 
> For sw-blinking set_brightness_delayed() clears delayed_set_value
> when LED_BLINK_DISABLE is set causing the led_set_brightness(LED_FULL)
> call effects to get lost when hitting the race, resulting in the LED
> turning off instead of on.
> 
> For hw-blinking if the race hits delayed_set_value has been
> set to LED_FULL by the time set_brightness_delayed() runs.
> So led_cdev->brightness_set_blocking() is never called with
> LED_OFF as argument and the hw-blinking is never disabled leaving
> the LED blinking instead of on.
> 
> Fix both issues by adding LED_SET_BRIGHTNESS and LED_SET_BRIGHTNESS_OFF
> work_flags making this 2 separate actions to be run by
> set_brightness_delayed().
> 
> Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Tested-by: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/leds/led-core.c | 57 +++++++++++++++++++++++++++++++----------
>  include/linux/leds.h    |  3 +++
>  2 files changed, 47 insertions(+), 13 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
