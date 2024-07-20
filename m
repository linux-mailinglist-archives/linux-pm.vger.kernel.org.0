Return-Path: <linux-pm+bounces-11268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD593808E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAC51F215EB
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015574420;
	Sat, 20 Jul 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2YLhcuz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEF5474A;
	Sat, 20 Jul 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721469312; cv=none; b=XURfxpXHSNJgHcMZ8HKJxW6QDM3mszabFzN6pE9abomoeK2ocQt2kZ1g1KH3Y8xwLcWtjr4HXluI5AyRg/ymSeYNCat2LHfJNmTYxJJYGH1XIR5hWUN1RdpZRKP6OPiP9oKtj5pW1xydR4Tvs7M46165m3rQfdlToHTFKuDLwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721469312; c=relaxed/simple;
	bh=Wu5UFeumOWtWcFpQjS3yFFfzrB2TMfTN7C1LyRPLT8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTb1yD4xZLL2a5MVwsx3MFEzHdLt/C7LKB4welhjmh5F0w/fBaYnFpiFeLcU3oE6KAj2z5RNdNjwa9ELWZWCY3GQDngG/yURz1+/9w3NHZUV9VEW/jSKcp4SBjpgEKDsuqGpEDynAJvXSBlHor954cAsoPd+8HcRDOyBshEs/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2YLhcuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E727BC2BD10;
	Sat, 20 Jul 2024 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721469312;
	bh=Wu5UFeumOWtWcFpQjS3yFFfzrB2TMfTN7C1LyRPLT8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2YLhcuzuvpG5Gmb6hnvUQYlRuoWmj+rC3ymrDjbv+3Q4d1Yo2kPaG6aisR+jz/Da
	 HHLfX8Ktt8uGZpZ+nD3NbYKU1jHj4R0UDCFJP0YY3nRlvR2CSRx229Mr0hxKMI5Dcx
	 N4n8eCznvVhRE9e3eRlui4O9yc6hg12xsrtfHUpAUY6qJd97i5W5O9WxiaYTFbAvc8
	 jr40fIkjooG0YTr9jqwEG7HZJdACGtfWExO6WQA6Xru6DM0JkKC4UlBPi3FZPtRC7h
	 7Qnk/cs4MkuCEST2blPWfY5Vix2Vni8RSPke/Mh8q2TCJBra2A5RIXWw8ylqSuDUl7
	 YzigxlXhQTo2Q==
Received: by pali.im (Postfix)
	id 020258A0; Sat, 20 Jul 2024 11:55:07 +0200 (CEST)
Date: Sat, 20 Jul 2024 11:55:07 +0200
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
Message-ID: <20240720095507.uyaotkofkyasdgbd@pali>
References: <20240720012220.26d62a54@5400>
 <20240720084019.hrnd4wgt4muorydp@pali>
 <20240720052419.73b1415a@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720052419.73b1415a@5400>
User-Agent: NeoMutt/20180716

On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:
> Thanks for the quick feedback! Responses below.
> 
> On Sat, 20 Jul 2024 10:40:19 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > Hello,
> > 
> > I looked at your patch. I wrote some comments below. The main issue is
> > how to correctly interpret read token values.
> >
> [...]
> 
> > 
> > dell_send_request() returns negative value on error. As the read value
> > seems to be always non-negative number, you can change API of the
> > dell_battery_read_req() function to have read value in the return value
> > (instead of in *val pointer). E.g.
> > 
> > static int dell_battery_read_req(const int type)
> > {
> > 	...
> > 	err = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> > 	if (err)
> > 		return err;
> > 
> > 	return buffer.output[1];
> > }
> > 
> 
> Good call, I'll change that.
> 
> 
> > > +
> > > +static int dell_battery_write_req(const int type, int val)
> > > +{
> > > +	struct calling_interface_buffer buffer;
> > > +	struct calling_interface_token *token;
> > > +
> > > +	token = dell_smbios_find_token(type);
> > > +	if (!token)
> > > +		return -ENODEV;
> > > +
> > > +	dell_fill_request(&buffer, token->location, val, 0, 0);
> > > +	return dell_send_request(&buffer,
> > > +			CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> > > +}
> > > +
> > > +/* The rules: the minimum start charging value is 50%. The maximum
> > > + * start charging value is 95%. The minimum end charging value is
> > > + * 55%. The maximum end charging value is 100%. And finally, there
> > > + * has to be at least a 5% difference between start & end values.
> > > + */
> > > +#define CHARGE_START_MIN	50
> > > +#define CHARGE_START_MAX	95
> > > +#define CHARGE_END_MIN		55
> > > +#define CHARGE_END_MAX		100
> > > +#define CHARGE_MIN_DIFF		5
> > > +
> > > +static int dell_battery_custom_set(const int type, int val)
> > > +{
> > > +	if (type == BAT_CUSTOM_CHARGE_START) {
> > > +		int end = CHARGE_END_MAX;
> > > +
> > > +		if (val < CHARGE_START_MIN)
> > > +			val = CHARGE_START_MIN;
> > > +		else if (val > CHARGE_START_MAX)
> > > +			val = CHARGE_START_MAX;
> > > +
> > > +		dell_battery_read_req(BAT_CUSTOM_CHARGE_END, &end);  
> > 
> > Missing check for failure of dell_battery_read_req.
> 
> This is intentional; it's just a sanity check, we don't need to bail
> if we hit a failure. I'll change the code to make that explicit
> though, as it's not currently clear.
> 
> 
> 
> > 
> > > +		if ((end - val) < CHARGE_MIN_DIFF)
> > > +			val = end - CHARGE_MIN_DIFF;
> > > +	} else if (type == BAT_CUSTOM_CHARGE_END) {
> > > +		int start = CHARGE_START_MIN;
> > > +
> > > +		if (val < CHARGE_END_MIN)
> > > +			val = CHARGE_END_MIN;
> > > +		else if (val > CHARGE_END_MAX)
> > > +			val = CHARGE_END_MAX;
> > > +
> > > +		dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);  
> > 
> > Missing check for failure of dell_battery_read_req.
> > 
> 
> Ditto.
> 
> 
> > > +		if ((val - start) < CHARGE_MIN_DIFF)
> > > +			val = start + CHARGE_MIN_DIFF;
> > > +	}
> > > +
> > > +	return dell_battery_write_req(type, val);
> > > +}
> > > +
> > > +static int battery_charging_mode_set(enum battery_charging_mode mode)
> > > +{
> > > +	int err;
> > > +
> > > +	switch (mode) {
> > > +	case DELL_BAT_MODE_STANDARD:
> > > +		err = dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
> > > +		break;
> > > +	case DELL_BAT_MODE_EXPRESS:
> > > +		err = dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
> > > +		break;
> > > +	case DELL_BAT_MODE_PRIMARILY_AC:
> > > +		err = dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
> > > +		break;
> > > +	case DELL_BAT_MODE_ADAPTIVE:
> > > +		err = dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
> > > +		break;
> > > +	case DELL_BAT_MODE_CUSTOM:
> > > +		err = dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
> > > +		break;
> > > +	default:
> > > +		err = -EINVAL;
> > > +	}
> > > +
> > > +	return err;
> > > +}  
> > 
> > You can make whole function smaller by avoiding err variable:
> > 
> > static int battery_charging_mode_set(enum battery_charging_mode mode)
> > {
> > 	switch (mode) {
> > 	case DELL_BAT_MODE_STANDARD:
> > 		return dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
> > 	case DELL_BAT_MODE_EXPRESS:
> > 		return dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
> > 	case DELL_BAT_MODE_PRIMARILY_AC:
> > 		return dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
> > 	case DELL_BAT_MODE_ADAPTIVE:
> > 		return dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
> > 	case DELL_BAT_MODE_CUSTOM:
> > 		return dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
> > 	default:
> > 		return -EINVAL;
> > 	}
> > }
> >
> 
> Okay, I'll change it.
> 
>  
> > > +
> > > +static ssize_t charge_type_show(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	enum battery_charging_mode mode;
> > > +	ssize_t count = 0;
> > > +
> > > +	for (mode = DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode++) {
> > > +		if (battery_state[mode]) {
> > > +			count += sysfs_emit_at(buf, count,
> > > +				mode == bat_chg_current ? "[%s] " : "%s ",
> > > +				battery_state[mode]);
> > > +		}
> > > +	}
> > > +
> > > +	/* convert the last space to a newline */
> > > +	count--;
> > > +	count += sysfs_emit_at(buf, count, "\n");  
> > 
> > Here is missing protection in the case when number of valid modes is
> > zero, so count is 0 and buf was untouched.
> > 
> 
> This will never be zero (based on the hardcoded value of DELL_BAT_MODE_MAX),

Now I see. You are iterating over members of constant array battery_state[].
I overlooked it and I thought that this iteration over mode values.

What about writing the for- conditions to be visible that you are
iterating over the array? E.g.

	size_t i;
	...
	for (i = 0; i < ARRAY_SIZE(battery_state); i++) {
		if (!battery_state[i])
			continue;
		count += sysfs_emit_at(buf, count, i == bat_chg_current ? "[%s] " : "%s ", battery_state[i]);
	}
	...

This has an advantage that you do not depend on DELL_BAT_MODE_MAX value,
compiler will calculate upper bound automatically.

Or another way. You can define array of tokens, like it is done for
keyboard backlight. See how the array kbd_tokens[] is used.

With this approach you can completely get rid of the DELL_BAT_MODE_MAX.

> but perhaps a static_assert or BUILD_BUG_ON to verify that the number of
> modes > 0?

I think it is not needed.

>   
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static ssize_t charge_type_store(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		const char *buf, size_t size)
> > > +{
> > > +	enum battery_charging_mode mode;
> > > +	const char *label;
> > > +	int ret = -EINVAL;
> > > +
> > > +	for (mode = DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode++) {
> > > +		label = battery_state[mode];
> > > +		if (label && sysfs_streq(label, buf))
> > > +			break;
> > > +	}
> > > +
> > > +	if (mode > DELL_BAT_MODE_NONE && mode < DELL_BAT_MODE_MAX) {
> > > +		ret = battery_charging_mode_set(mode);
> > > +		if (!ret) {
> > > +			bat_chg_current = mode;
> > > +			ret = size;
> > > +		}
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t charge_control_start_threshold_show(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	int ret, start;
> > > +
> > > +	ret = dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
> > > +	if (!ret)
> > > +		ret = sysfs_emit(buf, "%d\n", start);
> > > +
> > > +	return ret;
> > > +}  
> > 
> > This function and also following 3 functions have unusual error
> > handling. Normally error handling is done by early return, as:
> > 
> >     ret = func1();
> >     if (ret)
> >         return ret;
> > 
> >     ret = func2();
> >     if (ret)
> >         return ret;
> > 
> >     return 0;
> > 
> > You can change it something like:
> > 
> > {
> > 	int ret, start;
> > 
> > 	ret = dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
> > 	if (ret)
> > 		return ret;
> > 
> > 	return sysfs_emit(buf, "%d\n", start);
> > }
> > 
> 
> Okay.
> 
> 
> > > +static ssize_t charge_control_start_threshold_store(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		const char *buf, size_t size)
> > > +{
> [...]
> 
> > > +
> > > +static void __init dell_battery_init(struct device *dev)
> > > +{
> > > +	enum battery_charging_mode current_mode = DELL_BAT_MODE_NONE;
> > > +
> > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> > > +	if (current_mode != DELL_BAT_MODE_NONE) {  
> > 
> > I quite do not understand how is this code suppose to work.
> > 
> > Why is there mix of custom kernel enum battery_charging_mode and return
> > value from Dell's API?
> 
> This is from the original patch from Dell; tbh, I'm not sure. It does
> work, though. That is, current_mode ends up holding the correct value
> based on what was previously set, even if the charging mode is set from
> the BIOS.
> 
> I just scanned through the libsmbios code to see what it's doing, and
> it appears to loop through every charging mode to check if its active.
> I'm not really sure that makes much more sense, so I'll try some more
> tests.

Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
this type scan. If I remember correctly, for every keyboard backlight
token we just know the boolean value - if the token is set or not.

It would really nice to see what (raw) value is returned by the
dell_battery_read_req(token) function for every battery token and for
every initial state.

Because it is really suspicious if dell_battery_read_req() would return
value of the enum battery_charging_mode (as this is kernel enum).


Also another important thing. In past it was possible to buy from Dell
special batteries with long warranty (3+ years). I'm not sure if these
batteries are still available for end-user customers. With this type of
battery, it was not possible to change charging mode to ExpressCharge
(bios option was fade-out). I do not have such battery anymore, but I
would expect that the firmware disabled BAT_EXPRESS_MODE_TOKEN as mark
it as unavailable.

I think that we should scan list of available tokens, like it is done
for keyboard backlight in kbd_init_tokens(). And export via sysfs only
those battery modes for which there is available token.

> 
> > 
> > My feeling is that dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN) checks
> > if the token BAT_CUSTOM_MODE_TOKEN is set or not.
> > 
> > Could you please check what is stored in every BAT_*_MODE_TOKEN token at
> > this init stage?
> > 
> > I think it should work similarly, like keyboard backlight tokens as
> > implemented in functions: kbd_set_token_bit, kbd_get_token_bit,
> > kbd_get_first_active_token_bit.
> > 
> > > +		bat_chg_current = current_mode;
> > > +		battery_hook_register(&dell_battery_hook);
> > > +	}
> > > +}
> > > +
> [...]
> 
> > >  #define GLOBAL_MUTE_ENABLE	0x058C
> > >  #define GLOBAL_MUTE_DISABLE	0x058D
> > >  
> > > +enum battery_charging_mode {
> > > +	DELL_BAT_MODE_NONE = 0,
> > > +	DELL_BAT_MODE_STANDARD,
> > > +	DELL_BAT_MODE_EXPRESS,
> > > +	DELL_BAT_MODE_PRIMARILY_AC,
> > > +	DELL_BAT_MODE_ADAPTIVE,
> > > +	DELL_BAT_MODE_CUSTOM,
> > > +	DELL_BAT_MODE_MAX,
> > > +};
> > > +  
> > 
> > I think that this is just an internal driver enum, not Dell API. So this
> > enum should be in the dell-laptop.c file.
> > 
> 
> Agreed, I'll change it.
> 
> 
> 
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

