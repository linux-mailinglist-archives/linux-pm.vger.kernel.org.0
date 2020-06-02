Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F471EB4F6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 07:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgFBFQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 01:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFBFQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 01:16:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B8DC061A0E
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 22:16:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so886044pjv.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 22:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wDwA49qlibi8ifBKcQK5YxVr+aaj4hDDJcJVTNeIJ48=;
        b=rM7Q3kkjKcwtSFNIipJS/A4g/HnsQ1TsKTtLks8FS5hyB/S44lrzWqoImAeehYh+Dz
         WTjzuvsYIhRxoBgcTryPVTOIWEL+q+ftsR62L86UDYi6dFfHRyJLKulD1KLE8H+l+OSt
         CPu6no5aD/z8x8E6Ggvtgxq4dxz5BtDAKpNF3kF5G5436Km6Y+t8vh5DRd2f6WG9HZSo
         8f6yhbnLOtumZ3Nqau4SorDMFk2J/8VCtT7EmFVP/RteSMBD/kw18Qjjihr8x0xZ/mdR
         Wpi0Pr7n6FmV1r4qBYNjk3i36rX1IoST1Aqu91UbSEB/xm3wbC6fBrzrbE6+YJMfcZcy
         DRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDwA49qlibi8ifBKcQK5YxVr+aaj4hDDJcJVTNeIJ48=;
        b=U/AYRxpwXwPmykCyebqP6M54dCgo5+ZQkQ817FGLW47pzHB0g26iSPPV2kvjc2+KMM
         AIbM5fW+bLJD8x772XdbInQKFFul8+bz12CRZjjggRAFwzgVXDHl9WXcqa3qmuW3ZyFT
         RTnRSV4BnDuH3tJ4a00udAf3vGYWq/kjXdu/Ij2cUzWRXnJoTXaqBbG6q4LKUFG16XMc
         NNMkCx5+rptVGiSLtZj2I5OOElTFKq990zukQvlohc0FfsoeD5QDUoxSNXRYAK9Oz8nB
         zC5NFV2RZ4kFU/e7vSwkQheTH1DEa4eEjgOSjjQdoFIIelb27HRFofax7vkPb1XnKMJf
         b3Yg==
X-Gm-Message-State: AOAM531hJKsIt5brC0aPlPXzd4ivf4t+UlXWHUw/7o+cVr7Alk5QohgK
        TiViIwAj0lZ7J8YO3DfB2o3o1g==
X-Google-Smtp-Source: ABdhPJxK9MCNSAN72Ms1ilFwN/924RoU9ltixe5/gs2CCe/vT8GeVBVorAjhiJip1VvS9nwHngjmLQ==
X-Received: by 2002:a17:90b:30d8:: with SMTP id hi24mr3472370pjb.78.1591074973062;
        Mon, 01 Jun 2020 22:16:13 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id s8sm994752pjz.44.2020.06.01.22.16.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 22:16:12 -0700 (PDT)
Date:   Tue, 2 Jun 2020 10:46:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] add SW BOOST support for CPPC
Message-ID: <20200602051609.ahot4qv2nlb6yh3t@vireshk-i7>
References: <1590804511-9672-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590804511-9672-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-20, 10:08, Xiongfeng Wang wrote:
> ACPI spec 6.2 section 8.4.7.1 provide the following two CPC registers.
> 
> "Highest performance is the absolute maximum performance an individual
> processor may reach, assuming ideal conditions. This performance level
> may not be sustainable for long durations, and may only be achievable if
> other platform components are in a specific state; for example, it may
> require other processors be in an idle state.
> 
> Nominal Performance is the maximum sustained performance level of the
> processor, assuming ideal operating conditions. In absence of an
> external constraint (power, thermal, etc.) this is the performance level
> the platform is expected to be able to maintain continuously. All
> processors are expected to be able to sustain their nominal performance
> state simultaneously."
> 
> We can use Highest Performance as the max performance in boost mode and
> Nomial Performance as the max performance in non-boost mode. If the
> Highest Performance is greater than the Nominal Performance, we assume
> SW BOOST is supported.
> 
> Changelog:
> 
> v4 -> v5:
> 	add 'cpu_hotplug_lock' before calling '.set_boost'
> v3 -> v4:
> 	run 'boost_set_msr_each' for each CPU in the policy rather than
> 	each CPU in the system for 'acpi-cpufreq'
> 	add 'Suggested-by'
> 
> Xiongfeng Wang (2):
>   cpufreq: change '.set_boost' to act on only one policy
>   CPPC: add support for SW BOOST
> 
>  drivers/cpufreq/acpi-cpufreq.c | 14 ++++++-----
>  drivers/cpufreq/cppc_cpufreq.c | 39 +++++++++++++++++++++++++++--
>  drivers/cpufreq/cpufreq.c      | 57 +++++++++++++++++++++++-------------------
>  include/linux/cpufreq.h        |  2 +-
>  4 files changed, 77 insertions(+), 35 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
