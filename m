Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFDB446EF0
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhKFQ3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Nov 2021 12:29:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49840 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhKFQ3w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Nov 2021 12:29:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 548961F45641
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636216025; bh=njLeoKTzp5v0KsQV6uI0Ym0uiDEJl+S+cPk1tEuXLdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=km48YJbWt0GVgvflYKGrOFJgPTM4EG0RHPuoAH8+FMfA5TWbw1ihoK5x+sksj8d2V
         cn9gnx7JwIIIWOWk6dQxKHNR4m0zSACW4enAAPhT3IZY15WhRcBI9EjYkUwOWEgPKL
         wd85oxcrgeEWUREoQMpwafEgyZBoYZ+Fvu9x1+Qn5/tt6s5TEIvpSMILz9Ab/t6lK3
         zLGW8uTd0S22rZjlJUOynDCpg0WEtpts6tgiilPFXuD7KtDKbqgodSYVPKh5V5XSZW
         s8zDxniLFNbzJNLWQIMGK0QphhBmYvA8DsE3QYFvHv3Fo4BoOMws5So6oEyEg58Kbh
         8OnzKwfs07BQQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 63F8E3C0F95; Sat,  6 Nov 2021 17:27:03 +0100 (CET)
Date:   Sat, 6 Nov 2021 17:27:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Add kerneldoc to battery struct
Message-ID: <20211106162703.xjxsxdg3hrm7t3g3@earth.universe>
References: <20211105003026.970184-1-linus.walleij@linaro.org>
 <d296ee8c-f6f0-aa42-e261-ed631f598fd0@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfqkftfbnmikcljl"
Content-Disposition: inline
In-Reply-To: <d296ee8c-f6f0-aa42-e261-ed631f598fd0@infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dfqkftfbnmikcljl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 04, 2021 at 07:20:24PM -0700, Randy Dunlap wrote:
> Hi,
>=20
> On 11/4/21 5:30 PM, Linus Walleij wrote:
> > This complements the struct power_supply_battery_info with
> > extensive kerneldoc explaining the different semantics of the
> > fields, including an overview of the CC/CV charging concepts
> > implicit in some of the struct members.
> >=20
> > This is done to first establish semantics before I can
> > add more charging methods by breaking out the CC/CV parameters
> > to its own struct.
> >=20
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >   include/linux/power_supply.h | 209 +++++++++++++++++++++++++++++++----
> >   1 file changed, 186 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 9ca1f120a211..671730c5279f 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -342,37 +342,200 @@ struct power_supply_resistance_temp_table {
> >   #define POWER_SUPPLY_OCV_TEMP_MAX 20
> > -/*
> > +/**
> > + * struct power_supply_battery_info - information about batteries
> > + * @technology: from the POWER_SUPPLY_TECHNOLOGY_* enum
> > + * @energy_full_design_uwh: energy content when fully charged in micro=
watt
> > + *   hours
> > + * @charge_full_design_uah: charge content when fully charged in micro=
ampere
> > + *   hours
> > + * @voltage_min_design_uv: minimum voltage across the poles when the b=
attery
> > + *   is at minimum voltage level in microvolts. If the voltage drops b=
elow this
> > + *   level the battery will need precharging when using CC/CV charging.
> > + * @voltage_max_design_uv: voltage across the poles when the battery i=
s fully
> > + *   charged in microvolts. This is the "nominal voltage" i.e. the vol=
tage
> > + *   printed on the label of the battery.
> > + * @tricklecharge_current_ua: the tricklecharge current used when tric=
kle
> > + *   charging the battery in microamperes. This is the charging phase =
when the
> > + *   battery is fully charged and we just trickle in some current to k=
eep the
> > + *   voltage up between constant_charge_voltage_max_uv and overvoltage=
_limit_uv.
> > + * @precharge_current_ua: current to use in the precharge phase in mic=
roamperes,
> > + *   the precharge rate is limited by limiting the current to this val=
ue.
> > + * @precharge_voltage_max_uv: the maximum voltage allowed when prechar=
ging in
> > + *   microvolts. When we pass this voltage we will nominally switch ov=
er to the
> > + *   next charging phase defined by constant_charge_current_ua and
> > + *   constant_charge_voltage_max_uv.
> > + * @charge_term_current_ua: when the current in the CV (constant volta=
ge)
> > + *   charging phase drops below this value in microamperes the chargin=
g will
> > + *   terminate completely and not restart until the voltage over the b=
attery
> > + *   poles reach charge_restart_voltage_uv unless we use trickle charg=
ing.
> > + * @charge_restart_voltage_uv: when the battery has been fully charged=
 by
> > + *   CC/CV charging and charging has been disabled, and the voltage su=
bsequently
> > + *   drops below this value in microvolts, the charging will be restar=
ted
> > + *   (typically using CV charging).
> > + * @overvoltage_limit_uv: when tricklecharging the battery can tempora=
rily
> > + *   exceed the nominal voltage voltage_max_design_uv. The tricklechar=
ginging
> > + *   must stop when we reach this value, not to restart unless we get =
back
> > + *   down to constant_charge_voltage_max_uv.
> > + * @constant_charge_current_max_ua: current in microamperes to use in =
the CC
> > + *   (constant current) charging phase. The charging rate is limited
> > + *   by this current. This is the main charging phase and as the curre=
nt is
> > + *   constant into the battery the voltage slowly ascends to
> > + *   constant_charge_voltage_max_uv.
> > + * @constant_charge_voltage_max_uv: voltage in microvolts signifying t=
he end of
> > + *   the CC (constant current) charging phase and the beginning of the=
 CV
> > + *   (constant voltage) charging phase.
> > + * @factory_internal_resistance_uohm: the internal resistance of the b=
attery
> > + *   at fabrication time, expressed in microohms. This resistance will=
 vary
> > + *   depending on the lifetime and charge of the battery, so this is j=
ust a
> > + *   nominal ballpark figure.
> > + * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
> > + *   temperature indices. This is an array of temperatures in degrees =
celsius
>=20
>                                                            preferably    =
Celsius
>=20
> > + *   indicating which capacity table to used for a certain temperature=
, since
> > + *   the capacity for reasons of chemistry will be different at differ=
ent
> > + *   temperatures. Determining capacity is a multivariate problem and =
the
> > + *   temperature is the first variable we determine.
> > + * @temp_ambient_alert_min: the battery will go outside of operating c=
onditions
> > + *   when the ambient temperature goes below this temperature in degre=
es
> > + *   celsius.
> > + * @temp_ambient_alert_max: the battery will go outside of operating c=
onditions
> > + *   when the ambient temperature goes above this temperature in degre=
es
> > + *   celsius.
>=20
> Ditto. et al.
>=20
> > + * @temp_alert_min: the battery should issue an alert if the internal
> > + *   temperature goes below this temperature in degrees celsius.
> > + * @temp_alert_max: the battery should issue an alert if the internal
> > + *   temperature goes above this temperature in degrees celsius.
> > + * @temp_min: the battery will go outside of operating conditions when
> > + *   the internal temperature goes below this temperature in degrees c=
elsius.
> > + *   Normally this means the system should shut down.
> > + * @temp_max: the battery will go outside of operating conditions when
> > + *   the internal temperature goes above this temperature in degrees c=
elsius.
> > + *   Normally this means the system should shut down.
> > + * @ocv_table: for each entry in ocv_temp there is a corresponding ent=
ry in
> > + *   ocv_table and a size for each entry in ocv_table_size. These arra=
ys
> > + *   determine the capacity in percent in relation to the voltage in m=
icrovolts
> > + *   at the indexed temperature.
> > + * @ocv_table_size: for each entry in ocv_temp this array is giving th=
e size of
> > + *   each entry in the array of capacity arrays in ocv_table.
> > + * @resist_table: this is a table that correlates a resistance to an i=
nternal
> > + *   temperature of a battery. This can be achieved by a separate ther=
mistor to
> > + *   supply voltage on a third terminal on a battery which is the most
> > + *   reliable. An external thermistor can also be used sometimes.
> > + * @resist_table_size: the number of items in the resist table.
> > + *
> >    * This is the recommended struct to manage static battery parameters,
> >    * populated by power_supply_get_battery_info(). Most platform driver=
s should
> >    * use these for consistency.
> > + *
> >    * Its field names must correspond to elements in enum power_supply_p=
roperty.
> >    * The default field value is -EINVAL.
> > - * Power supply class itself doesn't use this.
> > + *
> > + * The charging parameters here assumes a CC/CV charging scheme. This =
method
>=20
>                                    assume
>=20
> > + * is most common with Lithium Ion batteries (other methods are possib=
le) and
> > + * looks as follows:
> > + *
> > + * ^ Battery voltage
> ...
> > + * +------------------------------------------------------------------=
> time
> > + *
> > + * ^ Current into the battery
> ...
> > + * +----------------------------------------------------------------->=
 time
> > + *
> > + * These diagrams are synchronized on time and the voltage and current
> > + * follow each other.
> > + *
> > + * With CC/CV charging commence over time like this for an empty batte=
ry:
> > + *
> > + * 1. First a small initial pre-charge current (precharge_current_ua)
> > + *    is applied if the voltage is below precharge_voltage_max_uv unti=
l we
> > + *    reach precharge_voltage_max_uv. CATION: in some text this is ref=
erred
>=20
>                                          CAUTION:        texts
> (although CATION is a word!)
>=20
> > + *    to as "trickle charging" but the use in the Linux kernel is diff=
eren
>=20
>                                                                      diff=
erent
>=20
> > + *    see below!
> > + *
> > + * 2. Then the main charging current is applied, which is called the c=
onstant
> > + *    current (CC) phase. A current regulator is set up to allow
> > + *    constant_charge_current_max_ua of current to flow into the batte=
ry.
> > + *    The chemical reaction in the battery will make the voltage go up=
 as
> > + *    charge goes into the battery. This current is applied until we r=
each
> > + *    the constant_charge_voltage_max_uv voltage.
> > + *
> > + * 3. At this voltage we switch over to the constant voltage (CV) phas=
e. This
> > + *    means we allow current to go into the battery, but we keep the v=
oltage
> > + *    fixed. This current will continue to charge the battery while ke=
eping
> > + *    the voltage the same. A chemical reaction in the battery goes on
> > + *    storing energy without affecting the voltage. Over time the curr=
ent
> > + *    will slowly drop and when we reach charge_term_current_ua we will
> > + *    end the constant voltage phase.
> > + *
> > + * After this the battery is fully charged, and if we do not support t=
rickle
> > + * charging, the charging will not restart until power dissapation mak=
e the
>=20
>                                                           dissipation mak=
es
>=20
> > + * voltage fall so that we reach charge_restart_voltage_uv and at this=
 point
> > + * we restart charging at the appropriate phase, usually this will be =
inside
> > + * the CV phase.
>=20
>=20
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> and if (when :) you fix these, you can add
>=20
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> Thanks for doing this.

Thanks Linus, LGTM and is appreciated a lot :)
Also thanks you for the review Randy!

-- Sebastian

--dfqkftfbnmikcljl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGGrMYACgkQ2O7X88g7
+prB2hAAo0I+LSkGNn75a+H6hUNLua+a5LCrrOb2Mu2uLFW0sBVFqUQcEo/54miG
+are1HCauXLP8KWEyVETlmDO6FDKdnhz3dQ7EW2hMxqRdxL+Sg3b82ZMX1/S/+E5
tr5TZgoXFieBJYih1Oce3q1OpWq1JmbivOqZS9g8BRnhIYq6muFUdADx6GglClwQ
wFF5JfCSAfnrr2370b8WI2pk8zksPfc0HM2SlsowWlorvmktZDt/bIiDmefNa0sN
Da3ILn/4iY9AFOyjJle4JIyVY/Me4WrTH1oQWWzXTRij/Jz4Kc1PGKkOUhPWbyxm
E4uy9/gbN3GgzKL7SUaYjjY4U8B622CwsGHm7XcqwQOm+GNlYlwMTIKhIb9c4S1I
1OGjX5RP0aduM8QQMl8UluzTyBT9otuniOKNflfYu/6Rh3Q7/ZmJUZJap5jO1YYw
zCqCpcs7FO9DrWRpJPcmD7ZKjWodGBsSKWt2KbhVgNUgVDsjq727tyjKpou0s8Ya
r8osNd2/SPmpwxeKe8kabg89eciOmtSBn50DlPkfAYjp45G1UMz4p0lLnoxhMgLb
A+9CULmtv20zVQI8fZn85p2uWrw+V4yPyQe+szH5TLTvtIMGIRtNaYPX911OQnl5
wwsRpDRm8nkhEe7otD+xlZhTFsc7rOiFglsRvnIIXP1L9zWnIDk=
=kYxN
-----END PGP SIGNATURE-----

--dfqkftfbnmikcljl--
