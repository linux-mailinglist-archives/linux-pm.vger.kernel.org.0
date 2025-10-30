Return-Path: <linux-pm+bounces-37096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A20BC20059
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7705A4E1578
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF5131D389;
	Thu, 30 Oct 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IibPVDnY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804E31D371
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827398; cv=none; b=BYsro/MaGwolV02WDTrBOwxGbajdE1l71ZuNv6CieZQQ2P9MmbdYQ9RQfkzA0nHHg7nCZubR2TVovK8VAXV9ToITrdghnzBvfw7F9bSc5IsU95pEzzr0uI7qhvDnrwOxY6tK+VbvQUE9s1RNyWkmleu8TmNvv2XSTxbmx2M5z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827398; c=relaxed/simple;
	bh=rb7KJ4lm+lTgntNGtYvel1Kk766lsCEqeiYHLnei13c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+gfmzmwy7Z8yk1CedQHiRNS0yX5/3XSb7RH/QpC+/h3keELeyXXvqlDvjQD54nMYVfsA4USHnW0s+HP+Dc92mQ3mS46C4BWpLGoi8TmfaJil12NkEzLItb2OJlU70vUw5XQqYgd63bMwG0Ibhh+2vzVXV1gQ+lhJpDxMRPWUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IibPVDnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42E0C19423
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761827397;
	bh=rb7KJ4lm+lTgntNGtYvel1Kk766lsCEqeiYHLnei13c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IibPVDnYSfk83fSPeDf6d9bMWHYBAnPXkVH++Wb5AV+kk98K624IgxW74c1VAojLd
	 j9FWqngKxV3v0mK1JgGntDUDvcj1ZBtyHoqYFsDpquWfKH8YCxsIPgzFWdfmiYSnyZ
	 YQ+qIqkBP4G5LT6fkYtIYGms+aixR+VQw+DZae4ft4ktFIpHd3fGJLctP4QsJXICX1
	 GFG6TsZe3ODmAcdqZyGGba89R9VYuCLlXz6kS+uTenGq5zReJninDrqM/xUKiKoCfy
	 D32oOi4Xtz32qjJ0TRiPVjyzIHpK3DH3bjH37KTXFe4DBK/p/Sp/8oXEpcBUyxaZ8o
	 B13EfNJUhjLkA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44f7be0adcfso427665b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:29:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwPKDQW9gpXSBld7EGkbtTpHOXnhS45VRDLjks7wsV+iNRtEVPB
	xjNMUpNtO6MyFSlnHho8byFyjq8yB6m0+ifa9SJuCoV16NySBWFpXihHCEiXF3qx3uCRcn7nC57
	q/UrjGbpbAoPhq/0nO9I8BDyxpobyxF4=
X-Google-Smtp-Source: AGHT+IFxwuyUEeE99wvIHGl9C6aRfo5aq6K935b+AbUJD9C6lFGxkhheH3LrBS9iHmPn5WRJYMocfm2/N/4spskuZgc=
X-Received: by 2002:a05:6808:8808:b0:44f:8f02:d62a with SMTP id
 5614622812f47-44f8f02f722mr498779b6e.7.1761827397144; Thu, 30 Oct 2025
 05:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
 <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com> <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
In-Reply-To: <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 13:29:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
X-Gm-Features: AWmQ_bkp1xgP5FOMdJYNN0N7vetKE4ou-z6OOPBv8RAC9ZhmkL7F4GkRwbLdMwQ
Message-ID: <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > Changes in v2:
> > > >         - Limit the new QoS to CPUs  and make some corresponding re=
naming of the
> > > >         functions along with name of the device node for user space=
.
> > > >         - Make sure we deal with the failure/error path correctly w=
hen there are
> > > >         no state available for s2idle.
> > > >         - Add documentation.
> > > >
> > > > Some platforms supports multiple low-power states for CPUs that can=
 be used
> > > > when entering system-wide suspend and s2idle in particular. Current=
ly we are
> > > > always selecting the deepest possible state for the CPUs, which can=
 break the
> > > > system-wakeup latency constraint that may be required for some use-=
cases.
> > > >
> > > > Therefore, this series suggests to introduce a new interface for us=
er-space,
> > > > allowing us to specify the CPU system-wakeup QoS limit. The QoS lim=
it is then
> > > > taken into account when selecting a suitable low-power state for s2=
idle.
> > >
> > > Last time we discussed this I said I would like the new limit to be
> > > taken into account by regular "runtime" cpuidle because the "s2idle"
> > > limit should not be less that the "runtime" limit (or at least it
> > > would be illogical if that happened).
> >
> > Yes, we discussed this, but that was also before we concluded to add a
> > new file for user-space to operate on after all.
> >
> > To me, it looks unnecessarily limiting to not allow them to be
> > orthogonal,
>
> So what's the use case in which it makes sense to have a lower latency
> limit for s2idle than for runtime?
>
> > but I am not insisting that it needs to be like this. I
> > was just thinking that we do not necessarily have to care about the
> > same use-case in runtime as in the system-suspend state. Moreover,
> > nothing would prevent user-space from applying the same constraint to
> > both of them, if that is needed.
> >
> > >
> > > It looks like that could be implemented by making
> > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit()
> > > into account, couldn't it?
> >
> > Right, but I am not sure we want that. See above.
>
> I do or I need to be convinced that this is a bad idea.

And there is a specific reason why I want that.

Namely, say somebody wants to set the same limit for both s2idle and
"runtime" cpuidle.  If the s2idle limit did not affect "runtime", they
would need to open two device special files and write the same value
to both of them.  Otherwise, they just need to use the s2idle limit
and it will work for "runtime" automatically.

