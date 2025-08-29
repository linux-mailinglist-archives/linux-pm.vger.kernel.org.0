Return-Path: <linux-pm+bounces-33430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ABCB3C2F8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F026A23670
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6D23FC54;
	Fri, 29 Aug 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIVXkZZl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A223D7F5;
	Fri, 29 Aug 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495406; cv=none; b=L5u/HFEVFbnVsvM6VZ6uRyUE29ArXsPC2H8fTCt0iburKfXvRLabASfJX8ZVeBYy3ilA4xnCPyeKJBl/KdlqJIfWeqi6C8ZQgEYRlo7wKjnn+kiYx84Oq9N7nOYzf5PhXqzOLNn7Hwju/b4hyPWOBCa7jjyL2YAv/8OMiLo+5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495406; c=relaxed/simple;
	bh=/qNQv6/YUZl+M24MZCwxNJ7uMi4lLQdGLv/Kb9BtL/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTS9dnjfI3+tH7Peg3C4i4LZzrZZR3m/Ja3LNQsc6l+uDML1NTAh/eDzol2zpmRldpyfO1F+RC6E450Ic7dnFLPsIJu74np9dt+xDpTWw7bcgvVWHnbpp6fFRfNueG9dcCT1PvEYdUySb8yFi2ghGU/qlUiDkBtIOwTU8t/ptpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIVXkZZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D229EC4CEF8;
	Fri, 29 Aug 2025 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756495405;
	bh=/qNQv6/YUZl+M24MZCwxNJ7uMi4lLQdGLv/Kb9BtL/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIVXkZZlYCGpBeWYSFhAJmKblmFPbyT2S6l9Sb5/+ektZK9dlnzVgTKqaobhIStoJ
	 CSMff85MwABrguWMNNFcrnmnFq6KV762QpSAUbq2NrTLuJ7f98x4eH7XzAwEwmGhur
	 entWKZGfZ5lUf8LK5IOhajEsAcW6OxUvAiu5bAC6I8m8PyBNS/7UmoivO+V6e+66wB
	 59y89sq0J0VnqIaE9eolJ/65kFAcrOTqonhaJAG45lWag0eVybACCCfYL2GxWztXBq
	 Kw6CL2QwjMxZ0w259zW0VQOAcaA7gOemdHAzFx5Y3O6kDXO8Bzgd0mYiPA7cSoXkXM
	 Ui+wFjT2aYa1A==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74526ca79beso1886147a34.0;
        Fri, 29 Aug 2025 12:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU13OlblzqPnmITT7qy90MN3oFsWu21VgZw2yvVzwsXvJFHrmQlN6LpJOpln/bx3d6MrJt/tTJZluqN@vger.kernel.org, AJvYcCW2TktaMHoif/s+o/5mv6ma2G17Ifd6AEcFfwUZ361i46phUu7e4jXAYZpJsOxT+jMvWjW7hYdzLA/X1so=@vger.kernel.org, AJvYcCXoqki9Lw6G+PgNdkMeTMyPXD0TyYqXqtxeoS32gzraXDNyW7XKlB9/yrjDGNDx0FLveb+Av40R3sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4stXVYWfozTQFV7Z4ibykN4T1GZ7KJkd8378Dr3sV7fqoMMJC
	1Bn7dfRPR8jgo98u0oyfFtj4KAjDgtqT8WctV3IpjSrDENog9JG4CwexjYSwU3LqIqJG7+kR7DW
	Fj0QyRcZpLCM2B00az0v2UPrqnsgb3NE=
X-Google-Smtp-Source: AGHT+IGhhO3+/fhQcPFtwDMGb+qBlFIeWpx6fqd/VvDCzukc9EkbPkoGilHJHbmMvPCJs3ZaK5heIeuKkPLnH9j4eR4=
X-Received: by 2002:a05:6830:40c1:b0:742:f82b:4f35 with SMTP id
 46e09a7af769-74500a69d25mr12526021a34.7.1756495405071; Fri, 29 Aug 2025
 12:23:25 -0700 (PDT)
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
In-Reply-To: <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 21:23:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
X-Gm-Features: Ac12FXyEF73V3lhOB13ApSuxu_i3ac2GiyhbkQnsLaaKZCKhVppMaOLjErmkg50
Message-ID: <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 3:25=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Aug 29, 2025 at 12:43:17AM +0000, Thinh Nguyen wrote:
> > On Wed, Aug 27, 2025, Rafael J. Wysocki wrote:
> > > On Wed, Aug 27, 2025 at 4:52=E2=80=AFPM Alan Stern <stern@rowland.har=
vard.edu> wrote:
> > > >
> > > > Ryan:
> > > >
> > > > You should present your questions to the maintainer of the kernel's
> > > > Power Management subsystem, Rafael Wysocki (added to the To: list f=
or
> > > > this email).
> > >
> > > Thanks Alan!
> > >
> > >
> > > > On Wed, Aug 27, 2025 at 10:09:10PM +0800, ryan zhou wrote:
> > > > > Hi Roy,
> > > > > Thank you for reviewing my patch.
> > > > > >
> > > > > > Wouldn't the parent glue dev already resume before resuming the=
 child dwc3?
> > > > > >
> > > > > No, in the following case, the parent device will not be reviewed
> > > > > before resuming the child device.
> > > > > Taking the 'imx8mp-dwc3' driver as an example.
> > > > > Step 1.usb disconnect trigger: the child device dwc3 enter runtim=
e
> > > > > suspend state firstly, followed by
> > > > > the parent device imx8mp-dwc3 enters runtime suspend
> > > > > flow:dwc3_runtime_suspend->dwc3_imx8mp_runtime_suspend
> > > > > Step2.system deep trigger:consistent with the runtime suspend flo=
w,
> > > > > child enters pm suspend and followed
> > > > > by parent
> > > > > flow: dwc3_pm_suspend->dwc3_imx8mp_pm_suspend
> > > > > Step3: After dwc3_pm_suspend, and before dwc3_imx8mp_pm_suspend, =
a
> > > > > task terminated the system suspend process
> > > > > . The system will resume from the checkpoint, and resume devices =
in
> > > > > the suspended state in the reverse
> > > > > of pm suspend, but excluding the parent device imx8mp-dwc3 since =
it
> > > > > did not execute the suspend process.
> > > > >
> > > > > >
> > > > > >Why would 'runtime PM trying to activate child device xxx.dwc3 b=
ut parent is not active' happen in the first place?
> > > > > >
> > > > > Following the above analysis, dwc3_resume calls
> > >
> > > I assume that dwc3_pm_resume() is meant here.
> > >
> > > > > pm_runtime_set_active(dev), it checks the
> > > > > parent.power->runtime_status is not RPM_ACTIVE and outputs the er=
ror log.
> > >
> > > And it does so because enabling runtime PM for the child with
> > > runtime_status =3D=3D RPM_ACTIVE does not make sense when the parent =
has
> > > runtime PM enabled and its status is not RPM_ACTIVE.
> > >
> > > It looks like the runtime PM status of the parent is not as expected,
> >
> > So is the scenario Ryan brought up unexpected? What are we missing here
> > and where should the fix be in?
> >
> > > but quite frankly I don't quite follow the logic in dwc3_pm_resume().
> > >
> > > Why does it disable runtime PM just for the duration of
> > > dwc3_resume_common()?  If runtime PM is functional before the
> > > pm_runtime_disable() call in dwc3_pm_resume(), the device may as well
> > > be resumed by calling pm_runtime_resume() on it without disabling
> > > runtime PM.  In turn, if runtime PM is not functional at that point,
> > > it should not be enabled.
> >
> > Base on git-blame, I hope this will answer your question:
> >
> >     68c26fe58182 ("usb: dwc3: set pm runtime active before resume commo=
n")
> >
> >     For device mode, if PM runtime autosuspend feature enabled, the
> >     runtime power status of dwc3 may be suspended when run dwc3_resume(=
),
> >     and dwc3 gadget would not be configured in dwc3_gadget_run_stop().
> >     It would cause gadget connected failed if USB cable has been plugge=
d
> >     before PM resume. So move forward pm_runtime_set_active() to fix it=
.
> >
> >
> > In certain platforms, they probably need the phy to be active to perfor=
m
> > dwc3_resume_common().
>
> It sounds like the real question is how we should deal with an
> interrupted system suspend.  Suppose parent device A and child device B
> are both in runtime suspend when a system sleep transition begins.  The
> PM core invokes the ->suspend callback of B (and let's say the callback
> doesn't need to do anything because B is already suspended with the
> appropriate wakeup setting).
>
> But then before the PM core invokes the ->suspend callback of A, the
> system sleep transition is cancelled.  So the PM core goes through the
> device tree from parents to children, invoking the ->resume callback for
> all the devices whose ->suspend callback was called earlier.  Thus, A's
> ->resume is skipped because A's ->suspend wasn't called, but B's
> ->resume callback _is_ invoked.  This callback fails, because it can't
> resume B while A is still in runtime suspend.
>
> The same problem arises if A isn't a parent of B but there is a PM
> dependency from B to A.
>
> It's been so long since I worked on the system suspend code that I don't
> remember how we decided to handle this scenario.

We actually have not made any specific decision in that respect.  That
is, in the error path, the core will invoke the resume callbacks for
devices whose suspend callbacks were invoked and it won't do anything
beyond that because it has too little information on what would need
to be done.

Arguably, though, the failure case described above is not different
from regular resume during which the driver of A decides to retain the
device in runtime suspend.

I'm not sure if the core can do anything about it.

But at the time when the B's resume callback is invoked, runtime PM is
enabled for A, so the driver of B may as well use runtime_resume() to
resume the device if it wants to do so.  It may also decide to do
nothing like in the suspend callback.

