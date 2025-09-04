Return-Path: <linux-pm+bounces-33841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A333B43E2D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1594A079A0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28693090C2;
	Thu,  4 Sep 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPqF6pdJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFE2222AC;
	Thu,  4 Sep 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994939; cv=none; b=CSupCSrQrfFsYqUw199EENG8APD95H01HCqk44MUfrP2U/rMdrxOv/udJ1SkvhCTUPRwn0dfvvYq0hS7BERLqYu2tHcPq0xxbTyvk+H0C+5lX+gJ0z14+mGeksipeIQpL0n9yP3UDeklB9hrYqUPBq9lnYAJ8SF0KUhRJWMIP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994939; c=relaxed/simple;
	bh=HtPKr+oBwPSeYkKEKVoPR5lmirDKZWIMKpcMOaHguWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8pJOnLWl7CLeKm32KSnyfYsWk1BAsMnRS+V/AmOD/O0a6OlCJf/lN/cLo9W8SIQAxf/tPqUXTITpldIw5DoBAdLvwv0Vivvs5y4+Ent3ylPnJDJ6OD4fivF+S9xQZHXYUQICP16eJo0Rft3PIztySxMDYd4Zqg67VDOZeUxUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPqF6pdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7501DC4CEF9;
	Thu,  4 Sep 2025 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756994939;
	bh=HtPKr+oBwPSeYkKEKVoPR5lmirDKZWIMKpcMOaHguWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JPqF6pdJ9q6tZLOFbgOflUSf6Vt9wiordoyXsGzw4sF4sFTBfb/sd8kOCHEcqBEiI
	 ZKYva7avQnX5rbHYi+PcYj6kE1ZrRre4o+rJq7AZXzecrDSCp1rSEsX5gGEgdOUFa/
	 I+3eLzzngYu/WHjHGgiwtSZny8hXRz4QdarWl9D2K8rRgtMQbiaIgVva1UCysxxxml
	 c+TiSyHyM/MUKsYG420GTOR/wMJDVsh1F+TmXQFGUBkVvfYNcZNV3NpteW/jVXkc40
	 bJtfwOTuShkCQAY+t+7jae3ZX2Y/fkfg9MX7FIB3jnIpx5RVxnokXIQcl4B5PS9WE7
	 YUjQkev4t9FWA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74381df387fso509671a34.0;
        Thu, 04 Sep 2025 07:08:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7CgTSGkl5tkb4p+4rvpb7fkXLKwCakzfFCwXt2Sr6vzgWLej5+Yslb5oRkl/KSQ6fDUN7X/X2tmOg@vger.kernel.org, AJvYcCV39CTBblnt2kvkhDd55kS27SWGgUwXVh7GzbZSD6/U9CqW7sVbZ2gFAO0iQXkHCT+j7BTFRPBo+eNiQ78=@vger.kernel.org, AJvYcCX4gNH46UsoXc299RLZ3U6VXrbhfxyxK6wvgd1mW7gPaF72zYI23nDcfOIJCwl00xMomdfYS113Dpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxffPSQ5llhJ559RVBviunqRxqacewv9CRuPjTMX9hcklM5bQ+g
	L913t4pUaxSg42rvuicVcUBtJK28rW9LOgOIsYtw+PEbsSh6nezIPZGb+CoHckzAB4GAQ3O804W
	4Q+Jn3CrwGpbxkkGtfMthJRB24KtfeqA=
X-Google-Smtp-Source: AGHT+IE7JhcNBlgb7askha34gNOAiHBg9hrIof0dwlBGqjwmjl0SYafNORGRA8Eyhwv3nVj/gXB58CEZna/ceWlpN2c=
X-Received: by 2002:a05:6830:67ec:b0:745:5166:2b32 with SMTP id
 46e09a7af769-74569eab3ebmr10511624a34.24.1756994938692; Thu, 04 Sep 2025
 07:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com> <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
 <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
 <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com> <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
In-Reply-To: <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 16:08:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6aFarDU8OTZ_3VS9dp4SaqKJ0SuiN4gFSxrRoAAV5CQ@mail.gmail.com>
X-Gm-Features: Ac12FXyIRtaVtxeIz24oEQBfd0vlON_oiPl0sIEvFoYYODK4rLgHJDI2PbBGfPc
Message-ID: <CAJZ5v0i6aFarDU8OTZ_3VS9dp4SaqKJ0SuiN4gFSxrRoAAV5CQ@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 11:54=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Sep 03, 2025 at 09:30:47PM +0200, Rafael J. Wysocki wrote:
> > I personally think that it would be reasonable to simply preserve
> > device states in error paths unless they have been changed already
> > before the error (or suspend abort due to a wakeup signal).
>
> The problem is complicated by the interaction between runtime-PM states
> and system-sleep states.  In the case, we've been considering, B changes
> from runtime-suspended to runtime-suspended + system-suspended.
> Therefore the error path is allowed to modify B's state.

Yes, it is, but retaining the B's state in an error path is also fine
so long as no changes have been made to it so far.

If B was runtime-suspended to start with and none of the suspend
callbacks invoked for it so far has done anything to it, then it is de
facto still runtime-suspended and its state need not be changed in an
error path.

> > By this rule, B would be left in runtime suspend if it were still in
> > runtime suspend when the error (or suspend abort in general) occurred
> > and then it doesn't matter what happens to A.
>
> More fully, B would be changed from runtime-suspended + system-suspended
> back to simply runtime-suspended.  Unfortunately, none of the PM
> callbacks in the kernel are defined to make this change -- at least, not
> without some cooperation from the driver.

Except when runtime-suspended + system-suspended is effectively the
same as runtime-suspended.

Say this is not the case and say that the device is runtime-suspended
to start with.  Then the "suspend" callback has two choices: either
(1) it can runtime-resume the device before doing anything to it,
which will also cause the device's parent and suppliers to
runtime-resume, or (2) it can update the device's state without
resuming it.

If it chooses (1), then "resume" is straightforward.  If it chooses
(2), "resume" may just reverse the changes made by "suspend" and
declare that the device is runtime-suspended.  And if it really really
wants to resume the device then, why not call runtime_resume() on it?

> > The PM core can do something like that for the drivers opting in for
> > runtime PM integration assistance, so to speak.  That is, drivers that
> > point their ->suspend() and ->resume() callbacks to
> > pm_runtime_force_suspend() and pm_runtime_force_resume(),
> > respectively, or set DPM_FLAG_SMART_SUSPEND (or both at the same time
> > which is now feasible).  Otherwise, it is hard to say what the
> > expectations of the driver are and some code between the driver and
> > the PM core may be involved (say, the PCI bus type).
>
> Setting DPM_FLAG_SMART_SUSPEND really does sound like the best answer.
>
> But there still should be some way the PM core can make resumes easier
> for drivers that don't set the flag.  Something like: If the device is
> in runtime suspend with SMART_SUSPEND clear, perform a runtime resume on
> the device's parent (and anything else the device depends on) before
> invoking ->resume.

Say that ->resume() does nothing to the device (because it is
runtime-suspended and there's no need to resume it).  Why would the
core resume the parent etc then?

