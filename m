Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E133BC81B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGFIxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhGFIxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 04:53:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B8C061574
        for <linux-pm@vger.kernel.org>; Tue,  6 Jul 2021 01:50:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 62so12653667pgf.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jul 2021 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p1u5Zxt+S039hPvzr3f6QxZq1mwtH1pk7RV6pkg6rpI=;
        b=JGmQ8HTKmWfUcVb6Tjlaym8ZXNNqhl8XclE5ucx2tdYSQFD1vOnge/1A58114OLYTX
         2Ki52SvUfPS/NA5ppiihLQoCKP2+8mTXnVx39CDgx3NIzoJzlnN8OblYa6I4BZLCu0Zn
         S0Tzjkv28rKuQtrc6nQiGzzn4hZd8X4eVPZ/XDB32ONHsSq2o7Cw5j4UWd0X2HhUeIcM
         X9FMLkIDlNMhQKMg2lqWnbkNhX0K7htD84960in/hTRxMzkXAZfH48Ke3t24dqPzVn0H
         kB60/KPUbmEuNVyrvyXGaqB4x83SMzGy00WZd1X6cKXum6KoX5m9po9CmZqb9zsKb0ia
         o2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p1u5Zxt+S039hPvzr3f6QxZq1mwtH1pk7RV6pkg6rpI=;
        b=EzHkgwddhRGTyiwx/RYpXFON3qkTTqDpgcE5MMxU8pnGZt1NJvdI2V7glUHdwED3X9
         AR92cgzMXqrDpWZm6SkdCC0OVLWcYbaxVz3NEUmXjwd0jrBWa2WSr8VXAzgtRHwr6EVq
         nkvZsJmvBTjHHny1Xqk5TWVjQHQtQVXO+7MQR+nrk15pne6J88Yi7q2gJhfDaadbRZnj
         2pYx46n3ejpNZe9Hg4tOfkZYO4AqxUg44qntF1M7yNVhrU4s9/HKODimie45TpTvuK9j
         QmBx8wAhRkI8CHBLxPgp6VdrUn1TClPkO381DrZRDcjQIl4w//K7ONva/bRHSaDiyUNI
         ELzA==
X-Gm-Message-State: AOAM5312n/ynuqkI4U7Cb2duIF8eJ6h5mboYdanfwOC4cgQYKkXOhIeH
        HtxVw33VpDHRUrvCYt8oTofDWw==
X-Google-Smtp-Source: ABdhPJxE/7NO5LH7QBGGkgcrZerj7gCBRizvAyElo6+YVtSQP3WxcTDgBtBVSGjB/H9bVjmdBbC12A==
X-Received: by 2002:a63:580c:: with SMTP id m12mr6257841pgb.157.1625561442314;
        Tue, 06 Jul 2021 01:50:42 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id y4sm17170775pfc.15.2021.07.06.01.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:50:41 -0700 (PDT)
Date:   Tue, 6 Jul 2021 14:20:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210706085039.eb7wzc2dpnd2v6yo@vireshk-i7>
References: <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com>
 <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
 <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
 <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
 <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
 <20210706083741.2ihy6wf6bfff6lvs@vireshk-i7>
 <20210706084312.GA219414@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706084312.GA219414@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-07-21, 09:43, Vincent Donnefort wrote:
> I was referring to how letting know a driver which registers ->target() that we
> want or not inefficient frequencies. My proposal was to rely on a
> cpufreq_policy's flag that the driver can read. 

I am bit confused at this point, lets see how it looks eventually as patches :)

-- 
viresh
