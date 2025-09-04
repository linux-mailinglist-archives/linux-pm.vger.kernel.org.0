Return-Path: <linux-pm+bounces-33787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10413B43147
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6CE541BB4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 04:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B272606;
	Thu,  4 Sep 2025 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZhjqnqg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58301BC3F
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961162; cv=none; b=nAihnNt123uj5XcK6pa+uB7W1+5n6C3BXpFCB1Jqh24WYPlRZ0V2bkeoFRe2dWhnlmeYr8E+ZOe7cyCw44t1JzMjMuo/DNrV0TM7BQGPQS0Zz8GOeDJ9BKkHm5Sd/OUqH+3t7mGBavCPgfbxoCt7jbh2V2STV2zE4HtbZSUCW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961162; c=relaxed/simple;
	bh=fV2Tk+cAJFMvm725WpVa4ywZ3SnH9lOf9TlnxGHH9qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRAj3af6J5ArvIfvE4gzBSF4IrZbGOgMUGwDUEV0ydRkgUFC9lG0KF5V/Q0QijfyEJzlHhjhN8OedbZb1Sj+pFq0vi9ci0byQiWX4LInp5B9pQDDieUghqjNVtktUhZMVfiFjkpBJMsrbk7IvzNrU27zOR6zMDitwdu8r0n+nAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QZhjqnqg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c738ee2fbso480173a12.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756961160; x=1757565960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVwtOioJ6QQmoqBdgt4Ax8qFgErbBnqWc/akKz/RHWs=;
        b=QZhjqnqg8OCUeubSWDzUjhwUjZvoCAckzWIYec079n8cjwdNniWAxFYIHZo8FmBe1m
         QeYRasz+X9TOP2yRqmH25NCwVmOL44nBUVPmk6TpbMzC9Q27wdund6CSjhowjjAKXENc
         VTz/vPSaZr9qP0rkvikQS6lOVLY998wJUIDlSPwD6ctQytUU8EqqGCK8RO2EyycPsGHz
         2PMfpZutMMd/BX6UYyuz9HbF3ulqulkdX8Z+BY3WkmQVWagmOaOUOFSO76klMUoASR4n
         ug4bpMjSwlNMYc1zgtuh+sb28ubJocgUop0YqGdEZCs3n1kmdEorP2MF0o7fLdrmWce9
         S99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961160; x=1757565960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVwtOioJ6QQmoqBdgt4Ax8qFgErbBnqWc/akKz/RHWs=;
        b=l8IAd4tz64N2XON4lggs37jJ1XRfhpDzst3+ry+tDcKc8eekOYzXmH+eAWsVZDvk8p
         BSAPdrtXvcCsOB1YUg281gYomncLHCBNd2GHsm6NiA7Y14H8geI9D1FHMzUvVD4zVYU2
         GYKbqMp6Rc4BXxE+tRrE3DV+DxvIMd4rydWCdOdW0dtsb1Smps7LvUq5Okr9sGQ51A9B
         qXEeiJy8CkexMAkGQizAFc3J5cOIlozbAzQZ5D5lIaUwuLRmnLgkQn7zM95xs7PCdxsO
         FAKEusKVsIoWscaVAHsrkb5Bv9RwodHxaUpYDG6mOC9egsjLQdH82mCCkJQw9HuXAMLA
         U4cA==
X-Forwarded-Encrypted: i=1; AJvYcCVFj2kSXHJZgiB38a0XonO3BuFBmIFtbGAOBljm3TGKyhiwu3g+ebfqF8an3U3Iv0fEuyVualMeEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJlaD2J74dhEpbQMXMcmoZStx34LXFlVNUdGMj2SXzb3YbVeJ
	OpkFB04wozP8KK6uwBsrnkuisnKJvyjavM8uph5y1OuVkU/MGD1NiHRTlUrdhTA9Bxk=
X-Gm-Gg: ASbGncuHFVfzh+Vch99xdjTho/11vzW07Umm7cDZ0iTseDckF4Jj5y1TOvagvQeWE5a
	gDuEiL1rNGY6YRbpfSfZmEGodlZ9xFoduys2l7KoFbSCYP+LP3Sbjnt+XY6q9p9bidZgEXw94Wd
	dLWWWk/IzIBOTtQgZHGIGY5i+i+43LyWRkXhimx6YX9+uFObHrXkDCAUEOIKJ9THy7wvC7y8k9P
	smLajYoA/I0zB8tDiP3cT/JFeEYcGU4bT/hq2Hg5cdd9c2CMkyYV9RP9OI7d+k9UxF3R5wqSqKh
	z6vTXQfn7VGoo95TUOxVbmmN1N1JU4FK6NmC0EQlzZ9iWVgiBoxNEfHjzqcaTRYbObmpZF10d1A
	bZxiB+8mnVQ/cUDKC9lP6T2ES
X-Google-Smtp-Source: AGHT+IHWGXeH6oTQDDhuBdIP3fhF+mpaRH7oxjZ7f709N/WQgz/IqaZIzWCaAXXOXynM2TWc33SOuw==
X-Received: by 2002:a17:902:f543:b0:24a:ea31:b523 with SMTP id d9443c01a7336-24aea31ba6bmr163168215ad.49.1756961160175;
        Wed, 03 Sep 2025 21:46:00 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caffd7beesm18391575ad.121.2025.09.03.21.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:45:59 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:15:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] cpufreq: Make cpufreq_frequency_table_verify()
 internal
Message-ID: <20250904044557.tde36hekoeuhnsci@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-4-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904032210.92978-4-zhangzihuan@kylinos.cn>

On 04-09-25, 11:22, Zihuan Zhang wrote:
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 642ddb9ea217..ee3fd1e71b90 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -90,10 +90,8 @@ static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
>  {
>  	struct clk *cpuclk = &per_cpu(sh_cpuclk, policy->cpu);
>  
> -	if (policy->freq_table)
> -		return cpufreq_frequency_table_verify(policy);
> -
> -	cpufreq_verify_within_cpu_limits(policy);
> +	if (!cpufreq_generic_frequency_table_verify(policy))
> +		return 0;
>  
>  	policy->min = (clk_round_rate(cpuclk, 1) + 500) / 1000;
>  	policy->max = (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> index 6ffa16d239b2..2498f40cd57e 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -249,10 +249,7 @@ static int virt_cpufreq_offline(struct cpufreq_policy *policy)
>  
>  static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
>  {
> -	if (policy->freq_table)
> -		return cpufreq_frequency_table_verify(policy);
> -
> -	cpufreq_verify_within_cpu_limits(policy);
> +	cpufreq_generic_frequency_table_verify(policy);
>  	return 0;
>  }

You ended up changing the logic of both these files and it isn't the
same anymore. Earlier if freq_table was there and
cpufreq_frequency_table_verify() failed, we used to return, but not
anymore.

And we don't return the error anymore for virtual driver.

-- 
viresh

