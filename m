Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80AF4065D9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 04:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhIJC4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 22:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhIJC4e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 22:56:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BCC061575
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 19:55:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j16so613333pfc.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 19:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1DCn45fgjMCQ5dOXTyEr8YoI8mYYmFSGGZ1t4ok398=;
        b=SyYmiBfuT121U2kQWstr/h0lqnT+GUYyddY2RtuwDAiIx+QVU9o01WKFaaqGddtmsU
         DsyGOgtfQ2T3G8vHHSHYnzgjV0cCfCsGI+e5tYDKgBT5cANHKyAIstpj/aBeCY/r97xV
         nbdgIW2kZoofxC/5Hmcdorin1lSO5co6g/Phs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1DCn45fgjMCQ5dOXTyEr8YoI8mYYmFSGGZ1t4ok398=;
        b=z+XfBqY2dTQxs/co6W7x7Emq0+dsH8kVcU95Gq3Ma3FsZwWniBOADnQu16ZGr8j/hY
         OKDQhNh5V/TiMFPCi3yeFgCcaMmejvkmIFVse2IYGaAgZ7rq/uXWtxOKEe1akTtA7uGh
         kCDstSKqh8rYkmELBWvpvTGhRV0klhX1BW3VzSn2B802o1y9E28kY4YUgmYsUa9pqJgD
         Tj/SPvK9sJqBthK798xZb/e5kEHe451xBN+q51QsxJCIbhULWH9X1FWhKK7NfP3o6UCq
         D18IaUXKbq7JLmsw2hss8cxzbR3SpWmdiLj1MPX2ubEyp0zXg/6jQ/OlW1jy08KpSdVp
         80og==
X-Gm-Message-State: AOAM532S6aXrdnIEvUxdus3dH32XtyzcKj6031dbbLzx16w0VaZPzPCn
        N4YyzQC3OYV6jAvitFlYFFj04w==
X-Google-Smtp-Source: ABdhPJyXKJMH4iL1JkUkb6KeSYYQYWAuY6YIZKAKq4TIuyIAFhfG24f/49fPMpEMqqI33F4vjUeT2w==
X-Received: by 2002:a63:535f:: with SMTP id t31mr5438886pgl.270.1631242524046;
        Thu, 09 Sep 2021 19:55:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5sm3415494pjv.56.2021.09.09.19.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 19:55:23 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:55:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: vexpress: Drop unused variable
Message-ID: <202109091955.B786058@keescook>
References: <20210909184714.153068-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909184714.153068-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 11:47:14AM -0700, Guenter Roeck wrote:
> arm:allmodconfig fails to build with the following error.
> 
> drivers/cpufreq/vexpress-spc-cpufreq.c:454:13: error:
> 					unused variable 'cur_cluster'
> 
> Remove the unused variable.
> 
> Fixes: bb8c26d9387f ("cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag")
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

I hit this in build testing too.

-- 
Kees Cook
