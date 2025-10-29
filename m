Return-Path: <linux-pm+bounces-37072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F81C1D3DB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 21:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577171892BD8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 20:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A38357A5E;
	Wed, 29 Oct 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO+G0kcb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3473559FB
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770423; cv=none; b=D1CoVMnBVCJqkfC543dsHqWjOr90bj8m0g5mbZzgqgv5F2i5bEUJVdu32/Quwx5EiU2fRRSTsPmf+WqaEv3sA2rn2xGJWnRnhjtf3G4VKMQrDez61r0gVrC4vZV4OXsr0IW38zNLR6INs4vdyz9+jdtjgscteri+mJHN3nYFKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770423; c=relaxed/simple;
	bh=ns4b6aM37ZgOxDoSOaW+r8bQOQRHH+MqybA/pg189gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEQYlbOH7SvV8OxZHqrpIgrS+QUs7wie88FaRRrK+Vk3RHP7wfeB5QUPBVWGdCAFpZCjrPXuPRL3Li2f9dJvh/FAMrfiXrpUrY7CFsVIOR8x8hFafUqUDgQn+6YeSF/EtjrAFAEDAF/XSDiHlvN3rSgDowAeWPNxV73A0YMkZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO+G0kcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B10C116B1
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761770423;
	bh=ns4b6aM37ZgOxDoSOaW+r8bQOQRHH+MqybA/pg189gM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nO+G0kcbM7pNCV0+74zGKKhYXh12qoB3q0zZmRBWcYbpkgzrJfDHLPwweS33YDqtH
	 4fLk99/ctjqqTJFXzdR7IR24tezAvcNATOb9PV3teZreG47IbvhRaWfoQDb6+NMWpx
	 Rl7todaGEC1nCqhTTfkTN6JenHoNvynolojOHGLMoBgtA3031Kr6uG3J7EpQv6DnPb
	 5VS+dQtY6Q1ZY6bHCzvnCVblIZqSPtpoTFCg7U/wldYh0H0O8ZYn14VxGLsS6hhENW
	 FCB5FYBkJtUXPT78XUAn4s6kzVKmGxMiCbJiFNVtKh4lLgdEmlNkez3epdQigRZl6I
	 p1B6Ikr30M6PA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6567607bd65so82154eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 13:40:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXh+gRkHs9rWoPlgd2LAoEAVdbjBaITl36OPjviI5V1uV16PvquBBTeiNsHThEtQYCQCiFumB2BGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmRTKGMjwRBnrjZIS/ULyj5LvMVP0iWzcNNGKxkogQhWQMTvN
	AXj/jVDSQDf0q5LglYHCWuymfg9ihzx1QfZrtgAESVndv/53r9xuHOKhoPxj7XAgQ4X4HWHIzAc
	UD5OUA5Zn8Ylr25PHTnf3fFUU9F0Suyc=
X-Google-Smtp-Source: AGHT+IGkw0errFUiWgHSegfRuc0UV+uiohV9K9kD6XTBbEYcHl6IYdAr8WV+LfSRejWvHXoyL9ZP+xb3OppXM4LdNZ0=
X-Received: by 2002:a05:6820:161e:b0:653:827d:1abb with SMTP id
 006d021491bc7-65677e52479mr1754431eaf.2.1761770422550; Wed, 29 Oct 2025
 13:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029134737.42229-1-swarajgaikwad1925@gmail.com>
 <aQHyhU78m-9RPQ8q@archie.me> <81b03d82-6dc7-4af1-bca1-3632e1a0b4c0@infradead.org>
In-Reply-To: <81b03d82-6dc7-4af1-bca1-3632e1a0b4c0@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 21:40:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g_v+21S=vq-B9H-vvyYRJjBUtc8fW2MSoP1JvQd9xsWw@mail.gmail.com>
X-Gm-Features: AWmQ_bnS4mODpTkuRjShVDMELlV7btLcndAf7AWIMblYKgESQ_nlIvEOpV4S5lI
Message-ID: <CAJZ5v0g_v+21S=vq-B9H-vvyYRJjBUtc8fW2MSoP1JvQd9xsWw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: pm: fix duplicate hyperlink target errors
To: Randy Dunlap <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 6:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/29/25 3:55 AM, Bagas Sanjaya wrote:
> > On Wed, Oct 29, 2025 at 01:47:37PM +0000, Swaraj Gaikwad wrote:
> >> Fix reST warnings in
> >> Documentation/admin-guide/pm/intel_pstate.rst caused by missing explic=
it
> >> hyperlink labels for section titles.
> >>
> >> Before this change, the following errors were printed during
> >> `make htmldocs`:
> >>
> >>   Documentation/admin-guide/pm/intel_pstate.rst:401:
> >>     ERROR: Indirect hyperlink target (id=3D"id6") refers to target
> >>     "passive mode", which is a duplicate, and cannot be used as a
> >>     unique reference.
> >>   Documentation/admin-guide/pm/intel_pstate.rst:517:
> >>     ERROR: Indirect hyperlink target (id=3D"id9") refers to target
> >>     "active mode", which is a duplicate, and cannot be used as a
> >>     unique reference.
> >>   Documentation/admin-guide/pm/intel_pstate.rst:611:
> >>     ERROR: Indirect hyperlink target (id=3D"id15") refers to target
> >>     "global attributes", which is a duplicate, and cannot be used as
> >>     a unique reference.
> >>   ERROR: Duplicate target name, cannot be used as a unique reference:
> >>   "passive mode", "active mode", "global attributes".
> >
> > Hmm... I don't see these warnings when I build htmldocs by:
> >
> >   $ make SPHINXOPTS=3D'-j 1' htmldocs
> >
> > My environment uses docutils 0.21.2 and Sphinx 8.2.3, though. What are =
yours?
>
>
> I do see the warnings and this patch fixes them in my testing.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>
> docutils-3.13 (Docutils 0.22.2, Python 3.13.9, on linux)
> sphinx-build 8.2.3
>
> >> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documenta=
tion/admin-guide/pm/intel_pstate.rst
> >> index 26e702c7016e..9cdd9dad6516 100644
> >> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> >> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> >> @@ -62,6 +62,8 @@ a certain performance scaling algorithm.  Which of t=
hem will be in effect
> >>  depends on what kernel command line options are used and on the capab=
ilities of
> >>  the processor.
> >>
> >> +.. _Active Mode:
> >> +
> >>  Active Mode
> >>  -----------
> >>
> >> @@ -94,6 +96,8 @@ Which of the P-state selection algorithms is used by=
 default depends on the
> >>  Namely, if that option is set, the ``performance`` algorithm will be =
used by
> >>  default, and the other one will be used by default if it is not set.
> >>
> >> +.. _Active Mode With HWP:
> >> +
> >>  Active Mode With HWP
> >>  ~~~~~~~~~~~~~~~~~~~~
> >>
> >> @@ -192,6 +196,8 @@ This is the default P-state selection algorithm if=
 the
> >>  :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configurati=
on option
> >>  is not set.
> >>
> >> +.. _Passive Mode:
> >> +
> >>  Passive Mode
> >>  ------------
> >>
> >> @@ -432,6 +438,8 @@ the ``energy_model`` directory in ``debugfs`` (typ=
lically mounted on
> >>  User Space Interface in ``sysfs``
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> +.. _Global Attributes:
> >> +
> >>  Global Attributes
> >>  -----------------
> >>
> >>
> >
> > The diff LGTM, nevertheless.
> >
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied as 6.19 material, thanks!

