Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF8433680
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhJSNBs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbhJSNBs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 09:01:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7540C061745
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 05:59:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mcoiI-0006Gy-V5; Tue, 19 Oct 2021 14:59:30 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mcoiH-0008NO-5k; Tue, 19 Oct 2021 14:59:29 +0200
Date:   Tue, 19 Oct 2021 14:59:29 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pm@vger.kernel.org, Petr Benes <petrben@gmail.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] thermal: imx: implement runtime PM support
Message-ID: <20211019125929.GD16320@pengutronix.de>
References: <20210924115032.29684-1-o.rempel@pengutronix.de>
 <19b2ab33-aa56-75fb-f6ef-3c928be9c50c@linaro.org>
 <20211019115151.GC16320@pengutronix.de>
 <df3f527d-22f3-b58d-a546-bdd8d312505c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df3f527d-22f3-b58d-a546-bdd8d312505c@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:55:40 up 243 days, 16:19, 139 users,  load average: 0.15, 0.13,
 0.16
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 01:55:32PM +0200, Daniel Lezcano wrote:
> On 19/10/2021 13:51, Oleksij Rempel wrote:
> > Hi Daniel,
> > 
> > On Tue, Oct 19, 2021 at 01:04:46PM +0200, Daniel Lezcano wrote:
> >> On 24/09/2021 13:50, Oleksij Rempel wrote:
> >>> Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
> >>> data to decide whether to run a measurement") this driver stared using
> >>> irq_enabled flag to make decision to power on/off the thermal core. This
> >>> triggered a regression, where after reaching critical temperature, alarm
> >>> IRQ handler set irq_enabled to false,  disabled thermal core and was not
> >>> able read temperature and disable cooling sequence.
> >>>
> >>> In case the cooling device is "CPU/GPU freq", the system will run with
> >>> reduce performance until next reboot.
> >>>
> >>> To solve this issue, we need to move all parts implementing hand made
> >>> runtime power management and let it handle actual runtime PM framework.
> >>>
> >>> Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether to run a measurement")
> >>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >>
> >> Thanks for this fix.
> >>
> >> Petr or Oleksij,
> >>
> >> could you confirm it is tested and working without CONFIG_PM ?
> > 
> > Petr was right, no it is not working without PM.
> Ok, thanks.
> 
> I suppose the fix is related to the initialization of the sensor which
> should be enabled with/out pm_runtime, right ?

No, i did sanity check on pm_runtime_put() within the probe. Without PM
it will properly return ENOSYS, so I aborted the probe. Looks like I
should ignore return value on this function like every driver is doing
it.

> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
