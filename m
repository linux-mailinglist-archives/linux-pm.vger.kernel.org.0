Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13A26898F5
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBCMks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCMks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:40:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE79AFE5
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:40:46 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8404C6602F05;
        Fri,  3 Feb 2023 12:40:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675428045;
        bh=NF35OAzoOu94ANsvIwcNBk9N9CjMrvdUuejFewIkylo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBg6rMr+tKvUgHgj3nrj7lZbgOSL9TiOOnEQiAU5WQ9uiaSA2OuhiW3jSq/878L8v
         D9YbOFQpXH/xvszUqOKOiHakkZjjji4zEZJlCKMxJkJOQW4ffL73GqmyuKYYCzDiPs
         +Ay2LbSgIdwknl6Yffeo+W0ngSMrzrQIIBt33RtQg4TOAD5OjpB9E+1Bwdx8RO8OXw
         xCHSf1CoSgkL7/pDs2N8YXSP4acLg7/DjkL00ZdO/+fCipYL1V6xQfzrAjRQsmWYYx
         KzSPmaQg8ZuYMM6EzfkmpjRNXy+UizaOYkvcoHQQ+gFKUPicEj6qjL/0rNr5CJT3zS
         r+zQuAdV0OYGA==
Received: by mercury (Postfix, from userid 1000)
        id 805731060930; Fri,  3 Feb 2023 13:40:42 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:40:42 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RFC PATCH] power: supply: fix circular dependency with cooling
 device
Message-ID: <20230203124042.2ssz77o4gjppaumi@mercury.elektranox.org>
References: <20230101174342.58351-1-caleb.connolly@linaro.org>
 <2266534.ElGaqSPkdT@g550jk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydamo65kj7uj2td2"
Content-Disposition: inline
In-Reply-To: <2266534.ElGaqSPkdT@g550jk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ydamo65kj7uj2td2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 12, 2023 at 10:47:37PM +0100, Luca Weiss wrote:
> On Sonntag, 1. J=E4nner 2023 18:43:40 CET Caleb Connolly wrote:
> > A recent change in thermal/core means it now calls the cooling device
> > ->get_max_state() callback during __thermal_cooling_device_register().
> > This creates a circular dependency as it attempts to fetch a power
> > supply property before the psy is initialised. Move this call later to
> > break the dependency.
> >=20
> > Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>=20
> Fixes USB on qcom-apq8026-lg-lenok (with smbb driver)
>=20
> Tested-by: Luca Weiss <luca@z3ntu.xyz>
>=20
> Regards
> Luca

I queued the following patch instead, which rips out the broken
cooling support:

https://lore.kernel.org/all/20230121111621.2821558-1-andreas@kemnade.info/

-- Sebastian

>=20
> > ---
> >  drivers/power/supply/power_supply_core.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c
> > b/drivers/power/supply/power_supply_core.c index 7c790c41e2fe..c921111f=
f26a
> > 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1354,10 +1354,6 @@ __power_supply_register(struct device *parent,
> >  	if (rc)
> >  		goto register_thermal_failed;
> >=20
> > -	rc =3D psy_register_cooler(psy);
> > -	if (rc)
> > -		goto register_cooler_failed;
> > -
> >  	rc =3D power_supply_create_triggers(psy);
> >  	if (rc)
> >  		goto create_triggers_failed;
> > @@ -1378,17 +1374,27 @@ __power_supply_register(struct device *parent,
> >  	atomic_inc(&psy->use_cnt);
> >  	psy->initialized =3D true;
> >=20
> > +	/* This has to be done after updating use_cnt and initialized
> > +	 * otherwise when __thermal_cooling_device_register calls back
> > +	 * to ->get_max_state() the psy core will return -EAGAIN..
> > +	 */
> > +	rc =3D psy_register_cooler(psy);
> > +	if (rc)
> > +		goto register_cooler_failed;
> > +
> >  	queue_delayed_work(system_power_efficient_wq,
> >  			   &psy->deferred_register_work,
> >  			   POWER_SUPPLY_DEFERRED_REGISTER_TIME);
> >=20
> >  	return psy;
> >=20
> > +register_cooler_failed:
> > +	power_supply_remove_hwmon_sysfs(psy);
> > +	psy->initialized =3D false;
> > +	atomic_dec(&psy->use_cnt);
> >  add_hwmon_sysfs_failed:
> >  	power_supply_remove_triggers(psy);
> >  create_triggers_failed:
> > -	psy_unregister_cooler(psy);
> > -register_cooler_failed:
> >  	psy_unregister_thermal(psy);
> >  register_thermal_failed:
> >  wakeup_init_failed:

--ydamo65kj7uj2td2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPdAMoACgkQ2O7X88g7
+pozbBAAjVaAb9gX2UBo9OLbI40S2Sw92j2J1UHuHT+TZ7Voh89AGEEjoa6sMq3o
En4lX6fYLL+zomZaSOIeT7WT/Kav7ivE5PjUpoNzy0i1jYh8F9LeGO7mXUg3g5LU
6CAZIdiS0QPQ4b+BlBOKsOuHt+ajpTkZX50OdtGtX7CF6G/aDh8GxTYIQqkSj6qu
I4j+n4Ii1sK5io/fjgZ7ysufArKranXs451lMNzfTEeZBKBic0QpmjB9VVXewLM5
rnh60dg7fgMcqann1LeBhgkov3KxxJa9Lbec2gCJ5nCZWIgiX26l3j3FNkdOA/b1
9FyyPfuDdemYujRfj42ONUGDRWgTkgY+yFU+f7RCCRgCH727cDMWk9/ZMFVsb+iw
jEsUfWqJ+EYVqyN/hHCpFqYRWEeK0ZMBv/AkZKnD/FRkZc+U0ACxr+ncXF+KG0f6
MWwpsjq8RS5Sukksg94YOLcywkjiec6XAagYF7AnE2XDN4UToQ3uZiXSP6H2pfOt
ryYO6pi7SRIX6ykBMc/ooCko8ey1+R6/w2VU3S5yVLl4WCrIkdWmUpzHZUfFriV1
cyn2dMCzDqTcqGRrTXdy/1Yu4aZpjgP0CfFZZ7W276MOKCGQ22bRBKFZu2scbmYr
eSW0cyM+0ByW2kk76a61ZlP8Cs7ERblY8hOJH6ggSbkpJnWg5Zg=
=4yDq
-----END PGP SIGNATURE-----

--ydamo65kj7uj2td2--
