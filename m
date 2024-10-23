Return-Path: <linux-pm+bounces-16282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B49AC241
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EAA284351
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF51684B4;
	Wed, 23 Oct 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j76WjmM5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53B157E78;
	Wed, 23 Oct 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673562; cv=none; b=EVe+AFt64QK53+8Wyyw5JoanT8uwKowIebyk7BUw3ZlF7aJZrVn/q6+/XLCW9P+eaUizyjxI1feugbrQ3oVxLcq2PBPEJGqlPgZQ0oB4/4PWGyVk3Z3RjCFTW09+R7Nb9UpBay+I0vDG4FHb6i7HSm7SxHbIMYKmv4QMZ8d6g/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673562; c=relaxed/simple;
	bh=WnfYBElZhFPsUfnPReJbIGFw2pzjY2EYwEjtUOWvtZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYL67sH7ccnP6hz4V59AdYpvxn5liADH9B1AK9lo4T8zvPlyecSVvMueW/KbrWZubVfHiGBWshawfHcm55eJxgfyZmdUkqkZ2k5W7mcCU0CsAX0LJraoAiLRFvH1UTX92JDXz8gPkCNQfg2EeMrXeBVicA7ncXfDSsq2zvCDOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j76WjmM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B35C4CEEF;
	Wed, 23 Oct 2024 08:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673561;
	bh=WnfYBElZhFPsUfnPReJbIGFw2pzjY2EYwEjtUOWvtZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j76WjmM5QwEtR5s7l0RoOA1ITPVoEne0UtGwppQpwLL1s11g98e6gcM+noXm68mg6
	 HsM5ExEXOlDfSB+hBSmu6GZJsm8X4Gj/3IhODxlX+BUH1O0ncrE+7HWTdUPz97vwQN
	 j8n9Cy4pNEFp3Y2zm7/zZ6tpkrjiZmCNPh9e2np1uBTF+9voG7xltauTZAeTOitu9+
	 ljZSUvmzKH0Uglq9c9kHwzAzpFKgGc6IjzFqyz6WrjlX4IOhoOb7qi/HxOiQf9NFxz
	 ZmJ4XNsNiHtlBGzQ7f77MGPq3tSXQc5+KSdlyy2ALsPGZnqOtpc41VZQQ8h3NqWNet
	 TdInvoGTqzoEg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28896d9d9deso2775474fac.2;
        Wed, 23 Oct 2024 01:52:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgXLUnmxsNomXAYmRLScFllQJwY3b+D6/0LgRjDqAEWjKiZJdQpZduwxLn9GqAg1b7JybpImH0G+Q=@vger.kernel.org, AJvYcCVoq/wXNBliPjNXGFb41PZM2WQlx0O5mcMuRq0YkVsTFKzIQ3p5HrzJkx06trr8zTSFfR5TnVkyhJVLfl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlwW7mxafoE1AuXneMkxCRg24gNOhoacZqnQMV4VEU14c9U8qg
	sQhY92VJObrB97LgKPtxnQeGU5KtXvLbI28DgiiXaHKDB8/ymmAeUwAi7T1Ez0WTBOGtz3cuQ4J
	jaKT7UGRfuZ9uLJ5GUXd0DvsUOPg=
X-Google-Smtp-Source: AGHT+IG8OuIQ3b48YFEsiLqVhLSUSOvbQjl4yeSLQwHN+5en9ACp62QdVH6sib/oYU8DQIIE8sPt+1gDw6JW1nhxrFs=
X-Received: by 2002:a05:6870:1d2:b0:25e:1711:90e3 with SMTP id
 586e51a60fabf-28ccb44c99amr2046492fac.2.1729673560629; Wed, 23 Oct 2024
 01:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net> <2655659.Lt9SDvczpP@rjwysocki.net>
 <CAJZ5v0h_tsCKpvZuHejCF4qnvJt7+=GqMGc7YgiM=Eu55bKBCg@mail.gmail.com> <fd8729ab-85ba-4cbb-80f2-c5e188987d62@arm.com>
In-Reply-To: <fd8729ab-85ba-4cbb-80f2-c5e188987d62@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 10:52:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iBL8bT1SHu4KKh7qgzq0nLAjrc6QY4oBEM-unhVFfs9w@mail.gmail.com>
Message-ID: <CAJZ5v0iBL8bT1SHu4KKh7qgzq0nLAjrc6QY4oBEM-unhVFfs9w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] thermal: core: Add and use cooling device guard
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:24=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/14/24 13:26, Rafael J. Wysocki wrote:
> > On Fri, Oct 11, 2024 at 12:22=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysoc=
ki.net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Add and use a special guard for cooling devices.
> >>
> >> This allows quite a few error code paths to be simplified among
> >> other things and brings in code size reduction for a good measure.
> >>
> >> No intentional functional impact.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>
> >> This is a new iteration of
> >>
> >> https://lore.kernel.org/linux-pm/1890654.atdPhlSkOF@rjwysocki.net/
> >>
> >> v1 -> v2: Rearrange cur_state_store()
> >>
> >> ---
> >>   drivers/thermal/gov_power_allocator.c |   21 +++++++--------
> >>   drivers/thermal/gov_step_wise.c       |    6 ++--
> >>   drivers/thermal/thermal_core.c        |   17 +++---------
> >>   drivers/thermal/thermal_debugfs.c     |   25 +++++++++++-------
> >>   drivers/thermal/thermal_helpers.c     |   19 +++-----------
> >>   drivers/thermal/thermal_sysfs.c       |   45 ++++++++++++-----------=
-----------
> >>   include/linux/thermal.h               |    3 ++
> >>   7 files changed, 57 insertions(+), 79 deletions(-)
> >>
>
> [snip]
>
> >>
> >>          stats =3D cdev->stats;
> >> -       if (!stats) {
> >> -               len =3D -ENODATA;
> >> -               goto unlock;
> >> -       }
> >> +       if (!stats)
> >> +               return -ENODATA;
> >>
> >>          len +=3D snprintf(buf + len, PAGE_SIZE - len, " From  :    To=
\n");
> >>          len +=3D snprintf(buf + len, PAGE_SIZE - len, "       : ");
> >
> > There is one more "goto unlock" statement in this function that needs
> > to be replaced with "return".
> >
> > I'll send an update of it shortly.
> >
>
> OK, I will review that when it's ready.

It's been sent already:

https://lore.kernel.org/linux-pm/5837621.DvuYhMxLoT@rjwysocki.net/

