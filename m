Return-Path: <linux-pm+bounces-33585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E363B3EE85
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFBC202775
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5B32ED22;
	Mon,  1 Sep 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnd1KNY/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7C2EC0B7;
	Mon,  1 Sep 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755708; cv=none; b=fG4wvJX3xxEZB5eRwXmzFIgTB1igyeCCT0Mky9a76rsEH0mmjBVqdHW5lbODiJI9ZYtrH1SixQD0yK5fZ13wNierE8n/2WmobSCX2LsQTnn9DQ0HXQDDcTjkzqk8R7+cYeg7hvwXiqBiw/+mG4eRGE3Z5Vzvyveh0sijyfPoLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755708; c=relaxed/simple;
	bh=JuWyd0w7O3KJOfMGhW7hd+J8ZubplXvZt1GO/a4nZAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeiKEOcqxl2cU3Z9hyUXHJOm7uUh+Hn57JUKiTUd/xZmht1tbhbQv8w1GQY+zSIjU2v5rJ9doZzNzNN0dmeYm+eqC59/ifmfyoj7o6MF/P7CfLDXfWSDTcq05ETPK1S/unr5vMF9pQCDMKL39Fp+xjop0wpTbziip+s4wj0ErJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnd1KNY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F68C4CEF1;
	Mon,  1 Sep 2025 19:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755706;
	bh=JuWyd0w7O3KJOfMGhW7hd+J8ZubplXvZt1GO/a4nZAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jnd1KNY/RlxiFI+o7kNxEmaQ+asWSzuNuZWG6Ne+kctMEDiKMfj5ptxUiGKPaLHbi
	 hvIIQbjXTZTJwocZjIxd6sMj7KVSBSEJWd0lq1g9s1MtHzV7u50B+Hmxd4k6l6WKD9
	 Z9dLTAp6YZ9K/zq16ZdOfi9uuiuExw1kdlBxI056oJPymY8HNWhHeEP/VWnQnAUgHG
	 tPaah8yUdKTfWm+feiWq3cAjk6R5BeQ/5R1LYyeaFSFUcgovhAntOUnp54y8+nbyoI
	 6/AactEzgWEUc12VVhjWYld79ktMDj+07DchchdRyK4ZZBkv2s2Lal9JOSk26ZrzC5
	 gJJTGsuB5qL3Q==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61e093930f6so1781760eaf.0;
        Mon, 01 Sep 2025 12:41:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAC+Q+t55bNJ8STP5C3kAxZzu/C1wSXwRCQ6fzqy8ZPuUya9EVvOOWfiyXEeKfo3oprQDB0axn2Wg=@vger.kernel.org, AJvYcCVjP6eSO9+m3rcXAZjQw5CLMokh/tzx7VrfMUzfqcod3w6OkF2UeqYKla3HzWDnX8prNp7IJC+QrUjs@vger.kernel.org, AJvYcCWOpir/8woe/+vtx+VcMVdnL2Y95br+YeoTacTPK5CF4uknC2MAJS0jc7kQXa3ZkU+25VZmTS9swJtQEDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01PDfrbkjc/qAFVyvTjaDGSaqwGHmftqUNA9pieOcSLl6vUXG
	tm5qiDNxrkiovhm+NcHB0jXnVYMSV+S3mudDQ5Ie+lqk8XPWGUYCM6uyq2f2zRWnDKUXqBZ/uXu
	Xvi/OXe98CdXeKQPTLDM/jEoEoys8Knw=
X-Google-Smtp-Source: AGHT+IFg56Nj4wj5MrZO8OjqXwWe6nfcHuoA34JbFlEqQ8Bec9Z7cOVb26N8Bi461FJpPvtZZpqhq2zfYCuFVmsoQ6w=
X-Received: by 2002:a05:6820:1622:b0:61b:e931:c6c7 with SMTP id
 006d021491bc7-61e33773844mr4431933eaf.4.1756755705899; Mon, 01 Sep 2025
 12:41:45 -0700 (PDT)
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
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com> <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
In-Reply-To: <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 21:41:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
X-Gm-Features: Ac12FXyoeBwDzo3KAOFlkYZ2PQBJ5Q6IDHcvI5AcrlVWPtB3Sxlgn4Z5K2YrgtE
Message-ID: <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:58=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Aug 29, 2025 at 09:23:12PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 29, 2025 at 3:25=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > > It sounds like the real question is how we should deal with an
> > > interrupted system suspend.  Suppose parent device A and child device=
 B
> > > are both in runtime suspend when a system sleep transition begins.  T=
he
> > > PM core invokes the ->suspend callback of B (and let's say the callba=
ck
> > > doesn't need to do anything because B is already suspended with the
> > > appropriate wakeup setting).
> > >
> > > But then before the PM core invokes the ->suspend callback of A, the
> > > system sleep transition is cancelled.  So the PM core goes through th=
e
> > > device tree from parents to children, invoking the ->resume callback =
for
> > > all the devices whose ->suspend callback was called earlier.  Thus, A=
's
> > > ->resume is skipped because A's ->suspend wasn't called, but B's
> > > ->resume callback _is_ invoked.  This callback fails, because it can'=
t
> > > resume B while A is still in runtime suspend.
> > >
> > > The same problem arises if A isn't a parent of B but there is a PM
> > > dependency from B to A.
> > >
> > > It's been so long since I worked on the system suspend code that I do=
n't
> > > remember how we decided to handle this scenario.
> >
> > We actually have not made any specific decision in that respect.  That
> > is, in the error path, the core will invoke the resume callbacks for
> > devices whose suspend callbacks were invoked and it won't do anything
> > beyond that because it has too little information on what would need
> > to be done.
> >
> > Arguably, though, the failure case described above is not different
> > from regular resume during which the driver of A decides to retain the
> > device in runtime suspend.
> >
> > I'm not sure if the core can do anything about it.
> >
> > But at the time when the B's resume callback is invoked, runtime PM is
> > enabled for A, so the driver of B may as well use runtime_resume() to
> > resume the device if it wants to do so.  It may also decide to do
> > nothing like in the suspend callback.
>
> Good point.  Since both devices were in runtime suspend before the sleep
> transition started, there's no reason they can't remain in runtime
> suspend after the sleep transition is cancelled.
>
> On the other hand, it seems clear that this scenario doesn't get very
> much testing.

No, it doesn't in general AFAICS.

> I'm pretty sure the USB subsystem in general is
> vulnerable to this problem; it doesn't consider suspended devices to be
> in different states according to the reason for the suspend.  That is, a
> USB device suspended for runtime PM is in the same state as a device
> suspended for system PM (aside from minor details like wakeup settings).
> Consequently the ->resume and ->runtime_resume callbacks do essentially
> the same thing, both assuming the parent device is not suspended.  As we
> have discussed, this assumption isn't always correct.
>
> I'm open to suggestions for how to handle this.  Should we keep track of
> whether a device was in runtime suspend when a system suspend happens,
> so that the ->resume callback can avoid doing anything?  Will that work
> if the device was the source of a wakeup request?

Generally speaking, for proper integration of system suspend with
runtime suspend at all levels, it is necessary to track whether or not
the given device has been suspended prior to system suspend.

In fact, there are even ways to opt-in for assistance from the PM core
and bus types in that respect to some extent.

In the particular case at hand though, the PM core is not involved in
making the decision whether or not to leave the devices in runtime
suspend during system suspend and it all depends on the drivers of A
and B.

Note here that the problematic situation occurs when the suspend of B
has run, but the suspend of A has not run yet and the transition is
aborted between them, so the driver of A cannot do much to help.  The
driver of B has a couple of options though.

First off, it might decide to runtime-resume the device in its system
suspend callback (as long as we are talking about the "suspend" phase
and not any later phases of system suspend) before suspending it again
which will also cause A to runtime-resume and aborting system suspend
would not be problematic any more.  So that's one of the options, but
it is kind of wasteful and time-consuming.

Another option, which I mentioned before, might be to call
runtime_resume() from the system resume callback of B (again, as long
as we are talking about the "resume" phase, not any of the earlier
phases of system resume).  This assumes that runtime PM is enabled at
this point for both A and B and so it should work properly.

Now, if the driver of B needs to do something special to the device in
its system suspend callback, it may want (and likely should) disable
runtime PM prior to this and in that case it will have to check what
the runtime PM status of the device is and adjust its actions
accordingly.  That really depends on what those actions are etc, so
I'd rather not talk about it without a specific example.

