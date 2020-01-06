Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F6A130D3E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 06:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFFpB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 00:45:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40106 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAFFpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 00:45:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id bg7so7300854pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 21:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gE/Gid9i9PsBYsQlg4fmp57Ncbkyju9XGadeZRX0gF4=;
        b=YUsvcYgUUc5z5cDmx8TusJQdedghyS4mO/+HKbOr+CblccrQl+0cwBT/vWzbe0MHx2
         QygMwZvxE2N9VK/mg1gpYFlKhzqVWWQDfFDD06SaYUeNbJk1uKxokGj70ZQUsNpKbctH
         FcK9o5kCJ58G6vlgT2qslLidoX4nKlSzRwsXMA/lpRPCnTg5vcLZCnt1RYfngBon8GVt
         BizW140hesxr64i4pb/Nqt++6R7w/yZ1EQ6XAwj0PuWyZ19c4HyMp2Il8xuOT/UQuLW/
         ixThiTGoEbMLhxGOmd03HKC19gcrvrpV53g3LS4laULn8mfedP0+ba3r5p6XqVAc3KE/
         r9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gE/Gid9i9PsBYsQlg4fmp57Ncbkyju9XGadeZRX0gF4=;
        b=PkzSdOjzAVpcHMo9Lj44kSCp7Ll7Qzujk/nAlodnkN8/nwspFWKe6qXt1UpBkITY2a
         y+quo+lnORLj3FRL8oibdu2DBjzgJ8eAtFZT15YSgUpVCzNfrru42khuTydnKveTd4Ss
         xpXVNHHzxmeiM6l+dx7MqcpaoxMRN5lHMohKXWVYCdLmFrPPS2myrrnYFppH75NtCXDs
         7Jg2XzNM19UfByEMC9ZZ6qbhMYDUIWlr9c2V89x0iCi4t8t/9QuOo6he8AW/kSEvzOZb
         x6fMZnqlAD67vnpefLejSXI7SpSKg6m1uYY9xiIv4PTxpiT/nGmX1R/CB/OE9BJU4X9a
         AWRw==
X-Gm-Message-State: APjAAAUNHedGDafVZM3JKCt3DY6zl48g+0bjkO9Dhso1f7ubDOzzrllr
        7BjmQTqUvAiYTiMyWvV1VFExgw==
X-Google-Smtp-Source: APXvYqzWXlQqvmRVI1MoLPER/6vOzIRLLhjY3gbCu4p9smluhkTOdAjJDcJ2o3CSCudp542u0BhlaQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr104008787plo.28.1578289500553;
        Sun, 05 Jan 2020 21:45:00 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id n26sm74694101pgd.46.2020.01.05.21.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 21:44:59 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:14:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwuchen55@gmail.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] cpufreq: powernow-k8: avoid use after free issue in
 cpufreq_notify_transition()
Message-ID: <20200106054457.sgz4uevykvkqdqzt@vireshk-i7>
References: <1577501824-12152-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577501824-12152-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-12-19, 10:57, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential UAF issue in cpufreq_notify_transition() that the
> cpufreq of current cpu has been released before using it. So we should
> make a judgement and avoid it.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 2db2f17..7391eb0 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -913,6 +913,11 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
>  	freqs.new = find_khz_freq_from_fid(fid);
>  
>  	policy = cpufreq_cpu_get(smp_processor_id());
> +	if (!policy) {
> +		pr_debug("cpu %d: CPUFreq policy not found\n",
> +			 smp_processor_id());
> +		return 1;
> +	}

You $subject and this change doesn't look related to me. The cpufreq
policy shall never be NULL here as we are in the middle of changing
frequency, initiated by cpufreq core itself.

>  	cpufreq_cpu_put(policy);
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -- 
> 1.9.1

-- 
viresh
