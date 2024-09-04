Return-Path: <linux-pm+bounces-13563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6087396BC80
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18186281D2A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1A1D88D9;
	Wed,  4 Sep 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkeHXF8L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35519185935;
	Wed,  4 Sep 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453379; cv=none; b=IiSFGQ8QhQXpQ+JqG9QvrIx2YPc+OBOgEa7+W1rSEyb/vYHGZyUXn8lnfMnRVjPgu36KkDTgeuoA+cYRWlrREGmHnBYQYyqmBACq5uxk9qJKrQ8kqlVkueKynj8BD7rLLg7aTD7l38oN41WNUILX6vi8aAIn5LpruYHpbWix96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453379; c=relaxed/simple;
	bh=JjA2/JsNXGExkeE2K/FQZhVSrIrSq/U99uy6B88D6YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEM1cTIx8ren6t7uKl7MWqFDUG939CUU2cB/toRwdKHD3K6GkAgjUAE+dMQ1OdZ26sxSJkvq7tANWcJgzm8OWV85K9P1z8FPRNHhmVJ4ihw7tEkpcPu3v8kQRQ5VUFqhQygY5Ru1wqlj/AH1/zbfSyHLKpGuntLnouTg8Z6g1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkeHXF8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FB1C4CEC6;
	Wed,  4 Sep 2024 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725453379;
	bh=JjA2/JsNXGExkeE2K/FQZhVSrIrSq/U99uy6B88D6YY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nkeHXF8L2lNOc60N7//9fxgBgJtS6EEGvC3WgGFxLVKe8op3GKltWb/m2W9tOXd7a
	 +Q2s36NAVfYyDq60G9yzMjvJYKlLjKsaT18cqDypW0w2NVeI4jZ9KiUIOtHC1TUrbz
	 5+5DuZF4MNuswDoLF2VEFGSdXi7tZZh/AnDGUr904xXwHyXMCbvl5YluCDin54f+hq
	 vltxV/WDrpSiGw/gMEw45UL0T/G8oCrHTemmq5EMLX9dQQv1Xwkt3YJCSP0eFtcTd+
	 6ZEksCjnTRSZrYjzYcFecdXWsipgn1mIe9w5i7iT1mABdY5UbR4bbBoSRPx1GaE840
	 x2YDJa2uHutiQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5f24d9df8so3692543eaf.2;
        Wed, 04 Sep 2024 05:36:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqQVDADduz2Oy7aThNKQjxuETEXPJmYU7ZXZrpwzsysJhys4NdI2bfinwESzHxbUaHFfQE/F8tCsw=@vger.kernel.org, AJvYcCX0gJcZnZ8DNTMPXbLnRFX06neRSL/3NgyeSwCSbVApOdKgxEvH35ck0WST803Kqwnqel7c8Iry3kRCWpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xzeWGmFbqyyXPN9wTT2F8ZEJ8g4kd05ogf8mzqNlUWlpeIRQ
	IiTJgs+JuylZjtEGkruEv6tczmmX5nNp9pkYrlhJ///BpGB8Y47LEvfAM00PwzdzMc0nvM5YROA
	uF7JfpzC0PODlQh4+qXOpHpPtsw8=
X-Google-Smtp-Source: AGHT+IEYd6wVrgfuqGaHEwztbvHD7RfPKDJ5M427MVlwc3gD1WA6CqJ4z9GYwZy84CTPZzdP0I3E7s7Uzt0me2R21cU=
X-Received: by 2002:a05:6870:3909:b0:278:2d12:9f13 with SMTP id
 586e51a60fabf-2782d12b186mr4130715fac.44.1725453378349; Wed, 04 Sep 2024
 05:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825110620.30109-1-av2082000@gmail.com> <dd30094d963ec559d444aee6d0c26a5cd4c1e432.camel@linux.intel.com>
In-Reply-To: <dd30094d963ec559d444aee6d0c26a5cd4c1e432.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 14:36:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iftq5S_=zcna1zwSSYk7d_4XWaAh1q9WVTy98gxDtR0A@mail.gmail.com>
Message-ID: <CAJZ5v0iftq5S_=zcna1zwSSYk7d_4XWaAh1q9WVTy98gxDtR0A@mail.gmail.com>
Subject: Re: [PATCH] pm-graph: Update directory handling and installation
 process in Makefile
To: todd.e.brandt@linux.intel.com, Amit Vadhavana <av2082000@gmail.com>
Cc: skhan@linuxfoundation.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:51=E2=80=AFPM Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
>
> On Sun, 2024-08-25 at 16:36 +0530, Amit Vadhavana wrote:
> > - Standardize directory variables to support more flexible
> > installations.
> > - Add copyright and licensing information to the Makefile.
> > - Introduce ".PHONY" declarations to ensure that specific targets are
> > always
> >   executed, regardless of the presence of files with matching names.
> > - Add a help target to provide usage instructions.
> >
> > Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> > ---
> >  tools/power/pm-graph/Makefile | 111 ++++++++++++++++++++++----------
> > --
> >  1 file changed, 73 insertions(+), 38 deletions(-)
> >
> > diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-
> > graph/Makefile
> > index b5310832c19c..aeddbaf2d4c4 100644
> > --- a/tools/power/pm-graph/Makefile
> > +++ b/tools/power/pm-graph/Makefile
> > @@ -1,51 +1,86 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -PREFIX         ?=3D /usr
> > -DESTDIR                ?=3D
> > +#
> > +# Copyright (c) 2013, Intel Corporation.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > modify it
> > +# under the terms and conditions of the GNU General Public License,
> > +# version 2, as published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope it will be useful, but
> > WITHOUT
> > +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> > or
> > +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for
> > +# more details.
> > +#
> > +# Authors:
> > +#       Todd Brandt <todd.e.brandt@linux.intel.com>
> > +
> > +# Prefix to the directories we're installing to
> > +DESTDIR ?=3D
> > +
> > +# Directory definitions. These are default and most probably
> > +# do not need to be changed. Please note that DESTDIR is
> > +# added in front of any of them
> > +
> > +BINDIR ?=3D      /usr/bin
> > +MANDIR ?=3D      /usr/share/man
> > +LIBDIR ?=3D      /usr/lib
> > +
> > +# Toolchain: what tools do we use, and what options do they need:
> > +INSTALL =3D /usr/bin/install
> > +INSTALL_DATA  =3D ${INSTALL} -m 644
> >
> >  all:
> >         @echo "Nothing to build"
> >
> >  install : uninstall
> > -       install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph
> > -       install sleepgraph.py $(DESTDIR)$(PREFIX)/lib/pm-graph
> > -       install bootgraph.py $(DESTDIR)$(PREFIX)/lib/pm-graph
> > -       install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/cgskip.txt $(DESTDIR)$(PREFIX)/lib/pm-
> > graph/config
> > -       install -m 644 config/freeze-callgraph.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/freeze.cfg $(DESTDIR)$(PREFIX)/lib/pm-
> > graph/config
> > -       install -m 644 config/freeze-dev.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/standby-callgraph.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/standby.cfg $(DESTDIR)$(PREFIX)/lib/pm-
> > graph/config
> > -       install -m 644 config/standby-dev.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/suspend-callgraph.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/suspend.cfg $(DESTDIR)$(PREFIX)/lib/pm-
> > graph/config
> > -       install -m 644 config/suspend-dev.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -       install -m 644 config/suspend-x2-proc.cfg
> > $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> > -
> > -       install -d  $(DESTDIR)$(PREFIX)/bin
> > -       ln -s ../lib/pm-graph/bootgraph.py
> > $(DESTDIR)$(PREFIX)/bin/bootgraph
> > -       ln -s ../lib/pm-graph/sleepgraph.py
> > $(DESTDIR)$(PREFIX)/bin/sleepgraph
> > -
> > -       install -d  $(DESTDIR)$(PREFIX)/share/man/man8
> > -       install bootgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
> > -       install sleepgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
> > +       $(INSTALL) -d  $(DESTDIR)$(LIBDIR)/pm-graph
> > +       $(INSTALL) sleepgraph.py $(DESTDIR)$(LIBDIR)/pm-graph
> > +       $(INSTALL) bootgraph.py $(DESTDIR)$(LIBDIR)/pm-graph
> > +       $(INSTALL) -d  $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +       $(INSTALL_DATA) config/cgskip.txt $(DESTDIR)$(LIBDIR)/pm-
> > graph/config
> > +       $(INSTALL_DATA) config/freeze-callgraph.cfg
> > $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +       $(INSTALL_DATA) config/freeze.cfg $(DESTDIR)$(LIBDIR)/pm-
> > graph/config
> > +       $(INSTALL_DATA) config/freeze-dev.cfg $(DESTDIR)$(LIBDIR)/pm-
> > graph/config
> > +       $(INSTALL_DATA) config/standby-callgraph.cfg
> > $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +       $(INSTALL_DATA) config/standby.cfg $(DESTDIR)$(LIBDIR)/pm-
> > graph/config
> > +       $(INSTALL_DATA) config/standby-dev.cfg
> > $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +       $(INSTALL_DATA) config/suspend-callgraph.cfg
> > $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +       $(INSTALL_DATA) config/suspend.cfg $(DESTDIR)$(LIBDIR)/pm-
> > graph/config
> > +       $(INSTALL_DATA) config/suspend-dev.cfg
> > $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +       $(INSTALL_DATA) config/suspend-x2-proc.cfg
> > $(DESTDIR)$(LIBDIR)/pm-graph/config
> > +
> > +       $(INSTALL) -d  $(DESTDIR)$(BINDIR)
> > +       ln -s ../lib/pm-graph/bootgraph.py
> > $(DESTDIR)$(BINDIR)/bootgraph
> > +       ln -s ../lib/pm-graph/sleepgraph.py
> > $(DESTDIR)$(BINDIR)/sleepgraph
> > +
> > +       $(INSTALL) -d  $(DESTDIR)$(MANDIR)/man8
> > +       $(INSTALL) bootgraph.8 $(DESTDIR)$(MANDIR)/man8
> > +       $(INSTALL) sleepgraph.8 $(DESTDIR)$(MANDIR)/man8
> >
> >  uninstall :
> > -       rm -f $(DESTDIR)$(PREFIX)/share/man/man8/bootgraph.8
> > -       rm -f $(DESTDIR)$(PREFIX)/share/man/man8/sleepgraph.8
> > +       rm -f $(DESTDIR)$(MANDIR)/man8/bootgraph.8
> > +       rm -f $(DESTDIR)$(MANDIR)/man8/sleepgraph.8
> >
> > -       rm -f $(DESTDIR)$(PREFIX)/bin/bootgraph
> > -       rm -f $(DESTDIR)$(PREFIX)/bin/sleepgraph
> > +       rm -f $(DESTDIR)$(BINDIR)/bootgraph
> > +       rm -f $(DESTDIR)$(BINDIR)/sleepgraph
> >
> > -       rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/config/*
> > -       if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/config ] ; then \
> > -               rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/config; \
> > +       rm -f $(DESTDIR)$(LIBDIR)/pm-graph/config/*
> > +       if [ -d $(DESTDIR)$(LIBDIR)/pm-graph/config ] ; then \
> > +               rmdir $(DESTDIR)$(LIBDIR)/pm-graph/config; \
> >         fi;
> > -       rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__/*
> > -       if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__ ] ; then
> > \
> > -               rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__; \
> > +       rm -f $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__/*
> > +       if [ -d $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__ ] ; then \
> > +               rmdir $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__; \
> >         fi;
> > -       rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/*
> > -       if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph ] ; then \
> > -               rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph; \
> > +       rm -f $(DESTDIR)$(LIBDIR)/pm-graph/*
> > +       if [ -d $(DESTDIR)$(LIBDIR)/pm-graph ] ; then \
> > +               rmdir $(DESTDIR)$(LIBDIR)/pm-graph; \
> >         fi;
> > +
> > +help:
> > +       @echo  'Building targets:'
> > +       @echo  '  all             - Nothing to build'
> > +       @echo  '  install         - Install the program and create
> > necessary directories'
> > +       @echo  '  uninstall       - Remove installed files and
> > directories'
> > +
> > +.PHONY: all install uninstall help
> This does look much nicer, and it's good to use the absolute path of
> install in case the system doesn't have the PATH setup. Thank you for
> cleaning this up! (re-send with Acked-by)
>
> Acked-by: Todd Brandt <todd.e.brandt@linux.intel.com>

Applied as 6.12 material, thanks!

