Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67E306FC
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEaD3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 23:29:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37288 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfEaD3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 23:29:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so5279947pff.4
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2019 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xnqDdr2i6Tf87P3bIRZEuiZG4fUxfuReHxw3r4p4RC8=;
        b=fBsnocer8Eo0a/7ZyEvb77ep2wXmQNF2ddphCXGtR0y5+sn6HIoTt0yVC4KOD8cUxa
         qXpIgccbgPvVe0OnwST9m/M74rcUUFM/XwjAYZr1xb8t27cdRD0OlNqZQ+VqFd/e4Ixl
         tOqjZIVNDeucsAkU58TcyLlAatlIau55Lt3MT2Amo71qNoLEw84wREUslV9JuGoSVFVE
         xSehbwGds3LND33ak8RKrLpFC0s1lF7SHrHJJLfMUZIUJ7KNICNCjxxnqIhfAc+yuJ+J
         KynfcJXonA62yial/IHpza8IKPtVNPB3YrAbJzKMUQa74uGzYNrDQaKx2mKHoD+Scaue
         LofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xnqDdr2i6Tf87P3bIRZEuiZG4fUxfuReHxw3r4p4RC8=;
        b=DLKF1pS1OYdc2yky3DApsF765HsYGe4n+Ko8hh77EKH4GsK6NVfWG1EI2xodI1s2zi
         jtWcTzpPhUCyBVKvMuJkKc5TsT1s06eUpZADN2nm/nJFqrlNBnCMuDtJIpW6VohRxbNF
         vn8B4OYqjAVG6TVmveQK12iZTlU2l8/BcyiAN+CW8xpu87pb2xXrXkzssUTaDHIKuq3N
         9RASk9HyRZyXgT3KUgh3AgI08ITq/Y8ahSZ+RcKFPPo9DfuTa4Swr7pQKDGCoXRzMjb6
         sIjOdANQQKMWeWgxOAha1I7YabjAWoGJCG1K6UbulTSwhxa0hM8Xfo3cYPpZN3CpfMEj
         LBTg==
X-Gm-Message-State: APjAAAU/koy0Rhx0mVuHqJXRhZ9qyNQmqS+aNnrdsBC4UWHbBvHa2YZy
        Hhk4r79fteyupS9pNhUUm6zrlg==
X-Google-Smtp-Source: APXvYqxsTLouYZB3eteNn2krrJisXBfEBpoWYOTWJAM8j6ndwI/IhwV6+UAuPkSBV5p5JJAAW7PeQg==
X-Received: by 2002:a65:620a:: with SMTP id d10mr6784558pgv.42.1559273340471;
        Thu, 30 May 2019 20:29:00 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s134sm4959835pfc.110.2019.05.30.20.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:28:58 -0700 (PDT)
Date:   Fri, 31 May 2019 08:58:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190531032854.m66ugtyjyjnksrqr@vireshk-i7>
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-4-quentin.perret@arm.com>
 <20190530112747.nlfyctzjkz5lak7o@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530112747.nlfyctzjkz5lak7o@queper01-lin>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-19, 12:27, Quentin Perret wrote:
> On Thursday 30 May 2019 at 10:20:38 (+0100), Quentin Perret wrote:
> > The newly introduced Energy Model framework manages power cost tables in
> > a generic way. Moreover, it supports several types of models since the
> > tables can come from DT or firmware (through SCMI) for example. On the
> > other hand, the cpu_cooling subsystem manages its own power cost tables
> > using only DT data.
> > 
> > In order to avoid the duplication of data in the kernel, and in order to
> > enable IPA with EMs coming from more than just DT, remove the private
> > tables from cpu_cooling.c and migrate it to using the centralized EM
> > framework. Doing so should have no visible functional impact for
> > existing users of IPA since:
> > 
> >  - recent extenstions to the the PM_OPP infrastructure enable the
> >    registration of EMs in PM_EM using the DT property used by IPA;
> > 
> >  - the existing upstream cpufreq drivers marked with the
> >    'CPUFREQ_IS_COOLING_DEV' flag all use the aforementioned PM_OPP
> >    infrastructure, which means they all support PM_EM. The only two
> >    exceptions are qoriq-cpufreq which doesn't in fact use an EM and
> >    scmi-cpufreq which doesn't use DT for power costs.
> > 
> > For existing users of cpu_cooling, PM_EM tables will contain the exact
> > same power values that IPA used to compute on its own until now. The
> > only new dependency for them is to compile in CONFIG_ENERGY_MODEL.
> > 
> > The case where the thermal subsystem is used without an Energy Model
> > (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> > frequency table which is already a dependency for cpu_cooling.c anyway.
> > Since the thermal framework expects the cooling states in a particular
> > order, bail out whenever the CPUFreq table is unsorted, since that is
> > fairly uncommon in general, and there are currently no users of
> > cpu_cooling for this use-case.
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Viresh: the patch hasn't changed much so I kept this, but please shout
> if you're not happy with the new version :-)

Yeah, it  looked fine and so I didn't complain :)

-- 
viresh
