Return-Path: <linux-pm+bounces-10237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6791891CCAC
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC7928359B
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB654F602;
	Sat, 29 Jun 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz8v3ipt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595371D52D;
	Sat, 29 Jun 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719663627; cv=none; b=tKhhWaihbXQF3ZNL719akFlgPI1xMkqXJkG8IoJtkV6u2Q6B8kYyinZyWKm/O/rO1DdUDJMGTn+9Q3ie5vep1k1lcblFoXspsIbJ/Kp6r452X/hRq0V3swdb+Q3S6gKZaJ945SNYpgZI95Uf6fECoGRlA5MsA8VmoqFPumipeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719663627; c=relaxed/simple;
	bh=Zt95ysWonWB222QIcNggbw5J7dgab+eiQ5Il5BPRrxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9kYDumKCUU5dF3ayMpTapzMEuvYvY5qHsGg62b4FNRZKKHu+/kH50q4adIPhSbcG95iE9B4aBfHtksmsyZgtKpZ3SE7UgNHhDd5TLpyIiamUJdufDt1NekL3mDtrkg1Ev3CmO9I4V+1JULKYNHM79iGh2Htl2/SlKcDXSyh1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz8v3ipt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so948606a12.3;
        Sat, 29 Jun 2024 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719663623; x=1720268423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07fSqL5YF7ajSMIBHHKbI5Tv87KUL1yMlVbcsEO3BYg=;
        b=Fz8v3ipt1IJmZu5K+Vjf6VmBwLKz4YwdpivdOCdeYgLdbiUc5Mg0/oJQkjplrmGYHZ
         Z92M6+0bV1GsFQwd+aieECyA8oYV9aHZ4FQrBWaYxmP74Y37HaMjM61xYxkmYLyputQb
         sy59ocPOnewWV5GiZzqicrbluFrjYwAw692B7ZzT+62pGXGL8IxDYYUXj244r4MO9HNJ
         arvlf/Hws805kS6bUZnl4Bo4iuifeGxdaKHEoE/7oTRFvpq8eXbUsLkN0b6wIs/ayKqH
         8mcWa+fiir7c5sohchhDrU5lnmLTdRDQggTBw3nA+Bi7n+4MAgfRb7BO9k11ju9bfHTc
         OWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719663623; x=1720268423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07fSqL5YF7ajSMIBHHKbI5Tv87KUL1yMlVbcsEO3BYg=;
        b=rmIT6J64mzAmildimhHv6JCRWygS7+ZrnCXXgkIUv6Rqu1yyKZ3z/TUgwmvH9WzJMA
         V00nC76sM2tJyT6aPPGhCwy2JyMj5q6v6G0KdOHktQC1UGMLR7V2qwHUVwHm+bGViqOl
         hUfhGnJHowL4cAKwkaq5q1ODsD99TZTgN8yiCxXclduiNVODAeemsGVUtAB7n9Lzxhox
         O46I/uo+YeEU0UfvhGcklco81XHJXh8Z341zveKu1EhxTrT2k9hf/eVSE+paPs/a8EsQ
         18ySgyaaZivnAloSGxflz4AmjeXBcN0ZF3ww8DtM8NVbgz2yq+A6cpcM4nteXlcY5Prr
         83Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWge5NNwmNfbXpgMcBX+m901ELX9W6k6WTQjtw8w3TOKJQ0JVkMWVlBA6FDSkruKf2KHanOu+DLX7m3jk292Yy9T6RS+O4HBvx+rcmz3ZIZyWH5rh2MhS8l+8PPzHUHsCRFRgd532I=
X-Gm-Message-State: AOJu0YwuSFzootswiU6nCKTWGlZcNddXUCcsS5KP+f/X8ulSOwnbbPCk
	RsQFppGDkU98JBAWKkbLPvxqE8El7TQAPDesWlL6sZbmoQB1j41NxQsD7pPOP7v9Zds7POuh34a
	LHqKWJ6/LBTUfSqHQOsxGcdh0Mow=
X-Google-Smtp-Source: AGHT+IGtFjcHlGtifyhNolw/jEepuzMeMplZd3U4ZvMARe2e+6A1TlJEHr1lREcHPfv0ZZM+WDU7pUxdbuetnXhjbK4=
X-Received: by 2002:a05:6402:50cc:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-5879ede2742mr870998a12.5.1719663623309; Sat, 29 Jun 2024
 05:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-fix-lib-install-v1-1-bcbd03b78d87@gmail.com> <cfee36c5-c5d9-49db-bc94-c6e5fdb77840@linuxfoundation.org>
In-Reply-To: <cfee36c5-c5d9-49db-bc94-c6e5fdb77840@linuxfoundation.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sat, 29 Jun 2024 14:20:11 +0200
Message-ID: <CALsPMBNd67iYF_tFQbBH=e3D0Mjn+KOv6sA1x6Hr940_C+sjMQ@mail.gmail.com>
Subject: Re: [PATCH] cpupower: fix lib default installation path
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:44=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> On 6/23/24 07:10, Roman Storozhenko wrote:
> > Invocation the tool built with the default settings fails:
> > $ cpupower
> > cpupower: error while loading shared libraries: libcpupower.so.1: canno=
t
> > open shared object file: No such file or directory> The issue is that M=
akefile puts the library to "/usr/lib64" dir for a 64
> > bit machine. This is wrong. According to the "File hierarchy standard
> > specification:
> > https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> > https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf
> >
> > "/usr/lib<qual>" dirs are intended for alternative-format libraries
> > (e.g., "/usr/lib32" for 32-bit libraries on a 64-bit machine (optional)=
).
> >
> > The utility is built for the current machine and doesn't change bit
> > depth.
> > Fix the issue by changing library destination dir to "/usr/lib".
> >
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> >   tools/power/cpupower/Makefile | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makef=
ile
> > index cd0225a312b4..6c02f401069e 100644
> > --- a/tools/power/cpupower/Makefile
> > +++ b/tools/power/cpupower/Makefile
> > @@ -67,6 +67,7 @@ LANGUAGES =3D                         de fr it cs pt =
ka
> >   bindir ?=3D   /usr/bin
> >   sbindir ?=3D  /usr/sbin
> >   mandir ?=3D   /usr/man
> > +libdir ?=3D    /usr/lib
> >   includedir ?=3D       /usr/include
> >   localedir ?=3D        /usr/share/locale
> >   docdir ?=3D       /usr/share/doc/packages/cpupower
> > @@ -94,15 +95,6 @@ RANLIB =3D $(CROSS)ranlib
> >   HOSTCC =3D gcc
> >   MKDIR =3D mkdir
>
> These are set when make invoked from the kernel main
> Makefile - see "make tools" option in main Makefile
> >
> > -# 64bit library detection
> > -include ../../scripts/Makefile.arch
>
> This does the 64-librray detection based on arch.
> > -
> > -ifeq ($(IS_64_BIT), 1)
> > -libdir ?=3D    /usr/lib64
> > -else
> > -libdir ?=3D    /usr/lib
> > -endif
> > -
> >   # Now we set up the build system
> >   #
> >
> >
> > ---
> > base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> > change-id: 20240623-fix-lib-install-3b7dccdbdf45
> >
> > Best regards,
>
> What happens if you cross-compile with this patch? Take a look at this
> commit that fixed cross-compile:
>
> a73f6e2fbe8077811ea9546e0d44a7533111f0ba
>
> This makefile has to be in sync with the rest of the tools - see
> "make tools" in the kernel main Makefile.

I have done this using "make tools" method mainline kernel and the
patch for x86_64 and risc-v:
1) x86_64
$make cpupower
$ sudo make cpupower_install -j8
$ cpupower
cpupower: error while loading shared libraries: libcpupower.so.1:
cannot open shared object file: No such file or directory

Works with my patch, and doesn't work with the mainline.

2) RISC-V:
$ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- cpupower -j8
$ sudo make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- cpupower_instal=
l -j8
$ cpupower
cpupower: error while loading shared libraries: libcpupower.so.1:
cannot open shared object file: No such file or directory

Works with my patch, and doesn't work with the mainline.

By the way - the cpupower makefile handles neither 'CROSS_COMPILE' nor
'ARCH' variables.
So the result is always the same - binary for x86_64 architecture.

Let me try to rephrase what I wrote in the initial patch message:
The current lib target dir is based on architecture bit width, and
this  is wrong.
The library should be put in the '/usr/lib' dir regardless of whether
it is x86_32 or x86_64 .
This is the case for all the distros that comply with the 'File
Hierarchy Standard 3.0"
by Linux Foundation. Most of the distros comply with it.
You can check this by examining the "/usr/lb64" dir on debian-based
distros and find
that it contains only "/usr/lib64/ld-linux-x86-64.so.2"
And examine that "/usr/lib" contains both 32 and 64 bit code:
find /usr/lib -name "*.so*" -type f | xargs file | grep 32-bit
find /usr/lib -name "*.so*" -type f | xargs file | grep 64-bit

>
> thanks,
> -- Shuah
>
>


--=20
Kind regards,
Roman Storozhenko

