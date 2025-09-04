Return-Path: <linux-pm+bounces-33843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C6B43F1A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522A4A441F5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1ED309DA1;
	Thu,  4 Sep 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj5z96jv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E143093B6;
	Thu,  4 Sep 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996418; cv=none; b=JaPhK8Uyd7EueY3JrgPfEGvrftNbt54UH9rpxXDLkJGWDiJAO9XyayC3pfq5YnZjxugLeYWG41K20ZtGFGt96aeMXeIpXNOO/fZxupwwT0x0+1RGXlAkOQS43HTjP8DgcOCz711EJef5l7/6uOGieempcrTizDdqmcOc1eACecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996418; c=relaxed/simple;
	bh=zsO60ct26WR/eJ2IFbjNl/ckcSwZBImdw60IDLqpGmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYXgbExZETQVwDKklex+/Usu7mfUGCU/1YuTnmHDgzlLQwdcYiPupgXzjVPk+zQsuP2QR4mCdYVFLrv8cALSWjXQP49CX1NEECnhrRRwAqXVRPdVPqQsm3JLoetNvbs9CrLvRtY7hoC4pwvIk/EoKYxcq4bZnhVGhC3xtKOjZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj5z96jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372C6C4CEF6;
	Thu,  4 Sep 2025 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996418;
	bh=zsO60ct26WR/eJ2IFbjNl/ckcSwZBImdw60IDLqpGmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mj5z96jvRC3hqiZLGa5DMXjlWTd6TxFgrgfv7SobdcjIur0YZ6WQkIwwat0LdfpjC
	 bRtwKD0bam8V50js+qNKHc16/zchNdWNxeNW+GawJ8mNjOi1pieHF6N3p3DmnpValK
	 PGNHMGdDluhVg4qGs99bUnWjaD0fbOXdxFtZLBOxD+/vUspZZQMlEWYlo4Tn8lmu9O
	 MTSOhgTnpWC1FVQP3DogWCKyPfGHmca+0I1VQxpbDbkF0WXyyDVat7QlapvvckY6da
	 R8iX6ZHimeq1lfUhmK6adjK8KoEWYXVLUOR9VILEdrP5+FVzqHQ3qQJcO08TDXi4Er
	 IwGIOuT9csVkw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61e27ee0ae4so152310eaf.0;
        Thu, 04 Sep 2025 07:33:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhOKmvmh2I6GRyF5vRnSbU/f+kn7wGDnkNhj3NWQ/iRcfFvBhRQLOREhvwL1mxdkVYz64iXMDc+djIUHQ=@vger.kernel.org, AJvYcCViAX14m1xLkNUeYXUsID9XIeiSg6XcAv4yctjFbSIgYZgxjS+qSS947HJTAtUrGZX9DfpZEo4ufLw=@vger.kernel.org, AJvYcCWFpvspvj8eGUK19+JOefABGYcQcxvMZx816fLp3fS9z/3m3nghkimFgBk9YNdvkcYdhXStf++rOJkc@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKFNJGBl1oAHfDIzPW9I8JdnZHuRDx2Zmbyv77tRct2va5++0
	Y5FDltThCx+W4+u4wHsrSyy5Zi/ttVnujmQSk6LVCMzQyojv+yz//W6Fnt3PBrjX9oX9TNzuWFQ
	FihCB8/Da/3cr7A3IFVvFo+hpJEPCehM=
X-Google-Smtp-Source: AGHT+IESkFGM/9yM3pRapNVXr7JWYX6xqmeLWHtVbhJiZ0nkllMRdqafnhq1dksqqrSRKZuh9qh22uH+XfWBLiQ8dA4=
X-Received: by 2002:a05:6820:1caa:b0:61e:2938:640f with SMTP id
 006d021491bc7-61e3379c34emr8931734eaf.8.1756996417469; Thu, 04 Sep 2025
 07:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829004312.5fw5jxj2gpft75nx@synopsys.com> <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
 <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
 <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
 <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
 <CAJZ5v0i6aFarDU8OTZ_3VS9dp4SaqKJ0SuiN4gFSxrRoAAV5CQ@mail.gmail.com> <24a69e4d-2f10-43fb-81d4-f7eea44a6b8d@rowland.harvard.edu>
In-Reply-To: <24a69e4d-2f10-43fb-81d4-f7eea44a6b8d@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 16:33:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5jDhYO-MSv2z2AtBJfO0RyhuHx5pUWPsnX6nrH7CMTA@mail.gmail.com>
X-Gm-Features: Ac12FXxZXNZumjUR03_Y88kljWHCqxM6M6YpzyO4ZzqQ_QiUFFqJWJDrrpSB8aY
Message-ID: <CAJZ5v0g5jDhYO-MSv2z2AtBJfO0RyhuHx5pUWPsnX6nrH7CMTA@mail.gmail.com>
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

On Thu, Sep 4, 2025 at 4:19=E2=80=AFPM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Thu, Sep 04, 2025 at 04:08:47PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 3, 2025 at 11:54=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 09:30:47PM +0200, Rafael J. Wysocki wrote:
> > > > I personally think that it would be reasonable to simply preserve
> > > > device states in error paths unless they have been changed already
> > > > before the error (or suspend abort due to a wakeup signal).
> > >
> > > The problem is complicated by the interaction between runtime-PM stat=
es
> > > and system-sleep states.  In the case, we've been considering, B chan=
ges
> > > from runtime-suspended to runtime-suspended + system-suspended.
> > > Therefore the error path is allowed to modify B's state.
> >
> > Yes, it is, but retaining the B's state in an error path is also fine
> > so long as no changes have been made to it so far.
> >
> > If B was runtime-suspended to start with and none of the suspend
> > callbacks invoked for it so far has done anything to it, then it is de
> > facto still runtime-suspended and its state need not be changed in an
> > error path.
> >
> > > > By this rule, B would be left in runtime suspend if it were still i=
n
> > > > runtime suspend when the error (or suspend abort in general) occurr=
ed
> > > > and then it doesn't matter what happens to A.
> > >
> > > More fully, B would be changed from runtime-suspended + system-suspen=
ded
> > > back to simply runtime-suspended.  Unfortunately, none of the PM
> > > callbacks in the kernel are defined to make this change -- at least, =
not
> > > without some cooperation from the driver.
> >
> > Except when runtime-suspended + system-suspended is effectively the
> > same as runtime-suspended.
> >
> > Say this is not the case and say that the device is runtime-suspended
> > to start with.  Then the "suspend" callback has two choices: either
> > (1) it can runtime-resume the device before doing anything to it,
> > which will also cause the device's parent and suppliers to
> > runtime-resume, or (2) it can update the device's state without
> > resuming it.
> >
> > If it chooses (1), then "resume" is straightforward.  If it chooses
> > (2), "resume" may just reverse the changes made by "suspend" and
> > declare that the device is runtime-suspended.  And if it really really
> > wants to resume the device then, why not call runtime_resume() on it?
>
> That's what I meant by needing "cooperation from the driver".  The
> driver's ->resume callback needs to do this check to see which pathway
> to follow: (1) or (2).
>
> I bet that right now almost none of the drivers in the kernel do
> anything like that.  I know that the USB drivers always follow (1)
> during ->resume, even if they followed (2) during suspend.  What do the
> PCI drivers do?

If they don't set DPM_FLAG_SMART_SUSPEND, the PCI bus type suspend
callback will runtime-resume their devices.

Calling runtime_resume() in a suspend callback (for the "suspend"
phase) is a popular pattern because it was recommended once upon a
time.

> > > > The PM core can do something like that for the drivers opting in fo=
r
> > > > runtime PM integration assistance, so to speak.  That is, drivers t=
hat
> > > > point their ->suspend() and ->resume() callbacks to
> > > > pm_runtime_force_suspend() and pm_runtime_force_resume(),
> > > > respectively, or set DPM_FLAG_SMART_SUSPEND (or both at the same ti=
me
> > > > which is now feasible).  Otherwise, it is hard to say what the
> > > > expectations of the driver are and some code between the driver and
> > > > the PM core may be involved (say, the PCI bus type).
> > >
> > > Setting DPM_FLAG_SMART_SUSPEND really does sound like the best answer=
.
> > >
> > > But there still should be some way the PM core can make resumes easie=
r
> > > for drivers that don't set the flag.  Something like: If the device i=
s
> > > in runtime suspend with SMART_SUSPEND clear, perform a runtime resume=
 on
> > > the device's parent (and anything else the device depends on) before
> > > invoking ->resume.
> >
> > Say that ->resume() does nothing to the device (because it is
> > runtime-suspended and there's no need to resume it).  Why would the
> > core resume the parent etc then?
>
> You're right.  I'm just trying to figure out a way to fix this problem
> in general without the need for updating every driver in the kernel.
> Maybe that's not possible.  :-(

Fortunately, in many cases runtime-suspended + system-suspended =3D=3D
runtime-suspended.

Many drivers use pm_runtime_force_suspend/resume() as their
suspend/resume callbacks.

There are also drivers without runtime PM support.

It is not all lost I think.

