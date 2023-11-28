Return-Path: <linux-pm+bounces-370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E37FBC42
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C914B282696
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597005AB87;
	Tue, 28 Nov 2023 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC530C6;
	Tue, 28 Nov 2023 06:09:28 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58787a6583aso182114eaf.1;
        Tue, 28 Nov 2023 06:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701180568; x=1701785368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok2Pvzx+XTxobx7csp7M2Qcx2McFJVa+pNHhV6WPiok=;
        b=rVsOHmyjemSh93VuSBAwWFrypV/mCCxxqfuOSDg0PYf0dWpC5pFsupb5/P5gCdwO6c
         6pAxzeYcfDh1ujGv8QnjhrRLffgOL/UhuDCN54sG6VpHNPfUNCaBluJU7zqaoPYQgv9k
         MR8WinmXtl49c4v+3xIhzdoBegSC9zRFUxpCwcfWlCObAPsXpYts3XE1Y2TDsgvnHlld
         aOS+vdcz+NuhqyG8LP3Lj2DB9f3AYOodROe98BOaLJrMD7db5ejCvp0/H6quU+C5NPV0
         zLtcLcMd9UVjIGg0s0n/tyX4wBUIRbnK4vbcTjsNN6zyW4TW+hRbwgAO5/dwYTCBQciQ
         ydBQ==
X-Gm-Message-State: AOJu0YwFh3jaeTFt5lQ46wWwixALXlvVGOAis14/B3fYLupN1s1u8qzj
	oteNzX1QbGtIZdqafhBr0njaHwzX+FmlOLp33Fw=
X-Google-Smtp-Source: AGHT+IHtASnhM/OKnxuGbYr1Q38yde7vCFfBhm7lG85droOtfxF2ahM5o850ntu1JZLLI+LZB/0AZOwFvaWAC0V9glc=
X-Received: by 2002:a4a:eb86:0:b0:58d:5302:5b18 with SMTP id
 d6-20020a4aeb86000000b0058d53025b18mr10488312ooj.1.1701180568163; Tue, 28 Nov
 2023 06:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127111121.400-1-gautham.shenoy@amd.com>
In-Reply-To: <20231127111121.400-1-gautham.shenoy@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Nov 2023 15:09:17 +0100
Message-ID: <CAJZ5v0j7QahmFU=eVG=4iBCmN4wk58GgyfUchr9wcc0Fh0Rwag@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Wyes Karny <wyes.karny@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <Perry.Yuan@amd.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:11=E2=80=AFPM Gautham R. Shenoy
<gautham.shenoy@amd.com> wrote:
>
> cpufreq_driver->fast_switch() callback expects a frequency as a return
> value. amd_pstate_fast_switch() was returning the return value of
> amd_pstate_update_freq(), which only indicates a success or failure.
>
> Fix this by making amd_pstate_fast_switch() return the target_freq
> when the call to amd_pstate_update_freq() is successful, and return
> the current frequency from policy->cur when the call to
> amd_pstate_update_freq() is unsuccessful.
>
> Fixes: 4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Cc: stable@vger.kernel.org # v6.4+
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..300f81d36291 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -518,7 +518,9 @@ static int amd_pstate_target(struct cpufreq_policy *p=
olicy,
>  static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy=
,
>                                   unsigned int target_freq)
>  {
> -       return amd_pstate_update_freq(policy, target_freq, true);
> +       if (!amd_pstate_update_freq(policy, target_freq, true))
> +               return target_freq;
> +       return policy->cur;
>  }
>
>  static void amd_pstate_adjust_perf(unsigned int cpu,
> --

Applied as 6.7-rc material, thanks!

BTW, if you are aware of any pending AMD P-state fixes for 6.7, please
let me know.

