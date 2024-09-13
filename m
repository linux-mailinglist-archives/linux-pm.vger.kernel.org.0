Return-Path: <linux-pm+bounces-14209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB63978A8F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 23:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8361F24484
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96E153824;
	Fri, 13 Sep 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmUJFKid"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56626126BFE;
	Fri, 13 Sep 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262841; cv=none; b=A6t5Jo4gmhXYjYaHfrhAWFGwHGQ37PZpnwdEWihr8TdVRYSy71a6pd0TEzQo0AgkEAsu58XXZoY/YqF3MWaZ310+D1QTWMcQ3jbyd0ph3RpIedNKBVpFeRQF2S/pBXbJmyHk1lTLoWATnhQBDVP+rRAMnFiwSCKB1fyqTYt4Gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262841; c=relaxed/simple;
	bh=e2Egl2CiNVT6C6Q9NlJXEkVqJ9ZWnNq6oZ79xiIYOUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmOaQslWamZkWlOC95dbA03jMo0nrlOfPdPwb7XW9DxjVG77Gb2bKXJhTPOBRdDWFG6UkyCwnGL5gfGawRGwdH4J28tZXKIlLdvZh8tkXOJZJYTJ7ghZk0T+k9/oiVcyjheATkyGpGWleAXrxI8DOFT6OblxfGEGMg0OGi0QXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmUJFKid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEAFC4CEC0;
	Fri, 13 Sep 2024 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726262840;
	bh=e2Egl2CiNVT6C6Q9NlJXEkVqJ9ZWnNq6oZ79xiIYOUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmUJFKidmt5t9YvCGkPoZxDAwkJR/qzMBD1ppAJRTZPzhyDwiIJA1UDS5+TIOt1S1
	 TDbGFabyGmeYGidBCgncLheZT9l3voYZL5HvajOco9CcDfEDKVZa94j6I9btL800Lg
	 JPwb1CP159MudzwKtv1IWzybv84rIlPKg5UNg6BZDJWCoq9yP40s2DMflpFw0yi2h8
	 BZ/zC93KcYej0nYfBh9ibfsVYudONxDlWp+QXwvFKTuevmwXKGerd69DoTpFvTAp5t
	 6O5+eZdsc1HMZ0XES9KRzM0B3HVpodtpelm60GLShbmEglca+Xgl9iK6WWeGHfUhKw
	 NY2QZyJWxJocw==
Received: by pali.im (Postfix)
	id BC139725; Fri, 13 Sep 2024 23:27:15 +0200 (CEST)
Date: Fri, 13 Sep 2024 23:27:15 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jerry Lv <Jerry.Lv@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV
 when busy
Message-ID: <20240913212715.gmchsmmaqrhksmhx@pali>
References: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 16:45:37 Jerry Lv wrote:
> Multiple applications may access the device gauge at the same time, so the
> gauge may be busy and EBUSY will be returned. The driver will set a flag to
> record the EBUSY state, and this flag will be kept until the next periodic
> update. When this flag is set, bq27xxx_battery_get_property() will just
> return ENODEV until the flag is updated.

I did not find any evidence of EBUSY. Which function and to which caller
it returns? Do you mean that bq27xxx_read() returns -EBUSY?

> Even if the gauge was busy during the last accessing attempt, returning
> ENODEV is not ideal, and can cause confusion in the applications layer.

It would be better to either propagate correct error or return old value
from cache...

> Instead, retry accessing the gauge to update the properties is as expected.
> The gauge typically recovers from busy state within a few milliseconds, and
> the cached flag will not cause issues while updating the properties.
> 
> Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 750fda543308..eefbb5029a3b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -2029,7 +2029,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>  		bq27xxx_battery_update_unlocked(di);
>  	mutex_unlock(&di->lock);
>  
> -	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> +	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0 && di->cache.flags != -EBUSY)
>  		return -ENODEV;

... but ignoring error and re-using the error return value as flags in
code later in this function is bad idea.

>  
>  	switch (psp) {
> 
> ---
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> change-id: 20240913-foo-fix2-a0d79db86a0b
> 
> Best regards,
> -- 
> Jerry Lv <Jerry.Lv@axis.com>
> 

