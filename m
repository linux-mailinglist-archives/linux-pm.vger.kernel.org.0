Return-Path: <linux-pm+bounces-41635-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBmSHaVEemkM5AEAu9opvQ
	(envelope-from <linux-pm+bounces-41635-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:17:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF74A6B24
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C49731190F1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6A311963;
	Wed, 28 Jan 2026 16:56:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF332F1FC4;
	Wed, 28 Jan 2026 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619414; cv=none; b=b94RhC58dQ5OurzRmSgPpoJBHoRitITiodttAM1wZUPOQeHPZc99rZF2xWkuFWWoprjbLJ/JjJcq1rAs0RjXOHkkikKATbC/Ki7922A6WCrCQNo5mbviNcVdidyPpsHTgTJPlkJ0yCVJzLE23gfFZW6dvTjdtR+AtTtp5S4Lqns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619414; c=relaxed/simple;
	bh=VgLFHYa8d8/t8THMJTYEsedJ/V/NSWe49J4zxdjlRo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4f+subYtgVs6JOT1ophtSPUqFxtN0UOcBZ4t9obmg9wEIx2YnuLOaAmjl92kf7HbXAhYmOAIW5h2SU1xVuTi4bYr5WxuMsK7jdwtGjIFj7Ln5JJUPpcSfZKaSZUn7aRb28t8ko37rW7rdM3AE4ZA5Ox3lEk248q3hLJDykWBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C6B91516;
	Wed, 28 Jan 2026 08:56:46 -0800 (PST)
Received: from [10.57.17.95] (unknown [10.57.17.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25DB43F73F;
	Wed, 28 Jan 2026 08:56:50 -0800 (PST)
Message-ID: <900eefbb-1297-4d73-9a60-cee6bf43bd5c@arm.com>
Date: Wed, 28 Jan 2026 16:56:53 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/airoha: Fix a device node reference leak
 in airoha_thermal_probe()
To: Felix Gu <ustc.gu@gmail.com>
Cc: linux-pm@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
References: <20260123-airoha-v1-1-ab167bb12fb7@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260123-airoha-v1-1-ab167bb12fb7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,linaro.org,intel.com];
	TAGGED_FROM(0.00)[bounces-41635-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BF74A6B24
X-Rspamd-Action: no action

Hi Felix,

On 1/23/26 11:55, Felix Gu wrote:
> In airoha_thermal_probe() function, chip-scu node is acquired through
> of_parse_phandle(), but it fails to release this reference if
> syscon_node_to_regmap() returns an error.
> Add the missing of_node_put() call to the error path to ensure the
> reference count is properly decremented.
> 
> Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>   drivers/thermal/airoha_thermal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> index b9fd6bfc88e5..308ea846ba26 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -431,8 +431,10 @@ static int airoha_thermal_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   
>   	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
> -	if (IS_ERR(priv->chip_scu))
> +	if (IS_ERR(priv->chip_scu)) {
> +		of_node_put(chip_scu_np);
>   		return PTR_ERR(priv->chip_scu);
> +	}
>   
>   	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
>   	of_node_put(chip_scu_np);

Thank you for the patch, LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>



