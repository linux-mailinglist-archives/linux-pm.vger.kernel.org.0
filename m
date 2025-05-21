Return-Path: <linux-pm+bounces-27473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB84ABFEDD
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 23:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708504E0792
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6612BCF7E;
	Wed, 21 May 2025 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="Jb6s+pxU"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0552BCF7B
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862610; cv=none; b=VZPnvD3GFALy7FLPklNIacdQPxNSldgDvi/rjbnHcfLBtav+E+M3jlpE6IRjDIR7zHECU40AGCa6r6668mlnkkCX/Xyt+u1iXTTVlcwaQUQWGRfHOjtQkWlK8grhqHotJ9qV/Q+Bbx+HLMCMKp5qECNl/YupVDG8JL54WVdPc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862610; c=relaxed/simple;
	bh=tjGJVjt9JCo9FTmODqDkaUjuR7f9y7WCHIeJhKCvBTc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=knUxsve139mqYAEV+FoSBc7KSX154acZYdLJ40T1u4HLSjT7AjIaY00kYjVV0hysAu3V6A86yciCtP4PUbsrdAhHpLHaaBF2ZoD9ch6xjEJiTfQQcwYQrf1/kAqTb/5ORz8gUpSPR52gpJqevMnUk4ga5FlWhacItF84dAGX2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=Jb6s+pxU; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747862598;
	bh=IGxf9Kl5yPpMKEOSn9zcGvlyNfFEhMz1XZ1V9xG/G+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jb6s+pxUCLaRJCbseg66wYGUm94LnhIeC4PgclDy5cEAf9OaPNCGmDMIaM9Bejx3c
	 vFUu1f1gGIAbw6FBJwEFZxNjfs/dyhKmvWmfL+PGETPcQLr1YOybZmDHIE4QlCNSDt
	 XzXAG0VI570N0lFOv54MyyoYVwNH34+mKGUEAFgA=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4b2ktG30zWz11BB;
	Wed, 21 May 2025 21:23:18 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4b2ktG2PpDz11B9;
	Wed, 21 May 2025 21:23:18 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uHquD-00000000HaU-29z7;
	Wed, 21 May 2025 23:23:17 +0200
Date: Wed, 21 May 2025 23:23:03 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-pm list <linux-pm@vger.kernel.org>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250521232303.6b66ddc90cf9a25ff07d1042@paranoici.org>
In-Reply-To: <260b6d79-ab61-43b7-a0eb-813e257bc028@leemhuis.info>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>
	<20250514222329.2db4ac81fccd10661d763ee4@paranoici.org>
	<260b6d79-ab61-43b7-a0eb-813e257bc028@leemhuis.info>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Wed__21_May_2025_23_23_03_+0200_Q=tit1JDTIoVl2It"

--Signature=_Wed__21_May_2025_23_23_03_+0200_Q=tit1JDTIoVl2It
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 15 May 2025 08:12:50 +0200 Thorsten Leemhuis wrote:

> On 14.05.25 22:23, Francesco Poli wrote:
> > On Wed, 14 May 2025 14:41:35 +0200 Thorsten Leemhuis wrote:
[...]
> >> unitdir ?=3D /usr/lib/systemd/system
> >>
> >> earlier in the Makefile and then using it in the last quoted line abov=
e.
> >=20
> > This could be the right fix, I think.
> > And it would improve the flexibility of the Makefile, as well.
> >=20
> > If nobody raises objections, I will prepare another patch to address
> > this issue.
>=20
> Thx!

I've just sent a patch that introduces this new 'unitdir' variable into
the Makefile.

>=20
> FWIW, after sending my mail my brain worked out that there is another
> problem. One that was there before your patches. One someone here might
> be interested to address. That
>=20
> libdir ?=3D       /usr/lib
>=20
> in tools/power/cpupower/Makefile will obviously do the wrong thing on
> distros that use /usr/lib64/ for 64bit libs (like Fedora and iirc
> openSUSE, too -- and all their derivatives of course). From a quick look
> other Makefiles we ship handle that fine by default, as during a quick
> grep I spotted code to handle the right lib/lib64 placement in Makefiles
> like tools/lib/bpf/Makefile, tools/net/ynl/Makefile, or
> tools/lib/perf/Makefile.

I'll leave this to other people...

>=20
> Ciao, Thorsten

Tsch=C3=BCss!


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Wed__21_May_2025_23_23_03_+0200_Q=tit1JDTIoVl2It
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmguRDcACgkQPhwn4R9p
v/5GFw/+MdZ0kbW0XM3UFVMfQvimFgKY+qY7tDawA+iG/6lDMIim0Dms8+hm+P7z
sKQqxH9H0J5ZGSfadoOUBFGqM+GvkMrgw94oX2pbXKeeB9cptO8Rys9zSbtF0AXx
8aEWmVy73a69FajlncRZ+6Lptd/ro4MWL3x+uPZ7Y0lFLdYNvM0LAaIohMEAhbOB
nS2ybMGXHoqXJoba9JSETGgI2nQidbGV1pYlVySY/+APK4OkVndzfDfmn7e4LUxo
MSwjyCsP48apwRlQncJL1DCoOIRLjCn8+rBbTCveTxE4wfi7+UkCJow0iNi8EDga
OlZqpQLmd6/n5JWu/NmizLChwnt6Dv24KXzXkMCbCUuy8h3GbMsfzE9ouQiFbKrU
8SanYVL8f/eih/Dedvel1WHmNGHG91xSVOt7bb409j4rIxFm8rZuaoj4VTGJz9sY
wYPZIJod7CLe1Wm/jGt1B9EVN8FTipuOLSXiMMsM5URIDupkDsyN2qlxmDMOw+xO
IxrR+8Ay3za9OzlN4K+0iIOd4u/BN/EAd08Q6RbJSRvmkQDMQ+HC8e6cvRwSJgnj
7hVFAeQp2Dq/TXjB38d7YQFEm839Hca/cYD2mNUpGHoCnfoMT1WGhKDZj/H1gsP8
cPROJh7u1d7H7YIfPM6qxxHXHCpMcj9hnFtztcWnqDC5HCjYves=
=wV/u
-----END PGP SIGNATURE-----

--Signature=_Wed__21_May_2025_23_23_03_+0200_Q=tit1JDTIoVl2It--

