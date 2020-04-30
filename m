Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8081BF1DD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 09:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD3Hx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgD3Hx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 03:53:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE63C035494
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 00:53:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so377456pjt.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kG8gxxShO/ZQhCVTu79MXllzxxRhWUROOMH4XeWOBIo=;
        b=PKeLiGXUA4odheuCOywjcjg5uNgODSCQFNSlQQE+92Z5Pz1kC2KBwFCBfGbS3B0AMG
         SJR5F6Ltj/XdoVo8dxh/txZW1JV5a4dPakAC2FMBeH/ZcVMujxkY78e6MpI+bguLRJHK
         0c0ZBndbA+al3r0fnuGeOKNwt8jM1ZIq3QpgiPD8Q30y54hmob/xloHvcTdgkv8rQEHO
         fk7IP0s7X8uHp1Y219FGypcyMqJKNdCmWnvycsxQsaJEU9Q2fIoyNINRmitgO9ICPNw9
         jOIIvDzq3Pele6Z+9pgP6Qsa0KzopjHntNX++q1A9mNLBySYNvZsn9i6ZwMEZy7zC7mB
         0fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kG8gxxShO/ZQhCVTu79MXllzxxRhWUROOMH4XeWOBIo=;
        b=hc4DE3TMXUdO67jtNVHROYS4tr1c70JZ1AWj5Kpnq58jA+hkgqLDRREvevZ5sLINi+
         yTRx3BOrM5UG8IK7cwi/RLTG7TKiZRlH0Cisd6vE+DaF4Q8hCd+v498aWlkegOAGIN3w
         GNLmj4Rz9WRRWUsPczx6WsNOfrD8ARzrnx+7ZjC8KhNCnJHKKthd9PvdarIDqkXUTp1L
         PEy9Ixc7rlFF/FNegoSoAF5lgAFIt0KtPP9eMBMdJIfJeRFC2YpPOYHo0X9HiiLJ4Eqt
         dhpZtlgxIpdQfP6Ns1WcYFS+KTxonE4jUNWRbEWBMzLPqPfod+T8VKoRuNEyuReK63Lq
         iUNg==
X-Gm-Message-State: AGi0PubrVjMqwcLeVOVZnj8V3644tx7dLk3FN9YDPvXdgv1WUXYIitR8
        1Sk4paiI91WaIzRXq4x+iTioPA==
X-Google-Smtp-Source: APiQypKL0XTZRutxcUdK04koig/l/oiYa+fGs3Nz3+weSHu7hACweER1oNgsKvxdySh7mi63MCLnnw==
X-Received: by 2002:a17:90a:d808:: with SMTP id a8mr1513940pjv.6.1588233238830;
        Thu, 30 Apr 2020 00:53:58 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id l1sm1073995pjr.17.2020.04.30.00.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 00:53:58 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:23:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
Message-ID: <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org>
 <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
 <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-04-20, 00:35, Saravana Kannan wrote:
> On Wed, Apr 29, 2020 at 11:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 24-04-20, 14:18, Saravana Kannan wrote:
> > > My only comment is -- can we drop this patch please? I'd like to use
> > > devfreq governors for voting on bandwidth and this will effectively
> > > override whatever bandwidth decisions are made by the devfreq
> > > governor.
> >
> > And why would that be better ? FWIW, that will have the same problem
> > which cpufreq governors had since ages, i.e. they were not proactive
> > and were always too late.
> >
> > The bw should get updated right with frequency, why shouldn't it ?
> 
> I didn't say the bw would be voted based on just CPUfreq. It can also
> be based on CPU busy time and other stats. Having said that, this is
> not just about CPUfreq. Having the bw be force changed every time a
> device has it's OPP is changed is very inflexible. Please don't do it.

So, the vote based on the requirements of cpufreq driver should come
directly from the cpufreq side itself, but no one stops the others
layers to aggregate the requests and then act on them. This is how it
is done for other frameworks like clk, regulator, genpd, etc.

You guys need to figure out who aggregates the requests from all users
or input providers for a certain path. This was pushed into the genpd
core in case of performance state for example.

-- 
viresh
