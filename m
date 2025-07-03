Return-Path: <linux-pm+bounces-30038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A2AF733C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE3562BCD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F87A2E4275;
	Thu,  3 Jul 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJi0k6Ao"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD702E2EF3;
	Thu,  3 Jul 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544367; cv=none; b=NOQQmUmyNaZjl5J/V5MJ/g5DFu3dsa+IdWsAkVHioW6ED+EtOeD3tEpbFFPTwBlqTn7Guhn69sP0/Apx8K+Wu34K00l4gNdDsrl00Jz2Yz9GDaHQKVVBkN0o32P0rhT7HBzpDX0bYNRUuOR/nGPKATZ8ZpEmbuqdKAM3BfJ9Dng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544367; c=relaxed/simple;
	bh=6WaqC49F51IOyelBTQXhzsOxCLazmLYXNHOkK7Ky7AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqiGBbchAAMJ/iIwTLSsd79SzsHxfG1nHpCNpIVpKHal/Oaw4KmpSOljczM4fet3xcoMdgQHNl5vfWPj81Qv7Oh+otnZtsoswxw/bVo+sgindZ7tMp0V91pswLADZemOoCXINs0W7+RKB+G2QAMz6kg1s8/ZWtc2auaBLyJD9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJi0k6Ao; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so47834015e9.2;
        Thu, 03 Jul 2025 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751544364; x=1752149164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WaqC49F51IOyelBTQXhzsOxCLazmLYXNHOkK7Ky7AY=;
        b=fJi0k6Aohm+HIbi874SVadJie5gEqS1q2gv9/sd2xIFww6V/bfcWnBLSbNkjWwgfXo
         9MuAOOA7RwckTsE4qC9Ml8BdkZs0hwI7AkK0Z2sWoi7N4XwrGcDNLjEGLbOm/AvvxuB0
         8/tZNg7p3boB/pSJtmCX9aIYiia6By9JUJiJcvBg5Qw/YBxvuE8YMlYR3vEjn0kob/BV
         tKfD1JHBWpXAHnWvKtivGSLfunl9YRt3Musqv+wrZB94bV8Q1FwWV4Pt5IxXH7Wv9+Ej
         kpRNmPFJa4by6ZhNCZ+BwCaEru/giuuYaBVtD6ma/xZnV1I+zgyZWiQsirQpFJSxX3Z5
         QVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751544364; x=1752149164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WaqC49F51IOyelBTQXhzsOxCLazmLYXNHOkK7Ky7AY=;
        b=gAVnf1lm2ezzIa4vwAdB4mgVDikwYlfkDtCHDvO8Wo6kzvC9xW+08N8odIDY+cLiCq
         ofvk96EXVTDkSbQRJhLb96jaJwPsrnaA4jCyejcWyv59RjK4cowjadluGbHIF8tfTzCM
         XJcYSsgsXSDixBJr69Z/XC2XuIdMlYHlpme0VtDBXoraz9jTUJg5A+TDG1w+a9cG6BtV
         BD277Ko8gX3Psss3Zn3sWzqDbIW5Bh53ySR80RMlNgyNgmcrppIkM+3G1Krch+ckjtUt
         5Lbvhpsg2sr9+12kS1qkevIHFL2PGBrRfGfzue0Qk+4JCVRjTLoMEBNFA54jljqH4krS
         w0ig==
X-Forwarded-Encrypted: i=1; AJvYcCUZcCgiigQq3LbBeYqUCh6b46pn22+K9N+q6DuRUbCBPBw/4nUyw5MW1ARFMsVNVPcjUJRxmSRbAQ==@vger.kernel.org, AJvYcCWnMHMwz7ruayGgOvZrzS5rPgk+F9i4yxqxGdXAxYuGCtu5dZnMRhHSIiAniQi5kGL35OcUPsAhF/6/634=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYckHWFpTnKieEG4HGuUr/dLcZBNmFhgG4bBSBxzXIrXFM7o+5
	dD58gZ66FcgEFLud3E/dk4gFQ97ek70Ag0OkmROjAYoDwBIdgGjJMAes
X-Gm-Gg: ASbGncsOFTGfz2VMlUiTSkTpeVnql/DVI5E5q8Stos+lYcxzutCrzbgzJjbQwgKhxag
	lTgndiEfUHbHdqroMg7nqlI3+43mTf2BsGFn8NPpYWh65Y8nZw1pZyGD4OEDGadwAmSReD3UlHx
	sFbW858/4yFGph5gPb4cbU4kpjw10TehSe2dFlCDIUyoSERiUwtl9D98Wpx1//wVNXrPwrY78aQ
	vcwY1SrV76La75e2hQlIZADGAVfOs6WFRoTH6376aCJxQkeC6dVgoPmx6GdU5rgVEdolqdYQdLu
	PRPZpI3vlUsxFRxOJt53NnEqks9OvS1Yz9nbMcTz2L1EwR5hNfna20yZxRbJTgpooksLg1gmqC4
	Z/k8stsfbloBfLj6O11YsTsg/XLopJZ6q9Bkv3j50RLr4I5fX
X-Google-Smtp-Source: AGHT+IGrBlPl4cRrJmgRU179mhSMUlfqSodkLrix516bOaydIFPSh5W7HlkBnUI4slm7YJjOXnlyYA==
X-Received: by 2002:a05:600c:c0cc:b0:453:8a62:df34 with SMTP id 5b1f17b1804b1-454a3708ec2mr43553745e9.21.1751544363158;
        Thu, 03 Jul 2025 05:06:03 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e6214fsm18693068f8f.98.2025.07.03.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:06:01 -0700 (PDT)
Date: Thu, 3 Jul 2025 14:06:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: Forcing devices into idle
Message-ID: <hjkm55hus3ctueydf7ebfb25hbdw6w3spdzx7maauzlzmnakas@noqexx2pxxtj>
References: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
 <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com>
 <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3trq7oliwem474c"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>


--c3trq7oliwem474c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Forcing devices into idle
MIME-Version: 1.0

On Thu, Jul 03, 2025 at 01:12:15PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 3, 2025 at 12:33=E2=80=AFPM Oliver Neukum <oneukum@suse.com> =
wrote:
> >
> > On 03.07.25 12:08, Thierry Reding wrote:
> >
> > > Any thoughts on how to solve this? Is the pm_runtime_{put,get}_sync()
> > > method acceptable? If not, are there other alternatives to achieve the
> > > same thing that I'm not aware of? Would it be useful to add a new set=
 of
> > > APIs to force devices into an idle state (which could be semantically
> > > different from runtime suspend)? Or is this all too specific for any
> > > kind of generic API?
> >
> > Basically what you need is what happens when the system prepares to
> > do a snapshot for S4. However, if you just perform FREEZE and then THAW,
> > devices will assume that user space has been frozen. You need a way
> > to substitute for that assumption.
>=20
> Well, you just need to freeze user space beforehand.

Freezing userspace seems a bit heavy-handed. There's only a very few
devices that need to be put into reset (such as the GPU), so most of
userspace should be fine to continue to run. For the GPU the idea is
to block all incoming requests while the device is forced into idle,
and then to resume processing these requests after the VPR resize.

But maybe freezing userspace isn't the heavy operation that I think it
is. Ideally we do not want to suspend things for too long to avoid
stuttering on the userspace side.

Also, I think we'd want the freezing to be triggered by the VPR driver
because userspace ideally doesn't know when the resizing happens. The
DMA BUF heap API that I'm trying to use is too simple for that, and
only the VPR driver knows when a resize needs to happen.

Is it possible to trigger the freeze from a kernel driver? Or localize
the freezing of userspace to only the processes that are accessing a
given device?

Other than that, freeze() and thaw() seem like the right callbacks for
this.

Thierry

--c3trq7oliwem474c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhmciQACgkQ3SOs138+
s6FrWRAArTr2+v5/RiI52gbOtblSZZHd0u8bRWvZc9eKsca1KbnLFzZqLR3EtWTj
LR3Iulq6+bbV7R3mxRltaDyZMzW8PzHy0/TO4pRV0sX/N3DUGDx9HkXHyGxCmfl2
zqRoWKvHvyX27BNImb/pk5HwxD6FgDyc8uRb71jR1/Ur7Wrs5wh9w/RCPU1ffOvD
54n1HVluWCJN38tDM05fsTdmBErnMbN+TkDxXusbmtOdAZBWLtkHxSH/3b9k5O/y
yokK4UfzVDVR3S97p5Q+hMi93fHztgR7rtDQjvMjELghNxO5cKfUrYRuqUYQASAC
VnuccLKZd5g/h05WcJaCScnxxA6yndutfVIh/okQc/g0P5ZY9obdtZ4e089D0jql
om7njxOFxVC0Dmr4dIePDlN19oStPGf3m2C9ZhqNQLKksarWF4rG9uX+ZIalIUN3
PrN1bGSr//mBuL0vAyj1VkrtIajFp1HqMfb1l9VGxvA0XVGPxuwn4+8X/i1G99rX
AJt7FzFfHHricO2SdmbpTpQPDOoTJa8YEKcaj6cuzFr7eb4yVrob7NqtIqhZ92/z
dk50CNH35WHeUToip/P8Fg499IcjMJEzHgqnTISOP89p5+gdKYLVhEpJX0eo0TkX
1eZ1EPawFYKUyscLynI6MhmoXcGLwo7/06bQ0KkGU9sVKal4Xx4=
=EP0t
-----END PGP SIGNATURE-----

--c3trq7oliwem474c--

