Return-Path: <linux-pm+bounces-22016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A5A33FF7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 14:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7649F188489A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43623F41B;
	Thu, 13 Feb 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfCK7t1q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D723F40D
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452292; cv=none; b=BeKODqilbQsrRZDtCLb7yoMEvPGJiqraHVPQoJYViC+cHlM3xyAvxwKD02bOZVcREd1wldgodewK2eXWESUz9l8dUy9ne0u1hQWK0MgISai9jF9UM9EdqK/huDGOpD3BSNv9YeSwRRWweWarY0e09eJJcHyoX9mKNXuWrk1U5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452292; c=relaxed/simple;
	bh=hsQGDLOWLG7bsVV5A0WVv5C1on4j51W1Qf35hZy+zOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVgEP3FxEJFF2Vo4QMZjnfs34yKyhziksxlz23t8nSy8QQvoGJxZTI0/fzHSiBm3/llXUeUjaX+KOACqWz/PdNqdhgH8+LpvTIZzEoph2N9C3QqvAW2/U9S1vqRWe3lLv041HQkAQqcX2C9T8E9dF9L1qPhEtaPJTHteMKzm/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfCK7t1q; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53a91756e5so712732276.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 05:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739452290; x=1740057090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av+4cXouFvBxiesIKZhu46IuHt9ZeCvayQcIT+brZhA=;
        b=UfCK7t1qdCOCWWMSR1VkJxK1unzNkgq2eXlF9TjEUBWJMjOtGzY/19EKNZ1mWJpEhY
         o2ujzAY8nlNC49yJUc37+W5emDwA2K7BzaNtIFlmDW4Ljr2ZRNBZwghhHtciUXWIT3sz
         Yr19ZKwiZ0Sm0eboaYP4VpTT4PdElm5pgecoRobUIIMaRIhbLR6lMmsM1CTm0qSb1E0y
         t6dWGkOdBkdrWxbQP8ZkHAXHQLDCNrkqwhZc6lOy5cwIMgDihqNaK+h3cmPuLUm7m7kL
         mLGrk9i/+PVRc+xwhbc/3sKDCnUR/weZF8n8Q5+VBB6qTxSDRXc7lO97KRvdIAIYKno4
         suHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739452290; x=1740057090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av+4cXouFvBxiesIKZhu46IuHt9ZeCvayQcIT+brZhA=;
        b=qabKQ3+YAaGKXztSafA8D8rTTyEWfIwI8ln68FV/u8fKzouZdk2sef0owMpYwYtaf+
         e3BXTwmgReLXk4o9suBnCosvDAW5/2SgEjWrU8mdlCgc+DkOfow3eb/cbW1wzbhxImUe
         BDG1GjaJfTG9xle7zg/rRacv2mncUx53kegm4trUPD2RLZGDZ3SUDu/SifD3PQFcHDus
         Mt0b2UyniO3OXmmWp2ol3a63FZefTmN4nk49KxQz1cXKsGWOQd3c77GmLfbjiDwRTvwz
         a/4WaT+dugd+DhmUsy9bR2jN2gNuLOXCGQUTwRxYtg6pzax4VQA+LwEZX/ElT6sjY705
         7Wlw==
X-Forwarded-Encrypted: i=1; AJvYcCXzZTc4p9S150WwKyHfY/AaOqyGBv8kNKWUQleRbYLMYU7xnKnB0MO3lJmQi4nMpzEHwArEgGI5Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWXeGpbqazHioTWfzMrKrT+WKX1IZLB4QMfs90/Bgan3lNW/F
	mbvRuNcwEN+W681UQG72j1YUtLpxy3zEDb/pFedE5rPqmz/5iG6aLiL6ZszxV2S0gcp+r306IuR
	PEAOSNaksNw/02k9tEeOTmiX8/JJh+CrXIA2DeA==
X-Gm-Gg: ASbGncuW9TdMjtfAxRz91AZY8yBG/vQBfDrHTy47Lw8/6ACG5g06DRcpefB+wCEwSW5
	VS0idv3lBekY3dBVjsGV0jfE5YEftzoQDuFK4lf0wQ8ElOlAg5HnlUPT31kcUF4OBrPQwpkxpEA
	==
X-Google-Smtp-Source: AGHT+IHgm7mdZPTihkcGCH8GpaKCczS36kNq4savGYCrbmNbcGY8qk2znocOPE05fuZQ11NbKnUgoPiobR/3luTpXiY=
X-Received: by 2002:a05:6902:1501:b0:e5b:4601:ed61 with SMTP id
 3f1490d57ef6-e5da020b708mr4677952276.17.1739452289718; Thu, 13 Feb 2025
 05:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2314745.iZASKD2KPV@rjwysocki.net> <CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com>
 <CAJZ5v0h44Yxp95pHW+75gk5yWKviLO1_YK_cZNFKaGnid7nx9A@mail.gmail.com>
 <CAJZ5v0iMZ=6YgKR3ZZuiv7DF4=vfoFRonSoXO_zV65oZH2rOgA@mail.gmail.com>
 <CAPDyKFq91JnCFhEuitOJPZtq78-Y3CUy4p0bNE1wK+eYCste6g@mail.gmail.com> <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iuLA9N5Vi-JNa8=uTO-kpsKNsRGKegYnCYLEhAn=nW9g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Feb 2025 14:10:53 +0100
X-Gm-Features: AWEUYZnI88CYMCOiPxLcaQnzQiLgjFghUrHuCSNkCd9YTo-u2Cjsvvfj9YmOIfw
Message-ID: <CAPDyKFr1LmYji1Yh=mrx03eeW8ukFr9rE0hk277iam174TjGig@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] PM: Make the core and pm_runtime_force_suspend/resume()
 agree more
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 at 18:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 12, 2025 at 4:15=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 12 Feb 2025 at 12:33, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Feb 12, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 10:12=E2=80=AFAM Ulf Hansson <ulf.hansson@l=
inaro.org> wrote:
> > > > >
> > > > > On Tue, 11 Feb 2025 at 22:25, Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
> > > > > >
> > > > > > Hi Everyone,
> > > > > >
> > > > > > This series is a result of the discussion on a recently reporte=
d issue
> > > > > > with device runtime PM status propagation during system resume =
and
> > > > > > the resulting patches:
> > > > > >
> > > > > > https://lore.kernel.org/linux-pm/12619233.O9o76ZdvQC@rjwysocki.=
net/
> > > > > > https://lore.kernel.org/linux-pm/6137505.lOV4Wx5bFT@rjwysocki.n=
et/
> > > > > >
> > > > > > Overall, due to restrictions related to pm_runtime_force_suspen=
d() and
> > > > > > pm_runtime_force_resume(), it was necessary to limit the RPM_AC=
TIVE
> > > > > > setting propagation to the parent of the first device in a depe=
ndency
> > > > > > chain that turned out to have to be resumed during system resum=
e even
> > > > > > though it was runtime-suspended before system suspend.
> > > > > >
> > > > > > Those restrictions are that (1) pm_runtime_force_suspend() atte=
mpts to
> > > > > > suspend devices that have never had runtime PM enabled if their=
 runtime
> > > > > > PM status is currently RPM_ACTIVE and (2) pm_runtime_force_resu=
me()
> > > > > > will skip device whose runtime PM status is currently RPM_ACTIV=
E.
> > > > > >
> > > > > > The purpose of this series is to eliminate the above restrictio=
ns and
> > > > > > get pm_runtime_force_suspend() and pm_runtime_force_resume() to=
 agree
> > > > > > more with what the core does.
> > > > >
> > > > > For my understanding, would you mind elaborating a bit more aroun=
d the
> > > > > end-goal with this?
> > > >
> > > > The end goal is, of course, full integration of runtime PM with sys=
tem
> > > > sleep for all devices.  Eventually.
> > > >
> > > > And it is necessary to make the core and
> > > > pm_runtime_force_suspend|resume() work together better for this
> > > > purpose.
> > > >
> > > > > Are you trying to make adaptations for
> > > > > pm_runtime_force_suspend|resume() and the PM core, such that driv=
ers
> > > > > that uses pm_runtime_force_suspend|resume() should be able to cop=
e
> > > > > with other drivers for child-devices that make use of
> > > > > DPM_FLAG_SMART_SUSPEND?
> > > >
> > > > Yes.
> > > >
> > > > This is a more general case, though, when a device that was
> > > > runtime-suspended before system suspend and is left in suspend duri=
ng
> > > > it, needs to be resumed during the system resume that follows.
> > > >
> > > > Currently, DPM_FLAG_SMART_SUSPEND can lead to this sometimes and it
> > > > cannot happen otherwise, but I think that it is a generally valid
> > > > case.
> > > >
> > > > > If we can make this work, it would enable the propagation of
> > > > > RPM_ACTIVE in the PM core for more devices, but still not for all=
,
> > > > > right?
> > > >
> > > > It is all until there is a known case in which it isn't.  So either
> > > > you know a specific case in which it doesn't work, or I don't see a
> > > > reason for avoiding it.
> > > >
> > > > ATM the only specific case in which it doesn't work is when
> > > > pm_runtime_force_suspend|resume() are used.
> > > >
> > > > > The point is, the other bigger issue that I pointed out in our ea=
rlier
> > > > > discussions; all those devices where their drivers/buses don't co=
pe
> > > > > with the behaviour of the DPM_FLAG_SMART_SUSPEND flag, will preve=
nt
> > > > > the PM core from *unconditionally* propagating the RPM_ACTIVE to
> > > > > parents. I guess this is the best we can do then?
> > > >
> > > > OK, what are they?
> > > >
> > > > You keep saying that they exist without giving any examples.
> > >
> > > To put it more bluntly, I'm not aware of any place other than
> > > pm_runtime_force_suspend|resume() that can be confused by changing th=
e
> > > runtime PM status of a device with runtime PM disabled (either
> > > permanently, or transiently during a system suspend-resume cycle) to
> > > RPM_ACTIVE, so if there are any such places, I would appreciate
> > > letting me know what they are.
> >
> > Well, sorry I thought you were aware. Anyway, I believe you need to do
> > your own investigation as it's simply too time consuming for me to
> > find them all. The problem is that it's not just a simple pattern to
> > search for, so we would need some clever scripting to move forward to
> > find them.
> >
> > To start with, we should look for drivers that enable runtime PM, by
> > calling pm_runtime_enable().
> >
> > Additionally, in their system suspend callback they should typically
> > *not* use pm_runtime_suspended(), pm_runtime_status_suspended() or
> > pm_runtime_active() as that is usually (but no always) indicating that
> > they got it right. Then there are those that don't have system
> > suspend/resume callbacks assigned at all (or uses some other subsystem
> > specific callback for this), but only uses runtime PM.
> >
> > On top of that, drivers that makes use of
> > pm_runtime_force_suspend|resume() should be disregarded, which has
> > reached beyond 300 as this point.
> >
> > Anyway, here is just one example that I found from a quick search.
> > drivers/i2c/busses/i2c-qcom-geni.c
>
> OK, I see.
>
> It sets the status to RPM_SUSPENDED in geni_i2c_suspend_noirq(), if
> not suspended already, and assumes it to stay this way across
> geni_i2c_resume_noirq() until someone resumes it via runtime PM.
>
> Fair enough, but somebody should tell them that they don't need to use
> pm_runtime_disable/enable() in _noirq.
>
> > >
> > > Note that rpm_active() could start producing confusing results if the
> > > runtime PM status of a device with runtime PM disabled is changed fro=
m
> > > RPM_ACTIVE to RPM_SUSPENDED because it will then start to return
> > > -EACCES instead of 1, but changing the status to RPM_ACTIVE will not
> > > confuse it the same way.
> >
> > Trust me, it will cause problems.
> >
> > Drivers may call pm_runtime_get_sync() to turn on the resources for
> > the device after the system has resumed, when runtime PM has been
> > re-enabled for the device by the PM core.
> >
> > Those calls to pm_runtime_get_sync() will then not end up invoking any
> > if ->runtime_resume() callbacks for the device since its state is
> > already RPM_ACTIVE. Hence, the device will remain in a low power state
> > even if the driver believes it has been powered on. In many cases,
> > accessing the device (like reading/writing a register) will often just
> > just hang in these cases, but in worst cases we could end up getting
> > even more difficult bugs to debug.
>
> Sure, that would be a problem.
>
> I think I need to find a different way to address the problem I'm
> seeing, that is to resume devices that were runtime-suspended before
> system suspend along with their superiors.
>
> One way to do it would be to just defer their resume to the point when
> the core has enabled runtime PM for them, which means that it has also
> enabled runtime PM for all of their superiors, and then call
> pm_runtime_resume().
>
> This should work unless one of the superiors has runtime PM disabled
> at that point, of course.

Right, so typically users of pm_runtime_force_suspend|resume() from
the regular ->suspend|resume() callbacks would not work, because they
disable/enable runtime PM. Although, we could probably fix this quite
easily by making some adaptations in
pm_runtime_force_suspend|resume().

I am not sure if this approach would have any other issue though, but
it seems like it could make sense to explore this approach. In general
drivers should cope with their devices being runtime resumed if
runtime PM is enabled, right!?

If this works, it seems like a generic and a good solution to me.

Kind regards
Uffe

