Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655BD349387
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCYOCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 10:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhCYOBb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 10:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB71F61A28;
        Thu, 25 Mar 2021 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616680891;
        bh=7gpGwW7zWwBlxxPi/YrFGrbB+rkLfxEn9Nm7IEI6HwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMFTfngtyRCeteMDU9ujJJ5fPk8B9BFtkSXKm7e6tBWveqiycT5OuwudcrmosaqHn
         9KPH3B/d3giL+V0WhfSlOEoRXr1SCVo4lbEo4g4+3xmpqq28bWrSEXQjeeyYltsizG
         OVXJhKTlgkesmmfiNIqScm5JWNAPAraBQshY0MN0=
Date:   Thu, 25 Mar 2021 15:01:28 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>
Subject: Re: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init
 fails
Message-ID: <YFyXuELPizzOjcVg@kroah.com>
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <1860d4e8-2e3a-fe05-cab9-782f3e35b9ab@redhat.com>
 <CGME20210324095118epcas1p1ea1cb42f8341bbb972f591d9f5a63695@epcas1p1.samsung.com>
 <58298d5bdd026a492e4fa2ad6de25720c66710ff.camel@fi.rohmeurope.com>
 <b465d250-3933-91ce-a686-f158ca3d0a53@samsung.com>
 <86d41fc6a9d2640d3f7fb749cc0fbfa2cd2736fb.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d41fc6a9d2640d3f7fb749cc0fbfa2cd2736fb.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 25, 2021 at 04:52:12AM +0000, Vaittinen, Matti wrote:
> 
> On Thu, 2021-03-25 at 09:49 +0900, Chanwoo Choi wrote:
> > On 3/24/21 6:51 PM, Vaittinen, Matti wrote:
> > > Hello Hans, Chanwoo, Greg,
> > > 
> > > On Wed, 2021-03-24 at 10:25 +0100, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 3/24/21 10:21 AM, Matti Vaittinen wrote:
> > > > > Add error print for probe failure when resource managed work-
> > > > > queue
> > > > > initialization fails.
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <
> > > > > matti.vaittinen@fi.rohmeurope.com>
> > > > > Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > > > ---
> > > > >  drivers/extcon/extcon-gpio.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/extcon/extcon-gpio.c
> > > > > b/drivers/extcon/extcon-
> > > > > gpio.c
> > > > > index 4105df74f2b0..8ea2cda8f7f3 100644
> > > > > --- a/drivers/extcon/extcon-gpio.c
> > > > > +++ b/drivers/extcon/extcon-gpio.c
> > > > > @@ -114,8 +114,10 @@ static int gpio_extcon_probe(struct
> > > > > platform_device *pdev)
> > > > >  		return ret;
> > > > >  
> > > > >  	ret = devm_delayed_work_autocancel(dev, &data->work,
> > > > > gpio_extcon_work);
> > > > > -	if (ret)
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to initialize
> > > > > delayed_work");
> > > > >  		return ret;
> > > > > +	}
> > > > 
> > > > The only ret which we can have here is -ENOMEM and as a rule we
> > > > don't
> > > > log
> > > > errors for those, because the kernel memory-management code
> > > > already
> > > > complains
> > > > loudly when this happens.
> > > 
> > > I know. This is why I originally omitted the print. Besides, if the
> > > memory is so low that devres adding fails - then we probably have
> > > plenty of other complaints as well... But as Chanwoo maintains the
> > > driver and wanted to have the print - I do not have objections to
> > > that
> > > either. Maybe someone some-day adds another error path to wq
> > > initialization in which case seeing it failed could make sense.
> > > 
> > > > So IMHO this patch should be dropped.
> > > Fine for me - as well as keeping it. I have no strong opinion on
> > > this.
> > 
> > If it is the same handling way for -ENOMEM, don't need to add log ss
> > Hans said. 
> > Thanks for Hans.
> 
> So be it :)
> Greg, can you just apply the patch 2/2 and drop this one? (There should
> be no dependency between these) or do you want me to resend 2/2 alone?

I'll just take the 2/2 patch, thanks.

greg k-h
