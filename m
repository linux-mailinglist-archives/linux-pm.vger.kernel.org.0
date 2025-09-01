Return-Path: <linux-pm+bounces-33588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E3B3EFCA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 22:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA64205724
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773B4271448;
	Mon,  1 Sep 2025 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkHy7zYn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4D26CE3A;
	Mon,  1 Sep 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759238; cv=none; b=Dxmlo73frlSekk8PMp3leN3DYOOciRLAi7mAxORYxPf0yJ/n//W8e7nd5Nu0mw1UHvX5Ze/dpz/zU7mX4TMNQQJ8e/JppDyVFCKwLqV+qFVmB7oFUXkuECz+43yAMrZQ2Rl8z4fnPhpVW48D1ZLlJ8jezk1U069Eb/SkZev8P0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759238; c=relaxed/simple;
	bh=qygvqnPVTLVPc7F2G9GUBXCTIt0bz9f4pcFJIFmo5MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7HYvfHWQuIWTdxuwXz8uKGfJ9NPGBCGTSltCSSZP1++vI/gLFTt9apfmx2Eq3dqXbzOuyrmNM+EPN85n2fSMtIqQ9XGPLS6hmVZm290QlkRW1MCMwK2yhSMi1SMGyVQ/Ie7VjTrO/RTn6IVbUuZBb+G3js2D9T4O8Qdx8TTM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkHy7zYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBED8C4CEF7;
	Mon,  1 Sep 2025 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759237;
	bh=qygvqnPVTLVPc7F2G9GUBXCTIt0bz9f4pcFJIFmo5MY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WkHy7zYnsFXBai212YbrT/68mFbNkTsIIU6s6bmSLrbyctm604ezppyREjDkzs7X3
	 eigGTEiRzo19/JGVFRPm+4e6w4gOVQ0XSYvm/n9aXfT18Au0QQMPR6guAKPT1zxZGG
	 nShOHwMF5Vj3lgpqTcPXp1tY7ZxZfC4S0y+xGlY1cfFGb3XtJkLece9fZmmLGZBZzh
	 WKYyqF5LrHk9N0mqkTNN/2mbVdsBAIoezmWq4J5OgUNdEsJ5mVIfODR40uAkF01I26
	 jb4ipeusps/rg4ZkUFRySAgnswUqFexunsqj5tnyNfQNOm8VR2MD6ravBnBbyyNz0L
	 RX1j3bt3PTVjw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61bd4d14bc4so2579529eaf.1;
        Mon, 01 Sep 2025 13:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/Cd97sB2nnpVwiepnUWCefmBwdSGwsSbbgwJ74uccEGxIbw4KVGnzUv/vJakD9qOgEbD6n0FbXOY=@vger.kernel.org, AJvYcCVADPMcGLGnzHPW+MkmIngVm1UU7+YEQs0Xvd4ajo9U2g+9jywCnThNVg/y7cz9uy/kxyahLuZMbld72Cw=@vger.kernel.org, AJvYcCXOT0/UaCItuJOdkaS3M94B/luJGC+4MASb5kdpQH2lm9vPbH7LeDuJ0h/YxWltSUdI4ZHUiNNl1XSO@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqYjWiTBvpcw4hfweACfY2QY/WgvLgPRwbxTvyVDcCT0s5oEq
	BFVms+AdHLW+SIxghaT74lE5rcUwVkhnBRxNyLkCkPU2vxM6CQPi1GgCWDulmy4iFl7IrEzQ/ey
	vGJr4Qf/okDx7TmpToZ7iwg0grubrdQg=
X-Google-Smtp-Source: AGHT+IEHgorDUlefSMlIfkV7MKPXOXpe1teq+UGG3UeasIMKLioaOhksTWveVQdimpj5xsyNPxe9dgUvPvTAo/Vx3zk=
X-Received: by 2002:a05:6820:548:b0:61d:ce66:3715 with SMTP id
 006d021491bc7-61e337170cbmr4752697eaf.3.1756759236986; Mon, 01 Sep 2025
 13:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826150826.11096-1-ryanzhou54@gmail.com> <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com> <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu> <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 22:40:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
X-Gm-Features: Ac12FXzQ9hcEjurH8eUEd3X09l0F1Sv2FyEpPrrVXnlvaPC7gF5PlnObyV0V71Y
Message-ID: <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, ryan zhou <ryanzhou54@gmail.com>, 
	Roy Luo <royluo@google.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Aug 29, 2025 at 9:58=E2=80=AFPM Alan Stern <stern@rowland.harvard=
.edu> wrote:
> >
> > On Fri, Aug 29, 2025 at 09:23:12PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 29, 2025 at 3:25=E2=80=AFAM Alan Stern <stern@rowland.har=
vard.edu> wrote:
> > > > It sounds like the real question is how we should deal with an
> > > > interrupted system suspend.  Suppose parent device A and child devi=
ce B
> > > > are both in runtime suspend when a system sleep transition begins. =
 The
> > > > PM core invokes the ->suspend callback of B (and let's say the call=
back
> > > > doesn't need to do anything because B is already suspended with the
> > > > appropriate wakeup setting).
> > > >
> > > > But then before the PM core invokes the ->suspend callback of A, th=
e
> > > > system sleep transition is cancelled.  So the PM core goes through =
the
> > > > device tree from parents to children, invoking the ->resume callbac=
k for
> > > > all the devices whose ->suspend callback was called earlier.  Thus,=
 A's
> > > > ->resume is skipped because A's ->suspend wasn't called, but B's
> > > > ->resume callback _is_ invoked.  This callback fails, because it ca=
n't
> > > > resume B while A is still in runtime suspend.
> > > >
> > > > The same problem arises if A isn't a parent of B but there is a PM
> > > > dependency from B to A.
> > > >
> > > > It's been so long since I worked on the system suspend code that I =
don't
> > > > remember how we decided to handle this scenario.
> > >
> > > We actually have not made any specific decision in that respect.  Tha=
t
> > > is, in the error path, the core will invoke the resume callbacks for
> > > devices whose suspend callbacks were invoked and it won't do anything
> > > beyond that because it has too little information on what would need
> > > to be done.
> > >
> > > Arguably, though, the failure case described above is not different
> > > from regular resume during which the driver of A decides to retain th=
e
> > > device in runtime suspend.
> > >
> > > I'm not sure if the core can do anything about it.
> > >
> > > But at the time when the B's resume callback is invoked, runtime PM i=
s
> > > enabled for A, so the driver of B may as well use runtime_resume() to
> > > resume the device if it wants to do so.  It may also decide to do
> > > nothing like in the suspend callback.
> >
> > Good point.  Since both devices were in runtime suspend before the slee=
p
> > transition started, there's no reason they can't remain in runtime
> > suspend after the sleep transition is cancelled.
> >
> > On the other hand, it seems clear that this scenario doesn't get very
> > much testing.
>
> No, it doesn't in general AFAICS.
>
> > I'm pretty sure the USB subsystem in general is
> > vulnerable to this problem; it doesn't consider suspended devices to be
> > in different states according to the reason for the suspend.  That is, =
a
> > USB device suspended for runtime PM is in the same state as a device
> > suspended for system PM (aside from minor details like wakeup settings)=
.
> > Consequently the ->resume and ->runtime_resume callbacks do essentially
> > the same thing, both assuming the parent device is not suspended.  As w=
e
> > have discussed, this assumption isn't always correct.
> >
> > I'm open to suggestions for how to handle this.  Should we keep track o=
f
> > whether a device was in runtime suspend when a system suspend happens,
> > so that the ->resume callback can avoid doing anything?  Will that work
> > if the device was the source of a wakeup request?
>
> Generally speaking, for proper integration of system suspend with
> runtime suspend at all levels, it is necessary to track whether or not
> the given device has been suspended prior to system suspend.
>
> In fact, there are even ways to opt-in for assistance from the PM core
> and bus types in that respect to some extent.
>
> In the particular case at hand though, the PM core is not involved in
> making the decision whether or not to leave the devices in runtime
> suspend during system suspend and it all depends on the drivers of A
> and B.
>
> Note here that the problematic situation occurs when the suspend of B
> has run, but the suspend of A has not run yet and the transition is
> aborted between them, so the driver of A cannot do much to help.  The
> driver of B has a couple of options though.
>
> First off, it might decide to runtime-resume the device in its system
> suspend callback (as long as we are talking about the "suspend" phase
> and not any later phases of system suspend) before suspending it again
> which will also cause A to runtime-resume and aborting system suspend
> would not be problematic any more.  So that's one of the options, but
> it is kind of wasteful and time-consuming.
>
> Another option, which I mentioned before, might be to call
> runtime_resume() from the system resume callback of B (again, as long
> as we are talking about the "resume" phase, not any of the earlier
> phases of system resume).  This assumes that runtime PM is enabled at
> this point for both A and B and so it should work properly.
>
> Now, if the driver of B needs to do something special to the device in
> its system suspend callback, it may want (and likely should) disable
> runtime PM prior to this and in that case it will have to check what
> the runtime PM status of the device is and adjust its actions
> accordingly.  That really depends on what those actions are etc, so
> I'd rather not talk about it without a specific example.

Of course, the driver of B may also choose to leave the device in
runtime suspend in its system resume callback.  This requires checking
the runtime PM status of the device upfront, but the driver needs to
do that anyway in order to leave the device in runtime suspend during
system suspend, so it can record the fact that the device has been
left in runtime suspend.  That record can be used later during system
resume.

The kind of tricky aspect of this is when the device triggers a system
wakeup by generating a wakeup signal.  In that case, it is probably
better to resume it during system resume, but the driver should know
that it is the case (it has access to the device's registers after
all).  It may, for example, use runtime_resume() for resuming the
device (and its parent etc) then.

