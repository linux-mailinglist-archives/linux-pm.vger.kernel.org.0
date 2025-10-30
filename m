Return-Path: <linux-pm+bounces-37098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54539C20116
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B17B18955D0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970D32B9B5;
	Thu, 30 Oct 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yc8whvFa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3F30FF1C
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828246; cv=none; b=hMvnc7S72xzf6fWqjLu2Vu1lpuE0cE2i9acl6ItwdEB/cjR+TVqTvkjehV6TeIHJLxgLdzeLdXh0r8TjuUlMfRGhxyiiN5sW0jE18HOOt2AWyvA703/LwyfYD0908MVdEqsgp4f1/8g9ZfV32iSs9YNeZptw8u/zwmLV7/INcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828246; c=relaxed/simple;
	bh=Vsg6pHABg0QNnlZoDT/EUBC2xV1JRoFDH/4oiFVdKOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBImT2byZSkcS5tbl775ozwp6RnDUxEHc3Wi1UrpQrtMococ7HfqR/kb0qxLZSaQ9gZ+2RWY0M3uvs76gRLwz0ac1NqldGW9vSiW+pzkmyAqH7oChkrNDL63BbCDToCuxt9ajwTuvDJXh0n+j76mQVt43NgAlxLi6eaAufEqzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yc8whvFa; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78485808eb3so13490327b3.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761828244; x=1762433044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDjyf2YcWAcYN9vEkqn7UbYwTq6TCYnnMJLBk0aUuPQ=;
        b=yc8whvFa1Tmpuzr3K+A5YOFo3An4OohDN+/8+Aq+94D8QKXtIktbbHGBaRGFOwq6dG
         2ySUQ9a4NL6UQkbOjQF+Ec5AeiHdKw4kCRP+fonQnVnUWOvTLfYl3zQmN+b5Q33MKASq
         8USEHcWLNmwzKo1KBPuGZzpd4+459kHbecapQfiiU9ZhlO9OmbCgDjqeaj7JVHNDHCqf
         kjQtdF/cSVSNEqZ+H1xNCxVulUTBt9b9H+GjgqfUDYfeWcFBi/riLImY80picPVK6evB
         6KGOrGvOOXXKpseNkNyZUyGvnWvdyfFi/7ZmdhhNG9c+CkHn2+dyfF3md8GOFYMi8VVe
         Aw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828244; x=1762433044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDjyf2YcWAcYN9vEkqn7UbYwTq6TCYnnMJLBk0aUuPQ=;
        b=aVO/GbhYAVSJDJ3yO4I8/w0jxkWxRSohPbVzBlgsPzOIPFDeFILxB/RjlkIsLVajLY
         f/Qx6FwGulzY7gyCKK+S7N6mhJUAHraoTy7EUaavXWw+097Cx9ArK8woJYHgYRH02gt8
         mM7yIm50qC/G4J5wuDrBTshpnnpdRxW5q7I65PnpghkfNzYx0bqhqlYX1GcIPVEEeWGK
         TdVJZEYLvduhfZnvNKeDjixrZ13FN3MPwX5Cu8QjxiwggfAQ6zatNogceMpAIeYCHD4A
         AbiYOpgDl7X+EivqdUxXQUSpV91CI2EYn9LpwFbgM3Gr5jUUY3W73KI2Sm/+YKXIY4YP
         JVsA==
X-Gm-Message-State: AOJu0YwwZuoBmRrCSwzW+651koi5AthwKMo6x19qSqF0MMv71o145J9V
	QZi1zVwS27qC/bY03Y0YJy+p6WRgHJ4RVON+ozcSF5/Dcz6thv3NTep+zzJUz8my+fKBJuV9P1F
	wneJ7NiE57xJhar8b0bVCtmKEBk7pDxTJkA7aEYL5PQ==
X-Gm-Gg: ASbGnctVjmdK4SM5Mqg8w9Fk+TK8gXyCpjiJK9m1UeLdbWt+wBlHgCdwQjiS3QBbPoP
	xvK0JRvtJkUrFS7Y8w0vsOtpac4Rb7whBzWYuAujEDnkl90XGK+zFE+6bHeLrXUglkX9y+BFP50
	OO9u4/YGH1VuLAIHm6JFNaiBH7VZlmw3eEtBNBCL/rl/0ascT/EHX2Hxj3PoT12/2Rx2+kCeIv5
	2kxqoz+z57TVz4k3Pyf7yDXGV4ekZE7r5GUHUnsLgypDSzMV8bpG1P647hMNA==
X-Google-Smtp-Source: AGHT+IHoJ3bGFdVpESH8uyHHz88xUNMEBC8Fu5HjAXHiNMtBHIYJ/tKO/aZSWr4m+lV+8zQnl1zuKQVq+qW0clPbizU=
X-Received: by 2002:a05:690c:b89:b0:785:c7ab:97e6 with SMTP id
 00721157ae682-78628e82e1amr62754117b3.12.1761828244016; Thu, 30 Oct 2025
 05:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
 <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
 <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com> <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 13:43:28 +0100
X-Gm-Features: AWmQ_blgVg55or3EyJ2go7j43VTMSM_CtPJYz4izL2KNF_jSNbaJ7DwH95vB6ks
Message-ID: <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 13:29, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > Changes in v2:
> > > > >         - Limit the new QoS to CPUs  and make some corresponding =
renaming of the
> > > > >         functions along with name of the device node for user spa=
ce.
> > > > >         - Make sure we deal with the failure/error path correctly=
 when there are
> > > > >         no state available for s2idle.
> > > > >         - Add documentation.
> > > > >
> > > > > Some platforms supports multiple low-power states for CPUs that c=
an be used
> > > > > when entering system-wide suspend and s2idle in particular. Curre=
ntly we are
> > > > > always selecting the deepest possible state for the CPUs, which c=
an break the
> > > > > system-wakeup latency constraint that may be required for some us=
e-cases.
> > > > >
> > > > > Therefore, this series suggests to introduce a new interface for =
user-space,
> > > > > allowing us to specify the CPU system-wakeup QoS limit. The QoS l=
imit is then
> > > > > taken into account when selecting a suitable low-power state for =
s2idle.
> > > >
> > > > Last time we discussed this I said I would like the new limit to be
> > > > taken into account by regular "runtime" cpuidle because the "s2idle=
"
> > > > limit should not be less that the "runtime" limit (or at least it
> > > > would be illogical if that happened).
> > >
> > > Yes, we discussed this, but that was also before we concluded to add =
a
> > > new file for user-space to operate on after all.
> > >
> > > To me, it looks unnecessarily limiting to not allow them to be
> > > orthogonal,
> >
> > So what's the use case in which it makes sense to have a lower latency
> > limit for s2idle than for runtime?

Honestly, I don't know, but I just wanted to keep things more flexible.

> >
> > > but I am not insisting that it needs to be like this. I
> > > was just thinking that we do not necessarily have to care about the
> > > same use-case in runtime as in the system-suspend state. Moreover,
> > > nothing would prevent user-space from applying the same constraint to
> > > both of them, if that is needed.
> > >
> > > >
> > > > It looks like that could be implemented by making
> > > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit()
> > > > into account, couldn't it?
> > >
> > > Right, but I am not sure we want that. See above.
> >
> > I do or I need to be convinced that this is a bad idea.
>
> And there is a specific reason why I want that.
>
> Namely, say somebody wants to set the same limit for both s2idle and
> "runtime" cpuidle.  If the s2idle limit did not affect "runtime", they
> would need to open two device special files and write the same value
> to both of them.  Otherwise, they just need to use the s2idle limit
> and it will work for "runtime" automatically.

Right. User-space would need to open two files instead of one, but is
that really a problem?

What if user-space doesn't want to affect the runtime state-selection,
but cares only about a use-case that requires a cpu-wakeup constraint
when resuming from s2idle.

It's your call, I can change if you prefer, np!

Kind regards
Uffe

