Return-Path: <linux-pm+bounces-26463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7429AA4E6E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 16:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B923B0F2E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555325A632;
	Wed, 30 Apr 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOjh4U6t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D221ABC6;
	Wed, 30 Apr 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023063; cv=none; b=d/tdlI+UUdVJfocf0BLIUBgA2K7xgoCR08o87CN/EEwn6vDRWjXhXzKWZPXLFwRPeuetVHlF6VrGeaSStwXfnznoglHTRgOb2OXUV86CfQ2GG3IbnTcjpg/SqwDjSiAaPPKhbRjylBb1hz1EPJzpTk17n5fblzXtFCa6TDDQvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023063; c=relaxed/simple;
	bh=DiilKaJG0/WO35VO8ryl3whyZcAVo/+1zf6kcyc7JZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OolZoDbwewqfKiytdm1f3WgGtZk1huk9hsJipXcd8udBiNcf6QiDOyGP6l0zi1kchKsp2SqGcvoo+JAl49OnHUZJIB0nuBhCHy+aztkF/Rx4E+XyPW5Spl1RZ+vRGDEPOSUT6N90mSgqt2ldBthR/qhTVEQrOiHQ0kt9LeTP8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOjh4U6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EFEC4CEE9;
	Wed, 30 Apr 2025 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746023062;
	bh=DiilKaJG0/WO35VO8ryl3whyZcAVo/+1zf6kcyc7JZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oOjh4U6tWSyBrn74QNMejxT6f/5QGbKaTcekHDUUDRgdze7OsjPLO8rJd9rLfM9j2
	 dWNs0m4q9+cEJwlrFqgxvVgcf53Gr/+49IxPk2xs7wv+7aChyVDKc/J+aSqomecaXU
	 HttNVrIK/tBYmu2tr4reQ9BTuuOScwgtJRXXKq5QW5hRq+IpUcbsn4axXo6nf9RKHp
	 kDWzI4aq2MwTqtHjT+AE1IH/G51ZwOpc/uWym2cK7w7KRzPsnLUUckcuibIlyuh9Rl
	 +A1tSSy+8dfAvHWnLJZJPcJLb7wGTXStrCql+2+RgU+OjC9dxDxWTxdss60OTMu9tg
	 psoGsl4itI3Uw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so678657fac.0;
        Wed, 30 Apr 2025 07:24:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWGBP4i4EHoWnF1cENkAZ/eJjNY0gskXug8B82T9sVW0iBpsJ/3Usf7Nd3v5MHnznNxZ+4DGioUYyilq0=@vger.kernel.org, AJvYcCVYZqVnexTBNGYFO28iPWB/HA2kKuniAiiJJPpJrDc5h7tRr85zZYHi9RsMYcjVQUQLIm2sHPuVXeY=@vger.kernel.org, AJvYcCXOosLdWCm2IGJB44ljhFSwxmWe57VOIQ3AHtzv9YVJb1gJn9IR7Pv5sVjSZCO7bVUhUyBQ6osDfyNHeLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpl+aVQrnwY6jb5la+wW3tqe27vY0Vryzwm9Rl/FYBax0gHif5
	jyXyQS4AxJC30Q47c3WpEaA0uHepRSSt0gGrL/yVnBANbFoXsO/GhFUs8nsgPn5ssa5ym3hcD31
	+DoUTRslU1hTeypqFIcXyLgl+Hlc=
X-Google-Smtp-Source: AGHT+IHI21hvZo5h8zBeQ4iz7Vk+x6EUW3fSjt0GGJli/RFF4twaJgW3jOs5FPheFilXL7iC2g4xzqMaMWypSx8BqdU=
X-Received: by 2002:a05:6871:8913:b0:2b8:5a6a:6f5f with SMTP id
 586e51a60fabf-2da6b5b1622mr1876941fac.19.1746023061756; Wed, 30 Apr 2025
 07:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12680420.O9o76ZdvQC@rjwysocki.net> <d4cafb3f-2045-40c1-a8fd-58dd46485232@linux.intel.com>
In-Reply-To: <d4cafb3f-2045-40c1-a8fd-58dd46485232@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 16:24:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gam8XmtwJ+8yp75EXmCXPrd3twSC_d39aMWw23YdCxfA@mail.gmail.com>
X-Gm-Features: ATxdqUHrtNP14h5bQQ1DruxfhiAAPaU6Kzuw40KNrqPp7z8XoIpCAe9R856-66U
Message-ID: <CAJZ5v0gam8XmtwJ+8yp75EXmCXPrd3twSC_d39aMWw23YdCxfA@mail.gmail.com>
Subject: Re: [PATCH v2] soundwire: intel_auxdevice: Fix system suspend/resume handling
To: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:59=E2=80=AFAM Liao, Bard
<yung-chuan.liao@linux.intel.com> wrote:
>
>
>
> On 4/29/2025 3:50 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Before commit bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND
> > conditionally") the runtime PM status of the device in intel_resume()
> > had always been RPM_ACTIVE because setting DPM_FLAG_SMART_SUSPEND had
> > caused the core to call pm_runtime_set_active() for that device during
> > the "noirq" resume phase.  For this reason, the pm_runtime_suspended()
> > check in intel_resume() had never triggered and the code depending on
> > it had never run.  That had not caused any observable functional issues
> > to appear, so effectively the code in question had never been needed.
> >
> > After commit bca84a7b93fd the core does not call pm_runtime_set_active(=
)
> > for all devices with DPM_FLAG_SMART_SUSPEND set any more and the code
> > depending on the pm_runtime_suspended() check in intel_resume() runs if
> > the device is runtime-suspended prior to a system-wide suspend
> > transition.  Unfortunately, when it runs, it breaks things due to the
> > attempt to runtime-resume bus->dev which most likely is not ready for a
> > runtime resume at that point.
> >
> > It also does other more-or-less questionable things.  Namely, it
> > calls pm_runtime_idle() for a device with a nonzero runtime PM usage
> > counter which has no effect (all devices have nonzero runtime PM
> > usage counters during system-wide suspend and resume).  It also calls
> > pm_runtime_mark_last_busy() for the device even though devices cannot
> > runtime-suspend during system-wide suspend and resume (because their
> > runtime PM usage counters are nonzero) and an analogous call is made
> > in the same function later.  Moreover, it sets the runtime PM status
> > of the device to RPM_ACTIVE before activating it.
> >
> > For the reasons listed above, remove that code altogether.
> >
> > On top of that, add a pm_runtime_disable() call to intel_suspend() to
> > prevent the device from being runtime-resumed at any point after
> > intel_suspend() has started to manipulate it because the changes
> > made by that function would be undone by a runtime-suspend of the
> > device.
> >
> > Next, once runtime PM has been disabled, the runtime PM status of the
> > device cannot change, so pm_runtime_status_suspended() can be used
> > instead of pm_runtime_suspended() in intel_suspend().
> >
> > Finally, make intel_resume() call pm_runtime_set_active() at the end to
> > set the runtime PM status of the device to "active" because it has just
> > been activated and re-enable runtime PM for it after that.
> >
> > Additionally, drop the setting of DPM_FLAG_SMART_SUSPEND from the
> > driver because it has no effect on devices handled by it.
> >
> > Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditional=
ly")
> > Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: New changelog
> >
> > Since it fixes a recent regression in 6.15-rc, I can route it through t=
he
> > PM tree unless that would be a major concern.
> >
>
>  Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Thanks, applied.

