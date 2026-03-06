Return-Path: <linux-pm+bounces-43825-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP/+ByviqmkJYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43825-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:18:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128B222774
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A50C53023E05
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A13A8FF6;
	Fri,  6 Mar 2026 14:15:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11293A9632;
	Fri,  6 Mar 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806506; cv=none; b=dtmFt4/bL9KTy/BUQpS2p/zIA4tWN/LHizyiXACcuT1tV/jHSuQxyh9NvF78A0pI/ZaaqXQnXVVJm9AVb2bvqD/trSnfznbxWoQuVkjYv6TCF+02xtQZxxMDHUMKbjAn3be+3SIBuhR9FiqfIbHmQ0WPBfo3Ub6VXB89x0rOjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806506; c=relaxed/simple;
	bh=+fJAxSTgLkhl1DRfJ9kcfPThvLN9cvtCxs9TfT7K+/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuYeMUefKNekQN7XRMBVtGqrGbSNIc2MUCjvC9VcJPAUU+g2z96YoIacTpai8a6CcbNsrL16ZOnA8QZKvh872LWsbUCKGJi9YT8C9/FRow12ywHQXPusLPVKqmJahHKAOycJvP66PSDd6LxmcOeRBl6FPYRnghsEuM0MpEI+F0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07BBD497;
	Fri,  6 Mar 2026 06:14:58 -0800 (PST)
Received: from [10.57.11.75] (unknown [10.57.11.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01C63F73B;
	Fri,  6 Mar 2026 06:15:02 -0800 (PST)
Message-ID: <87298887-6862-4b89-84bc-569cda59ced6@arm.com>
Date: Fri, 6 Mar 2026 14:15:13 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] thermal: sprd: Use min instead of clamp in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai
 <orsonzhai@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
References: <20260224145107.585892-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260224145107.585892-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7128B222774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,linaro.org,kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43825-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,arm.com:mid,arm.com:email]
X-Rspamd-Action: no action



On 2/24/26 14:51, Thorsten Blum wrote:
> Clamping 'val' to itself is unnecessary and the expression can be
> simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
> is also redundant and can be removed.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/thermal/sprd_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index e546067c9621..511f1e7959b6 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -201,7 +201,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
>   	 */
>   	val = (temp + sen->cal_offset) / sen->cal_slope;
>   
> -	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
> +	return min(val, SPRD_THM_RAW_DATA_HIGH - 1);
>   }
>   
>   static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)


LGTM, please send the next version with the tag
so it's on top of the queue for merging

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

