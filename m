Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62F7AE818
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjIZIbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 04:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjIZIbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 04:31:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017FB4;
        Tue, 26 Sep 2023 01:31:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53FC433C8;
        Tue, 26 Sep 2023 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695717071;
        bh=ZCDxwsZyOwa+nNRDkbNfSAVg8HokBeANzu0Swgv6opY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cge+92kI0dsZabKHFLZ7vaYhSSVwlhRsKDNkmuS8fSubucaBuPnayEYn7Gw5ObFnr
         EdJ7Fv0sBBbKM7DzxN7PLL90HD0RsXzni+lMO7qJiK80teQIp1r9fdskeSka7s1Aqr
         AeFX/VHPBHJ3Qp26UJ83CWhGe3CdgdWu0g6TTiZFFrnBX6X9yQeCgGtpNRy+5j0i40
         aRAT8YvCQwELWlPjFFGjVUoEP0tATtqBoOIfyd8sJi7Cvztsk6oVqOnxAH1HcAnDJx
         M7Mrsp6PZ0iHgGyBTVLKaLLv/Dc+T2DaeJ17mEcpsu813Ssi7fStaXtGCiyt75BgCG
         f+B6T3iz7D1Ng==
Date:   Tue, 26 Sep 2023 09:31:06 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] backlight: pwm_bl: Disable PWM on shutdown and suspend
 disabled PWM emiting inactive state")
Message-ID: <20230926083106.GE9999@google.com>
References: <DB9PR04MB84779AF9758B7FE747C6693D80869@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <20230322070352.xfwmnqyrao3mifuu@pengutronix.de>
 <DB9PR04MB8477FD24740251860648786380869@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <20230322085129.jxxz55tbcxkc6usd@pengutronix.de>
 <20230926071744.oikg3ndaq6x7yjrw@pengutronix.de>
 <20230926083015.GD9999@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926083015.GD9999@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 26 Sep 2023, Lee Jones wrote:

> On Tue, 26 Sep 2023, Uwe Kleine-König wrote:
> 
> > Hello,
> > 
> > On Wed, Mar 22, 2023 at 09:51:29AM +0100, Uwe Kleine-König wrote:
> > > Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> > > per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> > > the PWM any more. However this is necessary to suspend, because PWM
> > > drivers usually refuse to suspend if they are still enabled.
> > > 
> > > Also adapt shutdown to disable the PWM for similar reasons.
> > > 
> > > Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backlight toggle")
> > > Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > This patch was never applied but I think it is still needed. I assume it
> > fell through the cracks?
> 
> This "patch" was sent half way through a thread and when opened in my
> mail client looks like a mail reply due to the quotes below the '---'.
> 
> I'd suggest sending this again.

You also have a copy/paste error in the subject line.

-- 
Lee Jones [李琼斯]
