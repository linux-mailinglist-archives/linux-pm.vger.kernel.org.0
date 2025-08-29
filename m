Return-Path: <linux-pm+bounces-33431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DFB3C2FF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 21:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4ACA607A8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16BA23BCF3;
	Fri, 29 Aug 2025 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFFIf2CG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179B19D093;
	Fri, 29 Aug 2025 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495596; cv=none; b=bTn8vgLzZQya9Kh2+DcTxeL2r3XcO5zyiu22qun3LaFPe7log3XkqrbUQV/KVdWY4frbx65Y0VoJ2BYuZXJTl2m9nwtBvFff+lb1sZh94sJIDHu1JE8a62xHus6OqFTaP2Bnke/0aarCOk87A6yjb75YnOQGjrbkywOEzqSCJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495596; c=relaxed/simple;
	bh=/7vZA9ZkA77vASufHDyIg4Jlwsl643VicajB9U3uPBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZ2+05bPjCoenbwRmjqb+99Avw2jbKZBiF2YmaQ8yZyoZlRgLp/3rWGuqecyrmcf8Y5fWFysnthOQqaDO6mmu6AUoOoQkVeNFzCGymfOmR9YJM7jiPLFIUAfY9LWpy542Ga/6xroFvLAfUZHMv/cx5iRWoVoGuJ7d8rFU9n1TcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFFIf2CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC3FC4CEF0;
	Fri, 29 Aug 2025 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756495596;
	bh=/7vZA9ZkA77vASufHDyIg4Jlwsl643VicajB9U3uPBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TFFIf2CGTiD4a21mikT3G5vsYDqUo6Lx8v1o7mBcHg5qold4UVWAFXEIYuRrvQYmZ
	 IS+RgaSgnPoTpi165qWBimlLuW0+KcKV0JoSZPaOuB1vfz9uAIOu1568ttmYLZ5Bao
	 NbABFOQcw3TZ9M66kUfdZm7w4PDdI6lIhhQgr6RP8GWs0PNULMMHvJEgoDe4wX69WV
	 JjAg5pX9iZTqyPb5pYZKJSAhwqZHnQwnVRGJFmq2KezKO0trrMUANmtzvb7HDu0+Wi
	 3ttKuiCfq7ksFXU0U5gNZamEnhbrteeFkqpMz1yo99jK3JPo/YUIfO7xViAt+zv2VL
	 SFB4yTIscxFOw==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7454509f088so1726969a34.1;
        Fri, 29 Aug 2025 12:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMHjj2Zx21spDnZWn03y+B8BvaGPCvbav5G3YQn0zAndQv721F8psKaBrrZDCDOSOjTL6DOhgeNioZ0tE=@vger.kernel.org, AJvYcCUWK15rJFAV/eEJPdE3pHyZRpDemYzrCuv5Aparn6Fef1XjSMk819QZKPKjUQ+bGFsx6Al0+uJsIPY=@vger.kernel.org, AJvYcCUs9+m1l+spEJ+0LjpEkve0wbOw7+dISCAa2TkeHsF2mnzooRr9JF9bnqhSb9jwcTcskbmtuUEMB9ge@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Zzl2fP2eevGPRJMzGoZLCWn/qiiNrbK/pSTxyTfF/KZ5OMDX
	vtwjk97y5ljDp7USczUQcEDK07VmUG5tgcqhBGLnabFS/mVeophKG+4jOwpMXqLDrrEWnu2Ql9h
	ojnaDu0fiU17abIbw4u9uiLK+kp91X6E=
X-Google-Smtp-Source: AGHT+IFXTGy50xFt4Qiw2Jji7yZ0OHWD+i+E98ZFE0W6EZPes45rZtJYgmMdS50MPFyt7HjYWAiaPxZyCTxHg3WPZrI=
X-Received: by 2002:a05:6830:6994:b0:744:f113:fef8 with SMTP id
 46e09a7af769-74500b95c22mr14400309a34.35.1756495595543; Fri, 29 Aug 2025
 12:26:35 -0700 (PDT)
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
 <20250829190731.gx2xrgdz3tor5a2v@synopsys.com>
In-Reply-To: <20250829190731.gx2xrgdz3tor5a2v@synopsys.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 21:26:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gY=w1G-R1EdpJi+Hm5+YmDWY2yJDHgVVVeOvQAkO1ffQ@mail.gmail.com>
X-Gm-Features: Ac12FXzDb0ZEopGbmv5UjBef3-NzCfFYadVsYE6RMNoqJ3nt6irTry7nYExHnxI
Message-ID: <CAJZ5v0gY=w1G-R1EdpJi+Hm5+YmDWY2yJDHgVVVeOvQAkO1ffQ@mail.gmail.com>
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

On Fri, Aug 29, 2025 at 9:07=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Thu, Aug 28, 2025, Alan Stern wrote:
> > On Fri, Aug 29, 2025 at 12:43:17AM +0000, Thinh Nguyen wrote:
> > > On Wed, Aug 27, 2025, Rafael J. Wysocki wrote:
> > > > On Wed, Aug 27, 2025 at 4:52=E2=80=AFPM Alan Stern <stern@rowland.h=
arvard.edu> wrote:
> > > > >
> > > > > Ryan:
> > > > >
> > > > > You should present your questions to the maintainer of the kernel=
's
> > > > > Power Management subsystem, Rafael Wysocki (added to the To: list=
 for
> > > > > this email).
> > > >
> > > > Thanks Alan!
> > > >
> > > >
> > > > > On Wed, Aug 27, 2025 at 10:09:10PM +0800, ryan zhou wrote:
> > > > > > Hi Roy,
> > > > > > Thank you for reviewing my patch.
> > > > > > >
> > > > > > > Wouldn't the parent glue dev already resume before resuming t=
he child dwc3?
> > > > > > >
> > > > > > No, in the following case, the parent device will not be review=
ed
> > > > > > before resuming the child device.
> > > > > > Taking the 'imx8mp-dwc3' driver as an example.
> > > > > > Step 1.usb disconnect trigger: the child device dwc3 enter runt=
ime
> > > > > > suspend state firstly, followed by
> > > > > > the parent device imx8mp-dwc3 enters runtime suspend
> > > > > > flow:dwc3_runtime_suspend->dwc3_imx8mp_runtime_suspend
> > > > > > Step2.system deep trigger:consistent with the runtime suspend f=
low,
> > > > > > child enters pm suspend and followed
> > > > > > by parent
> > > > > > flow: dwc3_pm_suspend->dwc3_imx8mp_pm_suspend
> > > > > > Step3: After dwc3_pm_suspend, and before dwc3_imx8mp_pm_suspend=
, a
> > > > > > task terminated the system suspend process
> > > > > > . The system will resume from the checkpoint, and resume device=
s in
> > > > > > the suspended state in the reverse
> > > > > > of pm suspend, but excluding the parent device imx8mp-dwc3 sinc=
e it
> > > > > > did not execute the suspend process.
> > > > > >
> > > > > > >
> > > > > > >Why would 'runtime PM trying to activate child device xxx.dwc3=
 but parent is not active' happen in the first place?
> > > > > > >
> > > > > > Following the above analysis, dwc3_resume calls
> > > >
> > > > I assume that dwc3_pm_resume() is meant here.
> > > >
> > > > > > pm_runtime_set_active(dev), it checks the
> > > > > > parent.power->runtime_status is not RPM_ACTIVE and outputs the =
error log.
> > > >
> > > > And it does so because enabling runtime PM for the child with
> > > > runtime_status =3D=3D RPM_ACTIVE does not make sense when the paren=
t has
> > > > runtime PM enabled and its status is not RPM_ACTIVE.
> > > >
> > > > It looks like the runtime PM status of the parent is not as expecte=
d,
> > >
> > > So is the scenario Ryan brought up unexpected? What are we missing he=
re
> > > and where should the fix be in?
> > >
> > > > but quite frankly I don't quite follow the logic in dwc3_pm_resume(=
).
> > > >
> > > > Why does it disable runtime PM just for the duration of
> > > > dwc3_resume_common()?  If runtime PM is functional before the
> > > > pm_runtime_disable() call in dwc3_pm_resume(), the device may as we=
ll
> > > > be resumed by calling pm_runtime_resume() on it without disabling
> > > > runtime PM.  In turn, if runtime PM is not functional at that point=
,
> > > > it should not be enabled.
> > >
> > > Base on git-blame, I hope this will answer your question:
> > >
> > >     68c26fe58182 ("usb: dwc3: set pm runtime active before resume com=
mon")
> > >
> > >     For device mode, if PM runtime autosuspend feature enabled, the
> > >     runtime power status of dwc3 may be suspended when run dwc3_resum=
e(),
> > >     and dwc3 gadget would not be configured in dwc3_gadget_run_stop()=
.
> > >     It would cause gadget connected failed if USB cable has been plug=
ged
> > >     before PM resume. So move forward pm_runtime_set_active() to fix =
it.
> > >
> > >
> > > In certain platforms, they probably need the phy to be active to perf=
orm
> > > dwc3_resume_common().
> >
> > It sounds like the real question is how we should deal with an
> > interrupted system suspend.  Suppose parent device A and child device B
> > are both in runtime suspend when a system sleep transition begins.  The
> > PM core invokes the ->suspend callback of B (and let's say the callback
> > doesn't need to do anything because B is already suspended with the
> > appropriate wakeup setting).
> >
> > But then before the PM core invokes the ->suspend callback of A, the
> > system sleep transition is cancelled.  So the PM core goes through the
> > device tree from parents to children, invoking the ->resume callback fo=
r
> > all the devices whose ->suspend callback was called earlier.  Thus, A's
> > ->resume is skipped because A's ->suspend wasn't called, but B's
> > ->resume callback _is_ invoked.  This callback fails, because it can't
> > resume B while A is still in runtime suspend.
> >
> > The same problem arises if A isn't a parent of B but there is a PM
> > dependency from B to A.
> >
> > It's been so long since I worked on the system suspend code that I don'=
t
> > remember how we decided to handle this scenario.
> >
>
> Alan, Rafael,
>
> What are your thoughts on how we should handle this.

I'm not really sure what you mean by "this": the scenario described by
Alan or something else?

I was pulled into the thread in the middle of it and I don't know the
full context.

> Should the fix be at the PM core? Sounds like the PM core needs to check
> more than whether the ->suspend callback was called earlier to determine
> whether to skip ->resume.

But the core doesn't know what happened in the ->suspend callback in
the first place, so how can it know what's the right thing to do?

