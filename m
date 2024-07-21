Return-Path: <linux-pm+bounces-11270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4293833F
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 04:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FD72813B3
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 02:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459F139D;
	Sun, 21 Jul 2024 02:06:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0001396;
	Sun, 21 Jul 2024 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721527576; cv=none; b=Dmrkjth9YIJ9oyoifjipo5ctWewdltu99yUr3wzITeNF4QDLQrsXONTFFzekz5na+KFnLBGNu4ZjIOGJstqXnawexYPCtwEw4fbbTEbiW5LhlKsz1F+fQQlfHksPy1eM6mxG047kjGlGo8jvvIDNTzoL6zMjc8R4pI8DMRUJPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721527576; c=relaxed/simple;
	bh=j6wDrTm4fG5Noo6HKl4B9hE3bi5WT6wHqEMyqQNgyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2ShFcyBWQpAzNI7tVggt2nHfba/ehDYT+yvF5aEmyV9g+SreeEE/5454XmhppTNabM+7pqK/At9lDfcMf86kRPgUoN9ae+SHXYCFhPdrouEcAUoEwIaMgjzMfytDwQA7ceJ0Q8WUgIoxoh6YdYoIbAheM9AQ9SDuGVDac9pwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id E9C1B11594C; Sat, 20 Jul 2024 22:06:13 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 75D4011593F;
	Sat, 20 Jul 2024 22:06:10 -0400 (EDT)
Date: Sat, 20 Jul 2024 22:06:06 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240720220606.1934df43@5400>
In-Reply-To: <20240720095507.uyaotkofkyasdgbd@pali>
References: <20240720012220.26d62a54@5400>
	<20240720084019.hrnd4wgt4muorydp@pali>
	<20240720052419.73b1415a@5400>
	<20240720095507.uyaotkofkyasdgbd@pali>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Sat, 20 Jul 2024 11:55:07 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:
> > Thanks for the quick feedback! Responses below.
> >=20
> > On Sat, 20 Jul 2024 10:40:19 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > Hello,
> > >=20
> > > I looked at your patch. I wrote some comments below. The main issue is
> > > how to correctly interpret read token values.
> > > =20
[...]
> > > > +
> > > > +static ssize_t charge_type_show(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		char *buf)
> > > > +{
> > > > +	enum battery_charging_mode mode;
> > > > +	ssize_t count =3D 0;
> > > > +
> > > > +	for (mode =3D DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; m=
ode++) {
> > > > +		if (battery_state[mode]) {
> > > > +			count +=3D sysfs_emit_at(buf, count,
> > > > +				mode =3D=3D bat_chg_current ? "[%s] " : "%s ",
> > > > +				battery_state[mode]);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	/* convert the last space to a newline */
> > > > +	count--;
> > > > +	count +=3D sysfs_emit_at(buf, count, "\n");   =20
> > >=20
> > > Here is missing protection in the case when number of valid modes is
> > > zero, so count is 0 and buf was untouched.
> > >  =20
> >=20
> > This will never be zero (based on the hardcoded value of DELL_BAT_MODE_=
MAX), =20
>=20
> Now I see. You are iterating over members of constant array battery_state=
[].
> I overlooked it and I thought that this iteration over mode values.
>=20
> What about writing the for- conditions to be visible that you are
> iterating over the array? E.g.
>=20
> 	size_t i;
> 	...
> 	for (i =3D 0; i < ARRAY_SIZE(battery_state); i++) {
> 		if (!battery_state[i])
> 			continue;
> 		count +=3D sysfs_emit_at(buf, count, i =3D=3D bat_chg_current ? "[%s] "=
 : "%s ", battery_state[i]);
> 	}
> 	...
>=20
> This has an advantage that you do not depend on DELL_BAT_MODE_MAX value,
> compiler will calculate upper bound automatically.
>=20
> Or another way. You can define array of tokens, like it is done for
> keyboard backlight. See how the array kbd_tokens[] is used.
>=20
> With this approach you can completely get rid of the DELL_BAT_MODE_MAX.
>=20

See below for a question about charge_type_store() if we get rid of
DELL_BAT_MODE_MAX.

> > but perhaps a static_assert or BUILD_BUG_ON to verify that the number of
> > modes > 0? =20
>=20
> I think it is not needed.
>=20
> >    =20
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static ssize_t charge_type_store(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		const char *buf, size_t size)
> > > > +{
> > > > +	enum battery_charging_mode mode;
> > > > +	const char *label;
> > > > +	int ret =3D -EINVAL;
> > > > +
> > > > +	for (mode =3D DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; m=
ode++) {
> > > > +		label =3D battery_state[mode];
> > > > +		if (label && sysfs_streq(label, buf))
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	if (mode > DELL_BAT_MODE_NONE && mode < DELL_BAT_MODE_MAX) {
> > > > +		ret =3D battery_charging_mode_set(mode);
> > > > +		if (!ret) {
> > > > +			bat_chg_current =3D mode;
> > > > +			ret =3D size;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}

Here we're using DELL_BAT_MODE_MAX to determine if we failed to match
any mode strings sent from the user. If we get rid of that, we're either
going to have to use a separate variable (eg, 'bool matched =3D false;' and
set it to true in case of a match), or iterate backwards (eg,
for (mode =3D ARRAY_SIZE(battery_state); mode >=3D DELL_BAT_MODE_NONE; mode=
--) {
	...
}
if (mode !=3D DELL_BAT_MODE_NONE) {
	ret =3D battery_charging_mode_set(mode);


Do you have a preference?


[...]
> > > > +static ssize_t charge_control_start_threshold_store(struct device =
*dev,
> > > > +		struct device_attribute *attr,
> > > > +		const char *buf, size_t size)
> > > > +{ =20
> > [...]
> >  =20
> > > > +
> > > > +static void __init dell_battery_init(struct device *dev)
> > > > +{
> > > > +	enum battery_charging_mode current_mode =3D DELL_BAT_MODE_NONE;
> > > > +
> > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mod=
e);
> > > > +	if (current_mode !=3D DELL_BAT_MODE_NONE) {   =20
> > >=20
> > > I quite do not understand how is this code suppose to work.
> > >=20
> > > Why is there mix of custom kernel enum battery_charging_mode and retu=
rn
> > > value from Dell's API? =20
> >=20
> > This is from the original patch from Dell; tbh, I'm not sure. It does
> > work, though. That is, current_mode ends up holding the correct value
> > based on what was previously set, even if the charging mode is set from
> > the BIOS.
> >=20
> > I just scanned through the libsmbios code to see what it's doing, and
> > it appears to loop through every charging mode to check if its active.
> > I'm not really sure that makes much more sense, so I'll try some more
> > tests. =20
>=20
> Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
> this type scan. If I remember correctly, for every keyboard backlight
> token we just know the boolean value - if the token is set or not.
>=20
> It would really nice to see what (raw) value is returned by the
> dell_battery_read_req(token) function for every battery token and for
> every initial state.

I checked this. The BIOS sets the mode value in every related token
location. I'm still not really sure what libsmbios is doing, but the
kernel code seems to arbitrarily choose one of the token locations
to read from. This makes sense to me now.

In the BIOS when I set the mode to "ExpressCharge",
this what I pulled for each token location:

[    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN value: 2
[    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN value: 2
[    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN value: 2
[    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN value: 2
[    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN value: 2

Similar story when I set it to Custom (all were '5'), or Standard ('1').
When I set it from linux as well, it changed all location values.

>=20
> Because it is really suspicious if dell_battery_read_req() would return
> value of the enum battery_charging_mode (as this is kernel enum).
>=20
>=20
> Also another important thing. In past it was possible to buy from Dell
> special batteries with long warranty (3+ years). I'm not sure if these
> batteries are still available for end-user customers. With this type of
> battery, it was not possible to change charging mode to ExpressCharge
> (bios option was fade-out). I do not have such battery anymore, but I
> would expect that the firmware disabled BAT_EXPRESS_MODE_TOKEN as mark
> it as unavailable.
>=20
> I think that we should scan list of available tokens, like it is done
> for keyboard backlight in kbd_init_tokens(). And export via sysfs only
> those battery modes for which there is available token.

I agree, but I'm not seeing a way to do that right now given how the
BIOS sets the mode. Maybe libsmbios has some clues...





--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

