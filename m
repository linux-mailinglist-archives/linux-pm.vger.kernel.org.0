Return-Path: <linux-pm+bounces-25634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C3A91E38
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5695A683A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6C24BBE5;
	Thu, 17 Apr 2025 13:38:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329D2309AF;
	Thu, 17 Apr 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897135; cv=none; b=lc8QEa5mtZjG39E0G6HdpzWA5t3fruF60lDEF79H3HqdcEIJM2f+ITvLUvo44IFqwuxYqcoE0lg8bUOk3gAYPtlq+DtcxLCnbdDhKOjUfPxLd7tHBcQNL7PNLp5UOiMYm/O4jhM73M/ihKdFdbb4nSTZmuGQZcfwD/OOK5SakMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897135; c=relaxed/simple;
	bh=PCBN4VlmLQHpPI+4wGZDLIUvRbJCRv4wV+3kSCQjeEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ApCOna7cP79Ffqx8yaFFfq8CRWV6773leD8achfGBw/dvgiA3MCC1LaqWz0nZ7DS2BV+KfWpvothYHW7dCY734wNlu12B4Ijo4QPnHDbftt0Qrd3k4MGyq1CJb8MDzBSe34ZghYBj7wIkqkDkSur2m2KySKwEkMnJfrcAzaiqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1290E1515;
	Thu, 17 Apr 2025 06:38:50 -0700 (PDT)
Received: from [10.57.72.153] (unknown [10.57.72.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672573F59E;
	Thu, 17 Apr 2025 06:38:51 -0700 (PDT)
Message-ID: <047c3d45-fb18-4081-8990-e406efd0e9cd@arm.com>
Date: Thu, 17 Apr 2025 14:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: hisi: Do not enable by default during compile
 testing
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250417074638.81329-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250417074638.81329-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/25 08:46, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers, but only allow to choose to compile them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> For longer rationale:
> https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/
> ---
>   drivers/thermal/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d3f9686e26e7..510c2b821546 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -257,7 +257,7 @@ config HISI_THERMAL
>   	depends on ARCH_HISI || COMPILE_TEST
>   	depends on HAS_IOMEM
>   	depends on OF
> -	default y
> +	default ARCH_HISI
>   	help
>   	  Enable this to plug hisilicon's thermal sensor driver into the Linux
>   	  thermal framework. cpufreq is used as the cooling device to throttle


Make sense, thanks Krzysztof for the clean up.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

