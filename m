Return-Path: <linux-pm+bounces-11413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF193CBB1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 02:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABCA282748
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F619B;
	Fri, 26 Jul 2024 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWkYQAAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EF18E;
	Fri, 26 Jul 2024 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952254; cv=none; b=qcWpRYfgWFQTag5mOIUu90FjY/HMbRAZD0ddvQbpd9sg1AMQzd5GNhn/Ca2kKqT5BADV0e9m/Ap2P1dsVAoaOzHC2K9cAYauNbgPhSy/iImQbMQTTeEDM2jesTCTSu6N7XH/7DpERdHtsdDkm0OCYvzQjxJcCjAhuqgQl92pp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952254; c=relaxed/simple;
	bh=ZgTfIkmvyFYTDDSZxgVyN0+nuijRqdtCKl/730nnYmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdS/o0Jnry9iCnvyje5CumT9QnkZ4AQATZ3lfwnd4ulOTl0M+KRkDroBAXJjNuN7w9D4e18dUgSCXYPGn7UmzDHiT4Ugcjfk6RVFdB0GufhD9r//CbVoG5SzWST9USHSFKdoZjKWlpcIDbIZdv1vMzOtacfDPOMC+oRxAEyU36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWkYQAAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A625C116B1;
	Fri, 26 Jul 2024 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721952254;
	bh=ZgTfIkmvyFYTDDSZxgVyN0+nuijRqdtCKl/730nnYmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWkYQAAdpNnpmeHfOg3zTfxjzzBbi2yA6y3EE3CPnso7A2MqfuD1qhHHrz2+rXrG8
	 9qamQG9fnhhzg/8+z5DxSjZrxCGvnqJIdhjmgZEG5NxFiBAdAJETmyjyLp8sKTV264
	 gPQNcBWVvQEiTVrQ9fKyDkXZzRuW2yd5eJ3883b62kuL9Y2wCUm7rhMdlucW5oZPvF
	 JMgYJBJx6Td/ogq7LcWFTr2m1sYq+kxV3icvWx4jsh9eVxXZ3uCQ4qXMuFCI6lxajV
	 HbF1nSz/gsvhqYzMrJ/oz0AK59QqNcZePHZ29XVUIN9HUhlF72Fo8YVZQVIAZZmBiz
	 fTWJmIrwZlJJw==
Received: by pali.im (Postfix)
	id 229BA67E; Fri, 26 Jul 2024 02:04:10 +0200 (CEST)
Date: Fri, 26 Jul 2024 02:04:09 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240726000409.ejnvqkzco664q3zb@pali>
References: <20240723220502.77cb0401@5400>
 <20240724203403.zcrx2lshbla3o2gp@pali>
 <20240724204523.xb6rp7ba6yqi5klt@pali>
 <20240724182318.66578a48@5400>
 <20240724230158.nsmxdgagfpanjtzi@pali>
 <20240725162457.34b480e1@5400>
 <20240725221511.mqb4tlam2r7yheoi@pali>
 <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
User-Agent: NeoMutt/20180716

On Friday 26 July 2024 01:48:50 Armin Wolf wrote:
> Am 26.07.24 um 00:15 schrieb Pali Rohár:
> 
> > On Thursday 25 July 2024 16:24:57 Andres Salomon wrote:
> > > On Thu, 25 Jul 2024 01:01:58 +0200
> > > Pali Rohár <pali@kernel.org> wrote:
> > > 
> > > > On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
> > > > > On Wed, 24 Jul 2024 22:45:23 +0200
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > 
> > > > > > On Wednesday 24 July 2024 22:34:03 Pali Rohár wrote:
> > > > > > > Hello, the driver change looks good. I have just few minor comments for
> > > > > > > this change below.
> > > > > > > 
> > > > > > > Anyway, if there is somebody on the list with Dell laptop with 2 or 3
> > > > > > > batteries, see below, it would be nice to check how such laptop would
> > > > > > > behave with this patch. It does not seem that patch should cause
> > > > > > > regression but always it is better to do testing if it is possible.
> > > > > > > 
> > > > > > > On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote:
> > > > > [...]
> > > > > > And because CLASS_TOKEN_WRITE is being repeated, what about defining
> > > > > > something like this?
> > > > > > 
> > > > > >      static inline int dell_set_token_value(struct calling_interface_buffer *buffer, u16 class, u16 tokenid, u32 value)
> > > > > >      {
> > > > > >          dell_send_request_for_tokenid(buffer, class, CLASS_TOKEN_WRITE, tokenid, value);
> > > > > >      }
> > > > > > 
> > > > > > Just an idea. Do you think that it could be useful in second patch?
> > > > > > 
> > > > > Let me implement the other changes first and then take a look.
> > > > Ok.
> > > > 
> > > For the helper function, I noticed that all of the CLASS_TOKEN_WRITEs
> > > also have SELECT_TOKEN_STD except for one (dell_send_intensity). So I
> > > think it makes sense to have the helper function also do that as well.
> > > Eg,
> > > 
> > > static inline int dell_set_std_token_value(struct calling_interface_buffer *buffer, u16 tokenid, u32 value)
> > > {
> > > 	dell_send_request_for_tokenid(buffer, SELECT_TOKEN_STD, CLASS_TOKEN_WRITE, tokenid, value);
> > > }
> > > 
> > > I agree with your renaming to dell_send_request_for_tokenid, btw.
> > > 
> > > 
> > > > > > > > +static int dell_battery_read(const int type)
> > > > > > > > +{
> > > > > > > > +	struct calling_interface_buffer buffer;
> > > > > > > > +	int err;
> > > > > > > > +
> > > > > > > > +	err = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
> > > > > > > > +			SELECT_TOKEN_STD, type, 0);
> > > > > > > > +	if (err)
> > > > > > > > +		return err;
> > > > > > > > +
> > > > > > > > +	return buffer.output[1];
> > > > > > > buffer.output[1] is of type u32. So theoretically it can contain value
> > > > > > > above 2^31. For safety it would be better to check if the output[1]
> > > > > > > value fits into INT_MAX and if not then return something like -ERANGE
> > > > > > > (or some other better errno code).
> > > 
> > > I ended up returning -EIO here, with the logic that if we're getting
> > > some nonsense value from SMBIOS, it could either be junk in the stored
> > > values or communication corruption.
> > > 
> > > Likewise, I used -EIO for the checks in charge_control_start_threshold_show
> > > and charge_control_end_threshold_show when SMBIOS returns values > 100%.
> > > 
> > > 
> > > 
> > > > > 
> > > > > > > 
> > > > > > > > +	if (end < 0)
> > > > > > > > +		end = CHARGE_END_MAX;
> > > > > > > > +	if ((end - start) < CHARGE_MIN_DIFF)
> > > > > > > nit: I'm not sure what is the correct coding style for kernel drivers
> > > > > > > but I thought that parenthesis around (end - start) are not being
> > > > > > > written.
> > > > > > > 
> > > I think it makes the comparison much easier to read. I'd prefer to
> > > keep it, unless the coding style specifically forbids it.
> > As I said I'm really not sure. So if nobody would complain then you can
> > let it as is.
> > 
> > You can use ./scripts/checkpatch.pl application which is in git tree,
> > which does basic checks for code style. It cannot prove if something is
> > really correct but it can prove if something is incorrect.
> > 
> > > 
> > > 
> > > > > > > > +
> > > > > > > > +static u32 __init battery_get_supported_modes(void)
> > > > > > > > +{
> > > > > > > > +	u32 modes = 0;
> > > > > > > > +	int i;
> > > > > > > > +
> > > > > > > > +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > > > > > > +		if (dell_smbios_find_token(battery_modes[i].token))
> > > > > > > > +			modes |= BIT(i);
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	return modes;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > > > > +{
> > > > > > > > +	battery_supported_modes = battery_get_supported_modes();
> > > > > > > > +
> > > > > > > > +	if (battery_supported_modes != 0)
> > > > > > > > +		battery_hook_register(&dell_battery_hook);
> > > > > > > Anyway, how is this battery_hook_register() suppose to work on systems
> > > > > > > with multiple batteries? The provided API is only for the primary
> > > > > > > battery, but on older Dell laptop it was possible to connect up to
> > > > > > > 3 batteries. Would not this case some issues?
> > > > > This interface is _only_ for controlling charging of the primary battery.
> > > > > In theory, it should hopefully ignore any other batteries, which would
> > > > > need to have their settings changed in the BIOS or with a special tool or
> > > > > whatever.
> > > > That is OK. But where it is specified that the hook is being registered
> > > > only for the primary battery? Because from the usage it looks like that
> > > > the hook is applied either for all batteries present in the system or
> > > > for some one arbitrary chosen battery.
> > > > 
> > > > > However, I'm basing that assumption on the SMBIOS interface. These tokens
> > > > > are marked "Primary Battery". There are separate tokens marked "Battery
> > > > > Slice", which from my understanding was an older type of battery that
> > > >  From SMBIOS perspective it is clear, each battery seems to have its own
> > > > tokens.
> > > > 
> > > > The issue here is: how to tell kernel that the particular
> > > > dell_battery_hook has to be bound with the primary battery?
> > > > 
> > > So from userspace, we've got the expectation that multiple batteries
> > > would show up as /sys/class/power_supply/BAT0, /sys/class/power_supply/BAT1,
> > > and so on.
> > Yes, I hope so.
> > 
> > > The current BAT0 entry shows things like 'capacity' even without this
> > > patch, and we're just piggybacking off of that to add charge_type and
> > > other entries. So there shouldn't be any confusion there, agreed?
> > I have not looked at the battery_hook_register() code yet (seems that I
> > would have to properly read it and understand it). But does it mean that
> > battery_hook_register() is adding hook just for "BAT0"?
> > 
> > What I mean: cannot that hook be registered to "BAT1" too? Because if
> > yes then we should prevent it. Otherwise this hook which is for "Dell
> > Primary Battery" could be registered also for secondary battery "BAT1".
> > (I hope that now it is more clear what I mean).
> 
> Hi,
> 
> the battery hook is being registered to all ACPI batteries present on a given system,
> so you need to do some manual filtering when .add_battery() is called.

Ok. So it means that the filtering based on the primary battery in
add_battery callback is needed.

> As a side note: i suspect that "newer" Dell machines use a different interface for controlling
> battery charging, since the Dell Power Manager software on my machine seems to provide some
> additional features not found in this token-based interface.

Dell has released documentation of some other API, see the end of this file
https://github.com/dell/libsmbios/blob/master/src/bin/smbios-battery-ctl

> Unfortunately i am not sure if reverse-engineering the Dell software is legal, does the kernel
> community have some helping guides in this area? If it is legal, then i would happily volunteer
> to do the reverse-engineering.

That is questionable. Some kernel drivers were written from reverse
engineered data in past.

Note that in some countries is reverse engineering legal if it is done
for interoperability purposes (which this one could match).

> Otherwise maybe someone at Dell can provide some clarifications if a different interface for controlling
> battery charging exists and how to use it?

Try to send an off-list/private email to Dell.Client.Kernel@dell.com
with details for what you are asking. Maybe they would have access to
some new documentation.

> Thanks,
> Armin Wolf
> 
> > > In the kernel, we're registering the acpi_battery_hook as "Dell Primary
> > > Battery Extension". The functions set up by that acpi_battery_hook are
> > > the only ones using battery_support_modes. We could make it more explicit
> > > by:
> > > 1) renaming it to primary_battery_modes, along with
> > > dell_primary_battery_{init,exit} and/or
> > > 2) allocating the mode mask and strings dynamically, and storing that
> > > inside of the dev kobject.
> > > 
> > > However, #2 seems overly complicated for what we're doing. In the
> > > circumstances that we want to add support for secondary batteries,
> > > we're going to need to query separate tokens, add another
> > > acpi_battery_hook, and also add a second mask. Whether that's a global
> > > variable or kept inside pdev seems like more of a style issue than
> > > anything else.
> > > 
> > > #1 is easy enough to change, if you think that's necessary.
> > I think that "Dell Primary Battery Extension" is OK. All SMBIOS code is
> > currently primary-battery only.
> > 
> > The only my point is to prevent this &dell_battery_hook to be registered
> > for non-primary battery.
> > 

