Return-Path: <linux-pm+bounces-26226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99897A9CC8B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601E57BC99A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C1274676;
	Fri, 25 Apr 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="uHI7D7T3"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA911274FC9
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594052; cv=none; b=N7BZctZTOVa3B/58l4svBxjG4BpZLh4S3wcKzdQnE2mtu09MoapCS9ZoCSiDedEreW0993IpSY6c0zqSbePNhyxuDLzs8vimWBKPrc79Y4ykU+mO4GvmL83x5Fc9oXqN1rBdlHSq85M/hNcsPGgX+fOY9RHGZqToOIqTy37frP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594052; c=relaxed/simple;
	bh=5UOZ/+xgRchy1qgXE6gm41Yq9OobjMHNvdYYPCoHcAI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bWBt5XAop98r+cmnFAFE9zx/B5DF3riKIJ4W+m0ylUQ6/yRrWeYgvTd16Ys+/uGPj2NrQzfswq9f85XJTNoEl/pqlsRxxMBCpiprepwVp7mApPaz01CcgGDevGYlEZSJWIykkGHtToJqhYv2qVYJMUc41WvXPkzD0/cQ/+MCikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=uHI7D7T3; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1745593570;
	bh=xCTlvMwMqquSbFM9ghcjnFSzLLlilL9GbmDprFuJ758=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uHI7D7T3ayI4jsDZPFkU9l/UqAdkRNxqXgBiyOucvkC3s4teCHJaqKr9gvlkN4QBF
	 XCqkZDx8i+IIbWpDxt6ee+bvjTBoky0IPEIRCZBq5v2dxyfYATyTiqEh19o5Bu2Lh+
	 gdq/gyzDQtatmWO4tZptMZRqJDhwG5GERJDmPBdQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4Zkbl60qz6z11D0;
	Fri, 25 Apr 2025 15:06:10 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zkbl60FZ7z117h;
	Fri, 25 Apr 2025 15:06:10 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1u8Kcz-00000000VYm-0YOi;
	Fri, 25 Apr 2025 17:06:09 +0200
Date: Fri, 25 Apr 2025 17:06:01 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH] cpupower: add a systemd service to run cpupower
Message-Id: <20250425170601.4c1dabcea6dcd38d3b365761@paranoici.org>
In-Reply-To: <aAZn3rcwa5e-L68i@thinkpad2024>
References: <20250408203641.37195-1-invernomuto@paranoici.org>
	<aAZn3rcwa5e-L68i@thinkpad2024>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Fri__25_Apr_2025_17_06_01_+0200_zg19+vJ6dwYBxz9P"

--Signature=_Fri__25_Apr_2025_17_06_01_+0200_zg19+vJ6dwYBxz9P
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 11:44:30 -0400 John B. Wyatt IV wrote:

> Thank you for sending the patch Francesco.

Thanks to you for taking the time to review it!

>=20
> There are several issues:

Let's see...

>=20
> On Tue, Apr 08, 2025 at 10:32:46PM +0200, Francesco Poli (wintermute) wro=
te:
[...]
> > +systemd service
> > +---------------
> > +
> > +A systemd service is also provided to run the cpupower utility at boot=
 with
> > +settings read from a configuration file. In order to enable this syste=
md
> > +service, edit '${DESTDIR}/etc/default/cpupower' and then issue the fol=
lowing
> > +command:
>=20
> Edit what? What should they change?

I thought the 'cpupower.default' file was adequately self-documenting...

Edit the file, uncommenting at least one of the options (GOVERNOR,
MIN_FREQ, MAX_FREQ, FREQ, or PERF_BIAS), depending on your own
preferences.

I changed the text in order to be more explicit on this.

>=20
> I am new to systemd files so knowing how to test this is important.

One way to test it: take the options you usually pass to cpupower
and configure the default file so that the same options are
automatically passed to cpupower at boot.
For instance, if you usually run

  # cpupower frequency-set -g conservative

then you could edit the default file so that it contains:

  GOVERNOR=3D'conservative'

and check that this governor is actually set at boot by the systemd
service.

Needless to say, you can test it with any other options (not just your
favorite ones!).

[...]
> > diff --git a/tools/power/cpupower/cpupower.default b/tools/power/cpupow=
er/cpupower.default
> > new file mode 100644
> > index 000000000000..b2fd3c37e277
> > --- /dev/null
> > +++ b/tools/power/cpupower/cpupower.default
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (C) 2012, S=C3=A9bastien Luttringer
> > +# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
> > +
> > +# defaults file for linux-cpupower
>=20
> Should be:
>=20
> # Default file for linux-cpupower

OK, I applied this change.

>=20
> Otherwise, the additional comments added to the Arch files are welcome.
> :)

I am glad that you find them useful!

>=20
> > +
> > +# --- CPU clock frequency ---
> > +
> > +# Define CPU governor
> > +# valid governors: ondemand, performance, powersave, conservative, use=
rspace.
>=20
> Since we are at proofreading; please capitalize valid.

OK, done.

>=20
> > +#GOVERNOR=3D'ondemand'
>=20
> One thing I noticed is that you changed the variables to their
> uppercase. Is there a reason for that?

There's no strict rule for this, but, usually, shell script variables
are uppercase.

> Have you tested it?

Yes, I tested it.

>=20
> Last you wrote, you copied the Arch files to test in Debian. Once again,
> not familiar with systemd files so this is a change.

Last I wrote, I had taken the Arch files and enhanced/modernized them
(the variables had already been turned to uppercase).

[...]
> > +# --- CPU policy ---
> > +
> > +# Sets a register on supported Intel processore which allows software =
to convey
> > +# its policy for the relative importance of performance versus energy =
savings to
> > +# the  processor. See man (1) CPUPOWER-SET for additional details.
>=20
> double space

Good catch, fixed.

[...]
> > diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cp=
upower.sh
> > new file mode 100644
> > index 000000000000..a37dd4cfdb2b
> > --- /dev/null
> > +++ b/tools/power/cpupower/cpupower.sh
> > @@ -0,0 +1,26 @@
[...]
> Where did you get this file?

It's an enhanced/modernized evolution of
https://gitlab.archlinux.org/archlinux/packaging/packages/linux-tools/-/blo=
b/dd2e2a311e05413d0d87a0346ffce8c7e98d6d2b/cpupower.systemd

> I do not believe I see it in the Arch package repo.

It was called 'cpupower.systemd', which I don't consider the most
appropriate file name for a shell script...
That's why I renamed it as 'cpupower.sh'.

> What is it used for with the systemd scripts? They do not
> reference it.

The patch adds the following line to the Makefile:

  $(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'

hence, this file is by default installed to /usr/libexec/cpupower

Then, the following Makefile line:

  sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${libexec=
dir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.s=
ervice'

replaces __LDIR__ with $(DESTDIR)${libexecdir} , while the service file
template 'cpupower.service.in' has:

  ExecStart=3D___LDIR___/cpupower


In conclusion, 'cpupower.sh' is the shell script that is executed by
the systemd service, with variables set in the environment file
'cpupower.default'.

I hope this clarifies.



--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Fri__25_Apr_2025_17_06_01_+0200_zg19+vJ6dwYBxz9P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgLpNkACgkQPhwn4R9p
v/5/8A//bewHNEP7l0/fiMhXMvBIfk1Ehnr+E8qsbTUPpAVhyLXiZCvcgwF8v4cP
/cVjk30qulDw30+ePeET++gsaLBNOnO+tV284owd9pTKxdvx0AYxvFaORscPdQOd
UkEsGDbIC3taBZsXNu1Xd4UfgZiXsYUUtbWjb49/Cz9IN+GGouhNkfxbucBsglwW
3PITfX6spfbIspnRZgre+tkF+MXpR07FJWwpnoyxTF+HcY2LUqIDjOI/HTlVRNpW
Dl8bwQRffMJ72KxxaKstBDpkSYcsQeSCLrYiuA13qJ6lQwRpIcReBuDPN2NJr1EY
ILjj94rVZPbXBCu5YpF54Or71CNYuI3OiJ2EvM0Oe47yFY90zwS41Q9iIZtOLI33
zbRVDNGl+6oEZQaLyxxgiDC39azgdOxE2slHCDh4fEBbtnGCHMpG2ED+98Z/xMrf
pWco36GOsDaYE0O/hTcaF30Gm7Nd0n5TGwd3rX1xdiEfpQTUnQqrXuBN9dQeNFbN
M4XmkLVWJjpRI1t3B6Hzb2AR6Qe9yGFAvnNgCWUk5qlj3AUgNiuZxGu4z03Bw6Xt
DZYKfK8RxmLoRXzJ7H5MFw3Efv/yU61hp6hZAv6mbw8zDIXQmfHmhsOXy69AOWbn
U+K+cvu58a4x8LNDZ5y1L3LiL4SAIJPngHp1JBW04d58rqvT/Nw=
=WE+O
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Apr_2025_17_06_01_+0200_zg19+vJ6dwYBxz9P--

