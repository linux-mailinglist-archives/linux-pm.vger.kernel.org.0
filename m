Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE424AF79
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHTG67 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 02:58:59 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42708 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTG67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 02:58:59 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 81FCC1C0BB4; Thu, 20 Aug 2020 08:58:56 +0200 (CEST)
Date:   Thu, 20 Aug 2020 08:58:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        linux-pm@vger.kernel.org, "Arthur D." <spinal.by@gmail.com>
Subject: Re: [RFC] Limiting charge current on Droid 4 (and N900)
Message-ID: <20200820065855.GA9738@amd>
References: <20200615140557.GA22781@duo.ucw.cz>
 <20200629155515.GR37466@atomide.com>
 <20200820041512.GH2994@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20200820041512.GH2994@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Droid 4 has same problem as N900: it is often neccessary to manually
> > > tweak current draw from USB, for example when using thin charging cab=
le.
> > >=20
> > > N900 creates unique attribute by hand, but I believe
> > > POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT looks suitable. (Should N900 be
> > > converted?)
> > >=20
> > > Comments? Would the patch be acceptable after fixing whitespace?
> >=20
> > Looks OK to me. Until we have better charger vs host vs usb3 charging h=
ub
> > detection in place this seems like a good thing to do.
>=20
> FYI, I'm cleaning up the pending charger and battery patches to send out
> for review. So that includes my earlier RFC battery status patches, and
> Spinal's additions, and this patch. It will likely be several days before
> I have the series ready for posting though.

Thanks for heads-up.

I had issue when I could not charge _empty_ droid4 battery from
powerbank. Green light was blinking and current was going up and down
but never stabilized. I thought I had dmesg from that but can't find
it now :-(.

Plus, I left D4 on charger overnight, and found battery empty in the
morning. It apparently charged in the evening but then discharged.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8+Hy8ACgkQMOfwapXb+vINSgCgwqDjvKoMVjGwrmlpzth44pKJ
HuAAnRj18b8ySC+VOYnVFyO5jFV9QHol
=/9vO
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
