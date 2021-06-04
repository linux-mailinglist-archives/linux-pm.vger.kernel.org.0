Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6370639BF52
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFDSLJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSLJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 14:11:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE351C061766
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 11:09:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g24so5976704pji.4
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kLu3vjQlGZ6KdZHPZTDgU5PEXuxsb5EjFBe3ivrW8O0=;
        b=GXeWp5ki+scamiEKISCtgg/4/C5hJF0A86vMkYZn72ituqqCUbvWWK8XtTZuvjde8K
         jl8RTgStdoBvVbR3VuUe3/ZhKDqyyQlE3zHNLnHAhzJ0IRizMX/YlVQzhBLAHsBd+dFt
         UMpxeGfrjen2Js3rC8f1tsu6NPEtK910P12Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kLu3vjQlGZ6KdZHPZTDgU5PEXuxsb5EjFBe3ivrW8O0=;
        b=rjbSgHqHUYjVPVCgJ8HhCnLcUxUCv6iF0JVKZ0tTd7QABLh/Rq4dC2+6g2mEWQH3J1
         E/HcX5hrqz7e2P+/k3PX0neV2mhGN8mPNN4iFeXk37fTZ46+Eeou2SgDMGQWHevE/7ZC
         pbS2vOxF/0O5GWtgZ345DTkuBOGz6UqlwoaRJvJKO77/h/GvkKbaHteVaoWXkh02k1Z4
         Yp1ytXabDCj/uNYMiO5eK7Qwot4zDkxEq19hu4G2s+agXIziJtnLDNE3XNAPFwpveoYA
         RsqtFtAXYaF9Iaw8t4F3Vs8Si6ByzNlJIYwDxaKRzNWaA+vwWaYeuZcQDmBnJTZHyXN7
         AH7w==
X-Gm-Message-State: AOAM53348/U+BILgV/9/yE0YwjRKZM6sVFwMxe6WejUnfAfM8PgBpKrH
        6LWZ7u2m8eqkqOdIq3Fxy2KiGQ==
X-Google-Smtp-Source: ABdhPJwC3nr++/6pPm11hFW26AJIwlhyYlH6xxZH1jzYYJKio8f/hGAkLe9G7ll0/2wuCp3duIy2mw==
X-Received: by 2002:a17:90a:1688:: with SMTP id o8mr6158627pja.92.1622830162357;
        Fri, 04 Jun 2021 11:09:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id d22sm2354712pfn.147.2021.06.04.11.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:09:22 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:09:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 1/6] PM / EM: Fix inefficient states detection
Message-ID: <YLpsUKwHNn0RgyKb@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-2-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622804761-126737-2-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:05:56PM +0100, Vincent Donnefort wrote:
> Currently, a debug message is printed if an inefficient state is detected
> in the Energy Model. Unfortunately, it won't detect if the first state is
> inefficient or if two successive states are. Fix this behavior.
> 
> Fixes: 27871f7a (PM: Introduce an Energy Model management framework)
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 0c620eb..c4871a8 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -107,8 +107,7 @@ static void em_debug_remove_pd(struct device *dev) {}
>  static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  				int nr_states, struct em_data_callback *cb)
>  {
> -	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
> -	unsigned long power, freq, prev_freq = 0;
> +	unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
>  	struct em_perf_state *table;
>  	int i, ret;
>  	u64 fmax;
> @@ -153,25 +152,19 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  
>  		table[i].power = power;
>  		table[i].frequency = prev_freq = freq;
> -
> -		/*
> -		 * The hertz/watts efficiency ratio should decrease as the
> -		 * frequency grows on sane platforms. But this isn't always
> -		 * true in practice so warn the user if a higher OPP is more
> -		 * power efficient than a lower one.
> -		 */
> -		opp_eff = freq / power;
> -		if (opp_eff >= prev_opp_eff)
> -			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
> -					i, i - 1);
> -		prev_opp_eff = opp_eff;
>  	}
>  
>  	/* Compute the cost of each performance state. */
>  	fmax = (u64) table[nr_states - 1].frequency;
> -	for (i = 0; i < nr_states; i++) {
> +	for (i = nr_states - 1; i >= 0; i--) {
>  		table[i].cost = div64_u64(fmax * table[i].power,
>  					  table[i].frequency);
> +		if (table[i].cost >= prev_cost) {
> +			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> +				table[i].frequency);
> +		} else {
> +			prev_cost = table[i].cost;
> +		}

nit: curly braces aren't needed, especially if you change the 'dev_dbg'
statement to be a single line.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
