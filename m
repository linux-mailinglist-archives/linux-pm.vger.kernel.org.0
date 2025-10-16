Return-Path: <linux-pm+bounces-36218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215CBE1B7D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 08:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C58F546C8E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5792D3EC7;
	Thu, 16 Oct 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqSowFKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF2246760;
	Thu, 16 Oct 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596021; cv=none; b=pfHpmwx6Uo1bTCma8KFLUWEOv4OxV32cyaAn+gQCH44Fhlp9F9HYrBOV7FdK3F89ru772pJR4ledF0/GPFNGmjj/5dmFsaJEupcQ8TzDZfc/tm/z9caVSfGujkH9JizJahf8gparS7hkGAJrUCQ1C5BR9nSYGdfFFxFRqu0T59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596021; c=relaxed/simple;
	bh=fdgBiwrx8CE/LG88VvFXysvdrIt7OHm7sbZDPG51gNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDOPPKrE92fAoPSvTTR2IOOxyMnbl8RVJdIDzo04ZWmJvyn2XyG4+CDBFnDKZa5sVzUMDiWKMtZM2IC+Aa6oGIAj7vVDhU7LoMZDUwMm/sc5wMjrkXcv2H00r+x88aCUNTlD8HAUJ/2D7XtpVEJEn3B5NvoQPQYoN/SHDEni8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqSowFKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B06C4CEF1;
	Thu, 16 Oct 2025 06:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760596021;
	bh=fdgBiwrx8CE/LG88VvFXysvdrIt7OHm7sbZDPG51gNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GqSowFKRJfTmzajZ+vcP5hTjeT3ilK80c2GAXDMzYR5FjtyQsD2MsuslaWivzmAbf
	 Q5jFbQUz9TqAamRZkpM9qJnKkkr/ZqtzmCMFe3GxfLK71imsp67YAfbQ+ZmPlKkJJs
	 3OJE6I8BfqsjrvWP/qXqt444IU2A7MNffk2HWGi8Om2b5kbdaXfzwsN+sLnjF3Tw+E
	 QWDKjRTDEubWtUYQEgMtTqPIuDhyyBTzIcRLurRf/HDJGc7AdnThZ5PUc0WcpSWWKE
	 X2T99Ib+wtWsBwyXnFrLDd3YAIQ+Mp19DsShQNweRvwoT14eAjkIxLpwmRDPtXgeuD
	 SMqnqysKDuNnw==
Message-ID: <bc24007b-e41c-440f-9d50-0e8e92d2d3d0@kernel.org>
Date: Thu, 16 Oct 2025 08:26:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: intel_dc_ti_battery: fix 64bit divisions
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hansg@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251016062401.409809-1-jirislaby@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20251016062401.409809-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16. 10. 25, 8:23, Jiri Slaby (SUSE) wrote:
> On 32bit builds, I get:
> ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko] undefined!
> 
> This is due to 64bit ktime divisions. Fix both by using div_u64().
> 
> Fixes: 8c5795fe5527 ("power: supply: Add new Intel Dollar Cove TI battery driver")
> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Hans de Goede <hansg@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>

Scratch this. Missing a SOB line.

> ---
>   drivers/power/supply/intel_dc_ti_battery.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
> index 56b0c92e9d28..3d38106b638b 100644
> --- a/drivers/power/supply/intel_dc_ti_battery.c
> +++ b/drivers/power/supply/intel_dc_ti_battery.c
> @@ -141,7 +141,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
>   	if (ret)
>   		goto out_err;
>   
> -	cnt_start_usec = ktime_get_ns() / NSEC_PER_USEC;
> +	cnt_start_usec = div_u64(ktime_get_ns(), NSEC_PER_USEC);
>   
>   	/* Read Vbat, convert IIO mV to power-supply ųV */
>   	ret = iio_read_channel_processed_scale(chip->vbat_channel, volt, 1000);
> @@ -149,7 +149,7 @@ static int dc_ti_battery_get_voltage_and_current_now(struct power_supply *psy, i
>   		goto out_err;
>   
>   	/* Sleep at least 3 sample-times + slack to get 3+ CC samples */
> -	now_usec = ktime_get_ns() / NSEC_PER_USEC;
> +	now_usec = div_u64(ktime_get_ns(), NSEC_PER_USEC);
>   	sleep_usec = 3 * SMPL_INTVL_US + SLEEP_SLACK_US - (now_usec - cnt_start_usec);
>   	if (sleep_usec > 0 && sleep_usec < 1000000)
>   		usleep_range(sleep_usec, sleep_usec + SLEEP_SLACK_US);


-- 
js
suse labs

