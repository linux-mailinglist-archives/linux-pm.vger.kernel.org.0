Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE924F79B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgHXJRl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 05:17:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36345 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgHXJRa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 05:17:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id x7so1838496wro.3;
        Mon, 24 Aug 2020 02:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piFoeKFrUJtBI57BDIALP5epFRujdzh3bH9V8VDZYAo=;
        b=GZFVbseRjfzRmeYXFX0EmDZgoFijYc9/oWlgTjr1qb3y1gWhSj062+vqjo0XQHsKvZ
         rT/uE7jzYeGTiQId2VtFzRakfIp+s5E3/q2ofYEFSwR8vz9i30nPz+jPbnQCKJ/Fszzg
         hTUxIan7Idq2mQighRB7F3qdaWkfu07luZJAv4fREbQUwMb/lQlGSLN26Um5/yupQd/P
         RloQRNiw8OxcfDDtBfHIeB0uo4rHYpAuX5lad1X6l9GVySCF/vnuqO8iBo3pitodgRKa
         fFM+9S+gHfzADpUPBk6OERZdjVeSKXwMScrXFUrOAPvd22AOPvDWBE/JlNX8lEQB6ly9
         0AYQ==
X-Gm-Message-State: AOAM530au0AWrCR9k4K55GfIL0C6KB7BVdsybT+PxWfY8FTVN3YFPA2B
        JMz424n7lhB5AQkxmmSJrXU=
X-Google-Smtp-Source: ABdhPJzySf+UXQLxcG9X2DZIMX9284mRLw4G7ickfby9Bst4b2X7s+cUhUsK3Zq0OPsQTu9d2qfDhQ==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr4847868wrx.389.1598260647712;
        Mon, 24 Aug 2020 02:17:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id u7sm22138521wrq.89.2020.08.24.02.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 02:17:27 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:17:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20200824091724.GB20819@kozik-lap>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 02:39:32PM +0530, Viresh Kumar wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
> 
> The OPP core manages various resources, e.g. clocks or interconnect paths.
> These resources are looked up when the OPP table is allocated once
> dev_pm_opp_get_opp_table() is called the first time (either directly
> or indirectly through one of the many helper functions).
> 
> At this point, the resources may not be available yet, i.e. looking them
> up will result in -EPROBE_DEFER. Unfortunately, dev_pm_opp_get_opp_table()
> is currently unable to propagate this error code since it only returns
> the allocated OPP table or NULL.
> 
> This means that all consumers of the OPP core are required to make sure
> that all necessary resources are available. Usually this happens by
> requesting them, checking the result and releasing them immediately after.
> 
> For example, we have added "dev_pm_opp_of_find_icc_paths(dev, NULL)" to
> several drivers now just to make sure the interconnect providers are
> ready before the OPP table is allocated. If this call is missing,
> the OPP core will only warn about this and then attempt to continue
> without interconnect. This will eventually fail horribly, e.g.:
> 
>     cpu cpu0: _allocate_opp_table: Error finding interconnect paths: -517
>     ... later ...
>     of: _read_bw: Mismatch between opp-peak-kBps and paths (1 0)
>     cpu cpu0: _opp_add_static_v2: opp key field not found
>     cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
> 
> This example happens when trying to use interconnects for a CPU OPP
> table together with qcom-cpufreq-nvmem.c. qcom-cpufreq-nvmem calls
> dev_pm_opp_set_supported_hw(), which ends up allocating the OPP table
> early. To fix the problem with the current approach we would need to add
> yet another call to dev_pm_opp_of_find_icc_paths(dev, NULL).
> But actually qcom-cpufreq-nvmem.c has nothing to do with interconnects...
> 
> This commit attempts to make this more robust by allowing
> dev_pm_opp_get_opp_table() to return an error pointer. Fixing all
> the usages is trivial because the function is usually used indirectly
> through another helper (e.g. dev_pm_opp_set_supported_hw() above).
> These other helpers already return an error pointer.
> 
> The example above then works correctly because set_supported_hw() will
> return -EPROBE_DEFER, and qcom-cpufreq-nvmem.c already propagates that
> error. It should also be possible to remove the remaining usages of
> "dev_pm_opp_of_find_icc_paths(dev, NULL)" from other drivers as well.
> 
> Note that this commit currently only handles -EPROBE_DEFER for the
> clock/interconnects within _allocate_opp_table(). Other errors are just
> ignored as before. Eventually those should be propagated as well.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [ Viresh: skip checking return value of dev_pm_opp_get_opp_table() for
> 	  EPROBE_DEFER in domain.c, fix NULL return value and reorder
> 	  code a bit in core.c, and update exynos-asv.c ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Stephan, I have made some changes to the code. Please try it again and
> lemme know if it works fine.
> 
>  drivers/base/power/domain.c      | 14 +++++----
>  drivers/opp/core.c               | 53 +++++++++++++++++++-------------
>  drivers/opp/of.c                 |  8 ++---
>  drivers/soc/samsung/exynos-asv.c |  2 +-
>  4 files changed, 44 insertions(+), 33 deletions(-)

For Samsung:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
