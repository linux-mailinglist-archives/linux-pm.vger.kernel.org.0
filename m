Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00DC1DB06B
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETKlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETKlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 06:41:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A1C061A0F
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 03:41:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n18so1361385pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vu4oMQkSuoGOXfFHpOqFu4wgCH5lCjTUemxJNi8wieQ=;
        b=UhlRLXYYEATpth6j1TeIipbgC/1L2D7NAaUOXXURlOHPJLah1s/8sUAoOVUDVuS01c
         A3qQfCauN38n/MizGoFoUKQ8dcXZLgyGaJJS0iSq4GnK9Ppx9ZqHnvcmoypUiw6WJ+KP
         syH9nZTcYVzfQJb9CNNxUcsuelHIm6RyxF78uPDIdTjwEVGUPOdqdoWpwCKe6peFWs7z
         ANAcLGlyaQhg1Jy/Nbbq12ZAFILiKn8/1g1gDk0vmmoZhbVZqLyd9iGsUY1DidR3lwci
         19Dwm7b+ku5B+5xT6WRw+LKqfaXJAH9W7EQuWKFEtCNXewO9mX+0TOkZqaOqbc59iYtB
         Rw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vu4oMQkSuoGOXfFHpOqFu4wgCH5lCjTUemxJNi8wieQ=;
        b=KUoW7oNxmI+Rm2+FhQ6y3xKHpUW2iUdGFhS4HoXnOgjKlwjXiWpTi7g3rQac0OZCZK
         27PfoTD0PWakTi29UArczcMQy3118HNzgmwNGrqJg/RNwGczSK2RuzaxMYq4SnH9D7/e
         YwEx+qzDtD+S8wYnDXlhRpH5GOjqnwhk6W2gZvFEon9yV2qJMQkrr7A+4hpazNtSZkkQ
         YHSnzwOarHPkmqALqsI+Vvj5XyKWf/X2j7jFV/GHKVveLWUfBLeU+liOSaQ0WoCiqUun
         v1Ot/i6hhXIkZM2g9Zvxx2TDxF5qHS0Di/NwCvVAquQiMnXe/UfwjUjQKnV49eJNZrTU
         1uRA==
X-Gm-Message-State: AOAM532nt6B5Ec5BbXjAhQAgAK5LIM7FolqkdJxXKS0xD7jNa6svaJ2N
        XrAmlz7c0yRjPbm0zfWFWMS8mA==
X-Google-Smtp-Source: ABdhPJxQQ1pFsaJADTmPZi0u3cSTXP5ZH2PUQJLqTJo8h3/YhhA4y+qDzvJk/4aSW+rSWdBpctZ1vQ==
X-Received: by 2002:a63:5864:: with SMTP id i36mr3454636pgm.231.1589971271703;
        Wed, 20 May 2020 03:41:11 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id d20sm1710031pgl.72.2020.05.20.03.41.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 03:41:10 -0700 (PDT)
Date:   Wed, 20 May 2020 16:11:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Thanu.Rangarajan@arm.com, Sudeep Holla <Sudeep.Holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 1/2] cpufreq: change '.set_boost' to act on only
 one policy
Message-ID: <20200520104109.b7vrp7stnyopmwr6@vireshk-i7>
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com>
 <20200520045911.amww3nm3e7cezcbf@vireshk-i7>
 <CAJZ5v0gooW-qN0s03rU9ksxsNvxU4ZSZgXGSGaEcg-s16TnvUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gooW-qN0s03rU9ksxsNvxU4ZSZgXGSGaEcg-s16TnvUw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-05-20, 12:36, Rafael J. Wysocki wrote:
> On Wed, May 20, 2020 at 6:59 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 19-05-20, 19:41, Xiongfeng Wang wrote:
> > > Macro 'for_each_active_policy()' is defined internally. To avoid some
> > > cpufreq driver needing this macro to iterate over all the policies in
> > > '.set_boost' callback, we redefine '.set_boost' to act on only one
> > > policy and pass the policy as an argument.
> > > 'cpufreq_boost_trigger_state()' iterate over all the policies to set
> > > boost for the system. This is preparation for adding SW BOOST support
> > > for CPPC.
> > >
> > > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > > ---
> > >  drivers/cpufreq/acpi-cpufreq.c |  4 ++--
> > >  drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
> > >  include/linux/cpufreq.h        |  2 +-
> > >  3 files changed, 30 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > > index 289e8ce..b0a9eb5 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -126,7 +126,7 @@ static void boost_set_msr_each(void *p_en)
> > >       boost_set_msr(enable);
> > >  }
> > >
> > > -static int set_boost(int val)
> > > +static int set_boost(struct cpufreq_policy *policy, int val)
> > >  {
> > >       get_online_cpus();
> > >       on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
> >
> > I think (Rafael can confirm), that you need to update this as well. You don't
> > need to run for each cpu now, but for each CPU in the policy.
> 
> Right, the caller will iterate over policies.
> 
> Accordingly, the CPU hotplug locking needs to go to the caller too.

Hmm, why is that required ? Can't we call boost_set_msr_each() for all
CPUs of a policy under the locks ? And then let the next call take the
lock again ? I thought we don't want a CPU to disappear while we are
trying to run boost_set_msr_each() for it (or miss one that just got
added) and that should work with the locks being there in this routine.

-- 
viresh
