Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02F1189D5B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCRNuz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 09:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgCRNuz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 09:50:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79A020767;
        Wed, 18 Mar 2020 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584539454;
        bh=9zcXYLKK5Dhr/+f1z2OMEWB6HxFE4z3Xgg7sGJiZW8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xzl7WDy28mpXrKG2uuW9mWQWA6nDhybZpFEgynuX461hV6NyJmhE1pNlCmk69rfaW
         FfhPC4crTBVLVlo4RJthEex5J1bu7XOcWh43uQA8WZnkPViZpYyossDRHrbsGrjRaM
         lej9sKAIAKQVVgnpS6YCq5WXpAKLgH2POgcb/NAg=
Date:   Wed, 18 Mar 2020 14:50:52 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 3/9] drivers: base: add linear ranges helpers
Message-ID: <20200318135052.GA2804430@kroah.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
 <01ac2439f9d33ae405999065c5d28c368bad4a28.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
 <20200318130838.GB2769584@kroah.com>
 <910505f6a38298707fc27b135e49a7e2a941fb88.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910505f6a38298707fc27b135e49a7e2a941fb88.camel@fi.rohmeurope.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 18, 2020 at 01:42:26PM +0000, Vaittinen, Matti wrote:
> Hello Greg,
> 
> On Wed, 2020-03-18 at 14:08 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 25, 2020 at 10:53:01AM +0200, Matti Vaittinen wrote:
> > > Many devices have control registers which control some measurable
> > > property. Often a register contains control field so that change in
> > > this field causes linear change in the controlled property. It is
> > > not
> > > a rare case that user wants to give 'meaningful' control values and
> > > driver needs to convert them to register field values. Even more
> > > often user wants to 'see' the currently set value - again in
> > > meaningful units - and driver needs to convert the values it reads
> > > from register to these meaningful units. Examples of this include:
> > > 
> > > - regulators, voltage/current configurations
> > > - power, voltage/current configurations
> > > - clk(?) NCOs
> > > 
> > > and maybe others I can't think of right now.
> > > 
> > > Provide a linear_range helper which can do conversion from user
> > > value
> > > to register value 'selector'.
> > > 
> > > The idea here is stolen from regulator framework and patches
> > > refactoring
> > > the regulator helpers to use this are following.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > > 
> > > Changes since rfc-v3:
> > >   - Kerneldoc fixes
> > >   - Corrected commit message typo meaningfull => meaningful
> > > 
> > >  drivers/base/Kconfig         |   3 +
> > >  drivers/base/Makefile        |   1 +
> > >  drivers/base/linear_ranges.c | 246
> > > +++++++++++++++++++++++++++++++++++
> > 
> > Why in drivers/base/ ?
> > 
> > Why not in lib/ ?
> 
> I was pondering which of these would be better. I decided to do with
> drivers/base because - in it's current form - this is really a driver
> related stuff. I see it somehow in same position as regmap code -
> although this is just a tiny helper compared to regmap. But this also
> has pretty driver specific audience :)
> 
> And... I must admit I like things which I know. And I have been doing
> driver development and "know" a few of the driver related colleagues -
> hence working with them is easier for me ;) Getting to know the
> colleagues maintaining lib is a bit scary :] Yep, I'm Finnish if you
> happen to wonder why getting to know people is scary xD
> 
> > 
> > >  include/linux/linear_range.h |  48 +++++++
> > >  4 files changed, 298 insertions(+)
> > >  create mode 100644 drivers/base/linear_ranges.c
> > >  create mode 100644 include/linux/linear_range.h
> > > 
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > > index 5f0bc74d2409..636b6fa8e499 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -209,4 +209,7 @@ config GENERIC_ARCH_TOPOLOGY
> > >  	  appropriate scaling, sysfs interface for reading capacity
> > > values at
> > >  	  runtime.
> > >  
> > > +config LINEAR_RANGES
> > > +	tristate
> > 
> > No help text at all???
> 
> Yes. The linear ranges has no meaning to be enabled alone. It only
> plays a role if it is used by some driver/subsystem. And
> drivers/subsystems should do
> select LINEAR_RANGES. So showing help in any config tool is not needed.
> This should actually not be visible in menuconfig or others. I think I
> have seen a few examples like this.
> 
> Ayways, I have no obejctions to adding some text if absolutely needed.
> Any suggestions for a text politely saying - "please, pretend I am not
> here" - are welcome :) (Although, I think this really does not need
> help text).

This kind of implies it needs to be in lib/ that way the needed code
links it and all should be fine.

thanks,

greg k-h
