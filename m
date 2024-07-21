Return-Path: <linux-pm+bounces-11271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FDD938422
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D712281502
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CEBBE40;
	Sun, 21 Jul 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5K0Z/Dx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C069460;
	Sun, 21 Jul 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721552563; cv=none; b=XpNPgiwBk7V2kAExgdtafwFa8uqXSivEAjDZ2mIOL//kOhlbhk4Ty2ZGTyVn24ph2EUG3jCfDCsOAVV1eELzfljad2zmRjLcLJmdMeRz2pDL9gIwUcvfrwiEGHQ865tg2Z18+wGPcJQKxOFo7jiZYI/Yl8+JpYTTJ63L0oZIY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721552563; c=relaxed/simple;
	bh=lj6xhLE9N/q78EKFc/kRMyh7sLdyoZi1c1CV6RZvxQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2fU33RhQeixK/64njLTsCo5umCqoIIHZRPqpfahYlWuU8RxOy8LJ0WxB5QT2LMRaiAVCT7n9x/HHxfsF3SPDvLj1U3jzBaxWF3yo5UWWAGKISa76P+zcQjGrfjtttgJN9NahBeeaoBk2Jqq7RLja6usJLxRKyD2c372BZz9TKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5K0Z/Dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A536C116B1;
	Sun, 21 Jul 2024 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721552562;
	bh=lj6xhLE9N/q78EKFc/kRMyh7sLdyoZi1c1CV6RZvxQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5K0Z/DxxGvHoezHGDVw+KhpLuIHUoacxcPPDKsX7lAmMRTq8qd2JQ3CN+PNMCEuK
	 nyQfplQ462HvDQv7bMi8irQpO3zPy0ys/wXzgymTUKfyqRMVQAsx4QJ8nyKEaWcl5t
	 I1oGl2Pyw9vi8fHDz7//zzDNijvE6rVownCMZLuNOfDCnz4qWerTBAF/IB/YR89hb0
	 25OZEwNnjJYImiB8gwjHZttTpieFk5ZWFt4HOvis7LCBu4HwTdq9ER404miHvhgu13
	 eA6oC5vVKsR372RmgGIFDED9IdxfWkVoetC9bby4LyKDgA9V36POTH5GSmkumjtYr0
	 jYQIeAY6iFX4A==
Received: by pali.im (Postfix)
	id 97465800; Sun, 21 Jul 2024 11:02:38 +0200 (CEST)
Date: Sun, 21 Jul 2024 11:02:38 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240721090238.wrei5nu6y3awujws@pali>
References: <20240720012220.26d62a54@5400>
 <20240720084019.hrnd4wgt4muorydp@pali>
 <20240720052419.73b1415a@5400>
 <20240720095507.uyaotkofkyasdgbd@pali>
 <20240720220606.1934df43@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720220606.1934df43@5400>
User-Agent: NeoMutt/20180716

On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:
> On Sat, 20 Jul 2024 11:55:07 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:
> > > Thanks for the quick feedback! Responses below.
> > > 
> > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > Pali Rohár <pali@kernel.org> wrote:
> > >   
> > > > Hello,
> > > > 
> > > > I looked at your patch. I wrote some comments below. The main issue is
> > > > how to correctly interpret read token values.
> > > >  
> [...]
> > > > > +
> > > > > +static ssize_t charge_type_show(struct device *dev,
> > > > > +		struct device_attribute *attr,
> > > > > +		char *buf)
> > > > > +{
> > > > > +	enum battery_charging_mode mode;
> > > > > +	ssize_t count = 0;
> > > > > +
> > > > > +	for (mode = DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode++) {
> > > > > +		if (battery_state[mode]) {
> > > > > +			count += sysfs_emit_at(buf, count,
> > > > > +				mode == bat_chg_current ? "[%s] " : "%s ",
> > > > > +				battery_state[mode]);
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	/* convert the last space to a newline */
> > > > > +	count--;
> > > > > +	count += sysfs_emit_at(buf, count, "\n");    
> > > > 
> > > > Here is missing protection in the case when number of valid modes is
> > > > zero, so count is 0 and buf was untouched.
> > > >   
> > > 
> > > This will never be zero (based on the hardcoded value of DELL_BAT_MODE_MAX),  
> > 
> > Now I see. You are iterating over members of constant array battery_state[].
> > I overlooked it and I thought that this iteration over mode values.
> > 
> > What about writing the for- conditions to be visible that you are
> > iterating over the array? E.g.
> > 
> > 	size_t i;
> > 	...
> > 	for (i = 0; i < ARRAY_SIZE(battery_state); i++) {
> > 		if (!battery_state[i])
> > 			continue;
> > 		count += sysfs_emit_at(buf, count, i == bat_chg_current ? "[%s] " : "%s ", battery_state[i]);
> > 	}
> > 	...
> > 
> > This has an advantage that you do not depend on DELL_BAT_MODE_MAX value,
> > compiler will calculate upper bound automatically.
> > 
> > Or another way. You can define array of tokens, like it is done for
> > keyboard backlight. See how the array kbd_tokens[] is used.
> > 
> > With this approach you can completely get rid of the DELL_BAT_MODE_MAX.
> > 
> 
> See below for a question about charge_type_store() if we get rid of
> DELL_BAT_MODE_MAX.
> 
> > > but perhaps a static_assert or BUILD_BUG_ON to verify that the number of
> > > modes > 0?  
> > 
> > I think it is not needed.
> > 
> > >     
> > > > > +
> > > > > +	return count;
> > > > > +}
> > > > > +
> > > > > +static ssize_t charge_type_store(struct device *dev,
> > > > > +		struct device_attribute *attr,
> > > > > +		const char *buf, size_t size)
> > > > > +{
> > > > > +	enum battery_charging_mode mode;
> > > > > +	const char *label;
> > > > > +	int ret = -EINVAL;
> > > > > +
> > > > > +	for (mode = DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode++) {
> > > > > +		label = battery_state[mode];
> > > > > +		if (label && sysfs_streq(label, buf))
> > > > > +			break;
> > > > > +	}
> > > > > +
> > > > > +	if (mode > DELL_BAT_MODE_NONE && mode < DELL_BAT_MODE_MAX) {
> > > > > +		ret = battery_charging_mode_set(mode);
> > > > > +		if (!ret) {
> > > > > +			bat_chg_current = mode;
> > > > > +			ret = size;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return ret;
> > > > > +}
> 
> Here we're using DELL_BAT_MODE_MAX to determine if we failed to match
> any mode strings sent from the user. If we get rid of that, we're either
> going to have to use a separate variable (eg, 'bool matched = false;' and
> set it to true in case of a match), or iterate backwards (eg,
> for (mode = ARRAY_SIZE(battery_state); mode >= DELL_BAT_MODE_NONE; mode--) {
> 	...
> }
> if (mode != DELL_BAT_MODE_NONE) {
> 	ret = battery_charging_mode_set(mode);
> 
> 
> Do you have a preference?

You can use extra bool variable.

Anyway, if we figure out how the token value is going to be used, maybe
this code could be changed / simplified...

> 
> [...]
> > > > > +static ssize_t charge_control_start_threshold_store(struct device *dev,
> > > > > +		struct device_attribute *attr,
> > > > > +		const char *buf, size_t size)
> > > > > +{  
> > > [...]
> > >   
> > > > > +
> > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > +{
> > > > > +	enum battery_charging_mode current_mode = DELL_BAT_MODE_NONE;
> > > > > +
> > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> > > > > +	if (current_mode != DELL_BAT_MODE_NONE) {    
> > > > 
> > > > I quite do not understand how is this code suppose to work.
> > > > 
> > > > Why is there mix of custom kernel enum battery_charging_mode and return
> > > > value from Dell's API?  
> > > 
> > > This is from the original patch from Dell; tbh, I'm not sure. It does
> > > work, though. That is, current_mode ends up holding the correct value
> > > based on what was previously set, even if the charging mode is set from
> > > the BIOS.
> > > 
> > > I just scanned through the libsmbios code to see what it's doing, and
> > > it appears to loop through every charging mode to check if its active.
> > > I'm not really sure that makes much more sense, so I'll try some more
> > > tests.  
> > 
> > Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
> > this type scan. If I remember correctly, for every keyboard backlight
> > token we just know the boolean value - if the token is set or not.
> > 
> > It would really nice to see what (raw) value is returned by the
> > dell_battery_read_req(token) function for every battery token and for
> > every initial state.
> 
> I checked this. The BIOS sets the mode value in every related token
> location. I'm still not really sure what libsmbios is doing, but the
> kernel code seems to arbitrarily choose one of the token locations
> to read from. This makes sense to me now.
> 
> In the BIOS when I set the mode to "ExpressCharge",
> this what I pulled for each token location:
> 
> [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN value: 2
> [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN value: 2
> [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN value: 2
> [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN value: 2
> [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN value: 2
> 
> Similar story when I set it to Custom (all were '5'), or Standard ('1').
> When I set it from linux as well, it changed all location values.

Interesting... Anyway, I still think that the API could be similar to
what is used in keyboard backlight.

Could you please dump all information about each token? They are in
struct calling_interface_token returned by dell_smbios_find_token.

I'm interesting in tokenID, location and value.

Ideally to compare what is in token->value and then in buffer.output[1]
(in case dell_send_request does not fail).

> > 
> > Because it is really suspicious if dell_battery_read_req() would return
> > value of the enum battery_charging_mode (as this is kernel enum).
> > 
> > 
> > Also another important thing. In past it was possible to buy from Dell
> > special batteries with long warranty (3+ years). I'm not sure if these
> > batteries are still available for end-user customers. With this type of
> > battery, it was not possible to change charging mode to ExpressCharge
> > (bios option was fade-out). I do not have such battery anymore, but I
> > would expect that the firmware disabled BAT_EXPRESS_MODE_TOKEN as mark
> > it as unavailable.
> > 
> > I think that we should scan list of available tokens, like it is done
> > for keyboard backlight in kbd_init_tokens(). And export via sysfs only
> > those battery modes for which there is available token.
> 
> I agree, but I'm not seeing a way to do that right now given how the
> BIOS sets the mode. Maybe libsmbios has some clues...

Try to get those dumps and I will try to do something with it.

> 
> 
> 
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

