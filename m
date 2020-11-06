Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B312A9260
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 10:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgKFJUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 04:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgKFJUd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 04:20:33 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4EBC0613CF
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 01:20:33 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x13so752135pfa.9
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o8uFcVKje4kv+RGQbC1+Di2p0kqZQdZRyJXvb9yfszI=;
        b=Zo46DEmkqJXg2ONVmV7MPYuDSINCYRNJKcahQ33Zg+IcFOcg+lu1DP5wDQk1KC5MZr
         YQ9tDm410E0LrIe7lGXHW/t0PyfyTHad3w8yu7hj8zMOJBlbzPoI/YHs5bgKf6bcODsU
         hlAUSlCrONQOsU05d7+2mZxORNu/JRNguiMRANQQ2kdOLt6kxG9Rm9u2y8WvG4asnpgj
         vBsGf4CLT/AITZza3UDP8F6blDt1pz2pjcOMEiWl1yNj2lGZCV1lPfusdcu/QRVJHATP
         J8Bag4/eqwNiceJoEXSo1isob3PyOLkqGlgpIXDHqAqVZVkhnjVkvT5S4akFldscFpeC
         16JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o8uFcVKje4kv+RGQbC1+Di2p0kqZQdZRyJXvb9yfszI=;
        b=Q9+khOp5X6HUt+lE9rt+QGIEe6xzUw5dXyoKcYxEpSzAn3apmhibJ7HvD5nT48kK7/
         UsRqOBtS2j4jN9jGtrxBV7OrgH3IxDirdwY20HQuHiMBGeM/t6aHtmtUGi/VDwXjX4cs
         TMZfoZ8FV4z6D/c0DTn2kRLZUwkdSg8c6JFmYcjfIHyT/rbW0DpXLoO924LVqVwWiMTw
         U3by7V0iNQlUa4OObsDeX1Ntt184Z07660Q8WQYQvb/RqXcasFyRAI2oq9GEg6BMAXns
         WMnTK7ENgctJuRnV2YlyRJRb6D92JR6PNEgNXJyW1bFEMFuAfwNIRpYW647B5jd0Tpkv
         V5pA==
X-Gm-Message-State: AOAM531IiU6iLd/fX86kJr9iCHkY+KYWu8FuI3iTDzmXOo5cpnOoFEwz
        i2iLcckKQFjE2dxb0u9+yvlLiw==
X-Google-Smtp-Source: ABdhPJzR8+V8THDr+L0oS5ftjQ06bl0btESASGt/pHIKZV9BSbI/wAdu5iu+3PBZhWIHPCib1LCIWA==
X-Received: by 2002:a62:a11a:0:b029:18a:df9e:f537 with SMTP id b26-20020a62a11a0000b029018adf9ef537mr1145546pff.29.1604654432830;
        Fri, 06 Nov 2020 01:20:32 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id e6sm1088952pgn.9.2020.11.06.01.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 01:20:32 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:50:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102120115.29993-4-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-20, 12:01, Nicola Mazzucato wrote:
> This is a continuation of the previous v2, where we focused mostly on the
> dt binding.
> 
> I am seeking some feedback/comments on the following two approaches.
> 
> Intro:
> We have seen that in a system where performance control and hardware
> description do not match (i.e. per-cpu), we still need the information of
> how the v/f lines are shared among the cpus. We call this information
> "performance dependencies".
> We got this info through the opp-shared (the previous 2 patches aim for
> that).
> 
> Problem:
> How do we share such info (retrieved from a cpufreq driver) to other
> consumers that rely on it? I have two proposals.

I haven't really stop thinking about what and how we should solve
this, but I have few concerns first.

> 2) drivers/thermal/cpufreq_cooling: Replace related_cpus with dependent_cpus

I am not sure if I understand completely on how this is going to be
modified/work.

The only use of related_cpus in the cooling driver is in the helper
cdev->get_requested_power(), where we need to find the total power
being consumed by devices controlled by the cooling device. Right ?

Now the cooling devices today are very closely related to the cpufreq
policy, the registration function itself takes a cpufreq policy as an
argument.

Consider that you have an octa-core platform and all the CPUs are
dependent on each other. With your suggested changes and hw control,
we will have different cpufreq policies for each CPU. And so we will
have a cooling device, cdev, for each CPU as well. When the IPA
governor calls cdev->get_requested_power(), why should we ever bother
to traverse the list of dependent_cpus and not related_cpus only ?

Otherwise the same CPU will have its load contributed to the power of
8 cooling devices.

-- 
viresh
