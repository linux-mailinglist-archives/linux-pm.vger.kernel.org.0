Return-Path: <linux-pm+bounces-16146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F89A92CE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE8283CC6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0E11FDFA3;
	Mon, 21 Oct 2024 22:01:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5531E3DCB
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548065; cv=none; b=XcYAfC2H0pdGYeCsl55GIQ+HCpNkWZwmzaTv4pp5Kl5h6U2GC9dB8SjOTcBU3IdGQ1z0IWHICxBu9Ac/LRAXiVY9nkWtyL+cutF5MBhG/+503F9vFRs+wyaTr19SZ5IfCO7BoDXCSTyZ1h5YjbkLK1ZIaNq9EnSlsevtx5+Q9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548065; c=relaxed/simple;
	bh=6B7quEE49P/uJDCH9m9gRXV6o+GgwRLN6ne1+87qAlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovqSzy1fqYgRvc/jTtcwmLI58bYRFM0AbVcnX1BMeBhjFq/b86O6Oi9b2CgYI66QmnoSxvCWGrb5rW6zw0oR70/kYeZlLFyCBqayrIuVQjqqRkXQA65ZurBGaS1KhYIiux8FnyyexfKssbZth5VDglfHt3NvbGHFQIedtTmFsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54087497;
	Mon, 21 Oct 2024 15:01:31 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B59013F71E;
	Mon, 21 Oct 2024 15:01:00 -0700 (PDT)
Message-ID: <46d25358-bf23-44ec-8350-711252560b89@arm.com>
Date: Mon, 21 Oct 2024 23:02:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241014094309.1430126-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 10:43, Daniel Lezcano wrote:
> The thresholds exist but there is no notification neither action code
> related to them yet.
> 
> These changes implement the netlink for the notifications when the
> thresholds are crossed, added, deleted or flushed as well as the
> commands which allows to get the list of the thresholds, flush them,
> add and delete.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_netlink.c    | 236 ++++++++++++++++++++++++++-
>   drivers/thermal/thermal_netlink.h    |  34 ++++
>   drivers/thermal/thermal_thresholds.c |  36 ++--
>   drivers/thermal/thermal_thresholds.h |   2 +-
>   include/uapi/linux/thermal.h         |  27 ++-
>   5 files changed, 307 insertions(+), 28 deletions(-)
> 

[snip]

>   
> +static inline int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
> +					       int temperature, int direction)
> +{
> +	return 0;
> +}
> +
> +static inline int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
> +						  int temperature, int direction)
> +{
> +	return 0;
> +}
> +
> +static inline int thermal_notify_threshold_flush(const struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
> +static inline int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
> +static inline int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}

These 'return 0' look a bit odd. We usually use 'return -EINVAL' in
not defined. Although, since we don't check the output of those
functions  - we are OK. We just have to remember about these zeros,
one day when we would like to add the check of the return.

> +
>   static inline void __init thermal_netlink_exit(void) {}
>   
>   #endif /* CONFIG_THERMAL_NETLINK */

>   
> -int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction)
> +int thermal_thresholds_delete(struct thermal_zone_device *tz,
> +			      int temperature, int direction)
>   {
>   	struct list_head *thresholds = &tz->user_thresholds;
>   	struct user_threshold *t;
> @@ -205,6 +209,8 @@ int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, i
>   		t->direction &= ~direction;
>   	}
>   
> +	thermal_notify_threshold_delete(tz, temperature, direction);
> +
>   	__thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
>   
>   	return 0;
> @@ -217,7 +223,7 @@ int thermal_thresholds_for_each(struct thermal_zone_device *tz,
>   	struct user_threshold *entry;
>   	int ret;
>   
> -	lockdep_assert_held(&tz->lock);
> +	mutex_lock(&tz->lock);
>   
>   	list_for_each_entry(entry, thresholds, list_node) {
>   		ret = cb(entry, arg);
> @@ -225,5 +231,7 @@ int thermal_thresholds_for_each(struct thermal_zone_device *tz,
>   			return ret;

I agree with Rafael here. The lock should be released before return.

The rest looks good.

