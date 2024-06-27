Return-Path: <linux-pm+bounces-10105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E691A349
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076AA288009
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0A13BC26;
	Thu, 27 Jun 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUga8pSX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D913A245;
	Thu, 27 Jun 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482367; cv=none; b=KzFbr1o+uxHLeqKJAD02xjA6gqX9ydQVF+RYxR1s/sR2/Hb9PC3kWT+iZJ/bHc6QB0K4saAsRiP236H3z+2bYWDvVoisZsFf1JFjW18id7cfeOVU9dfJ5bGBxOShsJVEqPPQu3MLnA4XXj0up6C7ZeGykdchTXC6QCFnSAK6MRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482367; c=relaxed/simple;
	bh=a9Mxfd606of0B4EqCbsaptQNWRMBax7xX9L9ksTGFQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEe0JD8zr7N+nMFEBaw167rPjE+jCg9hitQEev+kO/P66amYdeHXabfgrFftHG+6ECld+Sg0aZrK03gArDGv9XlXno8l0WDcKOvDj6K2VpFEB8cx1UT4mr/6uuTPCqNMZXrm2BPr89HGMdEkvCqQk2Qgbkhn4Yk4YLvA7jaDKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUga8pSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76BC2BBFC;
	Thu, 27 Jun 2024 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482366;
	bh=a9Mxfd606of0B4EqCbsaptQNWRMBax7xX9L9ksTGFQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUga8pSX1ohH5+wjutqBGqU1EbmbBj1YzyxXG1aPJ7+/k37KssBUcmvBIxsos2OzO
	 7+PcGgTqMpwzol0322lSIIh3e3OKwFAgKXqFZWMi+VTxTbUpv0JihPw4SSWHD7h3Lx
	 2AvibcADONJRut0pNsoXaJwoxFp5/Cgo4eXUzKOCBORzx/BTPfJ0kBfvRdCEVJQCtv
	 aZKd5mMSRyxnnUgvWg485+2iEpzmDlKVjH8lQPdHgJZv0qQxKJFD5TCgtbnzW8aoD0
	 JLWyS/ULporuwExs8UyW7NbkCI39oLJISoYZnPSt50OeXcSAWdPY8nPeidulMXYyK7
	 xgNWGA8FcydKg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25cb5ee9d2dso819216fac.1;
        Thu, 27 Jun 2024 02:59:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXru/Xoh8SlsmR8iyYli2LDaVLIWtyaaOnHxDfELpHMhDcPDmK8lmNKUVnpP4AUcnsR0m/SuvPu2IpPS0Xk/jWcpzkcJzoJDN02FkIa
X-Gm-Message-State: AOJu0YzeB/UHkGZyrdmtaVepsVrxFWtFF4C0CPYouiIYjSYPjZvpAbB7
	x3/p3zNDf+Ec8BSgfx9vSnzMVypwM4hkIkbQCJYQ+uUHx/Z5qxrF683kYkhmRAiKT4vPa1n6/FB
	sQtCaUNR4PnaZkujGMfNoy64tMbI=
X-Google-Smtp-Source: AGHT+IHnNcgdDe52A+VEKS8n77D4vOj3SjGftsyRxdtqqYFndTXSlX02flgrQRWfoQPxv/NpEri8XwrKHe2CGsr0yms=
X-Received: by 2002:a05:6820:826:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5c1e5ca2a82mr18128298eaf.0.1719482366137; Thu, 27 Jun 2024
 02:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626204723.6237-1-mario.limonciello@amd.com>
In-Reply-To: <20240626204723.6237-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 11:59:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hu1rVOLycx5K4YWOGhtC8YfSYupc8D6qygtXVGtvxJrQ@mail.gmail.com>
Message-ID: <CAJZ5v0hu1rVOLycx5K4YWOGhtC8YfSYupc8D6qygtXVGtvxJrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq: Allow drivers to advertise boost enabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sibi Sankar <quic_sibis@quicinc.com>, Dhruva Gole <d-gole@ti.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Yipeng Zou <zouyipeng@huawei.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:47=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
>
> This is because policy_has_boost_freq() assumes that there is a frequency
> table set up by the driver and that the boost frequencies are advertised
> in that table. This assumption doesn't work for acpi-cpufreq or
> amd-pstate. Only use this check to enable boost if it's not already
> enabled instead of also disabling it if alreayd enabled.
>
> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs usin=
g cpufreq_boost_set_sw()")

CC: stable I suppose?

> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v1->v2
>  * Pick up tags
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..270ea04fb616 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>                 }
>
>                 /* Let the per-policy boost flag mirror the cpufreq_drive=
r boost during init */
> -               policy->boost_enabled =3D cpufreq_boost_enabled() && poli=
cy_has_boost_freq(policy);
> +               if (cpufreq_boost_enabled() && policy_has_boost_freq(poli=
cy))
> +                       policy->boost_enabled =3D true;
>
>                 /*
>                  * The initialization has succeeded and the policy is onl=
ine.
> --

