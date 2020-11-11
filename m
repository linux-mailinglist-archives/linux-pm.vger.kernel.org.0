Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E22AE7C8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 06:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgKKFO0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 00:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKKFOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 00:14:24 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA10C0613D4
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 21:14:23 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id g19so96658pji.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 21:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sul7TzPz5qF1XraO9vAG985VB9LlYhMpRl/uNls2UjU=;
        b=UPgyXL95q28Kgd5y6d93bt4A569RsW2McX9HlMQezIVbuFHdgFUecyO47PAmyrmTQ1
         u37QTkbuRqjAP52c2bu/EtjrNmaso1HkfRjYXojlzwABRJ3pGFKtEolAyVP2M2LhQCdw
         McX91JE3dV7dtbLXHF5lvIglLT7FwaHZB0uOfHKtS1sjp9opOJJ2Bb4Wr9MIfJMMi5+5
         U1DK+a/Dip5wE8riJwz+wmesvWH/1NFZXgfispH5TAAGLtWxYXNZIjp01HPwCf6R6Abv
         Ur9MhTe/ek+XHD8kzpQOaZ3ytC3FJwqLAAZusPs39q494zDvqwAc87wS7crysFA2Ic07
         5BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sul7TzPz5qF1XraO9vAG985VB9LlYhMpRl/uNls2UjU=;
        b=p/7sadjImx9hwelZXiLWJzz15pulPgvjP7ruoOZBHDwQOg+pcKhen3yhzu04nte1eJ
         GbyjcmK67ExGPjvKemO86kE9UG6xJMpdOmJSzCIYBmkaoOCooB2vIxiwsy6M3f6k8gMo
         jkRQ6mrMMsuxYeQuMO1F0UkJFquLYar98NCeIbYUbRuMAbohvXvY0Xng8m1P/KQHzj1r
         lDc6oOgpbR8HxjxA0/mbE7iyBXRqY3DRFcNjZaVyMUHR1JaBTaAeW7fOfUWCv+GaZX2v
         kXBvrJPmG1YgaoDRjEGEc8iJzW89APlCUhrpn9JsRKamiTWb77Zk75thHpiyugV7aM6A
         w3YA==
X-Gm-Message-State: AOAM531YN070eld3dnyzregrkf6IQxvmGvYRVp1ux1bj+KZn7txXIARJ
        37ULKCb3a//jH8XnWpj5OYM2AQ==
X-Google-Smtp-Source: ABdhPJwJzT/EbwsgNXsUfOzHkgAE5KhjmVJtC6toMBQcPdFliU6zf3qo2WyRHRlRIo42psh5F8tlzA==
X-Received: by 2002:a17:90b:351:: with SMTP id fh17mr2105299pjb.214.1605071663286;
        Tue, 10 Nov 2020 21:14:23 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id u197sm853670pfc.127.2020.11.10.21.14.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 21:14:22 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:44:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of
 jiffies and usertime
Message-ID: <20201111051420.wy7vapqx3gwcvzdw@vireshk-i7>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
 <5860b346-4eab-4018-87e4-a6313115fa2d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5860b346-4eab-4018-87e4-a6313115fa2d@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-20, 11:36, Lukasz Luba wrote:
> I am not sure if these ktime_get() are not too heavy in the code path
> visited by the scheduler.

Ahh Right. I missed that.

> How about local_clock()?
> It's used in ./drivers/cpuidle/cpuidle.c to do similar accounting.

Will have a look.

-- 
viresh
