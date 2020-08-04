Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC923B2CA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 04:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHDChu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 22:37:50 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56822 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgHDChu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 22:37:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U4iAThY_1596508667;
Received: from IT-C02ZL2E9LVDL.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0U4iAThY_1596508667)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 10:37:48 +0800
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <8643d122-c069-192e-8f3a-dc18f84eed9a@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 10:37:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200701042007.13333-1-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi everyone:

I want to know why my patch didn't merge into upstream ?


Thanks

ÔÚ 2020/7/1 ÏÂÎç12:20, Xin Hao Ð´µÀ:
>   The 'caps' variable has been defined, so there is no need to get
>   'highest_perf' value through 'cpu->caps.highest_perf', you can use
>   'caps->highest_perf' instead.
>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726a4456..051d0e56c67a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -161,7 +161,7 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
>   		if (!max_khz)
>   			max_khz = cppc_get_dmi_max_khz();
>   		mul = max_khz;
> -		div = cpu->perf_caps.highest_perf;
> +		div = caps->highest_perf;
>   	}
>   	return (u64)perf * mul / div;
>   }
> @@ -184,7 +184,7 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
>   	} else {
>   		if (!max_khz)
>   			max_khz = cppc_get_dmi_max_khz();
> -		mul = cpu->perf_caps.highest_perf;
> +		mul = caps->highest_perf;
>   		div = max_khz;
>   	}
>   
