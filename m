Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0433324AE7E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 07:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHTFjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 01:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHTFjt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 01:39:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F65FC061383
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 22:39:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so483806pfa.12
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THYhk6JOC4TXpYcTdTNB05bB3kc64g/hoRGOJ2KPS5g=;
        b=vUNZOjjum+PBtEM3XlGi73tWZ5COii2DJIxmx3PWecAaYP9ZkvQUA7habblAnQnr6d
         alqrkUOAhgfUDXVG7WOOUGxceCadhsQh/LBW98JK8KmX/2c1Kn/PUn7HN4V2K6cx6p3U
         GsKt+ALuaCIaI6S2b8rxVKkNQrxFMMbHXW2e22cCB0gpgwnewwThTAttwYA8fGBN7CdO
         Fn1oNlNG1TB0kVnpI0/8Ei7m3hcwPoWdPiyd3cAwl2G1Sarxl5ZcSBxtB+1kvyO7TVrw
         SYyTOaFPJbATGo+HmKy+0kwEAYwvH3C58ILx1n9AmgRcUtE4veIvTM11S2CUZ3ZIeVBm
         WnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THYhk6JOC4TXpYcTdTNB05bB3kc64g/hoRGOJ2KPS5g=;
        b=oN4lpJpTetzrKIukBz7arq/Rh1xCwmQek86luSXhZ1g6v0CPsrZc6fRP5R9Ulr/5SS
         4bdzL9lNajFodKccGtjOmAJOe3hylkVUsdFA18CU3w8MDGQbu7p1lq81EHCaqsFoYjJe
         0yIyKxw9fTu4fOrF1dsEKbaNpa1hXEC+XZVP7eaR6kU7DgSmbJE/5KV7r7QxycFPbMN3
         4F94glq3SCSWpNNT5XA4KQX/Ltrc435PG4HgiFlBTFH+9VROvtB1ipahkxi65ae3CREc
         0eBCQWAvnFmNhbU+o2dVcLWu9X92KLDZ7eruFJPzG/M3Ba+grYKuQ1hODdZX2bAko8YS
         R38w==
X-Gm-Message-State: AOAM533Omlkq0h5mninyYg87xGnGckeoqobt3/0yTFg7O4N/9bHsSSDb
        011GOwoITLKk/0gg0pCMOQ27AQ==
X-Google-Smtp-Source: ABdhPJyiv6R/08txV3btGY8Wex4DoNWiQ9V8i7TVrXG6grrAcw0P8NDqDoa/L6UCGKZqA6mKxIB7VA==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr1028280pfk.219.1597901988631;
        Wed, 19 Aug 2020 22:39:48 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id u21sm802708pjn.27.2020.08.19.22.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 22:39:47 -0700 (PDT)
Date:   Thu, 20 Aug 2020 11:09:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net, catalin.marinas@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, wangkefeng.wang@huawei.com
Subject: Re: [Patch] cpufreq: replace cpu_logical_map with read_cpuid_mpir
Message-ID: <20200820053945.xlwtpkvbt4o23flk@vireshk-i7>
References: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-08-20, 01:13, Sumit Gupta wrote:
> Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> fixes the issue with building tegra194 cpufreq driver as module. But
> the fix might cause problem while supporting physical cpu hotplug[1].
> 
> This patch fixes the original problem by avoiding use of cpu_logical_map().
> Instead calling read_cpuid_mpidr() to get MPIDR on target cpu.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200724131059.GB6521@bogus/
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh
