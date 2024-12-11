Return-Path: <linux-pm+bounces-19061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589A9ED686
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C44518817D7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41C2594AC;
	Wed, 11 Dec 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KMhkEYuE"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9C17736;
	Wed, 11 Dec 2024 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945208; cv=none; b=euL8/jrY8GdXv13GREgOLD96NaT34+ll3N1Z15uBo97pKrcATSxV1Yrh9FFnjNENXoiUGAn1y8OHhrJPU/OB9ECeznyIOrWgZ/I1kFqeS11WIDaEeXL4ZBe2BV4FWQVI/vhPN8VR5IDfhw40clLeffRigygd5R+iB90fApRPVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945208; c=relaxed/simple;
	bh=gYdwoyenUTlpMv0FM4Qna8hsMC/TbnCMCnw/Nk0U9Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt/SXZHvHHCqdg/+XSni2NJQ5pHMl+rK38YNNx4uqt2QRWUeEe7m4fwDART35+PAJF/3HElJKCowNhGLU4gyUmH9yeH6cbxHAwK9UwSRT6aQrFcUIU20iG7Tek9mXo3X+vqAMNf2jfqgPV3kO4yxKBswuPurREE74+nQr4U+IZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KMhkEYuE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733945202;
	bh=gYdwoyenUTlpMv0FM4Qna8hsMC/TbnCMCnw/Nk0U9Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMhkEYuE1zQKTxScqvB88VWF0Mz6aNv01jAD1fNugNeN3/1qip5W8z17Cmms1qf8X
	 yqFdEqEnkpPlC0Wi3wr79WsWKAYn7bvH5fRmPZMVMfNDStFDSGkHgI7ceBVMdkdwUH
	 hJi4jcDhfxUQ8EiHbwpizvzbAfoD5kEue8hosliw=
Date: Wed, 11 Dec 2024 20:26:42 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/4] power: supply: core: Add new "charge_types"
 property
Message-ID: <a3dcca80-efb1-47ba-bfc8-4e47d799e098@t-8ch.de>
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-3-hdegoede@redhat.com>
 <9aa6ad55-d0c3-4cdc-82a9-0c3906f77f30@t-8ch.de>
 <e30dec47-724d-48fb-8ffa-1e73a7f53f64@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e30dec47-724d-48fb-8ffa-1e73a7f53f64@redhat.com>

Hi Hans!

On 2024-12-11 17:11:49+0100, Hans de Goede wrote:
> On 10-Dec-24 5:50 PM, Thomas Weißschuh wrote:
> > On 2024-12-09 21:40:49+0100, Hans de Goede wrote:
> >> Add a new "charge_types" property, this is identical to "charge_type" but
> >> reading returns a list of supported charge-types with the currently active
> >> type surrounded by square brackets, e.g.:
> >>
> >> Fast [Standard] "Long_Life"
> >>
> >> This has the advantage over the existing "charge_type" property that this
> >> allows userspace to find out which charge-types are supported for writable
> >> charge_type properties.
> >>
> >> Drivers which already support "charge_type" can easily add support for
> >> this by setting power_supply_desc.charge_types to a bitmask representing
> >> valid charge_type values. The existing "charge_type" get_property() and
> >> set_property() code paths can be re-used for "charge_types".
> > 
> > IMO it would be nice to have the psy core implement "charge_type" in
> > terms of "charge_types" if that is available.
> > (And reject a custom "charge_type" in that case)
> 
> I'm afraid that adding support to the core for that is going to be
> tricky / ugly. While as supporting both in the same driver is trivial.

I didn't look into the implementation. If you say it is ugly I believe
you.

> Also this raises the question if we even want new drivers to have
> charge_type at all ? For old drivers we want to keep it to not break
> userspace ABI. But for new drivers arguably only having
> the new charge_types attribute is better ?

Makes sense.

> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Changes in v2:
> >> - Add "Check charge_types to get the values supported by the battery."
> >>   to Documentation/ABI/testing/sysfs-class-power
> >> - Add a note about labels with spaces having these replaced by '_'
> >>   to Documentation/ABI/testing/sysfs-class-power
> >> - Use power_supply_match_string() in power_supply_charge_types_parse()
> >> ---
> >>  Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++
> >>  drivers/power/supply/power_supply_sysfs.c   | 34 +++++++++++++++++++++
> >>  include/linux/power_supply.h                | 23 +++++++++++++-
> >>  3 files changed, 76 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> >> index 45180b62d426..4421815cfb40 100644
> >> --- a/Documentation/ABI/testing/sysfs-class-power
> >> +++ b/Documentation/ABI/testing/sysfs-class-power
> >> @@ -407,10 +407,30 @@ Description:
> >>  
> >>  		Access: Read, Write
> >>  
> >> +		Reading this returns the current active value, e.g. 'Standard'.
> >> +		Check charge_types to get the values supported by the battery.
> >> +
> >>  		Valid values:
> >>  			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
> >>  			      "Adaptive", "Custom", "Long Life", "Bypass"
> >>  
> >> +What:		/sys/class/power_supply/<supply_name>/charge_types
> >> +Date:		November 2024
> >> +Contact:	linux-pm@vger.kernel.org
> >> +Description:
> >> +		Identical to charge_type but reading returns a list of supported
> >> +		charge-types with the currently active type surrounded by square
> >> +		brackets, e.g.: "Fast [Standard] Long_Life".
> >> +
> >> +		power_supply class devices may support both charge_type and
> >> +		charge_types for backward compatibility. In this case both will
> >> +		always have the same active value and the active value can be
> >> +		changed by writing either property.
> >> +
> >> +		Note charge-types which contain a space such as "Long Life" will
> >> +		have the space replaced by a '_' resulting in e.g. "Long_Life".
> >> +		When writing charge-types both variants are accepted.
> >> +
> >>  What:		/sys/class/power_supply/<supply_name>/charge_term_current
> >>  Date:		July 2014
> >>  Contact:	linux-pm@vger.kernel.org
> >> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> >> index 034e1848f1ca..48a9bf791a38 100644
> >> --- a/drivers/power/supply/power_supply_sysfs.c
> >> +++ b/drivers/power/supply/power_supply_sysfs.c
> >> @@ -182,6 +182,8 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
> >>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
> >>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> >>  	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
> >> +	/* Same enum value texts as "charge_type" without the 's' at the end */
> >> +	_POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPES, POWER_SUPPLY_CHARGE_TYPE_TEXT),
> >>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
> >>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
> >>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> >> @@ -335,6 +337,10 @@ static ssize_t power_supply_show_property(struct device *dev,
> >>  		ret = power_supply_charge_behaviour_show(dev, psy->desc->charge_behaviours,
> >>  							 value.intval, buf);
> >>  		break;
> >> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
> > 
> > This should only show a single value for uevent. The same as
> > charge_behaviours above (done in a recent change).
> 
> Ack, I'll look at what you have done for charge_behaviors and replicate
> that for v4 of the series.
> 
> <snip>
> 
> >> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> >> index b98106e1a90f..60c7f669ec3e 100644
> >> --- a/include/linux/power_supply.h
> >> +++ b/include/linux/power_supply.h
> >> @@ -40,7 +40,7 @@ enum {
> >>  };
> >>  
> >>  /* What algorithm is the charger using? */
> >> -enum {
> >> +enum power_supply_charge_type {
> >>  	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
> >>  	POWER_SUPPLY_CHARGE_TYPE_NONE,
> >>  	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
> >> @@ -135,6 +135,7 @@ enum power_supply_property {
> >>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
> >>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> >>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> >> +	POWER_SUPPLY_PROP_CHARGE_TYPES,
> > 
> > Could the related enum values be kept together?
> 
> I but this after POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR since it
> is somewhat related to it, also see your uevent remark.
> 
> But since the enum values are kernel internal only this
> can easily be changed. I assume you want this to be
> directly after POWER_SUPPLY_PROP_CHARGE_TYPE instead ?

That was my idea. But it doesn't matter much anyways.


Regards,
Thomas

