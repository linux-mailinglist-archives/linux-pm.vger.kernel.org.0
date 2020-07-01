Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E7B2102A7
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 06:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgGAEMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 00:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGAEMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 00:12:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6881C061755
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 21:12:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so10400800pfu.8
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 21:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+fR5g5hKeYGrL/DpC1exUTm8ZVYDFKB3ckR2riVDD0=;
        b=UzgI19rOE764vGU7SFQDdRgSO+xjaPLz5krZf9jiRrmfIxzrsoI2FhIiTOXjr9HFMx
         Q2Fei2QAd7dFes10PTZO9Or5QnPhp9QyP6jCq2KQAlVKMiGdfeF8KhtNMhzkbT/R9JLw
         N74Bfo/Ug8cSTqeWL+oJAzg7VpLoAUXYwf2zRpWkXABw82qRCpc/E74pb1ga+8iJGFpq
         2aQ/byMoNqjPerVz8G2PrafOZoqe9jCSLOKXvkElp9wLnXjFl1A8VU/5sqna22ciJ0Cr
         0FRHk7HFvnxkpKy4NBx7H518AOePtMrvo+/n9uWfObQIwZV7h58/N+2Bqk2F5MRJEh8r
         2OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+fR5g5hKeYGrL/DpC1exUTm8ZVYDFKB3ckR2riVDD0=;
        b=p0tmMtqbMsd2uv6/p7IrmWxKRUk+ona0ObSA8QXgeoxO5xbG0HhSEAZ9StwbVw8DqV
         LK6Mcb5QfbN0+oaFmP2fizTnLiTO5A8F6bMx545jmityBez1jpJ0XgN/nBOLUdPzdtrg
         +YKo1hSiEwglWUgEBFCwNusoTtaEYd2H8HmXVkVuG95B9CbJa3O61hS5MIeb/njERS15
         hFySOFngVUWSpqTUC2RA40IJ67jgLbJx+Ppf7kpl5BOewpOdK4nGs6ypFGSC51IdZQpi
         fvpX2Fr8mDMmOqFAdi437g9YK/T4VIaHOrwi8tTbfhLC0ba5xdIEYnlGUj+mOmfTdizT
         foAQ==
X-Gm-Message-State: AOAM5311tQN4QyNK5LsDv6W5R0VZjS7kfkk+pefZwDHVSZV8ixddhxIx
        19101sKyEAXYfa9jADfMtK7AyQ==
X-Google-Smtp-Source: ABdhPJxupVepWv4QobFpsTdi9bcER9PfEdaM7M6SQTle+pu75UzPH7+1PuTQSLivgBO0Bq38UpEGKA==
X-Received: by 2002:a62:9251:: with SMTP id o78mr8798030pfd.256.1593576767290;
        Tue, 30 Jun 2020 21:12:47 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id u14sm4346023pfk.211.2020.06.30.21.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 21:12:46 -0700 (PDT)
Date:   Wed, 1 Jul 2020 09:42:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2]  cpufreq: CPPC: fix some unreasonable codes in
 cppc_cpufreq_perf_to_khz()
Message-ID: <20200701041244.bhes5bvtcfvm3zbb@vireshk-i7>
References: <20200701032610.11944-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701032610.11944-1-xhao@linux.alibaba.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 11:26, Xin Hao wrote:
>  The 'caps' variable has been defined, so there is no need to get
>  'highest_perf' value through 'cpu->caps.highest_perf', you can use
>  'caps->highest_perf' instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726a4456..444ee76a6bae 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
>  		if (!max_khz)
>  			max_khz = cppc_get_dmi_max_khz();
>  		mul = max_khz;
> -		div = cpu->perf_caps.highest_perf;
> +		div = caps->highest_perf;
>  	}
>  	return (u64)perf * mul / div;
>  }

Applied. Thanks.

-- 
viresh
