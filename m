Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CF35415A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhDELEv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 07:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhDELEu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Apr 2021 07:04:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B79CB03C;
        Mon,  5 Apr 2021 11:04:43 +0000 (UTC)
Message-ID: <8f147485af325181c57bdf0dd3b0e3dd54000ac8.camel@suse.de>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        DOCUMENTATION <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS "
         "<devicetree@vger.ke rnel.org>, ACPI Devel Maling List "
         "<linux-acpi@vger.kernel.org>, Android Kernel Team "
         "<kernel-team@android.com>, linux-rpi-kernel" 
        <linux-rpi-kernel@lists.infradead.org>
Date:   Mon, 05 Apr 2021 13:04:40 +0200
In-Reply-To: <161721871083.2260335.2392646934517115770@swboyd.mtv.corp.google.com>
References: <20210205222644.2357303-9-saravanak@google.com>
         <9b206c4d00dfe8b7f941260f18909914b2b2eecb.camel@suse.de>
         <161678243444.3012082.5031467952132861429@swboyd.mtv.corp.google.com>
         <CAMuHMdV5PGUujsFP2TXMxij4UxVnrrurh_qVhq8+480w21jJAg@mail.gmail.com>
         <161705310317.3012082.15148238105608149214@swboyd.mtv.corp.google.com>
         <CAGETcx8reqKoPoJ8dV7f9=SHYKmNhcVpkNHoCS-0L4UHCBahoA@mail.gmail.com>
         <161706920822.3012082.10047587064612237296@swboyd.mtv.corp.google.com>
         <CAMuHMdX7OxTjwQmdP8xDbVkjtZ5442qFao8K6bNpDQ5S3GPSgQ@mail.gmail.com>
         <161715734080.2260335.881350237641202575@swboyd.mtv.corp.google.com>
         <CAMuHMdXMhiOBSSwrC2A_ijXCaekBMfC8h9PFhqLtNGhtPDba=A@mail.gmail.com>
         <161721871083.2260335.2392646934517115770@swboyd.mtv.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ffRO6YGGlkKiYOjSl+0D"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-ffRO6YGGlkKiYOjSl+0D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-31 at 12:25 -0700, Stephen Boyd wrote:
> Quoting Geert Uytterhoeven (2021-03-31 00:05:00)
> > On Wed, Mar 31, 2021 at 4:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > Does it have any use?
> > > >=20
> > > > of_clk_del_provider() removes the first provider found with node =
=3D=3D NULL.
> > > > If there are two drivers calling of_clk_add_hw_provider(), and one =
of
> > > > hem calls of_clk_del_provider() later, the wrong provider may be
> > > > removed from the list.
> > > >=20
> > >=20
> > > So you're saying we shouldn't add a NULL device node pointer to the l=
ist
> > > so that this can't happen? That doesn't mean returning an error from
> > > of_clk_add_hw_provider() would be useful though.
> > > of_clk_add_hw_provider() can return 0 if np =3D=3D NULL and
> > > of_clk_del_provider() can return early if np =3D=3D NULL too.
> >=20
> > I don't know if I grasp all meanings of the above.
> >=20
> > The main question is if it is valid for a driver to call
> > of_clk_add_hw_provider()
> > with np =3D=3D NULL.
> > =C2=A0=C2=A0- If yes, should that register the provider?
>=20
> No it should not register the provider. That would be bad as you pointed
> out.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- If yes, how to handle two drivers=
 calling of_clk_add_hw_provider()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0with np =3D NULL, as th=
eir unregistration order is not guaranteed to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0be correct.
> >=20
> > If no, is that something to ignore (0), or a bug (error)?
>=20
> This is my question above. Is there a use to having
> of_clk_add_hw_provider() return an error value when np =3D=3D NULL? I dou=
bt
> it.
>=20
> Returning 0 would reduce the if conditions in driver code in this case
> and be consistent with the CONFIG_OF=3Dn inline stub that returns 0 when
> CONFIG_OF is disabled. The only case an error would be returned is if we
> couldn't allocate memory or if the assigned clocks code failed. Seems
> sane to me. The downside is that drivers would maybe register clkdev
> lookups when they don't need to and waste some memory. I'm fine with
> that until we have some sort of non-DT based clk provider lookup
> mechanism that could unify the two methods.

What about devm_of_clk_add_hw_provider() users, do we care that a seemingly
empty managed resource will be created?

Regards,
Nicolas


--=-ffRO6YGGlkKiYOjSl+0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBq7sgACgkQlfZmHno8
x/5ZSwf9HS5H+QT20eiJRWn3bELAv3sRiJTSXv7nkK9YBffB4RHKSH28Ocj04LdC
75oUWS2K08zuwHEK78YAo3wnD95KNIWq4Q3iNtkkmHxvm+DA/1fwbljVilKAtF0O
+HwypDjA3TMJm37VgB6AL9VKrO4/fQHdkq89m4WRl/ui9TP+LMpUfmpGMOT2g5KZ
r4OA+AsGfAjJpEOjvc+O+BAjfFaw53bDX2BqdWAodMSF5iAOYi+6/jQftxKRym4y
yw9x+YWxx6cG/I5rXJAC6es5foHtjHxgY9vL3BE7vN3ClQ5ZwcJmMq+gS/SKGopu
CY4Wm2CjB1YMigXfwLmvYxpMW5ubbw==
=EzAP
-----END PGP SIGNATURE-----

--=-ffRO6YGGlkKiYOjSl+0D--

