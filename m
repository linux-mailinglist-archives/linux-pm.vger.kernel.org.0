Return-Path: <linux-pm+bounces-34591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01672B560E1
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C4A1C80F5A
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30842ECE86;
	Sat, 13 Sep 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0Yu6R2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F8E555
	for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767427; cv=none; b=ZpDiDxxHQFCYOdjgUMv8UHMGlBnethscGBNPAPx+2WTyOpzA+cqhud3BZZC0RS+vMQrGZC3KzaMp/NFFD5bI7+rswZcioUMZKTzKjrC8Gtv5W2l/TTnviy1f/bMuUTQ6jfee6EX8o32CiH/OUSA2mfYvroaQPlfTPZnY7nLH/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767427; c=relaxed/simple;
	bh=jfB70gQONh76s9eOb2k7EuWL0y+TqUWsvIBuoaHEIgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvI3IIk36uQ//zfn3rETZHnX3bQ2S2UCpjoqEpWtA0WR8FQcHnD8x4MB8AL39DKTJMKHt0011GAm0j7nq4dPtqFWO9mdxvKJtPre2BUZ+2pqkSOD6uxwzI48fhZj0Yo4bmkcHpwctorgeN5zBdTN3P6u8i5PIPidQ9KnzbV0Cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0Yu6R2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369CAC4CEFC
	for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757767427;
	bh=jfB70gQONh76s9eOb2k7EuWL0y+TqUWsvIBuoaHEIgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I0Yu6R2ra4/DT88cl44PVNrMfOeFPiljiPHENl5VxvrHmS+ej9ozfV7A8c/PYgBZe
	 scUc3sbvYnHIGJ9IRQlt3IPC3bgrWTQriV20RfRklMtvd2pKgOYr44J1FsReV0SFzf
	 RpFIXWz7Ad0dwnisoRvoYb5ZuaRaRy8wEdnWRXHwlqtKjzpjoDD9dsJXXW+Pzr7amJ
	 SiyjHa/c8jR0EDfSLQdHaGyTJkuyeTOXGMQOslwjJlNgvRHmrQo1mXp9PsMMoFDTww
	 Cf7+FFrNDAwPze3x1i9OXPhy4ZJ9hDmFEjZzdaaHOrvLhlhwlH5nk6ww1MfqwWNOm8
	 ayyXZeQdMi8Gw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74c1251df00so1486773a34.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 05:43:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo6Xcdvas1VGuOohRITBfEKr/bHlXfLvpn0btSk0Xhe/46S3b7g245nC3xlV5mlek4xFlBtIBVwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykopBbiK0I+gX/AzwtlUrc7+VbQhOMPjICuUhiWdOfX75XqItv
	bln8Xppkz+eNYRjkfvodiVPwhlj7cKAVu5Lmc8uedtm32duKQ8x2g3CulRKNwon6ot6WoYNs76f
	Bo0aFN45zHZBRFmP97ZGuBFO67mdEIQs=
X-Google-Smtp-Source: AGHT+IEAmiMQnLcYLV/Pkj3NHYryOaXFljpsolHDj1IzK9H2zh00ir+lNbAaqOUzWhVVfMZ1hKEiamyleS7v2ajPG3Y=
X-Received: by 2002:a05:6830:6d15:b0:746:f391:9d71 with SMTP id
 46e09a7af769-753550e2c12mr3640920a34.23.1757767426497; Sat, 13 Sep 2025
 05:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
 <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
 <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
 <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
 <CAJZ5v0i6aFarDU8OTZ_3VS9dp4SaqKJ0SuiN4gFSxrRoAAV5CQ@mail.gmail.com>
 <24a69e4d-2f10-43fb-81d4-f7eea44a6b8d@rowland.harvard.edu>
 <CAJZ5v0gUjgY45WFye5STJ7kv30O4rQ=23qkOsHEMSxfwg8jO4g@mail.gmail.com>
 <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu> <20250912222321.ct5ezgvsgyvos2ah@synopsys.com>
In-Reply-To: <20250912222321.ct5ezgvsgyvos2ah@synopsys.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 13 Sep 2025 14:43:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvDxpB_8Um=SgWWFU8S8YVe4jmLa+yP_676sj+NNM5Bw@mail.gmail.com>
X-Gm-Features: Ac12FXzJER_E5HTgLjQMRgzyIRC7l3RKWw6eF7pJn9dN0S6FsvStekeOeK0QqhY
Message-ID: <CAJZ5v0jvDxpB_8Um=SgWWFU8S8YVe4jmLa+yP_676sj+NNM5Bw@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 12:23=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsy=
s.com> wrote:
>
> On Thu, Sep 04, 2025, Alan Stern wrote:
> > On Thu, Sep 04, 2025 at 07:34:22PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Sep 4, 2025 at 4:19=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > > >
> > > > On Thu, Sep 04, 2025 at 04:08:47PM +0200, Rafael J. Wysocki wrote:
> >
> > > > > Say this is not the case and say that the device is runtime-suspe=
nded
> > > > > to start with.  Then the "suspend" callback has two choices: eith=
er
> > > > > (1) it can runtime-resume the device before doing anything to it,
> > > > > which will also cause the device's parent and suppliers to
> > > > > runtime-resume, or (2) it can update the device's state without
> > > > > resuming it.
> > > > >
> > > > > If it chooses (1), then "resume" is straightforward.  If it choos=
es
> > > > > (2), "resume" may just reverse the changes made by "suspend" and
> > > > > declare that the device is runtime-suspended.  And if it really r=
eally
> > > > > wants to resume the device then, why not call runtime_resume() on=
 it?
> > > >
> > > > That's what I meant by needing "cooperation from the driver".  The
> > > > driver's ->resume callback needs to do this check to see which path=
way
> > > > to follow: (1) or (2).
> > >
> > > Unless "suspend" always does the same thing, so it always does (1) or
> > > it always does (2).
> > >
> > > In that case, "resume" will know what to do without checking.
> >
> > It still has to check whether the device is runtime suspended.
> >
> > > I'd like to mention that if "suspend" chooses (2), it may need to
> > > resume the suspended parent or suppliers to be able to access the
> > > device even though the device itself won't be resumed.  I'm not sure
> > > if (2) is really attractive then, though.
> >
> > True.
> >
> > > Also, in the example we've been considering so far, the assumption is
> > > that B can just stay in runtime suspend, so why would it need to be
> > > resumed by "resume"?  And if there is a specific reason for resuming
> > > it, "resume" can just call runtime_resume() on it AFAICS.
> >
> > So it appears to boil down to this, as far as ->resume is concerned: At
> > the start of the callback routine, there should be something like:
> >
> >       if (pm_runtime_suspended(dev)) {
> >               if (the device needs to be woken up) {
> >                       pm_runtime_resume(dev);
> >                       ... whatever else is needed ...
> >               }
> >               return 0;
> >       }
> >
> > If ->suspend is clever, it can clear or set the SMART_SUSPEND flag
> > according to whether the device will need to be woken up.  Then the
> > second conditional above will always be true whenever the callback runs=
,
> > so the test can be skipped.
> >
>
> So, can this solution be the default behavior in the PM core? That it
> would initiate pm_runtime_resume by default?

Not really because there are drivers that don't want that to be done.
For example, everybody pointing their suspend/resume callbacks to
pm_runtime_force_suspend/resume(), respectively, and not setting
SMART_SUSPEND.

> Seems you want this to be handled in the device driver and not PM core
> right? ie. the condition "the device needs to be woken up" will not be a
> PM user flag/config but the device driver needs to check that itself.

Not necessarily.  I'll write more about this next week (well, hopefully).

