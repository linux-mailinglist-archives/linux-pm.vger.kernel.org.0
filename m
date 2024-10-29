Return-Path: <linux-pm+bounces-16670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EB9B4FE8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA09283158
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D368B19995A;
	Tue, 29 Oct 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJhSGp6O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4065C96;
	Tue, 29 Oct 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221014; cv=none; b=lAJ9mUyzGyTpkUYDy5PMSqmdVnkjlUHkcZUaK7xTaH+afCFKZtwvkTffK+l6YHMokwJlVI40rmMOZKE0H0/QMWcz5zKgckEm3cTvW4dbuAGRWS+O0+ftDkXFuU6BZQ7z0l4VvPcqnsfO720wtDBCGuobzfxt8eGn/vXeSoIJcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221014; c=relaxed/simple;
	bh=etdtSKZzHyNHp2dO9HMm30+8IeYkXPUjGAvw/wRkyuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu9QEaSjxnbtJ6BQXjAlO8NFzZ7pY5H2GrNUPkBb7uJ9RXsgHJBTAudPyCc4zQjVWKRC7hvpChl34mHF+lNT7sVyKu0bGPpAJhtGhZ/G5UD4RPW5mj7RUT52kpMqTs+AB5jDKJzoVY+qyrl7J2Rf2RdIR0QWPpO8DuOA8+yBjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJhSGp6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4AFC4CECD;
	Tue, 29 Oct 2024 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730221014;
	bh=etdtSKZzHyNHp2dO9HMm30+8IeYkXPUjGAvw/wRkyuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJhSGp6O7NdIB8kC89Q1E4JBrRfJq2l5i11zAz7HzFJt95y81sCoQxNguD0andvq3
	 FPGZROrSwW9kvDTNl7wx2yQKmxcuZAeBDj6lRq1b9zY3xDSuKkp/f9Al+biAFm69Zs
	 gD48Y8C96esL7dg+H5GLS6ah7YW8SkZWumYep4mWFM2lMuLA1pLpzCs/YkZjBe139b
	 IKAJ3iu1r4ZwqQ1PPa463dKHE2bj0b15TVrU8n9fnEoq2jZ9b9jQbVzUbpAMZ5iRGQ
	 1y7qmjLa8FXwTcUwj5iCLGDVKQfxhrA8LmkthYML35Y1rp8dRyp5wqeYxp3rzOOam6
	 HZ90KUy3CG3nQ==
Received: by pali.im (Postfix)
	id 83DB8820; Tue, 29 Oct 2024 17:56:46 +0100 (CET)
Date: Tue, 29 Oct 2024 17:56:46 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jerry Lv <Jerry.Lv@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Retrieve again when busy
Message-ID: <20241029165646.x5wqy5bo5cjv2q4e@pali>
References: <20241029-foo-fix-v1-1-1dbfed72d023@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029-foo-fix-v1-1-1dbfed72d023@axis.com>
User-Agent: NeoMutt/20180716

On Tuesday 29 October 2024 11:35:00 Jerry Lv wrote:
> Multiple applications may access the battery gauge at the same time, so
> the gauge may be busy and EBUSY will be returned. The driver will set a
> flag to record the EBUSY state, and this flag will be kept until the next
> periodic update. When this flag is set, bq27xxx_battery_get_property()
> will just return ENODEV until the flag is updated.
> 
> Even if the gauge was busy during the last accessing attempt, returning
> ENODEV is not ideal, and can cause confusion in the applications layer.
> 
> Instead, retry accessing the gauge to update the flag is as expected, for
> the gauge typically recovers from busy state within a few milliseconds.
> If still failed to access the gauge, the real error code would be returned
> instead of ENODEV (as suggested by Pali Rohár).
> 
> Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
> ---
> When the battery gauge is busy, retry to access 10 miliseconds later,
> retry up to 3 times. When failed to access the gauge, return the real
> error code.
> 
> Differences related to previous versions:
> v2 (as suggested by Pali Rohár):
> - retry up to 3 times when gauge is busy.
> - return the real error code when fail to access the device.
> 
> v1:
> - initial version for review.
> ---
>  drivers/power/supply/bq27xxx_battery.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 750fda543308..9c40bbc292c1 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1871,11 +1871,19 @@ static int bq27xxx_battery_current_and_status(
>  
>  static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>  {
> +#define MAX_RETRY 3
> +	int retry = 0, sleep = 10;
>  	union power_supply_propval status = di->last_status;
>  	struct bq27xxx_reg_cache cache = {0, };
>  	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
>  
> -	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> +	do {
> +		cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> +		if (cache.flags == -EBUSY && retry < MAX_RETRY) {
> +			retry++;
> +			BQ27XXX_MSLEEP(sleep);		/* sleep 10 miliseconds when busy */
> +		}
> +	} while (cache.flags == -EBUSY && retry < MAX_RETRY);

Hello, this is for sure nice improvement.

Anyway, I think that I mentioned it in previous email, this problem
which you describe does not affect only bq27xxx_battery_update_unlocked()
but also any other function which calls bq27xxx_read().

What about rather moving this -EBUSY retry logic into the bq27xxx_read()
function itself? Or even better, directly inside bq27xxx_battery_i2c_read()
function? This would fix this problem on all places.

>  	if ((cache.flags & 0xff) == 0xff)
>  		cache.flags = -1; /* read error */
>  	if (cache.flags >= 0) {
> @@ -2030,7 +2038,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>  	mutex_unlock(&di->lock);
>  
>  	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> -		return -ENODEV;
> +		return di->cache.flags;
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> 
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241008-foo-fix-b2244cbe6dce
> 
> Best regards,
> -- 
> Jerry Lv <Jerry.Lv@axis.com>
> 

