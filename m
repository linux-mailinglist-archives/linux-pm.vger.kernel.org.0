Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF55249F9
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352062AbiELKIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbiELKIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 06:08:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C553B41
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 03:08:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1np5jv-0002y7-Ao; Thu, 12 May 2022 12:08:11 +0200
Message-ID: <6918b1a7ba401cd4db2db0601137766acd93bc63.camel@pengutronix.de>
Subject: Re: [PATCH v1] thermal: imx: Update critical temp threshold
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pm@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 12 May 2022 12:08:08 +0200
In-Reply-To: <20220512073600.GA36153@francesco-nb.int.toradex.com>
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
         <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
         <20220512073600.GA36153@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Donnerstag, dem 12.05.2022 um 09:36 +0200 schrieb Francesco Dolcini:
> Hello Daniel, Sasha, Shawn and all
> 
> On Mon, May 09, 2022 at 11:55:20AM +0200, Daniel Lezcano wrote:
> > On 20/04/2022 11:13, Francesco Dolcini wrote:
> > > Increase the critical temperature threshold to the datasheet defined
> > > value according to the temperature grade of the SoC, increasing the
> > > actual critical temperature value of 5 degrees.
> > > 
> > > Without this change the emergency shutdown will trigger earlier then
> > > required affecting applications that are expected to be working on this
> > > close to the limit, but yet valid, temperature range.
> > > 
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > > 
> > > Not sure if there is an alternative to this patch, the critical threshold seems
> > > to be read-only and it is not possible to just change it from user space that
> > > would be my preferred solution.
> > > 
> > > According to the original discussion [1] the reasoning was the following:
> > > 
> > > On Tue, Jul 28, 2015 at 4:50 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> > > > Yes - the purpose of lowering the critical threshold from the hardware
> > > > default is to allow Linux to shutdown more cleanly.
> > > 
> > > But I do not understand it.
> > 
> > Shawn, Sascha ? any comment ?
> 
> Just one small addition, we (Toradex) are using this modified critical
> threshold since quite some time, on multiple i.MX[67]* SOC, and we
> regularly run stress tests on commercial/IT part on the whole
> temperature working range (ambient temperature up to 85 degrees for IT
> modules) in climate chambers and I'm not aware of any issue reported
> because of that (indeed, it is the other way around, without this change
> we had issues).

That is really an overall system design issue. Most chips will probably
work fine when going over the critical temperature, as this is mostly
set due to device lifetime constraints, not because the chip fails at
this temperature. However the chip is only guaranteed to work at up to
the critical temperature, so one could argue that starting a orderly
shutdown when the critical temperature is reached is already too late,
as the temperature may rise further during the time taken to shut down
the system. Also device leakage increases a lot at those critical
temperatures, so the system may fail not because the chip is
malfunctioning, but the board power supply may not be able to supply
the increased current required.

Really I think there is no right or wrong here. I believe that this
needs to be up to the system integrator, so the critical temperature
should be writable by userspace in the constraints set by the fuses.

Regards,
Lucas

