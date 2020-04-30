Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9B81BF19D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD3Hfu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgD3Hfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 03:35:50 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5DC08E859
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 00:35:49 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m10so4417121oie.6
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs31g31s4Qup1BiKCc2DuRtqM2XedKFVg5N5v+BZjjw=;
        b=SicuVYS5fp0fa/wzv+q09rX6oQxgNmClx4f49iFcA5bDwQqCogfhamiVVpkdy0QlsF
         ae2KdpL6Mq+vPjWq/ZPYZD0ac60feHz/OOkbVGO55xwzQgCIGJ5rzD7n4sYr5kl4TlEp
         wH2/j7ymvRCJMxLbnipbZWJ8zIBG/Tv/jUppjIaLk03n1xDbd1/77ztyxWdT7eKEPCjx
         dQp1Sgf9DZdRh8mwUC9Bgk3OPPMmpMqiuy6smhEU/FwS1srovO5NAs/NFGak/WaGLQ4a
         envkNnbxsbFhwALdCNKh73IEILCjujXDrRdFoWIqfr0vWIhEddXSJ1Wzw2YR0cO3KLMw
         B0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qs31g31s4Qup1BiKCc2DuRtqM2XedKFVg5N5v+BZjjw=;
        b=Z3vLDzBHyBH0K7SH75azoFGq0QyS45yzk/ci5iAZ7IopFsjkzvrEXkWiy5iaymwAWI
         U9sXgWE58/0DdsyEsfGj78K8Wjf9/K17+MxkjbkZBRcUyFB+8pSdnmV56OIqWqY22BH6
         vfRW26B0reOw2rWPYXh/MDDmPROSgZ8euCHjllNn3IUG5Ov4Srpq8ZkKEivUCp53ZxuQ
         el7PE5IjSyLVfy7zBh+TOmZBM89wjQ5d03yX+OgPzWmh7kmJaKZtoesuVYzhGOFmG2Qb
         mzh/zSYVWpn9nIuqzVdpc4hmWI+mS2U9tPVr52sG1P5WBH3yc2GXMMxeO/e2ldxIXD73
         TviQ==
X-Gm-Message-State: AGi0PuYOJWxvEemDe9JzGIbrZEM41b5LBzj7i/tiJl8LAVlPGQ6rjUAX
        XeJS9BxnZFl+kbqqfGw8WFUtAseGSf0tP9PcDETpnA==
X-Google-Smtp-Source: APiQypJSVbEeLdKvSzeK+HnDLd495hRaTsKPEMdbd300IaB2PC5hErDtAPw/RD9fpBoG5vAHd3mduLUJ3j8aWN9Hbk4=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr827526oic.172.1588232148850;
 Thu, 30 Apr 2020 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org> <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
In-Reply-To: <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Apr 2020 00:35:12 -0700
Message-ID: <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
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

On Wed, Apr 29, 2020 at 11:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-04-20, 14:18, Saravana Kannan wrote:
> > My only comment is -- can we drop this patch please? I'd like to use
> > devfreq governors for voting on bandwidth and this will effectively
> > override whatever bandwidth decisions are made by the devfreq
> > governor.
>
> And why would that be better ? FWIW, that will have the same problem
> which cpufreq governors had since ages, i.e. they were not proactive
> and were always too late.
>
> The bw should get updated right with frequency, why shouldn't it ?

I didn't say the bw would be voted based on just CPUfreq. It can also
be based on CPU busy time and other stats. Having said that, this is
not just about CPUfreq. Having the bw be force changed every time a
device has it's OPP is changed is very inflexible. Please don't do it.

-Saravana
