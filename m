Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3453366C
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 07:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiEYFcW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 01:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiEYFcV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 01:32:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD65E153
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 22:32:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m1so17667061plx.3
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J7vss77naDm9fOC8P6NM8lmEpi8zZTDw8bIiy70a/Yk=;
        b=QzZRuZ+O8qEKTbpPmIUUUbXrrBLOVqJhJZOAMhXHuAPtGk2bgfVMmEjvEAwLAmjVhi
         8uH26rfPd1GE+7T15JAXzaWMH/s8XfjxJv/t+2OFGQN2sWyU6PgKOg/md3mlW2mDmX3w
         rGC0TL9GTHSfr/ULBPy0BmZvwlRcRI7jRTJe66ZwRDuReOri3+8fOSDTUfVNm3uVOowL
         XLcaotd3oOeFnMSRDJZ33qXRHpgel1z5H+XISQXEuB1qf4hna5jf/JOtm6R0i+69h6Ai
         1L051SkoMPRF3LxzXcuEZfquPlZgzPn387N1MX3P37Oc5t+gbIWQYYfPvGxOUVs+sOYj
         jeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J7vss77naDm9fOC8P6NM8lmEpi8zZTDw8bIiy70a/Yk=;
        b=8IbvN/7Sx9oZTz+VOJRiz7kHs5U6VFmbFnwTv08h0VFMm+if5BLYGQFRg22kxy+GJM
         GwfMdbHNsmXmR9tg2mkclve8U/Jlz7eKJXB0gVq4oOelcFo3YyWBRxPKoKbH2eupdzXO
         3/WHGVKY3a6fjhmXT08C3fMZGAqq2uw9kP21B5VxobRrKmUtU8ALyjjOj//TFuVjFTkg
         krqtRt3BCt8bAuen+WcXepqXPPWKq4/pKoZmViq/RkcdORl6gN0Is/3WQfzQxjNauUAf
         RWj4yQQ/XSSWzdjc1AHidUir6jT5n4i+ds9QTxTAfG9GMFAfoOm+4t7oCimnJFJPaDaB
         SyWg==
X-Gm-Message-State: AOAM5327b4qhsWBE8ZK8FxrHKLcEO9sSHuvO4wAhytnN7+ft7QYs48FP
        CovZu1tSVWGmDu5A9bGVESUVEw==
X-Google-Smtp-Source: ABdhPJwW6wAS7r5lkC8egFCajgrBOfxylUAeXTJOrvLyFboVjNjDIcQ9pepyrfHpO2G5R/dQLN6rnw==
X-Received: by 2002:a17:902:6b42:b0:15d:3603:6873 with SMTP id g2-20020a1709026b4200b0015d36036873mr31237100plt.30.1653456739137;
        Tue, 24 May 2022 22:32:19 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902f60900b0015e8d4eb2adsm8165528plg.247.2022.05.24.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 22:32:18 -0700 (PDT)
Date:   Wed, 25 May 2022 11:02:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220525053216.yw4asdj3ynf7fzwo@vireshk-i7>
References: <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
 <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
 <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
 <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7>
 <20220524111456.hw4qugsvt4bm7reh@vireshk-i7>
 <CAJZ5v0i_qpcaUwdZY=KR_e=HC6MZUw2aDGL=hxgo866dF1zwOA@mail.gmail.com>
 <20220524112917.apcvvvblksg7jdu4@vireshk-i7>
 <CAJZ5v0jRtYcscWjUras9RC9LOTHf=qu1SPBhnC=52Gb3KKAQNw@mail.gmail.com>
 <CAJZ5v0hHcW-JkXyOZ7ftR+sUQxysEV2--j29owdojYbg_dR_iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hHcW-JkXyOZ7ftR+sUQxysEV2--j29owdojYbg_dR_iw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-05-22, 13:53, Rafael J. Wysocki wrote:
> On Tue, May 24, 2022 at 1:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > So this was done before the entire CPU hotplug rework and it was
> > useful at that time.
> >
> > The current code always runs cpufreq_set_policy() under policy->rwsem
> > and governors are stopped under policy->rwsem, so this particular race
> > cannot happen AFAICS.
> >
> > Locking CPU hotplug prevents CPUs from going away while store() is
> > running, but in order to run store(), the caller must hold an active
> > reference to the policy kobject.  That prevents the policy from being
> > freed and so policy->rwsem can be acquired.  After policy->rwsem has
> > been acquired, policy->cpus can be checked to determine whether or not
> > there are any online CPUs for the given policy (there may be none),
> > because policy->cpus is only manipulated under policy->rwsem.
> >
> > If a CPU that belongs to the given policy is going away,
> > cpufreq_offline() has to remove it from policy->cpus under
> > policy->rwsem, so either it has to wait for store() to release
> > policy->rwsem, or store() will acquire policy->rwsem after it and will
> > find that policy->cpus is empty.
> 
> Moreover, locking CPU hotplug doesn't actually prevent
> cpufreq_remove_dev() from running which can happen when the cpufreq
> driver is unregistered, for example.

Right, we can get rid of this now I believe.

-- 
viresh
