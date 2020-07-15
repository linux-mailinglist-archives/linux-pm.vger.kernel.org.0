Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAD22055D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgGOGrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgGOGrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:47:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98560C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:47:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so1239818wrs.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RZua3L7ORYc/5yUTlbkpDQCk3pb0Hn/UmvH2O1LP5AI=;
        b=ycVggVFoo6iBM+WvMNC2erRI9VWkQ3uaqCbF2FKH68DO8rPcaAcXiE2qqS4E1N2xtv
         ygG7TcXaU16EgP6eun5Ezs28IfNyjcihAsjXca4TBLPJ8iuVHbX3NWFi54yXJ6lWZf13
         a1HYlLNDv1IWnh8YXyt/G/8PAKiz5Gheg6/04cL+tKh3rlz/VouvO1IWuW1mZSMf/g/V
         +FhNs5U4qAtD2z2J9lQzSsRMeFqwLLJwvJZgcAy5tnyDU8of9oWvKiz2j3IxI7p6nvkO
         afB4OYlF210oK1fWU66gwAoiOZPZTg+ynQXki+DwQ46cAsufP2Rtjo9Znbc2XH888z+S
         awNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RZua3L7ORYc/5yUTlbkpDQCk3pb0Hn/UmvH2O1LP5AI=;
        b=Pu2eiNdN/7Bp1xGc3r4EkDVOC62ZBVq8MO7eRZtQPKTBExm/g+2i3+b/WCbeo+JsvZ
         4XIysOy5fklCiXzZICUOtgjHT/0i6H50671aTUzo5oAX5gFXmAQ+b2ieYqPQVQMY6Iis
         HmcT8wwWGoYAVDQUAFcPjru6BXBhD0CMfAZhh71li2tBSlIO54y7+bIANFcmHlxSuXfW
         gXCsWS+j8tJ7g0/N4mkkZn2IkAfbyaC4g8J/SR5Tz8XvOzo6hvDxMia7+/peBhW4//N7
         x41JMP6Ev61gDLMU4Xq13HaDuZLzAXWRDKcSuEUh06v/a3ZIQlqtLRS9ySbB5nGK7JxP
         rnfA==
X-Gm-Message-State: AOAM531TQ8/YTNKtAH91THiEUDU1qfX/Nawx3hXzjTvPSLIKf0xuS430
        2wt98l8An2BuJQRIEqa1CrZ/U6WhFH8=
X-Google-Smtp-Source: ABdhPJwL5CBSF/GH6b4IIcV8l9IUoX2Ms8UjECSbuxp10q/Zf7L2cyBkfhgyHbrG9cgcuOUEctEs0w==
X-Received: by 2002:adf:b190:: with SMTP id q16mr9739722wra.356.1594795638330;
        Tue, 14 Jul 2020 23:47:18 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id u20sm1905445wmm.15.2020.07.14.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:47:17 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:47:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dominik Brodowski <linux@brodo.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH 02/13] cpufreq: cpufreq: Demote lots of function headers
 unworthy of kerneldoc status
Message-ID: <20200715064716.GT1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-3-lee.jones@linaro.org>
 <20200715024951.zr36iuagany5ii56@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715024951.zr36iuagany5ii56@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 14-07-20, 15:50, Lee Jones wrote:
> > -/**
> > +/*
> >   * cpufreq_remove_dev - remove a CPU device
> 
> Because cpufreq_add_dev() is part of kernel doc, we better keep it.
> 
> >   *
> >   * Removes the cpufreq interface for a CPU device.
> > @@ -2373,6 +2374,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
> >   * cpufreq_get_policy - get the current cpufreq_policy
> >   * @policy: struct cpufreq_policy into which the current cpufreq_policy
> >   *	is written
> > + * @cpu: CPU to find the policy for
> >   *
> >   * Reads the current cpufreq policy.
> >   */
> > @@ -2759,7 +2761,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_register_driver);
> >  
> > -/**
> > +/*
> >   * cpufreq_unregister_driver - unregister the current CPUFreq driver
> 
> And this should be there for sure.

Where is the *.rst file that references this kerneldoc entry?

Also, what do you mean by "there"?  We're not removing the function
header.  It's still documented, it's just not kerneldoc.

> >   *
> >   * Unregister the current CPUFreq driver. Only call this if you have
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
