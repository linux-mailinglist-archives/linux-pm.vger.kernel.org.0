Return-Path: <linux-pm+bounces-7725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8E8C28F3
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BA31F215A3
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6802317548;
	Fri, 10 May 2024 16:49:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF61429A;
	Fri, 10 May 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359786; cv=none; b=Vx0jpzu/yRWfEcoIMokKZo7IyaFxXeJR7NfCWkZ4d8U5/h0keAlQWNQLS86KT5kRq1eiEWBlnQsYCcZUoNcYWfYpYeRAV8ekLHbmPrKGUEuxtaPoQIHSOR+wPWZbhhF2XoYtJQc5TaVsGG3SnlPjPQn7tU1+UD4SNcnfi8metQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359786; c=relaxed/simple;
	bh=GbCNIFOQBJPFUW1zv45XMBiGgvlwB+enNPlomZb/ubM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VniAdTsPC1j4hkiQ964whJ5oVAHbTU3ZXwomszffxZWWkqWeXTvl0EmuULZL8lsWLzDo+s37Ng7+iQlbSQFS+DkNJWz6FJ/qteyc648sQeqe4d4pFAeX8YFtU1U/nQ05USKirnGJIP3TYSCMF6CTpqPGD1035ZIvxail0bR3joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A4A106F;
	Fri, 10 May 2024 09:50:07 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F42B3F6A8;
	Fri, 10 May 2024 09:49:40 -0700 (PDT)
Date: Fri, 10 May 2024 17:49:37 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: sun50i: fix memory leak in
 dt_has_supported_hw()
Message-ID: <20240510174937.0a710104@donnerap.manchester.arm.com>
In-Reply-To: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
	<20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 19:52:32 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

Hi Javier,

> The for_each_child_of_node() loop does not decrement the child node
> refcount before the break instruction, even though the node is no
> longer required.

Ah, thanks for spotting this, there is indeed a leak. Sorry for the
blunder!

> This can be avoided with the new for_each_child_of_node_scoped() macro
> that removes the need for any of_node_put().

Wow, that's the typical convoluted Linux macro, but it looks correct to me.
It would call the put even if the loop ends naturally, but there is a NULL
test in there, so that's fine.

> Fixes: fa5aec9561cf ("cpufreq: sun50i: Add support for opp_supported_hw")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 0b882765cd66..ef83e4bf2639 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -131,7 +131,7 @@ static const struct of_device_id cpu_opp_match_list[] = {
>  static bool dt_has_supported_hw(void)
>  {
>  	bool has_opp_supported_hw = false;
> -	struct device_node *np, *opp;
> +	struct device_node *np;
>  	struct device *cpu_dev;
>  
>  	cpu_dev = get_cpu_device(0);
> @@ -142,7 +142,7 @@ static bool dt_has_supported_hw(void)
>  	if (!np)
>  		return false;
>  
> -	for_each_child_of_node(np, opp) {
> +	for_each_child_of_node_scoped(np, opp) {
>  		if (of_find_property(opp, "opp-supported-hw", NULL)) {
>  			has_opp_supported_hw = true;
>  			break;
> 


