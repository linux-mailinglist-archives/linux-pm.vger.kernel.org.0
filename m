Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D27292310
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgJSHkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgJSHkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 03:40:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFF8C0613CE
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 00:40:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so5522722pgp.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ag/JRF53hl/24d8LgF+tPsIRiLpqiB7/nPdIcvK8ymI=;
        b=LjkRYRM93jiOPWZE8K+5mkRVDGsSAuxKV4N6zYZ1rok9GGy76x2KDqDVr4W7VOiphq
         LabuYL4L3meO9HUdfBkFnOuamD/20qyjNgxRkaEi72NROy8/5WwiA9oonGIHx2BLDhsw
         xkXik+SzFSlT8PMmXhsiK11zqPnNybzr0CV8SwV3Y/qGkEj3PITdEI5L/gFpkKN2tFBF
         w4chyuecLZxObXXNfHWdp2xptANqykX6m1zxGsZAZohhMl40fELs4PdWeounwGCRVI4D
         PVGWP0UNaa0ZU+BPYJoshiojMjZuIM0xWE7hnnwhcoe1J0c1TmfmxqIjp6A8DmSWQ0Iv
         XGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ag/JRF53hl/24d8LgF+tPsIRiLpqiB7/nPdIcvK8ymI=;
        b=VeIPfA0bI/XHoDDPdA+OCDOfaL9XJM6mI+PqY9bvf9RaYWQ2AGxF0bTERLl+eH4o38
         UJA1JxcdKBLVE/l3qWDddRMdv3Vkh+zN0v3eXHfdPsfZG6iM/uYV05rM74ybTFgoPMYf
         1a9SOajNrYrmzPlVhbAZ9PnGXcv7T/WGNeM09cDDRsp4J7bv6cwNLfVCfoIzptbrLzVP
         S58liZrvJFkJTYtvf+PbHBUNLsHfV48+HAAWE9GNeWgInCXunW0r38lvc6d+YEzlrKST
         JgpSK65bh+yhsYAiKJN0M2OnkM4aodj4vVyeEGIfEqhVQuf1TAZx6TshGbhFvwga8xTJ
         V9yg==
X-Gm-Message-State: AOAM532WM8JVkvtkN9oQSCRBWHdAQX+JxyL+XQWtpXT7NRcTlvn+yW7s
        EOsfcPaqP7kQh1qQisaOT6MuCA==
X-Google-Smtp-Source: ABdhPJzWusAGH/8TOEyY/iJVPtyWitpV+TQxC1r/p3JRnt7WK0xWB9EZOqJTQKJpDqfwI2D8LiDteA==
X-Received: by 2002:a63:cc53:: with SMTP id q19mr13211292pgi.339.1603093241504;
        Mon, 19 Oct 2020 00:40:41 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 194sm10694048pfz.182.2020.10.19.00.40.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 00:40:40 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:10:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20201019074037.75oueqxny5fhrsxt@vireshk-i7>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
 <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
 <20200730062414.uq3ip7ukpu7nkiyg@vireshk-mac-ubuntu>
 <bc99342a-48ee-ce30-0116-4ba5c76787c2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc99342a-48ee-ce30-0116-4ba5c76787c2@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-20, 12:16, Lukasz Luba wrote:
> Hi Viresh,
> 
> On 7/30/20 7:24 AM, Viresh Kumar wrote:
> > On 17-07-20, 11:46, Vincent Guittot wrote:
> > > On Thu, 16 Jul 2020 at 16:24, Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > > On 7/16/20 12:56 PM, Peter Zijlstra wrote:
> > > > > Currently cpufreq_cooling appears to estimate the CPU energy usage by
> > > > > calculating the percentage of idle time using the per-cpu cpustat stuff,
> > > > > which is pretty horrific.
> > > > 
> > > > Even worse, it then *samples* the *current* CPU frequency at that
> > > > particular point in time and assumes that when the CPU wasn't idle
> > > > during that period - it had *this* frequency...
> > > 
> > > So there is 2 problems in the power calculation of cpufreq cooling device :
> > > - How to get an accurate utilization level of the cpu which is what
> > > this patch is trying to fix because using idle time is just wrong
> > > whereas scheduler utilization is frequency invariant
> > 
> > Since this patch is targeted only towards fixing this particular
> > problem, should I change something in the patch to make it acceptable
> > ?
> > 
> > > - How to get power estimate from this utilization level. And as you
> > > pointed out, using the current freq which is not accurate.
> > 
> > This should be tackled separately I believe.
> > 
> 
> I don't think that these two are separate. Furthermore, I think we
> would need this kind of information also in future in the powercap.
> I've discussed with Daniel this possible scenario.
> 
> We have a vendor who presented issue with the IPA input power and
> pointed out these issues. Unfortunately, I don't have this vendor
> phone but I assume it can last a few minutes without changing the
> max allowed OPP. Based on their plots the frequency driven by the
> governor is changing, also the idles are present during the IPA period.
> 
> Please give me a few days, because I am also plumbing these stuff
> and would like to present it. These two interfaces: involving cpufreq
> driver or fallback mode for utilization and EM.

Its been almost 3 months, do we have any update for this? We really
would like to get this patchset merged in some form as it provides a
simple update and I think more work can be done by anyone over it in
future.

-- 
viresh
