Return-Path: <linux-pm+bounces-28978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D42ADEF8B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9853A3AB1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2722EAB6C;
	Wed, 18 Jun 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEGS72Q2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BED2BD580;
	Wed, 18 Jun 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257142; cv=none; b=ZYmgxnfq91bwAJae0/bmpCuBBDYY8P8EjZ57D64tdlzBjYNY3ob4te9lXysaAKDaF/JMdNLO47d3OXXI21v1rh7htWZVHA4wvm6j43O+W2I0mRKrbQmxy6Skq7qi9q2H4xlF9gFga0ct7xEWSo77hV4Pl8vUCr8ow0ZFjvUY7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257142; c=relaxed/simple;
	bh=V8eaORNjnFPC22A0/d3yLomnU28tvdggdXeDDIXrCKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMnLmKswrXKWGBgXq/TYGKVtLUbfBBQbBJ97seAO/YIOGKVBqja9jO8HYrtgGxsYBqbIE9LKRET+ixkwOKpYVBVW7OFl19CQ+rG0bssdRGxFUhhc0f0+Y1QJYLxlpRzmc3Isf3NIVOSa/BaSPBsGzKmNNniO+bLUWAIpOgurnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEGS72Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B6BC4CEE7;
	Wed, 18 Jun 2025 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750257141;
	bh=V8eaORNjnFPC22A0/d3yLomnU28tvdggdXeDDIXrCKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YEGS72Q2ZJzBOUIyajwfjpAIMWK/tyAVBLDjfrEllriKYZ6S4VKWDI4FB5Xc5OnIG
	 Wm+U7ciGJk7nzNSRYWw90xmDkCln8Rw9r8fa1639pxhKb88b3KgBrL/pnycYEJW7f5
	 mGZTkA4xGt1znr9lyeDCI/zUNJnd3YiTuuzFUyiLB4EjFtyebRJi2wL7Cd0FGMl9+p
	 AaWcyzUSHIP17lPIetr9i/OMlpMYGNGYabYtyIMt4lglTrH9vFWNvCsXWLjqjEAgtr
	 Ki0IJfvJazEEyUSJ+M80gc3Dd3bwf4EFrIZ1TTraOxWi1jUiqDgUfPVMRqtCqDx1mB
	 JwAYteBlT8znA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-401c43671ecso432292b6e.0;
        Wed, 18 Jun 2025 07:32:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVX5U94BMtTyOPgMxb1QbqcWSJtsBFviqQTsT+GsSZYKzLb2i7mTUeahS9Z2lXvy37iawI/DBwS0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhZtWlAAK5cJvEAV/gjRGohtYgs8/TP7tj0Ez8bX9MpgGiUv9
	PyQIg4C1sMAjbAg9r6EniGCX5nY+u6TuMwoJt9C0U7Bt74zh6ZqoK1uQtm4t5y9XGkhQKSSnJSS
	anDXTQHRWSlH/YvnJpfAVNFlTam1eRU0=
X-Google-Smtp-Source: AGHT+IEMWQzU4qSxFGgnXR1oAO890etvB+SwwceD3DtIK7Rz0Kbb9cuKlsziJPU77G00CBYvKhFqYV9MGlTNLgJyvkI=
X-Received: by 2002:a05:6808:219d:b0:408:fe75:419f with SMTP id
 5614622812f47-40aa50a1914mr1946169b6e.13.1750257141152; Wed, 18 Jun 2025
 07:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
In-Reply-To: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 16:32:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0heNSqHKZsmzu8N_hNKXeg_BZ0g4p0=dQtkDxBFHN+=4w@mail.gmail.com>
X-Gm-Features: AX0GCFub_XQB-Nx6VCmcYgV4QdnK-y_zYRigJUBid2VEBPcrD3AXPutY_721zm8
Message-ID: <CAJZ5v0heNSqHKZsmzu8N_hNKXeg_BZ0g4p0=dQtkDxBFHN+=4w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix initialization with disabled boost
To: Christian Loehle <christian.loehle@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:25=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> The boost_enabled early return in policy_set_boost() caused
> the boost disabled at initialization to not actually set the
> initial policy->max, therefore effectively enabling boost while
> it should have been enabled.

Did you mean "disabled"?

It would be good to mention the failure scenario here too.

> Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..e85139bd0436 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
>          */
>         if (cpufreq_driver->set_boost && policy->boost_supported &&
>             (new_policy || !cpufreq_boost_enabled())) {
> -               ret =3D policy_set_boost(policy, cpufreq_boost_enabled())=
;
> +               ret =3D cpufreq_driver->set_boost(policy, cpufreq_boost_e=
nabled());
>                 if (ret) {
>                         /* If the set_boost fails, the online operation i=
s not affected */
>                         pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__,=
 policy->cpu,
> --
> 2.34.1

