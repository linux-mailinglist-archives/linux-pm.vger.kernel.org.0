Return-Path: <linux-pm+bounces-36967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACFC14A3E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03F534F8483
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90571316190;
	Tue, 28 Oct 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY2UhXVq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89C1397
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654717; cv=none; b=ukAxETJfoYHWeg4902V2Q/iwVB4Jl+YK3JCYWcA6GYNqHbEeYgiVcC5J2Rh/BBR8UCqJuzNPOATZImvLuImffQuooiG0yziDi2+Buah4QOk5D0b0RYa9NnCC2vNlNXApQXlfa3x3tpIgmUw7HwfK752mty8q9dEk1n8sSJLvfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654717; c=relaxed/simple;
	bh=EuxJE4Aq13MfcKaAJnKjTBYl0mI55Kds9SCUERqVafQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDzz8KtkfDThGWTcr/MUgqTVg3GeojpALefiXqDCqwFWJKSRwtHvAWfnfzIR6KFoP/K881jMYUhMpmUJzPjI5+rvmvVrJks9XtAqWAUtLXCRdw/BA7xRdlqmHUgqU24yboAyuYby6LWK3B+QiyXF5HENyZHZf1PZAeaIQ++EuWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY2UhXVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75A4C4AF0B
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654716;
	bh=EuxJE4Aq13MfcKaAJnKjTBYl0mI55Kds9SCUERqVafQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fY2UhXVqMIWH28MFyd6iDb+LgNeYrEdkZ/iP0JgMyif4dmG0gT25Y6a8FGXuNRUJ4
	 EoyLFdFORaa+61P+7TfcRPNHRY0jwtXpZ9X1VTmy6uwGTGFFcFS/g0N9W028y/Q5lH
	 +kX97S8TEcAQEkdGAF6UhhhN7RyX/C/Uj+VtGvvzdPU61RluRBjh5qVre5ghTNAmqG
	 aEwpb2ty9mUBQaLXkX7qQujRYVHwoFu2KFQ3UaAfeNzIXQpd3axO7fmGwz8muy/IOh
	 kb054l+5o8XHRO2e0WJqKln1y4opDDFxeVleyQh7pnb5UcqhQ+Z1hlzrr+Z9Kiq3mO
	 xJIA9y0whT7ow==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c2846c961fso3661898a34.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 05:31:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTN4banuFOmYL5JSq4XDe7iAWMjhrIxKi22hUVKKKEufJQZEif
	YZm2fsOfJdTWXBDCOGDKpKu9//dnLRWNzhyLajpnim9Hai0Q+azo/dLGXwBqADHEV6VAoQRrl3c
	+1jgBsYa/dIFRK/+pC1olMid/c2TDfRY=
X-Google-Smtp-Source: AGHT+IEVWRo58I18xzfPUUR5PB0H7qJNXMlMiwlFVWyXlbW4PkHzQWF0hUMsoljOREpNVKrvj8tpfKwLVtst7Ksa/h8=
X-Received: by 2002:a05:6808:1907:b0:44d:b760:f1dc with SMTP id
 5614622812f47-44f6b9a83c8mr1388123b6e.1.1761654715990; Tue, 28 Oct 2025
 05:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028101814.3482508-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251028101814.3482508-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 13:31:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXS0TgAF6AqboN_NKGXxx7onsK8QRv7eCVQFStkQXJXQ@mail.gmail.com>
X-Gm-Features: AWmQ_bneCYDSoUq_LO_z8FNhWL9pBiL2HRrGHyS8u5xe6WAsLMWi7JNQP6pmMWg
Message-ID: <CAJZ5v0gXS0TgAF6AqboN_NKGXxx7onsK8QRv7eCVQFStkQXJXQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for NOVALAKE processors
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:20=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add RAPL support for Intel NOVALAKE and NOVALAKE_L processors using
> the core defaults configuration.

Srinivas, any concerns?

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 ++
>  drivers/powercap/intel_rapl_msr.c    | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index c7e7f9bf5313..8ea55e167b1a 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1284,6 +1284,8 @@ static const struct x86_cpu_id rapl_ids[] __initcon=
st =3D {
>         X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,    &rapl_defaults_spr_server=
),
>         X86_MATCH_VFM(INTEL_LUNARLAKE_M,        &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_PANTHERLAKE_L,      &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_NOVALAKE,           &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_NOVALAKE_L,         &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_H,        &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_ARROWLAKE,          &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_U,        &rapl_defaults_core),
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index 4ed06c71a3ac..7421648917d1 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -151,6 +151,8 @@ static const struct x86_cpu_id pl4_support_ids[] =3D =
{
>         X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
>         X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> +       X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
>         {}
>  };
>
> --
> 2.34.1
>
>

