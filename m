Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F420B6FE794
	for <lists+linux-pm@lfdr.de>; Thu, 11 May 2023 00:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjEJWxS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 May 2023 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJWxS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 May 2023 18:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418E3A8E;
        Wed, 10 May 2023 15:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F2361486;
        Wed, 10 May 2023 22:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEF6C433EF;
        Wed, 10 May 2023 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683759196;
        bh=0SZCsJwaN3AewUnoK7ahUFPcOXKKisj7UKcNsbIMmPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQc6WYHRDg0MBsZEyfCJ+vnkMjJlaVGOEx3mwuGtVdl5YOeoVKISE+iU91Kis8YeS
         oiuGG6EB+L8X4l2LTlLW4tSagbRG6Euq8Qsedz3o1mAtfEDf1SBV4tgBd5gSPpMDG5
         vIrRC4772kxNLYeCzjZ9oQoZU2ydqNJS6DFET+TE=
Date:   Thu, 11 May 2023 07:53:09 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
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
Message-ID: <2023051102-reseller-oat-3566@gregkh>
References: <20230510162234.291439-1-hdegoede@redhat.com>
 <20230510162234.291439-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510162234.291439-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 10, 2023 at 06:22:31PM +0200, Hans de Goede wrote:
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
