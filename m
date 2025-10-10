Return-Path: <linux-pm+bounces-35917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B1BCD484
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 15:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 174DD4E1BD2
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D42F3631;
	Fri, 10 Oct 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9eu0WMg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015012F2601
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103262; cv=none; b=fsaxaDFwsGjhQBByl9x28I9Xix9KFGE/lJ4txFjtUFPn8B0nXzDE32vksC617vcAGvrI+fS728hVHkz5CaT5lB8tn1cKnumvjgSZ3GRrVq+UBSQngXb/WtKW93zu2fsUrFKmVEM781iVsAb+W5r0cXkUYj5P4vTnrH88Ja4eSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103262; c=relaxed/simple;
	bh=ZBxX58xplYkNGZs9tQ/Ftj8iqCszIJBOSXuiKsNq7Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8MJN80h8z7wFREubYFypA5KLksMMH2tHTnFQJFEcxXkL1kBMVUGrutLPtp6YTS2Po06bmpV1yu/7y3IV2xBkSZc5tKWWIzfofeUvpPk7vzerwPB1y0Urr96okB1d3J5KRrB1NR9he2qOshdemjItV6qW5wrKy0RKrBPIX02FYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9eu0WMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4FCC116C6
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760103261;
	bh=ZBxX58xplYkNGZs9tQ/Ftj8iqCszIJBOSXuiKsNq7Fk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l9eu0WMgzaMw2Wj1gZYJ8ODcEwyB4OZrGJSYvnBV1DqKcNVIfhBI8vbEEVqP9+nvl
	 uJe4WTOfdBAsJd0Kp+qU4d7WUqa7AJE/nnpoERMexjZhpwEE15O8hP1MOqOSR9AaGa
	 xUg8g/jORhKVqtyPj06Rsk9tOO/HjIe/3MMGgvXHmQ6dI8xGunLtTj+IGSG+Ud9aiF
	 gAwoKKZe8IrMZark3NA2oUyK8S+6aaY23QdQhr0QK6cn7sPKRiVCWvy5B1mRuIkGLo
	 oOP6hEcW0mVwr5kvk8ZwnLtAQIq4uyRdmyHsg5gesL7u+mC3VVY0vGuaqSfM3neLk9
	 vC6jwPdfQv8aw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f86ddb4b3so607942b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 06:34:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4qSZGnGk+bnhcNgAEaK1uEqIf5jQnbPcjCFVXUzK99xBy8ATPn03chKZKNUX0kRJpvEK70PDLkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgU/jAZ6QNEPIWR0v3P9/O4fJh44TDADmAH/RBi5fssOD5XK2
	UhyywB9Jd4fJk5jG73jhZjDbkHiNpupOxgVvKU7eTTZQFMiDAoI67DeslX+ILIUJBKJy5LfBON9
	H60FWwFDD4rjbUg3hBh8Yrsrc3s16GD8=
X-Google-Smtp-Source: AGHT+IF6iuACd78CFkPvnWobinm5mJi6jj+Ygtj6Ghs/HmELdQIeGn8rQu+zUckCYs3rftvHmrFasbKc99VbP8GeH8U=
X-Received: by 2002:a05:6808:1881:b0:43f:1de2:fe8f with SMTP id
 5614622812f47-4417b36799emr4934825b6e.15.1760103260927; Fri, 10 Oct 2025
 06:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919153008.324338-1-marco.crivellari@suse.com> <CAAofZF7datQsN0xJXXJs-t33vh09D5+=2F67Q+GL=TSsqCb_zw@mail.gmail.com>
In-Reply-To: <CAAofZF7datQsN0xJXXJs-t33vh09D5+=2F67Q+GL=TSsqCb_zw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Oct 2025 15:34:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZEznO6mKcR0FM1Y5SxW-7_Q=atk4WDLWGY5+kysU+dw@mail.gmail.com>
X-Gm-Features: AS18NWBouB2cJ7Vpm4NHjuOMJI9kCgsSDhb0El-D_Tff1N0sQswptCG_5GJkRSs
Message-ID: <CAJZ5v0iZEznO6mKcR0FM1Y5SxW-7_Q=atk4WDLWGY5+kysU+dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] PM: WQ_UNBOUND added to pm_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:16=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> On Fri, Sep 19, 2025 at 5:30=E2=80=AFPM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> > [...]
> > Changes in v2:
> > - WQ_PERCPU removed from pm_wq.
> >
> > - WQ_UNBOUND has been added to pm_wq to make explicit this wq is unboun=
d.
> >
> >
> > Marco Crivellari (1):
> >   PM: WQ_UNBOUND added to pm_wq workqueue
> >
> >  kernel/power/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Gentle Ping. :-)

Well, a merge window is in progress.  I'll get to this when it's over.

Thanks!

