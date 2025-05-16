Return-Path: <linux-pm+bounces-27228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCB5AB9811
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED81D3ABC2B
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4F221275;
	Fri, 16 May 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz9zvmJD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070C282E1;
	Fri, 16 May 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385222; cv=none; b=jBzsmX/lUFIQaZTQtCIUxBYsLtgJ4isN+abO1RRvkXCKkJIDMw2pHnGBJ7ldYFnARzDiRRlEomKm5raUmTrWVDwzG3rMF5QpecfrFqT8HssqPK6WCq3XtDqh7IPiFwl6UmiUKiX3gBbBrV5VBkW+lsmMUZwQy7O54wv9d+NT8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385222; c=relaxed/simple;
	bh=wTP8idrqSdp2wYavwoKyI6GQS7ilYOvztNeCFPL3WWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE46FKSu8h8a7TpoiEMtfzPstWADasPb4yIzzJWAmj1D6Xzf3kYPkj1gruz8YJW7y05x6sWCGOmfsDE4AhhgLj0wZ0pyk3TM4Vz1AmPOtrXIGNuM13V3q68EdkXopm6+MjGZ6sB1tDkfmFrSPoNfVT8IOUM+ZfAOKtqP3tem+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz9zvmJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CFAC4CEE4;
	Fri, 16 May 2025 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747385222;
	bh=wTP8idrqSdp2wYavwoKyI6GQS7ilYOvztNeCFPL3WWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zz9zvmJDoSCx5trCGw6LfZb8KfD5fLLV8btnIjIk+UacFyL4SY7xZF5kUzSR2Vnr9
	 RrXaAYCIpUrr0kDA9RL1TLr+nABXwdYfwsKEtXniCe0SQEwWSJzqNSg3c+VYbfxZvs
	 Jf14zu/zU8O5eGF67FK8mb3FgJjrNDdUz/KhkcoF76nfO+WSi843dhe6POWZFl/7CP
	 8wXIgDWyanwTZAms50QGz9w6IjIlEhI+ZnGCuNyVgw1o/DQ/I8q2ScN//ucwv3rYOr
	 KvK1gP2JM+QQjWC1E09cdZhOKu0XhOQtktbd1Mn6HxnV0YD1VdbKgaOI69MsBFxk9B
	 ZtsoJQjxrLx6Q==
Date: Fri, 16 May 2025 10:46:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v10 03/13] x86/msr-index: define AMD heterogeneous CPU
 related MSR
Message-ID: <aCb7f4ziOffNRrkd@gmail.com>
References: <20250515211950.3102922-1-superm1@kernel.org>
 <20250515211950.3102922-4-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515211950.3102922-4-superm1@kernel.org>


* Mario Limonciello <superm1@kernel.org> wrote:

> From: Perry Yuan <perry.yuan@amd.com>
> 
> Introduces new MSR registers for AMD hardware feedback support.
> These registers enable the system to provide workload classification
> and configuration capabilities.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index b7dded3c81132..8e6db9a9f53c0 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -732,6 +732,11 @@
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>  
> +/* AMD Hardware Feedback Support MSRs */
> +#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
> +#define AMD_WORKLOAD_CLASS_ID          0xc0000501
> +#define AMD_WORKLOAD_HRST              0xc0000502

Can we follow the existing pattern of MSR_AMD64_* or MSR_AMD_* that 99% 
of the indices in this header are following?

Thanks,

	Ingo

