Return-Path: <linux-pm+bounces-11267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E2938035
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 11:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234371F217EE
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CB47F7F;
	Sat, 20 Jul 2024 09:24:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6E26AEC;
	Sat, 20 Jul 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467467; cv=none; b=rF4dHuSuJEzeI+5ek8BsmQuLvhesOGCasQP9WtvMsoRpEVANU2ovNePXa8DMyqGG5w6qhWKNZLTIJUMt2AMD1V+sB5DnvPa7v/sR8kqkpCnDJo8uRBWLF2myfswf9MUw03nZ9gHsBgtX48SqXd+kPvzpGENx7w5t2UEk4QYNyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467467; c=relaxed/simple;
	bh=UQnnijyW5sgJHT8ZNbLP+eYW+7Z6U3TK40QFtcFcrus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjs7r90LsJTBiKF4xm2Rpt0gwqdO6q246XnKXNGUrW5PLM7PTTiezXtbF861OAWl5okmWDmunM+IosNxUjRBdgSPfdLYxHtxefxqyjXDJ5uwOYfh5ZrNampLuzPXWjpl86j5jl2xe2CD2cpFOJiH0YUEom7hsnuc88rxF2s7020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 9D2961158F6; Sat, 20 Jul 2024 05:24:25 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 64D81112CCB;
	Sat, 20 Jul 2024 05:24:24 -0400 (EDT)
Date: Sat, 20 Jul 2024 05:24:19 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240720052419.73b1415a@5400>
In-Reply-To: <20240720084019.hrnd4wgt4muorydp@pali>
References: <20240720012220.26d62a54@5400>
	<20240720084019.hrnd4wgt4muorydp@pali>
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

Thanks for the quick feedback! Responses below.

On Sat, 20 Jul 2024 10:40:19 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Hello,
>=20
> I looked at your patch. I wrote some comments below. The main issue is
> how to correctly interpret read token values.
>
[...]

>=20
> dell_send_request() returns negative value on error. As the read value
> seems to be always non-negative number, you can change API of the
> dell_battery_read_req() function to have read value in the return value
> (instead of in *val pointer). E.g.
>=20
> static int dell_battery_read_req(const int type)
> {
> 	...
> 	err =3D dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> 	if (err)
> 		return err;
>=20
> 	return buffer.output[1];
> }
>=20

Good call, I'll change that.


> > +
> > +static int dell_battery_write_req(const int type, int val)
> > +{
> > +	struct calling_interface_buffer buffer;
> > +	struct calling_interface_token *token;
> > +
> > +	token =3D dell_smbios_find_token(type);
> > +	if (!token)
> > +		return -ENODEV;
> > +
> > +	dell_fill_request(&buffer, token->location, val, 0, 0);
> > +	return dell_send_request(&buffer,
> > +			CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> > +}
> > +
> > +/* The rules: the minimum start charging value is 50%. The maximum
> > + * start charging value is 95%. The minimum end charging value is
> > + * 55%. The maximum end charging value is 100%. And finally, there
> > + * has to be at least a 5% difference between start & end values.
> > + */
> > +#define CHARGE_START_MIN	50
> > +#define CHARGE_START_MAX	95
> > +#define CHARGE_END_MIN		55
> > +#define CHARGE_END_MAX		100
> > +#define CHARGE_MIN_DIFF		5
> > +
> > +static int dell_battery_custom_set(const int type, int val)
> > +{
> > +	if (type =3D=3D BAT_CUSTOM_CHARGE_START) {
> > +		int end =3D CHARGE_END_MAX;
> > +
> > +		if (val < CHARGE_START_MIN)
> > +			val =3D CHARGE_START_MIN;
> > +		else if (val > CHARGE_START_MAX)
> > +			val =3D CHARGE_START_MAX;
> > +
> > +		dell_battery_read_req(BAT_CUSTOM_CHARGE_END, &end); =20
>=20
> Missing check for failure of dell_battery_read_req.

This is intentional; it's just a sanity check, we don't need to bail
if we hit a failure. I'll change the code to make that explicit
though, as it's not currently clear.



>=20
> > +		if ((end - val) < CHARGE_MIN_DIFF)
> > +			val =3D end - CHARGE_MIN_DIFF;
> > +	} else if (type =3D=3D BAT_CUSTOM_CHARGE_END) {
> > +		int start =3D CHARGE_START_MIN;
> > +
> > +		if (val < CHARGE_END_MIN)
> > +			val =3D CHARGE_END_MIN;
> > +		else if (val > CHARGE_END_MAX)
> > +			val =3D CHARGE_END_MAX;
> > +
> > +		dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start); =20
>=20
> Missing check for failure of dell_battery_read_req.
>=20

Ditto.


> > +		if ((val - start) < CHARGE_MIN_DIFF)
> > +			val =3D start + CHARGE_MIN_DIFF;
> > +	}
> > +
> > +	return dell_battery_write_req(type, val);
> > +}
> > +
> > +static int battery_charging_mode_set(enum battery_charging_mode mode)
> > +{
> > +	int err;
> > +
> > +	switch (mode) {
> > +	case DELL_BAT_MODE_STANDARD:
> > +		err =3D dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
> > +		break;
> > +	case DELL_BAT_MODE_EXPRESS:
> > +		err =3D dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
> > +		break;
> > +	case DELL_BAT_MODE_PRIMARILY_AC:
> > +		err =3D dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
> > +		break;
> > +	case DELL_BAT_MODE_ADAPTIVE:
> > +		err =3D dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
> > +		break;
> > +	case DELL_BAT_MODE_CUSTOM:
> > +		err =3D dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
> > +		break;
> > +	default:
> > +		err =3D -EINVAL;
> > +	}
> > +
> > +	return err;
> > +} =20
>=20
> You can make whole function smaller by avoiding err variable:
>=20
> static int battery_charging_mode_set(enum battery_charging_mode mode)
> {
> 	switch (mode) {
> 	case DELL_BAT_MODE_STANDARD:
> 		return dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
> 	case DELL_BAT_MODE_EXPRESS:
> 		return dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
> 	case DELL_BAT_MODE_PRIMARILY_AC:
> 		return dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
> 	case DELL_BAT_MODE_ADAPTIVE:
> 		return dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
> 	case DELL_BAT_MODE_CUSTOM:
> 		return dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
> 	default:
> 		return -EINVAL;
> 	}
> }
>

Okay, I'll change it.

=20
> > +
> > +static ssize_t charge_type_show(struct device *dev,
> > +		struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	enum battery_charging_mode mode;
> > +	ssize_t count =3D 0;
> > +
> > +	for (mode =3D DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode+=
+) {
> > +		if (battery_state[mode]) {
> > +			count +=3D sysfs_emit_at(buf, count,
> > +				mode =3D=3D bat_chg_current ? "[%s] " : "%s ",
> > +				battery_state[mode]);
> > +		}
> > +	}
> > +
> > +	/* convert the last space to a newline */
> > +	count--;
> > +	count +=3D sysfs_emit_at(buf, count, "\n"); =20
>=20
> Here is missing protection in the case when number of valid modes is
> zero, so count is 0 and buf was untouched.
>=20

This will never be zero (based on the hardcoded value of DELL_BAT_MODE_MAX),
but perhaps a static_assert or BUILD_BUG_ON to verify that the number of
modes > 0?

 =20
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t charge_type_store(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf, size_t size)
> > +{
> > +	enum battery_charging_mode mode;
> > +	const char *label;
> > +	int ret =3D -EINVAL;
> > +
> > +	for (mode =3D DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode+=
+) {
> > +		label =3D battery_state[mode];
> > +		if (label && sysfs_streq(label, buf))
> > +			break;
> > +	}
> > +
> > +	if (mode > DELL_BAT_MODE_NONE && mode < DELL_BAT_MODE_MAX) {
> > +		ret =3D battery_charging_mode_set(mode);
> > +		if (!ret) {
> > +			bat_chg_current =3D mode;
> > +			ret =3D size;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t charge_control_start_threshold_show(struct device *dev,
> > +		struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	int ret, start;
> > +
> > +	ret =3D dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
> > +	if (!ret)
> > +		ret =3D sysfs_emit(buf, "%d\n", start);
> > +
> > +	return ret;
> > +} =20
>=20
> This function and also following 3 functions have unusual error
> handling. Normally error handling is done by early return, as:
>=20
>     ret =3D func1();
>     if (ret)
>         return ret;
>=20
>     ret =3D func2();
>     if (ret)
>         return ret;
>=20
>     return 0;
>=20
> You can change it something like:
>=20
> {
> 	int ret, start;
>=20
> 	ret =3D dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
> 	if (ret)
> 		return ret;
>=20
> 	return sysfs_emit(buf, "%d\n", start);
> }
>=20

Okay.


> > +static ssize_t charge_control_start_threshold_store(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf, size_t size)
> > +{
[...]

> > +
> > +static void __init dell_battery_init(struct device *dev)
> > +{
> > +	enum battery_charging_mode current_mode =3D DELL_BAT_MODE_NONE;
> > +
> > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> > +	if (current_mode !=3D DELL_BAT_MODE_NONE) { =20
>=20
> I quite do not understand how is this code suppose to work.
>=20
> Why is there mix of custom kernel enum battery_charging_mode and return
> value from Dell's API?

This is from the original patch from Dell; tbh, I'm not sure. It does
work, though. That is, current_mode ends up holding the correct value
based on what was previously set, even if the charging mode is set from
the BIOS.

I just scanned through the libsmbios code to see what it's doing, and
it appears to loop through every charging mode to check if its active.
I'm not really sure that makes much more sense, so I'll try some more
tests.


>=20
> My feeling is that dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN) checks
> if the token BAT_CUSTOM_MODE_TOKEN is set or not.
>=20
> Could you please check what is stored in every BAT_*_MODE_TOKEN token at
> this init stage?
>=20
> I think it should work similarly, like keyboard backlight tokens as
> implemented in functions: kbd_set_token_bit, kbd_get_token_bit,
> kbd_get_first_active_token_bit.
>=20
> > +		bat_chg_current =3D current_mode;
> > +		battery_hook_register(&dell_battery_hook);
> > +	}
> > +}
> > +
[...]

> >  #define GLOBAL_MUTE_ENABLE	0x058C
> >  #define GLOBAL_MUTE_DISABLE	0x058D
> > =20
> > +enum battery_charging_mode {
> > +	DELL_BAT_MODE_NONE =3D 0,
> > +	DELL_BAT_MODE_STANDARD,
> > +	DELL_BAT_MODE_EXPRESS,
> > +	DELL_BAT_MODE_PRIMARILY_AC,
> > +	DELL_BAT_MODE_ADAPTIVE,
> > +	DELL_BAT_MODE_CUSTOM,
> > +	DELL_BAT_MODE_MAX,
> > +};
> > + =20
>=20
> I think that this is just an internal driver enum, not Dell API. So this
> enum should be in the dell-laptop.c file.
>=20

Agreed, I'll change it.




--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

