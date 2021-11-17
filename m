Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE14544E4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 11:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhKQK10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 05:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhKQK1Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 05:27:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19219C061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 02:24:27 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mnI75-0007i3-9v; Wed, 17 Nov 2021 11:24:23 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mnI70-0000k2-Ab; Wed, 17 Nov 2021 11:24:18 +0100
Date:   Wed, 17 Nov 2021 11:24:18 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Petr Benes <petrben@gmail.com>
Cc:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] thermal: imx: implement runtime PM support
Message-ID: <20211117102418.GA29712@pengutronix.de>
References: <20211019130809.21281-1-o.rempel@pengutronix.de>
 <20211020050459.GE16320@pengutronix.de>
 <CAPwXO5b=z1nhQCo55A_XuK-Es2o7TrL2Vj6AkRSXa3Wxh0s8sA@mail.gmail.com>
 <20211021172048.GE2298@pengutronix.de>
 <CAPwXO5bWoAvZgQLQHa6CsFmZ2bcUQ9pJQBBL3F+goppMeAKkFQ@mail.gmail.com>
 <8692108c-1b46-3d3d-6911-300ac27c2980@ysoft.com>
 <20211111091627.GG12195@pengutronix.de>
 <CAPwXO5anM809k+wuSYU9LR9vLAyutaMNo6kceCHOZHPmZUbnUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwXO5anM809k+wuSYU9LR9vLAyutaMNo6kceCHOZHPmZUbnUw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:23:01 up 272 days, 13:46, 142 users,  load average: 0.00, 0.06,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 15, 2021 at 04:02:07PM +0100, Petr Benes wrote:
> Hi Oleksij,
> 
> On Thu, 11 Nov 2021 at 10:16, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > On Wed, Nov 10, 2021 at 11:07:31AM +0100, Michal Vokáč wrote:
> > > On 25. 10. 21 13:06, Petr Benes wrote:
> > > > Hi Oleksij,
> > > >
> > > > On Thu, 21 Oct 2021 at 19:21, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > > >
> > > > > Hi Petr,
> > > > >
> > > > > On Wed, Oct 20, 2021 at 05:53:03PM +0200, Petr Benes wrote:
> > > > > > On Wed, 20 Oct 2021 at 07:05, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > > > > >
> > > > > > > Hi Petr and Michal,
> > > > > > >
> > > > > > > I forgot to add you for v2 in CC. Please test/review this version.
> > > > > >
> > > > > > Hi Oleksij,
> > > > > >
> > > > > > It works good. with PM as well as without PM. The only minor issue I found is,
> > > > > > that the first temperature reading (when the driver probes) fails. That is
> > > > > > (val & soc_data->temp_valid_mask) == 0) holds true. How does
> > > > > > pm_runtime_resume_and_get() behave in imx_thermal_probe()?
> > > > > > Does it go through imx_thermal_runtime_resume() with usleep_range()?
> > > > >
> > > > > How exactly did you reproduce it? Even more or less understanding how
> > > >
> > > > I just placed my debug print into get_temp()
> > > >
> > > >      if ((val & soc_data->temp_valid_mask) == 0) {
> > > >          dev_dbg(&tz->device, "temp measurement never finished\n");
> > > >          printk("Wrong temperature reading!!!!!!\n");
> > > >          return -EAGAIN;
> > > >      }
> > > >
> > > > > this can potentially happen, i never had this issue on my HW. Is it something
> > > > > HW specific?
> > > >
> > > > IMHO it is just product of the following sequence:
> > > >
> > > > pm_runtime_set_active(&pdev->dev);
> > > > pm_runtime_enable(data->dev);
> > > > pm_runtime_resume_and_get(data->dev);
> > > > thermal_zone_device_enable(data->tz);
> > > >
> > > > With assumption imx_thermal_runtime_resume() didn't run,
> > > > hence the sensor didn't get enough time to come up.
> > > >
> > > > I didn't have time to spend it on and you have better knowledge of the
> > > > area. If it is not that straightforward I can try to diagnose it better.
> > > >
> > > Hi Oleksij,
> > > Did you manage to further debug and reproduce this problem?
> > > Do you plan to send the v3?
> > >
> > > Regarding your question about the HW - this problem occured once we
> > > upgraded the SoC on our SBC from i.MX6DL to i.MX6Q/QP. With the DualLite
> > > we never had this problem but the Quad is getting hot quite fast.
> > > We have pretty limited cooling options so the core is operated at its
> > > upper temperature limits when fully loaded.
> >
> > Hi Michal,
> >
> > Sorry, I was busy and lost this topic from my radar. I was not able to
> > reproduce it on my i.MX6Q and i.MX6QP died after other thermal voltage
> > experiments. Please, if you able to reproduce it, try to investigate
> > what is wrong, for example increasing wakeup time and/or and tracing
> > sleap/wake/get sequences.
> 
> Seems it is just as easy as calling usleep_range(20, 50) when you switch on
> the sensor and enable temperature measurement in imx_thermal_probe().
> So, we are sure the sensor is configured and _ready_.
> 
> You call pm_runtime_set_active(), pm_runtime_enable(), and
> pm_runtime_resume_and_get(). The last one doesn't call the resume
> callback (which correctly handles waiting for the sensor) as the device
> is already active.

Ok, thx! It makes sense. I'll send new version with the fix.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
