Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4617A2B58D8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 05:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKQEfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 23:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKQEfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 23:35:36 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36424C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:35:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so12713141pfg.12
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6VDC0+2ajqJZVVyTOuaiA3prDyAPpvrZ/Ex8CAmll80=;
        b=vJwj1jcaMRQbmdLuNT6TJNpqmWCbZAeWAs3M1QOwIbKReJVSnrxiDCyvqMHyCoPt8M
         kxso3ma/YSijf1jriqX1MeKBKGZWYdxGa/HDfPRVH6dUta5V9vx6GWazp1t2XPr7xaXU
         oHdivBo6SVutEMK+ZQ7uaNgt5anRSeJZ6omj9iOCnrQ1y/R1ebURyp/XRxICmnSEcprh
         znL/Z2QkHBC1yMb3KokmuFHB3Sqxonh0iMIc9euzdn+NUbXI2089NOOzPCHqJL4GXaO3
         OD97qThXNJPeb6lI+UwTmExxb3GCWNqfv6g09Oe9z9l18xQgFGD74Cx5VkP6FJx+z7l2
         ZS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6VDC0+2ajqJZVVyTOuaiA3prDyAPpvrZ/Ex8CAmll80=;
        b=A9Rp+PQIcZxpqkMETO2AqRUN1KCOL+tpk4AJ/Rix0LriqrEVW+tYdhGSkdM5pOOdko
         FLJ1e/+qddow1AGE4fodWia5TrXknE+lS/XQsNEOkc3q5XwEHsAmTbgG7AToyWwjd2rq
         JwJec5GuIoTOPKJuIdySddWiv4SzNj/wKRvjQNcd/hFSCfShC1GoeqCyOiqrmBzET90t
         osNJvSBb0PcMmaxl5kwZR8yvH+46JZQMTZcq5oh/L+lMTzTEWmt1+2n2tiXoLCI5bLq8
         3M5WDBVJyVpA8p6y2z4/9eCfjWLRbEZEfVP1MrJLZJl+Iek9yAuKXqrE+N3hrBu08gFI
         zJMA==
X-Gm-Message-State: AOAM533AxuRYj56IEZ5gbSP9iZ2n5jaz1O3AvB9vP8fAg+efQWxQ904X
        EsxSVHjNRE/VsXd332Q095j3CaPBgId9kw==
X-Google-Smtp-Source: ABdhPJxFpUL12UsZaYOG/4N7/jGZqBwmVUrHTcPYrcRYOexabKdwuR9HtZvUWR/P/ovBzyVmyDgJhg==
X-Received: by 2002:a17:90a:ca91:: with SMTP id y17mr2403338pjt.205.1605587735789;
        Mon, 16 Nov 2020 20:35:35 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id c28sm21238459pfj.108.2020.11.16.20.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 20:35:34 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:05:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scmi: Fix OPP addition failure with a dummy
 clock provider
Message-ID: <20201117043532.xo2ks6zy73dujnbq@vireshk-i7>
References: <20201110111040.280231-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110111040.280231-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-20, 11:10, Sudeep Holla wrote:
> Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> _allocate_opp_table() which is called from dev_pm_opp_add and it
> now propagates the error back to the caller.
> 
> SCMI performance domain re-used clock bindings to keep it simple. However
> with the above mentioned change, if clock property is present in a device
> node, opps fails to get added with below errors until clk_get succeeds.
> 
>  cpu0: failed to add opp 450000000Hz
>  cpu0: failed to add opps to the device
>  ....(errors on cpu1-cpu4)
>  cpu5: failed to add opp 450000000Hz
>  cpu5: failed to add opps to the device
> 
> So, in order to fix the issue, we need to register dummy clock provider.
> With the dummy clock provider, clk_get returns NULL(no errors!), then opp
> core proceeds to add OPPs for the CPUs.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied. Thanks.

-- 
viresh
