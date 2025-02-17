Return-Path: <linux-pm+bounces-22210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BBA38514
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005DF16561B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353529D05;
	Mon, 17 Feb 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2CQAxdN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE0179BC;
	Mon, 17 Feb 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800087; cv=none; b=M7ZdOyFLEN4aSYpLYen5s36tVS0+XN+S9Ope9CoUHgp/AvpK5YKUr7JuffAhnXYeebU9FOvXwyf1IxjkYiK8SmNpIm6TK0gtUITbhcadVX5HoO8G88f6C9a3wgZ/rEBF/v+BgaQLAoAyH71ZV1/pc75+cQjc/k4DhN2+nHsYWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800087; c=relaxed/simple;
	bh=L8OCN1cUiLRiv9P1I7bfcU+HLKCa8ZIv8qOYNs8TFCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDdqr0jAxHs+OjXLU+qysjYj52BTUi7q9+FTTwHAJCJ7/Y+dQRfZbLrr3yXj9dRI3pGqXY62z2RqFEqG3a8qqDj31eihL7UEkAGwBd3NvtxCcaczbpja0m8x2/zzFhwpzl2dyR03zxVvAq6R7xIcDsDHqjzHcb5L/QlV7+pjB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2CQAxdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAEC4CEE7;
	Mon, 17 Feb 2025 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800086;
	bh=L8OCN1cUiLRiv9P1I7bfcU+HLKCa8ZIv8qOYNs8TFCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r2CQAxdNAA90959zy5dtp01imhYusxAZN1YJtlkU7HEY/26WTYyjHC3wt08inR5XS
	 k1H7f3FsPhsqebwuMDPz8F3h/Tp4ndjOq5GMyHxiIMSOcyagfFqiVWCsHpaHRsBM9x
	 2KihCPLfPZNL3bsTCDNeZYcwoNsPicDvBMna5tLSqxB8rdC3IypN+gLMCgKwNG4Ty6
	 VA/0a/l0JYopS7z4pHGyv4ZSPnP+lWADWqMiPsJd3vtoqlN2dehSLJhAeDmkRB5/hb
	 VhQG4ML1x/gi/h/tKaEfw2AIL2hQKm4HMS7nJ2gaKWVSbkUm24CqPKKaR+3q6XpxbP
	 D2XcnCr2P9uZw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7272cc739f7so30902a34.1;
        Mon, 17 Feb 2025 05:48:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXvXe5ghcFK4pnL3Z7J+zNAzw6VbCropJlbZe1qecdYowgRSUFZdEdSr1EUiMyCm7CcmCe7jJXFIM=@vger.kernel.org, AJvYcCVqZJeHc/0RdAwe+A7PiarQOdIr/oNhkCtgFwN/3WiPJOA6zrSiPyuT6jvqC6+KX4UOnWKU5aSFQU02Vys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrME5IYa+bjFY2ZjrpZrtcNULpCw5mHo25ryr2nNqPTzQl7ysF
	ee2Eb7JY1QoHGwJmdH99Ki+5lhFW4ImI5rOpGRSRvbnKGFF+PpdOVFa0N6rMPmTTaOqjv9H9reX
	UhWdhgh8fuITCncfBSuCV5Hg1a8M=
X-Google-Smtp-Source: AGHT+IF4QDX+pkNaLhTeKO5r4AlLlH+oGgzolJUPo0/f9q0W438NMECwqDRAmg6kv5e+6w0OLzk2fSvdbKTFcWq5VWY=
X-Received: by 2002:a05:6808:1817:b0:3f3:adab:2012 with SMTP id
 5614622812f47-3f3d91581f9mr10573633b6e.15.1739800085922; Mon, 17 Feb 2025
 05:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <7770672.EvYhyI6sBW@rjwysocki.net>
 <20f09309-bd96-4b29-9602-4f969547dc51@arm.com>
In-Reply-To: <20f09309-bd96-4b29-9602-4f969547dc51@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Feb 2025 14:47:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hbthUx6BkCmfpESjz6YTA4rN2iF8TFFRM=4gY500UcSw@mail.gmail.com>
X-Gm-Features: AWEUYZnA1943DQlhWqO4DxwAbzmHpOgNYwqLjuVpwzLtZo_5iVIDwEf-izmcA38
Message-ID: <CAJZ5v0hbthUx6BkCmfpESjz6YTA4rN2iF8TFFRM=4gY500UcSw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 5/5] cpuidle: menu: Avoid discarding useful information
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 2:39=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/6/25 14:29, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When giving up on making a high-confidence prediction,
> > get_typical_interval() always returns UINT_MAX which means that the
> > next idle interval prediction will be based entirely on the time till
> > the next timer.  However, the information represented by the most
> > recent intervals may not be completely useless in those cases.
> >
> > Namely, the largest recent idle interval is an upper bound on the
> > recently observed idle duration, so it is reasonable to assume that
> > the next idle duration is unlikely to exceed it.  Moreover, this is
> > still true after eliminating the suspected outliers if the sample
> > set still under consideration is at least as large as 50% of the
> > maximum sample set size.
> >
> > Accordingly, make get_typical_interval() return the current maximum
> > recent interval value in that case instead of UINT_MAX.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -190,8 +190,19 @@
> >        * This can deal with workloads that have long pauses intersperse=
d
> >        * with sporadic activity with a bunch of short pauses.
> >        */
> > -     if ((divisor * 4) <=3D INTERVALS * 3)
> > +     if (divisor * 4 <=3D INTERVALS * 3) {
> > +             /*
> > +              * If there are sufficiently many data points still under
> > +              * consideration after the outliers have been eliminated,
> > +              * returning without a prediction would be a mistake beca=
use it
> > +              * is likely that the next interval will not exceed the c=
urrent
> > +              * maximum, so return the latter in that case.
> > +              */
> > +             if (divisor >=3D INTERVALS / 2)
> > +                     return max;
> > +
> >               return UINT_MAX;
> > +     }
> >
> >       /* Update the thresholds for the next round. */
> >       if (avg - min > max - avg)
> >
>
> You might want to amend the description at the top of menu.c then given t=
hat
> this now returns something without any meaning in a statistical significa=
nce
> way. Similar to admin-guide doc.

OK, I'll send a documentation update patch on top of this.

> As reported by the tests, this does improve performance a lot in scenario=
s of
> short intervals (where passing the statistical test is hard).

Yes, that pretty much is what the SPECjbb critical-jOPS improvement means.

> Teo exploits the idle state residencies for this (i.e. as long as they fa=
ll
> into the same bin, they are equal for our means), this can be viewed as t=
he
> menu equivalent to it, without relying on idle states.
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

