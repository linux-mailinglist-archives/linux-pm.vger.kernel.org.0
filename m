Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3D2F432E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 05:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhAMEc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 23:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhAMEc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 23:32:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3792C061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 20:31:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m5so364234pjv.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 20:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Be3aF7gmnbdczr08jTEc4qtrLE0DnSFP2kFU+SRBd8=;
        b=ubXI8E2Ds2qLPunhYDLxCHZJISXH+WHIsGWsngoPSJyq62RJ1w54sKvLHguwp3+47r
         oGH5jOyr6CMycje8lOLjlG0STf98npqWEp5712O6Ey+o77HjQxKqlNu+DxgylfkVnXTg
         mZjm2bOY+S1y33z90ufKO5w8+MGXYQVrPM3HiQxy4VfUV7DAx5uUq0C6WkBQ2+OSvWZ1
         aW4ISTvLNzUIiNUy2vsS7gv6/Gx/cJJpAI9cTajM7xkCwjQop1XSoa3iZazlzK9tvggc
         c8UFPAaBGTjLWc5GB/iQSPkMo6fMTQZiT/wyARh88J5Hj88OTxa912OR78Mmmz0NlJ9O
         lrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Be3aF7gmnbdczr08jTEc4qtrLE0DnSFP2kFU+SRBd8=;
        b=GuR31kSFhFK7SprnnnqtGty0RszERtOrtOEl3J2cZ7chyXMWLOeBmiQp9uo6eD3V5t
         J6Lh6sdiNzCwz5HG4BCdlpmuNpxcjDVgpmA5bt8/3S2us0DYyhv8cgZKN+MRyJhlNkY6
         xnIpGyzxhzdIGUuyWcnrU1vEQdbBnbff4LsA5ubawJ15wBlO1KnDBgrfvOMkDVWYtZSW
         /cZbpyh03V3ub/Ud2FH+SG6zEDpFFkp1plLlrU4jqvbV4ezS9CxpBnPrJJRnA/uWAZLM
         4j0OeTGVB5545UP+GJ03KWu5q3nT+L8OeNYqpfOmUopo/xtRek+sG5d/lkSCg4x7Kskc
         sT/w==
X-Gm-Message-State: AOAM532R9bQ+tsx4ULDeX32zbss5W1kZSeukP9xSZhe6CGtn+OxW1F7Z
        iDvPRZuIrogF+l2q3XGph+1VeA==
X-Google-Smtp-Source: ABdhPJyN8yeqQGueEd90usI4ITMZlRFcf09U5midtckT2qIOs8rC7ME1AIX3188ZbHX+bfqR3urBfQ==
X-Received: by 2002:a17:902:6b02:b029:da:c6c0:d650 with SMTP id o2-20020a1709026b02b02900dac6c0d650mr244313plk.74.1610512307215;
        Tue, 12 Jan 2021 20:31:47 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id s23sm642239pgj.29.2021.01.12.20.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 20:31:46 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:01:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210113043143.y45mmnw3e2kjkxnl@vireshk-i7>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <X/210llTiuNt3haG@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/210llTiuNt3haG@builder.lan>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-01-21, 08:44, Bjorn Andersson wrote:
> Intuitively I feel that resources allocated in cpufreq_driver->init()
> should be explicitly freed in cpufreq_driver->exit() and should thereby
> not use devm to track the allocations.

I agree.

> But afaict when qcom_cpufreq_hw_driver_remove() calls
> cpufreq_unregister_driver() to end up in cpufreq_remove_dev() it will
> only call cpufreq_driver->exit() iff cpufreq_driver->offline() is
> implemented - which it isn't in our case.

cpufreq_offline() calls exit() in your case. So no memory leak here.

> So without using devm to track
> this we would leak the memory - which also implies that we're leaking
> the "freq_table" when this happens.
> 
> But isn't that simply a typo in cpufreq_remove_dev()? And can't we just
> use ioremap()/iounmap() here instead?

-- 
viresh
