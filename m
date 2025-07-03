Return-Path: <linux-pm+bounces-30040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE45AF75BB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15D83A9750
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49027176ADE;
	Thu,  3 Jul 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTO3y/sR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AE13B2A4;
	Thu,  3 Jul 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549552; cv=none; b=HPDp+Lw6EKjfMKaj/yzuhRrr/g1+VaPF3iEakEGe9FEPC/9dLdBNkj+pkSuudu3BoCmCnHv9D5IHnMMz+aexdE5WGyMp/b9aFkroZLxbxRcCgU8F5IaUn0rCGby0DWMEKbO5Xc5OL++265Zc7n/rnU1EnWjCID1zqzcAquYjchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549552; c=relaxed/simple;
	bh=zGKkOzJI2At6lwlypOoOWjmLIZuzEOoWGySWBtnvhTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuGOt5Tjua0awFDy/q5Ijprop5Dwbl08q6C03jDaG6tL7Fo/F2ZxROiji6obs/vVJdzJH8NKInyhq60gGb3paY+AlW2KTrnBNvLVzhT8dG4azXUtKDN0J9G7vkY8AMoCUbpqZXcmYZvnTFEKheQNBIHZfyzWSBtuT/63607hb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTO3y/sR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso4464076f8f.1;
        Thu, 03 Jul 2025 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751549548; x=1752154348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzTZN1Rgi3KEaXkVhx7sTEQ+GfRghm0dQNuxhM8Lk7o=;
        b=hTO3y/sRMpU7KHb3YXqVcBt+kadH6BFfvfVvNGab6ykLtzoVBAAQj7JGijc5gVtE/t
         pcCmw3gSHjgCMJBM7KVr8+FF/Sub/vSBYM8vGNH0TnO/paI/DgWKJqjdaQEZBx636iqH
         Q9UnM5MkcoacKIe2KcGSrGPq+nkb65oqX6AhDSlnjY5KmF3n4fOBLXKR5XolXZNFoS4h
         lREs5XWG1TsOE9AJKU+pCxURgUuNqUBn29xe/TayZ+ux25OTv0OB1lvg8TVPyKQpo69H
         y6bumlK4kOM1TcXnePBCjeTVFS5PMGQeM5B250hdAx9axyb4Ak6P8CLqxpWBUKD5d5m9
         KUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751549548; x=1752154348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzTZN1Rgi3KEaXkVhx7sTEQ+GfRghm0dQNuxhM8Lk7o=;
        b=Pyj3SwcsXH6Ev6kBO34HAa4E6b5SXqm1DpN3HqaSnee3IYVL39L9ELcTzzNrT2JlM1
         HaZIhNRYn/BgvsjbInEXWT+JZFagZSTOtMUgrDfdni/tgrva9RPkJJh8MI8kcV7sBUsj
         ztba2L8lwegFrvDnjngkSI9BjY6qQ1rgRgA/0WiHCMK3OVojccdJ7Oh6VqX5gq4qMKKS
         ClhUMaI2EdEbZ2/NX65TrHLGEDxQY3G9crzRwSkfuGYtj6kuUkVIell++sZVK7d/4TrB
         /v07lrYEmdUEJSuMilECVcDfpKg03WgRweWqWmumgN1r5VJ+pBCq6721ViG8XNd3S4eg
         kT5w==
X-Forwarded-Encrypted: i=1; AJvYcCX4JWNlMzmnkzaBZXbYgnKPECJdwhnUW9Jk3JkUMNbssktk23N2FsJR93bVm6Aq4BlohP6co0azeg==@vger.kernel.org, AJvYcCXrxJzTZfBbS4SwViw0PcgyBrxXptbHhW2GCFCF+zHqJ+XmIRb85JtOh6hqvVohueHw4Pj7fTWSgTaNouQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNZYxmxS8PN/4GruUTg+wbUIq+LbCSt32KC9E15NwFepoecUX
	6iBy1P86kivv3YAGG4Ss4LLWlkkvoOW/sqCF+U2FZuuUccv9B7M0+4tMUogf4Q==
X-Gm-Gg: ASbGnctC1+YMIWFtYKImV3UAOJE7HxWGL5ipMNIDvQ9BGq/o5mbJzXx94jDhPkYTIxC
	y7QwWMsJPLEstSkgRfCjbDVS6EKnvjj2UgGDhx/+Mpd+HDgqAjlm/lUawkdV7h5gGV8SfJEBX/D
	9lqH4D9KafAhJENQjynsvOp58htF9GNCo8hdCgdHMBwbhwvTeh3UtUWe6PAXGWQZEF+JF7R00YT
	2m/ZSg+/fqUHEhYHpsRZdOV62Ye1kzV7DhDGpPYjB3D18PPnkWTDYnMRaIHmhcxfNt/n1VEKjbb
	TCWw2VHOsrplvId2C2C9kb/CRdm2WCv2X1TOwLIx41gyO8GdnoaJHrEjHpV5XFEK/iHfPgd2CKp
	LkqlqW7wOOpfanU79b2txNu6AJptv9n19H6g+ARnNRwh1w9vJ
X-Google-Smtp-Source: AGHT+IGWpisDXiFyyqwzWsMXcKSEHmRXU6edUilLRNhMLwl6kmpAmMNt1c/YASvIJDD2NqdC0Xef1A==
X-Received: by 2002:a5d:64e4:0:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b32b14582dmr2868264f8f.10.1751549547337;
        Thu, 03 Jul 2025 06:32:27 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a999c8cdsm27218775e9.24.2025.07.03.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:32:25 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:32:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: Forcing devices into idle
Message-ID: <e635l6gfpg7amck2hnu4l47tnc54lr6e26v7y3ohaywil6pjwr@4trxzfdigo62>
References: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
 <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com>
 <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>
 <hjkm55hus3ctueydf7ebfb25hbdw6w3spdzx7maauzlzmnakas@noqexx2pxxtj>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kl7qpfexrmgtjonf"
Content-Disposition: inline
In-Reply-To: <hjkm55hus3ctueydf7ebfb25hbdw6w3spdzx7maauzlzmnakas@noqexx2pxxtj>


--kl7qpfexrmgtjonf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Forcing devices into idle
MIME-Version: 1.0

On Thu, Jul 03, 2025 at 02:06:00PM +0200, Thierry Reding wrote:
> On Thu, Jul 03, 2025 at 01:12:15PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 3, 2025 at 12:33=E2=80=AFPM Oliver Neukum <oneukum@suse.com=
> wrote:
> > >
> > > On 03.07.25 12:08, Thierry Reding wrote:
> > >
> > > > Any thoughts on how to solve this? Is the pm_runtime_{put,get}_sync=
()
> > > > method acceptable? If not, are there other alternatives to achieve =
the
> > > > same thing that I'm not aware of? Would it be useful to add a new s=
et of
> > > > APIs to force devices into an idle state (which could be semantical=
ly
> > > > different from runtime suspend)? Or is this all too specific for any
> > > > kind of generic API?
> > >
> > > Basically what you need is what happens when the system prepares to
> > > do a snapshot for S4. However, if you just perform FREEZE and then TH=
AW,
> > > devices will assume that user space has been frozen. You need a way
> > > to substitute for that assumption.
> >=20
> > Well, you just need to freeze user space beforehand.
>=20
> Freezing userspace seems a bit heavy-handed. There's only a very few
> devices that need to be put into reset (such as the GPU), so most of
> userspace should be fine to continue to run. For the GPU the idea is
> to block all incoming requests while the device is forced into idle,
> and then to resume processing these requests after the VPR resize.
>=20
> But maybe freezing userspace isn't the heavy operation that I think it
> is. Ideally we do not want to suspend things for too long to avoid
> stuttering on the userspace side.
>=20
> Also, I think we'd want the freezing to be triggered by the VPR driver
> because userspace ideally doesn't know when the resizing happens. The
> DMA BUF heap API that I'm trying to use is too simple for that, and
> only the VPR driver knows when a resize needs to happen.
>=20
> Is it possible to trigger the freeze from a kernel driver? Or localize
> the freezing of userspace to only the processes that are accessing a
> given device?
>=20
> Other than that, freeze() and thaw() seem like the right callbacks for
> this.

I've prototyped this using the sledgehammer freeze_processes() and
thaw_processes() functions and the entire process seems to be pretty
quick. I can get through most of it in ~30 ms. This is on a mostly
idle test system, so I expect this to go up significantly if there
is a high load.

On the other hand, this will drastically simplify the GPU driver
implementation, because by the time ->freeze() is called, all userspace
will be frozen, so there's no need to do any blocking on the kernel
side.

What I have now is roughly this:

	freeze_processes();

	for each VPR device dev:
		pm_generic_freeze(dev);

	resize_vpr();

	for each VPR device dev:
		pm_generic_thaw(dev);

	thaw_processes()

I still can't shake the feeling that this is sketchy, but it seems to
work. Is there anything blatantly wrong about this?

Thierry

--kl7qpfexrmgtjonf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhmhmUACgkQ3SOs138+
s6F+6g//aRuHpYkzTMvccJ4QyH5yNDpNqRpGvN9HG7a5R6V0sul3YDjRBFiTSJ5U
87wncw9HcxnM/em3AHaqPeoGjLL5R95Sz1owAMh1TPxUHWfVlUfSqB5TCyd7dJ0S
O+F1EIjuVJrOcdd8P9gccBZLzJEkIGCdBe1ZAVWBapuj1wxAQxhPXZme/grtCiet
dzUbcHuZzkxThASpUDs0ftezwiamiW0W3xYKS+PjWC1sstlw7E2EIcsOTYyomLOA
LxcncWBzXYiApIwLuQtEI71We/5bATYbUJHdN1lo0Wc5tGlTFxgnKPRYME2WUit6
l2M6/3TfHPZOD7RxicU8NIeB1kBk5IefqiZ54SzH6BVuRV66gD56UmjxJP66K6vc
3OIgbXNeKwTsbMdd2Ho3fV9qEMfWdswH/YXev+WojMCGJLXQNzo9E6fO2bNH6FWA
5nHvK2/Ms2z6Q06Mbm+VSFnWSpcRf81vyqXFvD3ODX44hemA+tnEVB20T1/gEESe
Y8cuNsa0Jk6agmgQAA6Gpftne8R5gSO/gyQJrTJKBv+oTlR31P439/cd9nTB5pzT
aK0cD+JGCPoZZww4fuYwww5DwSRAq+/viU7Og71OF859E/BwOP6l5G2UDX7Qew9I
6Ekqjd9864mv0m9wIkDkLSM9gEU8E6qKMWQKyMrPzbJIQ1TJCpw=
=tnZJ
-----END PGP SIGNATURE-----

--kl7qpfexrmgtjonf--

