Return-Path: <linux-pm+bounces-9971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAD9170CA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2C41C20B6F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD7146596;
	Tue, 25 Jun 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmKGWSMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E431DDF8;
	Tue, 25 Jun 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342122; cv=none; b=czFkyJhxlaTjEISaXrO7lmcL82ScykFan2XfPcbEvIeQiMGJ5WURlzErI9kkhL94l+8/J98BL9H5vomGDyxRojlCT5AvftILFZHKEFeExj/07xM7liYA6JqgCeeypw8/lQioyTwTtdkKLlkYEwYznXZf0fnTjsvSHVYgNyR8lUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342122; c=relaxed/simple;
	bh=3Ye0bDhzpbz3fUGe0nhYFgBrWutlYxe1oAkJY20AiRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8Y34rVCzOdtzd9+ipLa0JGUGXta++m+261Zs3D8Wj27iH7sRrUt/9RCF/0Xo1Dd9j5czy6AAMmjU/BbFifiohQprf8EqYGWl1gydBb9Q1ZPUdebJFhO+ZH+0uYXv98vVLFnzIsK/s9Q4/8pSY+As/GLbtLqrK8/CBoNz5KYFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmKGWSMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D7C32782;
	Tue, 25 Jun 2024 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719342121;
	bh=3Ye0bDhzpbz3fUGe0nhYFgBrWutlYxe1oAkJY20AiRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GmKGWSMS8TON7V//u6ypke7Pk+ece/B4PQZRUub/Jl0/I+F7IN/W39KHCv4EiCG7t
	 ZV0DPZPsL1DQw1ClMXpItWEuoVAH+iobnCzucYn61mAJahPc6LMA8HnGtyBnVbvHdh
	 qlxruxhzXaXyuznu6d6+0W87CSUtJDPfPyFH8HqctloHckocpjYKgjmmS+EpdiGH7F
	 S+bSB6yF/TTMVOqErExCu9ki/hJ/Deyq4H4OL/g7bp6FYLRhsYZKIaGW/2YdF2+X/9
	 igXxIhqN7ZzDhbD0d2gh/hnXTQ+iWvrfE/l8b7kmcFCTrmTqbqFjcrYV/HOUzjFKcF
	 e4FmbTH4DCLpw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700cdb488c1so32655a34.1;
        Tue, 25 Jun 2024 12:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzorqJHvsmDnEapKYj+xjH4W+J4dhrGJ32deGx8PG/k7975CYZsBt5qH5LYzOjelXh1i/PzLeEaWJHT0V007j+GrVoOP584O4kOGOt/qa+jFtU1exbQNkVCgTrB3HG2iNCmJ9ILj8=
X-Gm-Message-State: AOJu0YwmXxwWV7n0SuT1uGV7zDqQ0hNUXQSvbU8cEJxHvWtyTxLJqcyk
	U0bfS9jx+PNpktNWKEzro9NhE811DJ6if0k3dKVbeowbjtFHLyJOu/YGtt1yMX3jFiF7l/qsWkS
	sCHoLd09dDrRHedOoBqyY8iLAFOk=
X-Google-Smtp-Source: AGHT+IHCJ/pErcYH4WdPB1HUPAHiliMLDNwpZnRcwtFcRi0Q+z6PWySKDN9DNi2+6DtVxqdls+/09WQyn+UsRYSYfXk=
X-Received: by 2002:a05:6870:17a8:b0:254:7dbe:1b89 with SMTP id
 586e51a60fabf-25cf3c23288mr10734924fac.1.1719342120768; Tue, 25 Jun 2024
 12:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624162714.1431182-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240624162714.1431182-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Jun 2024 21:01:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gEu+t+BqM8NxjrwUFu01TEYAaaB_Ca5HJHXYNUnXMOfg@mail.gmail.com>
Message-ID: <CAJZ5v0gEu+t+BqM8NxjrwUFu01TEYAaaB_Ca5HJHXYNUnXMOfg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Replace boot_cpu_has()
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:27=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Replace boot_cpu_has() with cpu_feature_enabled().
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This is based on comment from Borislov for the change to suppot HWP
> highest interrupt.
>
>  drivers/cpufreq/intel_pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index d53b99bab687..4ee244f59f54 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1635,7 +1635,7 @@ void notify_hwp_interrupt(void)
>         u64 value, status_mask;
>         unsigned long flags;
>
> -       if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +       if (!hwp_active || !cpu_feature_enabled(X86_FEATURE_HWP_NOTIFY))
>                 return;
>
>         status_mask =3D HWP_GUARANTEED_PERF_CHANGE_STATUS;
> @@ -1667,7 +1667,7 @@ static void intel_pstate_disable_hwp_interrupt(stru=
ct cpudata *cpudata)
>  {
>         bool cancel_work;
>
> -       if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +       if (!cpu_feature_enabled(X86_FEATURE_HWP_NOTIFY))
>                 return;
>
>         /* wrmsrl_on_cpu has to be outside spinlock as this can result in=
 IPC */
> --

Applied as 6.11 material, thanks!

