Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5633A514
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2019 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFILRg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Jun 2019 07:17:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54759 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfFILRg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jun 2019 07:17:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 02DC18022D; Sun,  9 Jun 2019 13:17:22 +0200 (CEST)
Date:   Sun, 9 Jun 2019 13:17:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Subject: 5.2-rc2: low framerate in flightgear, cpu not running at full speed,
 thermal related?
Message-ID: <20190609111732.GA2885@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

When I start flightgear, I get framerates around 20 fps and cpu at
3GHz:

pavel@duo:~/bt$ cat /proc/cpuinfo  | grep MHz
cpu MHz		    : 3027.471
cpu MHz		      : 2981.863
cpu MHz		      	: 2958.352
cpu MHz			  : 2864.001
pavel@duo:~/bt$

(Ok, fgfs is really only running at single core, so why do both cores
run at 3GHz?)

But temperatures get quite high:

pavel@duo:~/bt$ sensors
thinkpad-isa-0000
Adapter: ISA adapter
fan1:        4485 RPM

coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +98.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 0:        +98.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 1:        +91.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

And soon cpu goes to 1.5GHz range, with framerates going down to
12fps. That's a bit low.

Room temperature is 26Celsius.

The CPU is Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz . I guess it means
it should be able to sustain both cores running at 2.5GHz?

Any ideas? Were there any recent changes in that area?

Best regards,
							Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz86swACgkQMOfwapXb+vKdPQCeMqRBO1sszkxVYmrFdpM8K221
6ZoAn01zFFX0NuUnU3CTg0vhnDleQPmb
=QyRT
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
