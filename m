Return-Path: <linux-pm+bounces-721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40426805F76
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 21:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE45A281F30
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B0469E;
	Tue,  5 Dec 2023 20:32:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A1129;
	Tue,  5 Dec 2023 12:32:20 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b9b5b254e2so395882b6e.1;
        Tue, 05 Dec 2023 12:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808339; x=1702413139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrrURgKTtD+/aJbAAUAqOTwAaLDrzLDH8ZvaiOXDJfo=;
        b=iHGIIwRLgoj+n6VPUunhEHYW7TH8+5lQgEpGGBoeE+CL85yMf+sym7/Ri6cVFEPIaC
         pSgC1nLChtV2m3SU/OVsSChQdYYOgO2AutJFNk9xllzioeDNMnpGtGHSp1Y4JNlDIC60
         rsTFfJs2Z3jGH8WGjNUe+E3dveT5aKlRyGIA5rvXbCCBZDaiQHAtiA7E2pxYzMzDZfH3
         zvbOx8pZWF4+Sy7m2R1hMwj3oI/kHMo+jsBJlfiblBAWOq5ykYB/nDOvgmqlWXtNiUBr
         Tixq4+ynQYai5YMio8D6/Ae43NBNfslqX0pkOnheyIE1a01vsZS1tt3xO0FBdxEEQK1t
         5fWA==
X-Gm-Message-State: AOJu0YzB1T/+KI9kq60G5hG23bE/PWc34Kq15br0PbBaIlm2sb939sp2
	hEzijJH8hlGEiGkx7cFmBBAopQuBH5GUngehQTQ=
X-Google-Smtp-Source: AGHT+IGXU4XJWbJY2fCwe+yPX2kwu5P84xfw4o3ss15ZSGJpQCn0mpk9LtkheiRtcKEQN7sRSuHC3LmzYWMjcp+gd3c=
X-Received: by 2002:a05:6870:961f:b0:1fb:5e42:5096 with SMTP id
 d31-20020a056870961f00b001fb5e425096mr3848589oaq.5.1701808339245; Tue, 05 Dec
 2023 12:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120185942.2320424-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20231120185942.2320424-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Dec 2023 21:32:08 +0100
Message-ID: <CAJZ5v0iitqskhEU7jQGJpj_=panoLTkcnVMuY3ST_UN30J2aCA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Allow firmware balance performance
 EPP without code change
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 7:59=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Firmware can specify balance performance EPP value by enabling HWP and
> set EPP to a desired value. The current implementation requires code
> change for every generation to add an entry to intel_epp_balance_perf
> table.
>
> Some distributions like Chrome, which uses old kernels should be able
> to update balance performance EPP, without code change.
>
> There is a check to avoid updating EPP when the balance performance
> EPP is not changed and is power up default of 0x80. Move this check
> after checking if the HWP is enabled by the firmware and there is
> a valid EPP value set by the firmware.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index a534a1f7f1ee..dd6d23e389f1 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1691,13 +1691,6 @@ static void intel_pstate_update_epp_defaults(struc=
t cpudata *cpudata)
>  {
>         cpudata->epp_default =3D intel_pstate_get_epp(cpudata, 0);
>
> -       /*
> -        * If this CPU gen doesn't call for change in balance_perf
> -        * EPP return.
> -        */
> -       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] =3D=3D HWP_EPP_BALA=
NCE_PERFORMANCE)
> -               return;
> -
>         /*
>          * If the EPP is set by firmware, which means that firmware enabl=
ed HWP
>          * - Is equal or less than 0x80 (default balance_perf EPP)
> @@ -1710,6 +1703,13 @@ static void intel_pstate_update_epp_defaults(struc=
t cpudata *cpudata)
>                 return;
>         }
>
> +       /*
> +        * If this CPU gen doesn't call for change in balance_perf
> +        * EPP return.
> +        */
> +       if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] =3D=3D HWP_EPP_BALA=
NCE_PERFORMANCE)
> +               return;
> +
>         /*
>          * Use hard coded value per gen to update the balance_perf
>          * and default EPP.
> --

Applied as 6.8 material with modified subject and changelog, thanks!

