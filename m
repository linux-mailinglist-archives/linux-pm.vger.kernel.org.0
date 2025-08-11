Return-Path: <linux-pm+bounces-32203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC25B215F9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2EC1A23B73
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C829E0ED;
	Mon, 11 Aug 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjUwk30I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51825A655;
	Mon, 11 Aug 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942033; cv=none; b=cF64wyjAHiZ6bWsTKNhQozeO4xpXSSOj3kKJLPsgiwzUNt9gqB8dtcEVCIj1Rh4Xf+jxOOE2mcfzUQS56PqoGxBrmRmTz5CbqjHdyZsdOzW7g/Lj+mceGind6zywJsm1JYKRKOt7hAyuMDDcZYQtcJe+l+UUaCLqw5MCzJka4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942033; c=relaxed/simple;
	bh=4mr5MgSdGCu01ur6JubVvKjo1RpB2To+5cADO6GbGLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhApEvXjJYPRG2rMA4LqzmbdL8rXVngZq1VnY11dHSP8gqadcq16elXsmGuRHFgkYVK/ip1UYq0mS8yK6ulcL3dqEXPHjI49O24x1YloNFHZaURHSL/oq4BQtNPo4hytPa6P3BWgximlPB1XwFU/ADZy9/w+gwLH6K30sYweEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjUwk30I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F8C4CEED;
	Mon, 11 Aug 2025 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754942033;
	bh=4mr5MgSdGCu01ur6JubVvKjo1RpB2To+5cADO6GbGLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RjUwk30IUw0Kqitn5QBRWtn/hBtmW43YF9JDEIFoCprl1i1IL4qQqZb9hQSOg3euw
	 hb+J4RKsPJzCJNnvcOvId6TQ+87wdzIFRDjwgx51VyzHY+jsJFGjsjvz7CHLb0kLZ1
	 9dmVkaSZ7bMzUKbBYY+WOlKvwk/b/5NKLg+hh6Pzly5YvdqkFsEWSImFTaNNuo5JiN
	 54aryij8kvEATb4tYU2bgxuWgRBCVqf7IRPPp9Yy887YnYIVmucDXJfai2HBCtj3m7
	 U/BseKpGozUawUBFKpYjPA7dmwehVz52uPt0h3Xwgc5HIMpHq1aYIz8GW5FFk1GQAU
	 cIpfhKd4pvAPw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61585dfc8f8so1572805eaf.0;
        Mon, 11 Aug 2025 12:53:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1QF/WegtJE2uuMzzlyBuHp0U9WH3TQceY1jT1+cflPWAQi+6edh+OpCkG7yBj5Qi4Hl0VbLp9haw=@vger.kernel.org, AJvYcCWX8I3qSHMYqy78yl2QBGSGK5S7gVnF+jl0C5RTVLVJK2NvH06YLc/eJYJvWvA68ijFOIRQ1pHexKfkdwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJkIWT4baS4nhtRfzDsa9m2m2GimDtlfg3vK0dE/m4BzzZpu8
	1FgNS7ec6kSZo7JOmMkn2IlEavorwTuSWiGOfT1agPd9TsVq835/Tu7pxSm/W9tfNSJgWw1dCo5
	PONjE4dWphnaTn35HNN6nZbLCjB8LRbs=
X-Google-Smtp-Source: AGHT+IFRmjMD7JDfByiaJG7t7VDo+pJdeuILEB6UtqkFrx/8C6kVVxUJ00pS662NnCu5eg5OI9uJc+txgN/nwPqJ+dk=
X-Received: by 2002:a05:6820:22a5:b0:61b:92a3:577f with SMTP id
 006d021491bc7-61bb5a9ee3bmr618269eaf.4.1754942032333; Mon, 11 Aug 2025
 12:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808145122.4057208-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250808145122.4057208-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Aug 2025 21:53:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOQdi-73fCDTfrRoKU_umaUNReH-8sTW8Q_uK_V5Ap3Q@mail.gmail.com>
X-Gm-Features: Ac12FXx4EOJ7Egtl6UjxMTtKSIhahT_AzXOUH9ISQuutyPOMVeCEXZadbbIshwc
Message-ID: <CAJZ5v0hOQdi-73fCDTfrRoKU_umaUNReH-8sTW8Q_uK_V5Ap3Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Support Clearwater Forest OOB mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 4:51=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Prevent intel_pstate from loading when OOB (Out Of Band) P-states mode is
> enabled.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 06a1c7dd081f..f366d35c5840 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2793,6 +2793,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob=
_ids[] __initconst =3D {
>         X86_MATCH(INTEL_GRANITERAPIDS_X,        core_funcs),
>         X86_MATCH(INTEL_ATOM_CRESTMONT,         core_funcs),
>         X86_MATCH(INTEL_ATOM_CRESTMONT_X,       core_funcs),
> +       X86_MATCH(INTEL_ATOM_DARKMONT_X,        core_funcs),
>         {}
>  };
>  #endif
> --

Applied as 6.17-rc material, thanks!

