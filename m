Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC783C68D8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhGMDVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhGMDVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 23:21:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F4C0613DD
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 20:18:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so11288822pji.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 20:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVE/GvgYSkx5WumDeWyC0XJX7isLA4Rw/p1THEQwD/k=;
        b=ZjHVXmLWwx73MO5QZfJPr8MhbsrF1UXd3c5gB6k7KL5GwU7iF5Dq3fxLS6gEOtG4Ee
         he1n7FVQNQJurAPVYkvtZ4dV/IevaeY77tozLQn228hIauDqMSGGzDJm19ukbNKkMSR3
         11B9ijvxVRlPxwRH49E08pPkZ/Zqy/jK/OFip4pUGIOrIMXBxSE1lbp0ZvRvYpui6pfx
         HSHGHASD/1doEnBp+Rp42oPiDsSoxi/iVKKbc4COJ0jCNm3dbRzmolL6FHgVK4lC778m
         G3HcSQbCQpKH19XZo+/0oRhNqpbbCF1sQSs/YMSsZnj79Xokt4LN3/0H1Tan9fvJOmiE
         aeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVE/GvgYSkx5WumDeWyC0XJX7isLA4Rw/p1THEQwD/k=;
        b=pmzkPQ8s1pN0f1xICYGP3WsMqwtXfUk+r39nQG0/C49adf2EkK1h/SijbW2QH3MSkt
         Gd/UvDO+8/RtEPu0oTYs2xbKYKMl/+yn3htNSw8yHesR1oTgldcBGZ6Y4JF7Mw4cswOh
         zyc6il7brityTY6OBJ9RiSfflWOKHe3KxhrGMA/0ASt9edJD8IAYiy9xOG3b4ZsuoG7V
         hqYf3w+jnZ/r3jrYTMzEcPfmzm6N7P/7Qsjq+iFFhcjPSh72oOQuwuYVp9QO4n9pQKwS
         i9ie1Hykkwa1b+iB4W4aPqMECkebncJWh/uq6tSImR7XjT1NFO5YD3zoeYPisHkLyO0S
         NOvw==
X-Gm-Message-State: AOAM531KmwRGYbPJAD3yy3khuCztYwYA9u2uUX4K5x0EbA1ewVvyaHHn
        QFjpnZgb8xcBSxGBqKAzHpbFJQ==
X-Google-Smtp-Source: ABdhPJxnukAahEghffljUbOvSCONqbcz4qXjFGF8KttLdmDgPsVhx2udW7HNXCNocZQXTQGGpI5BXg==
X-Received: by 2002:a17:90a:fd14:: with SMTP id cv20mr1119258pjb.98.1626146331122;
        Mon, 12 Jul 2021 20:18:51 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id m1sm838985pjk.35.2021.07.12.20.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 20:18:50 -0700 (PDT)
Date:   Tue, 13 Jul 2021 08:48:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210713031848.sp5fpjg36uthnmuq@vireshk-i7>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org>
 <20210709064646.7vjgiba2o7beudly@vireshk-i7>
 <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
 <20210712044112.svhlagrktcfvyj35@vireshk-i7>
 <b05e9c76-c0ed-9ecb-8225-9504e226677b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b05e9c76-c0ed-9ecb-8225-9504e226677b@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-21, 21:18, Thara Gopinath wrote:
> So I really need the interrupt to fire and then the timer to kick in and
> take up the monitoring. I can think of introducing a variable is_disabled
> which is updated and read under a spinlock. qcom_cpufreq_hw_cpu_exit can
> hold the spinlock and set is_disabled to true prior to cancelling the work
> queue or disabling the interrupt. Before re-enabling the interrupt or
> re-queuing the work in qcom_lmh_dcvs_notify, is_disabled can be read and
> checked.

Or you can make the lmh_dcvs_poll_work item a pointer and mark it NULL in exit,
with proper locking etc.

> But does this problem not exist in target_index , fast_switch etc also ? One
> cpu can be disabling and the other one can be updating the target right?

The race doesn't happen there as cpufreq_unregister_driver() takes care of
stopping everything before removing the policy. To be more precise, governor's
->stop() function is responsible for making sure that frequency won't be updated
any further.

-- 
viresh
