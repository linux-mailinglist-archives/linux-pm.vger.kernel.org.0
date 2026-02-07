Return-Path: <linux-pm+bounces-42248-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEoTO2dgh2l+XQQAu9opvQ
	(envelope-from <linux-pm+bounces-42248-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 16:55:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863BB106709
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 730C6300E271
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB83358B6;
	Sat,  7 Feb 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Art1TTlS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7933554C
	for <linux-pm@vger.kernel.org>; Sat,  7 Feb 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479716; cv=none; b=sdaYjlEyHg8m3CRmqSo7Md7RY1RuvYxfFTmWwow3kqIM100dt7rtRk8GnBTvYqss3bMIiLedDmWGMkSolqlQmFrKz71Wh4F6V1p6dejUbLKme2uzQGCM2o1M0z+h9NmTYTk1OlwTrofy2hQ4QHSCvZ7Jk57pLzWBkp2C+022G3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479716; c=relaxed/simple;
	bh=BnnVMVv0c8C0e/H+CUovwDp5lVd2sEtU9VOfvQIbtUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5ZMUqeW3kvY1j3S9rloqmn4y0vPU0nUkPKTh4h78Vmx9zQ+lq0311vcdzrx5ZaJAtimUTjAFlprvkswhLhfzrs0hdveEolubk5ufKrecUvMpIOQeqbveOO4hzhafX3R+olF1BrzNffHcOj2Tq78kfBrgSpiJ0mnc2l+DXs/jIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Art1TTlS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so2018333a12.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770479715; x=1771084515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qIwnM/EnbL/fMHH8uJdlkYJB/t1pt7E6OgIZwym5L8=;
        b=Art1TTlSYXGP7+bKcTi2N6jj8xsGsnWzZ58UIU0N2Gmlog9Tz7JdMB3WZc3a/vatSd
         wXAeY7n+iRleCjgsqGLGexCBs6e7DFKZUNifwLbEZudsISRf35SL1aR7KcbL8dblDowp
         lyyCiokr27QMW+3s2mSbPiluP+y/Lq9mcAoDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770479715; x=1771084515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qIwnM/EnbL/fMHH8uJdlkYJB/t1pt7E6OgIZwym5L8=;
        b=TasjbHtnhTFRrNeOI5ueu7KQ1BQi4hwb9Gjfk81z1U3wgTOeCHPmLaVKYA+l0jmU2+
         7mP/PlKzyZz5ClLymX5gZohyYXSq+PeKv79Qy5NWP2LEZLoCGs/UAgJJqj7pesHZlbme
         tyujYNV/ShLE1d0vbvORWdPRE2xyDZ0qB/ID8sa/oKuiv9bCNtvSXrsjO1IZDH87u0UR
         KyWlfZC5VkIo6uxj4V2tKsAvhC42lJkoQF+9upH+468DmQFOaSEVAdocU9naUygFWyM/
         Q8KkTnWz42NtM0dviBSj/7OC0jGMZihOhZWy/ymnMW6E8vVjLjEmAtfg4BqY3eMZ2qLR
         SSMQ==
X-Gm-Message-State: AOJu0YzLxJBOcBpJKCNRD3Tv2uQcaEmk7r2Erodgrgt7Fi0yaCfsfPfE
	L0rWRjAa1hFGTntrYtMqzH411nbolmF27kyLSNn9F9ydSpoFFfRsRFb9zXzfBK3loGY=
X-Gm-Gg: AZuq6aJl7irAyVYPSjN8Kf5LQ+BR3aBM8Hne9ts8Fm2W5B8syyLD5aPum/ma0zS2ZfO
	jrsQvIXstLEspJf0HKYtmR9YX01nvcWvUd5dDIDbko87nUyyRmxr4cvY0HF8aP/gCUjPZYhZkVB
	d/CPDaxr/uvJrqF+P0ohmwJok0A0Je3wKLJ8o+K/hWEg1vwqWRU3OeESGj/Z9/Q7q9RG+P26o6T
	z7U0tCVkTElBATmFg9t0PXx0GAjazTm5NeYm96nRxMs8ZXpn6RLv7MHO856s59FI1C5X5FUZx8h
	llq/SIv13173JRf6CzAGvAII3NXqPdVRobX5PQCqtpKc6kqCO9JPHJzFlNLxzXNYNO5yiMmXWd9
	ppIdNEIgu46wO5IYHTGqA+Nwm+v8Nqf+QzRBXunPs3HnZz7MEeRNzpBYDkaeho9BzX/WD91tHMg
	c9fqYqxZ1N/Viz+/yKdS7AXWnD
X-Received: by 2002:a05:6a21:2d0a:b0:366:14ac:e1f3 with SMTP id adf61e73a8af0-393ad3c3db2mr6352451637.69.1770479715208;
        Sat, 07 Feb 2026 07:55:15 -0800 (PST)
Received: from [192.168.96.30] ([49.207.181.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9753sm56937385ad.46.2026.02.07.07.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 07:55:14 -0800 (PST)
Message-ID: <72e69496-f166-4d06-a815-a31530226078@linuxfoundation.org>
Date: Sat, 7 Feb 2026 08:55:10 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpupower: fix swapped power/energy unit labels
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, shuah@kernel.org,
 trenn@suse.com, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
 <20260204052143.3281063-2-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260204052143.3281063-2-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42248-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 863BB106709
X-Rspamd-Action: no action

On 2/3/26 22:21, Kaushlendra Kumar wrote:
> Fix error where microWatts and microJoules units were interchanged.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   tools/power/cpupower/utils/powercap-info.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/cpupower/utils/powercap-info.c
> index 3ea4486f1a0e..e53033488218 100644
> --- a/tools/power/cpupower/utils/powercap-info.c
> +++ b/tools/power/cpupower/utils/powercap-info.c
> @@ -38,11 +38,11 @@ static int powercap_print_one_zone(struct powercap_zone *zone)
>   	printf(" (%s)\n", mode ? "enabled" : "disabled");
>   
>   	if (zone->has_power_uw)
> -		printf(_("%sPower can be monitored in micro Jules\n"),
> +		printf(_("%sPower can be monitored in micro Watts\n"),
>   		       pr_prefix);
>   
>   	if (zone->has_energy_uj)
> -		printf(_("%sPower can be monitored in micro Watts\n"),
> +		printf(_("%sPower can be monitored in micro Jules\n"),
>   		       pr_prefix);

Good find. I applied this to
https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

I will send this to PM maintainer after rc1 comes out.

thanks,
-- Shuah

