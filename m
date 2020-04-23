Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712D11B5C7D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgDWNW5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726429AbgDWNW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 09:22:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4374C08ED7D
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 06:22:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so6803177wrg.11
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6lrCN4Y2jvBEhMEE9yoKB0QoRLluJFmgeNzXOO0519c=;
        b=MfGul8Hpypn6B6iEzWypyjdhBn2Sm6I3sSyNkRkdieKZwsujvoViJAlUxKfCp6PvVT
         nwSpOW9fHqYx6TfeuZBHXpiT/Q2s2RfycyW/XV2CCERaWqWBevrZxULrN89FB2oqqqIj
         EC4+LROpYsU0aZMAoa54xpOSfpfCZFQyZRrwaCx87r3hFioBkCt8KsdEjlJAImIi4s1I
         Us/CNyKM0JIG8zvg7SiTo3pIgmAXzgypQm3ZpltQJG1qtzhzgxWvcovuoFdh5tQZy9Cx
         NgvYaqs9da3YhKQ+izEK3Cgf+BXf15gAENfjKuHLNG3VaHH3xMMHcEogSfbIRqjGk5gK
         /7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6lrCN4Y2jvBEhMEE9yoKB0QoRLluJFmgeNzXOO0519c=;
        b=Mvavz/l39qUESecoWUcya/Kr5llCQ3F3TrmMEAK3hxRIKwxrZM0zqPZg6WhIdAQhlF
         Se5DzXS1vs5Sifll4rQvQC5yPG2y3fvfJnv2jbO/+oJb+bypQTlQA1PKS9CVfVeAptIT
         4b+dkHN3DXssQJBHsmknAs4LHs+qidKBs58Q2bHfsOQdfPClwa5HpmH/BCS0JwnjBilL
         U6hALuOo6eT1yNgFVkpQxRWTWwcPA3dJAupuPnszR9kZKNtyqKx3+OSY5OXOKt3bXie4
         L7gtkYmQwYsjOaMj9hu+CpMghlz0uYo91dxaULa98KdXoFD+1+qMVxa5CXsxcWBUlnwI
         hHmQ==
X-Gm-Message-State: AGi0PubGh7PvpLEkJyjl4IEFdj+rTI5A4vsvipHq+EHpdgASVSutVsQM
        2ZLXZONOnFYJ6gPYFmNGgkuSBg==
X-Google-Smtp-Source: APiQypLIExvxbZk7AtfC6O9cBOXmdm+gz1QSH3p+99FlJwwJBGarRXDyjXQkXRxvvC0opKaSfe3/tA==
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr5430755wrs.158.1587648175280;
        Thu, 23 Apr 2020 06:22:55 -0700 (PDT)
Received: from linaro.org ([37.167.216.250])
        by smtp.gmail.com with ESMTPSA id h137sm14658623wme.0.2020.04.23.06.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:22:54 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:22:43 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v6 03/10] PM / EM: update callback structure and add
 device pointer
Message-ID: <20200423132243.GA65632@linaro.org>
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200410084210.24932-4-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 09:42:03AM +0100, Lukasz Luba wrote:
> The Energy Model framework is going to support devices other that CPUs. In
> order to make this happen change the callback function and add pointer to
> a device as an argument.
> 
> Update the related users to use new function and new callback from the
> Energy Model.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

[ ... ]

> +static struct em_perf_domain *
> +em_create_pd(struct device *dev, int nr_states, struct em_data_callback *cb,
> +	     cpumask_t *span)
>  {
>  	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
>  	unsigned long power, freq, prev_freq = 0;
> @@ -106,7 +107,7 @@ static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
>  		 * lowest performance state of 'cpu' above 'freq' and updates
>  		 * 'power' and 'freq' accordingly.
>  		 */
> -		ret = cb->active_power(&power, &freq, cpu);
> +		ret = cb->active_power(&power, &freq, dev);
>  		if (ret) {
>  			pr_err("pd%d: invalid perf. state: %d\n", cpu, ret);
>  			goto free_ps_table;

Why are the changes 'cpu' to 'dev' in the patch 4/10 instead of this one ?

> @@ -237,7 +238,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  	}
>  
>  	/* Create the performance domain and add it to the Energy Model. */
> -	pd = em_create_pd(span, nr_states, cb);
> +	pd = em_create_pd(dev, nr_states, cb, span);
>  	if (!pd) {
>  		ret = -EINVAL;
>  		goto unlock;

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
