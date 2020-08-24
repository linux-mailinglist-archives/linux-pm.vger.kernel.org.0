Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7C24FC82
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHXL1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHXL1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 07:27:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E7C061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 04:27:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so4044563pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=baquQjNt6PFNzFAsQ0kh01MX49ZmJ/9Yg6dF7IDX3SI=;
        b=XDcppkVsrS82tADPSlchfl+fIh7vjbha2AfE+pdlL+dJ4n9F9wb1id39Ttudz+OTBs
         cFU9iqWtUav7j6WClzSX/OhkCoe1H1Y+cYGgH6+22Q/bqMxYaNG5gRYq8fYPrCjBefGA
         e6GF5Wz440cGa9dudTTei2vce+57RSDFLiPk1KFZnF7Au0jzS9njjNGoVc0P0j7JcrGH
         OdZr7uFAbOavvmBxm7gywnOXW29xYh/jqHEdNnawVNDoo2dlqw8WgG1sEDDhzfkFqKye
         k420NbCI+aCLYLnAv9aFcQhYfS3JRz7+TZ0K9FO6EZoQfMsl2v2VNV2uoyWikZR9FOJ5
         5nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=baquQjNt6PFNzFAsQ0kh01MX49ZmJ/9Yg6dF7IDX3SI=;
        b=RthfGDf8riwWDZyp7n8ypptSiMdCVYtKzdSmHyJ4OmgcZTIs0vaN01lmC/20ExIVEx
         e7gRFE6VLMdmeU4fWq9VZvzE3KLAEIxwuTqAHf6lvNyYLEmgxLwsYxvqZ/rxIwTVV7sa
         iTU/F7lg0hrILsSQqzxeJL00Whc2nsa+ACUPLPln+58CofLaI75qUT2ApIElut5feRkz
         QPVI+Y6jlSwD/ecSXjMrQrRDGmMOuoB7jQvbviR4BMymHz4N3UsgnMhs8PT5HR0KZ6RP
         yzJJpsF6qHoEFf8ae8ohS4m6+zQYdabUKaBMbAXNuFw4VFTujwC1UC/lhTiX5LamBicY
         /JRw==
X-Gm-Message-State: AOAM530x8g6DfItOCcioPP/TWlXHU8KaQbobkZ98wTUdJaSbHVTQ9m+c
        kXvf8DI3L1KunHGNKb++K3Udww==
X-Google-Smtp-Source: ABdhPJxwW1lXpSca83U1QtZjsMBccasNeRma6uXMIzqn9tVduIk2Swl1So0zZQR6DP5Sviepgt2TFA==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id x12mr4384709pja.186.1598268466779;
        Mon, 24 Aug 2020 04:27:46 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id k20sm5925428pfu.197.2020.08.24.04.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 04:27:46 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:57:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by
 the OPP core
Message-ID: <20200824112744.jsyaxrfbybyjpwex@vireshk-i7>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-4-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730080146.25185-4-stephan@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-20, 10:01, Stephan Gerhold wrote:
> dev_pm_opp_attach_genpd() allows attaching an arbitrary number of
> power domains to an OPP table. In that case, the genpd core will
> create a virtual device for each of the power domains.
> 
> At the moment, the OPP core only calls
> dev_pm_genpd_set_performance_state() on these virtual devices.
> It does not attempt to power on the power domains. Therefore
> the required power domain might never get turned on.
> 
> So far, dev_pm_opp_attach_genpd() is only used in qcom-cpufreq-nvmem.c
> to attach the CPR power domain to the CPU OPP table. The CPR driver
> does not check if it was actually powered on so this did not cause
> any problems. However, other drivers (e.g. rpmpd) might ignore the
> performance state until the power domain is actually powered on.
> 
> Since these virtual devices are managed exclusively by the OPP core,
> I would say that it should also be responsible to ensure they are
> enabled. A similar approach is already used for regulators, see
> commit 8d45719caaf5 ("opp: core: add regulators enable and disable").
> 
> This commit implements similar functionality for the virtual genpd
> devices managed by the OPP core. The power domains are turned on
> the first time dev_pm_opp_set_rate() is called. They are turned off
> again when dev_pm_opp_set_rate(dev, 0) is called.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Related discussion: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/
> 
> There would be also other ways to implement this, e.g. device links,
> assuming that the device using the OPP table also makes use of runtime PM.
> My first thought was that it would be most consistent to handle this like
> regulators, bandwidth votes etc. RFC :)

This stuff was done ages back and I am starting to forget almost
everything now :)

Ulf, why doesn't pm_runtime_get(dev) take care of enabling multiple
power domain case ? RFP (request for patience) :)

-- 
viresh
