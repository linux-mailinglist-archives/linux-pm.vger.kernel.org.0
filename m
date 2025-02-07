Return-Path: <linux-pm+bounces-21546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A815A2C752
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7873A2871
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C691CEAC2;
	Fri,  7 Feb 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4ut1yQf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03F238D26;
	Fri,  7 Feb 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942563; cv=none; b=PDccOy/nj+npnMl8Ct/4ARYcsfuAkDVmyGLt2oI621RHHn0uIluuekMjJsaKPAJO8o/bGeyCnlgyUpWYro+4yJ4DzfkGKNiOlcEtZKEmpFRIhX60cvBkmgr8tFqsUHdPofvXfZY34oNH/w++vVvizOxN3VTmDNs5hL4E964/4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942563; c=relaxed/simple;
	bh=eKpgUtAgKnXTGC6co7uKVWueEzNDPDo4Nk/czisWYtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzOgQQy1RsmK9vebcBeNvAHTgnfz/xEuZC/MuxI3Luwm9KbBPJiGKS7hisbpVQya2UhGJeDJbrHxCe2IcU2kdIas6JZ9YwBJtCMM3Vtavct474s2ZRU4M5l9ScNCIPPozYWdYHg95xXLho/joY8UgiNHXYAJ61xbQj0ep9fMaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4ut1yQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F86C4CEE7;
	Fri,  7 Feb 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738942562;
	bh=eKpgUtAgKnXTGC6co7uKVWueEzNDPDo4Nk/czisWYtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d4ut1yQfA3Pk3v+NsBRvsw5imZrHkQALoPXxQQc55SaiXNe4AiaTrpTpgRIipNNeA
	 ySqgK3NgnS1He0wCD57KnEOHQ+VvT83sWS71xIlI8Xiqq3k7sIumhArxicHBf2/c+y
	 xZMurC/mLajsp+tWySjRviAzMCovcC/Hj9o+AdTv/m9uLm75HoPeCLLCH4wgc9K4HL
	 NJUgDAna3AZeGdPf3IHgeSMNujwlpcPOU2uaw9aZvCJGr/EoQDskpmvMmM7vpXPZZ0
	 e+HDIofcaFLlhjr38FwPOAQC0+Ky/Y9kNYFZoeOVxtZIH8FKM9g0ASfLFYpFIYKg98
	 wHYv5V2c5ztyQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e2766994bso1275581a34.3;
        Fri, 07 Feb 2025 07:36:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsALLTIWbJjJKUYK7xqTY69HM6LsLMrJChyBm5GXmo4KfvDIV4jyXdnXnW3pLNXoQGSsFS7Y7quYF+RpM=@vger.kernel.org, AJvYcCX91xst/nd3y2eirOWNXrXB+db6JjIrjJ1anaspevC32K73n5lB49YZOSNmCKCILyKc3mZPW0FvDy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2/919WMdyOyYWmpGZ27RxbwKoe36iRfi3TjivOvu/0XW/viL
	NgKUiKBE7AlE2MDb4A2+Jns6KMREf5nMoU+h4awVz/Gjle9g/3IXDkOL0lGQO5+7Z+RcpRtEsN7
	SqPWHeloW0mfJg+TScoEgb6J+tH8=
X-Google-Smtp-Source: AGHT+IGDqX02CBpJr/9unc9HxWUlrUy3BWcAJQWZ9KGi7lke/D7VSaQ5LkwjmEIBLLPhGSFgK6ZZxlvDoGw17vx9UGo=
X-Received: by 2002:a05:6830:6e12:b0:71d:eb02:baed with SMTP id
 46e09a7af769-726b87da973mr2863629a34.8.1738942561839; Fri, 07 Feb 2025
 07:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
 <29daaf17-7711-44b1-baad-86dadcf01666@arm.com>
In-Reply-To: <29daaf17-7711-44b1-baad-86dadcf01666@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 16:35:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jUM6TKJuJsA9ZJF1PvnudOmJFd0RC26iQd0zQSWM+wnA@mail.gmail.com>
X-Gm-Features: AWEUYZkFtzMjH24WMjqwIJWFD9HdS0B_DDWuxd0jrQeHeGeKWcJj0_-js2jJPyM
Message-ID: <CAJZ5v0jUM6TKJuJsA9ZJF1PvnudOmJFd0RC26iQd0zQSWM+wnA@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Christian Loehle <christian.loehle@arm.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:24=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/7/25 14:48, Artem Bityutskiy wrote:
> > Hi,
> >
> > thanks for the patches!
> >
> > On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
> >> Hi Everyone,
> >>
> >> This work had been triggered by a report that commit 0611a640e60a ("ev=
entpoll:
> >> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS met=
ric of
> >> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it ge=
nerally
> >> reduced kernel overhead.  Indeed, it was found during further investig=
ation
> >> that the total interrupt rate while running the SPECjbb workload had f=
allen as
> >> a result of that commit by 55% and the local timer interrupt rate had =
fallen
> >> by
> >> almost 80%.
> >
> > I ran SPECjbb2015 with and it doubles critical-jOPS and basically makes=
 it
> > "normal" again. Thanks!
> >
> > Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
>
> I'll go take a look in-depth, honestly the statistical test of
> get_typical_interval() is somewhat black magic to me before and after
> 4/5, so if that actually works better fine with me.
> I'll run some tests, too.

Thank you!

