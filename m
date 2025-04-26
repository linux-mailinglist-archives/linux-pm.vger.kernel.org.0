Return-Path: <linux-pm+bounces-26271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22FA9DB22
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713059A185A
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B76502B1;
	Sat, 26 Apr 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDdgGJaP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4B2F44;
	Sat, 26 Apr 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674238; cv=none; b=jSuDHkTq8iSaYVKd3+2muy5FZjDuaijciLqHbPtQqfAvTaKVj3uLVHcctzJVP4CyuRr85uSCWwqIWnnLRJcA0Pih0Pj0SgrGwnDmG20PYuwz+XkeLpyLuTslGuxMztduuVEhQT2lxB6T2DnfLjPm9ty5NMYuL7ebja9D8ymGg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674238; c=relaxed/simple;
	bh=K827jkdV1zwBCcNUq2aRPRtdn0WqO1I3TTuj+q5Ts3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHme2Ny35YsR4e7HzikPPiMRoayIEadnJ2RF2Py9bPSiMK24hDwLhJA9HR8kHqP0risfCahikfVa2e4hiSaTuD82tUeEFIP3WgoRgTmm0l7sF7A4hQwfnpqZlLTYmanceaMR4bgsVuCEdaZl+TEtmKoNKESuamNFn5R8m5kG3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDdgGJaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA132C4CEEC;
	Sat, 26 Apr 2025 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674237;
	bh=K827jkdV1zwBCcNUq2aRPRtdn0WqO1I3TTuj+q5Ts3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JDdgGJaPsm0bFzVCnMaL0+YV/gpyxEpD1OxGJnBOZ3sQpaVPSgDHak4ewTtudpQzJ
	 jFdDafDQHJ9Uvlt9ZNrb3+vCwM6RjQYy5yXPkWjICSqFRS4hgnhggPmyUjX/fCx4yp
	 kM9jXl8mPaJEj+mNaQdKRGXAVlqyKBvwgXgNca4crgrW34P0rYZvr9Mf+2L3zKZfJL
	 0eFKxzv5ZtReGR53E+aFBolQwYQ0qh78v7VBG9xCw2iv6tF7ntoqgd2Lr4yMZuCs/A
	 sgBQ3p5R+Vx6aK1JVD32m0Q6USlqiox1FANS0PJ3jwkmyZPNQu8wjgNRpTzTcqPXde
	 3WbDHrMHtR71g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d09d495c6cso813468fac.3;
        Sat, 26 Apr 2025 06:30:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbjRbq4ASNH3SBemx0iL+ohjYBw5+eVT/aywQ3PdcIW9H4qz8W6eAHd0sEDgHfTYfqx2ZIHuCZNsEHjlI=@vger.kernel.org, AJvYcCUdImfB8TIHg8owaaLvsJGextXDQuR2jH+atgk2gbYa0i5EyOf4CC5sWrVrBJIVlhQkAeosSPA/fxJdA6Q=@vger.kernel.org, AJvYcCV5B9sDQluZJUCN2jJ2V1V5srBivzoUi7Ml36zd4eWLTXmNoqt4G/bZBSVk4JgLLsy4cpWHkZNLmWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpqjkITdJ9IicoI5OULWjFV3mjEzHWQNmWrqqi+g48u/2c3ln
	ouED2SJhPvEhzxCiw9ue5nzT9rA6AvkVSnUturDMCPaxinHVVFq6EUrx84l/QeVdR3Y3BM1abDi
	x8aDrKFuXQb2+9w/NJjkE/i/JsWM=
X-Google-Smtp-Source: AGHT+IEiWI3yojtu+4lFaEnbyWAbSDzO/PB83FZ3LgAebeyovkUwky9ls5b5wQK6vkkZagbi/hGfeVKdmi3kVZ1O8AM=
X-Received: by 2002:a05:6870:56a9:b0:2d8:957a:5176 with SMTP id
 586e51a60fabf-2d9be4fdaffmr1923936fac.5.1745674237112; Sat, 26 Apr 2025
 06:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5891540.DvuYhMxLoT@rjwysocki.net> <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
 <CAJZ5v0iCsd8fdXRdicT7mqsRte39WC+SVjgfz2NHS9QpvSnDdw@mail.gmail.com> <CAJZ5v0iFPf=WT3CjNqtioUoiX9jc5nmZLJnAkQOhBTmGq_ioAw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iFPf=WT3CjNqtioUoiX9jc5nmZLJnAkQOhBTmGq_ioAw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 26 Apr 2025 15:30:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jG7crhwnK0Tr0aswGWDFMc3o5QSPEDfQ+WRo+VPbYJKQ@mail.gmail.com>
X-Gm-Features: ATxdqUHAoMksK2L1eNkdJCS9oDNKxpI8yqtR-TIAHgcVAFMKAjFPBaEZ-e5ngvw
Message-ID: <CAJZ5v0jG7crhwnK0Tr0aswGWDFMc3o5QSPEDfQ+WRo+VPbYJKQ@mail.gmail.com>
Subject: Re: [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume handling
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Apr 25, 2025 at 8:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Apr 25, 2025 at 7:14=E2=80=AFPM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.dev> wrote:
> > >
> > > On 4/24/25 20:13, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > The code in intel_suspend() and intel_resume() needs to be properly
> > > > synchronized with runtime PM which is not the case currently, so fi=
x
> > > > it.
> > > >
> > > > First of all, prevent runtime PM from triggering after intel_suspen=
d()
> > > > has started because the changes made by it to the device might be
> > > > undone by a runtime resume of the device.  For this purpose, add a
> > > > pm_runtime_disable() call to intel_suspend().
> > >
> > > Allow me to push back on this, because we have to be very careful wit=
h a hidden state transition that needs to happen.
> > >
> > > If a controller was suspended by pm_runtime, it will enter the clock =
stop mode.
> > >
> > > If the system needs to suspend, the controller has to be forced to ex=
it the clock stop mode and the bus has to restart before we can suspend it,=
 and that's why we had those pm_runtime_resume().
> > >
> > > Disabling pm_runtime when entering system suspend would be problemati=
c for Intel hardware, it's a known can of worms.
> >
> > No, it wouldn't AFAICS.
> >
> > > It's quite possible that some of the code in intel_suspend() is no lo=
nger required because the .prepare will resume the bus properly, but I want=
ed to make sure this state transition out of clock-stop is known and taken =
into consideration.
> >
> > This patch doesn't change the functionality in intel_suspend(), it
> > just prevents runtime resume running in parallel with it or after it
> > from messing up with the hardware.
> >
> > I don't see why it would be unsafe to do and please feel free to prove =
me wrong.
>
> Or just tell me what I'm missing in the reasoning below.
>
> This code:
>
> -    if (pm_runtime_suspended(dev)) {
> -        dev_dbg(dev, "pm_runtime status was suspended, forcing active\n"=
);
> -
> -        /* follow required sequence from runtime_pm.rst */
> -        pm_runtime_disable(dev);
> -        pm_runtime_set_active(dev);
> -        pm_runtime_mark_last_busy(dev);
> -        pm_runtime_enable(dev);
> -
> -        pm_runtime_resume(bus->dev);
> -
> -        link_flags =3D md_flags >> (bus->link_id * 8);
> -
> -        if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
> -            pm_runtime_idle(dev);
> -    }

Well, I actually missed a couple of things.

First off, the core increases the runtime PM reference counter for
every device in the "prepare" phase of system suspend and it is still
nonzero when the code above runs, so the pm_runtime_idle() call at the
end of it has no effect (the bottom line is that devices don't
runtime-suspend during system-wide suspend and resume transitions,
they can only runtime-resume then).

Second, the argument of the pm_runtime_resume() call in it is
bus->dev, not dev.  I have to admit ignorance regarding the reason why
this code attempts to resume a different device, but this is what
breaks things AFAICS.

The pm_runtime_mark_last_busy() call is kind of fine, but it is
redundant because it is repeated at the end of intel_resume() and even
if the autosuspend timer triggers between these two calls, it will not
cause the device to suspend ("devices don't runtime-suspend during
system-wide suspend and resume transitions").

The pm_runtime_set_active() is questionable because it takes place
before the device is technically activated, so if anything in the
meantime actually depended on it being active, it would break.

So I need to rewrite the changelog, but I still cannot find anything
problematic in the patch itself.

First, it removes some code that had not been run earlier and it
started to break things after it had been allowed to run (and which is
questionable for that matter).  Next, it adds protection against races
that probably don't happen in practice, but if they happened, they
would be problematic.  It also replaces two checks with simpler
versions of them that can be used at this point, nothing wrong with
that.  Finally, it makes intel_resume() call pm_runtime_set_active()
when it is needed because the device actually becomes active at the
end of that function and it removes the setting of a driver flag that
has no effect on the given device any more.

I'm going to resend it with a new changelog as a v2.

Thanks!

