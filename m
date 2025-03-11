Return-Path: <linux-pm+bounces-23888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF91A5CDDD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C2A7A97A9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574C260A43;
	Tue, 11 Mar 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+V+sCcl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CB41C72
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717588; cv=none; b=NEeQc2tliJ1r/XVcTphnWhnWBk3qMYn5y0KymHd0whA4WovJ4p49g1HAEgB8QOZN+HWZyP/PLHzU3M4YHDlkKtvbb2InxcVseqp7E6yJazGL/rcS0Zo3jrldubvNqElo2mnKWTx9mf/7OXj0liusNw/22SuUyg5jumEA2KLGlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717588; c=relaxed/simple;
	bh=9LpSijtkyx/1BYJQ/3eIwyzqsfSZV6/+4O91FnQiaAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Soq5IZx2S4oVOM4inDe9GraG/Z0HfuLBpHmqKLB64uF6Xx44BM8kDbH1yTDt1tUoh+HY4a67IIcOOMY/4OxfLvDycnmP2GDoKkmz1p9yz9lJB2E1DctHB9Br0xoJGtyqhFE4yduVNUKwV5c8TDJA0ZChOdcK3t4IHXkzdMNg49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+V+sCcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1588BC4CEF0
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741717588;
	bh=9LpSijtkyx/1BYJQ/3eIwyzqsfSZV6/+4O91FnQiaAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a+V+sCclqvYeKyKDmvqBE0mFqMNH0Ou348D5E/EghSj3BjbpyNhTmPwPwHoa6tSwU
	 rAfl8gMZVPHCeFaA0XYOYplUz6L3DIvM49GnneILFXWSWnBz7knjjkLFMeIGo34Mnh
	 6j6ePqGVOD/yV8znq96P3Sv3Izxx+pVZ2vMuzvpzZQpkjGhBMj59XPpIjNzAimP9Eb
	 W3XqWHN+cNsR9hxUGNvO5hyaqEVK+Ck+ajqJpEO4wEsO8HD0Y05Vhtrn+xz0+/VvQX
	 TFibeThmXdC+hClwtFCpJQXW6phnTUgRAGo6A9on5P/wbICCfPfLTe7kMjCGTKHPi7
	 bfR5jb0JTh0Jw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso2713594fac.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 11:26:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5zMPeF72W3xCJlOvYoAcByfiYAC0JjN3XvCQpq05+po9H5xTArNS/N9RXq92RZFAlGf8J0Y3RQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj5f8/RIC+Yu7oggpwXCW4z7gqStFJnTWDQRkL+G/ujqvPGwn
	dVau9CzQRvCDSabbazzyxuu/5Jjuw6MTjpBgo6aBBXFrPnvHpXmqNalAOti1vKNUJMsOvxOEM+F
	1jGspqlZ/ZlxRil7Nnl7U+TLbcGw=
X-Google-Smtp-Source: AGHT+IGY3A9f4xXTDJA2gsgBlY+ghf/ba7IkpcgACDj2pG3RkeHBBD+LIX5YQ7kAn/p7rZSRqbcvAfxsXB50u2o5NMw=
X-Received: by 2002:a05:6871:7887:b0:2c2:542b:bcdb with SMTP id
 586e51a60fabf-2c260f869a7mr8843178fac.1.1741717587235; Tue, 11 Mar 2025
 11:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
 <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com> <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
 <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
In-Reply-To: <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Mar 2025 19:26:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJTB_JTb9YMVBCjd=iOPuCRdNQNLS7wXwHRD4kz5h-Og@mail.gmail.com>
X-Gm-Features: AQ5f1JoHH3vtzez3q4RuMhApJEDFl8aC7sZVF1XqRFg5-B4slL9huq9jBuaVbIY
Message-ID: <CAJZ5v0iJTB_JTb9YMVBCjd=iOPuCRdNQNLS7wXwHRD4kz5h-Og@mail.gmail.com>
Subject: Re: TEO as default governor ?
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:00=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/03/2025 18:34, Rafael J. Wysocki wrote:
> > On Tue, Mar 11, 2025 at 5:47=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 3/11/25 16:31, Daniel Lezcano wrote:
> >>>
> >>> Hi,
> >>>
> >>> I think we can agree the teo governor is better then the menu governo=
r.
> >>>
> >>> Would it make sense to make the teo governor the default governor ?
> >>>
> >>>
> >>
> >> Rafael's position seems to be quite conservative here.
> >> Fact is menu is still the default on many systems.
> >> Even worse, the really bad performance disadvantage when
> >> using menu in an intercept-heavy workload has been fixed by Rafael :)
> >> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.=
com/
> >>
> >> FWIW I proposed this a while ago:
> >> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle=
@arm.com/
> >
> > It will help if one can make a really convincing case for this change
> > (that is, show that menu with the most recent fixes included is really
> > significantly worse on their platform).
>
> For all the platforms I've been testing, the teo governor is always the
> best one.

Great!  Can you please share any numbers?

> Using the menu governor has also an impact on the user experience as it
> lags on mobile.

Well, I'm not quite sure what you mean here?

> After studying the history of the menu governor few years ago, it
> appeared the menu governor was introduced before the SMP was widely
> used. The strength of the menu governor was the ability to find
> repeating intervals but with he multiplication of the cores, the IPIs
> were introduced which increased the entropy of the busy-idle cycles
> duration, thus making the duration much more random and altering the
> menu governor prediction accuracy.

While this arguably is the case, menu has also been changed quite a
bit since its introduction.

What I'm looking for really is a set of numbers showing the difference
and clearly pointing out that teo should be preferred.

