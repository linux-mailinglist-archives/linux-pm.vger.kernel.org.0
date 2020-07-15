Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703F22027D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 04:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGOCtz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 22:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgGOCtz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 22:49:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4F4C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 19:49:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so1566386pjt.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q5vvXYd0T7QlyjZ+KGgsyakgUV75e/J/r/3oQdNc2Z8=;
        b=DezqCrAtzHMnxCsO8uGVnxD15BIn0IEeUuNsFF6BNaXJcE67PXoACB2NqCJsZ4YMJ6
         IQfBwy4l2Ikj7pABYwwxJNXwhc8u73xQ20q5oPN99lPuNCa5jOV/MvLUN3SFhtI6m7Ov
         AB1DPqy+ndx22mCtf3jVpdGuDQ0GcrT8Wu+t09vRbD7RHq4a39UJgYi1qFRcEsGI65Fs
         PHLZbUodNCESvXzrUiaRxbbYKAiQBHDxeP593atEm8e5e8pw/XPaP62KysVY6Ka+sHP6
         fh7AMRWHGZ+U0JWQbNJbDhFDsfj7BFFFxwSqKCK8ea4L8f4nSFgcZ3Nw6C+U+py9bhNh
         TqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q5vvXYd0T7QlyjZ+KGgsyakgUV75e/J/r/3oQdNc2Z8=;
        b=oBsm467DUpngqpNlE2KSNySo+CTLUZxmSYlZjLwBo0J8Cbh3wn8lX66lfLBaLuxkyb
         8d3TDeHplQsyTiPyICWm5fFiP0Ar0/saT69I39+QroTpdWJ/9gUbM4dfGbjcAJ2IML4K
         RZvHKKFm37B7h0km6PMm4SD3/6hBzemruOA46LymEtuzS0uwl6q7ZKr8Sm/CBBiHrjZl
         UAnkKhAaG7hJO0kIlE9ycss9aINYyvkMSdAfu6PAQ3HVR2OOpYKBvMb/2T99UAHw2D8w
         puGazVXwKSQnTOEzNemHf78mPpQJKJeQtRSjnRjaq59cylCiaauLEZLjkhk2GP54RLuU
         U8JA==
X-Gm-Message-State: AOAM531yrc5GiFUYp7l6zmbubP036g9bNJk7NPFhW+UtAcj+2ufRvDs5
        Z5senrXhskygBi/baPDkDLtbYA==
X-Google-Smtp-Source: ABdhPJzBhKELTRjg9O0sSVH+78W39OnjWXN56hDD8UePtV9hJOoL5/dKy2apkTSELv77wUsEMtcZDg==
X-Received: by 2002:a17:90a:80c3:: with SMTP id k3mr7713771pjw.102.1594781394340;
        Tue, 14 Jul 2020 19:49:54 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id k2sm404748pgm.11.2020.07.14.19.49.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:49:53 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:19:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dominik Brodowski <linux@brodo.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH 02/13] cpufreq: cpufreq: Demote lots of function headers
 unworthy of kerneldoc status
Message-ID: <20200715024951.zr36iuagany5ii56@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-3-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> -/**
> +/*
>   * cpufreq_remove_dev - remove a CPU device

Because cpufreq_add_dev() is part of kernel doc, we better keep it.

>   *
>   * Removes the cpufreq interface for a CPU device.
> @@ -2373,6 +2374,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
>   * cpufreq_get_policy - get the current cpufreq_policy
>   * @policy: struct cpufreq_policy into which the current cpufreq_policy
>   *	is written
> + * @cpu: CPU to find the policy for
>   *
>   * Reads the current cpufreq policy.
>   */
> @@ -2759,7 +2761,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_register_driver);
>  
> -/**
> +/*
>   * cpufreq_unregister_driver - unregister the current CPUFreq driver

And this should be there for sure.

>   *
>   * Unregister the current CPUFreq driver. Only call this if you have
> -- 
> 2.25.1

-- 
viresh
