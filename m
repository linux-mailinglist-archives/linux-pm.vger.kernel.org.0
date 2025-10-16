Return-Path: <linux-pm+bounces-36234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E1BE2802
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF2374F523C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088692D3EFC;
	Thu, 16 Oct 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI2ySQk8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA32C325A
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608235; cv=none; b=TPdXNYJnBI+V8/0VwtZ1yFK0/Gq18m2fhcWuJCT5AKcY7IZZhiq4Nb03I3rNVOceMX4Zw6LBYVPqlKzMNP1Q4AdgW/r6wSo+DaerKoCnTgyBbkcp6oCd3BRv19qvUka2eGgChHmHIV0l16vRN8p6bI92+T+mXBB2mS3YKXprOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608235; c=relaxed/simple;
	bh=bRGsk239rWKWtEXwaA+7dEJdSrHmmtsiX/HJaJkbuaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtVduqv1or+frIAuVhmitKLTPGcg1xz1K6nTRqY9Wi7xFoBWRbyo4HdGLlxQUAuIDocUH6VVgT/djmNOqf5RGRP8nv7dzrjPWZek8DllxARhsHQVy6/TI8fhZYVPnvX34G1ypEW/c7OiGyHoQZiXF+DLeeICQoBKR+vkCWts1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI2ySQk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC9EC16AAE
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608235;
	bh=bRGsk239rWKWtEXwaA+7dEJdSrHmmtsiX/HJaJkbuaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jI2ySQk8Kd+WcxBo5HMWDQw9OoCDWohooxQqF9EBrHutobJ6TQVljYuSMxVlxwJPL
	 W32Be1CUuY4iJDQLC/gOw/jmPjGQ1aANJD1PkqYA4quB8w3tjEP5nMqHJu8FaaAsds
	 V8Ou9A7bEH0VIwrUUhgk49mJu0RE0YATXvwyVjCp/cWyjEXwejx/PQRUUjY34+kVXf
	 Rgjos3vCHNQYeIFyEkycrVzMzWt53PCQRrJLMWKAq2wzAb8o6NkMXWwuiLcqB86QjP
	 +kiCeOlsPydJJa0dsBTz0otY/nJ9z2rNqyjzy7p6dTgdkFCaPyKqai4O0CqSNKfdR7
	 hdQwTWGaji7ug==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f67a9ba58so138118b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 02:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW1JKspiGlE564todDMu9UcnW7xxy84qC3sqIfPEwkcYpexAJgZ4NNZL+Dwo+OkHmPsX0QOuOIAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywujx47RrFGEgDNeG35uL8tJ6pCNI0+LLOvuq8OayHsdALyiTUj
	v5yV4UZjS9gOGOyYBz/LHbYnaG7XA2ZwjxQFRoDE41J70XWWh+/Mw0ci33U2Q0sUbmsbhsViy7S
	wIA+POLq4qDzCbg710rJ6UymdAcSkINc=
X-Google-Smtp-Source: AGHT+IFZu7yrBrL4fIhpo2H6MSt13LOBWaHdZi7294fip3lNmpYF+ctB38rier9pRdH+11rlW9n3Hvy8wrDYKAimmeU=
X-Received: by 2002:a05:6808:4f0c:b0:43f:6979:6c9d with SMTP id
 5614622812f47-4417b2bbccamr16314967b6e.7.1760608234848; Thu, 16 Oct 2025
 02:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net> <CAJZ5v0g7g7-WWTu=ZQwVAA345fodXer1ts422N0N+ZKx+6jXRw@mail.gmail.com>
 <002001dc3de0$9119d470$b34d7d50$@telus.net>
In-Reply-To: <002001dc3de0$9119d470$b34d7d50$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 11:50:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0ykSYrgPKxPHuNS63cD9mUx57qr7axKfhvtmv=sA_VA@mail.gmail.com>
X-Gm-Features: AS18NWCYJsxVGImT7d7pCGXsOHxR3KpMvjV30hTHaCyHTFhbPX6JOBR16p1MuQI
Message-ID: <CAJZ5v0j0ykSYrgPKxPHuNS63cD9mUx57qr7axKfhvtmv=sA_VA@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:32=E2=80=AFPM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2025.10.14 04:50 Rafael J. Wysocki wrote:
> > On Wed, Oct 15, 2025 at 5:41=E2=80=AFAM Doug Smythies <dsmythies@telus.=
net> wrote:
> >>
> >> On 2025.10.14 18:30 Sergey Senozhatsky wrote:
> >>> On (25/10/14 17:54), Rafael J. Wysocki wrote:
> >>>> Sergey, can you please run the workload under turbostat on the base
> >>>> 6.1.y and on 6.1.y with the problematic commit reverted and send the
> >>>> turbostat output from both runs (note: turbostat needs to be run as
> >>>> root)?
> >>>
> >>> Please find attached the turbostat logs for both cases.
> >>
> >> The turbostat data suggests that power limit throttling is involved.
> >
> > Why do you think so?
>
> I observed sustained processor package powers over the PL1 limit of 6 wat=
ts,
> combined with increased busy % while at the same time power and CPU frequ=
ency going down.
> I admit the time constant of 28 seconds only seems to be exceeded once.

I see, thanks!

> Since I seem to be unable to function without making a graph, some are at=
tached,
> including Idle state usage, which might be useful for your other email.

Thanks for the graphs, they are useful.

> (The graphs are poorly labelled and such.)

No worries.

