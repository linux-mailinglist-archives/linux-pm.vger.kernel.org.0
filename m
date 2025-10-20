Return-Path: <linux-pm+bounces-36508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3BBF31BC
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5E840603D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7A2C3263;
	Mon, 20 Oct 2025 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO3HZPXL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8C28BAB1
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987072; cv=none; b=CP/ZNkfV2XlNcWnPCP2T8ZO0YeLXCQUH6lhRXoid/0GPV6zRMO0kVRmlWOzOywCFF6sw12FgvxAELCfVyhtoEdwmaU91f2/+LOlXiSD3nxhlRfj2/8iT7oO/ZIJ9kWMpm0uN6t++PmkWxaa466XHnpljpiV6MTY4c1t3ghQl2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987072; c=relaxed/simple;
	bh=la2SNRyOuUL1EroP0cyfJMdhcrK+Fhus7+Rn3W6MB2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=up1PYRDZgRoYSFLnxIgxfwjGpTPX1AHpQ7JGqc9q7pUS/uJSyHuCi75jK2TAjFipmNMob1Ms3uejQ47u1sjURuEd4XlPp9467NicC/qIJ+0siVUv5tV7hNKaBDCdb8uZBWHlP32a7ACTm/GORdLt1C0vX02XNb/YEy0kPrnaKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO3HZPXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6C8C116D0
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760987072;
	bh=la2SNRyOuUL1EroP0cyfJMdhcrK+Fhus7+Rn3W6MB2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AO3HZPXLF1e6rZin4schtZWty2lv9xfLEqlI3lIa2eo3yApunlF/ouE63UwvboZnq
	 rldbczlTHbNmeRKhUetE9qNOBBcN3o/z+eD8R3ABsoOltC4wxhrCM12ZO37Tu+TbcZ
	 N/GHnBZafwzN29jK9mU+Tn52jHKCNxkZvIIhlanlbjXxqGHD+8ZCjBxwHL1W3unn7+
	 sA5ymBFP1pe6sOPYBweKelSM3i1bMwivC57cvlpD64/TyAMukwcBQx9IxcZosjgA/k
	 4+Vg02BtoqGDPBKFzPOboR0uN6Jx1NsFBIp9LyEIul+qAQpvAxZOJyD8jxmfs2SzXf
	 Q5+sBluj3PYvg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4439f1cb764so2435153b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:04:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgmeCe0rku1QKJhAVmThHl6BLoIYf7UNT4GcW2ydpVhgTHSBKhYOtW9pirjACfk6PZzStEoVeP0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2cp+36cW9tTl1Wz+rLA1Yn1NcAHTmmx9AFL9zbUkX+mGySZR
	wOA2xTQuj8iGDPve62DD1SjsQNN4QeoKAplK1htZnaAovm7sgRhmHhgjRyRKQzZ6lSUO71FpTMU
	KuqJUZTPTzEpt4qr6B1lmZPfH1LHn6Us=
X-Google-Smtp-Source: AGHT+IH2YwF5IgfEZBDiCNDTtJ4zxwtEoO0dMgpApSlIVsF+6kCQO4qUFCcXU32gMhAVur0/d18jXf1G70X2mafsg3A=
X-Received: by 2002:a05:6808:4442:b0:441:8f74:fc0 with SMTP id
 5614622812f47-443a31b76ddmr6748203b6e.61.1760987071710; Mon, 20 Oct 2025
 12:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011072420.11495-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20251011072420.11495-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 21:04:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTR-0mbODbYPjbNcS-xx7AxF48ZtKrcqv--v_knY9xNg@mail.gmail.com>
X-Gm-Features: AS18NWCBY11AETUvwsQS5L9kv9qDCzJWMLRGrhRc-IRGBcJL32hORwGcmN_JcD4
Message-ID: <CAJZ5v0iTR-0mbODbYPjbNcS-xx7AxF48ZtKrcqv--v_knY9xNg@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: preserve freq_table_sorted across suspend/hibernate
To: zzhwaxy <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 9:24=E2=80=AFAM zzhwaxy <zhangzihuan@kylinos.cn> wr=
ote:
>
> From: Zihuan Zhang <zhangzihuan@kylinos.cn>
>
> During S3/S4 suspend and resume, cpufreq policies are not freed or
> recreated; the freq_table and policy structure remain intact. However,
> set_freq_table_sorted() currently resets policy->freq_table_sorted to
> UNSORTED unconditionally, which is unnecessary since the table order
> does not change across suspend/resume.
>
> This patch adds a check to skip validation if policy->freq_table_sorted
> is already ASCENDING or DESCENDING. This avoids unnecessary traversal
> of the frequency table on S3/S4 resume or repeated online events,
> reducing overhead while preserving correctness.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 852e024facc3..4a27f6cb07d3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1421,9 +1421,12 @@ static int cpufreq_policy_online(struct cpufreq_po=
licy *policy,
>                  * If there is a problem with its frequency table, take i=
t
>                  * offline and drop it.
>                  */
> -               ret =3D cpufreq_table_validate_and_sort(policy);
> -               if (ret)
> -                       goto out_offline_policy;
> +               if (policy->freq_table_sorted !=3D CPUFREQ_TABLE_SORTED_A=
SCENDING &&
> +                   policy->freq_table_sorted !=3D CPUFREQ_TABLE_SORTED_D=
ESCENDING) {
> +                       ret =3D cpufreq_table_validate_and_sort(policy);
> +                       if (ret)
> +                               goto out_offline_policy;
> +               }
>
>                 /* related_cpus should at least include policy->cpus. */
>                 cpumask_copy(policy->related_cpus, policy->cpus);
> --

Applied as 6.19 material, thanks!

