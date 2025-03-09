Return-Path: <linux-pm+bounces-23721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC40A588E1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 23:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D9D188C3F8
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929719F47E;
	Sun,  9 Mar 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKais6FE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA219B5B8
	for <linux-pm@vger.kernel.org>; Sun,  9 Mar 2025 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741559898; cv=none; b=AbyUquXRxCUc8T771NWDKnT3T6PTF6QyyQV0ru2UDAAGB4l3QCDQC7UPtMiCT/45cfPX4ffxWeerW310mZv6gr3uO89tBxiijQuQfjrCTPX1C0KSp9MRimXKklvksf4O2wn5GBgFb3s8dFMA+PC3tdqnoY+kr6RlzIummax8RHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741559898; c=relaxed/simple;
	bh=Azwp04EkMKNvzb3dS2Zw+wVW2FbS+3fUfVDM4kOtpRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5x5K+Vxbq4kJerhuJOn1p0RiEvllfbZd7afkSR2NC61lKOega2JDN1IU7/RjpDSfftg0WvlAZhHGBeatFa2dZejFyZfAi8+xh0DAwE3loq0AQAQ3yExSYUQXoTIUDtuJGuMhsGxbzQGO88YCv57jqSdFVaoDqZHHofWOENlcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKais6FE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5495078cd59so4202038e87.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Mar 2025 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741559895; x=1742164695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UtH1v3jP2/r9ixGeLfDdN9kgltpwwM+LthypTjKFcI=;
        b=TKais6FECWiQTHVvAaKleu7iPsmVAN4JzQXYfo0eHGe0tqTzfptglYEaheZX8Q4P/B
         dRMYOyTvzRdahKeWSw7yjFu75pNQc1/2bA6MAH0MXAwXImDq+Djvki8uho8fDB8NQO2Y
         1WZx/nZIxj34F7S/SqUFrHgG8MTnvXKyBjAghAlc7N/YrBRiaDxBIWGAgNS4vu4qX2bs
         5cxDD2ZLxH7pJ5NpehEdZ/0Pq95QPRyv7r/I1yISqfl4JKAbJ4I4ekh5ktiBtMnu1PAq
         fAndWnAdTZS8RBeE20IMI1kC8exwpYkDXu9VtpwGfnQiYLdkLto9Iy/F+1gP7iAx8EYz
         k7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741559895; x=1742164695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UtH1v3jP2/r9ixGeLfDdN9kgltpwwM+LthypTjKFcI=;
        b=gd2lHK7IuPIGsxRWyHegwqJeSo0GzTi3ZpqFwGnPTKFvZvAQwZudm7jUYDP5Wtanqq
         vhGn7qdwiF3jJ4KZL+QbuT0MROLlP4btDff91vk6W/r4MY+i3O2UBfA8CjehxzsfiTX5
         1fnE6D+ycEdXoGHbf1OLZwNL1UkOpXEm7vpFunXGfMcsG87exir98hF9z2qnTVm09I5I
         7CclQZTNd6DVcA0yd89E/Z2jl+dRXzkwlUA0NK4kM4KwUBgOoi0sSK8Rqqul+efWK9U7
         pNcUBExIL6oe8R3H1FoEtHVxuvLeQuv1mL6YzCphbzOUucPQX8XyWN/uFoCHhDvq8FEN
         EOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhCeBh4keGFkDlh15FuS9UrJIc0Ku2Y6kxjTR9dxHfnvc/M3e5+9CZG4qLTp6uYyu9uNesJvuiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdo5mPfH+XBO/u297/mHBUAEh+bxLhXqK3B0Kcdn5+EXfT72Su
	roTiBzoqDj93jQO1SIKxGfaEeleKPbvClnwGbO3H5BG/rBAZPoHlwVKNu3+T9LLQQlWhbmK0e8e
	OMa2LLptT2A1ksYSHPlZ8/thitSFNuZf1yWEEjZAp4ts/VFAIvw==
X-Gm-Gg: ASbGnctZfnZxQepx7l5oop7JvAbAm41hhdI2lzcAj7MdRNhm/fQyeh7PRsTr3L/Bu1S
	gKoUrxqDv34ON6tpRNY3wtG8xjllKXiIUCsTZeDhOrUS1p92TiDKWJbyHNJee18kK2B2tiUw6Vs
	AbTKdQ1v7D7zWzfjl6wIPByZx4zQ==
X-Google-Smtp-Source: AGHT+IHpxX83JssEWivX8xC464YY7AHXc0n7H0jHpozJf0zDm0l+WYGt+H2+vYKELMb3Mtk0JmhwRT5o9Gnn86uFkyc=
X-Received: by 2002:a05:6512:2393:b0:546:27f0:21a7 with SMTP id
 2adb3069b0e04-54990ec1fbdmr3936793e87.49.1741559894418; Sun, 09 Mar 2025
 15:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
 <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Sun, 9 Mar 2025 15:37:37 -0700
X-Gm-Features: AQ5f1JpBBebQuZIt8MOSEa4OvjlL6IxzqdZ-iKIGd_qwe4qPaEwtQEJKyBFOkGQ
Message-ID: <CAGETcx82sLvG19eUN1ATrL5RzEKJjOeWP+kdYJdQX9O=ck7q2Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:23=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Feb 27, 2025 at 4:45=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > >
> > > Hi Everyone,
> > >
> > > Initially, this was an attempt to address the problems described by
> > > Saravana related to spawning async work for any async device upfront
> > > in the resume path:
> > >
> > > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@g=
oogle.com/
> > >
> > > but then I realized that it could be extended to the suspend path and
> > > used for speeding it up, which it really does.
> >
> > Btw, maybe I didn't  word it correctly, but my patch series was meant
> > to speed up the non-async case too.
>
> If "the non-async case" means the case with "async" suspend/resume
> disabled entirely, I don't think that the ordering in which devices
> are processed can be changed just because there are no known
> dependencies.
>
> > I was going to get around sending a v2 of my series, but was caught up
> > with some other work. But I'm okay if you want to finish up my effort
> > -- less work for me and I can focus on the other aspects of suspend :)
> >
> > Maybe add a Suggested-by: to the patches?
>
> Yeah, I can do that.
>
> > I definitely want to review the series, but very busy this week with
> > some other work. I'll get to this next week for sure.
>
> That should be fine.

Hi Rafael,

I looked at the full series and it has at least one bug and a few gaps
that I address in mine. And those are what make my patches have a
higher diff. Can we just continue with my series instead? That'll be
easier to explain and more forward for me than reviewing your patch
and making sure it covers everything I already tried to deal with.

You partially reviewed my patches, if you can give me more details on
my patch 1 and what else you want me to do for the rest of them, I'd
be happy to do that.

Thanks,
Saravana

>
> > > Overall, the idea is that instead of starting an async work item for =
every
> > > async device upfront, which is not very efficient because the majorit=
y of
> > > those devices will not be able to make progress due to dependencies a=
nyway,
> > > the async handling is only started upfront for the devices that are l=
ikely
> > > to be able to make progress.  That is, devices without parents in the=
 resume
> > > path and leaf devices (ie. devices without children or consumers) in =
the
> > > suspend path (the underlying observation here is that devices without=
 parents
> > > are likely to have no suppliers too whereas devices without children =
that
> > > have consumers are not unheard of).  This allows to reduce the amount=
 of
> > > processing that needs to be done to start with.
> > >
> > > Then, after processing every device ("async" or "sync"), "async" proc=
essing
> > > is started for some devices that have been "unblocked" by it, which a=
re its
> > > children in the resume path or its parent and its suppliers in the su=
spend
> > > path.  This allows asynchronous handling to start as soon as it makes=
 sense
> > > without delaying the "async" devices unnecessarily.
> > >
> > > Fortunately, the additional plumbing needed to implement this is not
> > > particularly complicated.
> > >
> > > The first two patches in the series are preparatory.
> > >
> > > Patch [3/5] deals with the resume path for all device resume phases.
> > >
> > > Patch [4/5] optimizes the "suspend" phase which has the most visible =
effect (on
> > > the systems in my office the speedup is in the 100 ms range which is =
around 20%
> > > of the total device resume time).
> > >
> > > Patch [5/5] extend this to the "suspend late" and "suspend noirq" pha=
ses.
> > >
> > > Thanks!

