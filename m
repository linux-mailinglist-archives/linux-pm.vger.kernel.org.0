Return-Path: <linux-pm+bounces-21953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170BA3241B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC991188A203
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E780209F2A;
	Wed, 12 Feb 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+i7e48A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8303206F2C;
	Wed, 12 Feb 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357953; cv=none; b=jL6jQqoMswfCvYF9IEFQ7r3AuhbXVwHyANMM3Lb+MXqPUgHVW9Ea5Vgw57ulIwvQUocHrDLduO/C8Pd3s1a//3qoQN4Xh32z4Cob6raKaSkpfyyo2GvQGlIzMmgR8Ve5XwqP3QGWVQc6ua28WJ42nGjhAbTPaQiZbRq1ntNXPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357953; c=relaxed/simple;
	bh=6ynvjwiirw9pMPqaFmUszoi8riMDvjaa43Q0OnomhyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQRdRiV6JS/5RZEPsPtEqjjwiDLmur2pQJMOMKAkIA2RCzd+aTB8QRygs65DpY24+GNS/n34sG/4Yf0qGdkCOqj93b8W3llIRvHRkPV5Yz2d7q3ECEZwVpipe6V30ZjqeMsoDEfWX1WGgH1d72lUv4B3+UCqnLERFmfJaEfknnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+i7e48A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC8C4CEDF;
	Wed, 12 Feb 2025 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739357953;
	bh=6ynvjwiirw9pMPqaFmUszoi8riMDvjaa43Q0OnomhyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I+i7e48A18OPZ7QAL7RlpiB+2HBjm7fKAEJG2P4o4hm10eY1DB/8aLTIL59Q848cq
	 wQOhwOR6Vym90bja0VZT9/TeyZxpuXyxG5tM4nXGFqdJqBJ1f1IPN0+4a+J50+cqAD
	 e1DqC0XHa02wH8JgMvGDGKAz2yEZqm0PQKhOYdlnPf6Jp+/kpnYC4Fqh5ZSvLmNWyu
	 rDXTniMapqot6GwsVx8hSHql+lihgCNPPVN7OXGTdg1o7/7f1xW3ymsuHWcNsUuMLN
	 OYpnF2r+UMjQTWwzVO9I2CjPhXITvsgnGwchcw4e3lU0APuyST7sv7wrVrykB1r2V8
	 sYU15cHoLTTig==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29fe83208a4so432052fac.0;
        Wed, 12 Feb 2025 02:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7DOdLTX2hdF/E/6OfJnGczaoFP7UrhGijBeZkf8dZq9lEYG4o63Ynl7nr+bIMv6GFHX2LhMqNIJI=@vger.kernel.org, AJvYcCX2dNVhtsmm94MsI5Z/HyXnOneobiXKtr7yoaka4prlzRjc5rb8ingRwxebrPRv7lRynY5gAvnKTqO+Kac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwR/hnRf2KssHv5/yRkcwfuamQyjpiw/R8w63aqFLGAoTmJB4
	SjQAIyW++Xo9eGy4laRZVRNqSQckF13xh32b6EG0P50sHW6VsaJAA0BoI93S3rZMmilre6kLk2W
	ZlTQvMAGDHgZ7HJyizJY+EM0G/Mk=
X-Google-Smtp-Source: AGHT+IG8QKAMUrvf7UKtROR6aDoc2C+w6x3rW2FjrqQKNmgcv5Enubi24yKLLGjLSma4ad+RujMSCIDPV2yBLz/vRGs=
X-Received: by 2002:a05:6870:9a21:b0:2b8:a5a9:c615 with SMTP id
 586e51a60fabf-2b8b6d5f653mr4471213fac.3.1739357952589; Wed, 12 Feb 2025
 02:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
In-Reply-To: <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 11:59:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
X-Gm-Features: AWEUYZnUZ89kR8nnk8jl2vFBp3d8Lo9uDbYIeRM2O4NyovM9vBRPbcJB9RpaZBU
Message-ID: <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > Hi Everyone,
> >
> > This series is a result of the discussion on a recently reported issue
> > with device runtime PM status propagation during system resume and
> > the resulting patches:
> >
> > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.net/
> > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.net/
> >
> > Overall, due to restrictions related to pm_runtime_force_suspend() and
> > pm_runtime_force_resume(), it was necessary to limit the RPM_ACTIVE
> > setting propagation to the parent of the first device in a dependency
> > chain that turned out to have to be resumed during system resume even
> > though it was runtime-suspended before system suspend.
> >
> > Those restrictions are that (1) pm_runtime_force_suspend() attempts to
> > suspend devices that have never had runtime PM enabled if their runtime
> > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resume()
> > will skip device whose runtime PM status is currently RPM_ACTIVE.
> >
> > The purpose of this series is to eliminate the above restrictions and
> > get pm_runtime_force_suspend() and pm_runtime_force_resume() to agree
> > more with what the core does.
>
> For my understanding, would you mind elaborating a bit more around the
> end-goal with this?

The end goal is, of course, full integration of runtime PM with system
sleep for all devices.  Eventually.

And it is necessary to make the core and
pm_runtime_force_suspend|resume() work together better for this
purpose.

> Are you trying to make adaptations for
> pm_runtime_force_suspend|resume() and the PM core, such that drivers
> that uses pm_runtime_force_suspend|resume() should be able to cope
> with other drivers for child-devices that make use of
> DPM_FLAG_SMART_SUSPEND?

Yes.

This is a more general case, though, when a device that was
runtime-suspended before system suspend and is left in suspend during
it, needs to be resumed during the system resume that follows.

Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and it
cannot happen otherwise, but I think that it is a generally valid
case.

> If we can make this work, it would enable the propagation of
> RPM_ACTIVE in the PM core for more devices, but still not for all,
> right?

It is all until there is a known case in which it isn't.  So either
you know a specific case in which it doesn't work, or I don't see a
reason for avoiding it.

ATM the only specific case in which it doesn't work is when
pm_runtime_force_suspend|resume() are used.

> The point is, the other bigger issue that I pointed out in our earlier
> discussions; all those devices where their drivers/buses don't cope
> with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will prevent
> the PM core from *unconditionally* propagating the RPM_ACTIVE to
> parents. I guess this is the best we can do then?

OK, what are they?

You keep saying that they exist without giving any examples.

