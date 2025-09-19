Return-Path: <linux-pm+bounces-35080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99231B8B535
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 23:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D14A029DE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CF2C21E2;
	Fri, 19 Sep 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUt3O2Zl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95F223702
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317012; cv=none; b=DX0yWS3sYv0XDFHtfWN9ykdn6pfDMcB7Uw7Ibe/hGVQbwpdd4HfkIuhYN4/0y5djMKGszjElf8emW4jF2gfMrRuX0wB9nQV4/fjx61WLuAqg1Voni22aEUGnl7sNNh/Et81VEpxrIDKv2bXvUrPDM1fI7yjE1xgE1PU+bHMyPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317012; c=relaxed/simple;
	bh=Mus4C9esnPUAx29I8Ebsex+Cx5Mb25n/skDJMlwEYWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F04O2EHEz28B+j2mscadn/H6oS3+LRdimVzR4uaVVW7Z2kfV8Q1g2z6XdOukB/D0AOUipghyn9y6pvNeB0pdAN6zixgFwEKdPm3i9nnMooXthxE4CYc35pJ5lifjG1otJPtE/vVS7Q8msdYdC2B8V0Dnrt8sRaeYmEy4cuMSI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUt3O2Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE143C4CEFD
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 21:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758317011;
	bh=Mus4C9esnPUAx29I8Ebsex+Cx5Mb25n/skDJMlwEYWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PUt3O2ZltJFMDOto5TUuBLGCXN69100NbGt9ksqtjCqEiGg5ayjnrtY+2EDFA3bnA
	 7CZ9G9HebqcsQmUTbFvkzjBYdClvfXYqA0e6cIbK4eVYI0YDNaq0HviEJV4QT+npQd
	 7/qxx7Ia+45cSTHHj+sFwG3f9KePscGdv8sg6PHxnF6VvdVah5+qQEnLZvN4j7AUzH
	 l0r5panWybfblueub9x7FWacjIxoEOdixqD12VZ6hTYgXiq/nkJt+okY/gomsc2450
	 CV2ycSCnoAKe8V7Gd89Vx9PgoBhLx+qAkYEx+lk7CkhpkMuYIwfwC6zmfbIkTTdKE5
	 qAIk+7pzpxkvQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-439b8c30864so88691b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 14:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQls8Uf2Uq7q5OSfRq8by01bc4qWw/fCHjTp97WtduTrlVuZ9PAu6AIWGW2dF9HJ2uOUsaot558A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fO/rXJ37TzB9YUw5pQ9VHZLJjGCQfez105z58tn6jkNKfczw
	fDPEFn1H49W13thHreHxodb3nDGiHrC7Ka3sYYkp0xT41e2ArG18UAwkpkE2bE1zEs+1I2NzfYa
	b8Q1AVQkT+CWZ2iyKvOI2qg1RuLV4uNY=
X-Google-Smtp-Source: AGHT+IE7ElRHaRGRktvVK45BptE2BVF7iG4w75CjDKLH0k31Wvji/o6p+tJtDxVaRRPQEDgd4RIBbt9jHs4wY6NlADU=
X-Received: by 2002:a05:6808:bca:b0:438:8c9:5f4 with SMTP id
 5614622812f47-43d6c19c11bmr2321873b6e.19.1758317011042; Fri, 19 Sep 2025
 14:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912073502.743735-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20250912073502.743735-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 23:23:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwyvdiuiKhXh79jwQe=1G+=mohrdtnSo2f8+s6-KZWjg@mail.gmail.com>
X-Gm-Features: AS18NWBsNWC5hi6eVw9L4pzpnBy4Mqr8BLjyCBprj5irs95Urhyiv8ZP-KTDmyI
Message-ID: <CAJZ5v0iwyvdiuiKhXh79jwQe=1G+=mohrdtnSo2f8+s6-KZWjg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use likely() optimization in intel_pstate_sample()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 9:35=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
> The comment above the condition `if (cpu->last_sample_time)` clearly
> indicates that the branch is taken for the vast majority of invocations
> after the first sample in a cycle. The first sample is a one-time
> initialization case.
>
> Add likely() hint to the condition to improve branch prediction for
> this performance-critical path in intel_pstate_sample().
>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 2519eb527468..d540f2ab9a52 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2531,7 +2531,7 @@ static inline bool intel_pstate_sample(struct cpuda=
ta *cpu, u64 time)
>          * that sample.time will always be reset before setting the utili=
zation
>          * update hook and make the caller skip the sample then.
>          */
> -       if (cpu->last_sample_time) {
> +       if (likely(cpu->last_sample_time)) {
>                 intel_pstate_calc_avg_perf(cpu);
>                 return true;
>         }
> --

Applied as 6.18 material, thanks!

