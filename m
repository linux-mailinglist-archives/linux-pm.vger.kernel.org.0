Return-Path: <linux-pm+bounces-27158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D8AB7731
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63554864F13
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C82951D2;
	Wed, 14 May 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="ZtG8OBVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FD295511
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255165; cv=none; b=f/kOLbcAy1Te8L0v+iCLQbyXZtAxBsNyLPHsMRfn2RF7iJH1V7w+qUBZIN9pG5sucKeXMMphz4ztfXhirjbjrWifr6u6BilAnaPeJJJH/rjN04bDIFQkgTpr6RbeL6a+eEQVh1daThrZuJDYuoqDJSVN3T4GBf3sHN1WKu7r1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255165; c=relaxed/simple;
	bh=iYWHmSCg8uppFDBxbIurmJ48ngdDVxb6gy3gbopBRYY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XGP9Bx1CXzAsWNRgCnvV589pXqK2xbpQu5jWRdPD4XOycSxOemNYgFzefqWqTWlNXQzP932Tk8QXhMzqw1UeZ71z0a1A694JY/4/3zTEAGwf0M2+Oc+RDMjkBZuNMB38PgC3FJFqpF3aKW0NBZspXlzvwWm9MYa+3PjX1NtDsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=ZtG8OBVx; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747255160;
	bh=gmivtzF4wdESZjrZIeqtGON4XgLnVJLEX5CXGpHDQYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZtG8OBVx7rl9c2qm1BSio8ATp0kf0qr4AJXyRXCaHbNGQ7dric6/I8Ob3tdsEGhBy
	 KT6tmP7m7Yrax3nKLl8OdprrE8HHlGdb4j0dG9ZqjOtcE1FvtTGa3ZwH+/WOhjvVq1
	 TQcGqdTdR/kDjueUs5sE8JARiJYtrJtjZpci1VHI=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ZyQDm6VYVz11FW;
	Wed, 14 May 2025 20:39:20 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZyQDm5kpqz11FP;
	Wed, 14 May 2025 20:39:20 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uFIsp-00000000JQA-490S;
	Wed, 14 May 2025 22:39:19 +0200
Date: Wed, 14 May 2025 22:39:02 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, linux-pm list
 <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Shuah Khan
 <shuah@kernel.org>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250514223902.fe58651168d7289bf0923281@paranoici.org>
In-Reply-To: <aCTYhzqYFNX6D9Vm@thinkpad2024>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<16ad2364-0161-4724-90e1-b57559168843@leemhuis.info>
	<aCTYhzqYFNX6D9Vm@thinkpad2024>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Wed__14_May_2025_22_39_02_+0200_gfZaFiKfTBrf9fAT"

--Signature=_Wed__14_May_2025_22_39_02_+0200_gfZaFiKfTBrf9fAT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 14 May 2025 13:53:11 -0400 John B. Wyatt IV wrote:

[...]
> Checked the Arch pkgs and my Ubuntu 22.04 install.
>=20
> Both of them copy service files to that folder as well.

Yes, systemd.unit(5) man page (on my Debian trixie installation) says
that

  /usr/lib/systemd/system/*

is on the System Unit Search Path.

> The Debian package
> is difficult to read at a glance.
>=20
> The problem is that Fedora installs libraries to lib64; Arch and Ubuntu
> (22.04 & likely Debian) do not from what I can tell.

I confirm that, on Debian, the libraries do not go to lib64 .
The following is the list of files shipped by the 'libcpupower1' binary
package (on my Debian trixie installation):

  $ dpkg -L libcpupower1
  /.
  /usr
  /usr/lib
  /usr/lib/x86_64-linux-gnu
  /usr/lib/x86_64-linux-gnu/libcpupower.so.0.0.1
  /usr/share
  /usr/share/doc
  /usr/share/doc/libcpupower1
  /usr/share/doc/libcpupower1/changelog.Debian.gz
  /usr/share/doc/libcpupower1/copyright
  /usr/share/lintian
  /usr/share/lintian/overrides
  /usr/share/lintian/overrides/libcpupower1
  /usr/lib/x86_64-linux-gnu/libcpupower.so.1


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Wed__14_May_2025_22_39_02_+0200_gfZaFiKfTBrf9fAT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgk/2YACgkQPhwn4R9p
v/7XRA//Ynm6nMbPmENTm0HTlNUrHmn3b3L2xSEkvn+X1uu2piI+OQ4P4+7d5Hl0
jmteH1zVnPyhd3GvtEhaqm6w7o2+tnVQqBU6yxwtKmhWbQFu6A7Rokq3g0IljNDC
3wt9aFvHX5EDYmT4w30NC0xH5ynwlG9oPi8I31kMYQ/jKpsOjchD3ih8hjfIFsl5
z1pgMim/ob8eZiCIqEOYo4qtPF73QmdT5y2U6YkcOnA6R1GLmgL9cnXZ17bDbEBz
DvGzQAr3z3DX4Usv535CVe2zRaU7W4WOev+Wk9DKTyeFnHHl5AMfQY1fdYGp74Cl
+cK4Uhxvu71UGpV9v5DTylN9QMxYKK/bHMh9RxnxJTlO5X895NN95tBvd8FZbXi1
saXt/M9hSeMsZcxN/+X4MaOygNOznQVihbroh2Y5HOVIiNYa/9Q2u8QOghmLe8U0
7GEGeIWEBXwurmXc8dcPCOv0KsguaIXXEkyY23URUTtbNiw237XIneWZD20Ny5Lu
MyJ0wty/Yq5nvAIvL63O6d1M0YP5WRAmW24mxkWqsYhnqpYQbMhamy2PU/U9X0zi
bR4O3xzhStGZdRw+GWiSRSE7ep14NMt2vfOLBQFpMB07ycHQC4ZDALXP3YQ1vXAi
ZCkLHkKczSWrMAHCjhy0JynuxPK+2GwPyq6qugyB8QzvD9FXL7I=
=m7JS
-----END PGP SIGNATURE-----

--Signature=_Wed__14_May_2025_22_39_02_+0200_gfZaFiKfTBrf9fAT--

