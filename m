Return-Path: <linux-pm+bounces-17967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCE9D63A5
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 19:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC6160FD4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292514387B;
	Fri, 22 Nov 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIqHSlgV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458646434
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298562; cv=none; b=N+r4JvacS/LmtZ5nIeSYrpui62PVXUnTeZxI/dFV8kDpFkeIKHTa2I4mgH6M07ukUW6xjB2TW1SL1/OYt9x6b7amGRQgW+pvc9ORG2hYjj0PkY1++e8huE4EGlVb6QA0PK1vLvwXMs88gdCqbBKf8qPOpLva2A2fpdEP4bgkByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298562; c=relaxed/simple;
	bh=ekCCgGqoPHo4zcbNwXZU0Fyaydg0OUHdYZ+WKARSEKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppqAQWOJY8oGeLnC6YO7qMMaMvi1zy/gK1yyUz0GKmYHRZzmEoY3v4dmW5eQaDOxHFxLJCjiRrixuOZItTTGyePNbG0W2B8pvslo6eevSg7y+q9z/anT6ZfZ8ZJeatOvIHBgdFXp8PPSL/cO+3mYh/3N3WurIixD9oEaJ4vmH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIqHSlgV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aac75fcceso80338739f.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 10:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732298559; x=1732903359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UKK6R6clrCso3TZBJx1KSDVNI3/xH6YnlT32kTkAIw=;
        b=LIqHSlgV3JQ6Jp0OOGhUFdVUouIi0PUXOSpNMNRj4iucPInGBwttzzKFlEnDQsTcyV
         FZ5BzCLvtt7Q6sdvDgzqh2Qh7+x434EBDh1UKTJQPcjDjA3uDRDqXRpBQ/adWiGibP7v
         VogoGAKFYrF2Dh0O34BBhhpyUxHIytdN6Idz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298559; x=1732903359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UKK6R6clrCso3TZBJx1KSDVNI3/xH6YnlT32kTkAIw=;
        b=H5khbNNUtUQQcKTGf9wtu2mO8/rGmThM04x4jOzhjitR0McJx3Ihg5AQyEoXjEJjAj
         YZTnWRIDGW1lCnAdBmMEuCtZ7O8ux0z575w7CBGDkvMA2YAuiTH/zwQTqQh937P+JGGq
         IsUUR/wu8XYairXZB6y+qQKI/55Fh099qngi9diUBxRzVIsdmplKj4wM9EaOviy7yK+X
         NbHJOal5js59IlknS8fFgHylutF4MdJ1Gh/TeFmbY/VLvRdRgaD0nD0b6QvtXH7k9/Bm
         Q/jv9xMB6ptUnHX3dKQWLWJkGRHrkw7CO6Jn6hIc405Di/dcBpM19jgkGSji/0RvHQGI
         cE5g==
X-Gm-Message-State: AOJu0YzrT5EmUzZMfIhmIM2f8L7aU/a0Wn0S0vsil1KfJOhkyR2NBUxB
	6JdliaZnbkxLG1IxZvesctxZWcQjCAAcILopz5deJTdOhoWfWZJ6XMcLVnIyHFk=
X-Gm-Gg: ASbGncviE20Wgba/lSMk1rWZIl9HQCf0whJuEXTGkWHcYUU0nY/H/ckuIxeNzwW1Mvg
	vLVJYcXmBArGZxm6/l0UNYEOpPK0qaVX3ivLAtnphZazY5WPYz/zFjoqOgco4d2673DzDain43g
	b8+ZA63m7+T+kQQ6cUjNW8uQmlSY5VKf69WlCNENiDgVgVuyiy3xto5nFmN8yq+Hk5jni+1VMTh
	tImjE5nddpjuBACZTRW0Y/p1Dx39ywHrWncSqHYcz8y8kXmEh1A5wjPwytT9A==
X-Google-Smtp-Source: AGHT+IFWzkCdRFFv1WAJ4OhtVkdsgjqMg1uTPe5WFau1RnEd7XbEpWY5vU7jhdifNFmZIwph0mKcAA==
X-Received: by 2002:a05:6602:164c:b0:83a:a9cc:69ff with SMTP id ca18e2360f4ac-83ecdd2ff2cmr388799539f.13.1732298559336;
        Fri, 22 Nov 2024 10:02:39 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ecd3ea05dsm55605439f.37.2024.11.22.10.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 10:02:38 -0800 (PST)
Message-ID: <6546a78d-9989-417f-925c-c6422c28f2f2@linuxfoundation.org>
Date: Fri, 22 Nov 2024 11:02:37 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Fixing memory leaks
To: liujing <liujing@cmss.chinamobile.com>, trenn@suse.com, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241121133212.6809-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241121133212.6809-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 06:32, liujing wrote:
> If execlp fails, page memory is not freed, so fix it.

How did you find the problem?

> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ec973165af1..36d486199630 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -98,7 +98,7 @@ static int print_man_page(const char *subpage)
>   	}
>   
>   	execlp("man", "man", page, NULL);
> -
> +	free(page);

The memory gets free'ed when process exits. Why do you need this?
  
  
>   	/* should not be reached */
>   	return -EINVAL;
>   }

thanks,
-- Shuah

