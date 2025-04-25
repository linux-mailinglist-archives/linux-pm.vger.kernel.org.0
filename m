Return-Path: <linux-pm+bounces-26237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0674A9D041
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEEF4C36CD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF3215781;
	Fri, 25 Apr 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2TDTfs3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D505134CF;
	Fri, 25 Apr 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604651; cv=none; b=SsClbqk7CkzO4e1eW3QqpVr3aNvzQZIfj9YtyoOdVNqIubWNwfQybiwi1sfk9u3/s2w+1ISqOZ+qcivNBMHSdWBiyXcorQC5W5Y6DR1+VLWRREArBLrdYpg/RU/BUgVja/K6bqYMYkf8Az0IB0nBbAve8HPWXhFolyy1+6S9NqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604651; c=relaxed/simple;
	bh=lQpZRp21ypT0sgeo7asX7MEr0T236GBxiJdY2FxeRWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr0iXiDngf0dldDs2UyhcS3gRjyXnoeSL6olBm8B0TOyeU3L8rQmP5K9HLMduCy6kruXxe5h1sH1k1CN2uLgfZjEqh1OktM/Y3JHzAdvdDWIcrmippYEqrt5tFqBuxOBE7fj5+pPhzoIVh+jP4EStrqizUxpJ7qCPlF7pGQilmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2TDTfs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6665C4CEEC;
	Fri, 25 Apr 2025 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604650;
	bh=lQpZRp21ypT0sgeo7asX7MEr0T236GBxiJdY2FxeRWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h2TDTfs3ZpnVI68v3FVjz/m3pd0exW3CFjBsys/F3ix1NnXQteaUUXawmoQR5LL5g
	 zfDc3IjZoA5QUYhZKR/p1y1F0v3CESBsbbD39LkeI4IBCpxaHiMBBghRFlFrItiie6
	 FZwSdslFnorAzBMxDFvC6DLmXku6bhrmDX8v03Tl6Dpb4BDMz1yb5xJFPIOfnWOu3N
	 KqcLaOihvCUgQROr053x2m/IlthRJkLJf9EmWubJuYbDAJ7I6/8rPGfP+KN0OOQXLo
	 Un9Yjfw1ml55c18W9IghF1Mu1xRn60Lh0pTBnWZtY3/uyZA+qOThlk24gNeyo1uOi0
	 UmFO+bQYTwG9Q==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f6aa4b3a7fso883117b6e.3;
        Fri, 25 Apr 2025 11:10:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiKzwMWV2Fq2UvyCxcNR+e2f2qYGibAL+0wlmThgwtAfehJD2ybtELLlg7sW4FxDkwNocdi/SzmbNkeRQ=@vger.kernel.org, AJvYcCWdP+WUEjRlaOdB7Xzt6NnmUc6MqhSCxsC7IO3bc1/f3+HGTyO8nyuDR0OnIUX6CsiuRtdFxaSfrpKfTZs=@vger.kernel.org, AJvYcCXMAchKWXtDYF9Qb72oZwJ5sCptKNoDVHCxDE7c/BekXKATt6Maa/6y/j/xyvRFlH/mPAsWq0t6COY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gNrNsRC4ASP0XT0ieU0vehNuHdItCLdJpbbeVeWhQh6KBTjV
	OYEDmlGL/HUpLByFT+r7p64T1Cjt1MBwGb4d9onGMZn52ixrvrVciz8h6XjEsM3EtJSfmvksTOD
	JU2qDg0FiPe46bFYSTSjgFyQQ/jE=
X-Google-Smtp-Source: AGHT+IFvb6Vhv5Dxm/J63/6/22Y4/PRskp8lXdhtTLQ0lVWAwtUuRa4ZoH9fRoAbaYBBe1pbITHrvSXYlh1CL+rqRnE=
X-Received: by 2002:a05:6808:6f97:b0:3fe:b1fd:527f with SMTP id
 5614622812f47-401f2876531mr2163990b6e.1.1745604650141; Fri, 25 Apr 2025
 11:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5891540.DvuYhMxLoT@rjwysocki.net> <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
In-Reply-To: <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 20:10:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCsd8fdXRdicT7mqsRte39WC+SVjgfz2NHS9QpvSnDdw@mail.gmail.com>
X-Gm-Features: ATxdqUEvMhI4wlWivn1ns9TDCRxes-DbS6sPiVIx2Ga83bbbjc8N-DTq_MZfwd4
Message-ID: <CAJZ5v0iCsd8fdXRdicT7mqsRte39WC+SVjgfz2NHS9QpvSnDdw@mail.gmail.com>
Subject: Re: [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume handling
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 7:14=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.dev> wrote:
>
> On 4/24/25 20:13, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The code in intel_suspend() and intel_resume() needs to be properly
> > synchronized with runtime PM which is not the case currently, so fix
> > it.
> >
> > First of all, prevent runtime PM from triggering after intel_suspend()
> > has started because the changes made by it to the device might be
> > undone by a runtime resume of the device.  For this purpose, add a
> > pm_runtime_disable() call to intel_suspend().
>
> Allow me to push back on this, because we have to be very careful with a =
hidden state transition that needs to happen.
>
> If a controller was suspended by pm_runtime, it will enter the clock stop=
 mode.
>
> If the system needs to suspend, the controller has to be forced to exit t=
he clock stop mode and the bus has to restart before we can suspend it, and=
 that's why we had those pm_runtime_resume().
>
> Disabling pm_runtime when entering system suspend would be problematic fo=
r Intel hardware, it's a known can of worms.

No, it wouldn't AFAICS.

> It's quite possible that some of the code in intel_suspend() is no longer=
 required because the .prepare will resume the bus properly, but I wanted t=
o make sure this state transition out of clock-stop is known and taken into=
 consideration.

This patch doesn't change the functionality in intel_suspend(), it
just prevents runtime resume running in parallel with it or after it
from messing up with the hardware.

I don't see why it would be unsafe to do and please feel free to prove me w=
rong.

What can happen after adding this pm_runtime_disable() that will make
things not work?

> Bard, is this a configuration you've tested?
>
> > Next, once runtime PM has been disabled, the runtime PM status of the
> > device cannot change, so pm_runtime_status_suspended() can be used
> > instead of pm_runtime_suspended() in intel_suspend().
> >
> > Moreover, checking the runtime PM status of the device in intel_resume(=
)
> > is pointless because the device is going to be resumed anyway and the
> > code running in the case when the pm_runtime_suspended() check in
> > intel_resume() returns 'true' is harmful.  Namely, calling
> > pm_runtime_resume() right after pm_runtime_set_active() has no effect
> > and calling pm_runtime_idle() on the device at that point is invalid
> > because the device is technically still suspended (it has not been
> > resumed yet).  Remove that code altogether along with the check leading
> > to it.
> >
> > Finally, call pm_runtime_set_active() at the end intel_resume() to set
> > the runtime PM status of the device to "active" because it has just bee=
n
> > resumed and re-enable runtime PM for it after that.
>
>
>
> > Additionally, drop the setting of DPM_FLAG_SMART_SUSPEND from the
> > driver because it has never been necessary and should not have been
> > done.
>
> IIRC it was your recommendation to add this flag many moons ago... No iss=
ue to remove it, it's just not something any of the 'SoundWire' folks are k=
nowledgeable with.

But not in this driver.  It doesn't have any early-late or noirq
callbacks anyway.

Thanks!

