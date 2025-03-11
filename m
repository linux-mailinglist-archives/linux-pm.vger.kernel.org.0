Return-Path: <linux-pm+bounces-23890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8BA5CE34
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DE77A91E0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A02627F7;
	Tue, 11 Mar 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGUlA8lk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314125F985
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719084; cv=none; b=chNZNX7AP+EoBSORt/ZGj71l8dZxhRJiWGtCBnSYznXpV3MqIZzPNPSZXhC6ikKlC3PFe3NmZkTRI7CJmJ9fDqAOiEeN3b66nUwMls15Omuc+CPtdakfq4aR5y4TLm8xv6SaRZgex46n9jqiD6IKriXk9d3JjOOdPBVp5a8fH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719084; c=relaxed/simple;
	bh=P0IzPlmJU7/AcP238xWshcoWQ+jNiaGjJQtq27gLnI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOHvIZQiKZ2lXkTpTTPhcVuJQZOzjtfrGURJ7aIOfyLmXsew0QTLTg1Pb3EfH0Kb7fxKp+98wan+cMokX9vGFctBFoFHRZ48GTyf23V8suDMDtbGeGZmu9KFxZPq5yNvixgYGKRixrYljyClPx7e3VV8DuTFZxdqVLt3GEz81CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGUlA8lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B61C4CEEC
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741719084;
	bh=P0IzPlmJU7/AcP238xWshcoWQ+jNiaGjJQtq27gLnI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LGUlA8lkl00mVKjfKbHEeuX88DrdcnGkKlVRMUsD3epAXikXC4iiNHUbJ3ayjmsa8
	 3VUqPgYY9CysOa3aFT9eXrs2Se0224mjFdZFJaod/g0P6YfR9Vyha1v4rnq/zNw+B5
	 BQ0chKdmzvRZ22UJ4+LcTSLD5malvPnxAFdIxOJQgjCPzTC/CBhJmTl3y+sPLYAADb
	 sOnnNgZS1ioOSA+2CowyVxNIHUXgSBRAxO2pkp3VsblDFaxNlXUuAd7mQBBYn6TvgS
	 Swi3NbM2OAiuLqPvhs4VELportbZD02KNacqpQuyLGXrLnrklKpas3C12Y0Lh6tXT2
	 MCOV3zo/gONVg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fe86c16f5dso2654176eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 11:51:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrbz2MSok9LPc1JtDvRdhcTVRmFIdvoTrBopeHFlXWnGQQHLF+QdBLcMmeJ0LxCBLy3SlBez+7wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO+lHYh3REPsu30udIrxbA8GKZzt6rT+xkSaOpbvxlHRpwKS0
	qsazSOFFiMzDbfUnAsSCn3O1nwfwP1FnwEEGfrive5nB0Xht0hy0wd+lVtY6BjZZDl28XcMzdtN
	iJRoxIczNa/GYrLFZDvFSdX6mSFM=
X-Google-Smtp-Source: AGHT+IE3LLEbtcl5BXhLpwGwESUQ0dSrCftmcewcRsq7ieC/bha0gDw2SQNnbB53FOpuztMMUAgpcQwL/Rsuy2RLUO0=
X-Received: by 2002:a05:6870:d14d:b0:2c1:4e25:e67d with SMTP id
 586e51a60fabf-2c2e8935865mr2565661fac.24.1741719083440; Tue, 11 Mar 2025
 11:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
 <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com> <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
 <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org> <CAJZ5v0iJTB_JTb9YMVBCjd=iOPuCRdNQNLS7wXwHRD4kz5h-Og@mail.gmail.com>
 <03c2833d-d80c-4146-911d-8d1a524a2b13@linaro.org>
In-Reply-To: <03c2833d-d80c-4146-911d-8d1a524a2b13@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Mar 2025 19:51:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hH+YUKvq8inVacwhuR_hC2jquttWNuc3nBdYRCP_R8dw@mail.gmail.com>
X-Gm-Features: AQ5f1JqJpY_n_P9HnAdRJdF7Z4hS0yV9j0Kg3A-rdhkWaAK74nHuyyINSEZdgDM
Message-ID: <CAJZ5v0hH+YUKvq8inVacwhuR_hC2jquttWNuc3nBdYRCP_R8dw@mail.gmail.com>
Subject: Re: TEO as default governor ?
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:42=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/03/2025 19:26, Rafael J. Wysocki wrote:
> > On Tue, Mar 11, 2025 at 7:00=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 11/03/2025 18:34, Rafael J. Wysocki wrote:
> >>> On Tue, Mar 11, 2025 at 5:47=E2=80=AFPM Christian Loehle
> >>> <christian.loehle@arm.com> wrote:
> >>>>
> >>>> On 3/11/25 16:31, Daniel Lezcano wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> I think we can agree the teo governor is better then the menu gover=
nor.
> >>>>>
> >>>>> Would it make sense to make the teo governor the default governor ?
> >>>>>
> >>>>>
> >>>>
> >>>> Rafael's position seems to be quite conservative here.
> >>>> Fact is menu is still the default on many systems.
> >>>> Even worse, the really bad performance disadvantage when
> >>>> using menu in an intercept-heavy workload has been fixed by Rafael :=
)
> >>>> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@ar=
m.com/
> >>>>
> >>>> FWIW I proposed this a while ago:
> >>>> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loeh=
le@arm.com/
> >>>
> >>> It will help if one can make a really convincing case for this change
> >>> (that is, show that menu with the most recent fixes included is reall=
y
> >>> significantly worse on their platform).
> >>
> >> For all the platforms I've been testing, the teo governor is always th=
e
> >> best one.
> >
> > Great!  Can you please share any numbers?
>
> There are some at a publication doing an evaluation of the irq
> prediction [1]
>
> >> Using the menu governor has also an impact on the user experience as i=
t
> >> lags on mobile.
> >
> > Well, I'm not quite sure what you mean here?
>
> For example, the user feels the lag when touching the screen on a mobile
> or scrolling a document. Changing from menu to teo solves this issue.
>
>
> >> After studying the history of the menu governor few years ago, it
> >> appeared the menu governor was introduced before the SMP was widely
> >> used. The strength of the menu governor was the ability to find
> >> repeating intervals but with he multiplication of the cores, the IPIs
> >> were introduced which increased the entropy of the busy-idle cycles
> >> duration, thus making the duration much more random and altering the
> >> menu governor prediction accuracy.
> >
> > While this arguably is the case, menu has also been changed quite a
> > bit since its introduction.
> >
> > What I'm looking for really is a set of numbers showing the difference
> > and clearly pointing out that teo should be preferred.
>
> Ok, let me check if I can find a platform doing energy measurement.
>
> I guess x86 is not a good target as the firmware overcomes the kernel
> decisions right ?

In many cases, yes, it does.

You basically need to disable the feature called "C1 demotion", please
see the recent patch series from Artem adding an interface for this:

https://lore.kernel.org/linux-pm/20250220151702.2153579-1-dedekind1@gmail.c=
om/

