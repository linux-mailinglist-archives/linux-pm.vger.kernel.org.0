Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334E31841A9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCMHrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 03:47:39 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52643 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgCMHrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 03:47:39 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id CE83E100010;
        Fri, 13 Mar 2020 07:47:34 +0000 (UTC)
Date:   Fri, 13 Mar 2020 08:47:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Ran Bi <ran.bi@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v10 4/5] rtc: mt6397: Add support for the MediaTek MT6358
 RTC
Message-ID: <20200313074734.GD3384@piout.net>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1583918223-22506-5-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20200312074407.GA3142@dell>
 <1584003477.6269.8.camel@mhfsdcap03>
 <20200313072230.GC3142@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313072230.GC3142@dell>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/03/2020 07:22:30+0000, Lee Jones wrote:
> > > >  struct mt6397_rtc {
> > > >  	struct device           *dev;
> > > >  	struct rtc_device       *rtc_dev;
> > > > @@ -74,6 +80,7 @@ struct mt6397_rtc {
> > > >  	struct regmap           *regmap;
> > > >  	int                     irq;
> > > >  	u32                     addr_base;
> > > > +	const struct mtk_rtc_data *data;
> > > 
> > > 'data' is a terrible variable name.
> > > 
> > > Why do you need to store this?
> > > 
> > > It's one variable which is used once AFAICT.
> > 
> > I would rename 'data' to 'config'.
> > 
> > This struct will be extended in future patches to achieve more PMIC chip
> > compatibility.
> 
> On closer inspection, it looks like wrtgr (also not a great name for a
> variable by the way) is a register address.  Is that correct?
> Initially I thought it was a model number, which would have been a
> suitable candidate for entry into OF .data.
> 
> However, describing register addresses in OF .data does not sound like
> good practice.  It is usually used to identify a platform in the cases
> where platforms cannot be otherwise dynamically interrogated for model
> number via a register read.
> 
> Describing register maps via 'config' data is a slippery slope.

I'm not sure I get what you mean, there are dozens if not hundreds of
drivers doing it exactly that way. What is the difference between having
.data pointing to a register map and having .data containing a model
number and then use that model number to get the register map?

of_device_id::data definitively isn't config data as the DT describes
the hardware, not the configuration.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
