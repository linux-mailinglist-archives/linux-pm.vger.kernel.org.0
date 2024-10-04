Return-Path: <linux-pm+bounces-15158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A9990ADC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F19B20C81
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8A31C830E;
	Fri,  4 Oct 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMTIDX0h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0548249F;
	Fri,  4 Oct 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065874; cv=none; b=d1wd3zRBt/mFva1t4fMspnBUdQeOYQwjrPPMHRvylaGaf3NVKM2d9Fy8SnKxCwJGJcVsqOue7cpRp46KtvZ0u5SjbNAM0YSBDQZm4faVD3i3i8bDJIreKvTFCZCb1+c9CqwxbwsXk3Dm3GXZ1W0tLnFKikWG4LZu1Hpt8RviqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065874; c=relaxed/simple;
	bh=6ti04Y4H+n0+r7BpIVRZZPOlm9sLS17MZ/Pw4VWJX/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELb1RVk3HOWYacD9fjH81wHupe17ilMlvsqfwmJrdwUF7MzZVPn1mBLrhtanNeTwEwulJ4N+HsrJy/kugYPV6f48KWe438vqRWe8nbRJMLjmUUYli5qhaMqS8TbviisPz0h/X7nwUHYEdRRueOlFy/RQ7keW09iL1SErWr5OKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMTIDX0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B264C4CEC6;
	Fri,  4 Oct 2024 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065873;
	bh=6ti04Y4H+n0+r7BpIVRZZPOlm9sLS17MZ/Pw4VWJX/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QMTIDX0hObMLF0EsbKvjW+VS3P7CmOI655ONFSC+IzaoxfN8Ym9Vk3nJG8QRdPbxw
	 Q1qF8oRsb5+B4IWMJy+xkFu+XlqlVDmnY+gGXCFF7a31cXGPOBdNPtH4c4C9Jrht7V
	 uNe9k4x6C3GdkeuPfp5qz4uWBecbqX7S+D69cN0kCpQ8tmp2tCuTHkYq/axZojBh9G
	 j7a79P5RBSrJXZIWNPnIaHAaqWT0Nj/gznIW/5W50j4ejEhaQ6EDrQgLqn4SF/kz2Y
	 gAlXwmFHfne93C9wvNu8VYW1F/GvDYNFiVuFw/pQqolHWx4xv1IWGpAmyea1pp29WS
	 T7j9M1DDIMnng==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e7b0f81d13so835015eaf.0;
        Fri, 04 Oct 2024 11:17:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc3KevyF6U2yVMZldfgFKwyCLkQa1eOsR/i2a+RXXHS9wQEoBTwKpMBqwiJUX9vh1rMzSBRGqifaI=@vger.kernel.org, AJvYcCXMEjIJfYIjStRfriXDXAXA2k7UrQeNAW6hRQNg+bqO39ZHnqEdthfGmZWqZkwXu8tVcd6fekbZkrbYB7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+u1WYFLq+3kP1jKv4OdLG/jqKgk8aCvG3zi/z9x3hn0Mz7fQ
	wKBwd7I6XpwuBHkVeTxCmW7K36mM/YxYgo0QiTC9KrVc0THnGT5ataUq7PXq9e94zceChGq3UJT
	GIGm/BsorUsc+mcCZhjLEex2zCLs=
X-Google-Smtp-Source: AGHT+IESrsYesXnnIB0K2go5gQ925pHcZTfMUQ8ksBWbk4QeH+cnV2Myr9WucSd+B44lTw84/tNfWT9xN+PBzrzecPE=
X-Received: by 2002:a05:6820:1c84:b0:5e1:cabe:a3 with SMTP id
 006d021491bc7-5e7cbe5f4e4mr1985600eaf.0.1728065872705; Fri, 04 Oct 2024
 11:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com> <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 20:17:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
Message-ID: <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:44=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Currently, there is no proper way to update the initial lower frequency
> limit from cpufreq drivers.

Why do you want to do it?

> Only way is to add a new min_freq qos
> request from the driver side, but it leads to the issue explained below.
>
> The QoS infrastructure collates the constraints from multiple
> subsystems and saves them in a plist. The "current value" is defined to
> be the highest value in the plist for min_freq constraint.
>
> The cpufreq core adds a qos_request for min_freq to be 0 and the amd-psta=
te
> driver today adds qos request for min_freq to be lowest_freq, where
> lowest_freq corresponds to CPPC.lowest_perf.
>
> Eg: Suppose WLOG considering amd-pstate driver, lowest_freq is 400000 KHz=
,
> lowest_non_linear_freq is 1200000 KHz.
>
> At this point of time, the min_freq QoS plist looks like:
>
> head--> 400000 KHz (registered by amd-pstate) --> 0 KHz (registered by
> cpufreq core)
>
> When a user updates /sys/devices/system/cpu/cpuX/cpufreq/scaling_min_freq=
,
> it only results in updating the cpufreq-core's node in the plist, where
> say 0 becomes the newly echoed value.
>
> Now, if the user echoes a value 1000000 KHz, to scaling_min_freq, then th=
e
> new list would be
>
> head--> 1000000 KHz (registered by cpufreq core) --> 400000 KHz (register=
ed
> by amd-pstate)
>
> and the new "current value" of the min_freq QoS constraint will be 100000=
0
> KHz, this is the scenario where it works as expected.
>
> Suppose we change the amd-pstate driver code's min_freq qos constraint
> to lowest_non_linear_freq instead of lowest_freq, then the user will
> never be able to request a value below that, due to the following:
>
> At boot time, the min_freq QoS plist would be
>
> head--> 1200000 KHz (registered by amd-pstate) --> 0 KHz (registered by
> cpufreq core)
>
> When the user echoes a value of 1000000 KHz, to
> /sys/devices/..../scaling_min_freq, then the new list would be
>
> head--> 1200000 KHz (registered by amd-pstate) --> 1000000 KHz (registere=
d
> by cpufreq core)
>
> with the new "current value" of the min_freq QoS remaining 1200000 KHz.

Yes, that's how frequency QoS works.

> Since the current value has not changed, there won't be any notifications
> sent to the subsystems which have added their QoS constraints. In
> particular, the amd-pstate driver will not get the notification, and thus=
,
> the user's request to lower the scaling_min_freq will be ineffective.

The value written by user space to scaling_min_freq is a vote, not a
request.  It may not be physically possible to reduce the frequency
below a certain minimum level that need not be known to the user.

> Hence, it is advisable to have a single source of truth for the min and
> max freq QoS constraints between the cpufreq and the cpufreq drivers.
>
> So add a new callback get_init_min_freq() add in struct cpufreq_driver,
> which allows amd-pstate (or any other cpufreq driver) to override the
> default min_freq value being set in the policy->min_freq_req. Now
> scaling_min_freq can be modified by the user to any value (lower or
> higher than the init value) later on if desired.
>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++++-
>  include/linux/cpufreq.h   | 6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f98c9438760c..2923068cf5f4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1361,6 +1361,7 @@ static int cpufreq_online(unsigned int cpu)
>         bool new_policy;
>         unsigned long flags;
>         unsigned int j;
> +       u32 init_min_freq =3D FREQ_QOS_MIN_DEFAULT_VALUE;
>         int ret;
>
>         pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
> @@ -1445,9 +1446,12 @@ static int cpufreq_online(unsigned int cpu)
>                         goto out_destroy_policy;
>                 }
>
> +               if (cpufreq_driver->get_init_min_freq)
> +                       init_min_freq =3D cpufreq_driver->get_init_min_fr=
eq(policy);
> +
>                 ret =3D freq_qos_add_request(&policy->constraints,
>                                            policy->min_freq_req, FREQ_QOS=
_MIN,
> -                                          FREQ_QOS_MIN_DEFAULT_VALUE);
> +                                          init_min_freq);
>                 if (ret < 0) {
>                         /*
>                          * So we don't call freq_qos_remove_request() for=
 an
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index e0e19d9c1323..b20488b55f6c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -414,6 +414,12 @@ struct cpufreq_driver {
>          * policy is properly initialized, but before the governor is sta=
rted.
>          */
>         void            (*register_em)(struct cpufreq_policy *policy);
> +
> +       /*
> +        * Set by drivers that want to initialize the policy->min_freq_re=
q with
> +        * a value different from the default value (0) in cpufreq core.
> +        */
> +       int             (*get_init_min_freq)(struct cpufreq_policy *polic=
y);
>  };
>
>  /* flags */
> --
> 2.34.1
>

