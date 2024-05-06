Return-Path: <linux-pm+bounces-7545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E127C8BD40D
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 19:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C901F21F11
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66A157A45;
	Mon,  6 May 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gXbYAIfe"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C51D52C;
	Mon,  6 May 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017699; cv=none; b=Aa9PbjIUgkoIwD0t1B9VzW26HeXGvbJdVtfYRmnsj2rl2UYAdfAo5MPolsJotpJeYy4msfq9csm9i7lp156STeWttmXxZ7po/pR6m2jpJ8FBW9/GGK/UDVbvn3YoEjbJV8J8KDbJMq9UbpC0h0wD3gHNazo/qKUhC2JmtQgaLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017699; c=relaxed/simple;
	bh=MvU5sKTnLEckHFjZCqkxY/lmg1E8y33V8+9lLbUc2Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCvTkI44hmEpE7ER9fw/FDJLw5GXLjLWIWxysk1AdhzKfp/XRaTX6gEQSJ2MiqFduiPWoI7YWFZavFW+PL8ElnPvobDOGSmqCpOcGnxRcW9R2HSZSEMmFwDEt6Zewz75yp0fqQxAr4l3xUYRNWHBXPx4ZE/6PLJ6oj0Ad4uFu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gXbYAIfe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715017695;
	bh=MvU5sKTnLEckHFjZCqkxY/lmg1E8y33V8+9lLbUc2Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXbYAIfeiNBAdErnj8FDrF6BRufNDLS5Sy2vaGpljGRCAJ2kRHckgsEAcrqJcZEfl
	 bt6LFheWca1yJbPM5sMNaqlAKpFN7xuoBeQZGGd+m/QDRj53JMV85P9WazbjSxkds+
	 YbB5YliGBGgW8lRpfM36XlLtPLMqFmmmbJg0aaFo=
Date: Mon, 6 May 2024 19:48:14 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, "Dustin L. Howett" <dustin@howett.net>, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_framework_laptop: introduce
 driver
Message-ID: <7dab7267-a5f2-4b03-bb45-92b836e42c28@t-8ch.de>
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
 <20240505-cros_ec-framework-v1-1-402662d6276b@weissschuh.net>
 <84c58078-93a4-406a-8abb-9054854e54a0@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84c58078-93a4-406a-8abb-9054854e54a0@amd.com>

On 2024-05-06 08:10:58+0000, Limonciello, Mario wrote:
> 
> 
> On 5/5/2024 3:56 PM, Thomas Weißschuh wrote:
> > Framework Laptops are using embedded controller firmware based on the
> > ChromeOS EC project.
> > In addition to the standard upstream commands, some vendor-specific
> > ones are implemented.
> > 
> > Add a driver for those custom EC commands.
> > 
> > At first, provide an empty driver that only takes care of scaffolding and
> > device binding.
> > Further patches will add functionality to the driver.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   MAINTAINERS                                        |  5 ++
> >   drivers/mfd/cros_ec_dev.c                          | 13 ++++++
> >   drivers/platform/chrome/Kconfig                    | 11 +++++
> >   drivers/platform/chrome/Makefile                   |  1 +
> >   drivers/platform/chrome/cros_ec_framework_laptop.c | 53 ++++++++++++++++++++++
> >   5 files changed, 83 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c23fda1aa1f0..60699c289757 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4988,6 +4988,11 @@ S:	Maintained
> >   F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> >   F:	sound/soc/codecs/cros_ec_codec.*
> > +CHROMEOS EC FRAMEWORK LAPTOP EXTENSIONS
> > +M:	Thomas Weißschuh <linux@weissschuh.net>
> > +S:	Maintained
> > +F:	drivers/platform/chrome/cros_ec_framework_laptop.c
> > +
> >   CHROMEOS EC SUBDRIVERS
> >   M:	Benson Leung <bleung@chromium.org>
> >   R:	Guenter Roeck <groeck@chromium.org>
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index a52d59cc2b1e..0a36e77e5039 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -145,6 +145,10 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
> >   	{ .name = "cros-ec-vbc", }
> >   };
> > +static const struct mfd_cell cros_ec_framework_cells[] = {
> > +	{ .name = "cros-ec-framework", }
> > +};
> > +
> >   static void cros_ec_class_release(struct device *dev)
> >   {
> >   	kfree(to_cros_ec_dev(dev));
> > @@ -299,6 +303,15 @@ static int ec_device_probe(struct platform_device *pdev)
> >   				 retval);
> >   	}
> > +	 /* The EC on Framework laptops implements some nonstandard features */
> 
> I don't think there is a spec really for cros_ec is there?  I think it will
> depend upon what features you're talking about if this is the right way to
> go.

I equate "standard" with "mainline".

> The reason I say this is that maybe some of the same kinds of features will
> make sense for chromebooks that use cros_ec in the future and thus they
> should be "generic" cros_ec mfd cells to probe for in some way.

The commands identifiers are just numbers.
So if multiple vendors use the same numbers there could be collisions.
By loading the subdriver only for the correct vendors devices we avoid those.

If other vendors or mainline CrOS EC implements the same commands we can
revisit this and move the functionality to a generic mfd cell.

But after the discussions on the cover letter, let's first see if a
vendor-specific driver is needed at all.

Thomas

