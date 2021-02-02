Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342B230BB3F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBBJoE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 04:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhBBJmj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 04:42:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C16C061573
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 01:41:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gx20so2013446pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 01:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i+L3gHCFPBrOT3OzqVoJEMLNmPS76kGxMPoMoHjeHoE=;
        b=NmWfjQeMO9d2WIIHpRdr6jr++3hDWkh6UnfVUtcg3HEYXxLcaL7AhreofkbExfTfS4
         HXCv1wU1SMG+oDz231R7azvftZV6BbcfX2kUysu+hITsqutmoML1fgsSGk36rj7wXkMe
         Q610MrPMFv2xU69rKbE68aXh82NgoiIe3RrhBv0rMQtoKrwF14r56ohHIqknoDYxvko5
         UVT3DK9WZ5BqdlG3BDlst1cFW/Er8/rjU2UiUK2zOBgi1n8qCSlr93b4LES3ayyqOLvp
         475+iETXMcZFDG+M+Kkn7X/cyCbT8DlhAsOZvvN9IyXcTSBvWQqs2CweLlk3QkLDBein
         tuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+L3gHCFPBrOT3OzqVoJEMLNmPS76kGxMPoMoHjeHoE=;
        b=FCdgjUa8EBu3np0dA1I3diSERk3UOwvSnHQbbKI0W9uYcLsyQ7I4YNkhlWw8UeI7Pz
         Weuwnxm1mgCTygKE2XgAO2eTEssNui90KlazFcX01pnlzTPjXCRPKC1uZI/X0ZxpAtNE
         5x9rN+LJSssm8822Tc4OyQn5voqNZ6IBd57LoJZqPuhd+AAe1rU7TMTE3t7QAIXSGv5u
         fIBnlkLL3rgIquO8YDhK2Ig/L3ScfuLft5jxGXiOlXINxjsDPTgCozHNcOQvtd8ckyTE
         VKhtVZngfxQKtbRBZcnBAN3ijYpRJHsEq5MhnJ+uAGfHz4tY28csJBBK+zIa4LwTpZwQ
         /+WA==
X-Gm-Message-State: AOAM531hnjbeMSgJ6YErtvqjJrbQ+naFBN0u6xrgPIhI8Xzqyg7Ftcq7
        J3CVMVbDgav4Klq3l/wavKCc3Q==
X-Google-Smtp-Source: ABdhPJyElb1lJb3rLmD6VqzU2AijwVSJresCSXvrAwJduFmPfBlCwkCStWPQvpEfYcFDwxoaBGv9eA==
X-Received: by 2002:a17:90a:5287:: with SMTP id w7mr3515259pjh.52.1612258918668;
        Tue, 02 Feb 2021 01:41:58 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id r7sm21092013pfc.26.2021.02.02.01.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 01:41:57 -0800 (PST)
Date:   Tue, 2 Feb 2021 15:11:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewyan@foxmail.com,
        Xuewen.Yan@unisoc.com
Subject: Re: [PATCH] cpufreq: Judging new_policy before update related_cpus
Message-ID: <20210202094156.tb27lpq2nfzvbxgi@vireshk-i7>
References: <20210202093619.543-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202093619.543-1-xuewen.yan94@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-02-21, 17:36, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> When the policy->related_cpus are all offline, and then
> bring up one cpu, this time, if the ->online is NULL,
> the code would update the ->related_cpus with ->cpus,
> and now ->cpus is only one online cpu, as a result, the
> ->related_cpus is different from the origion ->related_cpus.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d0a3525ce27f..3d512ac463a5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1374,8 +1374,10 @@ static int cpufreq_online(unsigned int cpu)
>  		if (ret)
>  			goto out_exit_policy;
>  
> -		/* related_cpus should at least include policy->cpus. */
> -		cpumask_copy(policy->related_cpus, policy->cpus);
> +		if (new_policy) {
> +			/* related_cpus should at least include policy->cpus. */
> +			cpumask_copy(policy->related_cpus, policy->cpus);
> +		}
>  	}

The driver's ->init() callback is responsible for filling policy->cpus
here.

-- 
viresh
