Return-Path: <linux-pm+bounces-27157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22EAB76FF
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BB97B191E
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A2213259;
	Wed, 14 May 2025 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="WSTuGYOD"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F95296710
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254233; cv=none; b=Mb1FYc+6Q5as7FklToUtYNwyozRr8A3W6KK+KyJwZ+MC/BRVMogXeQSf2oxX7f8PbNi6KysMKacftxBAi2iIKiqANGPkydLzWWaOAlg6P1G3/QVf+24Dq1uvo04JcD83K8VdFQvPpIkOLNxsxMCauEG3mnnueoicRR/pJNW9v4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254233; c=relaxed/simple;
	bh=Po7jr/1zCSd4x7B7pGDnL5ir+QdIxdf4bG70sm0tlvA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ee1YXeaIIWGE05e+lo9Mhs3i7BuZuV36cYMf6jczkD53ll6VRO/7bSJfe0TbHn+GhYruPk1RVw4zYD6GdD5xRRuX+cpKknmxo4CdrxHaQLBLuQjAroqfu9KeCnDA0c+7kanNdTM6skQM0RMrejO7LbEmLJTrN5q3dxYKajyv2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=WSTuGYOD; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747254221;
	bh=7oJOXd1npiG89z9BvKOpvd0I++0tGACIlN9CtdKjnTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSTuGYOD3RZ7NvH+tsfvyMcJwRmzKcXZjPmdbe+UZxnPAdRBEe8yts7BrSepCy7pe
	 F+kH99wNGjWszFw14NbdAyA8CWaCOnCveWDKYYY4GjLZ+HQqgTw+yCgMkLwDHmq/qB
	 5CddE2Y8IXN3aqH7tFcRhpBBhzjBMHVz1tT8tD1E=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ZyPtj2spPz11Bl;
	Wed, 14 May 2025 20:23:41 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZyPtj140vz11BP;
	Wed, 14 May 2025 20:23:41 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uFIdg-00000000IVE-1Dz4;
	Wed, 14 May 2025 22:23:40 +0200
Date: Wed, 14 May 2025 22:23:29 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250514222329.2db4ac81fccd10661d763ee4@paranoici.org>
In-Reply-To: <16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Wed__14_May_2025_22_23_29_+0200_llX3Y0S0RykOpWsP"

--Signature=_Wed__14_May_2025_22_23_29_+0200_llX3Y0S0RykOpWsP
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 14 May 2025 14:41:35 +0200 Thorsten Leemhuis wrote:

> Hi Francesco!

Hello Thorsten!

> Many thx for addressing the issues I brought up earlier
> which now landed in -next, much appreciated.

You're welcome, I am glad you appreciated it.

>=20
> Sadly with those fixes in I noticed another issue I missed earlier. One
> from the "small differences between different Linux distributions that
> make all our lives hard". :-/

OK, the fix is simple: all other distros should be more similar to
Debian!   ;-)

...just kidding, of course!   :p

>=20
> On 25.04.25 17:07, Francesco Poli (wintermute) wrote:
> > One of the most typical use cases of the 'cpupower' utility works as
> > follows: run 'cpupower' at boot with the desired command-line options
> > and then forget about it.
>=20
> > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makef=
ile
> > index 835123add0ed..9c2b5f71fee1 100644
> > [...]
> > @@ -302,6 +305,14 @@ install-tools: $(OUTPUT)cpupower
> >  	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
> >  	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
> >  	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion=
_dir}/cpupower'
> > +	$(INSTALL) -d $(DESTDIR)${confdir}default
> > +	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupowe=
r'
> > +	$(INSTALL) -d $(DESTDIR)${libexecdir}
> > +	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
> > +	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
>=20
> That last line to the best of my knowledge is wrong on distributions
> like Fedora, where ${libdir} expands to /usr/lib64/ -- which is the
> right path for libraries, but the wrong one for systemd units, as they
> are always stored in /usr/lib/systemd/system (at least on Fedora). Not
> sure what the right fix it, it might be something like defining
>=20
> unitdir ?=3D /usr/lib/systemd/system
>=20
> earlier in the Makefile and then using it in the last quoted line above.

This could be the right fix, I think.
And it would improve the flexibility of the Makefile, as well.

If nobody raises objections, I will prepare another patch to address
this issue.

>=20
> Ciao, Thorsten

Tsch=C3=BCss!


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Wed__14_May_2025_22_23_29_+0200_llX3Y0S0RykOpWsP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgk+8EACgkQPhwn4R9p
v/5oIg/+JUZTeyyOSeWVjsz7zDb3FeQRQOnqNq3JPsVS8LFjwIQeVDG06hqvdtW2
0NePEUxue96jQEVJEI341VwbZKf9MgTEETNPdpalsxZ5SbkkQsnXAWRTDwkaG+of
aUpf8mdYB1/bigwmzV5INkRRVtVlW74yIK+pEkYDqfBZyu8K1IFS0aWNiOVv9sVu
0AVxIXsc0e0dHNPXI+dVoii3iq3he7pl/83sQMSFqPzxqDxCMx4g6C6yVoGoQQ35
kiAwhr44b87aZeETzjQi80XCnN3REmMeomlRSH5FIj45xI9mSPT0Hjy29hxwlJR+
7NDzj0H1oDVbdLeQ8tDlMv9zRMYTBPAGNM9W1eHOwkMMfwIHZHezslWpVgPDr1Hz
2IXCcGtXkfHcd9aiV9uvsj2ViZvddsNeVfCi1ZqxarbVuusstsrPgqgZbC+ZvkCL
is+c0DNs6PrbxSPOeDNNhsbblQgp4bY8urFdI0RH3T4mOByUFWazGD+lh6r4P7xz
C20Y2fkF2i93Bcd5hg3V/mQt3UocpCYxyCRCFfXMhtK1XSsiFqYpu6qGUWILqOwC
1sUdJjTQw3hoQsuVYK4k3Lnl/gDlfqgcZOchaVSVEU1vNmk7si7i7NMN277EQFqO
+Qt2JhsFpb4uxWi30jh6IXqyTVJoZC1Yh7ZPH462P+IA/D8uieQ=
=cZw8
-----END PGP SIGNATURE-----

--Signature=_Wed__14_May_2025_22_23_29_+0200_llX3Y0S0RykOpWsP--

