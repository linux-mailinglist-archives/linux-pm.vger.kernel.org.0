Return-Path: <linux-pm+bounces-15440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A9998211
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 11:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964CA1C20F9A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C519AD73;
	Thu, 10 Oct 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xqruXXH4"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B929AF;
	Thu, 10 Oct 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552283; cv=none; b=PeYgZUN89SWkiB/KW9kN9IlASyACpc3qp6HP9KuzpbqWh2oxoWcwQMk8xV/N2nmWpjGPnBF1aIVW7GJzylmnYsrVh9jDNFtf1Am+3nsa9mbCj3fEiNMfyHaIhjXUN3z114eTn7xv/hlwaWdzbu4w4042OvPHPns5Fm3eNbO+w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552283; c=relaxed/simple;
	bh=hseCQCzg/iK8Z2QQD5BUnyWBcmUEyGFcrwJob9Lhu7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7tqT2tuh+uSyMD6nqgttuKaK4BgVj8hAeBsfk7XjiMtp/r37SVNiAY6ekcbddumefdSY7g8wYlF50EIJqYx6oWL0mslkeQ1fnaRhmWY3oLrdFz10ZIb7ff302r2L+qaLgX5PwB5SMFwYZGTge1KAc9Vf0pZJzbC4qiSsWuSDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xqruXXH4; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728552273; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cB8bmbKiNFQ+Vlam+82SOQQqBd6BsBuQZpjxFRkIpOg=;
	b=xqruXXH4AeW5R74skKpUXoIw/YOJ84cierKcMnsJNH5wgturz/z8lj997Q5lE9yZNSAbZaX9QONMcfjI5oqVTFFZjp8gA14XrBYTLjtInaoIiAa1QAARo6a+mHVayV91zcLKeO0WnwnsPRvX3dEvNiV1oMnmlEUleS6Lnp/LR5Y=
Received: from 30.74.144.160(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGlzF5b_1728552272 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:24:32 +0800
Message-ID: <7e6434ad-e9bc-4e9a-b540-654852cebf07@linux.alibaba.com>
Date: Thu, 10 Oct 2024 17:24:31 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] power: supply: sc27xx: use const reference to ocv
 table
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
 <20241005-power-supply-battery-const-v1-4-c1f721927048@weissschuh.net>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241005-power-supply-battery-const-v1-4-c1f721927048@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/5 18:04, Thomas Weißschuh wrote:
> The table is not modified, so constify the reference.
> This enables a constification in the power supply core.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/power/supply/sc27xx_fuel_gauge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
> index bd23c4d9fed43482e972ccc086311e7bfcec2d54..426d423b935b581a7673be076ae71b8899f17e2e 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -992,7 +992,7 @@ static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
>   static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
>   {
>   	struct power_supply_battery_info *info;
> -	struct power_supply_battery_ocv_table *table;
> +	const struct power_supply_battery_ocv_table *table;
>   	int ret, delta_clbcnt, alarm_adc;
>   
>   	ret = power_supply_get_battery_info(data->battery, &info);
> 

