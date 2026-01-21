Return-Path: <linux-pm+bounces-41232-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AI2OardcGnCaQAAu9opvQ
	(envelope-from <linux-pm+bounces-41232-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 15:07:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09D5825A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 230317019F7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EFA3D333C;
	Wed, 21 Jan 2026 13:36:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8023EAA3;
	Wed, 21 Jan 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002618; cv=none; b=Sjxh7i0VwlGPZAAkxZyxGcN/Y5XeNL0vWN5qOEJcoQLtP1xLy2P/w/TsUhYXC+4H9AbB7q6w2eMqT8ZL8t2t0jDyFuF2RRaLJ0GXkbVJ9oX5BrEsS+B/Kqgh3cohsgKdzvxRo8ftQAJfYYdrDCEHW/aj6j0DZ9gP0sKT5KbRMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002618; c=relaxed/simple;
	bh=euSeREND68fs8Fu86AWhcjafiIhsQVNHdrxPlLdH6PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzfSr4s5GAx/yv92FgSDNVtRs5x4khiqJMAbw11CMYiDnSRcxtitAc3MYfD5l1KHZ4hf72Qzx00L4+Kigt/UMYWN5khc/eIexIOJ06xmZYxAnRQTR7aRyAy+HaDSZEEVk+KPpaGT7XlN55v9+dwCtnQxlBqd38lJkh3SER//12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2325D1476;
	Wed, 21 Jan 2026 05:36:49 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D499E3F632;
	Wed, 21 Jan 2026 05:36:54 -0800 (PST)
Message-ID: <f366937a-1748-4319-b545-48f3f2a728d7@arm.com>
Date: Wed, 21 Jan 2026 13:36:52 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] cpuidle: governors: teo: Refine tick_intercepts vs
 total events check
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
 <10793374.nUPlyArG6x@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <10793374.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-41232-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: DF09D5825A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/14/26 19:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use 2/3 as the proportion coefficient in the check comparing
> cpu_data->tick_intercepts with cpu_data->total because it is close
> enough to the current one (5/8) and it allows of more straightforward
> interpretation (on average, intercepts within the tick period length
> are twice as frequent as other events).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -485,7 +485,7 @@ constraint:
>  	 * total wakeup events, do not stop the tick.
>  	 */
>  	if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> -	    cpu_data->tick_intercepts > cpu_data->total / 2 + cpu_data->total / 8)
> +	    3 * cpu_data->tick_intercepts >= 2 * cpu_data->total)
>  		duration_ns = TICK_NSEC / 2;
>  

Sure, I guess the 2 and 8 was just as arbitrary to avoid a division.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


