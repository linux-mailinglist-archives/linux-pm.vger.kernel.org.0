Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7D3B41B1
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFYKdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 06:33:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhFYKdV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 06:33:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E888ED1;
        Fri, 25 Jun 2021 03:31:00 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E8BB3F719;
        Fri, 25 Jun 2021 03:31:00 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:30:58 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/4] cpufreq: cppc: Pass structure instance by
 reference
Message-ID: <20210625103058.GC15540@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <b910f89cf11f6916319f9a2fb48d9146005318b1.1624266901.git.viresh.kumar@linaro.org>
 <20210623134533.GB12411@arm.com>
 <20210624022252.zrxsftrvcd43eqra@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624022252.zrxsftrvcd43eqra@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

On Thursday 24 Jun 2021 at 07:52:52 (+0530), Viresh Kumar wrote:
> On 23-06-21, 14:45, Ionela Voinescu wrote:
> > On Monday 21 Jun 2021 at 14:49:35 (+0530), Viresh Kumar wrote:
> > > Don't pass structure instance by value, pass it by reference instead.
> > >
> > 
> > Might be best to justify the change a bit :)
> 
> I had it and removed later as I thought it would be obvious :)
> 
> > For me this is a judgement call, and I don't really see the reasons for
> > changing it: we don't care if the structure is modified or not, as we're
> > not reusing the data after the call to cppc_get_rate_from_fbctrs().
> > More so, in this scenario we might not even want for the called function
> > to modify the counter values. Also there is no further call to a function
> > in cppc_get_rate_from_fbctrs(), that might require references to the
> > fb_ctrs.
> > 
> > So what is the reason behind this change?
> 
> How about this commit log then:
> 
> Theoretically speaking, call by reference is cheaper/faster than call by value
> for structures as the later requires the compiler to make a new copy of the
> whole structure (which has four u64 values here), to be used by the called
> function, while with call by reference we just need to pass a single pointer
> (u64 on 64-bit architectures) to the existing structure.
> 
> Yes, on modern architectures, the compilers will likely end up using the
> processor registers for passing this structure as it isn't doesn't have lot of
> fields and it shouldn't be bad eventually, but nevertheless the code should do
> the right thing without assuming about the compiler's or architecture's
> optimizations.
> 

Yes, that's why "judgement call", which I'll let you make. The code is
sane and I like the longer commit message.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

> Don't pass structure instance by value, pass it by reference instead.
> 
> -- 
> viresh
