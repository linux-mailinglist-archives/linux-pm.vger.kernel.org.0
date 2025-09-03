Return-Path: <linux-pm+bounces-33760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928CB429EF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1233BE855
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0836932A;
	Wed,  3 Sep 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvzjfBDg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3A2D7DE2;
	Wed,  3 Sep 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927859; cv=none; b=ugojfmXnlpvNmTZN/eDiJn1jOU+2o3UmBtgEV04p2bRdvGEIGbJ7ZF86dQwyQn7v/MhWwotzxvK9oq9qVvaI0aUs/Eh8jpyXktgKnbaubvJDzhfMdMR6UMMG7puI5se5eURfzWCWuCJUpOXRwdTtLv+y1i0RM3IWFeLdLDXN1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927859; c=relaxed/simple;
	bh=bOEWhj/DMbKGMjfDehipU/AbvbJ3F+TVVjLU6ELKsOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaHY7D4t36OE/4lgmBFPbAwOAsQJ6tjr4fPTzztkPVFOUlrsvpkJGxGtAxrp7CVfBRP/K96J3MPzjAlVRyPoYcAINUuf3xGJ5h/oGpmx3OuSmRMU1io7oi7d7YmnSNHzhtGN/fgwhWrZGWi6hKtgbY5lDSg4GZNVEhegEQBb4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvzjfBDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FBBC4CEF1;
	Wed,  3 Sep 2025 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927859;
	bh=bOEWhj/DMbKGMjfDehipU/AbvbJ3F+TVVjLU6ELKsOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PvzjfBDgO1d08l/fMcveDZ5WNV6UR3qJ3/HUrf8QrlVTNtSopedwXM2p/Bybw2sDj
	 V15hgqannh1CLdKq0t7mlpwRLVZoXN/l2Yi0hqTY5hjWuJL9InoYl9A/4GiwCpAl0Y
	 Qu7yoIydPa+MTnrqjkEe9aU2X6xOtq55Vv9uk9ecRXWAOr8ZAnTfzdm6g+YKOptaRb
	 HhHMS/37Y0Hhi3cCLhotHkrsJi28htIkbKMfsNhv+d+X2FYXqqwHPaQ3uzROcxJNsq
	 l3n+CG4Yae+j8lT26ARA3mePUeJqKnhk8CsK2gjOoxVGlrk/StU0DUkUU4SvhA2DAq
	 /8QI4KnorUzHA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74381e207a0so238700a34.0;
        Wed, 03 Sep 2025 12:30:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRwWlJzteIi5F+EMfzA2SFh8HDtPAItlUDCAOS2Qv9xtf09dtRST8/nfjaseJl6O3FraY6/yOa8/u5v1E=@vger.kernel.org, AJvYcCVfma8MyKyuSJVL8z6eZdAE1CSMOdlMFCBjHIlqXKlj4uLRCwVsSfgCbxrRz2+h9wMslHt34fsQU1yt@vger.kernel.org, AJvYcCWe1ytw0emkaXf3szTZl2MaJyWboaTXS/QrbhBLmlGqgr3Oc+GBDb9yaCGaSlHrcCgb1YwMFzJU8u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DzGcnM7dy/YKsVX++L4dHFulLTbUCFKeteNm/+7rBvEcDE44
	aYhoJugE9ql/1Sr8KyH1AZnPkTFEvFMB+q4n5tEdpLeOkjcvEO8Ty2h/U/hJYuH9MnnaWV3Sav/
	ZBPSu4Zfqxca9XJBkXXPDyet861vjLz0=
X-Google-Smtp-Source: AGHT+IFQ9p90hXRjXn6MH1j2HTRM3pCYObsSQwrkh4lUED/TieWX9bpnR5r4rbFvPldePlcfrCpubqwBnT7H7rcJ4o0=
X-Received: by 2002:a05:6808:180e:b0:438:3927:e4c6 with SMTP id
 5614622812f47-4383927e64emr879646b6e.43.1756927858264; Wed, 03 Sep 2025
 12:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com> <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com> <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
In-Reply-To: <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 21:30:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
X-Gm-Features: Ac12FXxZ7Fb-Zf_CneXnD7imu_hj0xqNHkA7Lqw2wc98nBmKdYWlFPnzXaLvWWc
Message-ID: <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
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

On Tue, Sep 2, 2025 at 4:41=E2=80=AFAM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Mon, Sep 01, 2025 at 10:40:25PM +0200, Rafael J. Wysocki wrote:
> > Of course, the driver of B may also choose to leave the device in
> > runtime suspend in its system resume callback.  This requires checking
> > the runtime PM status of the device upfront, but the driver needs to
> > do that anyway in order to leave the device in runtime suspend during
> > system suspend, so it can record the fact that the device has been
> > left in runtime suspend.  That record can be used later during system
> > resume.
>
> As a general rule, I think this is by default the best approach.  That
> is, since B was in runtime suspend before the system sleep, you should
> just keep it in runtime suspend after the system sleep unless you have
> some good reason not to.  In other words, strive to leave the entire
> system in the same state that it started in, as near as possible.

That's reasonable IMV.

> One good reason not to would obviously be if B is the source of a wakeup
> signal...
>
> > The kind of tricky aspect of this is when the device triggers a system
> > wakeup by generating a wakeup signal.  In that case, it is probably
> > better to resume it during system resume, but the driver should know
> > that it is the case (it has access to the device's registers after
> > all).
>
> Not necessarily.  Suppose that C is a child of B, and C is the wakeup
> source.  B's driver might decide to keep B in runtime suspend
> since B wasn't the wakeup source -- but then C's driver would have to
> make the same decision and would not have access to C's registers.
>
> >  It may, for example, use runtime_resume() for resuming the
> > device (and its parent etc) then.
>
> Consider this as a possible heuristic for B's ->resume callback, in the
> case where B was in runtime suspend throughout the system sleep:
>
>         If B's parent A is not in runtime suspend, test whether B
>         has a wakeup signal pending.  If it does, do a runtime
>         resume.  If not (or if A is in runtime suspend), leave B
>         in runtime suspend.
>
> At first glance I think that will work fairly well.  Even if B is kept
> in runtime suspend when it shouldn't be, the normal runtime wakeup
> signalling mechanism should kick in without too much of a delay.

This is not just about the parent, but also about suppliers and things
get fairly complicated at that point, so I would just rely on the
observation that runtime wakeup should trigger shortly.

> The big problem is that this issue applies to all subsystems and
> devices.  It would be better if we had a uniform solution that could be
> implemented in the PM core, not in every single subsystem or device
> driver.
>
> Here's another possibility, one that can be implemented in the PM core
> during the ->resume, ->resume_early, or ->resume_noirq phase of system
> wakeup:
>
>         If A and B are both in runtime suspend, do not invoke B's
>         ->resume callback.  (Or maybe don't invoke it if A's ->resume
>         callback wasn't invoked.)
>
> There probably are some detailed reasons why that won't always work, but
> maybe you figure out something like it that will be okay.

I personally think that it would be reasonable to simply preserve
device states in error paths unless they have been changed already
before the error (or suspend abort due to a wakeup signal).

By this rule, B would be left in runtime suspend if it were still in
runtime suspend when the error (or suspend abort in general) occurred
and then it doesn't matter what happens to A.

The PM core can do something like that for the drivers opting in for
runtime PM integration assistance, so to speak.  That is, drivers that
point their ->suspend() and ->resume() callbacks to
pm_runtime_force_suspend() and pm_runtime_force_resume(),
respectively, or set DPM_FLAG_SMART_SUSPEND (or both at the same time
which is now feasible).  Otherwise, it is hard to say what the
expectations of the driver are and some code between the driver and
the PM core may be involved (say, the PCI bus type).

