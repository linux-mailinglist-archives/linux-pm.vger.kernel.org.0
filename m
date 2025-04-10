Return-Path: <linux-pm+bounces-25092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E6BA83F26
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45D316BE0C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B102686AB;
	Thu, 10 Apr 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRL6j1fj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389526772E
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278186; cv=none; b=TM33J1qVyTkDfTyJnlsFbkTESPBLAy44raCd2QtzAMF+zM44k1ipihfM1DT2hMes+BZQuk/W1RV58pF4PnzRPL87IjP2JpXJz4kzovBWhcTbTa3k2U0GV0yCzrLIXjvUUFTZ40YUDuFRy9/mrdhJxUFFyQqo8p3LKTE0sqsciqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278186; c=relaxed/simple;
	bh=HlGIfDWHUCMQsRs1JADPrHxGJcAiiwrY6eSSX2lthrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFYMKVujUYr9wrOV3vwxnN6CfkptzlcoAe3FymsTRYg8Zrh6a9jBI8Z09TdsntmiMLMtxXN4aHeruNmQWeaCfARaWB7G0mVNoxHncUxU7AfS/U0VCQFu6LXp+20DvmKbN21bw0UaJ1hMd5BGs1zwmQInHdwG9shlgFN9CON1Fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRL6j1fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F76C4CEEA
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744278186;
	bh=HlGIfDWHUCMQsRs1JADPrHxGJcAiiwrY6eSSX2lthrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PRL6j1fj0q/897aS+Er3wuGhm3gKp5Vk01C3rWBxZ8PiDghQt1NuCkV5vLwXp5UZ2
	 XRGDOeu6VRrG7rjXKrC2bOWR0+GqDAMAEd3QF0PhCJmmKSh/f/bk/r5nfDp35gImyZ
	 WMefha3A3M+B5VknAVqfywdnC4X9n0KS2Tg2PDlCzO/KF0DQAp+/cOslgzEyw8+3SC
	 hWO44Yhp3SNlV7fA70KssjYjf9EqI+QjeaPOMriF3tV8pfRk2hbWlwqkq7hM+FLbqg
	 ZJ6pQw9ql7SQ7M3VzPD+oqT/eQ02v2/5vYp+wOu0frt0Qik52N5O7FACOjyM+Es5zJ
	 gY+5X9DwTHYwg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6042c04fd18so292609eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 02:43:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQqe4bIkiJU9Qum7oB4U+QkFRMtsSzA+0WhuOGkqCy+QgEzq1WANlTnUABtd3tc5QMyCH8EjWJ8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqPVO0JsiVWGzH60GX5Z83Pi6dpZjKolh8w5Tt0aWiZa2EGcj
	kT0Wqn8E8NaRSZ6UOtWM93jw4pY25dvd4l81iLQdJ8MPM0j9CJAejb52bfYeaJiEE4NgkCH+8xD
	hWSgFvF6PfDO5OQzuLFxuFjkWs7s=
X-Google-Smtp-Source: AGHT+IGH4in6q85gWtly4VxdkrA/1RIkuA/TzECu931mpALTILyIsQBWHS8kf8nRHtv9hfQFdO+JUq9KKLKEYpjtL6I=
X-Received: by 2002:a05:6870:6f14:b0:29e:53cc:a6c1 with SMTP id
 586e51a60fabf-2d0b3593597mr1217735fac.6.1744278185422; Thu, 10 Apr 2025
 02:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <765545b5-f278-47a9-8a67-904cbff177c2@stanley.mountain>
In-Reply-To: <765545b5-f278-47a9-8a67-904cbff177c2@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 11:42:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFhHrdEUj5ygOKcq9JhHdN-66Kua4oRup-swOi-QcXeg@mail.gmail.com>
X-Gm-Features: ATxdqUGOhBgCkqkQxYYEfcXzWJLT-Cfgdol9dCbkZkf7hwLN7NDkH8tq_Ax5ohg
Message-ID: <CAJZ5v0jFhHrdEUj5ygOKcq9JhHdN-66Kua4oRup-swOi-QcXeg@mail.gmail.com>
Subject: Re: [bug report] cpufreq: Use __free() for policy reference counting cleanup
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:02=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Rafael J. Wysocki,
>
> Commit 5b90b0ce2705 ("cpufreq: Use __free() for policy reference
> counting cleanup") from Mar 28, 2025 (linux-next), leads to the
> following Smatch static checker warning:
>
>         drivers/cpufreq/cpufreq.c:2562 cpufreq_get_policy()
>         error: uninitialized symbol 'cpu_policy'.
>
> drivers/cpufreq/cpufreq.c
>     2552 /**
>     2553  * cpufreq_get_policy - get the current cpufreq_policy
>     2554  * @policy: struct cpufreq_policy into which the current cpufreq=
_policy
>     2555  *        is written
>     2556  * @cpu: CPU to find the policy for
>     2557  *
>     2558  * Reads the current cpufreq policy.
>     2559  */
>     2560 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned i=
nt cpu)
>     2561 {
> --> 2562         struct cpufreq_policy *cpu_policy __free(put_cpufreq_pol=
icy);
>     2563
>     2564         if (!policy)
>     2565                 return -EINVAL;
>
> If policy is NULL then we call put_cpufreq_policy() on an uninitialized
> pointer.  But this function is never called so it's dead code.

Yes, it is, I'll remove it.

>     2566
>     2567         cpu_policy =3D cpufreq_cpu_get(cpu);
>     2568         if (!cpu_policy)
>     2569                 return -EINVAL;
>     2570
>     2571         memcpy(policy, cpu_policy, sizeof(*policy));
>     2572
>     2573         return 0;
>     2574 }

Thanks for the report!

