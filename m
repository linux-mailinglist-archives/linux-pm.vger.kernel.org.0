Return-Path: <linux-pm+bounces-36178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA9BDDE7A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D73884E4BE7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E731B126;
	Wed, 15 Oct 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBXQvfcM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312331B11C;
	Wed, 15 Oct 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522679; cv=none; b=tsyrYRzjYB8riEvYwRUHFuL9OZ/lYX8BcEF+8j46X1dtBAabwWvkCzrJU2oIFejmTrfftPELQ7BCKtbbTA3xF67GOjJ6GmgxiUkqLjr/mY544VQjcuRGV8wVKYSdatfis3B6xfKAXAZqTwMLuBkq3Y3pc3m+rmKAQjveXFfYu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522679; c=relaxed/simple;
	bh=L/YsvmNMY201BrcR1Rq1tMYlBDZNlU5JzPbhL3T+c0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfAn9BVWBtBOR8fzE11KL5UGsdALOZZ/AikG0qyUZ6l/PtwcMwvkxXUPZqbw7KpTzA1UX4kNgTsT33H1OJ+xs1MCaT/inyjDNtqqp08hgNAZDGOxgry2lNrK3V5VYL9/EsLC35b7TFesxySOp6kSaTy7iJzIRLFch+WgAqvSGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBXQvfcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49566C4CEF8;
	Wed, 15 Oct 2025 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760522679;
	bh=L/YsvmNMY201BrcR1Rq1tMYlBDZNlU5JzPbhL3T+c0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBXQvfcMQV9GCempxEjyZRZckE0LVe6yPPSbDuo3jDwFkelvYPXy07PXAJ88H0t4M
	 P4HbLLAFyeZkdFi29Zm4H1240g/RjWhQCerhtGzhfgCGaUHQILybJB2RQi0mOI7gtR
	 wBcpBnBo40ET+y/eI06FwcciIUWTSIVjNhMFy9towRdJRsFttTMSw52DiJ2Balmtr7
	 nW/HwHYjAV7pSGJQ972ODZktrHVP8tRYmQLjFS5fgbLJeZeDL2epJdOsBlC5+w2cmv
	 /1jVR9nm2Dbw0DpC/zeKfGoBC79RvWnNg22Skd2v/sri8eHFrnU0e6qJOPyocM7Ox9
	 RQlZwqu5BRVDA==
Message-ID: <d6729dd0-112f-49a6-a08a-d08120588feb@kernel.org>
Date: Wed, 15 Oct 2025 12:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: use ktime_divns() to avoid 64-bit division
To: Michal Kubecek <mkubecek@suse.cz>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
References: <20251015075957.8F40620057@lion.mk-sys.cz>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251015075957.8F40620057@lion.mk-sys.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michal,

On 15-Oct-25 9:56 AM, Michal Kubecek wrote:
> The build of intel_dc_ti_battery module on i386 (32-bit) fails with
> 
> ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko]
> 
> This is caused by 64-bit division of ktime values by NSEC_PER_USEC. Use
> ktime_divns() helper which handles the division correctly on 32-bit
> architectures.
> 
> Fixes: 8c5795fe5527 ("power: supply: Add new Intel Dollar Cove TI battery driver")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/power/supply/intel_dc_ti_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
> index 56b0c92e9d28..c26209ef9577 100644
> --- a/drivers/power/supply/intel_dc_ti_battery.c
> +++ b/drivers/power/supply/intel_dc_ti_battery.c
> @@ -141,7 +141,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
>  	if (ret)
>  		goto out_err;
>  
> -	cnt_start_usec = ktime_get_ns() / NSEC_PER_USEC;
> +	cnt_start_usec = ktime_divns(ktime_get_ns(), NSEC_PER_USEC);
>  
>  	/* Read Vbat, convert IIO mV to power-supply ųV */
>  	ret = iio_read_channel_processed_scale(chip->vbat_channel, volt, 1000);
> @@ -149,7 +149,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
>  		goto out_err;
>  
>  	/* Sleep at least 3 sample-times + slack to get 3+ CC samples */
> -	now_usec = ktime_get_ns() / NSEC_PER_USEC;
> +	now_usec = ktime_divns(ktime_get_ns(), NSEC_PER_USEC);
>  	sleep_usec = 3 * SMPL_INTVL_US + SLEEP_SLACK_US - (now_usec - cnt_start_usec);
>  	if (sleep_usec > 0 && sleep_usec < 1000000)
>  		usleep_range(sleep_usec, sleep_usec + SLEEP_SLACK_US);


