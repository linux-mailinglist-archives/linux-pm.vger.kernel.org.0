Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083E7080F1
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjERMOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjERMOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 08:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9F10A;
        Thu, 18 May 2023 05:14:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C338B64EDA;
        Thu, 18 May 2023 12:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136C1C433EF;
        Thu, 18 May 2023 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684412073;
        bh=iq2R9rcAYaIytt+OyDd3kwA4on0rvzXiK7CMKrCwPAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtN/LR+q1aCzoSoh8MqKoe6JpvHWBsTUKbWwbtZ8rrRqJNZEo1ifR7FxU23Q8HjgM
         aX2WFqZpRO3Sz5c0Ol3rhL68mq9WdPfWsx8A95WlPg0Yrv6jaXoFe/v4+qpsq1zxmY
         Je+/Q2kQweYkFBeq7fLgRMiA4spei/HyPBSiR2mtK9kV5SJCM77MoWCdyMHH6v9TyC
         zTjR6/lLqHYq8QzuXYZ8zO8XAGD7IvtY8kACaDSAfH5QMlgfnQpDL76Q1TIsTJKknq
         naoeCajuP/xvTEXXS4Lw7JikuIV8HSijqMueUJbJcwLPVaU/7H6nKh8Qv+LQKsdtS5
         VdAlgWn3LJZBg==
Date:   Thu, 18 May 2023 13:14:26 +0100
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
Subject: Re: [PATCH RESEND 4/4] leds: Clear LED_INIT_DEFAULT_TRIGGER when
 clearing current trigger
Message-ID: <20230518121426.GJ404509@google.com>
References: <20230510162234.291439-1-hdegoede@redhat.com>
 <20230510162234.291439-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162234.291439-5-hdegoede@redhat.com>
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

> Not all triggers use LED_INIT_DEFAULT_TRIGGER, which means that it
> will not get cleared when the default trigger is a trigger which
> does not use it such as "default-on".
> 
> If the default trigger then later gets replaced by a trigger which
> does check LED_INIT_DEFAULT_TRIGGER, such as "timer" then that trigger
> will behave as if it is the default trigger which it should not do.
> 
> To fix this clear the LED_INIT_DEFAULT_TRIGGER flag when clearing
> the current trigger, so that it will not be set for any subsequently
> set (non default) triggers.
> 
> Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Tested-by: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/leds/led-triggers.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
