Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20CB263B87
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 05:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIJDnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 23:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgIJDnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 23:43:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9563C061756
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 20:43:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r24so242716pls.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmS2T2jFD4Mhxd1SucoAel5AcWUGDJSMEH/6aOpQ3E4=;
        b=xQK7MlcvpwgA7zVon4fYwgsjjBXLD1QDVQO0Y/wxK4TpVqAOuOsyHTfnz61IDHZ2n5
         TGXB9Ozsm5y9yYIWBSZihicx99cw8Tqy45Kzki86JArCPtrddKx8cx77jJLwOpYMGaGK
         M7L2/yKx7qk6TgLvU71F2gSNpHGQNerD4WBLdX/GKAstcJMfIlHlelhbu9G4XmmlB47K
         vvZ5OFuqcsxwTb0J/ulV+DTtR8GWtu+++Va24XqlOa+K3nMYat+XJPH7FLd09HLwP1TH
         083BY7CAp5HdCGyDtmJmOb0fZYTgNC3uZZhOlqvGsm/C6UlMfNwTL7XcG7+LYgwmCgj3
         O5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmS2T2jFD4Mhxd1SucoAel5AcWUGDJSMEH/6aOpQ3E4=;
        b=gT1ilLnVFglUKUeVv3B9/erfxOp+CufWjuNweiTsso7lg2jjIc6J3E83edh7gmZtps
         V3TCbRbgcOWZ1wFPnXMMGEiVgQzPB8Lslz70jH+PzBN/nzyWM0Nxpa3ve4fOGj7AyzNP
         YNux8EGdkdBFqq3fRhL7KtTN992b93sjp4YVnTo9QYwIOdW72IK91vZhA6v1YHs6Z5k/
         Kpf7qAQPYffXSeYc7M4U5FcamEYbGquUEnM9dp6Frdv3V3gs0gymRbLYiPI/Q3eT1ZAy
         UDJWBk2BG8ApP+kE0FCz/i3scGdvdxNoYNX/KvnAAtyEWJvOPJ34wZ8unaiXJHOzYyX3
         /v/w==
X-Gm-Message-State: AOAM533ZoalR8MIAgMmyXA/omFGf+91Fe6yapMcjgmePEOW0JAz6iP9Z
        ZKH7aJzZRxLfHfBkyUOfdA9oZA==
X-Google-Smtp-Source: ABdhPJxRgu58IL1rniuVlRLSIpomG8nzd42RuHvTf3NVD6MC0hy7wZ/evpSgjCdMunvXwKBg/3c4Tg==
X-Received: by 2002:a17:902:10f:: with SMTP id 15mr3733723plb.121.1599709379966;
        Wed, 09 Sep 2020 20:42:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z129sm3423532pgb.84.2020.09.09.20.42.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 20:42:58 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:12:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v6 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200910034245.eqya625p7la33dkc@vireshk-i7>
References: <1599658476-16562-1-git-send-email-hector.yuan@mediatek.com>
 <1599658476-16562-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599658476-16562-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-09-20, 21:34, Hector Yuan wrote:
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct cpufreq_mtk *c;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;

Why didn't you drop policy as we discussed in previous version ?

> +	c = mtk_freq_domain_map[cpu];
> +
> +	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;

policy->freq_table and c->table are same, isn't it ?

> +}
> +
> +static struct platform_driver mtk_cpufreq_hw_driver = {
> +	.probe = mtk_cpufreq_hw_driver_probe,
> +	.remove = mtk_cpufreq_hw_driver_remove,
> +	.driver = {
> +		.name = "mtk-cpufreq-hw",
> +		.of_match_table = mtk_cpufreq_hw_match,
> +	},
> +};
> +

Remove this blank line.

> +module_platform_driver(mtk_cpufreq_hw_driver);
> +
> +MODULE_DESCRIPTION("mtk CPUFREQ HW Driver");

Maybe write this is "Mediatek cpufreq-hw driver" ?

> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh
