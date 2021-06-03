Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A697399802
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 04:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhFCC04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 22:26:56 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:37793 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCC04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 22:26:56 -0400
Received: by mail-pl1-f177.google.com with SMTP id u7so2107963plq.4
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fme9lwaPd+erkgXoIvHB43i1V/M18jnZzcTan+3LUa4=;
        b=Xn4+QbVWUhFIxX+RZIr6cAQsf6LaS6it+SNJI0TCHr+/DjgW3jIk7QnCiOep5OqslH
         gQx2tSCtDHSiEL7rDWypqdw3Hxi+fYnFUo4T4MZ5W0+LlJwfktlbFlhMXfxJNa8Te+Vt
         lNgNvQ/qK7G7m6enjMEceQn6g32Q5eNhMLM24BkM1aAryDdLwn7e9bslL6fgMEGkkGzN
         6/7NuQT8SNWs1fUk75O5ataPY7GbZ+Fjt79Zd7U2ngXPR1ccQ0LojmfLZyaInCGGZgSz
         qZNC9W2M1RI1Rm5Vq6XswcZKljnAsjALYN3PNQefhBpqtGJSRYM+8rQOwOa6mvfMO0ou
         nQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fme9lwaPd+erkgXoIvHB43i1V/M18jnZzcTan+3LUa4=;
        b=mlVt1qJXgBTkWzblhbvgieFPYbTQsQFHtuyFTXUD+rrzilt1KLFM2L7hmi5o3B5lfa
         T24Rkbkzh0+Sc54iGx9rFkoygvS8t47vY20PbuTU1ztlKeThPkYzDrBuSTbHU65HzyKv
         Fh/dQ2UsscmyEKPajPp2oxRC4blOYu+OOaOCSQUpDpXlmD2rYNJKapvvOOyGr5guleeW
         sVGKIKmUXTiwx2l/F1p0BD2LXN2M6CGwt50Q2VIbXsJG6PGEf1lksMjxfgUaxKll8FMZ
         gJqvXzQg7LLbXZWVYWx7/SPv8Up7lN4sKOm4qM832o8CWPbSBYwNgMvSreWV6Z4qzu5l
         jSFw==
X-Gm-Message-State: AOAM533l21lq/ezYsclKDduE/u8PI3Z2GOrphnwZzJWCV1SrXSVG8VOd
        csHS4Yb9SuBBqQderDdgSEkfYw==
X-Google-Smtp-Source: ABdhPJwr11DIVHIertb7BWXiBE2m9ehQglYnvNEdgIJ18aVT5rpAverffYZKh47liDDpBYwRRa/PtQ==
X-Received: by 2002:a17:90b:354:: with SMTP id fh20mr16448957pjb.67.1622687043173;
        Wed, 02 Jun 2021 19:24:03 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id v18sm746852pff.90.2021.06.02.19.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 19:24:02 -0700 (PDT)
Date:   Thu, 3 Jun 2021 07:54:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: domains: Split code in
 dev_pm_genpd_set_performance_state()
Message-ID: <20210603022400.idphwyporxezzrvs@vireshk-i7>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
 <20210602101215.78094-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602101215.78094-2-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-06-21, 12:12, Ulf Hansson wrote:
> To prepare some of the code in dev_pm_genpd_set_performance_state() to be
> re-used from subsequent changes, let's split it up into two functions.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
