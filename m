Return-Path: <linux-pm+bounces-18624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61309E58AC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 15:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C2B281652
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC421A422;
	Thu,  5 Dec 2024 14:40:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9E218E90;
	Thu,  5 Dec 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409618; cv=none; b=AOtcyb+WVj7WmMFN0o5zf/4VDJvwPUhOYHRYVo5qRTkb6kHQ1AY9E2aROW52ki6mLzB1WwVALngBCq2xSkSKeVSApzKHr91KpCfJKvQAuaGFRIOtPvIBvF/j6K+3V7v9LPnx4OrVK1n6bVhtcgJUrtAl0/ZI5Hm1eN88ypOxjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409618; c=relaxed/simple;
	bh=Max9uPy0pEIJdrwLsRLytWmB3/61ri1lgTCu+cPbVoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byhGIX5BsWxQPfXOu8aZm/Z7Vgs15iTLg1euYSvi9KYpFTAa4CYy4GaOw+lqJnGJ7y2evKMW3fuOMRz5dhDQ9RlfvIyPAnVcdMbEic3pBoDhcak2iXVP4SHHrY+PQ1MQ+v4Cmr6wZy6rtIM5dkBgtzpAfiN1bcEPQEWJHqFax5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC779C0008;
	Thu,  5 Dec 2024 14:40:10 +0000 (UTC)
Message-ID: <eee10593-eb0b-4660-80cf-3027d6a99435@ghiti.fr>
Date: Thu, 5 Dec 2024 15:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
Content-Language: en-US
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Anup Patel <anup@brainfault.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Atish Patra <atishp@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20241116-cpuidle-riscv-sbi-cleanup-v3-1-a3a46372ce08@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241116-cpuidle-riscv-sbi-cleanup-v3-1-a3a46372ce08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Anup,

On 16/11/2024 00:32, Javier Carrasco wrote:
> The 'np' device_node is initialized via of_cpu_device_node_get(), which
> requires explicit calls to of_node_put() when it is no longer required
> to avoid leaking the resource.
>
> Instead of adding the missing calls to of_node_put() in all execution
> paths, use the cleanup attribute for 'np' by means of the __free()
> macro, which automatically calls of_node_put() when the variable goes
> out of scope. Given that 'np' is only used within the
> for_each_possible_cpu(), reduce its scope to release the nood after
> every iteration of the loop.
>
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v3:
> - Unwrap line (100 char width).
> - Link to v2: https://lore.kernel.org/r/20241031-cpuidle-riscv-sbi-cleanup-v2-1-aae62d383118@gmail.com
>
> Changes in v2:
> - Squash patches for mainline solution without intermediate steps.
> - Link to v1: https://lore.kernel.org/r/20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com
> ---
>   drivers/cpuidle/cpuidle-riscv-sbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 14462c092039..0c92a628bbd4 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -504,12 +504,12 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
>   	int cpu, ret;
>   	struct cpuidle_driver *drv;
>   	struct cpuidle_device *dev;
> -	struct device_node *np, *pds_node;
> +	struct device_node *pds_node;
>   
>   	/* Detect OSI support based on CPU DT nodes */
>   	sbi_cpuidle_use_osi = true;
>   	for_each_possible_cpu(cpu) {
> -		np = of_cpu_device_node_get(cpu);
> +		struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
>   		if (np &&
>   		    of_property_present(np, "power-domains") &&
>   		    of_property_present(np, "power-domain-names")) {
>
> ---
> base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
> change-id: 20241029-cpuidle-riscv-sbi-cleanup-e9b3cb96e16d
>
> Best regards,


Will you make a PR for this? Or should this go through the riscv tree?

Thanks,

Alex


