Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA94A31F48C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSE7J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 23:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSE7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 23:59:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA1C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 20:58:26 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t26so2828682pgv.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 20:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQ8JfAUf/ySg/ATklOLfVi6FRg+WrMTayYjOprp1Sx0=;
        b=zrt/i2IK+MNx8nousJ5vhUkJhPOg+W4lAaza3KU7WU5akL9GwRYl6fQtYhNv5OPgY+
         DH+LAVbb4FtDeXzzY815wVASFyQv3PCGNAStQH0V4uw8EBNU1Ir8Hsl/6tzswvd1TC8c
         cU0qPNlAxe9fwZ4gRAFODY1w66JGzR3S+RYHoonlLtQt9BbnkLkdx8RBgxU2LTn/utZb
         /YDLg1RG0yahHSXebbwpRlOJdhqjI14F0xjzasUbv7hvqKPJm2vwlVBm6T1JMwWWT2N9
         NkJkVQb6OtohZ1RPApNY6L7wwiT0oR+nP9JDUape8vht0cXFLole/ud9E1+fq/+LyGZP
         fUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQ8JfAUf/ySg/ATklOLfVi6FRg+WrMTayYjOprp1Sx0=;
        b=EBmJH+2uckxAnr+Kh01R6KEz1jWO6iypyrurMos7/7ulxP0kJPsNe7AHQ1llANwAl7
         L9zyc+wV0vgSFhzHiBLOEvD75xzmC048lzWa63ezfxopevCLalraAcx9aNAtzC3P16jL
         NAmbF2LDNUl4E52b8u0jskecI11zpgudDUX9SvA9XUygoFHxqKUWxqVfu/Phkjxbdnhj
         HjbIOad2gAhgHO78AfPNW0+7f+u1awhDjMud2NQEriAjiVbheBV54JI43evRAOCQ+/2y
         eVMbfeMlDtN/Bct8b1RUc8bZ+i0aSARavOoWlgphKFob+2lweOWDnKXy06BIG6WoCRCI
         V2RQ==
X-Gm-Message-State: AOAM531pgnCUZfUhRQMgOY3qnYXHkO44dqS2LjxT4hhjkZc9k7ffGxFV
        2PaBMiDc5pW+FqTphFVfxM1avw==
X-Google-Smtp-Source: ABdhPJwu4+l3z0J6l2dIbzGBCfMCuNcRbcfi8xlFg/zWmBVxwfBMR2E2oxOYuMXfJN2cC8DQBRZXAg==
X-Received: by 2002:a63:1845:: with SMTP id 5mr7015563pgy.244.1613710706075;
        Thu, 18 Feb 2021 20:58:26 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s18sm7433890pfm.129.2021.02.18.20.58.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 20:58:25 -0800 (PST)
Date:   Fri, 19 Feb 2021 10:28:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210219045823.beeijwaymd63prk7@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210218093304.3mt3o7kbeymn5ofl@vireshk-i7>
 <20210218163635.GA23622@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218163635.GA23622@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 16:36, Ionela Voinescu wrote:
> Yes, we don't care if there is no cpufreq driver, as the use of AMUs won't
> get initialised either. But we do care if there is a cpufreq driver that
> does not support frequency invariance, which is the example above.
> 
> The intention with the patches that made cpufreq based invariance generic
> a while back was for it to be present, seamlessly, for as many drivers as
> possible, as a less than accurate invariance default method is still
> better than nothing.

Right.

> So only a few drivers today don't support cpufreq based FI

Only two AFAICT, both x86, and the AMU stuff doesn't conflict with
them.

drivers/cpufreq/intel_pstate.c
drivers/cpufreq/longrun.c

> but it's not a guarantee that it will stay this way.

What do you mean by "no guarantee" here ?

The very core routines (cpufreq_freq_transition_end() and
cpufreq_driver_fast_switch()) of the cpufreq core call
arch_set_freq_scale() today and this isn't going to change anytime
soon. If something gets changed there someone will need to see other
parts of the kernel which may get broken with that.

I don't see any need of complicating other parts of the kernel like,
amu or cppc code for that. They should be kept simple and they should
assume cpufreq invariance will be supported as it is today.

-- 
viresh
