Return-Path: <linux-pm+bounces-12998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B59616EA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 20:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B1A2897C9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1561D1757;
	Tue, 27 Aug 2024 18:24:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC2B64A;
	Tue, 27 Aug 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783061; cv=none; b=AFU5hsP0gP3d3BmIKm3A4XlQe2qs4jOdan9xvg8q43irAkQ+7apX4pgvmC4MNKbR5zVBjNCAWEvBPxLlTNMwmmXgw9uvkj/AlMsF2F1DSkJm3UvpmoodplS/SWsACSV79D9re1LxssQJZmZAf0me9jmZOPndU4YCbOzR2dgh1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783061; c=relaxed/simple;
	bh=aBFZVtuwfZ+m5iiQY1UmETzqRCn8tpeZF8oNvnWbkco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9x9JbR1JQiQ64Q88M6uR8qx3F7u50MQcO8yOB95UdcIK2wOPolmkc5tp0oP71ZGoUTvWJ1xS0u/2AoN2zlc3gAvAkupvEBwZOQYvb24irs2ezZ80WviCXiTfDJGZWEmwPRcNI/Cvtn9/fDkJmmCp5/zNH6xFp+i0hF5geVZtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 895B9116374; Tue, 27 Aug 2024 14:24:13 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 01704116301;
	Tue, 27 Aug 2024 14:24:10 -0400 (EDT)
Date: Tue, 27 Aug 2024 14:24:08 -0400
From: Andres Salomon <dilinger@queued.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v4 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240827142408.0748911f@5400>
In-Reply-To: <04d48a7c-cad1-4490-bbcd-ceb332c740bd@redhat.com>
References: <20240820033005.09e03af1@5400>
	<04d48a7c-cad1-4490-bbcd-ceb332c740bd@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Mon, 26 Aug 2024 16:44:35 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi Andres,
> 
> On 8/20/24 9:30 AM, Andres Salomon wrote:
[...]
> > +
> > +static ssize_t charge_type_show(struct device *dev,
> > +		struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	ssize_t count = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> > +		bool active;
> > +
> > +		if (!(battery_supported_modes & BIT(i)))
> > +			continue;
> > +
> > +		active = dell_battery_mode_is_active(battery_modes[i].token);
> > +		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> > +				battery_modes[i].label);
> > +	}  
> 
> If you look at the way how charge_type is shown by the power_supply_sysfs.c
> file which is used for power-supply drivers which directly register
> a power-supply themselves rather then extending an existing driver, this
> is not the correct format.
> 
> drivers/power/supply/power_supply_sysfs.c
> 
> lists charge_type as:
> 
>         POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
> 
> and ENUM type properties use the following for show() :
> 
> 	default:
> 		if (ps_attr->text_values_len > 0 &&
> 				value.intval < ps_attr->text_values_len && value.intval >= 0) {
> 			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> 		} else {
> 			ret = sysfs_emit(buf, "%d\n", value.intval);
> 		}
> 	}
> 
> with in this case text_values pointing to:
> 
> static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
> 	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	= "Unknown",
> 	[POWER_SUPPLY_CHARGE_TYPE_NONE]		= "N/A",
> 	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	= "Trickle",
> 	[POWER_SUPPLY_CHARGE_TYPE_FAST]		= "Fast",
> 	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	= "Standard",
> 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
> 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
> 	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Long Life",
> 	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	= "Bypass",
> };
> 
> So value.intval will be within the expected range hitting:
> 
> 			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> 
> IOW instead of outputting something like this:
> 
> Fast [Standard] Long Life
> 
> which is what your show() function does it outputs only
> the active value as a string, e.g.:
> 
> Standard
> 
> Yes not being able to see the supported values is annoying I actually
> wrote an email about that earlier today:
> 
> https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/
> 
> but we need to make sure that the output is consistent between drivers otherwise
> userspace can never know how to use the API, so for charge_type the dell
> driver should only output the active type, not all the options.

So should I just wait to make any changes until you hear back in that
thread? I'm not overly excited about changing it to use the current
charge_type API, given that the only way to get a list of modes that the
hardware supports is to try setting them all and seeing what fails.

I suppose another option is to rename it to charge_types in the dell
driver under the assumption that your proposed charge_types API (or
something like it) will be added..


> 
> This reminds me that there was a patch-series to allow battery extension drivers
> like this one to actually use the power-supply core code for show()/store()
> Thomas IIRC that series was done by you ?  What is the status of that ?
> 
> Also looking at the userspace API parts of this again I wonder
> if mapping  BAT_PRI_AC_MODE_TOKEN -> "Trickle" is the right thing do
> maybe "Long Life" would be a better match ?  That depends on what the option
> actually does under the hood I guess. Is this known ?
> 

I originally thought to use Long Life rather than Trickle. We discussed
it here:

https://lore.kernel.org/linux-pm/5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de/

Based on the existing documentation and the fact that the wilco driver
already mapped it, it was decided to stick with the existing precedent
of using Trickle.

That said, Armin at first suggested creating a new "Primarily AC" entry.
That's personally my favorite option, though I understand if we don't
have to have 50 CHARGE_TYPE entries that just slightly different
variations. :)



-- 
I'm available for contract & employment work, please contact me if
interested.

