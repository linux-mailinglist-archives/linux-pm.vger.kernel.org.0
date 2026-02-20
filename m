Return-Path: <linux-pm+bounces-42942-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULJeF6uJmGlKJgMAu9opvQ
	(envelope-from <linux-pm+bounces-42942-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:19:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC3169477
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0904302A7B5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC012ECEA5;
	Fri, 20 Feb 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZO2BBFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02A1F8691;
	Fri, 20 Feb 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604383; cv=none; b=dzIt8iQuEijxQrwrIvzcn61aRyIxFrM82lLKpT447H8OOmyxOhy1Byp16Owzu5BT8MESr3uFiWIlAZyBBB9A3N5y1XdRNzPmM/KNv/Y5Zu5TR7PTdcOrsmCVV5X0a0vAVMbUHjpTNgGoY80GoHmVtqNl0m1RB4cmuwMxbD83SAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604383; c=relaxed/simple;
	bh=fbIuMAOrr0Nt3alD+VLiC66+4DvkcvaorPDAJHY32Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEG9yeoL37wKrLq+DaxJX40zTXK14lF9P9e1CynW+QASCAZM+olmRgD4HH/JD/t846WRvkfrtYTXRDrOEYCr6KQdz0te9SyFE3+did+JSmG7r2oYwBsNPFtnuOYJGxDlR7p/YgcXToNXWDkijWi88cxFdtakQssEk0JPI4r6q8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZO2BBFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A9BC19424;
	Fri, 20 Feb 2026 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771604383;
	bh=fbIuMAOrr0Nt3alD+VLiC66+4DvkcvaorPDAJHY32Gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZZO2BBFnBNaUwTCYJrktFE5E4TVllKrJH95xF32lHW2lHnc8atpQ3mS2gJVIE0wdu
	 ynjDfmmg0Y2zfJVAMwoKdoeuGPWzVBnoEck1YR4FugKDpcTzbgKFzakhVau8URmGI3
	 NhmanMu0dlkYdH4bFIawVInJuZuY51Kc5YpJv8mb0Xa9278hz3ZdRBkG3ucOBAk+Yy
	 J0MLcCU+1gNh4d8TQjOuspsEMBOd9evQMRmoR9tkEZZwLrR3epiMFXAwYL8tXUMtfq
	 5yQhJg89XWWVocJiIikDysQ851rR6CxuDUdJrkB9wh/oVJGShCvLzZFDTilExg+C+p
	 63vbwAHFMO5UQ==
Message-ID: <3cf87836-1fb7-4706-86ff-267383a8d914@kernel.org>
Date: Fri, 20 Feb 2026 09:19:41 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add support for setting EPP via systemd service
To: Jan Kiszka <jan.kiszka@siemens.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 shuah <shuah@kernel.org>
References: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42942-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuah@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:email]
X-Rspamd-Queue-Id: E8DC3169477
X-Rspamd-Action: no action

On 2/14/26 04:12, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Extend the systemd service so that it can be used for tuning the Energy
> Performance Preference (EPP) as well.

How would users use this support? Add a few lines to help them.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   tools/power/cpupower/cpupower-service.conf | 5 +++++
>   tools/power/cpupower/cpupower.sh           | 6 ++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/tools/power/cpupower/cpupower-service.conf b/tools/power/cpupower/cpupower-service.conf
> index 02eabe8e3614..abbb46967565 100644
> --- a/tools/power/cpupower/cpupower-service.conf
> +++ b/tools/power/cpupower/cpupower-service.conf
> @@ -30,3 +30,8 @@
>   # its policy for the relative importance of performance versus energy savings to
>   # the processor. See man CPUPOWER-SET(1) for additional details
>   #PERF_BIAS=
> +
> +# Set the Energy Performance Preference
> +# Available options can be read from
> +# /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> +#EPP=
> diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cpupower.sh
> index a37dd4cfdb2b..6283e8bf275d 100644
> --- a/tools/power/cpupower/cpupower.sh
> +++ b/tools/power/cpupower/cpupower.sh
> @@ -23,4 +23,10 @@ then
>       cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
>   fi
>   
> +# apply Energy Performance Preference
> +if test -n "$EPP"
> +then
> +    cpupower set -e "$EPP" > /dev/null || ESTATUS=1
> +fi
> +
>   exit $ESTATUS

thanks,
-- Shuah

