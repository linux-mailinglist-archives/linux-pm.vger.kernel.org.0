Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B733B1206
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWDNN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWDNM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 23:13:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F4EC061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 20:10:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v7so569621pgl.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0gPs/cs8YvnQjVNndlg//nehJAxA2/r7AIcl6qRSJw=;
        b=wpfhEedfhZcJ6o7g7lFoOV4VkVD/dYlAckXkDcsS8MHNP8iNBhshJtmdcdsVFRknCy
         ekPFziu3c6jKykAou/RtZewHx0KJk5/kr/pmKqQOjDngYzDTLa3HVc1qbR8m6gJJajmA
         iPGV9W4iLR0dr8qx5/XG+eZpULi86fAU7/Nrc7iyzTiJee5RB0xgyvok2nWxEuqKZmRp
         qDpNj86TgJxYYO4QReHiuWrqjSlY70SXX9zV8c9SXo58gmzvvvpbEcMEhwnf+MeoBMxc
         7zgtfdMmPEyiC5p5oXuqm6gKOUJRtV6+yffa058IjKUgpTF3BMR0ijAtgwoXmmzIHwTy
         yvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0gPs/cs8YvnQjVNndlg//nehJAxA2/r7AIcl6qRSJw=;
        b=SovN2QmCHQtxdklDUUK2zSsgM0Qo7CaIZMqwsHBJHldUC1NJ5X4hVeJP5ncvpmzxV4
         w7uDhewOVv5YE8vQDkBuJTGS4MBMNvcI5oZRo+daF4D9r5Rg3nnwa+1F/mNLSo3VfBQJ
         Lf+NW4C9orhEwSBRQmXaxQOXsrx7/U9xNAt1AaF1GwhQ0TeX5lb7MxaPwO9gjICPC3m1
         vS1umyDsqsYnT03cMTWj4CzV+ZbeYDdphBUNnfq0zJOSBC25AcNr8jv5cl15EE0/lRNj
         tkwCcJnTCVUP1T6TFQcndiwiimK5JRYR7Gwj7bCf37HOXLEODJHsWLjulHhOUqvR4gVv
         9Faw==
X-Gm-Message-State: AOAM53228Jav7vl1+PMfIkzADK264gJForfYclgG2GUITSUoOcN6/0by
        n02ebhwO5MUSWLBHGMsU7Fb5cQ==
X-Google-Smtp-Source: ABdhPJyy3UQ9Fcvn1OWMeug2nlY5olK42S2yBzsHOzX5nuv98ZPVPdeGAxStLE4FLbrDL0wQ/IqH+Q==
X-Received: by 2002:a05:6a00:c2:b029:2ee:9cfc:af85 with SMTP id e2-20020a056a0000c2b02902ee9cfcaf85mr6680704pfj.78.1624417854712;
        Tue, 22 Jun 2021 20:10:54 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id f17sm20974482pgm.37.2021.06.22.20.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 20:10:54 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:40:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: Make cpufreq_online() call driver->offline()
 on errors
Message-ID: <20210623031051.xsbcug5erbgvzjde@vireshk-i7>
References: <11788436.O9o76ZdvQC@kreacher>
 <5490292.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5490292.DvuYhMxLoT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-06-21, 21:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Make cpufreq_online() call driver->offline() on errors
> 
> In the CPU removal path the ->offline() callback provided by the
> driver is always invoked before ->exit(), but in the cpufreq_online()
> error path it is not, so ->exit() is expected to somehow know the
> context in which it has been called and act accordingly.
> 
> That is less than straightforward, so make cpufreq_online() invoke
> the driver's ->offline() callback, if present, on errors before
> ->exit() too.
> 
> This only potentially affects intel_pstate.
> 
> Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of CPUs")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>    * Avoid calling ->offline() after a failing ->online().
>    * Add a comment regarding the expected state after calling ->init().
>    * Edit the changelog a bit.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
