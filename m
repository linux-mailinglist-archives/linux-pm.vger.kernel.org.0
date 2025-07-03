Return-Path: <linux-pm+bounces-30047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BDAF76FF
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC14189A962
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22272E7657;
	Thu,  3 Jul 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff4pTne6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F352E7649;
	Thu,  3 Jul 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552068; cv=none; b=ZAWex2No0uJILOmASzFyE2x+FIpqhPPFj3p9GGdn0UkL2ig4RavtYrDjuNQihPOjO7LJHzL38ul7LFc8+v+XIdVFtEjPpE04zDoSf0PbN2h3aZh9a7P8FrTcldHgZCSp9JCtatXgJ5ssTR0mVJFgDROsCP8GSK4kA5bI0b3I4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552068; c=relaxed/simple;
	bh=yz27+gZ90qqjcbOWbMafRdQhym9Xz9uDhF1OjBNbzI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0SPV3Z2ZVDn43Cn5fPy2WIgBlURZ2A1K/GTT/vf9RxE0nc4NEf1dRbmA5A/UfM0hHQe5KrUS4qRXQ1GLPmjcusVit5Aj1kE4+h0P2im1GFK5c4dEIdUL6mC+FsC8HrJOn4IjdgPwv5zgZeL8SCJi3Jiw9dyOdNVqoDRBJrMrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff4pTne6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d7b50815so44538125e9.2;
        Thu, 03 Jul 2025 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552065; x=1752156865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0V7NkDIEc+/eOQ6W4dZ09XTpw5W6+N3Lcj8PdPlLeM=;
        b=ff4pTne6690fSio64bKrv5BamBq8tnK7TJrA8DuUL81tMpBYMLe7MU+XgV2gl0X+3U
         0UeqkD+5e5waTR0IkrQahKVrj/pM8Yepya4pqLyCVGsU1X22/yVAh3pbTtbgT7z2RzW9
         FzOYEiI+fqEDKenQKtC0kB+i921EIQjPgV8arqH+r9+6FgHLzlze8ljLUZ7ZdMMPR61M
         J0cJ9mIb6vO825G/KNBCLYLf75RHvUbq3gsSMtJOY2guHLdPojX+tie5ZFsStdcJkJiU
         35gMduD7s6Pw55AJ2y1ykUeS5khX8bkohf1y4YPq/hc45TE4TSHi0bbg987YCsmcY1ov
         +EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552065; x=1752156865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0V7NkDIEc+/eOQ6W4dZ09XTpw5W6+N3Lcj8PdPlLeM=;
        b=ju/WIVwQqzK5Igc2flFGCB78Wz76QmgSQCfHTjecHAGKAkyIPy/GmTkplBBjwNO9u0
         EKHcisEEPIBTpnDadARUc1RZKEROp8UNyFGY6Img9CSKlFPvjQZnIbX2kp5HkG6Hjl5f
         4tiAsKP9igTc3y1p9DlNY1ZrPVF0dwJh7V6EaPK+AispQXVdKdTcMyxmgRVfJM2nQqRS
         t16Vz343aEzIFTm7VHOfP2XwwxZ2FTmW5qIhcr7FTAsvxdmN/McO353OuhamuH3rnVUx
         +RpixZGy45/FpgbwS6dMK7ieoCJklALEGYBBXUM1XX/JVA2s78hL+5oiTiYGsns/0jNm
         ecvA==
X-Forwarded-Encrypted: i=1; AJvYcCUYxodfN19rYJbUGqB5bKNWzkW5iqW6FKuQ4/7R2So1zJgMPB1wXYgKTkpqYXW50ft0xP4Bu9Av3LsKlm8=@vger.kernel.org, AJvYcCWk5CF/v1rY5tmDxjFLq6mgHfzkg6bRoZUdw6D6uC38FuNaOrfN7wg5B6fqXgCyHHgDdYM1McHF1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OXXw6d5i1Zh4HBqUzq/aB9yK/eetH/irZWR2z62XG/q4foim
	2il65Dl2oQUx3DDb+5+gcSVzvTMvLy6XgYGHfLM/1MwmLSVKUN3e/kDCzoagrQ==
X-Gm-Gg: ASbGncv19riRmQRTBBx4SS85BeXVf86Cp9g9b93dOFgfb17jrnWdJcnrcRz85fBeqfC
	zOjlvkRt1O0tearP/+9Iz4RpCgPGKDbjSzJhe3VFzsFHZpo0ADr0UNksTYgxFglT9G7+m7UIOYf
	ucjsRHlTcPrZ4GRAWn4M73lK/C+FNpWEGh5YYoZ5hrddK+khlvNikZ5Gvh4Eg/uipaYfd+5rU01
	/KSZkPH2hm0euOwzhkW7JQ6H1qlcENypMQtAf93ar8bEhmdULVcVuA5QUlUGglygwyb/RIsQ8z4
	ryDxogR7YhTxClWpe2yfqz9G8XTwJFmjtTxqhDqkp9aM0IbJ8O1zqUswaXExPUDUFgmFcPsGsLE
	6H7EUCOaJLOKK3sEcopMth9xTru/QVSfHOH6JfdVV9gdLWFfAHdRgsT5F+wg=
X-Google-Smtp-Source: AGHT+IHTxdrOhvQwD9mAm+OYtxuX4BGPWcT02Tytvb0U2VzogK8kd5aZKkz6G1E20h9EBpsbmYKSvQ==
X-Received: by 2002:a05:600c:4f87:b0:450:d012:df85 with SMTP id 5b1f17b1804b1-454a9c9fc7cmr41407445e9.18.1751552064802;
        Thu, 03 Jul 2025 07:14:24 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bac51bsm28466365e9.39.2025.07.03.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:14:23 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:14:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: Forcing devices into idle
Message-ID: <lhqjjycgtiap37ckghkyovdyosxxo5ugdep6t7jjtxidk3rws4@re2x2rom7chc>
References: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
 <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com>
 <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>
 <hjkm55hus3ctueydf7ebfb25hbdw6w3spdzx7maauzlzmnakas@noqexx2pxxtj>
 <e635l6gfpg7amck2hnu4l47tnc54lr6e26v7y3ohaywil6pjwr@4trxzfdigo62>
 <CAJZ5v0gsLCpGnA5fNSSVLOoPL6Qinw=o_fBGG-0iFKeWyQtFZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fidxxisyxhzeepwx"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gsLCpGnA5fNSSVLOoPL6Qinw=o_fBGG-0iFKeWyQtFZQ@mail.gmail.com>


--fidxxisyxhzeepwx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Forcing devices into idle
MIME-Version: 1.0

On Thu, Jul 03, 2025 at 03:46:03PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 3, 2025 at 3:32=E2=80=AFPM Thierry Reding <thierry.reding@gma=
il.com> wrote:
> >
> > On Thu, Jul 03, 2025 at 02:06:00PM +0200, Thierry Reding wrote:
> > > On Thu, Jul 03, 2025 at 01:12:15PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Jul 3, 2025 at 12:33=E2=80=AFPM Oliver Neukum <oneukum@suse=
=2Ecom> wrote:
> > > > >
> > > > > On 03.07.25 12:08, Thierry Reding wrote:
> > > > >
> > > > > > Any thoughts on how to solve this? Is the pm_runtime_{put,get}_=
sync()
> > > > > > method acceptable? If not, are there other alternatives to achi=
eve the
> > > > > > same thing that I'm not aware of? Would it be useful to add a n=
ew set of
> > > > > > APIs to force devices into an idle state (which could be semant=
ically
> > > > > > different from runtime suspend)? Or is this all too specific fo=
r any
> > > > > > kind of generic API?
> > > > >
> > > > > Basically what you need is what happens when the system prepares =
to
> > > > > do a snapshot for S4. However, if you just perform FREEZE and the=
n THAW,
> > > > > devices will assume that user space has been frozen. You need a w=
ay
> > > > > to substitute for that assumption.
> > > >
> > > > Well, you just need to freeze user space beforehand.
> > >
> > > Freezing userspace seems a bit heavy-handed. There's only a very few
> > > devices that need to be put into reset (such as the GPU), so most of
> > > userspace should be fine to continue to run. For the GPU the idea is
> > > to block all incoming requests while the device is forced into idle,
> > > and then to resume processing these requests after the VPR resize.
> > >
> > > But maybe freezing userspace isn't the heavy operation that I think it
> > > is. Ideally we do not want to suspend things for too long to avoid
> > > stuttering on the userspace side.
> > >
> > > Also, I think we'd want the freezing to be triggered by the VPR driver
> > > because userspace ideally doesn't know when the resizing happens. The
> > > DMA BUF heap API that I'm trying to use is too simple for that, and
> > > only the VPR driver knows when a resize needs to happen.
> > >
> > > Is it possible to trigger the freeze from a kernel driver? Or localize
> > > the freezing of userspace to only the processes that are accessing a
> > > given device?
> > >
> > > Other than that, freeze() and thaw() seem like the right callbacks for
> > > this.
> >
> > I've prototyped this using the sledgehammer freeze_processes() and
> > thaw_processes() functions and the entire process seems to be pretty
> > quick. I can get through most of it in ~30 ms. This is on a mostly
> > idle test system, so I expect this to go up significantly if there
> > is a high load.
> >
> > On the other hand, this will drastically simplify the GPU driver
> > implementation, because by the time ->freeze() is called, all userspace
> > will be frozen, so there's no need to do any blocking on the kernel
> > side.
> >
> > What I have now is roughly this:
> >
> >         freeze_processes();
> >
> >         for each VPR device dev:
> >                 pm_generic_freeze(dev);
> >
> >         resize_vpr();
> >
> >         for each VPR device dev:
> >                 pm_generic_thaw(dev);
> >
> >         thaw_processes()
> >
> > I still can't shake the feeling that this is sketchy, but it seems to
> > work. Is there anything blatantly wrong about this?
>=20
> There are a few things to take into consideration.
>=20
> First, there are 4 tiers of "freeze" callbacks (->prepare, ->freeze,
> ->freeze_late, ->freeze_noirq), and analogously for "thaw" callbacks,
> but you only use one of them.  This may be fine in a particular case,
> but you need to ensure that the other tiers are not needed and, in
> particular, the _noirq ones need not be involved.  Also ensure that
> they don't assume that PM notifiers have run (or that they will run on
> the resume side).

I think that's something we can accomodate in this case. The primary
device that needs this in the integrated GPU on Tegra, so it's very a
narrow set.

> Second, if there are dependencies between the devices being frozen and
> other devices, they will have to be taken into account.

Fortunately, as far as I know the only dependency, if any, would be via
the userspace. There's no relationship between the devices from a PM
point of view.

There might be a video decoder that decodes images into the VPR and the
GPU would then read data out of the VPR and composite onto the screen.
So as long as userspace is frozen, there should be no issue.

> Also note that kernel threads are generally not affected by
> freeze_processes(), but I guess this is not a problem in your use
> case.

I had read through some of the documentation around this, and yes, the
kernel threads shouldn't be an issue.

In any case I'll make sure to add comments where necessary to point out
the peculiarities of the whole thing.

So this sounds like a workable solution. If for whatever reason freezing
the entire userspace doesn't work out, would it still be possible to
"abuse" the freeze() and thaw() callbacks like this? The way I imagine
this would be for freeze() to include code that effectively suspends all
userspace submissions to the GPU (i.e. effectively suspend all GPU
related operations).

Thierry

--fidxxisyxhzeepwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhmkDgACgkQ3SOs138+
s6GXohAAijEUZWwb7m4k0LLH2s01oyPFu0nC9B7LXWNKpAxcChnSkul3zLAU5SjK
UChG1XJURudu5GwbW+6sVoZVsvmyF7tfrhizcrUi0jZMvFP9TfzgxPRHDRwaGQky
p6OmEDPSl8q9JEMzqSfJdFmAdRB2f7Y1+zstAp9nSb/kxyPYw0/5ihCfNZmiLd6/
/D/9Bz3D1EzqZeXVq7JTcbmnWGG/WdqwsDJXSzPEbr9ecQPDZ2CoWyBznDDIwisV
plYOZmtBlwp9p3Y19+c7QtkmNVurXu3gglFpKoIUz2SLBG5AP9WtAhrjnbEagqrW
h36uLAsEa3uuF6q6xw3Qmwbd3gWWfCMF5/A/w/6S9skPLda4fANoYykQP1IBc47r
cPPoPNotQLPLerMaHZr0M251yUK9ZRERhfEilK7ZxHHrDxaZhjfup8edIm2dUy6D
trPYt7lNpa+tMaWYHpmKROoUIMIWlRAbzjRzXeVv6jm/ThPfuHnLyv+QiH7qCL4w
+Yju0ZDl/t0gdi37qVpKNIm4RJmr3n6OEBhqEtonAIYdd76Eaoa0tuUUPg9EwrpF
UFOrEDX4OCg1UFbyfjMruL295rHRbtL7cxEYRv3iu3D7NZKRe+fnGQfW3mvAPIoN
isqQFsM9i7tls2P6TGT2uq5tCzBkbTL+FtuPenH6AfIjxLZvVII=
=dpfT
-----END PGP SIGNATURE-----

--fidxxisyxhzeepwx--

