Return-Path: <linux-pm+bounces-26849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF228AAEEA2
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3D24C4E0A
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15A28C2CB;
	Wed,  7 May 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="ClipfLNi"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66832219A7A
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746656357; cv=none; b=kZ6kst7F6DJUVuh7GfKzAc+aOY+qDCApk7AJpOiC/gVU0Fggc9wcT0JJKaLFWExUZmzIrtPjFgBTS0lzds0By0rX3YM/Lrgv00vHA39doukRpoIa7EPIE3MLLYTvSln85ARZE+5Xw9Znp6XRgiL01A615cYxydAOPmkZv+pSf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746656357; c=relaxed/simple;
	bh=QXqdjxCCcSWPgkwV5PwDntfgtKnY+qjSmSFijqlqZq8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qiv/nBdHWTZMfi2SMT4Pp+wdVzhF8q8nXpmNAoaCvXxLivQpYvgW6aLcGR05AUbNwS2u5cdjYi+ljyA//ScZgKMrcdAuSV41byxF0JKF0Qr2YFz7ZSFPA1ZyO6CztwMsfbVoh3CxpKuzpfTToB7BdHEnNbK/hlWG/5Lb+TIZxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=ClipfLNi; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1746656344;
	bh=+/wJ8S5pFvYOv79gs09fGabCaB/5mmss6wce84uBTUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ClipfLNiFnSlSCBbrTNjt+Ao0oRovLuY7wKU8AwSVwdsj2a8a0YIXKi/zxveNMwaz
	 uicbJRFuQ5ZNxyFpCPCg9Kf1Bb2q8t/xMclqhWCaYd5ElXQsrZ3Ej6eHzlLUfzXfdU
	 kjWz0PQl9jwIohNhiUTV+IHxe8c0FDstEbgP/kRQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4Zt8n45mFsz11Jy;
	Wed,  7 May 2025 22:19:04 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zt8n451K2z11JQ;
	Wed,  7 May 2025 22:19:04 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uCn6V-00000000KMN-3JbW;
	Thu, 08 May 2025 00:19:03 +0200
Date: Thu, 8 May 2025 00:18:57 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250508001857.ef90d07f43868b2b12c2f432@paranoici.org>
In-Reply-To: <b36a5385-dea0-48bc-8555-e073f62cb6dc@leemhuis.info>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<b36a5385-dea0-48bc-8555-e073f62cb6dc@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Thu__8_May_2025_00_18_57_+0200_RBl_ui=vrmDhm.Ih"

--Signature=_Thu__8_May_2025_00_18_57_+0200_RBl_ui=vrmDhm.Ih
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 10:07:33 +0200 Thorsten Leemhuis wrote:

[...]
> On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
> > One of the most typical use cases of the 'cpupower' utility works as
> > follows: run 'cpupower' at boot with the desired command-line options
> > and then forget about it.
> > [...]
> >  tools/power/cpupower/cpupower.default    | 28 ++++++++++++++++++++++++
> > [...]
> > +	$(INSTALL) -d $(DESTDIR)${confdir}default
> > +	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupowe=
r'
>=20
> /etc/default/ is to the best of my knowledge (everyone: please correct
> me if I'm wrong!) a Debianism and on rarely used (or maybe not at all,
> not sure) in distros unrelated to Debian.

I thought that /etc/default was used in other distros, as well, not
only on Debian-derivatives...

For instance on [RedHat] Enterprise Linux and (consequently) on [Rocky]
Linux for [GRUB], for [useradd], and so forth...

[RedHat]: <https://access.redhat.com/solutions/3185891>
[GRUB]: <https://docs.rockylinux.org/books/admin_guide/10-boot/#the-grub2-b=
ootloader>
[useradd]: <https://docs.rockylinux.org/books/admin_guide/06-users/#default=
-value-for-user-creation>

What do others think?

> So I'd say it's a bad choice
> to place that file. Why not put it simply straight into /etc/ ?

Because /etc/cpupower.conf makes me think it's a configuration file for
cpupower, rather than for the cpupower.service that runs cpupower at
boot.

> Side node: the config file is also basically a template, which makes me
> wonder if it should land in /usr/share/doc or something like that anyway
> so users take a look at adjust it to their needs. But it's just a
> thought, I have no strong opinions with regards to this.

Well, I would prefer to have a configuration file in the right
location, ready to be edited by the sysadmin.

This way distros (at least Debian and Debian-derivatives) can mark it
as a conffile, so that the package manager handles its update, when the
copy shipped by the package changes, but there are local modifications
by the sysadmin to be migrated to the new structure.
The Debian package manager (dpkg) has ways to cope with this scenario,
I am not sure about other (non Debian-derivative) distros...


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Thu__8_May_2025_00_18_57_+0200_RBl_ui=vrmDhm.Ih
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgb3FEACgkQPhwn4R9p
v/4Ipw/9HGYFR8pvc6b3xg7r1Pzn+sjmkClB4xt/3IvfI6EnVT1hP8MOS9qvjYhM
+fo0xTbeq+CzH3/oC7Kbp/egeGWe2a29L6Qcu82N7G7AhqW+DkadGbS89Izsxqj9
CdUerhfjRV+c6lmKh868XylKI7j7E999DscOmmm2rdwI43ZrgL+ZnwtQU9nvA6zR
YG0wF46V4yPjCK/4hxvetsQl9KxO5pfNoXYAmSNw96FDGGhmQaloWO9r52c1wjaL
owH06BAZYdLSUBpaqSQiHGdZ2GWbgRL2njrgOrM9+hx8GR7DL0KKeNxYR6itb3gh
cFyd0v8OzIWR8bPZ1wsayTc2IbrXF280H2wigxPilg9wVG4gkDv3MvvAwE1EKu0x
X5Ev/QQFtLTr9xzoyKN0zDO8Oz0v08nRO25gEIZMw9xdYB7rTQKAt941ZHD/Grmx
JqJ4nflC2xEBNFXZmFLuJL5C4D+CQ5YKVLgVNaixjEt3cnyQii5CHndeKH10e1zJ
Z5CGIJ35eBxCekgOU9wOq1rHScW9MfMMiz0hU7GGoJ5Du9qWx2+YgjIKege5QpmS
Zw8V9KtdOe4tFXl6gtSLwL9R2HPR276xfHDAZYVz0cz61b5oPrWlQw/76NL6SWAj
Jxim1ldMD0jp09hh557w7w6uiH1y4VooO9/8tdvFh/TYli2PXvg=
=jIIR
-----END PGP SIGNATURE-----

--Signature=_Thu__8_May_2025_00_18_57_+0200_RBl_ui=vrmDhm.Ih--

