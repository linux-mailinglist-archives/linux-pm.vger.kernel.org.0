Return-Path: <linux-pm+bounces-10288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40C91E518
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9C51C21D9F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322016D4E8;
	Mon,  1 Jul 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRS9cFQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64616CD09;
	Mon,  1 Jul 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850552; cv=none; b=O15dlOlpUdbzYtLRjtzlFROPrvXLr479toHSN/pIjbLYLjY23ZQwAR/1a1UvUpBX8u/H0KcEiqV2OoG79o6YHCF9CpOa3+9RRHCZD/zHA6ABRXfn3V9J29amsWRWJPpO3nMRZ0kRjAlgRvb0nN4IssD1UI++gmkGxaw/8kc7Fns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850552; c=relaxed/simple;
	bh=6WeDN4O9CqsZITlUaWatsVbDiRibRXGUfWyTH4PNE7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+QlIgtMeT4sSek3tlyNQu35dAbWsJV/R1BrPw+cfWhVbbJ8tRk1PcKo7yWpYMcNSdsnKiQ3/ZhcrmgxRElnAdsrkVWPEHXAIASdDC82tCwTlfEUjXv7s+AYBFMqof6eKtUWsNr+3+cM9RKLwckju5jB4RK/flkOWIXgxdqskoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRS9cFQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238F2C4AF0F;
	Mon,  1 Jul 2024 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719850552;
	bh=6WeDN4O9CqsZITlUaWatsVbDiRibRXGUfWyTH4PNE7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eRS9cFQgfitWaNC+/gY9b2F4iYIVG4MzNrmtG0bE/FvE1JcoANIIS2gA5P9wT6/9M
	 8NTwLAhbaoZcZ6ibCxx/Ga2GqF0QIZOSWsmhFGF15sSpa1s6WU7I5yvOHnei/qyq1l
	 dF78pbrYIVBIN6FwmIZaH/dhLQPXfuv9qNbzitCO/QjVSDR3H61BZ+CSlWVnFM4/pV
	 xLgNWHP8pFbzxtNIvSabbbr4vgtkmcoW9OP9aHFWpzOoa3Tk57LYvZDJrsverJ+Wi1
	 xIHs3yj+t3+FfGA7XOFXqf0f3HnGrdsZAAz/qf0wfN0qNzyMw81pgbZMQKKo9jjaHf
	 xFGdqh102tc4Q==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25cd49906aeso416704fac.2;
        Mon, 01 Jul 2024 09:15:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQUPMME55VRcSmdyW0fdurDEC2JLL6+Rho3lLmQbOjEL0igldzyuz4ehojEipoRLm17IutxOZCGgaNcUw2VlK9iWTJsYBY7clq9AhjLMnjFOxWhXd+XAEWPNqzsyLVtuSpPzp+7DI=
X-Gm-Message-State: AOJu0Yyg4H/6y2zRZZzEv+it1w7Fq2sY0FEQuf8fU9Xhji07EbKIQDqH
	3ZpuqXiVhKAqyxVbdrF8i+hzU8Q1cwtB2SaAI4GJ27/vIm8OFqZvUCbflxpRjyrzby/JVnN2DzR
	yTAab0VpRaZhHHyBMf29veL2mKIk=
X-Google-Smtp-Source: AGHT+IFh/enPoUKNGEs4oUOY6HqFo+VjaGLpISFn8fxo3xPC4aSgmGXVDFt3twaLwzBH48fNasaBqvISCVRSZDdXeb0=
X-Received: by 2002:a05:6870:a349:b0:254:d417:34ff with SMTP id
 586e51a60fabf-25db3630354mr5941180fac.4.1719850551358; Mon, 01 Jul 2024
 09:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626204723.6237-1-mario.limonciello@amd.com>
 <CAJZ5v0hu1rVOLycx5K4YWOGhtC8YfSYupc8D6qygtXVGtvxJrQ@mail.gmail.com> <5ed06d29-a8b6-48f6-b341-3cd32c19c8d7@amd.com>
In-Reply-To: <5ed06d29-a8b6-48f6-b341-3cd32c19c8d7@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 18:15:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jtmpmg-7XvJ-OheWzTn=xbbiEZ8iu=F_tO3gaG9-rKDA@mail.gmail.com>
Message-ID: <CAJZ5v0jtmpmg-7XvJ-OheWzTn=xbbiEZ8iu=F_tO3gaG9-rKDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq: Allow drivers to advertise boost enabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Yipeng Zou <zouyipeng@huawei.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:12=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/27/2024 04:59, Rafael J. Wysocki wrote:
> > On Wed, Jun 26, 2024 at 10:47=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-poli=
cy
> >> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boos=
t
> >> policy incorrectly when boost has been enabled by the platform firmwar=
e
> >> initially even if a driver sets the policy up.
> >>
> >> This is because policy_has_boost_freq() assumes that there is a freque=
ncy
> >> table set up by the driver and that the boost frequencies are advertis=
ed
> >> in that table. This assumption doesn't work for acpi-cpufreq or
> >> amd-pstate. Only use this check to enable boost if it's not already
> >> enabled instead of also disabling it if alreayd enabled.
> >>
> >> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
> >> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> >> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs u=
sing cpufreq_boost_set_sw()")
> >
> > CC: stable I suppose?
>
> Yes, I didn't realize f37a4d6b4a2c came in 6.9, I had assumed it was
> 6.10.  But since it's 6.9, yes if you can please add stable tag when
> committing.

Applied as 6.10-rc material along with the [2/2].

I've added a Fixes: tag to the second patch and "Cc: stable" tags to
both patches.

Thanks!

> >
> >> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> >> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Cc: Dhruva Gole <d-gole@ti.com>
> >> Cc: Yipeng Zou <zouyipeng@huawei.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> v1->v2
> >>   * Pick up tags
> >> ---
> >>   drivers/cpufreq/cpufreq.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 1fdabb660231..270ea04fb616 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
> >>                  }
> >>
> >>                  /* Let the per-policy boost flag mirror the cpufreq_d=
river boost during init */
> >> -               policy->boost_enabled =3D cpufreq_boost_enabled() && p=
olicy_has_boost_freq(policy);
> >> +               if (cpufreq_boost_enabled() && policy_has_boost_freq(p=
olicy))
> >> +                       policy->boost_enabled =3D true;
> >>
> >>                  /*
> >>                   * The initialization has succeeded and the policy is=
 online.
> >> --
>

