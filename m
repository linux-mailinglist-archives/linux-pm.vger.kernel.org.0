Return-Path: <linux-pm+bounces-16373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7429AE36C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA301C227BE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29DF1CB9FC;
	Thu, 24 Oct 2024 11:06:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6AF1CBA10;
	Thu, 24 Oct 2024 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767962; cv=none; b=tAYwX4BgPEuNY9YL2hZEOudd4bceMHZN+JMfTSqKOopUZGyLXwb/Re1UeCNizfhAtWuUhQwrK1a3Zy1cJfvc50reA9m6eymSZNM4oIV70q3SWE6kieJrkfds5uqjyVljd2juonZHk2rpM2DjAmeGs++/JX6UP7jMIb10Elgtf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767962; c=relaxed/simple;
	bh=KYJVhO2nIp+8XBr6nXoI8+0qLY05U7sLp9KRZ8EnQGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV0DueWvYdYZd4xjH71euIW65xp5bzfg2YP0TJcXWJRZG5uRFhCxg0m8kvVyXE2SKHDTZeCauTN97jYark1Q372tAj4MSQcOuWyXmeKpEZzlZ9msQ/bAVkXTS/wHram8+XM4cAMSoIsR/u60IVLkRvsqhRKuXQd6IPZev+Trk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05188339;
	Thu, 24 Oct 2024 04:06:30 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740423F71E;
	Thu, 24 Oct 2024 04:05:59 -0700 (PDT)
Message-ID: <b2b24684-1760-43e4-8091-64e59334a0fa@arm.com>
Date: Thu, 24 Oct 2024 12:07:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, rafael@kernel.org
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/24/24 11:59, Daniel Lezcano wrote:
> The function thermal_genl_auto() does not free the allocated message
> in the error path. Fix that by putting a out label and jump to it
> which will free the message instead of directly returning an error.
> 
> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   tools/lib/thermal/commands.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
> index bcf0f14d035a..b0d4c8aca21c 100644
> --- a/tools/lib/thermal/commands.c
> +++ b/tools/lib/thermal/commands.c
> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
>   					 struct cmd_param *param,
>   					 int cmd, int flags, void *arg)
>   {
> +	thermal_error_t ret = THERMAL_ERROR;
>   	struct nl_msg *msg;
>   	void *hdr;
>   
>   	msg = nlmsg_alloc();
>   	if (!msg)
> -		return THERMAL_ERROR;
> +		goto out;
>   
>   	hdr = genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_ops.o_id,
>   			  0, flags, cmd, THERMAL_GENL_VERSION);
>   	if (!hdr)
> -		return THERMAL_ERROR;
> +		goto out;
>   
>   	if (cmd_cb && cmd_cb(msg, param))
> -		return THERMAL_ERROR;
> +		goto out;
>   
>   	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
> -		return THERMAL_ERROR;
> +		goto out;
>   
> +	ret = THERMAL_SUCCESS;
> +out:
>   	nlmsg_free(msg);
>   
> -	return THERMAL_SUCCESS;
> +	return ret;
>   }
>   
>   thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

