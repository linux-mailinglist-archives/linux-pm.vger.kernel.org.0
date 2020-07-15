Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E0220914
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgGOJqY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGOJqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 05:46:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B79C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:46:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so2716160pjc.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ta5eB8n1j7394YSOV3FTjLEgFK5+gJYa0yXjRVjvKzc=;
        b=qHmM76d85REKWg3SKZsETSfnmNFLAxVm2cJUMkbujT3RGqc9CoIY7YAy4DEbR7KaAV
         mgn87zNqG9v1a2P3E0AhydpJDfL2kP8NdJdbSBrp2YmG7Faaf//U+YOnr7UNQkADonYg
         TUnR3UClJ3xp17gA9ZKv6vkdjf29YVQMSy9urGPhbnziIzd++0MJOjIdxhsqL4NHhpFI
         vOHrQoQgLArlWSNibZ6zrfoBqd4rMc+UW37NokY9Mf4ZkR4h3Cl1A4LWEwORZzU7mPBC
         dydy2vhcbETegjiRbuVyCl/DHUzqbMp7r94482uwcfX3rIBbHslqqI1doNi0199xaVlr
         gjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ta5eB8n1j7394YSOV3FTjLEgFK5+gJYa0yXjRVjvKzc=;
        b=JcqyuokInVV++A010cjEoorZCA8D+2MBq/EPy1S4ZD7P4wprhYdsL08JvC2t/0LeBG
         OkxsxkbDbJrdHh+E0NJZfVDQV3X5wb0tTfBp2ybCOOquS4orihuoNGgI31LM6nGDXKiC
         westXLw9bmqhlJ/SbygWhwsmSZmGW2iH4Uw1QGXbLdn005/kiK1n9IvRVltu7jco8gKE
         7WtAlsYCDgR9ZspR0Y/w5nNw5kf66/qc5Y1/O86mQQRgJUvL2uqsqPdCX0VNGk+2Cbox
         Un9YU4F0FTcjFFM8r5oM3wPhukBxOjubhjKkXQb7+oGMHSQ4Y/V1OEbfFj6abH4p+gW/
         rh8w==
X-Gm-Message-State: AOAM5338KhTaLrmzgGLAmUGivP+CPlfOf9biONE1We+46BwYBwdNpIzi
        oZjsKQFVc7Ub7xE2XhQIfQ5r8Q==
X-Google-Smtp-Source: ABdhPJz0ztYWypN5Sqepyw/Es6Ia33xwOYh3KQcd7uKjiWwIyveN/f7pPS+8Qp3He5haCyq1lfe8Kw==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr9099735pjb.156.1594806383451;
        Wed, 15 Jul 2020 02:46:23 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id c71sm1808745pje.32.2020.07.15.02.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:46:22 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:16:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Pal Singh <ajitpal.singh@st.com>
Subject: Re: [PATCH v2 04/13] cpufreq: sti-cpufreq: Fix some formatting and
 misspelling issues
Message-ID: <20200715094620.jxh3wwhvchpuhj5o@vireshk-i7>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
 <20200715082634.3024816-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715082634.3024816-5-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 09:26, Lee Jones wrote:
> Kerneldoc format for attribute descriptions should be '@.*: '.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/sti-cpufreq.c:49: warning: cannot understand function prototype: 'struct sti_cpufreq_ddata '
> 
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Pal Singh <ajitpal.singh@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 8f16bbb164b84..a5ad96d29adca 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -40,11 +40,11 @@ enum {
>  };
>  
>  /**
> - * ST CPUFreq Driver Data
> + * struct sti_cpufreq_ddata - ST CPUFreq Driver Data
>   *
> - * @cpu_node		CPU's OF node
> - * @syscfg_eng		Engineering Syscon register map
> - * @regmap		Syscon register map
> + * @cpu:		CPU's OF node
> + * @syscfg_eng:		Engineering Syscon register map
> + * @syscfg:		Syscon register map
>   */
>  static struct sti_cpufreq_ddata {
>  	struct device *cpu;

I already applied the one from V1 earlier this morning.

-- 
viresh
