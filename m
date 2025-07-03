Return-Path: <linux-pm+bounces-30056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B0AF785D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7B216722F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3D2E7620;
	Thu,  3 Jul 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFaa0ySN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4A101DE;
	Thu,  3 Jul 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554079; cv=none; b=eGlEJuKxr85pbKz8YF9ephObA6TgGqOyQuWvWozV2OtUyTkuKg2/vUq6TtNfvj/Hihcpw/NQsD67JHHwbquvv5S/O64tGHDgnEJjI2FizbJsL9kHI1TE0HvEGWZpZDamrunB68VCLUEKyvB3u9b8z3Kclr2DQuathXnuRNmaBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554079; c=relaxed/simple;
	bh=fKLN6/HulayP6omt5jhq6TuMsCcquczMcfQIaFIQjxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDYFeOD75h4PzFwIbp3bUS5aSeMMKfP9U9yyUxU4B8GLlr+zQ3Wh5fiAlA/CckLM89ictVFHEQgAB+6E1WiJ1zO9y1v2u43c6erdK+PGrlDJox3E79wGW2eOQjuhiFQ9WQtWcNNSxBBVB1T7rEp/8MuTKRd5Mbu2CtmYXNn6q+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFaa0ySN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED7BC4CEF3;
	Thu,  3 Jul 2025 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554079;
	bh=fKLN6/HulayP6omt5jhq6TuMsCcquczMcfQIaFIQjxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FFaa0ySN3dEMXBkZQOJENcILz3XiaIKRSkxvbz3d1NNQJPknsucd1TPS3ttzb+kCp
	 C/bjRW0cQ1wzq+Baf9EkYLLUuZjrMdYB1E4mVk7lOfZjUSwPCoMoAkr8jTLlhFI2Yw
	 LRfSEFPWl6S9qyw7JR9Ri0GxvJt0ejuI0lCHkC3IH6eEFJIzD7jEgrZrUUPl24E6G+
	 wVgp73E5gsLOfuFfBRxqPofncLID9gpKMfU8Nj8e05QcLUUUYLgfdEJfCl/R7th9E2
	 hgJhovaoUNDOCY6sM9hYdQcdF5N3bJx6GcZlboh8iY742bowy+uKEwKZx12DVf7FqW
	 4r9nC8rvOmVeQ==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40a8013d961so14706b6e.0;
        Thu, 03 Jul 2025 07:47:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURyKtZtc0KSvaOUWbbsDv9J0s/s5B2mRIGC7Xe4UUljfa/jvukLqT/RhDYSaGyShR6AzeXfLJ1cwU=@vger.kernel.org, AJvYcCWG18l6Ota1WsJ9FJjqf/JDJjryzxf1ApEbSEjtdhDzqlnrJW+iiCsTKjj6RNy9B+/9l+DILvNMa1Gi2rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDM0Ucx8wfDu9IsunrsRhwSZkEHQoEaJqOjlezhS4PaqBwwnhY
	QKQg965jenorb9BfGpOLAi67zQBdX0PPA97wPx0wKjEsUMFG+tKz6VMZJGlfouf2T5i3nwzMt/g
	nAQMxUQGRLPMoWhkGHzzev2C/aWeZQAI=
X-Google-Smtp-Source: AGHT+IGNqCYKjhblqjV5As/wEtJd+RKTMiZ4Z0oWXKC2p/Jzb1Y/Vh6nfXDv9dZMQ3TSTOYL8nrMryM/M7oSMgjBwH8=
X-Received: by 2002:a05:6808:50a3:b0:406:3a0c:1801 with SMTP id
 5614622812f47-40bfde8a099mr2441379b6e.20.1751554078830; Thu, 03 Jul 2025
 07:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623105601.3924-1-lirongqing@baidu.com>
In-Reply-To: <20250623105601.3924-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:47:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2=G8e10b23aU=mw7C1KdozbXgRtusqU_xUDv58yi6HQ@mail.gmail.com>
X-Gm-Features: Ac12FXzjMUF-sSTWoAVe4ReUmFUkPPVlFmvs4tQ5ZnUgrpPqY3T9MFU4ZdwCF_I
Message-ID: <CAJZ5v0i2=G8e10b23aU=mw7C1KdozbXgRtusqU_xUDv58yi6HQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Granite Rapids support in
 no-HWP mode
To: lirongqing <lirongqing@baidu.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:56=E2=80=AFPM lirongqing <lirongqing@baidu.com> =
wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Users may disable HWP in firmware, in which case intel_pstate
> wouldn't load unless the CPU model is explicitly supported.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 64587d3..1782b29 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2775,6 +2775,8 @@ static const struct x86_cpu_id intel_pstate_cpu_ids=
[] =3D {
>         X86_MATCH(INTEL_TIGERLAKE,              core_funcs),
>         X86_MATCH(INTEL_SAPPHIRERAPIDS_X,       core_funcs),
>         X86_MATCH(INTEL_EMERALDRAPIDS_X,        core_funcs),
> +       X86_MATCH(INTEL_GRANITERAPIDS_D,        core_funcs),
> +       X86_MATCH(INTEL_GRANITERAPIDS_X,        core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --

Applied as 6.17 material, thanks!

