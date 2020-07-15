Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC22206AA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgGOICk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbgGOICk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:02:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D360C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:02:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f16so2601069pjt.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=28LPiAqo6rn61iySEHGNuvUMSg1fAAzkUJ6/74196es=;
        b=q2XXH5FkzyM+I/gEOBKmjb1QlV9XBEvY1twWEJnRlidueLWibUqV4QyC45U0hx45ly
         5B65hTcRdCLKmk5dGyRrAhGxXZu45q/cxUEg1OZnXhFNjqlQeLCa0L8v0+qgM3pAzS8w
         vrOcj0bucXfYarPsK80ub8hZCDzExNnRtBjuHrIIo3+iGpAlP2yBP3aYvagvYR5sQuGa
         Sp2LaNKrb/nr3rWDC5YwdJTBA+mudqKuNCXBrTgI698hxNygOTjLht67saJcsMgbHhUf
         qS64Lvb4tAmqbBjXokRiscmMcFiPKFGwulfwy2+KmDivNIsetaV1XHX5ljnmo3Z9aSke
         WYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=28LPiAqo6rn61iySEHGNuvUMSg1fAAzkUJ6/74196es=;
        b=ISQJRdN5xzGqoXpB1J2LMSGiumu/PNUPaIRigZMspIvgsKSmW3YAIHDZSMhQXjpPsR
         c6ygdkuh68UqMD7oZCf5cxb5fgL4CfuDUz3qvyRC8ZGKMygn3ZTOlvu/zlBBk3Vsipp7
         eRE7SbqN8+qc8+jaowBsfuUSQkZH7bbHj/82MbrQQ9yDmOaL5cu6K5jsyLAl8+WFV1Lb
         lV3t2A6/Q7GWsOZVwYG/0BIlqgFtkX7l5er23uRUlJfSyo73uxErHbH6hxALMIuzab/B
         Q42yXxIkdcmqt0bJmWWCvVnTwP9goUT5AmWuhzoIPmJk2jV0m/J9CsuMDVxQ8+xT6LP2
         K84A==
X-Gm-Message-State: AOAM533OfP6nVfK+fOIh7tcDa5ic312NrfHf0CW9cVwS1KhGRWEJ/LL4
        Veovh4gy8K5hju3UVfEDiPNS/w==
X-Google-Smtp-Source: ABdhPJxedNl8dwWRu2b2ozerCCOLDc/kmjGQO7RexlfDLuupNj0NWkugyMQ8g3x3UE/bPykP1JE0UA==
X-Received: by 2002:a17:90b:b0a:: with SMTP id bf10mr8336516pjb.220.1594800159342;
        Wed, 15 Jul 2020 01:02:39 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id x22sm1343745pfr.11.2020.07.15.01.02.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 01:02:38 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:32:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715080236.n3gecwhidorn4rqq@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
 <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
 <20200715064539.GS1398296@dell>
 <20200715070836.l24lzkb6pgvqj26i@vireshk-i7>
 <20200715073150.GX1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715073150.GX1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 08:31, Lee Jones wrote:
> I'm not sure what you mean.  Kerneldoc headers are designed to be
> extracted and converted into mediums which are easy to read/browse.
> For example, see the online documentation for 'debug_object_init':
> 
>  https://www.kernel.org/doc/html/latest/core-api/debug-objects.html?highlight=debug_object_init#c.debug_object_init
> 
> They are generally meant to be referenced/consumed.  There is even a
> script provided inside the kernel to find offending instances where
> kerneldoc headers are provided, but not *yet* referenced:
> 
>  `scripts/find-unused-docs.sh`
> 
> HINT: There are many.
> 
> There *could* be and argument to use kerneldoc *just* so you can use
> the kerneldoc checker `scripts/kernel-doc` (which is invoked by W=1
> builds), in order to ensure the parameter descriptions are kept in
> check.
> 
> However, in this case, there are no descriptions provided.  So, in
> reference to my previous question, what are your reasons for wanting
> to keep kerneldoc here?

I think the code did the right thing by keeping them as kernel doc
type comments. What we missed then is getting them used in the *.rst
documentation.

A simple way of doing that could be just adding this to the cpu-freq
rst file, like:

-------------------------8<-------------------------
Here are the bits from the in-source documentation:

.. kernel-doc:: include/linux/cpufreq.h
.. kernel-doc:: drivers/cpufreq/cpufreq.c
.. kernel-doc:: drivers/cpufreq/freq_table.c
.. kernel-doc:: drivers/cpufreq/cpufreq_governor.c
-------------------------8<-------------------------

This will make the script stop complaining about these. But the layout
of things wont' be very nice right now.

-- 
viresh
