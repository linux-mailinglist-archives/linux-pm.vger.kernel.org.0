Return-Path: <linux-pm+bounces-38833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92A1C8FBF9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE9B3AA3E7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D792F2903;
	Thu, 27 Nov 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrEdjuhK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60F2F28F5
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265554; cv=none; b=cWBa/0vkfF5j4QgRN5qWLZxs47dYmCnhGfgQKFQt2NxJrEzwIS0quzf6K6caH8a/F0WXrvQ+7EwE7mpZhGUzjdrcmI09eOT/uHmSEsyphUwjT/SdH83Z6VTSdBTgwgxZlkavqOtcY16mhGPU5hJ1Ax7xemGUvLzicZj2BckIN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265554; c=relaxed/simple;
	bh=8lPh6RsZGzhW8vz2APhpAZDUvPP5rsSMjo3d4DxQlBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/GeHJfy9TmKAqh64noj0L9R77fHVdlSXcBBaVRzyGgmQ5qt17ZEYJNVyo/u2HQ19ex2jQh0Be6b+wAV37QXQXr23FVAtfj/L3gf9RhzNrngPHcS88z6XQIEHbYoo3IJFZlY/0xin1D+Mzhk8CTVH8gBfGgChM8MbOiAHb0nG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrEdjuhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16845C116D0
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764265554;
	bh=8lPh6RsZGzhW8vz2APhpAZDUvPP5rsSMjo3d4DxQlBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VrEdjuhK+3XpsP7WTvS/7U96FcYu7EFseN8EXf6gSG1+GmnK3n43LqwWwcRBx3CPw
	 cfPWStmRSoy7CQaUACAHE2hftl4FSu043wFQShek7eKNuvuEBnYDuDrKb7YA2ffoOa
	 m4ia1i8NQNIPBFLoOf1VtgtJIT3o+MKZMKWKp0tpMdloEiKwj6WixLuz95XVUZ1fYk
	 S2CWi1LBVOzmFb8QUuS2UbE5rl5whsMVNQfuhGTQFzikKjQEgCwD3eh7779CBDuycd
	 FJaHzheWkgrzU/Ni8E7eMYtfELRIwZhkmQypimH3kSvDhxn3EK+gvr63lArVsm258M
	 MC7Qj1uTGALZQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec31d2b7f8so276129fac.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 09:45:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7Nk0ys6FINETzbhiVviWZA/Hr5BDCyxJOhP1TRdqtC5lRA8A+
	5d9bP3bE/3yX8i69ntDh4V+B7/6m1Ftiyf5ZtVnZjT1loektBovXpmD1jZtTK7fhKRtoy5e6B3R
	1Wejvl6E6ZS2AWPWbSpokyH3SsXG5D6o=
X-Google-Smtp-Source: AGHT+IGwqXQ1HwqBiOcVcjGveNr8nDuljYRQ8bvwvhaU/bpbeuOZXVvseo7L406EBetfzdo90gtJ6u0ya5yad0CWAkM=
X-Received: by 2002:a05:6808:14cd:b0:44f:79de:1981 with SMTP id
 5614622812f47-45115aca5a1mr9346297b6e.39.1764265553490; Thu, 27 Nov 2025
 09:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-3-darcari@redhat.com>
 <CAJvTdK=tw76+79sCAa3TbVQwDdv9EGCWVrFvFbHihtH3jNcDWw@mail.gmail.com> <41373082-e421-496f-955d-bc9abbf44be4@redhat.com>
In-Reply-To: <41373082-e421-496f-955d-bc9abbf44be4@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 27 Nov 2025 12:45:42 -0500
X-Gmail-Original-Message-ID: <CAJvTdKm-GThyvWsv8meGDPxymF+2PV0EH=Ny6crO+8MfS5QeLg@mail.gmail.com>
X-Gm-Features: AWmQ_bka9-3YZNnQkA2Jn4w_4Olh-NvBekdZODMTFs1Mtwq9kc7DevDjQZQnY3g
Message-ID: <CAJvTdKm-GThyvWsv8meGDPxymF+2PV0EH=Ny6crO+8MfS5QeLg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/power turbostat: avoid an infinite loop of restarts
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I guess it is sort of an art form upon malfunction to decide whether
it is fatal or not.

I suppose if we know that a counter used to work, and it stops working, the=
n we
are responding to a configuration change.  We don't want to count a
certain number
of configuration changes as a fatal error.

A more useful heuristic may be to recognize when there are failures
without any intervening successes,
and if those happen many times per second.  Likely that is the
infinite loop case we're looking for...

On Tue, Nov 25, 2025 at 4:51=E2=80=AFPM David Arcari <darcari@redhat.com> w=
rote:
>
>
> I see.  Perhaps this isn't fixable then.  I'll take another look.
>
> -DA
>
> On 11/25/25 2:12 PM, Len Brown wrote:
> > this patch introduces a limit of 10-restarts per turbostat lifetime,
> > down from infinity.
> >
> > some turbostat invocations span multiple uses of cpu online/offline --
> > so this limit will not fly.
> >
> > On Tue, Nov 18, 2025 at 10:58=E2=80=AFAM David Arcari <darcari@redhat.c=
om> wrote:
> >>
> >> There are some error cases where turbostat will attempt to reinitializ=
e
> >> by calling the re_initialize() function.  The code attempts to avoid
> >> an infinite loop by checking the value of 'restarted' in one case, but
> >> not others. It should be checked in all cases of restart.  Additonally=
,
> >> the 'restarted' is reset to zero at the start of the loop which also
> >> needs to be removed.
> >>
> >> Signed-off-by: David Arcari <darcari@redhat.com>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>   tools/power/x86/turbostat/turbostat.c | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/t=
urbostat/turbostat.c
> >> index 584b0f7f9067..5567b9ecd516 100644
> >> --- a/tools/power/x86/turbostat/turbostat.c
> >> +++ b/tools/power/x86/turbostat/turbostat.c
> >> @@ -6722,7 +6722,11 @@ void turbostat_loop()
> >>          set_my_sched_priority(-20);
> >>
> >>   restart:
> >> -       restarted++;
> >> +       if (restarted++ > 10) {
> >> +               if (!retval)
> >> +                       retval =3D -1;
> >> +               exit(retval);
> >> +       }
> >>
> >>          snapshot_proc_sysfs_files();
> >>          retval =3D for_all_cpus(get_counters, EVEN_COUNTERS);
> >> @@ -6730,13 +6734,9 @@ void turbostat_loop()
> >>          if (retval < -1) {
> >>                  exit(retval);
> >>          } else if (retval =3D=3D -1) {
> >> -               if (restarted > 10) {
> >> -                       exit(retval);
> >> -               }
> >>                  re_initialize();
> >>                  goto restart;
> >>          }
> >> -       restarted =3D 0;
> >>          done_iters =3D 0;
> >>          gettimeofday(&tv_even, (struct timezone *)NULL);
> >>
> >> --
> >> 2.51.0
> >>
> >>
> >
> >
>


--=20
Len Brown, Intel Open Source Technology Center

