Return-Path: <linux-pm+bounces-15497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A37999499
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1712284C58
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE41E1A23;
	Thu, 10 Oct 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BByj7kYW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80028F6A
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596675; cv=none; b=k4Dbhdf5nt1Qud14N9Dx4Mjw0O84PMv77IID2B6u8H2bPsxeLAbe3Im2WciJ1Zqh6C6jpaxKg6p9rZq8DsuaChVLn2mqZp2S0C4TAI+M/bXC+BY/fTr+vYMPXyEGQeOQ7MNcFro4+4axWfvwq+/lQzCbHPknn8LXUASmj7FqztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596675; c=relaxed/simple;
	bh=AcSuf/vPOT9tcrdfVuyWUs/nU36TWjtWhqEsOkTBf6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psrAEKBiSYknoPqvpGALpqyXcwo3l1+USxpQmHWo9ifbPqkN8fTP+/YbifcWuRijBgc3p8mUUjBUEwYTdN9eai6W/e8oov4T2imvo+ZRQGzcmGQ8no3LdiR9qLHzesNwMGMxYaeoIzUe4CTgvV/b2b7lUhrjErmkn0w69RQvyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BByj7kYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BD6C4CED0
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728596674;
	bh=AcSuf/vPOT9tcrdfVuyWUs/nU36TWjtWhqEsOkTBf6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BByj7kYWr6v1AYC0PpS/wTMPryUM99SC5xpsRL3+IR/8CU60Wtf0Dz2YWoxK9IfuI
	 NGxg0jehRnLqOJaUHi5sFg41OAtDWxyWXDYlbL2oeHNuQNpKrZDNRcRgt56U5SDIYV
	 ncesf+pvf6yp6Q2yphSnXC+1yJ5f19/Mi00dWPQbOAbwa7Vd3FZ3BPcChvZUel8pUu
	 C47q33m+VPwG00nzICHsyJ+Tnb0zstzqwzLBZBNNokjkGDPaoJvura/PrCjwhvWk6z
	 E8InsePTvoTOoOk+hxWV3r4H1jUy0tZ/LCe6Jac9TZ2YXxa2kZAg1P3DNHhT4tYRSJ
	 UiHDjFxVPx2Nw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e4444b0788so902252b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 14:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTWtMRlcW4Rd4RhAIg36e8JS4iMnIkbPYO+wgEAC+HwhzFaQnfy2GHAnd+/apRWgxRNoz7SHgnvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNXIhzrQCgeZCemkg8JjPwKtkBTDSVJI7Vu87aAC2uA663Stf
	49utg518doTThJggJ05HXo18zE1sfQ/KhgLbYlJppaJUKB93xG1zNPZcu+G4HoTeYR9yxMN1uCG
	z8u9/7SF/KTjRZ9pssfof+87wN6s=
X-Google-Smtp-Source: AGHT+IE7p/kIgeXrs0GvEiAOUPA4iQg9W6ZwMYzWxstWg3J26yClZVVQp7xfzhPzUK45aJHFHKdFbsByRDWomkB8HGI=
X-Received: by 2002:a05:6808:1b2a:b0:3e4:d7aa:dfc9 with SMTP id
 5614622812f47-3e5c9144ac1mr408325b6e.46.1728596673718; Thu, 10 Oct 2024
 14:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
 <20240923100005.2532430-2-daniel.lezcano@linaro.org> <CAJZ5v0i9N_ie_duMXYSumQSnFDVxHj1h1ikSyrApJyEjXs_mQg@mail.gmail.com>
 <CAJZ5v0jCOHAmpmniVRuGCrtvKj6+YtCKidKSJf1t+HitwpKrwg@mail.gmail.com>
 <d9682276-1068-4b90-8478-bf1f5047d306@linaro.org> <CAJZ5v0iUYnJi61TAaUz5exRhH7fjwDSXCCeVVUQgm80L-ujfnw@mail.gmail.com>
 <bb4741a1-0a1a-42a9-b71a-0ecd9d34b231@linaro.org>
In-Reply-To: <bb4741a1-0a1a-42a9-b71a-0ecd9d34b231@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Oct 2024 23:44:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jWFrs4XQLSG9r_WeMTHsRZWdvqXv4C_snBPAE2DFSJOw@mail.gmail.com>
Message-ID: <CAJZ5v0jWFrs4XQLSG9r_WeMTHsRZWdvqXv4C_snBPAE2DFSJOw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] thermal/core: Add user thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:44=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 09/10/2024 17:59, Rafael J. Wysocki wrote:
> > Hi Daniel,
> >
> > On Wed, Oct 9, 2024 at 5:40=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >> On 02/10/2024 14:22, Rafael J. Wysocki wrote:
> >>> On Tue, Oct 1, 2024 at 9:57=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>>>
> >>>> On Mon, Sep 23, 2024 at 12:00=E2=80=AFPM Daniel Lezcano
> >>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>
> >>>>> The user thresholds mechanism is a way to have the userspace to tel=
l
> >>>>> the thermal framework to send a notification when a temperature lim=
it
> >>>>> is crossed. There is no id, no hysteresis, just the temperature and
> >>>>> the direction of the limit crossing. That means we can be notified
> >>>>> when a threshold is crossed the way up only, or the way down only o=
r
> >>>>> both ways. That allows to create hysteresis values if it is needed.
> >>
> >> [ ... ]
> >>
> >>
> >>> I'm inclined to apply these 2 patches with the change mentioned above=
,
> >>> so that I can base my 6.13 work on them.
> >>
> >> I was expecting you to pick these two patches and do the modifications
> >> but I don't see them in your tree. Did I misunderstood your comment?
> >
> > That's still the plan, I've been waiting for you to respond and confirm=
.
> >
> > I gather that this is OK then.
>
> Yes, it is ;)

Applied now, sorry for the delay.

