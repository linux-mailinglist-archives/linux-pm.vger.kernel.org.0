Return-Path: <linux-pm+bounces-35648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E810BB17AC
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 20:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAF3B9789
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4F2D3EC7;
	Wed,  1 Oct 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1qclB8W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3F2D373E
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342979; cv=none; b=gEL351UniuLl7BvL6o7BwIn7R9KHOWun6WWTkQy2oyLQkEEok5m0q0v6jupSFMEQszOEx+EFgz8wKaXoDl7BSp2vqbkr+o8jsJ6GZ+KDGGj9BjYqwoekdoyQ7qFjIuaGIbLpLNKfXhfB8EiseMntX8gpq+CnT9ka62y4iX0I5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342979; c=relaxed/simple;
	bh=KCrkhqaxa1wGOP/hklSSh5FinGc8Mcdaij4YwxehQnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r98Ygqxp/IvayNLr4l+nJawQUDfSBGXg9EfPxOLTx/IxKNmTNAOemWPhlWhZwUNiWef5R8r44yez8HSZaaQFfROFbVsOl1J5JPWYNQvh5FnuKq94NdEXmHQeayiJJTpHrQoanNdwJouulqsLSt5ZnLNIP9s1J0C111ZZnUZH6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1qclB8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B84C4CEF9
	for <linux-pm@vger.kernel.org>; Wed,  1 Oct 2025 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759342979;
	bh=KCrkhqaxa1wGOP/hklSSh5FinGc8Mcdaij4YwxehQnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y1qclB8WCu97IFg4pkM5sLQROeu00dfJXwuGmCUQI0yq3OIzFxsfcn19DDbTU3luR
	 jYkrvPvwKFLLv4oxmr05Lih25qQiZGJeZumpH4yVDWkoEV5ISCrBcJjBdhEFHT/Zj1
	 hrJRqB2FQpjGo+nCiKIYAWxmhJr4Quc7y39UoIewN5IMotb8BTBferIoPIk6R54dHH
	 4T217lwQkdbOIEpWB+qPpVXJDaq73Hl4xdQjnMuvE6EypA5VxXxqb9stdAixCCRaX7
	 dQsuDi0MJZne+PSX+WPeHh6x5Elr0Ry0tFvWR38QvyNE8ZQ3LN3+X3wGTqC2t/RuiN
	 ZxC6YX+Yh6m6Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-36c9859b036so82836fac.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Oct 2025 11:22:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEOwLXnEaGhgboFDW5pM3l7GWlKBoPDRBEj3+yB/C3qGHgD49z7fmHirZQ7RjlAevSg+OGF8sh2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcw9hHuV8vEagpxvVR7ERlmyvIi3Q7AZ+MBRV18VjyDYrsyIN1
	Ql115XwobC3q9YLmKIk+HosowO4LefXWsEUlI1U1M2uLVw/SxG8B6Wqj3UVxHvEuuqNlYp7B6nB
	VHVaaGvWq8SV/Q6dj69/UvSEbJiRSxSQ=
X-Google-Smtp-Source: AGHT+IEPUK+RmrivtXzcI0U3jx81sESiKbx4wlJFNrW8Hp7eXlijHVMwfmSIVGZ7s2Sx8VA21v0fuqQYfTDVR/VirCs=
X-Received: by 2002:a05:6871:81c1:10b0:331:7220:f4c4 with SMTP id
 586e51a60fabf-3abcb0627f4mr388654fac.13.1759342978347; Wed, 01 Oct 2025
 11:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com> <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
In-Reply-To: <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Oct 2025 20:22:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
X-Gm-Features: AS18NWA3g0TQmCO76wAf69mrfg2AIPJU8TBIzb4bftZh7uTz1dIEktKoGWV2Gy4
Message-ID: <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:37=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > Hi,
> >
> > On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > Hi Rafael,
> > >
> > > Just a friendly ping on this patch. Please let me know if there's any
> > > feedback or if you'd like me to make any changes.
> >
> > Have you seen https://lore.kernel.org/all/20250909065836.32534-1-tuhaow=
en@uniontech.com/
> > ?
> >
> > If so, what do you think about it?
>
> I was following this chain
> (https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniontech.co=
m/),
> where there is some ongoing discussion on converging the solution.
>
> Our changes aren't mutually exclusive, and tuhaowen can build changes
> on top of ours, even indicating:
> > I'm happy to work on this as a follow-up patch series after your change=
s land, or we could explore a unified solution that handles both scenarios.

That's fair.

> These patchsets don't negate each other, so could we decouple these
> two patchsets since they address different issues?

Well, I'm not sure if they are really different.  After all, this is
all about avoiding having to wait on an excessively long filesystem
sync during suspend.

I'm also not sure why it is being pursued to be honest.  Is setting
/sys/power/sync_on_suspend to 0 not regarded as a viable option?

