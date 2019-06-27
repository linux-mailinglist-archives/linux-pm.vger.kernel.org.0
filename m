Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58F958A16
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0Sh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 14:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfF0Sh4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 14:37:56 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93EC22064A;
        Thu, 27 Jun 2019 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561660675;
        bh=WtgVWv3h3e6GjUeYM72+oOL3QStDuHufllKTBP4Cqjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GblNFDB4+qPQZ2cNTxdiAQ8mhnWmjEhqcOFBbvX5LW7NPvYajqpwl6iBWf6XGGn9Y
         UEQt+CsfWcbMOSS+teKpMqLOs+HpsGVS23yuUohkkradaXvMtrDPoTDzejSw39uBK7
         VjRf4ciUwyl90j95mp7yV/jNna4htgYcUsDgXqHc=
Received: by earth.universe (Postfix, from userid 1000)
        id 4ED403C08D5; Thu, 27 Jun 2019 20:37:52 +0200 (CEST)
Date:   Thu, 27 Jun 2019 20:37:52 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Benson Leung <bleung@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sameer Nanda <snanda@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Adam.Thomson.Opensource@diasemi.com,
        Collabora Kernel ML <kernel@collabora.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 1/2] power: supply: add input power and voltage limit
 properties
Message-ID: <20190627183752.4amfttcvd7bswom6@earth.universe>
References: <20190507095248.17915-1-enric.balletbo@collabora.com>
 <20190523195438.GA110498@google.com>
 <CAFqH_52mdHKGN6gA3HuRJrcBvG1GpE+LzAyLgJD_xeZAiHruFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e4ghregrusiggzmz"
Content-Disposition: inline
In-Reply-To: <CAFqH_52mdHKGN6gA3HuRJrcBvG1GpE+LzAyLgJD_xeZAiHruFw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e4ghregrusiggzmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just queued both patches. Thanks for the detailed description and
documentation.

-- Sebastian

On Tue, Jun 25, 2019 at 12:04:13PM +0200, Enric Balletbo Serra wrote:
> Hi Sebastian, Pavel,
>=20
> Missatge de Benson Leung <bleung@google.com> del dia dj., 23 de maig
> 2019 a les 21:55:
> >
> > Hi Enric,
> >
> > On Tue, May 07, 2019 at 11:52:47AM +0200, Enric Balletbo i Serra wrote:
> > > For thermal management strategy you might be interested on limit the
> > > input power for a power supply. We already have current limit but
> > > basically what we probably want is to limit power. So, introduce the
> > > input_power_limit property.
> > >
> > > Although the common use case is limit the input power, in some
> > > specific cases it is the voltage that is problematic (i.e some regula=
tors
> > > have different efficiencies at higher voltage resulting in more heat).
> > > So introduce also the input_voltage_limit property.
> > >
> > > This happens in one Chromebook and is used on the Pixel C's thermal
> > > management strategy to effectively limit the input power to 5V 3A when
> > > the screen is on. When the screen is on, the display, the CPU, and th=
e GPU
> > > all contribute more heat to the system than while the screen is off, =
and
> > > we made a tradeoff to throttle the charger in order to give more of t=
he
> > > thermal budget to those other components.
> > >
> > > So there's nothing fundamentally broken about the hardware that would
> > > cause the Pixel C to malfunction if we were charging at 9V or 12V ins=
tead
> > > of 5V when the screen is on, i.e. if userspace doesn't change this.
> > >
> > > What would happen is that you wouldn't meet Google's skin temperature
> > > targets on the system if the charger was allowed to run at 9V or 12V =
with
> > > the screen on.
> > >
> > > For folks hacking on Pixel Cs (which is now outside of Google's offic=
ial
> > > support window for Android) and customizing their own kernel and user=
space
> > > this would be acceptable, but we wanted to expose this feature in the
> > > power supply properties because the feature does exist in the Emedded
> > > Controller firmware of the Pixel C and all of Google's Chromebooks wi=
th
> > > USB-C made since 2015 in case someone running an up to date kernel wa=
nted
> > > to limit the charging power for thermal or other reasons.
> > >
> > > This patch exposes a new property, similar to input current limit, to
> > > re-configure the maximum voltage from the external supply at runtime
> > > based on system-level knowledge or user input.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> > > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> >
> > Reviewed-by: Benson Leung <bleung@chromium.org>
> >
>=20
> We're close to the merge window so I'm wondering if there are more
> concerns on this patchset?
>=20
> Thanks,
> ~ Enric
>=20
> > > ---
> > >
> > > Changes in v4:
> > > - Add also input_power_limit.
> > >
> > > Changes in v3:
> > > - Improve commit log and documentation with Benson comments.
> > >
> > > Changes in v2:
> > > - Document the new property in ABI/testing/sysfs-class-power.
> > > - Add the Reviewed-by Guenter Roeck tag.
> > >
> > >  Documentation/ABI/testing/sysfs-class-power | 32 +++++++++++++++++++=
++
> > >  Documentation/power/power_supply_class.txt  |  4 +++
> > >  drivers/power/supply/power_supply_sysfs.c   |  2 ++
> > >  include/linux/power_supply.h                |  2 ++
> > >  4 files changed, 40 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentat=
ion/ABI/testing/sysfs-class-power
> > > index 5e23e22dce1b..962a27a1daf8 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -331,10 +331,42 @@ Description:
> > >               supply. Normally this is configured based on the type of
> > >               connection made (e.g. A configured SDP should output a =
maximum
> > >               of 500mA so the input current limit is set to the same =
value).
> > > +             Use preferably input_power_limit, and for problems that=
 can be
> > > +             solved using power limit use input_current_limit.
> > >
> > >               Access: Read, Write
> > >               Valid values: Represented in microamps
> > >
> > > +What:                /sys/class/power_supply/<supply_name>/input_vol=
tage_limit
> > > +Date:                May 2019
> > > +Contact:     linux-pm@vger.kernel.org
> > > +Description:
> > > +             This entry configures the incoming VBUS voltage limit c=
urrently
> > > +             set in the supply. Normally this is configured based on
> > > +             system-level knowledge or user input (e.g. This is part=
 of the
> > > +             Pixel C's thermal management strategy to effectively li=
mit the
> > > +             input power to 5V when the screen is on to meet Google'=
s skin
> > > +             temperature targets). Note that this feature should not=
 be
> > > +             used for safety critical things.
> > > +             Use preferably input_power_limit, and for problems that=
 can be
> > > +             solved using power limit use input_voltage_limit.
> > > +
> > > +             Access: Read, Write
> > > +             Valid values: Represented in microvolts
> > > +
> > > +What:                /sys/class/power_supply/<supply_name>/input_pow=
er_limit
> > > +Date:                May 2019
> > > +Contact:     linux-pm@vger.kernel.org
> > > +Description:
> > > +             This entry configures the incoming power limit currentl=
y set
> > > +             in the supply. Normally this is configured based on
> > > +             system-level knowledge or user input. Use preferably th=
is
> > > +             feature to limit the incoming power and use current/vol=
tage
> > > +             limit only for problems that can be solved using power =
limit.
> > > +
> > > +             Access: Read, Write
> > > +             Valid values: Represented in microwatts
> > > +
> > >  What:                /sys/class/power_supply/<supply_name>/online,
> > >  Date:                May 2007
> > >  Contact:     linux-pm@vger.kernel.org
> > > diff --git a/Documentation/power/power_supply_class.txt b/Documentati=
on/power/power_supply_class.txt
> > > index 300d37896e51..1e3c705111db 100644
> > > --- a/Documentation/power/power_supply_class.txt
> > > +++ b/Documentation/power/power_supply_class.txt
> > > @@ -137,6 +137,10 @@ power supply object.
> > >
> > >  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Ind=
icates
> > >  the current drawn from a charging source.
> > > +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Ind=
icates
> > > +the voltage limit from a charging source.
> > > +INPUT_POWER_LIMIT - input power limit programmed by charger. Indicat=
es
> > > +the power limit from a charging source.
> > >
> > >  CHARGE_CONTROL_LIMIT - current charge control limit setting
> > >  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> > > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/powe=
r/supply/power_supply_sysfs.c
> > > index 5358a80d854f..860db617d241 100644
> > > --- a/drivers/power/supply/power_supply_sysfs.c
> > > +++ b/drivers/power/supply/power_supply_sysfs.c
> > > @@ -275,6 +275,8 @@ static struct device_attribute power_supply_attrs=
[] =3D {
> > >       POWER_SUPPLY_ATTR(charge_control_limit),
> > >       POWER_SUPPLY_ATTR(charge_control_limit_max),
> > >       POWER_SUPPLY_ATTR(input_current_limit),
> > > +     POWER_SUPPLY_ATTR(input_voltage_limit),
> > > +     POWER_SUPPLY_ATTR(input_power_limit),
> > >       POWER_SUPPLY_ATTR(energy_full_design),
> > >       POWER_SUPPLY_ATTR(energy_empty_design),
> > >       POWER_SUPPLY_ATTR(energy_full),
> > > diff --git a/include/linux/power_supply.h b/include/linux/power_suppl=
y.h
> > > index 2f9c201a54d1..ba135a5d8996 100644
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -122,6 +122,8 @@ enum power_supply_property {
> > >       POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
> > >       POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> > >       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> > > +     POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> > > +     POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
> > >       POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> > >       POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
> > >       POWER_SUPPLY_PROP_ENERGY_FULL,
> > > --
> > > 2.20.1
> > >
> >
> > --
> > Benson Leung
> > Staff Software Engineer
> > Chrome OS Kernel
> > Google Inc.
> > bleung@google.com
> > Chromium OS Project
> > bleung@chromium.org

--e4ghregrusiggzmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0VDQAACgkQ2O7X88g7
+pqkhhAAlWCKoKEY+olvQ7v5gHO3kZB0Z5j8HEgtWE7KbkzVR0RmMq+dm0w7jOcu
VNn9iYY/buXIRP/ey66XuQ8nYS/b9FGFsoxDsm7UVG9ps/7LTpgvhpIiN3hR5Aue
BvwkIbBrE4lJSEtwuKKskOMP4+tUh6SLxVIuWkYBi3j9iW8+TquKLzIk/VLDqLlF
jK+RlynXef5Ge+RNa8yAt0kz0GaRyDGIZf67FPQIvJ7qL/bjlsyJ21Bstq9wZqdf
Ny06XGiY4nerdJelxnPIbLZrcZx9M4mb+LJSmJJ1ZNE2ofTduPv3FT5zMI4vq8+K
/8aoKnp3DbpoQ/ubreqWAYpG1e/5Hs7kn1B3rDOXilOB4f96470f+ydDPzQ9aKuh
SYxWkVEFoi2RcfsaLkYSC2JLTrHJG3n0IGEAxfdiV2Zd5orSlVfoz59EJR75EUAc
nazikzvj62E2VHsUt3VvNpi1Gz2ojNhMqr2j4DJckvALujtORB38D65WfRlXbvej
tJ0GLs3ItHnwe961+GWQOC/V/Wyon821hvigrlRhJHh17VZCWEFL3WnAuw51NejF
F8VrrYbqkVNWCBTBEcjQ8L5RGz/uofBxg8g6mtHv7l+fSagk7KhVFO3N3Bm5FfJn
5rjIYw3/kID8EK7U82sMnG+QsR4TRJ8hqOeTtUXbZZV95rNmKHo=
=Cf/l
-----END PGP SIGNATURE-----

--e4ghregrusiggzmz--
