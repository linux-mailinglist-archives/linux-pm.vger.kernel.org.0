Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF273A2A4D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJLg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 07:36:59 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:39444 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFJLg6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 07:36:58 -0400
Received: by mail-pg1-f171.google.com with SMTP id z1so136341pgj.6
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAYWQy/NatfpIcXJIRpsRB5B4j7vaD9GdXi8w2oAwB0=;
        b=W5pUG3St5KymyWOc7NfMZB9I5KV6ob7gbyVykdBi9XBvrZtPeYW1ArRBP0hOrligL7
         +aXXVJRJGYssqUraDO+Icq6cABG4gEP2NoqB+z2kSuf2/HJIJjuKNFoyQ0lHOkjtb8Hd
         mQnoyD/K0gdtxbGnlYQF3iPN2MkZuFuKVQvD1VpNX0ytJtnBefV3aFP+/ikMttzukk/M
         s/m+KiBPfs0JDOyxaRvmrWVIBwXTeCwrHoV/CA05rb4vCNvH47tTS1wDO0xpVVQXvPjb
         Vl9vhC8Ays1Oa3KyIr77Gx8LrzT8SMhj6GCCUmUy3h2tXuoO0znhCMi092PiB4WE+kuJ
         DEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAYWQy/NatfpIcXJIRpsRB5B4j7vaD9GdXi8w2oAwB0=;
        b=mcYtmFYaurdLa4c9rveauiyy4+vczO2K2vqtibRZjKDBaDgT4WAQpaGUiICkepseuN
         IwT5PaOsvrFLUgTOGcZr03/Oxfudq2t6zmkIRYBSMsv0jku2ERQAksYBNwcyuB2NU4KJ
         gBpIaRgZU5fGt52fC8o186T2PAUdtLLVT/11ZZ8pRdMopoff1vuzywqyeVqfBYc8LbDI
         /HhNukvPmtiGsG6DhsconFyee1YViNKqU/Vzz9QQGuUIe87F670M0HL+2dTJEzBCTDs0
         ROgFe0af/8QAwxw/JYiBl5hvAobLrw+syUGxmS9qCe3tRJFhRoc23O0nwStLKVIUdhiz
         vQpQ==
X-Gm-Message-State: AOAM531utPdG6v9X5FLjH46LlxlRw9574Bb5IQ3fcapUCa95Fb8zPq4q
        jNv+1hEVvjb/0H8kw2Cm6x28ow==
X-Google-Smtp-Source: ABdhPJx2wjAW6NK3r+kW3K0nffrtvAGOgWQTRJxfHls6ATvVpriTrEbU3Eb3w9qKs+rc2DfC1aZkqA==
X-Received: by 2002:a63:5c4:: with SMTP id 187mr4616940pgf.368.1623324842169;
        Thu, 10 Jun 2021 04:34:02 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id n8sm7738416pjo.1.2021.06.10.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 04:34:01 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:03:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: cppc: Mark frequency invariance broken
Message-ID: <20210610113359.gb2cu3miwuo44d5b@vireshk-i7>
References: <28308fc0d38f252baf90e6ffb31fd2f8660be273.1623311808.git.viresh.kumar@linaro.org>
 <CAJZ5v0i+GvobLS=cM9kc9Cj4BhLcEmTzRoBsRvDqQjLO-o7yGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i+GvobLS=cM9kc9Cj4BhLcEmTzRoBsRvDqQjLO-o7yGA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-06-21, 13:19, Rafael J. Wysocki wrote:
> On Thu, Jun 10, 2021 at 9:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > There are few races in the frequency invariance support for CPPC driver,
> > namely the driver doesn't stop the kthread_work and irq_work on policy
> > exit during suspend/resume or CPU hotplug.
> >
> > A proper fix won't be possible for the 5.13-rc, as it requires a lot of
> > changes. Instead of reverting the patch, mark this feature BROKEN for
> > now.
> >
> > Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
> > Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Well, why don't we revert 4c38f2df71c8 instead?
> 
> Is there any particular reason for retaining it?

I was just trying to reduce the diff size here, since this feature
(which broke) was controlled by a CONFIG option, it looked like a nice
way of doing it.

It was already reviewed and a diff over it should be easier to review.

I can do a full revert if that's what you want.

-- 
viresh
