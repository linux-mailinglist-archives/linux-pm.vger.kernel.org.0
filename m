Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECDC8C38A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfHMVWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 17:22:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34062 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHMVWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 17:22:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8B47280848; Tue, 13 Aug 2019 23:21:52 +0200 (CEST)
Date:   Tue, 13 Aug 2019 23:22:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Eric Blau <eblau@eblau.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [Regression] MacBook Pro - suspend does not power off - reaches
 dangerously hot temps
Message-ID: <20190813212204.GA14654@amd>
References: <CADU241M42pe_vFD4QriuVm_CjnpQe0LyBUDihaDkxm5k6o7X3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <CADU241M42pe_vFD4QriuVm_CjnpQe0LyBUDihaDkxm5k6o7X3g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

You may want to cc maintainers...

M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
M:      Pavel Machek <pavel@ucw.cz>
L:      linux-pm@vger.kernel.org

> I have a MacBook Pro 12,1 model where I've hit a regression since
> upgrading to 5.2.x. When I enter hybrid-sleep mode with "systemctl
> hybrid-sleep", the laptop appears to enter suspend (screen turns off
> and keyboard backlights go out) but actually is still on with the CPU
> fan powered off.
>=20
> When I first noticed this, I had put my laptop away in my bag and
> noticed it got extremely hot to the point of being dangerously close
> to a fire hazard. It was too hot to touch and would not resume
> successfully either from suspend or, after powering off, from
> hibernate.

If you are able to push the CPU over 100C, it is a hardware
bug. Hardware should protect itself.

> I've had no issues on 5.1 through 5.1.16 but every version of 5.2.x
> I've tried (5.2 through 5.2.8) has exhibited this problem. Is there a
> known regression in suspend handling in the kernel? I noticed some
> traffic about suspend and NVMe devices but I do not have an NVMe
> drive.
>=20
> If nobody else has reported this issue, I would be glad to do a bisect
> to help resolve it.

You may want to try latest 5.3-rc and -next... And perform basic
debugging such as making sure that normal suspend works and normal
poweroff works.

But yes, if you can bisect it, it will make stuff easy...

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1TKfwACgkQMOfwapXb+vLwQQCeIKWWTjWb5sq6glJ4XSkYyVSm
yzkAnAlqlQbWuqVZ93/XoffeK7yTEEf9
=bmFZ
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
