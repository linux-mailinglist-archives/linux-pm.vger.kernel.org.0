Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23560D20
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfGEVZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 17:25:01 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58063 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfGEVZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 17:25:01 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5B1981C0003;
        Fri,  5 Jul 2019 21:24:48 +0000 (UTC)
Date:   Fri, 5 Jul 2019 23:24:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: Re: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Message-ID: <20190705212448.GB12409@piout.net>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-4-frank-w@public-files.de>
 <20190704204336.GJ3692@piout.net>
 <trinity-7b1977bd-252b-4482-b708-cf704a9d3da1-1562340946396@3c-app-gmx-bs68>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-7b1977bd-252b-4482-b708-cf704a9d3da1-1562340946396@3c-app-gmx-bs68>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/07/2019 17:35:46+0200, Frank Wunderlich wrote:
> Hi Alexander,
> 
> thank you for the Review
> 
> > Gesendet: Donnerstag, 04. Juli 2019 um 22:43 Uhr
> > Von: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
> > > -	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
> > > -	if (IS_ERR(rtc->rtc_dev))
> > > -		return PTR_ERR(rtc->rtc_dev);
> > > +	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> > > +					mtk_rtc_irq_handler_thread,
> > > +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > > +					"mt6397-rtc", rtc);
> > >
> >
> > This change may lead to a crash and the allocation was intentionally
> > placed before the irq request.
> 
> i got no crash till now, but i will try to move the allocation before irq-request
> 

Let's say the RTC has been used to start your platform, then the irq
handler will be called as soon as the irq is requested, leading to a
null pointer dereference.

> > > -	ret = request_threaded_irq(rtc->irq, NULL,
> > > -				   mtk_rtc_irq_handler_thread,
> > > -				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > > -				   "mt6397-rtc", rtc);
> > >  	if (ret) {
> > >  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> > >  			rtc->irq, ret);
> > > @@ -287,6 +281,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> > >
> > >  	device_init_wakeup(&pdev->dev, 1);
> > >
> > > +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> > > +	if (IS_ERR(rtc->rtc_dev))
> > > +		return PTR_ERR(rtc->rtc_dev);
> > > +
> > >  	rtc->rtc_dev->ops = &mtk_rtc_ops;
> 
> 
> > >  static const struct of_device_id mt6397_rtc_of_match[] = {
> > > +	{ .compatible = "mediatek,mt6323-rtc", },
> >
> > Unrelated change, this is not an improvement and must be accompanied by
> > a documentation change.
> 
> documentation is changed in 1/7 defining this compatible. i called it improvement because existing driver now supports another chip
> 

Yes and IIRC, I did comment that the rtc change also had to be separated
from 1/7.

Also, I really doubt this new compatible is necessary at all as you
could simply directly use mediatek,mt6397-rtc.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
