Return-Path: <linux-pm+bounces-27252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF6ABA4AB
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D213B3A15
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416E27FD71;
	Fri, 16 May 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW8Bg18s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7927FD70;
	Fri, 16 May 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427133; cv=none; b=LUDxWq8SaRHP9ADcLYjeHc/6yZvOWd3D0JfpIWPzHWeQqIzolZFHjuSarRDm1nl5YozFgHzYbNYkljZEYWK1hXcNPsuK6KySk7eVoalY1Zo5iH4buXLyggS57szTxCgpPXcxaooDitjDhXzObTX7koG4C1EQXi72FBUv7id/47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427133; c=relaxed/simple;
	bh=6Cb6ywclFYtlrtCawbNfQUEAdiioIPe/Mra8Lelr4VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/WNJ1ARVepIVKUm2wyzBzFyvlkRSqQobXXasQB22a0sJ1UNBkFYw0tRZGDCpIRih34GmRztbuomrcFB7rsrukiqQj3KyeLYk7CIe0sqgQCGHDieq+saK/xRDgRO3yIGPjOoO4UsIGPucZ4MTXb3ZoT53B3m/nI9RPFU6dAMUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW8Bg18s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5C4C4AF09;
	Fri, 16 May 2025 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747427132;
	bh=6Cb6ywclFYtlrtCawbNfQUEAdiioIPe/Mra8Lelr4VY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OW8Bg18s/j6rB4d5MbcmDg49y608/XptMh1dHWeBJirFhE6D/0uPFH3+BajpiMajd
	 Sk2wRJi8chTlbKI2r9jTtuxBRUK+H440yUzCbGOqliqrLVZeu9m1bXpy0RfqK5R2Dp
	 SA+R4Dq54WtnitBokzvZsSsAQw2HQgfDY1jFrAp50MWaqRrOWPs5vjRFgjNWjFloc7
	 cicns37HERhJyhH/r6YpvrY1l+WZBkT2MRHV1ASt81uj53GQNzLqg+HyGi8KUV4O0R
	 cdUU+yz9SiGrJHFbSXgLPvrFXnPDe9i0MWms0nrJUz+jZbl0mez2B6pErDchdBnPs5
	 PuqXbsdECCWJQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60402c94319so1776726eaf.1;
        Fri, 16 May 2025 13:25:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVAqZawESf4pefCx1qxsuGgAhxndcrZt7TDitJRVONwZKDDhQh1n8jNdjjWHgZ8kMr7tAs5CY00f98GNQ=@vger.kernel.org, AJvYcCWlPtyI+PM6iQFXrrzChL7et/SFuTSeH2RI/qsZW/6fLiI1s12AoDvvcxCjWZc/PyTIj5BErVc1VPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDlYhAI7uoE6la4N1lkseNgEMW99yyiXzLSUDvyW0t26vdnAP
	RDnaqJbG+VVTE/NsCYB+w49HdgK1UaCpwmPxT81IxjkEMvT6XIV4I9rtSQojWBwKFPND++t3FGy
	wc0zhbS6E9B8p6YwKJkDB7DYZMf0tnvU=
X-Google-Smtp-Source: AGHT+IH0Xes1Wzc8PA73AY9vV5b9owgRxMM57rsXjufnKy/wDUxGk8j9u6EagGzESspJXa2WL8JGNx2iD20dsSOj8Gw=
X-Received: by 2002:a05:6820:1807:b0:608:34d1:db96 with SMTP id
 006d021491bc7-609f3731c81mr2763527eaf.4.1747427132107; Fri, 16 May 2025
 13:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511174648.950430-1-pmenzel@molgen.mpg.de> <f6ce9e16-7cb4-4648-926f-6ac13e2ce100@molgen.mpg.de>
In-Reply-To: <f6ce9e16-7cb4-4648-926f-6ac13e2ce100@molgen.mpg.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 22:25:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0in+bXXqJO-EWa6LsDCdKzQHR_q2XfgHEPJbJjK2P_-Gg@mail.gmail.com>
X-Gm-Features: AX0GCFsB_QbPepHEGcorvk9VGR0iIm5NBwE9pAR7IR5Ccn_06DH8HEsyO9n1eAQ
Message-ID: <CAJZ5v0in+bXXqJO-EWa6LsDCdKzQHR_q2XfgHEPJbJjK2P_-Gg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: thaw_processes: Rewrite restarting tasks log to
 remove stray *done.*
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 4:48=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> [add change-log]
>
> Am 11.05.25 um 19:46 schrieb Paul Menzel:
> > `pr_cont()` unfortunately does not work here, as other parts of the
> > Linux kernel log between the two log lines:
> >
> >      [18445.295056] r8152-cfgselector 4-1.1.3: USB disconnect, device n=
umber 5
> >      [18445.295112] OOM killer enabled.
> >      [18445.295115] Restarting tasks ...
> >      [18445.295185] usb 3-1: USB disconnect, device number 2
> >      [18445.295193] usb 3-1.1: USB disconnect, device number 3
> >      [18445.296262] usb 3-1.5: USB disconnect, device number 4
> >      [18445.297017] done.
> >      [18445.297029] random: crng reseeded on system resumption
> >
> > `pr_cont()` also uses the default log level, normally warning, if the
> > corresponding log line is interrupted.
> >
> > Therefore, replace the `pr_cont()`, and explicitly log it as a separate
> > line with log level info:
> >
> >      Restarting tasks: Starting
> >      [=E2=80=A6]
> >      Restarting tasks: Done
> >
> > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
>
> v2: Use log message texts suggested by Rafael.
>
> >   kernel/power/process.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index 66ac067d9ae6..1938fafa9172 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -189,7 +189,7 @@ void thaw_processes(void)
> >
> >       oom_killer_enable();
> >
> > -     pr_info("Restarting tasks ... ");
> > +     pr_info("Restarting tasks: Starting\n");
> >
> >       __usermodehelper_set_disable_depth(UMH_FREEZING);
> >       thaw_workqueues();
> > @@ -208,7 +208,7 @@ void thaw_processes(void)
> >       usermodehelper_enable();
> >
> >       schedule();
> > -     pr_cont("done.\n");
> > +     pr_info("Restarting tasks: Done\n");
> >       trace_suspend_resume(TPS("thaw_processes"), 0, false);
> >   }
> >

An analogous change, which I have forgotten about, has been made
already in this cycle, but I prefer the way the messages look after
your changes, so I've rebased your patch on top of the other one and
applied it for 6.16.

Thanks!

