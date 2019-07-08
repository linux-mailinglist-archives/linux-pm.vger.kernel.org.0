Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66061BFE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGHI4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 04:56:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43798 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfGHI4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 04:56:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so7873478plb.10
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=caOy47iObIWpUBNz9YBs1LqOSsSKOy2UuatZJ0Q43mo=;
        b=myXVVq/De7PJ2z5d05SOEeW9WqlEyQ4+XK7XGpMu9Odl2pSEwuPPfvChi0jyw5HI/Y
         xuQngalAkxwy/I+4pwJIpROTjgVrNECyKTo9JpQzuE+Fi5P2WKsW6/eGA9Awbr9WV1sl
         SKYnJujSLhGvFnD+06SsWwRFcixnQ2wEL6xOWYiF6VyBQWrX3Hk5M/JtZia6vnYoX9/k
         oX0O2CP1TL3Ma6mtYxuqAfS71NpdKPw3hWVN5yu0Hj+vXYAuiPwGBIn9Im3CBb26cB1d
         eD35TTwwNZk5Sk5K0oVnz7hZCILs288rCBrPEDFZ1vQx2PDAlff0BHg5q48D66F9TkjT
         T6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=caOy47iObIWpUBNz9YBs1LqOSsSKOy2UuatZJ0Q43mo=;
        b=cV+tMlRRdpBEQXkHjfD59xixecF98qdO+g/YFOGhkV6H0Y4b8QnVyhq/dWNhs8bdcJ
         ynDmG7VT/FG6cYRafAyTISwMxfxvKiUaI3xGtX8Qr+j8DMLpVGxfuu4LjgJ6oSzlFFuL
         75b34O4U7iB0IP1fnZALggIEdD+078BaIeQzaafHpVf/ckaSaNqyrql2EPcRhvZjbOZY
         lYRC9Tp8KWg1oPCv1nTgHsCevGdzPNKIObHHpPxkkYczx1/oeCAtQ/8YLD1hTpEZIYl/
         R9GatvTHsMP+mRRqrhx2xmgXrM6bv/ssuOp+6qRip+W3rVzXSkqnTOjCNRMgrho/qYeN
         FBug==
X-Gm-Message-State: APjAAAUMA7RczwHgbHuJEm7lTXHCgFv09AGq39bdQdsgEwNcgfMo7uuM
        wcQtgZ+4Hv8WRniGLzB3pmKzEA==
X-Google-Smtp-Source: APXvYqx9dBbfaCeSrlWG9YwA8C4t0s8GIS3+7DlJ/SNiwhtLdjCXdF/a0g0X0AN2yjaZsVJ4/G87lg==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr22483969plo.290.1562576169340;
        Mon, 08 Jul 2019 01:56:09 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p68sm26882425pfb.80.2019.07.08.01.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 01:56:08 -0700 (PDT)
Date:   Mon, 8 Jul 2019 14:26:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190708085606.tqhb3dgotj7sztyj@vireshk-i7>
References: <1562575726-17438-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562575726-17438-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-19, 16:48, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 6b1e4ab..9dc5163 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -128,20 +128,20 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	int cur_astate, idx;
>  	struct resource res;
>  	struct device_node *cpu, *dn;
> -	int err = -ENODEV;
> +	int err;
>  
>  	cpu = of_get_cpu_node(policy->cpu, NULL);
> -
> -	of_node_put(cpu);
>  	if (!cpu)
> -		goto out;
> +		return -ENODEV;
>  
>  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
>  	if (!dn)
>  		dn = of_find_compatible_node(NULL, NULL,
>  					     "pasemi,pwrficient-sdc");
> -	if (!dn)
> +	if (!dn) {
> +		err = -ENODEV;
>  		goto out;
> +	}

Please restore the blank line here.

>  	err = of_address_to_resource(dn, 0, &res);
>  	of_node_put(dn);
>  	if (err)
> @@ -196,6 +196,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = pas_freqs[cur_astate].frequency;
>  	ppc_proc_freq = policy->cur * 1000ul;
>  
> +	of_node_put(cpu);
>  	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
>  
>  out_unmap_sdcpwr:
> @@ -204,6 +205,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  out_unmap_sdcasr:
>  	iounmap(sdcasr_mapbase);
>  out:
> +	of_node_put(cpu);
>  	return err;
>  }
>  
> -- 
> 2.9.5

-- 
viresh
