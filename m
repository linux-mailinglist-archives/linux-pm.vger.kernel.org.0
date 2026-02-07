Return-Path: <linux-pm+bounces-42247-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OTiHe9dh2kvXQQAu9opvQ
	(envelope-from <linux-pm+bounces-42247-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 16:44:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8910668B
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D47723004C9D
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DED332EC9;
	Sat,  7 Feb 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qjrq4h7O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9646733120D
	for <linux-pm@vger.kernel.org>; Sat,  7 Feb 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479082; cv=none; b=NkFgyqU9RSXUjpKBlu/274qbSJrCZfk+9Z1vVanhoqLgs4ySMxggHjMhtDwavn+HYNelk4Snt7ky9rJPawwhUGYUE7fNG0vKwCFhi2Et2EwrRVivjB5YZUNIgpR2KlQEVygXP0lHelOahcVvgvOb7VtHBUqeT6c3sZnJ4ArXDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479082; c=relaxed/simple;
	bh=YoVMOH57MN80ldCMTW1U0YjWpMbPh1BSpSs/O5QOHiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9IMZSAX4z+RD/gC/Q79feEbvKd7zfmKZHsHhBaHDQ0ZSYrtZe9XrjXtHE2rExscvm8Uk0XIqO3OtLseHKJFoteWqpsynXsgDAZzjoLbYuJB0WR3vAzjHGvtT4mhgnfDgSIVndv1439/cYlDMy1emHzwSZ6nY49Nm4dcKAp9eqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qjrq4h7O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352ccc61658so1542489a91.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 07:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770479082; x=1771083882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRP584dbnm28OsbcU3hs9GLHFFCtoMKi6mf8uh7cmkA=;
        b=Qjrq4h7OzR1XgVq1MmRHrIMTmkRUSfAUXokbQU82Prhm8yKnScYI6aN7LVtqBrF+Hf
         JZo2+ShmZLQFMZMDwjMuhEnFZsVTCM6aiCCjkiO4rr028qW1w3DWQssbu13tA5dtZ3Cw
         7tdgLJnkca0uuV7Enj/cZ6kb0+dF45cTv3VGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770479082; x=1771083882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRP584dbnm28OsbcU3hs9GLHFFCtoMKi6mf8uh7cmkA=;
        b=okZ1qBVljpimfbNQAiVrbjf41WdUKCGnSRAHlTX/QDQDIZ1YjCZ6ou2ESUJH7DRdEK
         vqpP2EOyPPBquiYNvwBLvAF+HFqG471CwDQTMPTcvJQT4FTlH4TcQrBuvCUKnuJBbePQ
         FuL809kpXt8FWeJ4hsgQJoNZfsikHOvR1hM1bXGwUr6nU0/miyVRyiQc53jDDy80Uvzm
         iFHx1ZcMVweVz5UrAwBhkCAj1Advr/FGKNvWziSuSZ6ZwjqszhCugetfxvbToHLyRzAy
         ouRC0RV8eWKAc6d1ivK06XtUw71aMmjA65b7zlzpqJ7IGuR515noW9WlmL1Ff6Hw1lPX
         k5IQ==
X-Gm-Message-State: AOJu0Yw+50Ox/ZnVYmkJP1aKbbvtOoJNyObMgDTIS4dRIhKpVAjUiRpF
	eCbB0owhtfMSuUNqcP9+8mYKv21/SF1dHfV5b+gpyat8qKQW1qEyLBHyxjD9nfW5KdE=
X-Gm-Gg: AZuq6aLIkih3wfL2QZVQiBTWbHs/Vh3NAeZkMrefLWYIRSKKUgAgVZSxD/7Ya6dmTDn
	2oVRpLdpMqHdF6vY4whNlp1HdHs7eAnIQL0X1sCThQMXyyUWFAbXlD62xIXtZF/VJxJo/gRRF8j
	BnvSkRpdA2Wh8kZMMcI84N9Z2Zsv/Q1uHSUnTI9L1W6sX9arbIvd6HLoG6IlfwNk4LfHmBcRA55
	Lnmks3BzeK/BczPTjmd/eSgv3yGs1YQ08m+B7kWhtGQB1BkGiNDC1yPnwo1+Un87sq9PLI3wlMC
	4qxyoDy4W8O1ynr4iVZ+onFZh2387odlKNPGTQUwWFVleD7ZmVo6Z3BCHJgT8YeKZmpqcj50NZ8
	qK156kkCbb7owE8aW8iWDrwUv9ORD8LaTFyff4vJ8Ut8oH+kIFdMeggJiUeuJef1SNtuElXz+LS
	bExhiDF3RbQAwE0aAICgx4YP7i
X-Received: by 2002:a17:90a:d883:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-354b3be26camr5069867a91.14.1770479081987;
        Sat, 07 Feb 2026 07:44:41 -0800 (PST)
Received: from [192.168.96.30] ([49.207.181.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b53fa09dsm3673813a91.0.2026.02.07.07.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 07:44:41 -0800 (PST)
Message-ID: <b8f08e33-d669-4d69-9b1d-5a5dca5de4b1@linuxfoundation.org>
Date: Sat, 7 Feb 2026 08:44:36 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpupower: fix memory leak on execlp failure
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, shuah@kernel.org,
 trenn@suse.com, jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
 <20260204052143.3281063-4-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260204052143.3281063-4-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42247-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 8AD8910668B
X-Rspamd-Action: no action

On 2/3/26 22:21, Kaushlendra Kumar wrote:
> Free allocated page string when execlp fails to execute.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   tools/power/cpupower/utils/cpupower.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 3d3c5768c5d7..b74b4d19d95f 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -99,6 +99,9 @@ static int print_man_page(const char *subpage)
>   
>   	execlp("man", "man", page, NULL);
>   
> +	/* execlp failed */
> +	free(page);
> +
>   	/* should not be reached */
>   	return -EINVAL;
>   }

This is unnecessary - how did you test this code?

thanks,
-- Shuah

