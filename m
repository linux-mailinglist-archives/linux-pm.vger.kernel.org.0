Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FD3EE52C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhHQDmr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbhHQDmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 23:42:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E11FC0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 20:42:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so2754200pjz.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JCOFQBT2H8r+cJYdeiAd3yX79xIHiz7jSYTg79TH8Rw=;
        b=NlkUBJq6j28D7GK7CAAupxV+5tfzRl1Ucoc41Ew3cXEWi2jH4mjRk1YkvUYoUx7zez
         J0qtw4OHsY3c4vNj2606aEZntzQqv/UaLZyu6hLnklVZKhU+oMnc7Ht4GSF4whS6IKrR
         31XqyQNn3IuLIbGBJpd9QB3j2Q6KlxF9Sft+ZArDUu+WcQ46nLWTs4vYwcmCQckS+qUK
         axU8ZcYkgr6+ZL9nIlAvD9ulIlSkcO+IRsvRYlu9jpErze9Xy+AIyS3CXvTLE8m4jtRu
         9TgyjNx4fM6pAoIHI3//UPctkkHXBxmaclE4UZR7tRjsM4ECzBvQT6mZCCMyWhNdQ5ua
         qyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JCOFQBT2H8r+cJYdeiAd3yX79xIHiz7jSYTg79TH8Rw=;
        b=GNE7vMkRBxMKAjev/h32ljkRuLzxiECXCoNlGZMcXn9KzfqalqExc6/EobRTD3kFDQ
         KFOV+cuImVR1REvbYcxn88POk+egW3qr7rS7sQsKbtPFdajPw3FKI36F4EhmUiu2RXUY
         MLnSSUZ/6xsyVRhylnlnUJJddz+dPLXOznh+2veeh3jJ8JYnYIRDmIvoCaYemwEKtSfC
         ArXn2bahRYeko//4FaGscNkGTtnvtwdXKPxZKQPrHxYLZhYnx3m/C8Uq/lRM+GKxsKNX
         uBX6CZCjL7VRjuuac6hrnlUbM1jxvsxeViD15ZMXGPmo5v5XjlwT3ZZfm1xa9u7gxBfc
         IDSA==
X-Gm-Message-State: AOAM5310610DmJMB1hjWot/8ifaxMMcutO/sRIF52D7xp0DsWrfQMiGd
        R9a59lfApsIgcf3YPuYpOWy6Dw==
X-Google-Smtp-Source: ABdhPJyBcs3PMQO6TNBu95yHIEU0AGNrEDxs8TdvoQSKr14DVGi5d/593wOkeOBqc07k1cdbKSyiZw==
X-Received: by 2002:a05:6a00:24c1:b0:3e2:1171:34dd with SMTP id d1-20020a056a0024c100b003e2117134ddmr1484836pfv.27.1629171732105;
        Mon, 16 Aug 2021 20:42:12 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id h17sm601338pfh.192.2021.08.16.20.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 20:42:11 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:12:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v13 2/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210817034206.hmpjdz4bqvwxfn3c@vireshk-i7>
References: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
 <1627574891-26514-3-git-send-email-hector.yuan@mediatek.com>
 <20210803071302.b4ttoqgqdq4dfmwe@vireshk-i7>
 <1629118594.3246.13.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629118594.3246.13.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-08-21, 20:56, Hector Yuan wrote:
> On Tue, 2021-08-03 at 12:43 +0530, Viresh Kumar wrote:
> > On 30-07-21, 00:08, Hector Yuan wrote:
> > > +	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
> > > +		c->reg_bases[i] = base + offsets[i];
> > > +
> > > +	ret = of_perf_domain_get_sharing_cpumask(index, "performance-domains",
> > 
> > Instead of parsing parsing "performance-domains" twice, I would rather
> > pass a CPU number here instead of index.
> > 
> Sorry, could you give me more details? For now, will use index to parse
> per-cpu to related cpus.You mean pass policy->cpu or? Thanks.

Yes, pass the cpu number from policy->cpu instead.

> > > +	latency = readl_relaxed(c->reg_bases[REG_FREQ_LATENCY]);
> > > +	if (!latency)
> > > +		latency = CPUFREQ_ETERNAL;
> > > +
> > > +	/* us convert to ns */
> > > +	policy->cpuinfo.transition_latency = latency * 1000;
> > 
> > You want to multiple CPUFREQ_ETERNAL too ?

s/multiple/multiply/

Sorry about this.

> Yes, may be different power domain with different transition latency.
> > > +
> > > +	policy->fast_switch_possible = true;
> > > +
> > > +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
> > 
> > This is a small structure, why not allocate it on stack instead ?
> > 
> For qos part, we'd like to take more time to re-consider the SW flow and
> put this to another patch set.Is this okay to you?

So you will drop entire qos stuff ? Fine by me.

-- 
viresh
