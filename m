Return-Path: <linux-pm+bounces-26667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA77AA9D9E
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAF017D52D
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022A425D213;
	Mon,  5 May 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="N+boQfWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [82.94.249.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB101E52D
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.94.249.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478568; cv=none; b=IdSDCglJGpSomNKXxaq8eipmsgwoWrbL3raVjSAL134mzRE8kcBVldrowQriOCxGODlBnTYeSerXpAewh0GVhHtYY7PtDjRCyYW5mR9n2T0j1Mf8L8LpIB5Uo+BlvM0ocInWRv+qDjT2ZULRa275vksZy5bKCxM0BzJjNOTS2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478568; c=relaxed/simple;
	bh=W3fbjy18nrvEbedQynK8qn32FgFS+w4Yeur+JJlft0o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DRbI0wd318GuazGRiOxtkiXbcxkY499+OfkoEae2QiGpXcw5UNWD+MUdYSvtYBkRMYwlGxnG0iIp6EuqYDhwXgSHSAqOJ7H+zd4cyHXORzqWPALB5TMn+/Oq8ESmal1/VjAGJXO9Tfiet2kHuDq6Xgrb6/9migNKUSQFDuWmutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=N+boQfWM; arc=none smtp.client-ip=82.94.249.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1746478556;
	bh=h7+7SOfuvJVQTPT3pWohw21gh9qU5O/JlrE01rwCyqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N+boQfWMFlbQkB9GzpMSOBRoXieZIwaoKPjxcvfha1u8wbll1Y3InK2/0edeFGiAQ
	 +xw3h2S5KUYMEKbEiPGBL9fNQQUCHkplQizlogSh7Q8a1ytsn0hCkMeCL7VV86q6mq
	 20ca9dzZW8eV1cpgfLSpddxY/oBTRJebqD0qA5ro=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4Zrv240CHCzGp3n;
	Mon,  5 May 2025 20:55:56 +0000 (UTC)
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zrv2375BPzGp3m;
	Mon,  5 May 2025 20:55:55 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uC2qw-00000000FuL-3dTd;
	Mon, 05 May 2025 22:55:54 +0200
Date: Mon, 5 May 2025 22:55:45 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Shuah Khan <shuah@kernel.org>, linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Justin Forbes <jforbes@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250505225545.7ed30f420ea8d1b6f3d9b0ce@paranoici.org>
In-Reply-To: <d06fb5d6-b8fe-4c4f-9ee9-6710c05cc51e@leemhuis.info>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<d06fb5d6-b8fe-4c4f-9ee9-6710c05cc51e@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Mon__5_May_2025_22_55_45_+0200_GXX+xG0.Tyw4cEOO"

--Signature=_Mon__5_May_2025_22_55_45_+0200_GXX+xG0.Tyw4cEOO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 18:06:30 +0200 Thorsten Leemhuis wrote:

[...]
> On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
[...]
> > Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
>=20
> Lo! I'm wondering if the the DESTDIR usage in this patch is wrong, as it
> caused trouble for me today when it showed up in -next. During debugging
> I furthermore found a related problem.

Hello Thorsten!

I am sorry for the trouble that my patch caused, while you were testing
the build of RPM packages for Fedora.
Thanks a lot for taking a deeper look at the issue!

>=20
> > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makef=
ile
> > index 835123add0ed..9c2b5f71fee1 100644
> > --- a/tools/power/cpupower/Makefile
> > +++ b/tools/power/cpupower/Makefile
> > @@ -2,6 +2,7 @@
> >  # Makefile for cpupower
[...]
> > +	sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${lib=
execdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupow=
er.service'
>=20
> While building -next kernel RPMS for Fedora the above line lead to the
> this build error today:
>=20
> """
> /builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT/usr/lib64/systemd/sys=
tem/cpupower.service
> Found '/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT' in installed
> files; aborting
> """
>=20
> This somewhat cryptic error message means that the path
> "/builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT/" ended up in the
> file "cpupower.service"; RPM noticed that and rightfully aborts the
> build, as that path should not end up there. It's inserted by the sed
> call in the last line quoted above.

Yes, that seems to be exactly what happened.

>=20
> I could easily fix this up in the RPM spec file with another sed call,
> but wonder if that path should end up there in the first place. Not
> quite sure, but I guess it should not (removing the first two
> "$(DESTDIR)" in the line with the quoted sed call would fix that).

I probably misunderstood the purpose of DESTDIR.

I thought it was intended to define a custom final destination for the
installed files (as in "I want the whole thing to be installed there!").

But maybe it is instead intended to define a custom temporary
destination for the installed files, which will be later relocated to
the root directory / (as in "I want the installation to end up there,
because I am building a distribution package, but the files that are
placed there, will eventually end up under / , once the package is
actually installed on an actual system!").

If the main purpose of DESTDIR is to define a temporary install
directory for (RPM/DEB/...) package builds, then I agree that the sed
call should not have those two "$(DESTDIR)" in the regular expressions.

I can prepare a fix for this issue, if others confirm that the intended
purpose of DESTDIR is to help package builds.

By the way, should I prepare a v3 patch, or a new patch on top of the
origin/cpupower git branch?

[...]
> > +	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
> > +	if test -d /run/systemd/system; then systemctl daemon-reload; fi
>=20
> While investigating the issue I did a manual local build using
> "make DESTDIR=3D~/tmp/out libdir=3D/usr/lib64 CPUFREQ_BENCH=3Dfalse insta=
ll"
> to take a closer look. That make call then made systemd ask me for the
> root password, which I found odd. Turns out that happens due to that "if
> test -d" command quoted above.

Yes, this is another aspect that seemed tricky to me.

I thought that the "systemctl daemon-reload" should be automated
through the Makefile, but I agree that issuing this command is not
always useful or desired.

If the "make install" call writes the 'cpupower.service' file to a
location where systemd does not look at all, then reloading the systemd
daemon is pointless. Also, if the EUID is not root, reloading the
systemd daemon is probably not what you want to (or can) do.

I could add other conditions to the "if", but maybe we should not
complicate things too much.
Maybe it's better if I drop the "systemd daemon-reload" command
entirely, and add something to the 'README' file (a suggestion to issue
this command manually, if one wants to let systemd see the new service
immediately, without waiting for the next reboot).
After all, distribution packages have automation for systemd service
unit installation anyway...

What do others think?

>=20
> I'd say that should not have happened this case (or maybe in general?).
> The service afterwards would not have been available in systemd anyway,
> as the service file was as instructed installed to
> ~/tmp/out/usr/lib64/systemd/system/cpupower.service -- but there systemd
> would never have found it own it's own, so reloading the daemon is
> meaningless in this case anyway.

Yes.
As I said above, you are probably right that there are a good number of
cases, where one does not want or need to reload the systemd daemon...

>=20
> Ciao, Thorsten

Bye.
And thank you again for reviewing these aspects of my patch!   :-)


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Mon__5_May_2025_22_55_45_+0200_GXX+xG0.Tyw4cEOO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgZJdEACgkQPhwn4R9p
v/4RyhAAhfIeZhONBKt5txkpoEa1xg33AQjV07Tqma7woyGuMlPtW/MQdFTRrOjV
g9lqVfQpgl43LFEZJeA39GWWNnWTw+dFiocvhJ9Tr8PwOoi8ryAkVlALljJBxOy6
FPrniSOEkTqkUDeqHAq8uvz3ATqjGXiHc1DXEEseQADJwpDYGpgzuSeDok7utkB1
U/4dBmWDN9T3uwZ3E4Hbp71+1M9gQgO3lIluaHWxSJtLGnQnwnYej8ORsUn6lJbh
9y/jE0+fyxVkSOK3vJBSxEGABs/VWkxH9I4Wluia6LUneSJbO2dlMNt+QlPBFOz7
KgRU5On2RFkkCuDXvmjA8/Yhr9p2ZddCtjqQT4kvuDpy06TyBto86PHIuvOwvZRa
f8O59ZQlZy+kFrCHXryUdohtXpwV2PVcsbZFslSUUkX2bssb4XR4tVECyz6O+C/2
ZJxnurekC/lS5wLTbiD+ygLEZx5i7suO02MS254TXx/nhEwt+lh4bIcjsryfT6qo
8G4Epbkamsidd3NTVMIlAEaSZDF83lAQHkgx13ceYh9LxV65NOi6vuWS8vARlJHv
qJg89oSBVy3aNULK7BBUY/K3rZ/uQiTbC51B+FcGpAzy+GsCLMrXbbFrLp4GbJmD
Aw3e0CuAf+AR6a1hvd95a9KoRqdsl/VaAExNPf2NRsErwQ+cEfY=
=dIQq
-----END PGP SIGNATURE-----

--Signature=_Mon__5_May_2025_22_55_45_+0200_GXX+xG0.Tyw4cEOO--

