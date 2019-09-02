Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B585CA5C47
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 20:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfIBScA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 14:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfIBScA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 14:32:00 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2962521881;
        Mon,  2 Sep 2019 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567449118;
        bh=48saDu2OkRopU+sxbZhDbOY5dlUZqXFHW7UlD0wi3PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miD21iyEUekwktVZZ1bEp9935D61M7B5jcopxRBrKKx91pdjd6emSo8YJxNqqo5dC
         8USM0BlcKBxWQvAdETU6YcHrmYHKBAtl1cBet4ri3kb0WZaapCQz3A2AAB2VAEuL61
         jVRCvb9BSR5k8STMh7b+hWPFCys8nzX6kkqhiBso=
Received: by earth.universe (Postfix, from userid 1000)
        id B210C3C0B7F; Mon,  2 Sep 2019 20:31:55 +0200 (CEST)
Date:   Mon, 2 Sep 2019 20:31:55 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Richard Tresidder <rtresidd@electromag.com.au>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        andrew.smirnov@gmail.com, Guenter Roeck <groeck@chromium.org>,
        david@lechnology.com, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net,
        Baolin Wang <baolin.wang@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
Message-ID: <20190902183155.6nugohjfr3pktxve@earth.universe>
References: <1564452025-12673-1-git-send-email-rtresidd@electromag.com.au>
 <CAHX4x87gVfmKVmj2O_riwV57Qb8X-MtKCUp6e=3UYuii4TVg0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c5jfoqaruz4rn6pk"
Content-Disposition: inline
In-Reply-To: <CAHX4x87gVfmKVmj2O_riwV57Qb8X-MtKCUp6e=3UYuii4TVg0Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c5jfoqaruz4rn6pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Looks good to me, but needs to be split (one patch adding STATUS_EMPTY
to the power-supply core and one patch fixing sbs-battery driver).

-- Sebastian

On Thu, Aug 01, 2019 at 12:34:18PM -0600, Nick Crews wrote:
> Thanks Richard, I still would like some more opinions
> on this changing the userspace experience, but LGTM
> otherwise.
>=20
> Reviewed-by: Nick Crews <ncrews@chromium.org>
>=20
> On Mon, Jul 29, 2019 at 8:00 PM Richard Tresidder
> <rtresidd@electromag.com.au> wrote:
> >
> > When a battery or batteries in a system are in parallel then one or more
> > may not be providing any current to the system.
> > This fixes an incorrect status indication of FULL for the battery simply
> > because it wasn't discharging at that point in time.
> > The battery will now be flagged as NOT CHARGING.
> > Have also added the additional check for the battery FULL DISCHARGED fl=
ag
> > which will now flag a status of EMPTY.
> >
> > Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> > ---
> >
> > Notes:
> >     power/supply/sbs-battery: Fix confusing battery status when idle or=
 empty
> >
> >     When a battery or batteries in a system are in parallel then one or=
 more
> >     may not be providing any current to the system.
> >     This fixes an incorrect status indication of FULL for the battery s=
imply
> >     because it wasn't discharging at that point in time.
> >     The battery will now be flagged as NOT CHARGING.
> >     Have also added the additional check for the battery FULL DISCHARGE=
D flag
> >     which will now flag a status of EMPTY.
> >
> >     v2: Missed a later merge that should have been included in original=
 patch
> >     v3: Refactor the sbs_status_correct function to capture all the sta=
tes for
> >         normal operation rather than being spread across multile functi=
ons.
> >     v4: Remove unnecessary brackets, rename sbs_status_correct to
> >         sbs_correct_battery_status
> >
> >  drivers/power/supply/power_supply_sysfs.c |  2 +-
> >  drivers/power/supply/sbs-battery.c        | 46 ++++++++++++-----------=
--------
> >  include/linux/power_supply.h              |  1 +
> >  3 files changed, 19 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index f37ad4e..305e833 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -51,7 +51,7 @@
> >  };
> >
> >  static const char * const power_supply_status_text[] =3D {
> > -       "Unknown", "Charging", "Discharging", "Not charging", "Full"
> > +       "Unknown", "Charging", "Discharging", "Not charging", "Full", "=
Empty"
> >  };
> >
> >  static const char * const power_supply_charge_type_text[] =3D {
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/=
sbs-battery.c
> > index 048d205..3ed70d4 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c
> > @@ -283,7 +283,7 @@ static int sbs_write_word_data(struct i2c_client *c=
lient, u8 address,
> >         return 0;
> >  }
> >
> > -static int sbs_status_correct(struct i2c_client *client, int *intval)
> > +static int sbs_correct_battery_status(struct i2c_client *client, int *=
status)
> >  {
> >         int ret;
> >
> > @@ -293,16 +293,18 @@ static int sbs_status_correct(struct i2c_client *=
client, int *intval)
> >
> >         ret =3D (s16)ret;
> >
> > -       /* Not drawing current means full (cannot be not charging) */
> > -       if (ret =3D=3D 0)
> > -               *intval =3D POWER_SUPPLY_STATUS_FULL;
> > -
> > -       if (*intval =3D=3D POWER_SUPPLY_STATUS_FULL) {
> > -               /* Drawing or providing current when full */
> > -               if (ret > 0)
> > -                       *intval =3D POWER_SUPPLY_STATUS_CHARGING;
> > -               else if (ret < 0)
> > -                       *intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +       if (ret > 0)
> > +               *status =3D POWER_SUPPLY_STATUS_CHARGING;
> > +       else if (ret < 0)
> > +               *status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +       else {
> > +               /* Current is 0, so how full is the battery? */
> > +               if (*status & BATTERY_FULL_CHARGED)
> > +                       *status =3D POWER_SUPPLY_STATUS_FULL;
> > +               else if (*status & BATTERY_FULL_DISCHARGED)
> > +                       *status =3D POWER_SUPPLY_STATUS_EMPTY;
> > +               else
> > +                       *status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> >         }
> >
> >         return 0;
> > @@ -421,14 +423,9 @@ static int sbs_get_battery_property(struct i2c_cli=
ent *client,
> >                         return 0;
> >                 }
> >
> > -               if (ret & BATTERY_FULL_CHARGED)
> > -                       val->intval =3D POWER_SUPPLY_STATUS_FULL;
> > -               else if (ret & BATTERY_DISCHARGING)
> > -                       val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > -               else
> > -                       val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> > -
> > -               sbs_status_correct(client, &val->intval);
> > +               ret =3D sbs_correct_battery_status(client, &val->intval=
);
> > +               if (ret < 0)
> > +                       return ret;
> >
> >                 if (chip->poll_time =3D=3D 0)
> >                         chip->last_state =3D val->intval;
> > @@ -773,20 +770,11 @@ static void sbs_delayed_work(struct work_struct *=
work)
> >
> >         ret =3D sbs_read_word_data(chip->client, sbs_data[REG_STATUS].a=
ddr);
> >         /* if the read failed, give up on this work */
> > -       if (ret < 0) {
> > +       if (ret < 0 || sbs_correct_battery_status(chip->client, &ret) <=
 0) {
> >                 chip->poll_time =3D 0;
> >                 return;
> >         }
> >
> > -       if (ret & BATTERY_FULL_CHARGED)
> > -               ret =3D POWER_SUPPLY_STATUS_FULL;
> > -       else if (ret & BATTERY_DISCHARGING)
> > -               ret =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > -       else
> > -               ret =3D POWER_SUPPLY_STATUS_CHARGING;
> > -
> > -       sbs_status_correct(chip->client, &ret);
> > -
> >         if (chip->last_state !=3D ret) {
> >                 chip->poll_time =3D 0;
> >                 power_supply_changed(chip->power_supply);
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 28413f7..8fb10ec 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -37,6 +37,7 @@ enum {
> >         POWER_SUPPLY_STATUS_DISCHARGING,
> >         POWER_SUPPLY_STATUS_NOT_CHARGING,
> >         POWER_SUPPLY_STATUS_FULL,
> > +       POWER_SUPPLY_STATUS_EMPTY,
> >  };
> >
> >  /* What algorithm is the charger using? */
> > --
> > 1.8.3.1
> >

--c5jfoqaruz4rn6pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tYBsACgkQ2O7X88g7
+prZLhAAidogLtBQ44eP7QxfyURYuiKdZclVMhxhhkscUe9w8AWjMC+JDXGQH7T7
+il73UYNc0xlGicZIrBV5DRRWSJfhLAUVt+cpeYkGrzVUiEeNa0KYUPu96J49C8s
GSZnsQDLkt4kG+FOgRIRh/hu18G3GmMJ4qvFoNObGTTXa3OwjZCf3f5ML2yaseTL
R1UOl1SMkdN7fmTozjUxeLb/gd/LDja8bZDRcFgGu5BoP6Ju7+IKfvHyLAISCZo5
iQJIH1MR+spTGf3wIUB3NLbjAHw5qCUnY/f9oSuEvA4LJuPMK1LH6lXHJJbYaf7v
XpBG8iYmabY6YuLf8pc5zKNU1Amft+KogbkSV8Jd6eN4T2UcKC9K7yzPtN1cRSe/
1I1VS3d+LFbYS8Fz4D8Phb671edRedClecAhFY3D/FEdi0/H68RglMnl5Ugp/5NW
L6uuo5xk4xTvQ6kH6zivLcaDHEQjjoJEeG5zTycHCvzj1lU6iJVmwHc8B2+A7wk4
3Fzq8rM90tw6LwnKQIuicURJuzlE2X04h7GF/p9Iq/43sAAbVyk+q94kbu5eqvns
l1GzJCO53rlouRTebzzzCBj2eX+GjfNgMcVMpi1wi4LVM0Sdh6VqTdnMVuPS3N8y
uWHQr+Cqbglggr3yIry3h5F4iWR1jr9eGFu2OaiE3sSTbusXvQM=
=d3Rd
-----END PGP SIGNATURE-----

--c5jfoqaruz4rn6pk--
