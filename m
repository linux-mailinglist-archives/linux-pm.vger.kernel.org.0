Return-Path: <linux-pm+bounces-17478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7629C6EB6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 13:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8081F26ADD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF240206E9B;
	Wed, 13 Nov 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvBh+5xX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E4206E98;
	Wed, 13 Nov 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499475; cv=none; b=TaGAFnPGGIWn+qvkQ/3HNJnzE9czGWEzBVuXjOMxg3Hk4IPbILr4dWAWUxekIPDOr5TsyHCxpg6DQdDUGKFsiTZWOf0WNd/Ev39tpgKlFofCScjyprdWucCwfLsPtbTgaKik3MTuBJCZaZhVABcwUJ9VrySGss4HW6aOmivtP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499475; c=relaxed/simple;
	bh=EksfeHfE5OxceSeBDdxXOcQohfdRlh4FbXI+VQhs/I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hp2MqjLBimyE8clGbFTvmOi67ikIth0hIQ1P2vw6p1C0zoxUrhE36F2PSqQudri1ZA1mDm14KurBlns5sssfVLTNvB3gruj85DXFZs/OqqMLhAhIf/Oo5lDEW/Bf/P4QvuBWjC+EJc0t0d2+wK9c9wshDP4jbWfkim6SRPpLTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvBh+5xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57051C4CECD;
	Wed, 13 Nov 2024 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731499474;
	bh=EksfeHfE5OxceSeBDdxXOcQohfdRlh4FbXI+VQhs/I4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cvBh+5xXD3KNJT6Z7lRFegT0diIMWzdiESIMOHpu9A+md3s/GgNcSz5IhAi3qlpOt
	 IH86y+qwyJC8t+oQoTAsgLNEhoAjfxm5WRu6BrpUjgwbyq/CWyUknie5UWr2fIaC+j
	 MfVvCwyqu7mBdccqFiYMIGRNbGS/Z9WMl13XPmwkvo3p4RKU0jx8v5irGu0+ef94Fy
	 2vZD92NrOyFNo9k94l9MAS6uOXwUu/3tDe4ne+hOWoRWTAEJoUPGoGzV57MV8pFWlB
	 ab1XTIIUiKKeEPSMiW50BdV/h6dIUnAF88bF7VKF0dFTYqTX8eyhSrZ/pcq+ar1utU
	 7srsF0klyOdrg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5eb60f6b4a7so1688123eaf.0;
        Wed, 13 Nov 2024 04:04:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8NBTmcq0wWBTs0jJNciwxkB6msfq2QOI+n4N4uKQNts5gDXL0zUV0dcaV3qih2TiSx9Vvv/ZIKFtcT2I=@vger.kernel.org, AJvYcCXJsSRG2ZTqKzXoXTu4bQrYyq0RESqZxQtmjnBJCIlqlRqlR+eFn6YdjVgbwpmAKNuxji/bA4GZF2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpxFf5JvE/4xSEbVbMmyCu886j03jpw5XkCpeZ5pNbjj623Xd
	fc0FX26gDRUIwqA+6AsoYmY8637OwIDqO6I0urvKx8UoKtGK7eQkrKWOvoKJ4+sflkxxcDol7gI
	R+eCQZHrnSkUZ8HP5McBY0QU5i3Y=
X-Google-Smtp-Source: AGHT+IEVnHr+c75j4Ah7GnM0xUmsz3sBmxC+FHCASwiIDokT/u783ordaOVkTzX3xXr5WWrmsrP01jBvzoauQ4lNfbk=
X-Received: by 2002:a05:6820:2909:b0:5eb:db1c:a860 with SMTP id
 006d021491bc7-5ee57c788f0mr12165235eaf.8.1731499473711; Wed, 13 Nov 2024
 04:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112235946.368082-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20241112235946.368082-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 13:04:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpcSOFndaSMvrdz5ryFcF65PEkpC+8Hh9nWzcQP7JNDw@mail.gmail.com>
Message-ID: <CAJZ5v0hpcSOFndaSMvrdz5ryFcF65PEkpC+8Hh9nWzcQP7JNDw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for
 Granite Rapids
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:00=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Update EPP default for balance_performance to 32. This will give better
> performance out of box using Intel P-State powersave governor while still
> offering power savings compared to performance governor.
>
> This is in line with what has already been done for Emerald Rapids and
> Sapphire Rapids.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index cd2ac1ba53d2..f1db73a52bae 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3658,6 +3658,8 @@ static const struct x86_cpu_id intel_epp_default[] =
=3D {
>         X86_MATCH_VFM(INTEL_ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102=
)),
>         X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EP=
P(32)),
>         X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP=
(32)),
> +       X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP=
(32)),
> +       X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, HWP_SET_DEF_BALANCE_PERF_EPP=
(32)),
>         X86_MATCH_VFM(INTEL_METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWE=
RSAVE,
>                       179, 64, 16)),
>         X86_MATCH_VFM(INTEL_ARROWLAKE, HWP_SET_EPP_VALUES(HWP_EPP_POWERSA=
VE,
> --

Applied as 6.13 material, thanks!

