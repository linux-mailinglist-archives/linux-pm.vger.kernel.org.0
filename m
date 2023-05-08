Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48E6FB54F
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjEHQiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjEHQhp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:37:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6836EA9
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:37:36 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22ED56605769;
        Mon,  8 May 2023 17:37:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563853;
        bh=/ClvrZdhdE8THodrv3yD82g7ckIdcHTZUUsKera7uY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9cDvHsqckHOXgFPsrTAGnP7o4aQGCnTh3Uo1zjKVN3yxE7B2dEI5gYS15tyZGfGg
         s/sQfjGwlS5MJzAgIpPlPD8NfPmy+JLNFV1GLeoinhznqLnS9h3Q2r/+CrcYrY+Tyc
         E7qS9r2a+shLqlcebAJKRuHvreHh8MTXk66XjnaRa1sKkkuU5cyyTEbsagLxTwC84I
         zq9Vmi2O4Lyxy3+16Q1Dv3Xgb6JbgIpInBVC5tHkDEpFnW9kVvDfVDpc0KJBwBYw/R
         MRzyuGKaKrFTpzN0qFXhcmxIRfpwcKEynW+BgWhLYTS6jM2woPbaFoLF81Ynrwev7y
         eGBlzS0IdVg1Q==
Received: by mercury (Postfix, from userid 1000)
        id E87E41067081; Mon,  8 May 2023 15:14:33 +0200 (CEST)
Date:   Mon, 8 May 2023 15:14:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: leds: Fix blink to LED on transition
Message-ID: <20230508131433.yqqeqr2nf62zgzkt@mercury.elektranox.org>
References: <20230413100941.115529-1-hdegoede@redhat.com>
 <CA+E=qVd70a2kJvfdPdssiwMwS0PHHb1C06sgK9G6MjQwG+C5+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iaxjji6cusyrxt43"
Content-Disposition: inline
In-Reply-To: <CA+E=qVd70a2kJvfdPdssiwMwS0PHHb1C06sgK9G6MjQwG+C5+A@mail.gmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iaxjji6cusyrxt43
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 13, 2023 at 09:40:44AM -0700, Vasily Khoruzhick wrote:
> On Thu, Apr 13, 2023 at 3:09=E2=80=AFAM Hans de Goede <hdegoede@redhat.co=
m> wrote:
> >
> > When a battery's status changes from charging to full then
> > the charging-blink-full-solid trigger tries to change
> > the LED from blinking to solid/on.
> >
> > As is documented in include/linux/leds.h to deactivate blinking /
> > to make the LED solid a LED_OFF must be send:
> >
> > """
> >          * Deactivate blinking again when the brightness is set to LED_=
OFF
> >          * via the brightness_set() callback.
> > """
> >
> > led_set_brighness() calls with a brightness value other then 0 / LED_OFF
> > merely change the brightness of the LED in its on state while it is
> > blinking.
> >
> > So power_supply_update_bat_leds() must first send a LED_OFF event
> > before the LED_FULL to disable blinking.
> >
> > Fixes: 6501f728c56f ("power_supply: Add new LED trigger charging-blink-=
solid-full")
>=20
> Wow, it's a commit from 2011 :)
>=20
> > Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

Thanks, queued to my fixes branch.

-- Sebastian

> > ---
> >  drivers/power/supply/power_supply_leds.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/s=
upply/power_supply_leds.c
> > index e2f554e4e4e6..c7db29d5fcb8 100644
> > --- a/drivers/power/supply/power_supply_leds.c
> > +++ b/drivers/power/supply/power_supply_leds.c
> > @@ -33,8 +33,9 @@ static void power_supply_update_bat_leds(struct power=
_supply *psy)
> >                 led_trigger_event(psy->charging_full_trig, LED_FULL);
> >                 led_trigger_event(psy->charging_trig, LED_OFF);
> >                 led_trigger_event(psy->full_trig, LED_FULL);
> > -               led_trigger_event(psy->charging_blink_full_solid_trig,
> > -                       LED_FULL);
> > +               /* Going from blink to LED on requires a LED_OFF event =
to stop blink */
> > +               led_trigger_event(psy->charging_blink_full_solid_trig, =
LED_OFF);
> > +               led_trigger_event(psy->charging_blink_full_solid_trig, =
LED_FULL);
> >                 break;
> >         case POWER_SUPPLY_STATUS_CHARGING:
> >                 led_trigger_event(psy->charging_full_trig, LED_FULL);
> > --
> > 2.39.1
> >

--iaxjji6cusyrxt43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY9bkACgkQ2O7X88g7
+pofhg//ZtXYZhydgIA6Y51yvg+WvNwWHIn5pQoJThQfCWWHUsG/9bQhEQq+/VoZ
kyjHDg5dTBIfz9qryfLXQiTjGXChHvnhYfy0awWrt6I0GBf6yLBu7N8IQ8a7Tjfl
E7RRrrDd/7bL/WRIirZdXDFvqsPPULTNv8S8mitEuAF0CPpUsAn6fS7At/S3ypyB
eax6u+K92QDXsNtzkRFeIVcOVHyA8SBHK2RJuqwxjODE2mETt+GgEkPmPf4y+jI+
JaOCQW8H+0yBAAD+drVNuMG2Zi/wBQeM1JTLLDXJBOyaJ9APPllXtsHpiuA0FZGs
+4I2CSYC2jc3Z8s9bCf233vOa+rySOGMRC7H9y3UczXZTyR5b1ZSWq2tgiAUXfh8
bdunVV5dV46INxswrGs9+5fVe0DKeKywILjPgM/nF7iWEJfxbGQ2itfaiywcOkO+
F24QgPCqNRV+LkmZRwtr5CoWcWGOBIYqcMDD7wgj6Ph7XQ0QmFICGwzmh/wP3FUS
HXpg2V0Z8Ny8XRKSemiNpuz5WuNgsulHes9NXmeyFnFaNm7EQ8eVI9I0kOzOl0Jk
G+zpiKYPfiF+nKts1xII06aIEoR8o523zV2EbtaNHeqnDCvKrr7apNo6OZykfcRH
lafTb8pMD7j+blnwtPVUaK8jQkl/grhdUvv21N6nU8msDVmtxcg=
=lKk8
-----END PGP SIGNATURE-----

--iaxjji6cusyrxt43--
