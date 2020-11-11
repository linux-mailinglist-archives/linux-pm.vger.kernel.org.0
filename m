Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0912AE894
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 07:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgKKGBb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 01:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKGBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 01:01:30 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2311C0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 22:01:30 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f27so789688pgl.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 22:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sElQ0UasyAxx1p9v/6PmsrVmJXS5A5b4XWEfpPsYb2c=;
        b=AgRH2ICBEuIJ5D7uzTetuBykN7UmRfVT7tsz859NB5W/UFCLY14yHowhi9eyAxulQA
         BY+gI662sES/BaznMeaX9fcE61kUoCbdRGQSHQlF+egh+WYtqz4KsUXc9GRTQVe8TT1I
         yAfCPmvD0/4gI2XwatntdmbN5XxaKNI8Ug3UPFmzzxpWStyLjA2v/JWxfO5tUXqD1dlZ
         PBlI8bJXqCu8WDJdygKQnfP6KGEIf2qEAtVmOABgNt+stLNcNoGHssGWfWD5JZR14ntZ
         W/UvSDHVei5XNjmmOzxkQwF2se4R8FzrYpoa41vij2rq31Q5v56ZVoo4eq7WVFXaSEpM
         euwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sElQ0UasyAxx1p9v/6PmsrVmJXS5A5b4XWEfpPsYb2c=;
        b=bFOQWGr2X7P8GzS5oNMDqLvio20XVBBZqCLvFV8CNNEPKo2U1aHPzFWAY/hq+OuKzl
         BRa+D+wl+wzaFLgryDj3tTco8LyA7fLD4OIINlFc6Sl32EmW1SAzPd0UeSfj1bTQvdep
         FuDftKLWZH2fBGs3nI0vNJ7VMudMdo0CMnvZH0Q4XQTNvsGHYvKoBBNUIVmgleYx8KFJ
         5BXiWqnxycr+4ySUFQRIBdDSBujJI6BhTTjPsTXFjxISbWtYjcK0cORBRu0LRXLtL62l
         EDWnKTyzodZsbj+Qw+RdboE942evUjy7XpUbIVKWMuBQRnsjw8FDX7MxmQF9B/k6Aqwx
         yM/A==
X-Gm-Message-State: AOAM532XqF04D30AbTSM4lHhgXr+DXW8zgpmVn7VEiffqBg5p3XvGb3z
        ucAlm+quv1i4cvFNslatM3c1xA==
X-Google-Smtp-Source: ABdhPJzRqVfTZchctw4+pUfLWVKTckJpU+KZvrJQ9LuRTyDx2mJRy0bpYJSt/F1B6CXc6Jkm2dDXiA==
X-Received: by 2002:a63:5fc3:: with SMTP id t186mr20186444pgb.187.1605074490182;
        Tue, 10 Nov 2020 22:01:30 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id v191sm1020905pfc.19.2020.11.10.22.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 22:01:29 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:31:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] cpufreq: Add missing modalias for tristate drivers
Message-ID: <20201111060127.ulr63huycvqxxkha@vireshk-i7>
References: <20201103151139.29690-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-11-20, 16:11, Pali Rohár wrote:
> Some of cpufreq drivers are tristate, can be compiled as modules, but do
> not have defined modalias for automatic loading. This patch series add
> for all those cpufreq drivers missing MODULE_DEVICE_TABLE macro, based
> on OF definitions, or MODULE_ALIAS for platform drivers.
> 
> MODULE_DEVICE_TABLE is not explictily added only for speedstep-centrino,
> speedstep-ich and speedstep-smi drivers as it was removed in commit
> b11d77fa300d9 ("cpufreq: Convert to new X86 CPU match macros").
> 
> Pali Rohár (9):
>   cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
>   cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
>   cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
>   cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
>   cpufreq: st: Add missing MODULE_DEVICE_TABLE
>   cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
>   cpufreq: loongson1: Add missing MODULE_ALIAS
>   cpufreq: scpi: Add missing MODULE_ALIAS
>   cpufreq: vexpress-spc: Add missing MODULE_ALIAS
> 
>  drivers/cpufreq/armada-8k-cpufreq.c    | 6 ++++++
>  drivers/cpufreq/highbank-cpufreq.c     | 7 +++++++
>  drivers/cpufreq/loongson1-cpufreq.c    | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c     | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 +
>  drivers/cpufreq/scpi-cpufreq.c         | 1 +
>  drivers/cpufreq/sti-cpufreq.c          | 7 +++++++
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 +
>  9 files changed, 26 insertions(+)

Applied. Thanks.

-- 
viresh
