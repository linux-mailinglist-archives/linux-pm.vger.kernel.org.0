Return-Path: <linux-pm+bounces-26906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A9AB05F0
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 00:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350DB9E1C02
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB222A4F4;
	Thu,  8 May 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="BKy/uCNB"
X-Original-To: linux-pm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D71F37C5
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742946; cv=none; b=ZdJ7JIeGEW2BTavp771vTIpxC0XvHs9iKgnApXCQAWyB/GxJuSIsf1C/DM9t55OFOnTBM8N+ez1vxt7fvW22Gpb0WJrjII8NyRkxU+e5ARdvytsjO4u8g3j9B9iDhKnHKnSsa+9+5AMKPLs9DI/OdHhLarHWOLtVm/tQM0k2zqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742946; c=relaxed/simple;
	bh=V31E9SB9S2QRVO0pPcFsq9ZLleMNHduSSEzAv95tekI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JhbEpYeqsoch3Ww6N0xd5yhBR+dyB6eptr5jCP2Sn+MPzxteBA5QE1/WgWcvKkvJWIv00mg67OYbHB9815+5xfRjYcTra1I2Obhgnz/rol09101LSVF+A8aE9A62CRVEl5dM8eJGXDiRgRzqBDStrgVVcF49E1xSvgixo6h9izM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=BKy/uCNB; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1746742934;
	bh=kZ75L65iixYMXRyBGX8tFadsaqUdRThy6YEFhU2ry3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BKy/uCNBXdmq9514Bx8FgeO24KyS1+aMH9uOwh7gWlTKQ8Z08d7Aai3blPJCPkmhZ
	 pSUIypLo7EaFVktQ0zeod+fl740e2z91l4i31tFNoIa/v7XsBaOlRsLT6DWpr3iv9e
	 7fVbxZhk0AhMDSJICcphOev0t3KbSWHhPQ1Jt7og=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ZtmpG1grQz11G9;
	Thu,  8 May 2025 22:22:14 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZtmpG10tHz11Fc;
	Thu,  8 May 2025 22:22:14 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uD9d7-00000000PbL-14UV;
	Fri, 09 May 2025 00:22:13 +0200
Date: Fri, 9 May 2025 00:22:06 +0200
From: Francesco Poli <invernomuto@paranoici.org>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, linux-pm list
 <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Shuah Khan
 <shuah@kernel.org>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-Id: <20250509002206.bd2519ba52035d47c3c32aa6@paranoici.org>
In-Reply-To: <aBzaXqz4TQkHxJjV@thinkpad2024>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
	<b36a5385-dea0-48bc-8555-e073f62cb6dc@leemhuis.info>
	<20250508001857.ef90d07f43868b2b12c2f432@paranoici.org>
	<aBzaXqz4TQkHxJjV@thinkpad2024>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Fri__9_May_2025_00_22_06_+0200_rs_Z.BaxqL7ZCN6u"

--Signature=_Fri__9_May_2025_00_22_06_+0200_rs_Z.BaxqL7ZCN6u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 8 May 2025 12:22:54 -0400 John B. Wyatt IV wrote:

> On Thu, May 08, 2025 at 12:18:57AM +0200, Francesco Poli wrote:
> > On Wed, 7 May 2025 10:07:33 +0200 Thorsten Leemhuis wrote:
> > > /etc/default/ is to the best of my knowledge (everyone: please correct
> > > me if I'm wrong!) a Debianism and on rarely used (or maybe not at all,
> > > not sure) in distros unrelated to Debian.
[...]
> > > So I'd say it's a bad choice
> > > to place that file. Why not put it simply straight into /etc/ ?
> >=20
> > Because /etc/cpupower.conf makes me think it's a configuration file for
> > cpupower, rather than for the cpupower.service that runs cpupower at
> > boot.
>=20
> Despite reviewing it, in retrospect, it makes me think the name of the
> file should be different instead; perhaps cpupower-service.conf ?

This looks like a reasonable suggestion, I can modify the Makefile so
that the configuration file gets installed as /etc/cpupower-service.conf

[...]
> > > Side node: the config file is also basically a template, which makes =
me
> > > wonder if it should land in /usr/share/doc or something like that any=
way
> > > so users take a look at adjust it to their needs. But it's just a
> > > thought, I have no strong opinions with regards to this.
>=20
> > Well, I would prefer to have a configuration file in the right
> > location, ready to be edited by the sysadmin.
>=20
> Agreed. Also, that seems to be for readonly info and this file is
> intended to be modified to have any effect. Plenty of programs place a
> default configuration file in /etc or a subdirectory.

Exactly.


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Fri__9_May_2025_00_22_06_+0200_rs_Z.BaxqL7ZCN6u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmgdLo8ACgkQPhwn4R9p
v/69CA/+NXeZ8bEgc441pUZ1oWD1iEv+ROMav0x5joiH7YOs3AXWQMdgsEdLdrJk
GEh+qc6m+9ipr2QoZc2evl6Shql6ksGnEZhuqVjIvh3VVYVg6rt47BHvzkQypPwH
WRBfc0oWh2LJRs3AgAQtAd+tGCoCggGskKNFBtIJgJLJ5pC+3hkeDQxb69RP+dC0
4sc9vypl2M1r26ytetb18NRRoIdIWkBodoqclDlvCLABop9ZpxPe/WWWVwQzr896
Ncvba1cL+afwAHpSrT08wMBE2RXwYjrecmpM1P4bxXu4A41u6hZ/HK8lDcksNpIn
rFRgzBJDiRrTL0rQ3EyZPoz26GHOvPXMxwReRqZyjsbnGJYAwLMz54rWGOvbN5Rs
4MpFJTdITRq0/P0K4kuV5YIUOE6HUnb2qtUwgGyMFwoa2puqe9gmHT3h8OHkyojR
Iyy572iCNGVL94jVTCgdTRFVqtYK9j61E74IzL2Dq7iaGjQJFbQQh2TNvg94+QN0
NQMB0VCHZSLsJd+KBbp2PwXMfTZO82INuUJHUaYffDqT3Pngqv9XNnyZJK+s5ivL
lXt9/Rne1Bs2QhFlheL3iV0LUmvi0ogSX0QtohHm8z22b1HOyzBzXWLEL6/gNqrt
M2HhWLnGsvTSG1QQ5KAjG49x/Ks2gc4QZl/pRWBaCn9hFnDytYk=
=j/Q5
-----END PGP SIGNATURE-----

--Signature=_Fri__9_May_2025_00_22_06_+0200_rs_Z.BaxqL7ZCN6u--

