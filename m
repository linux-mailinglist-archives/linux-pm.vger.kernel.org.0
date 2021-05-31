Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFFC3955EA
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhEaHVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhEaHVG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 03:21:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8319DC061760
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 00:19:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e15so4778727plh.1
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3a3VFSA9uj+gWqV4L+HxxSOR81E7UjlXtV5LDn4/cOo=;
        b=TlpEIurdbTkUKm2IeEJapCh0stmPxEFv0QJFI9qW7jWaE4vnHSQc+an4iFj1QIsfez
         tQHTHyd7r59puyl4WFT6C8i8E80M4IJeEcPndPOB8wwxBNgUz389AjBTSAaFyzJJyILL
         6g78Sfir5adselxu68FlocTfSpg1doX1vB2gqTbi7eZzcm8jGcQGw2N4FLMBBNPH39aL
         TBv7Meq/rJWJ7g99gzOdptiMZU202Ferqt/Efur61vqkTutGVkBOOLuziokqDTcjZJiN
         xPKJXRQNqwk+9udgVSWZif9zOEbmYwVoFBalaCBELsBwBZQeMmTQ+wlP3JOtZB043Svf
         cV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3a3VFSA9uj+gWqV4L+HxxSOR81E7UjlXtV5LDn4/cOo=;
        b=dFyHzkYSqXeb8vGw4eUzPmIVhAlQtyQKV7V3rl/4J2BdnU7niMUawZBBDeqZFemR0+
         j60PysHXbekkNSuUieqVOSEAJd7DoDNQKSkXu70JuTGqEP4YCEvLDAKJNpnSgBxgwx85
         zkx/wR8J6jfZOFw208wYOxOSjGyCQPhNcNKZMGzGD/kpNuKVjWwwaGOSBpeLwSsYuQf7
         kubZiMHvf7mr0Fp2s/k3ABNHdrqvJCmYHzZSDigdSKx4ky4avUygekHwqFAovvn9IV9T
         FsD4A6xMK1mC8Ov45SzNDRhMl36FCrtij3hL7YNxxZ1eYR3wjNa3Xk3TA7A0tgfsVIbg
         LVMg==
X-Gm-Message-State: AOAM531SKXCQ4nwnAzBYloDu/AoRX9ETJIQtCjEw45+xv26+xtItwO8i
        d61NtbYvMSdgsXPcpPIFUqHpEg==
X-Google-Smtp-Source: ABdhPJxvnPe3l3ZjTy4GK3yV5HpbbVwGTyRGovAFO/amOnhQzpj6ArnkKSXl4d6v+2MEBksVtPecvA==
X-Received: by 2002:a17:902:8ecc:b029:ef:6471:dc08 with SMTP id x12-20020a1709028eccb02900ef6471dc08mr19255094plo.5.1622445567049;
        Mon, 31 May 2021 00:19:27 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id i14sm4600535pgc.57.2021.05.31.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:19:26 -0700 (PDT)
Date:   Mon, 31 May 2021 12:49:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: stats: Clean up local variable of
 cpufreq_stats_create_table
Message-ID: <20210531071924.bfomsgnukytf7yru@vireshk-i7>
References: <1622445367-37754-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622445367-37754-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-05-21, 15:16, Shaokun Zhang wrote:
> Local variable 'count' will be initialized and 'ret' also is not required,
> so remove the redundant initialization and get rid of 'ret'.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
> ChangeLog:
> v1-->v2:
>     1. Address Viresh's comment, get rid of 'ret'
> 
>  drivers/cpufreq/cpufreq_stats.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
