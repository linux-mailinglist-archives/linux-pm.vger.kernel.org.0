Return-Path: <linux-pm+bounces-21488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A8A2AB8D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662D63A90E7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA9A23642B;
	Thu,  6 Feb 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYNHlu9L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A2236420;
	Thu,  6 Feb 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852656; cv=none; b=UBpHVIgzwjIf6mCMr0f8BxV138f+FrFija4pngoo9KTwSAj7jUmzm75cDv9KnKDDMcgL2zPSggLsctd3GwTZEk9Raw0BShkxU5eax1Torn4JFcZuvXyiQKhrkqL5grlevnQZ8MovfFEMkVVrtLpIX4dCBaPFWvgAy75BEVnYNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852656; c=relaxed/simple;
	bh=4uK47KEygQEWwVGcoVZkeuoHQF2iiSJDgicszxMhLUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5ai2n9+m4KEaF7gcAeppKY/eLApeYT1/q0HLCZXxVzrdOGK7eVZQ1nJ/HckES6/dvcQg2lW1Q7ZhLk/yKiDO0snUIdWgJyHmIzFP3fcNAUOfxkytRdYPbvIDTeh1HeEVbqc5m+nBOfyraRL9v2C9qyNIYIlowP86E73kgrsM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYNHlu9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B04C4CEE2;
	Thu,  6 Feb 2025 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738852656;
	bh=4uK47KEygQEWwVGcoVZkeuoHQF2iiSJDgicszxMhLUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cYNHlu9Li16/cYWcECllsDQkMwp2U97D6xVnP/8nzhJTAEsXMTsiQhC8pZHLAlABY
	 85hGt0RWff2gJotCXsWO7d/ARUxGF0Tqi5VR23W32Sk8T35fkMVPm/8jzd1UDEsAwx
	 pAscphsIJ5bXztzp2HNNbRETz4RhQyk19LSMCBS+1NTWdEDSMxnGYWW3Cctop2174I
	 ccl3VsNOYeaX0fLZYanmqkSCu+04H/849FA+VdSFwPIgjhVL4HV9P1xaEADmeDop5Y
	 lo0UeTw39pECPnMd4E4zWwm0lPAY70PoSNXlk9BRwvXI3blMOCKG6yR68Nss0spp+K
	 rBYa2KMX7O8gQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f37207259bso315023b6e.1;
        Thu, 06 Feb 2025 06:37:36 -0800 (PST)
X-Gm-Message-State: AOJu0YzkbOKoE6Xhl/iYMKpBwYXBjHxs+8AUoWr+ldmTRxsaSbi8ALEv
	5ubkNORlB+Z7qUr0QHxSjvhQVZcwrC1ufa/fSJ/7f3OO12t1TV6y715/huq48m83PRTR8sDbqbk
	MTR0vnfVsR5kb0VMT2QGR5cfIwPU=
X-Google-Smtp-Source: AGHT+IFqvm0IT213/DuLt1yySZz9h6W/+Lgpa3XAdb39n5pbDxYtVyQhvT9JQ/FRsPvebCcRG1HvpSiXFmcHbSZVRKI=
X-Received: by 2002:a05:6808:1706:b0:3ea:4e7c:a91a with SMTP id
 5614622812f47-3f37c1da666mr5218854b6e.34.1738852655622; Thu, 06 Feb 2025
 06:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12630185.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12630185.O9o76ZdvQC@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Feb 2025 15:37:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hCQ0nm+yy+Fg25kKX-76eZAR9r-855FrPLjiA4ytuufQ@mail.gmail.com>
X-Gm-Features: AWEUYZkL0yQLslAU0j1j8oFF-2xzqbXOFs-8dR946nFfkTScbiU8mjTRkXUyuW8
Message-ID: <CAJZ5v0hCQ0nm+yy+Fg25kKX-76eZAR9r-855FrPLjiA4ytuufQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:58=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It has been observed that the recent teo governor update which concluded
> with commit 16c8d7586c19 ("cpuidle: teo: Skip sleep length computation
> for low latency constraints") caused the max-jOPS score of the SPECjbb
> 2015 benchmark [1] on Intel Granite Rapids to decrease by around 1.4%.
> While it may be argued that this is not a significant increase, the
> previous score can be restored by tweaking the inequality used by teo
> to decide whether or not to preselect the deepest enabled idle state.
> That change also causes the critical-jOPS score of SPECjbb to increase
> by around 2%.
>
> Namely, the likelihood of selecting the deepest enabled idle state in
> teo on the platform in question has increased after commit 13ed5c4a6d9c
> ("cpuidle: teo: Skip getting the sleep length if wakeups are very
> frequent") because some timer wakeups were previously counted as non-
> timer ones and they were effectively added to the left-hand side of the
> inequality deciding whether or not to preselect the deepest idle state.
>
> Many of them are now (accurately) counted as timer wakeups, so the left-
> hand side of that inequality is now effectively smaller in some cases,
> especially when timer wakeups often occur in the range below the target
> residency of the deepest enabled idle state and idle states with target
> residencies below CPUIDLE_FLAG_POLLING are often selected, but the
> majority of recent idle intervals are still above that value most of
> the time.  As a result, the deepest enabled idle state may be selected
> more often than it used to be selected in some cases.
>
> To counter that effect, add the sum of the hits metric for all of the
> idle states below the candidate one (which is the deepest enabled idle
> state at that point) to the left-hand side of the inequality mentioned
> above.  This will cause it to be more balanced because, in principle,
> putting both timer and non-timer wakeups on both sides of it is more
> consistent than only taking into account the timer wakeups in the range
> above the target residency of the deepest enabled idle state.
>
> Link: https://www.spec.org/jbb2015/
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -349,13 +349,13 @@
>         }
>
>         /*
> -        * If the sum of the intercepts metric for all of the idle states
> -        * shallower than the current candidate one (idx) is greater than=
 the
> +        * If the sum of the intercepts and hits metric for all of the id=
le
> +        * states below the current candidate one (idx) is greater than t=
he
>          * sum of the intercepts and hits metrics for the candidate state=
 and
>          * all of the deeper states, a shallower idle state is likely to =
be a
>          * better choice.
>          */
> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> +       if (2 * (idx_intercept_sum + idx_hit_sum) > cpu_data->total) {
>                 int first_suitable_idx =3D idx;
>
>                 /*

For easier reference/testing this has been exposed in the git branch at

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dexperimental/teo-tweak

on top of the cpuidle material that went into 6.14-rc1.

