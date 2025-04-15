Return-Path: <linux-pm+bounces-25445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7715A89796
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 11:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A987A2C3C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526C1DACA1;
	Tue, 15 Apr 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwCWIXWO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B68633F;
	Tue, 15 Apr 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708353; cv=none; b=Q75H3R/B/4wVji2VPGfu5SWzRl0srid6w+08jcYwU6dd6xoIDFgVd/wwsz1LAt892DxiFd4wStoTEF7Kofe/mOB++Y3Kif4ZKHFY+U5A2/gUvselV+kJbeWj7g2qoFW1aiHCgwBkwyV3ZeV0Qw7inucEmUWAPHdEZmZvxtiYa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708353; c=relaxed/simple;
	bh=1GPdp0yF1LxXZR2PHbVhmstt8gYYNiu8Be9hukxMSKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4QoUE3cP+LOZywyrSupHVpU4lF25SJ8KZqxdYpiLunLX+Pz3mwPiF0pTKXRLvYGm9WpzaAKWNJlD9qfZjvZpYVi/WzI9TJPPO3fL7oA63++2kg+f1pOn/swRxD9rTobmrzCuWPhow2Y+0riix2LswU4YtPhnlNkt99Cm3dtoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwCWIXWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EC4C4CEE9;
	Tue, 15 Apr 2025 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744708352;
	bh=1GPdp0yF1LxXZR2PHbVhmstt8gYYNiu8Be9hukxMSKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uwCWIXWOjs4ZUB2sl812nBkFDj5xJ5vtkezRCrfMst7XMGarouLL2tQyX+2LXZSLC
	 yIMOPEznBq3OBevBKvZnj+wpJ+HpVAfNHPHo8m2VVemN7Yl9J3XLoo1HHmM7NFEkCB
	 Vueh6uFD+qq2X8hUElD/NdeVUVfUO1y1d5Fgz+MJ3hpDITtga03UP2xmccwaz7wLi3
	 5/rcVarwn+SjJowQbT5pcs2wyLSbkmMWbLetH/dXVFo92yUksI3wbkXdqKgDUaGKBf
	 z4JVuZEKb77iGDhj3R9bHZveTMucORDqGBS8yz3bEmARCEQ2QcQHbTnJFjRHCHTY+W
	 iEdYqHTdCq8cw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cca475546fso2542037fac.1;
        Tue, 15 Apr 2025 02:12:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8NOEct9713y8Tu0feOiZcIUp6NeFtEAcCprLQDDr4irdEr8XB
	+PE1zM+OCuZN32Ror9vaV0EmI+1Ym8rU5TNvhqgzOy4PnGvqGpw7PLmXY44Ql/94jokUtKdH39M
	BK7tNKa8m2Ylyp9PMr+s04IdYeqI=
X-Google-Smtp-Source: AGHT+IHd6zT4M76Tkq99+iZ/V1LqHgTjfCOEic8maVILN3RMZaCDCPkYCIDpgaGK0+eePA5xmH+78+9WsSmN60/2cjo=
X-Received: by 2002:a05:6871:a582:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2d0d5efba95mr8488238fac.25.1744708351716; Tue, 15 Apr 2025
 02:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3364921.aeNJFYEL58@rjwysocki.net> <8533207.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <8533207.T7Z3S40VBb@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 11:12:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hwBA=EkE8aV5Gyn2R3JxsgSzg_F9pNMSkNgwzPUBKLow@mail.gmail.com>
X-Gm-Features: ATxdqUFxCYrrQbp2Dc0mDJWKB-pIhJh3_KXY5hQFXWXSYs6lax73wZnI9gBRquA
Message-ID: <CAJZ5v0hwBA=EkE8aV5Gyn2R3JxsgSzg_F9pNMSkNgwzPUBKLow@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] cpufreq/sched: Check fast_switch_enabled when
 setting need_freq_update
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Sultan Alsawaf <sultan@kerneltoast.com>, 
	Peter Zijlstra <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 10:52=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused
> by need_freq_update") overlooked the fact that when fast swtching is
> enabled, it is the only way to pick up new policy limits and so
> need_freq_update needs to be set in that case when limits_changed is
> set.
>
> This causes policy limits updates to be missed in some cases, so
> make sugov_should_update_freq() also set need_freq_update when the
> fast_switch_enabled policy flag is set.

Earlier today I realized that this patch would not be sufficient
because if the policy limits change, schedutil needed to invoke the
driver callback for the new limits to take effect regardless of
whether or not fast switching had been enabled.

After making this observation I've realized that there's a better fix
that covers all of the relevant cases, but it requires patch [2/5] to
be rebased and one more can be made between the new fix and patch
[2/5].

So there will be a v2.

> Fixes: 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused =
by need_freq_update")
> Closes: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org/
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -83,7 +83,9 @@
>
>         if (unlikely(sg_policy->limits_changed)) {
>                 sg_policy->limits_changed =3D false;
> -               sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
> +               sg_policy->need_freq_update =3D
> +                       sg_policy->policy->fast_switch_enabled ||
> +                       cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIM=
ITS);
>                 return true;
>         }
>
>
>
>
>

