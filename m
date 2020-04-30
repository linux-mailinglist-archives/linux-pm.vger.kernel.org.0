Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25E01C0296
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgD3Qcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgD3Qcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 12:32:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16656C035494
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 09:32:54 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so122263oif.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZsclabnnR3wKrS78Exn79EM/lt2n7ZZyGteRGUsI8A=;
        b=JUYJmd1MBGqCas674WTA1IWfQlE/kGTREfBIK5mpDA0GKQCWA5TWrInT5xqa+cty1P
         1uf7jMp4ptZNe61WpozNUpn19cau+2xAsPJezxaJ/YkNvLq0Y4Ke8RMtVAAA6GGjYHiE
         gScspZIdHjRYqpJ2Uno+FQWJL/XiblVg/Mi22ewLmBd/WxxJ9smUOoHF9lr4DrqqMmAI
         C9OI28yxF+GzrKoTO+j1owgWEJOGkNwuwuNh8Zj6Tpvn/9KtPJiufeBqwE3ogh5pXqwf
         6/YLrVQoTxsZzAQIfZM8oI6/JkLwFFLp8PmBtms1w/jVWbOij59zxxdfJnRIZKaW6HD3
         p3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZsclabnnR3wKrS78Exn79EM/lt2n7ZZyGteRGUsI8A=;
        b=p6M3BSOZToESmC7tIOBAaWfHLEyyFLIBR6IlbPM5wK8z1S8bcQxexnAKz2QUneME/g
         grj2mR1wGb10cwWL/dDMhk0y6DvAVTQqKYNmkyIN35BAltP9batw8cPju5FXc2H1zyw0
         sfqrURw1Ub8O9q03925xEMgoyF9PWRShXOfjUJkW7F89yn3eLKuLJRMPc5+RaUYrtCMe
         txIWt+mGf3s6ukd4pVqW34P6n//ncdz+sOdxHm31+diIdOpJMaS572EWmxKYNt8Ky5Dc
         0RtS3lputLeeQ3Fb0qX//WLHAf6P9twcggN8857x2pMED1Bggl7iOVUNj8H7XxiRJ+YI
         s/oA==
X-Gm-Message-State: AGi0PuYSR/1uFx/M46SSFRySNSVKTMVTYEd+qlrT3W3P2WOEPuYvlrvY
        3iDzMbxg/bSEM5gbd3jdNS54011p2wLC7ALb96sSWA==
X-Google-Smtp-Source: APiQypJprzA/+arNVWPUX0khphDyRoZS8i1qOaFeSW8at+OIuNhknrJDu20eedqo9Mv1KETW0rnGhGJV0oxQ/gnyTBI=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr36776oic.172.1588264373140;
 Thu, 30 Apr 2020 09:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org> <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7> <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
 <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
In-Reply-To: <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Apr 2020 09:32:17 -0700
Message-ID: <CAGETcx-W5XjNtgjDz2Ma_miN=cUBb5LFfhzYtKRpf6iAi4bXNw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 30, 2020 at 12:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-04-20, 00:35, Saravana Kannan wrote:
> > On Wed, Apr 29, 2020 at 11:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 24-04-20, 14:18, Saravana Kannan wrote:
> > > > My only comment is -- can we drop this patch please? I'd like to use
> > > > devfreq governors for voting on bandwidth and this will effectively
> > > > override whatever bandwidth decisions are made by the devfreq
> > > > governor.
> > >
> > > And why would that be better ? FWIW, that will have the same problem
> > > which cpufreq governors had since ages, i.e. they were not proactive
> > > and were always too late.
> > >
> > > The bw should get updated right with frequency, why shouldn't it ?
> >
> > I didn't say the bw would be voted based on just CPUfreq. It can also
> > be based on CPU busy time and other stats. Having said that, this is
> > not just about CPUfreq. Having the bw be force changed every time a
> > device has it's OPP is changed is very inflexible. Please don't do it.
>
> So, the vote based on the requirements of cpufreq driver should come
> directly from the cpufreq side itself, but no one stops the others
> layers to aggregate the requests and then act on them. This is how it
> is done for other frameworks like clk, regulator, genpd, etc.

You are missing the point. This is not about aggregation. This is
about OPP voting for bandwidth on a path when the vote can/should be
0.

I'll give another example. Say one of the interconnect paths needs to
be voted only when a particular use case is running. Say, the GPU
needs to vote for bandwidth to L3 only when it's running in cache
coherent mode. But it always needs to vote for bandwidth to DDR. With
the way it's written now, OPP is going to force vote a non-zero
bandwidth to L3 even when it can be zero. Wasting power for no good
reason.

Just let the drivers/device get the bandwidth values from OPP without
forcing them to vote for the bandwidth when they don't need to. Just
because they decide to use OPP to set their clock doesn't mean they
should lose to ability to control their bandwidth in a more
intelligent fashion.

-Saravana
