Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7978F454B75
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhKQQ7d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 11:59:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52326 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhKQQ7c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 11:59:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 92D691F46230
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637168192; bh=oH6fpLGCYd/bdQpuFQdBHWiwNTD5ZhIzeSW/6trZ9bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SImxZFDSGeAxuIAbojLA27iv/HI28PijyvZ19vvh5/eqW2uzVC9cQpMEmV3cRYHHT
         9GpFHxwZRNVo/DgmlOWzHkcs/rB80DxnjIz4Ljnfd86rNZtYIA6RdrriTI4nx31Pxd
         TXNNWgiNahjx6wGER7P1OkQe3jV0Lj2FAtJhADXmN80Xx1Ejd2RVJcRLfPAa7i/fVT
         /9+l/0OXluqjceFNopkqxlosF3ytUkk0CB4GAEaCbHrh04SdTHY6ZGyq7a55UOWbsd
         XCsYVOIyJtNvBjD1XH/qMeA+kJPGMD5CMwunz90mV3Zzd5hmjpyFK8zGIGz3I5Uxl0
         3SLRxEHz5q+IA==
Received: by earth.universe (Postfix, from userid 1000)
        id 169C23C0F9E; Wed, 17 Nov 2021 17:56:30 +0100 (CET)
Date:   Wed, 17 Nov 2021 17:56:30 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v4] power: supply: core: Add kerneldoc to battery struct
Message-ID: <20211117165630.ewwi7bf7h35npygu@earth.universe>
References: <20211116224428.2157735-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="erqcbssz6tngwbpg"
Content-Disposition: inline
In-Reply-To: <20211116224428.2157735-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--erqcbssz6tngwbpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 16, 2021 at 11:44:28PM +0100, Linus Walleij wrote:
> This complements the struct power_supply_battery_info with
> extensive kerneldoc explaining the different semantics of the
> fields, including an overview of the CC/CV charging concepts
> implicit in some of the struct members.
>=20
> This is done to first establish semantics before I can
> add more charging methods by breaking out the CC/CV parameters
> to its own struct.
>=20
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Make the precharge phase explicitly reference the CC phase.
> - Fix up the text about the resist table to be more accurate.
> - Collect Matti's Review tag.
> ChangeLog v2->v3:
> - After reading the Rohm bd99954 I realized I put the trickle
>   charging at the end of the phase (as I like it to be) but
>   the one driver using it is putting it before pre-charge,
>   so we adapt to this fact. I will add new properties for
>   "maintenance charging" that happen after CV instead.
> - Matti, please check this so I don't make any more mistakes.
> ChangeLog v1->v2:
> - Fix some spelling error etc.
> ---

Very nice patch, queued.

-- Sebastian

>  include/linux/power_supply.h | 215 +++++++++++++++++++++++++++++++----
>  1 file changed, 192 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..b5079109ac00 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -342,37 +342,206 @@ struct power_supply_resistance_temp_table {
> =20
>  #define POWER_SUPPLY_OCV_TEMP_MAX 20
> =20
> -/*
> +/**
> + * struct power_supply_battery_info - information about batteries
> + * @technology: from the POWER_SUPPLY_TECHNOLOGY_* enum
> + * @energy_full_design_uwh: energy content when fully charged in microwa=
tt
> + *   hours
> + * @charge_full_design_uah: charge content when fully charged in microam=
pere
> + *   hours
> + * @voltage_min_design_uv: minimum voltage across the poles when the bat=
tery
> + *   is at minimum voltage level in microvolts. If the voltage drops bel=
ow this
> + *   level the battery will need precharging when using CC/CV charging.
> + * @voltage_max_design_uv: voltage across the poles when the battery is =
fully
> + *   charged in microvolts. This is the "nominal voltage" i.e. the volta=
ge
> + *   printed on the label of the battery.
> + * @tricklecharge_current_ua: the tricklecharge current used when trickle
> + *   charging the battery in microamperes. This is the charging phase wh=
en the
> + *   battery is completely empty and we need to carefully trickle in some
> + *   charge until we reach the precharging voltage.
> + * @precharge_current_ua: current to use in the precharge phase in micro=
amperes,
> + *   the precharge rate is limited by limiting the current to this value.
> + * @precharge_voltage_max_uv: the maximum voltage allowed when prechargi=
ng in
> + *   microvolts. When we pass this voltage we will nominally switch over=
 to the
> + *   CC (constant current) charging phase defined by constant_charge_cur=
rent_ua
> + *   and constant_charge_voltage_max_uv.
> + * @charge_term_current_ua: when the current in the CV (constant voltage)
> + *   charging phase drops below this value in microamperes the charging =
will
> + *   terminate completely and not restart until the voltage over the bat=
tery
> + *   poles reach charge_restart_voltage_uv unless we use maintenance cha=
rging.
> + * @charge_restart_voltage_uv: when the battery has been fully charged by
> + *   CC/CV charging and charging has been disabled, and the voltage subs=
equently
> + *   drops below this value in microvolts, the charging will be restarted
> + *   (typically using CV charging).
> + * @overvoltage_limit_uv: If the voltage exceeds the nominal voltage
> + *   voltage_max_design_uv and we reach this voltage level, all charging=
 must
> + *   stop and emergency procedures take place, such as shutting down the=
 system
> + *   in some cases.
> + * @constant_charge_current_max_ua: current in microamperes to use in th=
e CC
> + *   (constant current) charging phase. The charging rate is limited
> + *   by this current. This is the main charging phase and as the current=
 is
> + *   constant into the battery the voltage slowly ascends to
> + *   constant_charge_voltage_max_uv.
> + * @constant_charge_voltage_max_uv: voltage in microvolts signifying the=
 end of
> + *   the CC (constant current) charging phase and the beginning of the CV
> + *   (constant voltage) charging phase.
> + * @factory_internal_resistance_uohm: the internal resistance of the bat=
tery
> + *   at fabrication time, expressed in microohms. This resistance will v=
ary
> + *   depending on the lifetime and charge of the battery, so this is jus=
t a
> + *   nominal ballpark figure.
> + * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
> + *   temperature indices. This is an array of temperatures in degrees Ce=
lsius
> + *   indicating which capacity table to use for a certain temperature, s=
ince
> + *   the capacity for reasons of chemistry will be different at different
> + *   temperatures. Determining capacity is a multivariate problem and the
> + *   temperature is the first variable we determine.
> + * @temp_ambient_alert_min: the battery will go outside of operating con=
ditions
> + *   when the ambient temperature goes below this temperature in degrees
> + *   Celsius.
> + * @temp_ambient_alert_max: the battery will go outside of operating con=
ditions
> + *   when the ambient temperature goes above this temperature in degrees
> + *   Celsius.
> + * @temp_alert_min: the battery should issue an alert if the internal
> + *   temperature goes below this temperature in degrees Celsius.
> + * @temp_alert_max: the battery should issue an alert if the internal
> + *   temperature goes above this temperature in degrees Celsius.
> + * @temp_min: the battery will go outside of operating conditions when
> + *   the internal temperature goes below this temperature in degrees Cel=
sius.
> + *   Normally this means the system should shut down.
> + * @temp_max: the battery will go outside of operating conditions when
> + *   the internal temperature goes above this temperature in degrees Cel=
sius.
> + *   Normally this means the system should shut down.
> + * @ocv_table: for each entry in ocv_temp there is a corresponding entry=
 in
> + *   ocv_table and a size for each entry in ocv_table_size. These arrays
> + *   determine the capacity in percent in relation to the voltage in mic=
rovolts
> + *   at the indexed temperature.
> + * @ocv_table_size: for each entry in ocv_temp this array is giving the =
size of
> + *   each entry in the array of capacity arrays in ocv_table.
> + * @resist_table: this is a table that correlates a battery temperature =
to the
> + *   expected internal resistance at this temperature. The resistance is=
 given
> + *   as a percentage of factory_internal_resistance_uohm. Knowing the
> + *   resistance of the battery is usually necessary for calculating the =
open
> + *   circuit voltage (OCV) that is then used with the ocv_table to calcu=
late
> + *   the capacity of the battery. The resist_table must be ordered desce=
nding
> + *   by temperature: highest temperature with lowest resistance first, l=
owest
> + *   temperature with highest resistance last.
> + * @resist_table_size: the number of items in the resist_table.
> + *
>   * This is the recommended struct to manage static battery parameters,
>   * populated by power_supply_get_battery_info(). Most platform drivers s=
hould
>   * use these for consistency.
> + *
>   * Its field names must correspond to elements in enum power_supply_prop=
erty.
>   * The default field value is -EINVAL.
> - * Power supply class itself doesn't use this.
> + *
> + * The charging parameters here assume a CC/CV charging scheme. This met=
hod
> + * is most common with Lithium Ion batteries (other methods are possible=
) and
> + * looks as follows:
> + *
> + * ^ Battery voltage
> + * |                                               --- overvoltage_limit=
_uv
> + * |
> + * |                    ................................................=
=2E..
> + * |                 .. constant_charge_voltage_max_uv
> + * |              ..
> + * |             .
> + * |            .
> + * |           .
> + * |          .
> + * |         .
> + * |     .. precharge_voltage_max_uv
> + * |  ..
> + * |. (trickle charging)
> + * +------------------------------------------------------------------> =
time
> + *
> + * ^ Current into the battery
> + * |
> + * |      ............. constant_charge_current_max_ua
> + * |      .            .
> + * |      .             .
> + * |      .              .
> + * |      .               .
> + * |      .                ..
> + * |      .                  ....
> + * |      .                       .....
> + * |    ... precharge_current_ua       .......  charge_term_current_ua
> + * |    .                                    .
> + * |    .                                    .
> + * |.... tricklecharge_current_ua            .
> + * |                                         .
> + * +-----------------------------------------------------------------> t=
ime
> + *
> + * These diagrams are synchronized on time and the voltage and current
> + * follow each other.
> + *
> + * With CC/CV charging commence over time like this for an empty battery:
> + *
> + * 1. When the battery is completely empty it may need to be charged with
> + *    an especially small current so that electrons just "trickle in",
> + *    this is the tricklecharge_current_ua.
> + *
> + * 2. Next a small initial pre-charge current (precharge_current_ua)
> + *    is applied if the voltage is below precharge_voltage_max_uv until =
we
> + *    reach precharge_voltage_max_uv. CAUTION: in some texts this is ref=
erred
> + *    to as "trickle charging" but the use in the Linux kernel is differ=
ent
> + *    see below!
> + *
> + * 3. Then the main charging current is applied, which is called the con=
stant
> + *    current (CC) phase. A current regulator is set up to allow
> + *    constant_charge_current_max_ua of current to flow into the battery.
> + *    The chemical reaction in the battery will make the voltage go up as
> + *    charge goes into the battery. This current is applied until we rea=
ch
> + *    the constant_charge_voltage_max_uv voltage.
> + *
> + * 4. At this voltage we switch over to the constant voltage (CV) phase.=
 This
> + *    means we allow current to go into the battery, but we keep the vol=
tage
> + *    fixed. This current will continue to charge the battery while keep=
ing
> + *    the voltage the same. A chemical reaction in the battery goes on
> + *    storing energy without affecting the voltage. Over time the current
> + *    will slowly drop and when we reach charge_term_current_ua we will
> + *    end the constant voltage phase.
> + *
> + * After this the battery is fully charged, and if we do not support mai=
ntenance
> + * charging, the charging will not restart until power dissipation makes=
 the
> + * voltage fall so that we reach charge_restart_voltage_uv and at this p=
oint
> + * we restart charging at the appropriate phase, usually this will be in=
side
> + * the CV phase.
> + *
> + * If we support maintenance charging the voltage is however kept high a=
fter
> + * the CV phase with a very low current. This is meant to let the same c=
harge
> + * go in for usage while the charger is still connected, mainly for
> + * dissipation for the power consuming entity while connected to the
> + * charger.
> + *
> + * All charging MUST terminate if the overvoltage_limit_uv is ever reach=
ed.
> + * Overcharging Lithium Ion cells can be DANGEROUS and lead to fire or
> + * explosions.
> + *
> + * The power supply class itself doesn't use this struct as of now.
>   */
> =20
>  struct power_supply_battery_info {
> -	unsigned int technology;	    /* from the enum above */
> -	int energy_full_design_uwh;	    /* microWatt-hours */
> -	int charge_full_design_uah;	    /* microAmp-hours */
> -	int voltage_min_design_uv;	    /* microVolts */
> -	int voltage_max_design_uv;	    /* microVolts */
> -	int tricklecharge_current_ua;	    /* microAmps */
> -	int precharge_current_ua;	    /* microAmps */
> -	int precharge_voltage_max_uv;	    /* microVolts */
> -	int charge_term_current_ua;	    /* microAmps */
> -	int charge_restart_voltage_uv;	    /* microVolts */
> -	int overvoltage_limit_uv;	    /* microVolts */
> -	int constant_charge_current_max_ua; /* microAmps */
> -	int constant_charge_voltage_max_uv; /* microVolts */
> -	int factory_internal_resistance_uohm;   /* microOhms */
> -	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];/* celsius */
> -	int temp_ambient_alert_min;             /* celsius */
> -	int temp_ambient_alert_max;             /* celsius */
> -	int temp_alert_min;                     /* celsius */
> -	int temp_alert_max;                     /* celsius */
> -	int temp_min;                           /* celsius */
> -	int temp_max;                           /* celsius */
> +	unsigned int technology;
> +	int energy_full_design_uwh;
> +	int charge_full_design_uah;
> +	int voltage_min_design_uv;
> +	int voltage_max_design_uv;
> +	int tricklecharge_current_ua;
> +	int precharge_current_ua;
> +	int precharge_voltage_max_uv;
> +	int charge_term_current_ua;
> +	int charge_restart_voltage_uv;
> +	int overvoltage_limit_uv;
> +	int constant_charge_current_max_ua;
> +	int constant_charge_voltage_max_uv;
> +	int factory_internal_resistance_uohm;
> +	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
> +	int temp_ambient_alert_min;
> +	int temp_ambient_alert_max;
> +	int temp_alert_min;
> +	int temp_alert_max;
> +	int temp_min;
> +	int temp_max;
>  	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_=
MAX];
>  	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
>  	struct power_supply_resistance_temp_table *resist_table;
> --=20
> 2.31.1
>=20

--erqcbssz6tngwbpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGVNDEACgkQ2O7X88g7
+pr1IQ//XEuxZpeLgvvYyBc3hzTtkYtPpSVCFMmlXQEax/92dR/YQp/rAcvZRajT
D/c95u4QFTyU+696wBoqY2sNIwf0TSDuG7i7Za1DkG5h6YtxlL18r2m8eaiG7emX
vjDDktXJNK5vrlGxHLQtdhQqkOOln8MI17vn3NceeWPisGT999mqBuGHEGGKvLkE
T/0jGpCVSeLH4K6r5Z1BYR48T9l3GTs5hwwvKUo57iFnaOINgqITTFqKdn6AGpY6
cF75v8TgOe96ds2hoqqdO/fbAJt6CSiuy2vy4MEHKPW5Yx+2jJMVNkPCk/efF9M1
kGAcKzCBLgoe01zYgFUX9FzXdll+CNCMT7hW+y2xtfNUkaWLgT8uNpmL7TiwHKJs
IhLolMig4oD3nYfMTwRQVg/YhPxXhU2PYG5JSpqCRZWmSldeo3xNcZgsTtRPlZ+F
dLbzYHxaSZLgSRvREftbQpUVNnCytwLSCb2gNMVTtdmtFAaL8BLCSi4xnJ2EabWO
emjlaPlDhcCOBRyv/5gmA/IKzi6n6niUOBdKrQ6aqTLwmTAV6gt1FE/AJQeyDuKt
m6CQ4Im7uPiKrBTF6D2/BIHkxrzql34h8HhlgCwBGhhEmdBTk6GnZKpaxOsx6Cwu
nmnmzlFabppaKByZn3uguJ7cb+uwN1O9ehxSzhCOy66T7bShvnI=
=xQmV
-----END PGP SIGNATURE-----

--erqcbssz6tngwbpg--
