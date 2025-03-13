Return-Path: <linux-pm+bounces-23990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F58A5FDBA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D14B42169E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7C15383A;
	Thu, 13 Mar 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXIz1epJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4F78F4C;
	Thu, 13 Mar 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886881; cv=none; b=Ylafu0dujC4aOgdA1pLGH2Ursp7jZ2nGP8wqN2uaJmNSAYFYG0dSJdpxSF1txMExSUEiB5nuff4mQbuo6nzsoa4ULIW3ZkxfBpragzSy8ezHMz+4VVDcZ+7ZDCF7TImlSeK1v9IywvWhgI4uIrsAB53hmgRguXHHJkkQrSlgoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886881; c=relaxed/simple;
	bh=zl9PTfYDgX37SrTUinkONG5qdSt3AMJGBkNO49g4CAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jysijw36z7zzhuGCsfgVzToDnUC07sRKOTgFZAEANZtHBQZ0mefb17HwMiAy0vzdztDtZwt14Gay1m0Td6x2z77tlh/YbwBFR1m0KruFaTWDwsp4QRpOB5l7kPPTLSB83BQAgoxanasD8uZeWEkkO8EQBq3Qe4v6VZNdjB8OMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXIz1epJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70211C4CEDD;
	Thu, 13 Mar 2025 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886880;
	bh=zl9PTfYDgX37SrTUinkONG5qdSt3AMJGBkNO49g4CAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pXIz1epJZACMll+Ry4KfrlWCJA462P/jsZdGXC3KB28KHsG35jawz2piAaS6kIFW8
	 P+fk78apG+0LHb/vKeEz8295rBBL3Z1UoJWpwfH+1xAy1R8pDCouqYtwPgYiVp//pG
	 MnJaBXDYrLiRjNxz5WZQY3/jWZs63iLhdKeE16QP9sqm73COARTSVyo+BEGkZpzeyi
	 hxoHWt2+hkD7iXEcFUriWEmWM4/+O3GvKjXgyyF30tV0Mtsj6SWXcUtsNE2xn2zkS9
	 ixmfXZYdjgShm8TJdkCSBt1cA2HopCXVeS9lbewpz5S9RZVF4rkJ2+5MQ+GkVaZAZL
	 UfOiO45nevJ4g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-60009c5dd51so285797eaf.1;
        Thu, 13 Mar 2025 10:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+XuazDc8B6nxudkMPx9xjnCE7rFfIH4l2exiztaDicaXj0h8qPUVl2Zqe0jh+8rUppS/0994b4Q==@vger.kernel.org, AJvYcCX67lLPvfPqKuBlKryc6qSpOPga+9If1Lxwtyg/UxGACObJZ34Ksp0HMdbI8HwECe7ffx6shS1QRY3KhPC6P+/c3I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5Ae5eNUVJNSTPD494YJ2CRQxQhCpzfMLqLHZC0TmOtOneM4+
	7LXLcy46/eq7nDEc8DoDsP8oU5jHErxP3a/Je2dSnwpkp/zJAs4WY4IcpAeWdDrjFVoCOfcqGl/
	NSVwZsVtf0PhUOnmtFqw4Y0cb5j8=
X-Google-Smtp-Source: AGHT+IEuKP8HiK8KBKtqZ7F5gucMLCyJTQmLWSrIAkxe/6yoHRu4j8JCzVHMH6HTRuWxcIoukj5QdiOQdUutkcVVYp8=
X-Received: by 2002:a05:6870:b50d:b0:2c2:27c8:5865 with SMTP id
 586e51a60fabf-2c68b1bf1f1mr170048fac.9.1741886879705; Thu, 13 Mar 2025
 10:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
 <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
 <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
 <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com> <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com>
In-Reply-To: <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 18:27:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jKOeZxzUXu9bHA4=SDio1FT3ZmfoOGqNNZO2+DN+U21Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpFL8tnNXY3I5aOM-EYRu2U84F_cMWOJoVflpqMUvO4z1lxkx4vUyFaBTo
Message-ID: <CAJZ5v0jKOeZxzUXu9bHA4=SDio1FT3ZmfoOGqNNZO2+DN+U21Q@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Thu, Mar 13, 2025 at 5:48=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Saravana,
>
> On Thu, 13 Mar 2025 at 15:32, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> > On Thu, 13 Feb 2025 at 11:26, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google.com> =
wrote:
> > > > On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <geert@l=
inux-m68k.org> wrote:
> > > > > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> > > > > > Instrumenting all dev->power.completion accesses in
> > > > > > drivers/base/power/main.c reveals that resume is blocked in dpm=
_wait()
> > > > > > in the call to wait_for_completion() for regulator-1p2v, which =
is
> > > > > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing
> > > > >
> > > > > [...]
> > > > >
> > > > > > Looking at /sys/devices/virtual/devlink, the non-working case h=
as the
> > > > > > following extra entries:
> > > > >
> > > > > Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary b=
us
> > > > > to create four subdevices:
> > > > >   - ti_sn65dsi86.aux.0,
> > > > >   - ti_sn65dsi86.bridge.0,
> > > > >   - ti_sn65dsi86.gpio.0,
> > > > >   - ti_sn65dsi86.pwm.0.
> > > > > None of them have supplier:* symlinks in sysfs, so perhaps that i=
s
> > > > > the root cause of the issue?
> > > >
> > > > Sorry, I haven't had time to look into this closely. Couple of
> > > > questions/suggestions that might give you some answers.
> > > >
> > > > Is this an issue only happening for s2idle or for s2ram too? I'd gu=
ess
> > > > both, but if not, that might tell you something?
> > >
> > > The two (very similar) boards I could reproduce the issue on do not
> > > support s2ram yet.
> > >
> > > > The only reason the wait_for_completion() wouldn't work is because =
the
> > > > supplier is not "completing"?
> > >
> > > Yes, the diff shows ca. 70 additional calls to "complete_all()" in th=
e
> > > good case.
>
> >   4. When the issue happens, /sys/devices/virtual/devlink shows 3
> >      more links:
> >        A. platform:feb00000.display is a supplier of platform:fed80000.=
dsi-encoder
> >        B. platform:fed80000.dsi-encoder is a supplier of platform:feb00=
000.display
>
> Their status file report "dormant".
>
> >        C. i2c:1-002c is a supplier of platform:fed80000.dsi-encoder
>
> Its status file reports "available".
>
> >   5. What happens in dpm_noirq_resume_devices()?
> >
> >        /*
> >         * Trigger the resume of "async" devices upfront so they don't h=
ave to
> >         * wait for the "non-async" ones they don't depend on.
> >         */
> >         i2c-1 (i2c bus) and 1-002c (bridge device) are async,
> >         thus triggered first.
> >         After that, the remaining devices are resumed.
> >
> >      In the bad case:
> >
> >        device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
> >          dpm_wait_for_superior()
> >            parent soc: skipping wait_for_completion()
> >            dpm_wait_for_suppliers()
> >              supplier feb00000.display: skipped, DL_STATE_DORMANT
> >              ^^^^^^^^^^^^^^^^^^^^^^^^^
> > Cfr. extra link A above (harmless)
> >
> >              supplier e6150000.clock-controller: skipping wait_for_comp=
letion()
> >              supplier 1-002c: wait_for_completion() =3D> BLOCKED
> >              ^^^^^^^^^^^^^^^
> > Cfr. extra link C above, but the bridge device hasn't been resumed yet.
>
> Changing the test for "DL_STATE_DORMANT"[1] in dpm_wait_for_suppliers()
> to also include "DL_STATE_AVAILABLE" makes it skip supplier 1-002c,
> and fixes the issue.  Does that make sense?

Good question.

DL_STATE_AVAILABLE essentially means that the consumer hasn't been
probed yet, but it doesn't mean that it can be suspended before its
supplier.

Cheers, Rafael

