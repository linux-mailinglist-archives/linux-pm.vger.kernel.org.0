Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083FA220910
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgGOJpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgGOJpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 05:45:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B1C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:45:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so2177067plr.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4BTTr5oucsR8JbbShHUL2XbMTStwAjQe5P0BncDXj58=;
        b=ZiDAjjBZM/18U5oGdS+177O7tJJlRYSHzUSAe7RuMTwrs0ACtN+bj5Vbw0m+RP4NPH
         FTONJ3j3zDRFBi+lWSl0lFFi7SsWDRcd3haI5usSaW9MdEiP5pSEiaaw6TRA4ipn7D+E
         0PY7Zn85htsoso7JuhFupFcqKQb8r//K9EGlDqKbcPdEA0afofS2/DMj6UdomWTvtScp
         kYjZIsAPHODHik5Xo0NOQXlzKz0x9Roae3Yw6eUgGmnnn8P1/OlOZ7C7HDIkHseLKkUI
         0l2LtzDn74BqqRTB4jYPHTGn2lZk9HZ4dXGm8iF00EjXaN74jT/lxWmYZoqyD9Ncao+T
         cK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4BTTr5oucsR8JbbShHUL2XbMTStwAjQe5P0BncDXj58=;
        b=rkCbtC7BEJSVYsugYPK6cvHQGhJXkOqlxMM3J3FI2PohTkeepPOp+soz/o/XSnW6pS
         JvNOnQOVUPWMIwRKYdUM7p+r5/k1KlPr5W83KivvHSkrWNDfzp/Rutx3iYwFhr9qL88Q
         Lq/cFk52c3qJB7ODzjkR6Lna0/nOgBCF8JeNSyL5XxH1xDyBTOuoHTU5+7AnPPfHwZku
         o5TjUP1Wwck59IJwQEC2WTDWRjUfGzGGZ5hBZVZlA2+1I657Iu4S34AmKQTFgc1Z8KIh
         JeCxk8BEkviZA8a8y65EZ6PmzMg7DFkjsoUDiMtF3nCPGryYpENmg4k3XvZpfiakapFD
         Hx2Q==
X-Gm-Message-State: AOAM531hQmRa/ZMU8wGJJiH9rhZCUdFQnoy8siZfkiTqCtblPYA7FntK
        UwE5Lahrn/9GawblMcmHv20KGw==
X-Google-Smtp-Source: ABdhPJyrLXJkqRK/7BhC4BFVruLsng1ogMN6DlNeSjBGIhJnVoVhQXAvhZxEgnc3/B4w8m9S8AXf5Q==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr7404932plz.69.1594806307293;
        Wed, 15 Jul 2020 02:45:07 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id z13sm1605674pfq.220.2020.07.15.02.45.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:45:06 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:15:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 06/13] cpufreq: powernv-cpufreq: Functions only used
 in call-backs should be static
Message-ID: <20200715094504.val6rb7wibysh7dn@vireshk-i7>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715082634.3024816-7-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 09:26, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
>  drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8646eb197cd96..068cc53abe320 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>   * according quadratic equation. Queues a new timer if it is still not equal
>   * to local pstate
>   */
> -void gpstate_timer_handler(struct timer_list *t)
> +static void gpstate_timer_handler(struct timer_list *t)
>  {
>  	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
>  	struct cpufreq_policy *policy = gpstates->policy;
> @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> -void powernv_cpufreq_work_fn(struct work_struct *work)
> +static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
>  	struct cpufreq_policy *policy;

Don't you want to drop this patch now ? As you already reviewed the
other one on the list ?

-- 
viresh
