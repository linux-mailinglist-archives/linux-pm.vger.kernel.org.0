Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9D2D857D
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 10:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbgLLJ6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 04:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgLLJyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 04:54:43 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D3C0611CB
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 01:11:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so10690094wmg.4
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Zwrk1C01SFawGIN2qVUduWj86VuxKX+lX/AnlfSy+k=;
        b=FS/u6APMfZKK57ai1xg4P10itnRfUQXUWmXJjj+RO+J31Or98l0R/A4lrNC5f6l7sQ
         1akR0qQUShOiDifcunzKNIZr0/GuXcMlDjLkacs40L7svrv4FhSDV9ujAGneNqBtpEag
         FU8rG5L3073EH6EzSnF4YCNxnzUt0mYsWzP3DCHm3inwlsOpGzoKe7GXY/uJF2z5BfRj
         +hs+zYQVa55mVRiTXAPsZjWIW3bXNR//WPkcSLcrnIKZnEKc7dk65GREJuYHM+UtFlGt
         UwRhPPiMVigiwSNToasiSVGykqr/rj2xups7F8Kq0yrkqG2xKAzitv5bH1Lpz1fayBsw
         98GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Zwrk1C01SFawGIN2qVUduWj86VuxKX+lX/AnlfSy+k=;
        b=ZCMPO2qahSVhYNHmCmRbF9OmhQP241oXZs7Lb6uq9WVhn4tdT+VUTqNhEgiCFUYxxu
         Mjugay6hiq0chqJyIX20LipreVrEmn7yve1iy4JbOi6znBilSXjx3EUFUiXqz0988QNJ
         Yz5fl2fTc2gxXJDYCUB+m1Pvgmaok8xpLiVUcnVuO1ztsiGmuaYFKVQYNKJvx06CNkqt
         q49/o4HHgjsvwx8CIQCqCcjppgB2BPRV2s0el6tkc2xHJmE1pKpuNs4pybQfN6Sz3Dxy
         a4Kt9ZJHEU5ySSzYR9XbmEyLXZa9thprMHatu1cCvjZf3wSQg/LMM/rMbWxGxgcER88V
         CCXA==
X-Gm-Message-State: AOAM530Zb4wy4In5+8+IWddN3OFC2wDAbLA80McNo4EVxzo1dtWI8ot7
        Z97AsO0DrGHb9go54XsBJmwMeg==
X-Google-Smtp-Source: ABdhPJxBC4ft+6gF5rrqdIvOkyzrRh7kT2zrxAfO2eTWMBDfpT+FwaoER6sF4oWxigmNIv21OEtOHA==
X-Received: by 2002:a1c:81d5:: with SMTP id c204mr17364176wmd.156.1607764294077;
        Sat, 12 Dec 2020 01:11:34 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fd07:6f0a:92a7:a3a0? ([2a01:e34:ed2f:f020:fd07:6f0a:92a7:a3a0])
        by smtp.googlemail.com with ESMTPSA id q143sm19986932wme.28.2020.12.12.01.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 01:11:33 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
To:     Matthew Garrett <mjg59@codon.org.uk>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
 <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
 <20201212035012.GA11926@codon.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <20015331-955b-756f-3dce-4eb78e473704@linaro.org>
Date:   Sat, 12 Dec 2020 10:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212035012.GA11926@codon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/2020 04:50, Matthew Garrett wrote:
> On Fri, Dec 11, 2020 at 02:17:55PM +0100, Daniel Lezcano wrote:
>> On 08/12/2020 16:30, Daniel Lezcano wrote:
>>> The passive file in sysfs forces the usage of a passive trip point set
>>> by the userspace when a broken BIOS does not provide the mitigation
>>> temperature for such thermal zone. The hardware evolved a lot since
>>> 2008 as a good thermal management is no longer an option.
>>>
>>> Linux on the other side also provides now a way to load fixed ACPI
>>> table via the option ACPI_TABLE_UPGRADE, so additionnal trip point
>>> could be added there.
>>>
>>> Set the option obsolete and plan to remove it, so the corresponding
>>> code can be removed from the core code and allow more cleanups the
>>> thermal framework deserves.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>
>> Is there any concern about this change ?
> 
> Yes - what's the reason to do so?

I'm cleaning up the thermal core code, so questioning every old ABI.

> The code isn't specific to ACPI,
> so being able to override ACPI tables doesn't seem to justify it.

I agree, the code is no specific to ACPI.

What non-ACPI architecture, without device tree or platform data would
need the 'passive' option today ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
