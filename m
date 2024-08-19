Return-Path: <linux-pm+bounces-12432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD33956C52
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DCD2851BE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B616C44C;
	Mon, 19 Aug 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAc3yVcD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB116B74D;
	Mon, 19 Aug 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074844; cv=none; b=dJlDDVc6MVg1YEfkto2VxQ/flNtKjqNm8xmDlfvCDFr7ClrWVtYOGBRJkT7xXCPpCjEx2aFWj7vkJ5Zp1VDdVmziONAciQyvy7Zv6SfSzS2Tdv4rCvt+ELyev/FNr2aRD5Lnx81WYHICt0amyayV91po9ZPITVw/73IlcRLL2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074844; c=relaxed/simple;
	bh=ohHtJCd1LMmlZaLfG1cTYsvsMdY41RcEOhH2pBVdJNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmg1Nv4t3pjWxOAsCTohAAh2iiTvz1YThKfq1n2T6fOX0htpeJL3ifDsHYyZq9/kfOnXGc8mGTv6E+v5Nn06MHvYUEuzy4LOo8WEQjRF55ojHY3BGOACbCKYEPNctFxgIW2gdG1n2/JVpmSy8ay+mVPks44q7EVSUFfEfdhNBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAc3yVcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5719EC4AF0E;
	Mon, 19 Aug 2024 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074844;
	bh=ohHtJCd1LMmlZaLfG1cTYsvsMdY41RcEOhH2pBVdJNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HAc3yVcDkqMvizgNK/14Kf5xD16MbEM9vKsmtQNOD2Vj5aDhuAyQTSn0vpQVeJro4
	 C3TR9mMWjaudjKA7F8tXShVAB8nCiLSd6bncPw/jBs6anvdSR9OxXqdyreH9BeQbPD
	 xpqvgL70awCQuZx6xnmHXPqpTik6oaLD3xh3WmvIkkKqVlha8zK2L5s9t5KGOsG47n
	 d7Y3u707LJix1WrItDwnrDV8rlzOQUHU2EqK0G1oMt/w5yK9u2YQlwAGfbaT06Nlff
	 BwBx4K2wP8Oaq2mG7SwJm3mLjz496alljyczemdr/jH+wDqvuPj10DVY+2YBRQLFrB
	 FPCtNvHy/kE7Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2610c095ea1so600069fac.3;
        Mon, 19 Aug 2024 06:40:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWay5emyFagDtCf07kuQGe90k3kcNwV+zfLG5dpajp0L2zyne4yiTk2032iNtSWwoT91FvwxWiiCiU=@vger.kernel.org, AJvYcCWfVrsbSALKDSb/yPpPN1pzvvczkk871mvngRdeJ11WTlvdCn4XxAsQvfAhjn1jdjmjyzwXHJVHcSiSH0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4gLQ8ToigsRg7WE+Xd+pwrqBtYwpFap6mfLkHsFNyeo372Ep
	6HzTFL4a6j5xSU3VkR4JnfxRlobLO75XJjBsHF85wt+gzyffUM+dhHL5KLJ84smy4aP96ywtk8z
	16VUfyPDeGGnS3XXIL9Jh7PuOYcE=
X-Google-Smtp-Source: AGHT+IGcVhVh+V4mQt5hXDRNbLTiyYms/xw2yVM0mDtZbGAqm3MqkS+kWaSNUzHeYQtV1Y7e/bNOufQMyMOKpbEvDLc=
X-Received: by 2002:a05:6871:918b:b0:26f:de62:7d8a with SMTP id
 586e51a60fabf-2701c5ec1a2mr5376234fac.10.1724074843580; Mon, 19 Aug 2024
 06:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802184839.1909091-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240802184839.1909091-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:40:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gkJdSdM+282AWTDKPdRsvJLiXi5p1bq+L+=_weCqOdzg@mail.gmail.com>
Message-ID: <CAJZ5v0gkJdSdM+282AWTDKPdRsvJLiXi5p1bq+L+=_weCqOdzg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Support Granite Rapids and Sierra
 Forest OOB mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:49=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Prevent intel_pstate from loading when OOB (Out Of Band) P-states mode is
> enabled.
>
> The OOB identifying bits are same as for the prior generation CPUs like
> Emerald Rapids servers. Add Granite Rapids and Sierra Forest CPU models t=
o
> intel_pstate_cpu_oob_ids[].
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 392a8000b238..79b9c3c27dff 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2425,6 +2425,10 @@ static const struct x86_cpu_id intel_pstate_cpu_oo=
b_ids[] __initconst =3D {
>         X86_MATCH(INTEL_ICELAKE_X,              core_funcs),
>         X86_MATCH(INTEL_SAPPHIRERAPIDS_X,       core_funcs),
>         X86_MATCH(INTEL_EMERALDRAPIDS_X,        core_funcs),
> +       X86_MATCH(INTEL_GRANITERAPIDS_D,        core_funcs),
> +       X86_MATCH(INTEL_GRANITERAPIDS_X,        core_funcs),
> +       X86_MATCH(INTEL_ATOM_CRESTMONT,         core_funcs),
> +       X86_MATCH(INTEL_ATOM_CRESTMONT_X,       core_funcs),
>         {}
>  };
>  #endif
> --

Applied as 6.12 material, thanks!

