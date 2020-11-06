Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EDB2A94D4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKFKzS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFKzS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:55:18 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C4C0613CF
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 02:55:17 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 1so500748ple.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/EXZYeChCIs1m40/OogMCYwnFfXBPrTLz46deLiJcA=;
        b=XE3WmDim8YAmqM4wMueP497yfYpq4mZKBuDgqPG/tLQgt6JSE0/4rnF/ynwrUFUtoD
         PQ5xhlF+SNe+ddNm3uq1E+sW+nc5eCrwv24/wQzXUILasKZByU53yrycLJmEBB9oErna
         IYdADsb7pse/R6UfvZYps8Y7FrZP9cIMsDW9gF4LvQH0kmFTCXYT0ESV4wOshPeby7tV
         R23mChkPhLJr78HSEuhX9xsyg0sxLwNhU4i7N1Ru1R4slkqFpd+Rz4K/Z7wssYvRnHbp
         U7T6XYHccwRJkqgoN0hfDBue85ZLX2awle9liKb/q4YQ+f7QZcdeIA4Vp5wWI2RDbduO
         cOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/EXZYeChCIs1m40/OogMCYwnFfXBPrTLz46deLiJcA=;
        b=iK9jr6YLsJOtT2HOZ7QSHYx1IopZO+IVtYc5CKFc/LUOl96bzuFuTwVX2yQRsgDSDQ
         ConPvi1zNR+FW3J3JiowMOqP8Y65cHMZHR7dFITajM+dJlJega+6ENpuAUEkpcxg+sZr
         lQjvgKJMlo/t7Ry29u2nawdLKTMxp9+CD55wQLMgFwIABZxVmbcmVbgu/9+QDO3/UtmK
         nPeRarj3y82ovJb9JzLO5XDlzg+c+vkjR0vOF5+eN8J9y+38/u9tQrjAPkYlyrvYCbo4
         yKP4kMFhzTTTMqu1evyhQ+WaT+HyLVB+2CEvB+3kqWc+CmUgNpWkT34FXn+peBFGqOBQ
         Vm4A==
X-Gm-Message-State: AOAM530hhQD5Oa7hLLlm9kxmucirCrGzPwA8LHoTPAihv1mNVfYHiCoW
        VtGvBlmoToKpKM+LD1wsoQz/Xg==
X-Google-Smtp-Source: ABdhPJwLCX4MA/OOHdhLU3UIDCLaYzo+IJOWbKzfu+djgm7NfBe6J0VuY+WxKlwV8jfW74rAFh9prA==
X-Received: by 2002:a17:902:7c12:b029:d6:ed57:fe13 with SMTP id x18-20020a1709027c12b02900d6ed57fe13mr1373599pll.59.1604660117422;
        Fri, 06 Nov 2020 02:55:17 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id y124sm1641133pfy.28.2020.11.06.02.55.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:55:16 -0800 (PST)
Date:   Fri, 6 Nov 2020 16:25:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201106105514.bhtdklyhn7goml64@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
 <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-20, 10:37, Lukasz Luba wrote:
> Good question.
> 
> How about a different interface for those cpufreq drivers?
> That new registration API would allow to specify the cpumask.
> Or rely on EM cpumask: em_span_cpus(em)
> 
> Currently we have two ways to register cooling device:
> 1. when the cpufreq driver set a flag CPUFREQ_IS_COOLING_DEV, the core
> will register cooling device
> 2. cpufreq driver can explicitly call the registration function:
> cpufreq_cooling_register() with 'policy' as argument
> 
> That would need substantial change to the cpufreq cooling code, from
> policy oriented to custom driver's cpumask (like EM registration).

I am even wondering if we should really make that change. Why do we
need the combined load of the CPUs to be sent back to the IPA governor
? Why shouldn't they all do that (they == cdev) ?

This is a bit confusing to me, sorry about that. The cpufreq governors
take a look at all the CPUs utilization and set the frequency based on
the highest utilization (and not the total util).

While in this case we present the total load of the CPUs to the IPA
(based on the current frequency of the CPUs), in response to which it
tells us the frequency at which all the CPUs of the policy can run at
(I am not even sure if it is the right thing to do as the CPUs have
different loads). And how do we fit this dependent_cpus thing into
this.

Sorry, I am not sure what's the right way of doing thing here.

-- 
viresh
