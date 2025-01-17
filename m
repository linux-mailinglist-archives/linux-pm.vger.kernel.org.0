Return-Path: <linux-pm+bounces-20614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C9A14E4C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A7D7A35CB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D61F8EF6;
	Fri, 17 Jan 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8Hs4kX1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650B46BF
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112698; cv=none; b=FA0JZlTTrywtbzTpWK4We62Lqdp4CQQSDCfr+pZpNaTzyVYYJErK6pnwcyWTWwxYdlbrlHEm5dB+GbusBlOidg/DeFbNyMOTcTQepD2SmYytahuvHP9ZdFqy6RHEh4qgWvHaKo6f6Q4b5RXFUaOJQSUN/jyOksc1VZUaDffUYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112698; c=relaxed/simple;
	bh=bzvW4EAU0qKLolmQ8kHlU1hznSllKDG/I1jwpw8SfQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz7rK1ahkiukodUQufMfyI794eIIPllzoQKDJ7CWxxAl+1cSiOIJRiuA4Ad0Ehu2G2AlbZMYK7OEEAL/XLfnqvpo9NX4w1y+93mgOVZKG7P95r6PDQ6drZP6AlHIFZbgnTORXvenLdXMjya8ie8ZFdtfvCvVzi5fpnvXsA0oodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8Hs4kX1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so3074193276.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737112695; x=1737717495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TB/Qn3zo0NJioy2yY8z56ftG4qCd5/SxIPc8JAZsEUY=;
        b=T8Hs4kX1f7rminhao8Vu+T2Qyf2Eg4ff1Lum+HMqTmhBvU96Lj8ZlJAnzOqBdvmArk
         zNefSdh1faygivIwejAfdTSSZQAth5+Q+denyTUTrOyxmo9mTbrK7tiPMZebN+8tbK3c
         7NBYjs/XXsR+u1VWpLQYuzcAi8WI6adkaOnZWpJ4equt4hxc4IrAQGu9e/gqDn4NaGZQ
         W0TZ4/ot7pVaKjdzsZg5/QNRzirTINPvGM/uyYHKXgaysGrPqrTNKErPspGYn7RMF+bO
         ynVQHU+deiIIUP9AWd6/pqpl7Rnb6yZsL/k744uVspV6NgZc5np5T82IQ0saF2BEshxH
         TN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737112695; x=1737717495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TB/Qn3zo0NJioy2yY8z56ftG4qCd5/SxIPc8JAZsEUY=;
        b=qyCc4BB8ZAn2EuHOBGq66TjbmTKmNmmVdudaKyTrSypMx0OG+cm6JGT3dQFpysyFRn
         n2hpyMqy33XjR5SpoKrT0UBL7NTzAt48/TV7gbiGm1s0EVn//E/8SdhnJGEe3BVMmjZB
         5qKlcb5ueHP/KrAAmIncbK6ddWWXH6h3LjVo2eT1jhFX1DgCVu/7e6/lUEGQlXTi9ZoC
         mNJBLVKq9zspK7SY0+/Fe21Nvkq3zTFppdoxlbhhULcqKelmGxPgNsQnSLwf0IGX12ce
         ksXy4cWFvkJPQBrzYIq/0ywtC6k95J96kZJX9UuvhXZaiBgODUH1Uf9GUbsTzZ0o/hpt
         l+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF4BKHzTCPMt7RfAgZPDbKnv9sX1knHJpWbaaFER1D7wDc0FFAefI5TRr5SDZzs82IqOX5FNglDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOdQ0e6Y+C08rz0Ih9sWu6TKx4ZfdgUPvIox/cNjdW/0I1tWA
	3aKX7wkGJCkfYukEte8ZicNIF4f16RbEDqdxSPWxnwnmTsXZ+I9+agdMlhpUL9p8nz3vatFydol
	wBB/iISx2Px5Gct0sdYnphF1V/V3DumbtU6eLm8wWSoS+sJ0M
X-Gm-Gg: ASbGncvree33cHYAap48Ej1DFPJqKD8GW9/TYLoOdIevV4WCsuQn0oiN2e5SZCAQhhj
	5YF7UVoKZ2QVDw91ehfOj4d2dEiT5J9nqUSoAfBs=
X-Google-Smtp-Source: AGHT+IG7ZhWGWT7mNVj/qn/vvAV+YPcm8SpcQ42x5ZTwtOsgQdVXdchj0b54RlqT/qw3z231h0F06HHp1U70evipNG8=
X-Received: by 2002:a05:690c:7345:b0:6f6:d01c:af18 with SMTP id
 00721157ae682-6f6eb677b94mr15324937b3.11.1737112694916; Fri, 17 Jan 2025
 03:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115113931.1181309-1-sudeep.holla@arm.com>
 <CAPDyKFrrdkBAPBw5JOv5HLnOj2L=6ZjE+O7h8N3MFC64ebcNEg@mail.gmail.com> <Z4kz5MvjSCK6KTT0@bogus>
In-Reply-To: <Z4kz5MvjSCK6KTT0@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Jan 2025 12:17:39 +0100
X-Gm-Features: AbW1kvbS2Uj3sXMZi7mmT5gF9xljbSE0gR7ZS64KJV2turIzwP407Zx5B8tOyhA
Message-ID: <CAPDyKFohsfyQXkZfyK1gX=_gWnu6J1RwpFe7S1O4nP9vT2AC8A@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request
 to set the current state
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org, 
	Cristian Marussi <cristian.marussi@arm.com>, 
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 17:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jan 16, 2025 at 04:54:44PM +0100, Ulf Hansson wrote:
> > On Wed, 15 Jan 2025 at 12:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On a system with multiple active SCMI agents, one agent(other than OSPM/
> > > Linux or bootloader) would request to turn on a shared power domain
> > > before the Linux boots/initialise the genpds. So when the Linux boots
> > > and gets the power state as already ON, it just registers the genpd with
> > > a default ON state.
> > >
> > > However, when the driver that needs this shared power domain is probed
> > > genpd sees that the power domain status is ON and never makes any SCMI
> > > call to power it up which is correct. But, since Linux didn't make an
> > > explicit request to turn on the shared power domain, the SCMI platform
> > > firmware will not know if the OSPM agent is actively using it.
> > >
> > > Suppose the other agent that requested the shared power domain to be
> > > powered ON requests to power it OFF as it no longer needs it, the SCMI
> > > platform firmware needs to turn it off if there are no active users of
> > > it which in the above scenaro is the case.
> > >
> > > As a result of SCMI platform firmware turning off the resource, OSPM/
> > > Linux will crash the moment as it expects the shared power domain to be
> > > powered ON.
> > >
> > > Send an explicit request to set the current state when setting up the
> > > genpd power domains so that OSPM registers its vote in the power domain
> > > state with the SCMI platform firmware.
> > >
> > > The other option is to not read the state and set the genpds as default
> > > OFF, but it can't handle the scenario on certain platforms where SCMI
> > > platform keeps all the power domains turned ON by default for faster boot
> > > (or any other such variations) and expect the OSPM to turn off the unused
> > > domains if power saving is required.
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Link: https://lore.kernel.org/all/Z4aBkezSWOPCXcUh@bogus
> > > Reported-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > > Reported-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > I read up on the discussion and it looks like there is not really a
> > simple solution here.
> >
> > In principle if a boot-loader wants to do a handover and leave the
> > power-domain powered-on for the kernel, the additional call to
> > ->state_set() *could* bump the usagecount in the SCMI FW, forever
> > leaving the power-domain on.
> >
>
> IIUC, the refcount in firmware differs from the one in the kernel. It is
> refcount per agent i.e. it is really just a kind of boolean to indicate if
> the agent is active user of the resource. So if the bootloader and the Linux
> being the same agent request to be turned on without a request to turn off
> doesn't mean the refcount is set to 2 and Linux needs to turn off twice.
> This is just my opinion and understanding.
>
> > I guess this problem only exists for power-domains being shared across
> > scmi agents. Perhaps some kind of configuration flag can help us to
> > determine what to do?
> >
>
> While I can't disagree, there is also a thought that OS shouldn't be aware
> of that detail for equally valid reasons. I am not sure if we can get that
> added in the spec.

Okay, it seems like $subject patch is the way forward at this moment.

I have applied it for *next* to allow it to be a bit more tested
before we decide if this is material for stable kernels too. That
means we may have to send the patch to stable maintainers manually to
get it applied.

Kind regards
Uffe

>
> > > ---
> > >  drivers/pmdomain/arm/scmi_pm_domain.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > Hi Ulf,
> > >
> > > We need your feedback or suggestions for better solution on this matter.
> > > Let us know if we can do something better with the genpd's help to resolve
> > > this issue.
> >
> > At initialization, genpd tries to get the correct state of the HW. If
> > the power-domain is on, genpd believes that it will stay on until it
> > requests it to be powered-off.
> >
>
> Agreed and it is right. I don't think that should change.
>
> > That said, I know we have FW's that aren't capable of informing us
> > about the power-domain's current state. For this, I (and Abel Vesa)
> > have been exploring how to introduce an "unknown-default" power-state,
> > which would mean that genpd would request on or off the first time
> > there is a transition of the genpd's power-state. This is on my TODO
> > list, perhaps that is something that can help here too?
> >
>
> Ah interesting. But I still can't get my head around how this fits with
> in with the existing 2 extreme use cases. One where f/w leaves everything
> on to speed up boot(which is fair requirement) and one where OS is expected
> to turn on when it needs a resource(which is ideal but may impact boot time
> loads of power domains needs to be turned on.
>
> IIUC if we initialise it to unknown state, we will issue ON request when
> we use the resource in the kernel and OFF when we are trying to power off
> unused on. It may defer the request to the firmware and is move this hack
> away from the genpd provider driver into core to deal with this "unknown"
> state. Sounds not bad to me if it is feasible to implement.
>
> --
> Regards,
> Sudeep

