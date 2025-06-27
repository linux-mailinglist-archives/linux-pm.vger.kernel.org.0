Return-Path: <linux-pm+bounces-29648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A002AEB52A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 12:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B948167FCE
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1B29824B;
	Fri, 27 Jun 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw0WUk4x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07029615D;
	Fri, 27 Jun 2025 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020845; cv=none; b=Ar05dz6X9I5Kydk2beZ93PDxAkoAM7i5K/iURH2GzfB+XT3ke9rLIPhpr/7TxTKRs76wkdSsNiNA/F5yTipBkvjMa7M6hC8zRM+Woin/LujWCIW0L1BxY0D+AVQAdSsHHr921RdnfHPseA6QNO0YfqT1HFzlpIUDnorOUrBd+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020845; c=relaxed/simple;
	bh=7qfv9HgVzOEOTjaIxZhU7hK9cuJpa4FQXmITJTTJBGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG9jn1c/tpT+OF23YKy6495I7U5QvlTIV0TEBRkyUo4qUP5Lyf4TEZ8tPLbeVU0+nxuNSuSYwYRYS5en7BFXLv1ygJFZz5CYYy/67sqnIe8UVm0Iz9KnA3HfYxtkDHPZCGXm3yFiMzIAnDZyQ94MVCz6tqWhmg99NLS8SiuWpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw0WUk4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AB2C4AF09;
	Fri, 27 Jun 2025 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751020844;
	bh=7qfv9HgVzOEOTjaIxZhU7hK9cuJpa4FQXmITJTTJBGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fw0WUk4xPmRlmgDezc1YKV/cRfHJ4iHucPaAP1v4VFN77pttsoXUwObdNm2IcKlJ0
	 qHjogcDFJA5WfxRKHNXYgd6r1wpWi/N8CAgl7ezq5lO3NDl45DYxIowXN0fZCQnkAe
	 RYTGy1+ZhpL0JSIiqt3Q+dArWVxWacu4Crd935iYSh2LIiKVP72DlHDMc9Wt3SxX9I
	 Oe/FuwzMS6rqIols9lyQgRjgZTCcveSsdo1vFLpM13YrLaoyg2wojsIGDKDxh4lL/k
	 rFaDNzBomRZwAtv8uqeell5u43H6UM+lVCtTFbTXbSkTs2xIQxe1mucpwgbqKwyGXE
	 lpZXCjs2rPR7A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2ea34731c5dso1235331fac.0;
        Fri, 27 Jun 2025 03:40:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0yYLkXxsk5GFm15YcvCWw6gMeoq/RskPHw7OVCTI1SSwurFAgF2jU6mvfPQ4cgMAbWVZFAnR5l6XdpzE=@vger.kernel.org, AJvYcCWXXNFgw1j6IgGXjss2ofQd4rkE6ADNnKG4okdQGwmjOsjnPhphDiFxz3o1RslKo27rXyHhk8ZPAAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOmpoTRTQy+z1be4GhRRp/CIZk61HVS7WXoYgy+BRpcl4Kwxx
	XTslGYuPaVXF+N5P4RIwr53z88POduEIDOumdGC//ft7FaBJSRCYbW7xQ6y4p9qnQiXcV7mFVf8
	FbZr/yj9V1V8OO97ngLTbFKRSth3WGLA=
X-Google-Smtp-Source: AGHT+IFhOwiSehvLBkinA4qw2PH2OU6rDaCbd9wuzKMX5ahOUCbBmhxWtwnQNsVCx4C5FPU9zqajspliPpZOhjhh11o=
X-Received: by 2002:a05:6871:e7c6:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2efed86efafmr1672430fac.30.1751020844035; Fri, 27 Jun 2025
 03:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5011988.GXAFRqVoOG@rjwysocki.net> <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
 <5a6d0684-3340-43ed-b520-933654515943@amd.com>
In-Reply-To: <5a6d0684-3340-43ed-b520-933654515943@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 12:40:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJ65xxuHtJrWp1sC76FUzPHNpXB+xtHB=e4qTRSgAC4w@mail.gmail.com>
X-Gm-Features: Ac12FXwM-RS_IpmNqOjPxf8-LkqCjGjccQnSq8VTBhiyXJPJXFSHQgRjmlID9gY
Message-ID: <CAJZ5v0iJ65xxuHtJrWp1sC76FUzPHNpXB+xtHB=e4qTRSgAC4w@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Chris Bainbridge <chris.bainbridge@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:28=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/26/2025 4:46 AM, Ulf Hansson wrote:
> > On Mon, 23 Jun 2025 at 14:55, Rafael J. Wysocki <rjw@rjwysocki.net> wro=
te:
> >>
> >> Hi Everyone,
> >>
> >> These two patches complement the recently made PM core changes related=
 to
> >> the async suspend and resume of devices.  They should apply on top of
> >> 6.16-rc3.
> >>
> >> They were sent along with the other changes mentioned above:
> >>
> >> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
> >> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
> >>
> >> (and this is v4 because they have been rebased in the meantime), but t=
hey don't
> >> make any difference on my test-bed x86 systems, so I'd appreciate a co=
nfirmation
> >> that they are actually needed on ARM (or another architecture using DT=
).
> >>
> >> Thanks!
> >
> > Hi Rafael,
> >
> > I haven't yet got the time to test these, but the code looks good to
> > me, so feel free to add for the series:
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Kind regards
> > Uffe
>
> I passed this series to some internal guys to test on a wide variety of
> AMD x86 hardware.  The initial testing looks good.
> Will keep you apprised if anything pops up.

Thanks!

It would also help if you could check whether or not there is any
measurable performance (that is, system suspend and resume time)
difference between "before" and "after".

