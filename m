Return-Path: <linux-pm+bounces-33887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA1FB446E7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 22:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B505A0705
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532427A123;
	Thu,  4 Sep 2025 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOaA7t6d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A75279DDA;
	Thu,  4 Sep 2025 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016188; cv=none; b=oxtoQxrdKTxLZuXj9NSO575sKCYXyQUiWKDKcU5JNZTiq9emin1GUhqGgZRYvY6JVvXGttV59LyWMu9k6bi8acPdKmJUJFmj0OSewBqBUgSWBaEEhjCy+kub6hBdeizcjgJrPV46Ef/GBPXpTlahMjLuO53d37TNMCjMrMn82aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016188; c=relaxed/simple;
	bh=jiB0SmMjS4zaMyTVtUGdfi4c0oVbMnzk0ENcWBuYT6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGTL/e3DretmXrbWv55I2bjv9sTF992dR0l5+eA6kRawV1g5XAPH3nwoS9ck787bMXrlSn58uzz1FGTPyKv7aMNKpypRnomG2D0YWSZ1fXm/wC0efExBvBBVC4Nt3S7lMuXtkTA1G+Be2Q0LHefki12jZqa7VVul8KHTRv7jPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOaA7t6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B755C4CEF0;
	Thu,  4 Sep 2025 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757016188;
	bh=jiB0SmMjS4zaMyTVtUGdfi4c0oVbMnzk0ENcWBuYT6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JOaA7t6dly4gcV34fzYVYHG0ngsLNCvfjXBy5NU03O8jgEl+1BQObSoXXs/7l8rc/
	 pAmEff+kl+8uNaMSkhakFCdO0s+5C7m9cFJIcyTauuBfwIpJzkzU2JaxfKswDrnt6j
	 4I2t7qEiigpnVNfEEn4DnoN18hMaMnigRR3GOvmOfy2dxK61jyYikhG7mjNbDJQyUD
	 ZS4dreJqKQAzAvf418X7I7XW0Z+bEA+tq1a5MKdCuv8+vKEQDV+z3nz13n81tu+WXG
	 koBrAX9Dm/FJ1LczbIJ+6iXZkA9zWQ/DJDtyQspB8C1NdBOpcMw5AABilhWEfslSsC
	 uDpX2gcgy5IyA==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74526ca79c2so686001a34.3;
        Thu, 04 Sep 2025 13:03:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJNn+jPWp+Ylr0JAvHG5ksSNBHn4Y05fhgjDn7ar9YJIRF1MVhWJ/oaikwB7Y7YigtQDNB0gCTmGwLtuU=@vger.kernel.org, AJvYcCVqjytkUvyO83R63SdlPhpVmoviKN6rMIMNcHbjlzk5PXeXsEKeUgFYxsqCzk+RIbi5vtgK72sNUww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVttRX7d6L2d+YKEOi8xMK7lzFALIEOuTOVBbHhiCVlDdo3d/w
	puAIL8fMTaht6cJGRy+SiMquGWGURpSJSgdNzEPRAeTdGv+zEJgzy7b5Rjmnicdv82B7p24V4Ke
	pRM8NI6gBV94mPH8OGD+Hyv0DTC7dEN0=
X-Google-Smtp-Source: AGHT+IGDgabH07o0jXUsx8EUBmxVIeNIp9gbySMtFVD6zhi4DjUSLK9X5SYv0mndPHQ/smsOJXFgUANYD0cBtQuciOA=
X-Received: by 2002:a05:6830:f82:b0:745:623b:fcea with SMTP id
 46e09a7af769-74569c68d47mr11744107a34.0.1757016187344; Thu, 04 Sep 2025
 13:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183644.220093-1-sohil.mehta@intel.com>
In-Reply-To: <20250826183644.220093-1-sohil.mehta@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 22:02:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hw+797-mm3qA6PqQdA7hWyZKhkYobbvF+8MCvg1cHZvQ@mail.gmail.com>
X-Gm-Features: Ac12FXyvbt0m04pHIDjR3IZESiqkecbEoB7zGlMvdqST2dqGlpONMlCx5RdiJgM
Message-ID: <CAJZ5v0hw+797-mm3qA6PqQdA7hWyZKhkYobbvF+8MCvg1cHZvQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: ondemand: Update the efficient idle check for
 Intel extended Families
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	x86@kernel.org, Tony Luck <tony.luck@intel.com>, Zhao Liu <zhao1.liu@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:38=E2=80=AFPM Sohil Mehta <sohil.mehta@intel.com>=
 wrote:
>
> IO time is considered busy by default for modern Intel processors. The
> current check covers recent Family 6 models but excludes the brand new
> Families 18 and 19.
>
> According to Arjan van de Ven, the model check was mainly due to a lack
> of testing on systems before INTEL_CORE2_MEROM. He suggests considering
> all Intel processors as having an efficient idle.
>
> Extend the IO busy classification to all Intel processors starting with
> Family 6, including Family 15 (Pentium 4s) and upcoming Families 18/19.
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v3:
>  - Posting this patch separately since the core family cleanup series
>    was merged without it.
>  - Improve commit message and code comments.
>
> v2: https://lore.kernel.org/lkml/20250211194407.2577252-7-sohil.mehta@int=
el.com/
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index 0e65d37c9231..3decfc53fe68 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -15,6 +15,10 @@
>  #include <linux/tick.h>
>  #include <linux/sched/cpufreq.h>

Since you are adding this #ifdef below, why don't you go a bit farther and =
do

> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>

static bool should_io_be_busy(void)
{
       /* All Intel Family 6 and later processors have efficient idle. */
       return boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
boot_cpu_data.x86_vfm >=3D INTEL_PENTIUM_PRO;
}
#else
static inline bool should_io_be_busy(void)
{
        return false;
}
> +#endif
> +
>  #include "cpufreq_ondemand.h"
>
>  /* On-demand governor macros */
> @@ -41,12 +45,9 @@ static unsigned int default_powersave_bias;
>  static int should_io_be_busy(void)
>  {
>  #if defined(CONFIG_X86)
> -       /*
> -        * For Intel, Core 2 (model 15) and later have an efficient idle.
> -        */
> +       /* For Intel, Family 6 and later have an efficient idle. */
>         if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
> -                       boot_cpu_data.x86 =3D=3D 6 &&
> -                       boot_cpu_data.x86_model >=3D 15)
> +           boot_cpu_data.x86_vfm >=3D INTEL_PENTIUM_PRO)
>                 return 1;
>  #endif
>         return 0;
> --

