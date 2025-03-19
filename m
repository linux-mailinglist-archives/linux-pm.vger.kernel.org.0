Return-Path: <linux-pm+bounces-24322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D7A69A42
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 21:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22D53AAE90
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A992046B2;
	Wed, 19 Mar 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXKTmsmm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB81A7046;
	Wed, 19 Mar 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416605; cv=none; b=n0Tl3YqYH4lAiI6lWI+AinnkYondmtUmcKSMSoZtP4N/cdl/S08AwRGhiN9uQfxDZLQJF2HgGY6Gm3bU3v4AhaDnricZHep+95/jxKp2XTfJXbgStVlL60S3tQPII/ReLx48RiGq9vuMT/0mWRGCxiQ8E/QA/jdjIYMZpcIjSkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416605; c=relaxed/simple;
	bh=Rpi5EZJtdIXV38JBQVPCQTTTUTsGclKxCESwXvkaeok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAR737WncdTWFhthdVBxr9bYoWx2m8pJT2w1A6uZlof0tf2y+kaL08XU0cTLWpOne+/3qR+UDLW9dmgGU3x2h/Dw9OlkccMCwIcGwPFRZB05AZCANDSm+SQOiOd7S98L+MKtrpXoukvQf5TQJXFnle7F8RViDBKe6uKhMgb/HRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXKTmsmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B75C4CEE4;
	Wed, 19 Mar 2025 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416604;
	bh=Rpi5EZJtdIXV38JBQVPCQTTTUTsGclKxCESwXvkaeok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXKTmsmmntuQ0cnLuVXXQOmU47mZc58YToPSkTapRHY8SDQ2B84sNvumnZLHS6ndt
	 QVoqQDRq4Msk6/AEpU/iY1eW0D5qR3C2+v1o7FGpmh7ARGaJa/JvuRn8bi8sZKW3YE
	 7EFbEFVBLw0jtorO8RYltX/7J9OXwAv/rF09tQNOnW0IccE7PfVd5onSOBH6Uuh1e4
	 cG/Ed5eQrLfvtKOyyfRFuLpeyjqKZ8T8Qa4ljIP4oVtT4bMVxm8yRcemFk6zosoNfN
	 Pij0g9ldw4vXI5W6pW3E4Ax6pXEgeLpgARwvQ94ArdZuG6TRCJ+2EoATt1nDq+3wYX
	 /JKYjoXoLEmCg==
Received: by pali.im (Postfix)
	id 70F27A0C; Wed, 19 Mar 2025 21:36:29 +0100 (CET)
Date: Wed, 19 Mar 2025 21:36:29 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jerry Lv <Jerry.Lv@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3] power: supply: bq27xxx: Retrieve again when busy
Message-ID: <20250319203629.zb6zob5nqapr2faw@pali>
References: <20250319-foo-fix-v2-1-ff4cb232ef42@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319-foo-fix-v2-1-ff4cb232ef42@axis.com>
User-Agent: NeoMutt/20180716

On Wednesday 19 March 2025 17:41:28 Jerry Lv wrote:
> Multiple applications may access the battery gauge at the same time, so
> the gauge may be busy and EBUSY will be returned. The driver will set a
> flag to record the EBUSY state, and this flag will be kept until the next
> periodic update. When this flag is set, bq27xxx_battery_get_property()
> will just return ENODEV until the flag is updated.
> 
> Even if the gauge was busy during the last accessing attempt, returning
> ENODEV is not ideal, and can cause confusion in the applications layer.
> 
> Instead, retry accessing the I2C to update the flag is as expected, for
> the gauge typically recovers from busy state within a few milliseconds.
> If still failed to access the gauge, the real error code would be returned
> instead of ENODEV (as suggested by Pali Rohár).
> 
> Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
> ---
> Changes in v3:
> - Move I2C retry logic to bq27xxx_battery_i2c_read()
> - Link to v2: https://lore.kernel.org/all/20241029-foo-fix-v1-1-1dbfed72d023@axis.com
> 
> Changes in v2:
> - Retry up to 3 times when gauge is busy
> - return the real error code when fail to access the device
> - Link to v1: https://lore.kernel.org/all/20240913-foo-fix2-v1-1-a0f499404f3a@axis.com
> ---
>  drivers/power/supply/bq27xxx_battery.c     |  2 +-
>  drivers/power/supply/bq27xxx_battery_i2c.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 750fda543308..99631ab46e8e 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -2030,7 +2030,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>  	mutex_unlock(&di->lock);
>  
>  	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> -		return -ENODEV;
> +		return di->cache.flags;
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index ba0d22d90429..78cccea4d419 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -6,6 +6,7 @@
>   *	Andrew F. Davis <afd@ti.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> @@ -27,10 +28,15 @@ static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
>  static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
>  				    bool single)
>  {
> +#define MAX_RETRY 3
> +#define I2C_DELAY_MIN 10000
> +#define I2C_DELAY_MAX 11000
> +
>  	struct i2c_client *client = to_i2c_client(di->dev);
>  	struct i2c_msg msg[2];
>  	u8 data[2];
>  	int ret;
> +	int retry = 0;
>  
>  	if (!client->adapter)
>  		return -ENODEV;
> @@ -47,7 +53,14 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
>  	else
>  		msg[1].len = 2;
>  
> -	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	do {
> +		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +		if (ret == -EBUSY && retry < MAX_RETRY) {
> +			retry++;
> +			/* sleep 10 miliseconds when busy */
> +			usleep_range(I2C_DELAY_MIN, I2C_DELAY_MAX);
> +		}
> +	} while (ret == -EBUSY && retry < MAX_RETRY);
>  	if (ret < 0)
>  		return ret;
>  
> 
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241008-foo-fix-b2244cbe6dce
> 
> Best regards,
> -- 
> Jerry Lv <Jerry.Lv@axis.com>
> 

Hello, this change looks good. I think that now it should handle all
cases when chipset is busy.

Personally if I'm writing this change I will avoid those new ad-hoc
#defines in the middle of the function and also avoid duplicating the
loop terminating condition (there is two times). For example as:

    retry = 0;
    do {
        ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
        if (ret == -EBUSY && ++retry < 3) {
            /* sleep 10 milliseconds when busy */
            usleep_range(10000, 11000);
            continue;
        }
        break;
    } while (0);

Btw, "milliseconds" should be with two LL.

But I will let the code style decision to maintainers.

Reviewed-by: Pali Rohár <pali@kernel.org>

