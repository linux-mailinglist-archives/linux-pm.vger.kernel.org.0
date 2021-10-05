Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D20422DDE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhJEQZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:25:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhJEQZq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:25:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 16F191F425D6
Received: by earth.universe (Postfix, from userid 1000)
        id 93B9D3C0CA7; Tue,  5 Oct 2021 18:23:52 +0200 (CEST)
Date:   Tue, 5 Oct 2021 18:23:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?utf-8?Q?Nicol=C3=B2?= Piazzalunga <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
Message-ID: <20211005162352.emaoveimhkp5uzfw@earth.universe>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ypvk6t7gfdphpnja"
Content-Disposition: inline
In-Reply-To: <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ypvk6t7gfdphpnja
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 29, 2021 at 11:38:12AM +0200, Hans de Goede wrote:
> On 9/28/21 10:11 PM, Nicol=F2 Piazzalunga wrote:
> > this is a proposal to introduce separate and standardized attributes
> > for force_discharge and inhibit_charge of a battery.
> > These are simpler than using status from a user-space perspective,
> > as discussed on the platform-driver-x86 mail list.
>=20
> To clarify things a bit here, the reasons for not using status for
> this are:
>=20
> 1. This would require adding new status-es which so far have never
> been seen by userspace, which will likely cause confusion of e.g.
> upower. IOW I believe that adding new status-es for this would
> be a userspace ABI break.

Some embedded devices have status writable and use existing status
and reset when adapter is replugged. That's why there are no extra
status already.

> 2. The devices where we currently want to use this functionality
> use the ACPI battery interface, which is standardized between
> vendors and dealt with by drivers/apci/battery.c  but this kinda
> extra functionality is vendor specific. The drivers/apci/battery.c
> has code allowing vendor drivers to "hook" ACPI batteries and get
> add/remove calls for them. Then in these calls currently the
> vendor drivers do:
>=20
> 	device_add_groups(&battery->dev, my_prop_group))
>=20
> Which allows them to register extra sysfs_attributes for
> for example charge_control_start_threshold and
> charge_control_end_threshold.
>=20
> This works well, but having vendor drivers somehow intercept /
> muck with the status handling in drivers/apci/battery.c is a
> non trival problem. Where as with new separate attributes
> this is already a solved problem.

The second argument is a very weak one. We do not accept bad
userspace API to avoid restructuring a driver. FWIW adding
attributes that way is already racy and a bug:

http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

The power-supply subsystem offers registering custom sysfs
files since a few kernel releases by setting up the following:

/* Run-time specific power supply configuration */
struct power_supply_config {
    ...
   	/* Device specific sysfs attributes */
	const struct attribute_group **attr_grp;
    ...
}

All drivers in drivers/power/supply/ have been converted and
the ACPI is one of the last drivers not using this.

> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 27 +++++++++++++++++++++
> >  drivers/power/supply/power_supply_sysfs.c   |  2 ++
> >  include/linux/power_supply.h                |  2 ++
> >  3 files changed, 31 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentatio=
n/ABI/testing/sysfs-class-power
> > index ca830c6cd809..2c5f48f49273 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -455,6 +455,33 @@ Description:
> >  			      "Unknown", "Charging", "Discharging",
> >  			      "Not charging", "Full"
> > =20
> > +What:		/sys/class/power_supply/<supply_name>/force_discharge
> > +Date:		September 2021
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Represents the forced discharging status of the battery.
> > +
> > +		Access: Read, Write
> > +
> > +		Valid values:
> > +			=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +			0: Force discharge while AC is attached
> > +			1: Terminate forced discharging
> > +
>=20
> I think you have 0 and 1 swapped here? I would expect 1 to be enable forc=
ed
> discharging and 0 be normal operation, iow only discharge when not on AC.

Considering some Thinkpads have two batteries the naming and
description of this is quite bad. Only the valid values part
suggests that this is just about AC.

> > +What:		/sys/class/power_supply/<supply_name>/inhibit_charge
> > +Date:		September 2021
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Represents the presence of a manual override over the threshold
> > +		attributes of the battery, thus inhibiting battery charge.

The first part is specific to thinkpad implementation.

> > +
> > +		Access: Read, Write
> > +
> > +		Valid values:
> > +			=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +			1: Stop charging
> > +			0: Terminate the override
> > +

I wonder if its better to put both into the same file, considering
that the only logical options are

 * 0 =3D no override (=3D charge when possible)
 * 1 =3D force idle
 * 2 =3D force discharge

I.e. forced discharge implies battery not being charged.

-- Sebastian

> >  What:		/sys/class/power_supply/<supply_name>/technology
> >  Date:		May 2007
> >  Contact:	linux-pm@vger.kernel.org
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index c3d7cbcd4fad..6e7303935810 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -136,6 +136,8 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[]=
 =3D {
> >  static struct power_supply_attr power_supply_attrs[] =3D {
> >  	/* Properties of type `int' */
> >  	POWER_SUPPLY_ENUM_ATTR(STATUS),
> > +	POWER_SUPPLY_ENUM_ATTR(FORCE_DISCHARGE),
> > +	POWER_SUPPLY_ENUM_ATTR(INHIBIT_CHARGE),
> >  	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
> >  	POWER_SUPPLY_ENUM_ATTR(HEALTH),
> >  	POWER_SUPPLY_ATTR(PRESENT),
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 9ca1f120a211..4340fe65df4d 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -96,6 +96,8 @@ enum {
> >  enum power_supply_property {
> >  	/* Properties of type `int' */
> >  	POWER_SUPPLY_PROP_STATUS =3D 0,
> > +	POWER_SUPPLY_PROP_FORCE_DISCHARGE,
> > +	POWER_SUPPLY_PROP_INHIBIT_CHARGE,
> >  	POWER_SUPPLY_PROP_CHARGE_TYPE,
> >  	POWER_SUPPLY_PROP_HEALTH,
> >  	POWER_SUPPLY_PROP_PRESENT,
> >=20
>=20
> Regards,
>=20
> Hans
>=20

--ypvk6t7gfdphpnja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFcfBQACgkQ2O7X88g7
+pr3/g//cdiacSUI6ucSueiJ6nMero8VDp7aT/T/v7Ooot5a9bv03Aemi+iihmRy
e8V8QC1xUYxte8NylUENs8J09WXd+ipqMO9rngjp3w6AWCQvbjVDxI0G1J0T3sR+
u5pZqEuiKuJZYlcYBs0YGu+O6XOd9qtcc/8GbIzd8WXfnQhovYiDsvaiaFS1mtgB
zgYeV3PmC8bXLYGtmzMtqtaaiDt4VPQnlC3A7Fjx4e+7rePQ0No2XRQOiDddcj27
GIAKQPxQeY7/HlJu/qL3fZ8e3fg2hpLputPn2BAF4j34OHUOBdLkarZCu9aIa6jr
RTQm9LMfZ8TkYBCwfF40I2iDJuL2pmFF94xEqPWHuiwx2bcqxh33gSHROYSMkV36
Pf6NIcdK8WZqx3xhyX5CazRg1wx2msfCLg43YvABKG4d8KMnPylP4S8BcYVdq8zq
6LZ87vYumQcwk86wIdSk6uYcR+/HisDt9obrNeweJrUepmQV+XMd2tuPPHEF8G9S
H7IUdHUTZJGbfenCTJ3U1DpPeM4YJYU2Im6oQ1NVdB3ed5ZseRcUCDsBQk0koe/A
3KuC4fYaTJB5uEmGtW+e+hQeNchfBVhBqmvm7AYtDbhlHn+Saem6uWDtMlNbyp2M
sVqrcJuCBvQ8qOvf08rDJoBL5KQXMaRKY9XYLNui9V1DBOoXd94=
=rRJG
-----END PGP SIGNATURE-----

--ypvk6t7gfdphpnja--
