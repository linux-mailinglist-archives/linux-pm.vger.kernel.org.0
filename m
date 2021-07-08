Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52CF3C1B85
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGHWnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 18:43:16 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:61645 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGHWnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 18:43:15 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 18:43:15 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GLWJn47tgzTS;
        Fri,  9 Jul 2021 00:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1625783577; bh=aSRPhRNGkFjEWLH2kg/7j89z1gCsuMcB8R59/oKF8I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdcfHB95JZvOq9AwYo66uRnlaRCmz91L8Cj5IBH0eXUke32R+PvFPcm9toZQMM95N
         /Y1gk1nfN/MyGCcH8tOzDn5CPBgAbfJUuhxi8Hgfdj4287vlB1Uy55dz8kuI3ru4zE
         nPwcHhb+5U8xxrys8VlQTA4haGyH+2Hf5MXA7XBFkk/whZRjfgWRInFjZ6AkyXa6O6
         tJHBNGGyUq9mGtzeAelqMxVyajw9fLe9JC7Su0DM9J06GugR2q4CbIywIP8HFx2/Tz
         r1+1EjF/z+UP4xoMK1xsPiL/43cmyUwSWpAV1vmSVw8blvRcxefhWqJCG7vg1W6LC1
         fzlGVc5wXAiWA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Fri, 9 Jul 2021 00:32:56 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 04/12] usb: phy: tegra: Support OTG mode programming
Message-ID: <YOd9GE7xM150i1XT@qmqm.qmqm.pl>
References: <20210701022405.10817-1-digetx@gmail.com>
 <20210701022405.10817-5-digetx@gmail.com>
 <12f5b8cc-982e-f112-e0a4-21afdf3bce06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12f5b8cc-982e-f112-e0a4-21afdf3bce06@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 01, 2021 at 04:55:03PM +0300, Dmitry Osipenko wrote:
> 01.07.2021 05:23, Dmitry Osipenko пишет:
> >  static int tegra_usb_phy_init(struct usb_phy *u_phy)
> > @@ -967,12 +1057,26 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
> >  			goto disable_vbus;
> >  	}
> >  
> > +	err = tegra_usb_phy_configure_pmc(phy);
> > +	if (err)
> > +		goto close_phy;
> > +
> >  	err = tegra_usb_phy_power_on(phy);
> >  	if (err)
> >  		goto close_phy;
> >  
> > +	if (phy->irq > 0) {
> > +		err = request_irq(phy->irq, tegra_usb_phy_isr, IRQF_SHARED,
> > +				  dev_name(phy->u_phy.dev), phy);
> > +		if (err)
> > +			goto pwr_off_phy;
> > +	}
> 
> There were reports that this patch was casing an unhandled USB interrupt
> event on some devices. I thought this problem was fixed already, but
> looking again at the offending kernel log again, it still should be a
> problem.
> 
> The interrupt fires from the usb_add_hcd() of the CI driver before CI
> driver have requested interrupt in ci_hdrc_probe(). So either CI driver
> should request interrupt earlier or Tegra PHY driver should keep shared
> interrupt disabled after requesting it, the latter variant should be
> more robust. I'll improve it in v2.

I'd suggest the first solution, as the latter is a workaround for what
is a normal shared interrupt behaviour. Maybe a controller reset is
needed in CI driver before going on with PHY init?

Best Regards
Michał Mirosław
