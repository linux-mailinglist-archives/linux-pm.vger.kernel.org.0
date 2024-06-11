Return-Path: <linux-pm+bounces-8963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A99043C6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A991F23816
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891A2628D;
	Tue, 11 Jun 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAc0Hv5+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F1171D8;
	Tue, 11 Jun 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130932; cv=none; b=nLmFl3FkVHaZMx1XqPyNyHljn4SYVLeDVZLJ9DCK7/RlvWhFT6s2b8mf7tlHGaEVJRRpcS7xvKsThXy1ryQ77RhXrLuZn0HQcHBxgOKKU06vxoyLM2b+wVQVUC0+No319RbKM58uDS+mFhMA2OkaAXG8XvPQdi4vOk4Y0cVOkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130932; c=relaxed/simple;
	bh=kaoPBmb1FTgO00GA5cfctvuChdkH30Phg0/HzkbnsRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSuXqq1LTwTIWVhE0vJIIg/tXwvpJk977GI2SU2D+LDjSAIL4PZrZoEevgZVwxaWgd8GfUKuv74o9qPymJQ3kjBNPnPF8VhYAht+2Lq4WssGUMN5mO4iLBdFtyj6uCeNjndlMLO9w/9aa8Ldbw0cc9hukBixqXY5FyxN0EI6QjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAc0Hv5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED93AC4AF1C;
	Tue, 11 Jun 2024 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130932;
	bh=kaoPBmb1FTgO00GA5cfctvuChdkH30Phg0/HzkbnsRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AAc0Hv5+nO/GpEJ8Rx0+odPTjOFP5TYcHMd4YRk4KSGlCcrkyMNW0PgofKrnfFTtp
	 RykofV9twQIT1HlzP1a2OIZUoaFZ+s6MYJv6RkInqeJa7Aas7E2xFU8Rd5WUEydenT
	 YpHSmwP4bafJqQKGipiiyzKFFV5DOOwx2m4h8Gpd44fKWrmWH4zUXbj1yXsJ1CE3KZ
	 sNvr5NtmqbhNzHeVapiOl1JCn6tXDI1AWbXbNoHkZO1kdwDsOi/qwLL/oaBuL95WE0
	 0ej8y7lE8XTllw0in/KDwx+7BBSN16L2hcVotyy04buJo/xWAoTdrxGCwEJNerjA0n
	 V4PzK4pbd5/IQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d1b8bacf67so784479b6e.2;
        Tue, 11 Jun 2024 11:35:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2bL8gaO8pWkDUcvqxRmi0lM6QNT13qyFZEhzNLFLZs31zQrAGSD02guDaEeneHaRcmjgGrF6NE+pRIeu8sGP1yF1NWNPRp61UMDRxyr9rzxJTU6cgBPP3s6OKbGVH+lQqNhs0ISk=
X-Gm-Message-State: AOJu0YzjCkcZGX/rBvGW0phDRrU6MfmwfrqoDkpBQp1r3zWNfyQXFyue
	OdfnUoH6gg218u/doNCPyBbB1pqV6Oks2nnXAIw49QiL0lPGvePTC5WK2eUSMI/MZ7nYZI7iL9E
	AgvqKkSDVUa7O4bfNQxH/sFIp5EI=
X-Google-Smtp-Source: AGHT+IGrEeecnnWsNZC8kAgOiM3M1Rbm/oM6sK2M8N9RqHGx6pWHRv4VUFValfQPO2jWvR8TCsYyDdPQBdy5jkXPFoE=
X-Received: by 2002:a05:6808:1590:b0:3d2:22cb:5592 with SMTP id
 5614622812f47-3d222cb57acmr9571004b6e.2.1718130931125; Tue, 11 Jun 2024
 11:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5794974.DvuYhMxLoT@kreacher> <2337425.ElGaqSPkdT@kreacher>
 <dd446bf6-05ca-4861-b3b1-f113c3528f13@linaro.org> <CAJZ5v0jku1tptD3O=x-rptgUWGQFOQT-U3rsxk9k4XXsyeq3Kw@mail.gmail.com>
 <1ca6f4db-a7cc-4f47-b626-51daf7175885@linaro.org>
In-Reply-To: <1ca6f4db-a7cc-4f47-b626-51daf7175885@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Jun 2024 20:35:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1OdEmrQr1EQz6ucX4cA65W1BmjS8pSRnVPuVcrCCAAA@mail.gmail.com>
Message-ID: <CAJZ5v0h1OdEmrQr1EQz6ucX4cA65W1BmjS8pSRnVPuVcrCCAAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] thermal/debugfs: Do not extend mitigation episodes
 beyond system resume
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 3:39=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/06/2024 13:29, Rafael J. Wysocki wrote:
> > On Mon, Jun 10, 2024 at 10:28=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 28/05/2024 16:53, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Because thermal zone handling by the thermal core is started from
> >>> scratch during resume from system-wide suspend, prevent the debug
> >>> code from extending mitigation episodes beyond that point by ending
> >>> the mitigation episode currently in progress, if any, for each therma=
l
> >>> zone.
> >>
> >> Why it is done at resume time and not at suspend time ?
> >
> > Because it is related to thermal_zone_device_init() which also runs at
> > the resume time, so IMV it's better to keep these two pieces together.
> >
> > Why would it be better to run this during suspend?
>
>  From a logical point of view, it makes more sense to cancel something
> at suspend time rather than resume. That prevents future readers to be
> puzzled by an action done in an unexpected place.
>
> Technically speaking there is no difference if it is done during suspend
> or resume. Well... we want to prevent actions to be done at resume time
> in order to not increase the resume duration but I'm not sure this code
> is doing a big difference.
>
> If you want to keep it as is, feel free to add my:
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I will, thank you!

And thanks for all of the other ACKs.

