Return-Path: <linux-pm+bounces-38171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE34C69807
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7D41349AC0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE624BD1A;
	Tue, 18 Nov 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNrvN5im"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05B23C50A
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470661; cv=none; b=EYPlzJBDXNT138xXI4t7u8cUE+C4NoRswgPokhqZbubCt9Vgzc4B+lbCmKZcGU5AcZy6zEdsSZU2WgqgbAvzqop7qV2/BaYE/DqMI4YuDfarqCQR4zel1QNE97LlB2iWHH2cYUPJmzHYr5lUyZFAfqYYApgP2Mh+37df9vdF134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470661; c=relaxed/simple;
	bh=FK7sk9cnm9w4kzCQbVcUvD+O2ZvTy6nVERaTCMpDdLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv10SCrw7sJLwbx8KBCbMaN1RbGwDMHxUEKA3wq/ywYclZecGLLxilY5hruZr9Wvs8DQ5DDPAKd+2EmEFJdzbnMAFd7CRqR3ieS2UrboYgTrMY8SMYTNbCrKbNTSIqJ1eYYbcj6nLAe1a4fHMiKGpQcPe9RxFYyrZsYhwAZ4OOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNrvN5im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4D3C2BCB2
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763470659;
	bh=FK7sk9cnm9w4kzCQbVcUvD+O2ZvTy6nVERaTCMpDdLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZNrvN5imFaWa1adsc3BdJQKvryViNYepJL0QQYTDFCiIk3va55zK5hfxxHogiR6ly
	 S9SdkDShIlwN7NQnwLmIZ1Bnn7HkmTnxdYtG9b9m0fKP/n4934tbzu6mkJyyU05QCp
	 XhXEwfMBTGfTTks4ZOtYt4D3cEFBbHLAgmk/olyR2UVdJAPbmIo/2eom2xwLJYNITq
	 e+bD3Hx/HazrnTqN3hg1bM+acV5mN1NverChg5dCqvN4DV0EiuN0vyCA7Xpl3dQnkZ
	 a7LCuBm8IgQXVMQZLxeAmcxUmWtEIyl0UY5QI9EVVPXHKfYTbDCFygiFdkbcUm1Ysn
	 DnNcd2Hbm005g==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45034dbaaabso2364920b6e.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 04:57:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULvCKkblgndbTj/Cr0JLJuCOCpS9i4ozpY4fM+EOqoMQqcXBb/n405EPAVUfiS++cMWXiBsdWVbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/AIvLT4YJ+ApVqliJc3ktLyfl3EQY0UY3/GpE+yvNn9Omkt/
	l8Gg1Wc6DM2RvRseDjZawPQEXwUahZut3X1L5LNMkGjmPYxLKy9nXNOlLpDTCYy0mYJdixVcG7p
	8AreXFs/tqEuh+VwZ1VEZalfpinfm6Eo=
X-Google-Smtp-Source: AGHT+IGxkvjf7P4mecouRr+VvLVf51szBgZ1gHGYre5Bj8YpM22VOv+3bGt5IyrPnvWQgB5S2PwVaVLRTF6EMxk2rSw=
X-Received: by 2002:a05:6808:1245:b0:43f:6727:b553 with SMTP id
 5614622812f47-45097458ba6mr7240381b6e.27.1763470658161; Tue, 18 Nov 2025
 04:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118090354.118553-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251118090354.118553-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 13:57:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hMKsttM9_zgcZ0SMHpNBwr1FYQP8z_99brwaX_8zi2Mw@mail.gmail.com>
X-Gm-Features: AWmQ_blADymbz3gIPriUaEDkXK104fvorClZHdsoSC4kACNMY_Sq2gOXVy10rXE
Message-ID: <CAJZ5v0hMKsttM9_zgcZ0SMHpNBwr1FYQP8z_99brwaX_8zi2Mw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Skip scheduling when update work is pending
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:06=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Avoid scheduling cpufreq policy update work when it's already
> pending by checking work_pending() before schedule_work(). This
> reduces unnecessary work queue churn and scheduling overhead under
> frequent notifier events.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d90dcffac953..49300cedd8d0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1222,7 +1222,8 @@ static int cpufreq_notifier_min(struct notifier_blo=
ck *nb, unsigned long freq,
>  {
>         struct cpufreq_policy *policy =3D container_of(nb, struct cpufreq=
_policy, nb_min);
>
> -       schedule_work(&policy->update);
> +       if (!work_pending(&policy->update))
> +               schedule_work(&policy->update);

This duplicates the test_and_set_bit(WORK_STRUCT_PENDING_BIT,
work_data_bits(work)) check in queue_work_on().  Why exactly?


>         return 0;
>  }
>
> @@ -1231,7 +1232,8 @@ static int cpufreq_notifier_max(struct notifier_blo=
ck *nb, unsigned long freq,
>  {
>         struct cpufreq_policy *policy =3D container_of(nb, struct cpufreq=
_policy, nb_max);
>
> -       schedule_work(&policy->update);
> +       if (!work_pending(&policy->update))
> +               schedule_work(&policy->update);

And same here.

>         return 0;
>  }
>
> @@ -1841,7 +1843,7 @@ static unsigned int cpufreq_verify_current_freq(str=
uct cpufreq_policy *policy, b
>                         return policy->cur;
>
>                 cpufreq_out_of_sync(policy, new_freq);
> -               if (update)
> +               if (update && !work_pending(&policy->update))
>                         schedule_work(&policy->update);
>         }
>
> --

