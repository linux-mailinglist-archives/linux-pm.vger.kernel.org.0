Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361EA42A137
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhJLJhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 05:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhJLJhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 05:37:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08FC061745
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:35:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g9so2737412plo.12
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1k8Z+wdh4QOPkQnS+F7/9QuIX0JH9DSlOiSZOGiLJ0=;
        b=JPI1N3b7+PMvCr14EefM11K1KWWL9gaM68fMQB7IOAiZNObXnUiboTUHWlnYJDNW4Q
         mAL5untW+5tZk/Drg861zZnJ9H4YHfyVpz6p6D8S9xoKxTdQVHUTycAjL9cKWw8J1PiX
         cinbdgMKzCE4rX5LNwEYerT8da3aVSR2j4wjuDJVPrWYQfsUMfLgK1JDGIjjGZftmbR4
         NfkMIKuopr20cjROoPqyebI1ELIut1t1FrnCNI1rm0SN4UeT0GFxPEmu6D3Mb6gc/vpf
         NvU9Ikd8PH7/TCmv20xvT7bPLqqXs259HgnHrkCC0K33EmuDKKIWryZ0FLbBfB/rBqNc
         UMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1k8Z+wdh4QOPkQnS+F7/9QuIX0JH9DSlOiSZOGiLJ0=;
        b=iGUqq2P59kGUKr0I/7LG6Iut67rqu20hB/trQXwb48nspb+qh2bHRa+iIgCtXySkko
         iqkJNn5SgGbrJw/JntI25HZtoQiGohaSxz9ZdtP9I2xEtx/MWJf/7ATT/iS9kQ6NNayL
         D5qhuliT7abaKt6FS5oYILv+Xr4SJ5LXEcpdDuklwM3Z2BiT4/vOjyGt2OHYpgJ/KUhP
         p2wAr++6f+FkCN7aj1loyFRs8JrqQbRw5f0rSnSlqos3axBpz0hE38kTc2Ruwgu+dJuq
         sTOUHj0kbNznQJY+jhETxtDvpfblG+64XOw8T+OmL6ymKivYqOqViTSTh+E6rdCfqqDR
         FkMQ==
X-Gm-Message-State: AOAM533vK495Id3tku6EtCnTrD8RiuqFEJfp4rp+uWtcM33PTGCid98+
        f7SZJIz7dro+vAE4ddYjnTSM/A==
X-Google-Smtp-Source: ABdhPJwmjNVx5j57L4zEiPRXtEe8aH/7F8Q9b0NO96Wmfmn8nm+42QOAA5HdzvgpsdPfHkHGSn5kpQ==
X-Received: by 2002:a17:902:8494:b0:13b:9365:6f12 with SMTP id c20-20020a170902849400b0013b93656f12mr28929229plo.19.1634031332258;
        Tue, 12 Oct 2021 02:35:32 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id e15sm10067916pfc.134.2021.10.12.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:35:31 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:05:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/9] dt-bindings: clock: Add apple,cluster-clk binding
Message-ID: <20211012093529.pzzfo44ikq5oc6cl@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-4-marcan@marcan.st>
 <0fe602f6-3adc-dfac-beee-2854b01cec5c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe602f6-3adc-dfac-beee-2854b01cec5c@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Apart from what Krzysztof already said:

On 12-10-21, 10:51, Krzysztof Kozlowski wrote:
> On 11/10/2021 18:57, Hector Martin wrote:
> > +    pcluster_opp: opp-table-1 {
> > +        compatible = "operating-points-v2";
> > +        opp-shared;
> > +
> > +        opp01 {
> > +            opp-hz = /bits/ 64 <600000000>;
> > +            opp-microvolt = <781000>;
> > +            opp-level = <1>;

The opp-level thing wasn't designed to work this way, though it may
work just fine. It was designed as a unique key for power-domains,
which don't have opp-hz. The OPP core currently looks at 3 different
values, which can act as a unique key to identify the OPP. clk-rate,
bandwidth and level.

I think this is the first platform which has both hz and level in the
CPUs OPP table. What exactly is level in this case ?

Again, it may work fine, I just don't know where it may end up
breaking :)

-- 
viresh
