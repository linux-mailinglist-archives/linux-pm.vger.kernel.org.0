Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F12049BF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 08:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgFWGUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 02:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgFWGUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 02:20:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D77AC061573
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 23:20:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d66so9605652pfd.6
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xkEZLfW1ArYgf+mEiL+b5tURW9CFpN3REEce4uqJNH0=;
        b=mDh1Fl94b3/LSZ+hMlztNtRD33tkWnaxz8jVAg3XWYW8wZ8vRi1lGAMFXvmC+ld9oq
         yoj1BYpiF4qp/PUndN/UrCjFRgoxGIVbP7WdIa/Og1WXc5/3wG9C91iC1qcV50TlhZ6m
         XBllvcUyb3wDmPZK3Etsz833H3UWSiNLXTZlbHuC0a/stsEgjxQDg6gu5q309hEyTJNc
         VA6U6mtmGjjwP7IWZrxUg9ih8rRJMMh8IC5Jqvi9wNZq8UAohIxZndVvX0mI5xnYvPxJ
         EmHNG66dntMreD3T8r2oyjt9i/uD//9Mo0vhNQEblG0eGl2WJqHcpUUNoZqCbP92pq5k
         B5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xkEZLfW1ArYgf+mEiL+b5tURW9CFpN3REEce4uqJNH0=;
        b=jg+LkHcAY318VSnN/arpjkSwg58HsNeex69Gna4TK1ITIqOJrH2R5rxsNk+GO+Oi1K
         wGxqmVRyYbvqWVvT8emy5C7TBT7uAB8wHGb8qT/1LmVzJ7v8tjXB+obQ3f44R6RG3AGF
         YAz86QhuEW9yBHBdpeNbK6C7tydvQucEG1EeKNvnL5M+yz+PAaXuP1OXTDaJRuT2wTJX
         ENvKQwnq5M2XCLTOJTeqzOEmwKjhvvqotfO9q/KD+Axkc/iqB/raTR+vV55bhw0xxOqq
         GQWrmlf4u+jWRKQcaYjxwvOuv0TLqhAhhAhNDpPvcMpGRtKDaEYXJoJzcPdjpGrjvJOz
         2o+Q==
X-Gm-Message-State: AOAM532SCtM7BYL2gl+/FSADxR7Qzc75fKAaK87t+3cAumM1mxNnkCiF
        HriZ9uy063OU6teBW77q5wAwgcIAz5k=
X-Google-Smtp-Source: ABdhPJzPhO4piZUlhyX41kRvKT0EgrKEBSKMGlr2VTKP7RKfZOV4lMU0w2m7uDvwx/uYcjh4UjbI6g==
X-Received: by 2002:a63:3f42:: with SMTP id m63mr16314448pga.310.1592893223436;
        Mon, 22 Jun 2020 23:20:23 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id np5sm1408030pjb.43.2020.06.22.23.20.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:20:22 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:50:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch v3 3/4] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200623062020.weg6h4uygelkih7d@vireshk-i7>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
 <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
 <20200622072052.uryxo4hri6gzrkku@vireshk-i7>
 <ed6956a3-3f77-2943-6387-5affc25b59d2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6956a3-3f77-2943-6387-5affc25b59d2@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-20, 10:49, Sumit Gupta wrote:
> Hi Viresh,
> 
> Thank you for the review. please find my reply inline.
> 
> 
> > > +++ b/drivers/cpufreq/tegra194-cpufreq.c
> > > @@ -0,0 +1,403 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved
> > 
> >                      2020

You missed this ?

> T194 supports four CPU clusters, each with two cores. Each CPU cluster is
> capable of running at a specific frequency sourced by respective NAFLL to
> provide cluster specific clocks. Individual cores within a cluster write
> freq in per core register. Cluster h/w forwards the max(core0, core1)
> request to per cluster NAFLL.

Okay, this is clear now. Add a comment about this max thing in the
target routine to show why you need to do this on all CPUs.

-- 
viresh
