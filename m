Return-Path: <linux-pm+bounces-27082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B05EAB5982
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20FB460555
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5828DF0E;
	Tue, 13 May 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfgPG+1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE01E487;
	Tue, 13 May 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152847; cv=none; b=gYnPipbKq4XCaXEY9x6sm1Irg1vLHLL/OquFm0MkRG8XtSZEU3UxV7he6oGH5fS41LR9SylxfRCIuVcWpK9w+gJSO0qBgO8wt/ZRDh265/2CGijgE3gcMux+lwnDu5cyuyW8LFcFoaKqVK5Eq1EnyWsZMGmz9htHzKRBMp8yCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152847; c=relaxed/simple;
	bh=06Mnn8DD0kLBqrjcbG6VmX6krU353wykhLimJN/+7xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn3UrJFWGqo64anr6Pn7Kx8xejppYmZq6x6Kn5ZCsN8yEDxdLP9SKoIVbwIGMpkzUtwg5cIA36ouFtF7JogdIpwBtt+jrukNA7oF+m4YEdG47Ksg2tfJn2mF3/XNKqEI5xvBVkACyxbAkPzTcvZxhUOOZvUNpgBtuGm6Ie0Gbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfgPG+1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475F8C4CEE4;
	Tue, 13 May 2025 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152847;
	bh=06Mnn8DD0kLBqrjcbG6VmX6krU353wykhLimJN/+7xU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfgPG+1gu3HnDcoCcWfF54jXdFqSUmEcC2xaRR5tohWvyDs3e+RECsHP3Boi63FF5
	 XZJLq32RabDUHIqw1tKniKFfcWr99oXUe6YWvRr3GWHuPk9NklME+qld8XzHBlmrs6
	 WAhu6x/9lfyJr7z1YJfiqhyawsDNYeJnE3ItC3PU+DXA3k2dFbMDVW1zL6AtdO92W5
	 QK2hrQ5FdXQwSQyUbi956WVibwN7tpE4/J8AqSX5OzaoPsANTM0tKYtE1w8xrxGZeS
	 tQcVMTA9v4NES1AljWumULgEMn6oHrpfEPZ6YbEct4pTm77EjD8M4weOrjkKB2t4+i
	 Sl0Zq2nd0TB1A==
Message-ID: <34aa4d3e-ed6b-4caf-aeb5-0f40ecff1a94@kernel.org>
Date: Tue, 13 May 2025 11:14:05 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Avoid shadowing ret in
 amd_pstate_ut_check_driver()
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <20250512-amd-pstate-ut-uninit-ret-v1-1-fcb4104f502e@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250512-amd-pstate-ut-uninit-ret-v1-1-fcb4104f502e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/2025 4:28 PM, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>    drivers/cpufreq/amd-pstate-ut.c:262:6: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>      262 |         if (ret)
>          |             ^~~
> 
> ret is declared at the top of the function and in the for loop so the
> initialization of ret is local to the loop. Remove the declaration in
> the for loop so that ret is always used initialized.
> 
> Fixes: d26d16438bc5 ("amd-pstate-ut: Reset amd-pstate driver mode after running selftests")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505072226.g2QclhaR-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 30835d0e4994..65f9d2bae2d3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -246,7 +246,7 @@ static int amd_pstate_ut_check_driver(u32 index)
>   	int ret;
>   
>   	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
> -		int ret = amd_pstate_set_mode(mode1);
> +		ret = amd_pstate_set_mode(mode1);
>   		if (ret)
>   			return ret;
>   		for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {
> 
> ---
> base-commit: b01fc4eca73cbd7946181255a95dbe64ff83bc5f
> change-id: 20250512-amd-pstate-ut-uninit-ret-46a23a195687
> 
> Best regards,

Much appreciated.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to superm1/bleeding-edge.

