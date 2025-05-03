Return-Path: <linux-pm+bounces-26622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0EAA8030
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E161BA15C1
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8061DEFDB;
	Sat,  3 May 2025 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="MbRwzdHO"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5F1B0413
	for <linux-pm@vger.kernel.org>; Sat,  3 May 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746270572; cv=none; b=tRGMrYE563EzrXkCWiJn5r3XIY+OLANld76t2mItWOA4oGVVQwg5iL2JlAvBW4ZY5Cy3DBf3GS5AIiISDzEIXlZAqzKd+PGAJq/0qnjXOteaXwM+64rZPQDZSHZaDL+eGhsud5bC/s0IG87p8tXH0IQWtqOs1kmYptrHJ+RJRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746270572; c=relaxed/simple;
	bh=4EQ+o8a+b0ILRiwPfoJGEMvrvSmYlaBrV+hO8dMCEtk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E5VJljTHEpOG8ArA4iI6XwwD+hHDUmodG63kgYu8YZh1hBy0ZgMgSbRLMwECjyxGtFkqxTs1ZgTLT6hxONmBbhfr/pK9cdnATO03Wq9lG82vTzjFa8FHPVQwg1372rQPmQI7fYzK/LQOhwxpIJPjN+CTQrdXrenKPSo73q801qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=MbRwzdHO; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1746269986;
	bh=d/8V2Jicqb1v6KoJDyEubBn1ST8w6xVX4XanVZw7U00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbRwzdHOsruaJ8guCNDdiAAGT/bayn5pH2b2G/FVaW5r++BR17d11d3lSB4p3pIw9
	 hVs8/Rnsz60heHdz+m0s2kAnUF44hqAdqTdb8QeXhixRwh5ACw49riQNUk7RFFywpZ
	 uaeQ6WqMErJqnBfjM9H3klZnBLeUiv6upH+0Jd6w=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ZqPv66Lglz111g;
	Sat,  3 May 2025 10:59:46 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZqPv65gCsz10ww;
	Sat,  3 May 2025 10:59:46 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uBAav-000000004Ld-3I5Z;
	Sat, 03 May 2025 12:59:45 +0200
Date: Sat, 3 May 2025 12:59:39 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>, linux-pm list
 <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Shuah Khan
 <shuah@kernel.org>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250503125939.06195e2eb96651b524721449@paranoici.org>
In-Reply-To: <bb5bb612-e98f-49ce-9082-5a883068977d@linuxfoundation.org>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<aBE9ly7vP0eryfMO@thinkpad2024>
	<20250502175309.05e66d43fc2654afb01721fc@paranoici.org>
	<bdc10540-2e4a-4f97-9007-e4b70db04c64@linuxfoundation.org>
	<bb5bb612-e98f-49ce-9082-5a883068977d@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Sat__3_May_2025_12_59_39_+0200_WeU6_p7c5b3/Mt4="

--Signature=_Sat__3_May_2025_12_59_39_+0200_WeU6_p7c5b3/Mt4=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2 May 2025 13:55:49 -0600 Shuah Khan wrote:

[...]
> Applied now for Linux 6.16-rc1 - will be included in pull request to
> PM maintainer.
>=20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?=
h=3Dcpupower
>=20
> thanks,

Thanks to you!   :-)

Have a nice weekend.


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Sat__3_May_2025_12_59_39_+0200_WeU6_p7c5b3/Mt4=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgV9xsACgkQPhwn4R9p
v/5GyxAAki5U0lVqylrCz/o2agGBe/JsTu03J9Q3aDUcHU9VeIgVIEaPBotkvkkh
3ra9Qfw5s8NYLH18vObIHe24YOTLkJUja9fs8L5ZJI8H6Uh/a0CEJp7+OwmEabYF
VTjzY9iJsGcgMBcPNJ/TZAJSfDRcFfYgfQXem4+Xrl1MbhPOeJcWRKEbfEXcfg7T
zYkH4u2p0JwXISryXyyhwbOe18RxodYldPZFDVrM8btv7Wgm/R3jimQ6HDdWDA0W
qn7ncZttVniUgCKq8dpJVv5LxqaQw7XlPAZDOgJT8LzDcmmOfCOWhptrqGTQRO/x
XmrpA3y8sbXYbitYrm5XtqBgSxc4Dt+b3dBMNJUfvMzpoeNlJhq/XLB54dzPMhTo
XgY60aSVvldSdXL5idn2X71yk61Vy2JFo1yL5N+kfLZ69YZsB/GZb+jOspazGdI3
H5V1K14WkourFwKlbjv43WL4/NcfZklYoQpn0nX4emjToF7g/R3Alm2fpn7nylx/
e6O3yKgtqUPFL8i4vvQhdFHk60LzkDgwA7Rb05/wLFiSepcReID8lSyn5sSUEal7
Hdb2r5ex7IVJJ29Nf8SN7wrVuV0U0062EjTXxS6hTvlOhRzxav6bX7DJGpR4YUHP
wzCtGEy2gfdSnwmi4ZXuPpao4MvN9fcIpjdM0v5bra3JpidKDb4=
=D18l
-----END PGP SIGNATURE-----

--Signature=_Sat__3_May_2025_12_59_39_+0200_WeU6_p7c5b3/Mt4=--

