Return-Path: <linux-pm+bounces-33676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939EB41373
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 06:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C894C3ADDE5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B32D29B7;
	Wed,  3 Sep 2025 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LX6lc/8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE722AC17
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 04:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872892; cv=none; b=feMExcclTaHG1gCOmXdEwj7VqwrwvG3qAxUvDX69liYwzTUY8UXQyRQd/JYZLXyrka838kcGbvRCHvu/WUXVrqcuI2x5jEljedtujYBnTNQ5bz0khDNvz7UWsD8dRtfDopBGEFYdRf+DEEjxqxqiCpNSFJyp3bGKVeOelUAHGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872892; c=relaxed/simple;
	bh=pwpMnp02iR5Nb2xJei5nSyPw103lFtmOwIACABH/wec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4DHmfxby9v5uLNo8dGa4nKq0HnyJqKN0NMw8FE3kb9zB1B0OkcHlltnPnQHk1AgLjCc9ATdYKTdrzmltG/F948oDwgMHyi/RA8uFf9wp3W91uQf67MSAytJ8BpUW+6TzcPo9uRxgDr26Ut5PwdHCa3K8xvIO3YJ48rZ6u16mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LX6lc/8I; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-329b760080fso2245435a91.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756872890; x=1757477690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3736M7NCTLnENtRRfPhfcHj37p+iIh+YlnUYDC/dTVs=;
        b=LX6lc/8IUF+pScPW4nmbhn51UMQyqKdHekTgDIDfQdbQ9lHh8iyUPz07ZqI9zKxsI1
         /O8a9768TVrLkQbL+3q4T7WmHl5xBKaQAT3WsgxsyPdFWbTKdwxXoIe9wIt282YRGvLB
         /T6wOd/GGB+5iVgPQ8Tn60GPf5pgzfLfOAldSZlNxcok2RcQj7MS9rbgrhcOzF6ns/2B
         G2dX28q+jGRg8TiC4lRYTp/tdiBPGGngqL+Z+Afnq1houfRnbvz1gY6JRAYDrTEwwiLt
         bBdzHv20KrimuzXdjnkQeAmzdiLZ5hK5hSzGlbF5leNJni23K+KJVmQKIllLIPA4DcZD
         EgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872890; x=1757477690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3736M7NCTLnENtRRfPhfcHj37p+iIh+YlnUYDC/dTVs=;
        b=qNrF8oQJpu4YFcOnwQ9x7t/ZcdqhzWnPGTrqoSK/L+7Wq5MpaVk/kqFDT1vyC4RxdT
         WOMOSrg1sHHWk11mNL7Ed/9Gft0OlUhaDZaoGZcjyoydL3GmoGbyCm2e5GeNj4HuERke
         o9iaAddjq1N5lWstj8wVeonYZhIjRUzmEhqvrUpRbnZN1GTR4A7uv6z2sryFl9EOwqnI
         L07+ZDTDfxY+DM42RYwS1mBERdMab7F03R7nN8xhvC/4OM1WcraS+jQlq8b2LkANxTJ4
         e1DcoOc41Jj9Ryq76Wrhx9lMxD1AVyKMzLaJSPvWxBSFrLSU0zfgI1cpc66z5cNl+s3r
         fB0g==
X-Forwarded-Encrypted: i=1; AJvYcCXOj0vFSlCl7P4RCbxJmBqan/0sgLvyLG92/2Rz9aE07T1ADGzWtwRSnMHPtHIL/JJyTGiJRbuz6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxAgRELC/CjjyJNYVwz3Z0mrP0ywQXSm5QXxVHQC38urMN5ZSg
	eK0KJeoRKv3z624HrOM+YPuFLujgm7MIeT5GO9aIV46ges9nqlpEOwdleyuTDpTq5Pw=
X-Gm-Gg: ASbGnct8RDaRkOiPfWll0aXDWKRMQRx1+c/cMTIOXo8sA2ZvH33XKqkmRnmpBxJMegV
	SblXuW7Ju0L+C/I9cO0y/1f9yO+zolFV5UhUQyZ24t9KFtxldrD1bWivseyDv7XD8AieMAxGNMs
	5zB8LDjoBeLcbfzRPYF6woJvBzDmVpgi4BzLZXTTdZyneKaukmst+hR8TAl4BReweFmMUxa71Ng
	jDP1Xzuw/rraqmn1R0wTdWhOwS3Eox/Q1OvqwvsmuErYkjbdGhFYSlS8ZsbtoXbPg+IpKL1ft11
	N0mgUgTGNIYEM0RJI7Rj/0CQbyqsC4uwQfZZV+V9HDIjmrLvjJ7VsYOfUILsTl/j8muNpbh69sZ
	tQ2q5gUKgreiL/Zd60ZtZ5y9Sz7pBySzyiDE=
X-Google-Smtp-Source: AGHT+IGcvj4f93HyRKYjmm+ix+F/dgYOGHgJhEHnb22iW86TWueIT+1XgMH2qdsfKMuWPvqAcJ0VJg==
X-Received: by 2002:a17:90b:2884:b0:327:ca0a:67b4 with SMTP id 98e67ed59e1d1-3281544fe3amr20695525a91.12.1756872890400;
        Tue, 02 Sep 2025 21:14:50 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d08a36b3sm4862695a91.25.2025.09.02.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:14:49 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:44:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cpufreq: powernow: Use int type to store negative
 error codes
Message-ID: <20250903041447.6t7q5ddoqwm3og4d@vireshk-i7>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-3-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902114545.651661-3-rongqianfeng@vivo.com>

$Subject is incorrect.

On 02-09-25, 19:45, Qianfeng Rong wrote:
> In powernow_decode_bios(), the 'ret' variable stores either negative error
> codes or zero returned by get_ranges(), so it needs to be changed to int
> type.

You don't need to mention this now. You are making a different change.

> However, since the 'ret' variable is only used once and can be
> simplified to 'return get_ranges()', it is better to remove the 'ret'
> variable.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>  drivers/cpufreq/powernow-k7.c | 4 +---

There should be a `---` line in between these two statements, you have
corrupted your patch somehow.

>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 31039330a3ba..72430c3c5500 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
>  	unsigned int i, j;
>  	unsigned char *p;
>  	unsigned int etuple;
> -	unsigned int ret;
>  
>  	etuple = cpuid_eax(0x80000001);
>  
> @@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
>  				    (startvid == pst->startvid)) {
>  					print_pst_entry(pst, j);
>  					p = (char *)pst + sizeof(*pst);
> -					ret = get_ranges(p);
> -					return ret;
> +					return get_ranges(p);
>  				} else {
>  					unsigned int k;
>  					p = (char *)pst + sizeof(*pst);
> -- 
> 2.34.1

-- 
viresh

