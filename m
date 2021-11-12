Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47044EC95
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhKLS3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 13:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhKLS3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 13:29:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16058C061767;
        Fri, 12 Nov 2021 10:26:10 -0800 (PST)
Date:   Fri, 12 Nov 2021 19:26:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636741567;
        bh=CPFRIMrKxEgVfLT6fVk9Aj/fKhPlm7UyGx3isHmuH5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJ8QWKrFciCuZjAcmyeorViUohQt0fiM1/eRMkWd3Kv7b7lZxWFxpbl15m3ooSqKQ
         yprkiLuRcq5wtuIwwJ2XyLqsIY7MmrzzO+qcsQ6R5HaPYUbnGoSb9ACttMwS8fli9H
         GzP77WQPXsPUSlVAKFXTm5coY6DOwSgVmoYBTBKg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, nicolopiazzalunga@gmail.com,
        linrunner@gmx.net, platform-driver-x86@vger.kernel.org,
        smclt30p@gmail.com
Subject: Re: [RFC v2] standardized attributes for powersupply charge behaviour
Message-ID: <c3c3cd24-d9a0-42d2-a532-65c46f003273@t-8ch.de>
References: <20211108192852.357473-1-linux@weissschuh.net>
 <20211112181042.jk63p5dm2ty3kxd5@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211112181042.jk63p5dm2ty3kxd5@earth.universe>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2021-11-12 19:10+0100, Sebastian Reichel wrote:
> On Mon, Nov 08, 2021 at 08:28:52PM +0100, Thomas Weißschuh wrote:
> > This a revised version of
> > "[RFC] add standardized attributes for force_discharge and inhibit_charge" [0],
> > incorporating discussion results.
> > 
> > The biggest change is the switch from two boolean attributes to a single
> > enum attribute.
> > 
> > [0] https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec29983d1@gmail.com/
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
> >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> >  include/linux/power_supply.h                |  7 +++++++
> >  3 files changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index ca830c6cd809..2f58cfc91420 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -455,6 +455,20 @@ Description:
> >  			      "Unknown", "Charging", "Discharging",
> >  			      "Not charging", "Full"
> >  
> > +What:		/sys/class/power_supply/<supply_name>/charge_behaviour
> > +Date:		November 2021
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Represents the charging behaviour.
> > +
> > +		Access: Read, Write
> > +
> > +		Valid values:
> > +			================ ====================================
> > +			auto:            Charge normally, respect thresholds
> > +			inhibit-charge:  Do not charge while AC is attached
> > +			force-discharge: Force discharge while AC is attached
> > +
> >  What:		/sys/class/power_supply/<supply_name>/technology
> >  Date:		May 2007
> >  Contact:	linux-pm@vger.kernel.org
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index c3d7cbcd4fad..26c60587dca1 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -172,6 +172,7 @@ static struct power_supply_attr power_supply_attrs[] = {
> >  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
> >  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
> >  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> > +	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
> >  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
> >  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
> >  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> 
> this is missing (and should not compile without it):
> 
> static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = { ... };

The non-RFC version will have that.

> Otherwise LGTM. But you need to send API changes with an API user (i.e. the
> patch updating acpi battery driver using this).

I have an implementation for the thinkpad_acpi driver.

Is it fine if I export helper functions from power_supply_sysfs.c?

The problem is that thinkpad_acpi is using the acpi battery hooks which do
not allow other drivers to extend existing ACPI batteries with proper
powersupply properties but only plain sysfs attributes.

Currently I keep the parsing and formatting of the sysfs file inside
power_supply_sysfs.c, because that is where it belongs but export it to other
modules to use for their custom sysfs attributes.

I'm just not sure if this is acceptable, because no other function from
power_supply_sysfs.c is exported yet.

If it's not clear enough, we can also discuss this on the real patchset which
I'll probably submit tomorrow.

Thanks,
Thomas
