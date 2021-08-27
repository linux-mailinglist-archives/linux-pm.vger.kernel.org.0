Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F63F929E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 05:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbhH0DGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 23:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhH0DGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 23:06:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BAC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 20:06:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so3575316pjv.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3i7idO8QqKhjt0ThMO0ce5R45fYSfUmsl0FexLZ5s0=;
        b=bTEyYRvY1cWcwoZEZ2moTg1MjvMRYK8rR2S5dUEOaEfvquXEgZBwJP6Pk1JE+xxszK
         Gh2K0JCV4U6S6UY6uJjQunU41ghVesKm1+1TyAmkjVlwsbOIqY7QRq5SpcdAeERa95zm
         65SJep8SkvCVT7UaMaZ3Pke9nQreBI6ybUrcnCamJXe5wiLQdQm6xfk5ofI5favfLZTl
         9yTQbn509s3wcC6a42QCUHj2d1cU0FxlgQFFOqMcbgBHIWwK3abPu7ZPNSGt+lEv2dFW
         hUrQ2RHm+beAGZ4f4+rJZ3XxBqgJgfgKwNR+ZmfiXcNvKOxNgpgj3X5CbYCr/9c8LF4A
         9hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3i7idO8QqKhjt0ThMO0ce5R45fYSfUmsl0FexLZ5s0=;
        b=YgJbLnybzBoBjl6AMQYB30llztqXgByTPoNHKvRUZA5vYEWJhv5+LA+MkTzvlrKtCk
         i1QyLh/I2MvOu0EsQZqfCiGSs84J+VicLBn/Ufyt82O0uWukjPqtB7roJsj50ot+XkNV
         1V0igH8CtqkTyUXCIgqd0Dn+gnuFaigvIhksOP0yLzmazDbh9q8OkLbWv+K3GClWYFbE
         4tTGFFyV9zYRjSjXBOkPvMJDXdn0Rq7WFUA2ScnM93OhsE4O3SphnfI/agneCZT10wdn
         kGiaa50RzMAeL7COt+szI0UX8aL05WEM3/gvt18sB1kehxI7ZS0bkpvHyhv3vV7+DiSY
         tUrw==
X-Gm-Message-State: AOAM531P+uJG/J076SeI0jZx0G5t+KrmIonMpmo5ieEb8exSD/AtEVXa
        T+MRtlnxmP7wN+GxCxK2eZQM7w==
X-Google-Smtp-Source: ABdhPJwi/AXRYp0dh7EOBaZcQmdGOm65HoIu+HLQTJxX6eLLRbofgCP5WSIT9+znxWkDp2OZLm3HfA==
X-Received: by 2002:a17:90a:6a01:: with SMTP id t1mr8009301pjj.31.1630033562037;
        Thu, 26 Aug 2021 20:06:02 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z12sm4262715pfe.79.2021.08.26.20.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:06:01 -0700 (PDT)
Date:   Fri, 27 Aug 2021 08:35:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state()
 callback
Message-ID: <20210827030557.aymjkky7athjxpow@vireshk-i7>
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827013415.24027-6-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-21, 04:34, Dmitry Osipenko wrote:
> +	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
> +	if (IS_ERR(clk_opp_table)) {
> +		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
> +		ret = PTR_ERR(clk_opp_table);
> +		goto put_hw;
> +	}

Why do you need to do it ? OPP core already does this automatically.

-- 
viresh
