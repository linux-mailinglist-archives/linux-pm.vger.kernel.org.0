Return-Path: <linux-pm+bounces-42969-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI9gFgzNmWlGWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42969-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:19:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B272B16D254
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 326573013797
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1D1E51EE;
	Sat, 21 Feb 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0DcK/As"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934710FD;
	Sat, 21 Feb 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771687174; cv=none; b=M/oOK8CP9jQtAOOJJaHb0XV/NzpSbMrCuwQVTaNzjcBpCOjh0YQSF5eY3zbmAsFJ+0hx8RlAgVE6P0AP6kOT68P0GQ3zWHhCPiVul3o5bKbu7A9Hz99Y54hp6QIyJu+UOxPpsJLlDgd67+iH9UqIRkbP5dbvSQu9TQgw1TGNQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771687174; c=relaxed/simple;
	bh=TNUcv3HphMFhMVrm2mUrMyNEpiapjfAA9tFlgaYlN7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oZc7N2ye7EvyjkIembB81hzc6i9LqfdWT4Uehg5vb4NCMfqOirYkr4G7WVBrixqfb3+ZWBt4K9DUk7LlXYSqs+31uAB2hDLSoHTelHZQ9sbl0vAxw7+USI1MfqmDRBMgSLSp0dY4Bi6bEdX1jjQIU3tMfKwqI9+i9KiTqfSvrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0DcK/As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE9AC4CEF7;
	Sat, 21 Feb 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771687174;
	bh=TNUcv3HphMFhMVrm2mUrMyNEpiapjfAA9tFlgaYlN7A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=H0DcK/AsRSVjCLLlyWM4pi26rVLKFgLqOBs377v62BQ8cFvEzIiymMkQMux4JqJAQ
	 8hGTH3K60NX6sXupU41Wn6YQdpP/T0f4oI1QwrpI9uKBqipTig8dVkYzKs2TwISooI
	 jR0TJiK2c909rPOQPZzGVVFEdx3ddPKpMPY4qWjpflGxCT3AFPry/MljOnRxj2DYH8
	 q76meL5/nIN/Pbavn5BeGeVQI3AxiHkk/nUzxXWs6OB6P8vVU/WVahgrn33zMaRXI+
	 s1GJz7bUcKFSForNL6Os0F4r5bEoOtWGr37xrEP/J20arNkmmAkVccrd0Uc4UHmph2
	 DXWPz7v0DYYtg==
Message-ID: <39fa92d6-edf6-4c88-9590-5b2dec62aa0d@kernel.org>
Date: Sat, 21 Feb 2026 16:19:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] power: supply: bq24190: Avoid rescheduling after
 cancelling work
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
 <20260220174938.672883-7-krzysztof.kozlowski@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260220174938.672883-7-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42969-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B272B16D254
X-Rspamd-Action: no action

Hi,

On 20-Feb-26 18:49, Krzysztof Kozlowski wrote:
> Driver initializes delayed work and then registers interrupt handler
> with devm interface.  This means that device removal will not use a
> reversed order, but first cancel pending work items and then, via devm
> release handlers, free the interrupt.
> 
> The interrupt handler does not directly use/schedule work
> items on the workqueue, however it updates the status of the battery
> charger which might lead to calling power_supply_changed() and trigger
> chain of calls leading to scheduling the work items.  If this happens
> during short time window after cancel_delayed_work_sync() in remove()
> callback, the work would be rescheduled.
> 
> Avoid this by using devm interface to initialize and cancel work item,
> thus having exactly reverse order during remove() in respect to rest of
> the probe/cleanup paths.  This is also more logical and readable code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/power/supply/bq24190_charger.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index ed0ceae8d90b..55da91bacc3e 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
>  #include <linux/power/bq24190_charger.h>
> @@ -2087,8 +2088,11 @@ static int bq24190_probe(struct i2c_client *client)
>  	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
>  	bdi->f_reg = 0;
>  	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
> -	INIT_DELAYED_WORK(&bdi->input_current_limit_work,
> -			  bq24190_input_current_limit_work);
> +
> +	ret = devm_delayed_work_autocancel(dev, &bdi->input_current_limit_work,
> +					   bq24190_input_current_limit_work);
> +	if (ret)
> +		return ret;
>  
>  	i2c_set_clientdata(client, bdi);
>  
> @@ -2198,7 +2202,6 @@ static void bq24190_remove(struct i2c_client *client)
>  	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
>  	int error;
>  
> -	cancel_delayed_work_sync(&bdi->input_current_limit_work);
>  	error = pm_runtime_resume_and_get(bdi->dev);
>  	if (error < 0)
>  		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);


