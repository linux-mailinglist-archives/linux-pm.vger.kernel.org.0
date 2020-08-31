Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2732575A7
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHaIl0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgHaIlU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 04:41:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72368C061236
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 01:41:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c15so2700571plq.4
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eYb5KpT1V07RPnlSuRsMWwBmtGIT5ttBS72iMXyylIc=;
        b=c9DSp+F/t4Lv/naJp2z8zanWeIlwgvVuwoKE5H7UcvekIrgvh7vO/uqf3/+c8tUpgR
         r/z3VIZJphzh0KSYCvPPKNv8PglIG7J2wkU8Y96/WoTTK4DZVBjrjq+uWQ2s5oKVHLsO
         sn/cYjp8yLJoJAg3yeU1AZ9/nHY7VEG6bDh4sPzEv3leruDXjHOZ7eAXFo/ORUVvNFXB
         ELX0HnU/KYt38VTTVqmzYdumStOxWDB/C3JvhFKYoMoejdUJDRGMoN08PkEz6mwCtyJ6
         qeSEBfDhuKjtPIyRG+xsw05nsIPWsxaPkM9y8R9WKZisjHx7cFS2PbFEUgvNomuIuzyM
         ecyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eYb5KpT1V07RPnlSuRsMWwBmtGIT5ttBS72iMXyylIc=;
        b=sqz+pql9N4kA/7Lmw9HVy9BXHjZPQOAZAZt9/I7CYuKcCHqsLSVua4XMvalhS+Hams
         k9VmWrdO6SmIqTtfqISJAHoTMCc26ZzlG0zeMV4TJSt+fvgLsPazT3xUoIyTEwNfBCzM
         IzBG4WnYUpxkXB3qv8OviHKJgWMcW+W7s1uSWjcYGEsYj0vtuR86J6R5ea/qQP0JTB5w
         aZyEwzdUbCinitGxIE1X3BajQpcvocNqrAyzoTZNBn0aePY8SdjGShyFWHgcaQdxo3VT
         zUQH2gDy3itrHIqaR8jeiZEJZTe/bsbr8/bROVXXUvZVIHQTe9RLVGobGMI1fVberkxh
         XxvA==
X-Gm-Message-State: AOAM531o56i+VaZ3G5UPoV1z7OsXDIS9LTvOONw3SOhqD359encdefOS
        gjUarpGCbWUdZMbZXbpsRiAv4w==
X-Google-Smtp-Source: ABdhPJzVGSLNLHl/Fg5vdyWAY70juhup0Vyl2NaEKnZepVk/rNvw4WAFyMHDYLPrAJz6toDsdvf2eg==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr429283pja.56.1598863279409;
        Mon, 31 Aug 2020 01:41:19 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id o23sm6939940pgm.18.2020.08.31.01.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 01:41:18 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:11:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
Message-ID: <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
 <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-20, 10:54, Dmitry Osipenko wrote:
> 31.08.2020 07:39, Viresh Kumar пишет:
> ...
> >>> Dmitry, I think there is further scope of simplifying stuff here by
> >>> using the opp-microvolt-<name> property and corresponding
> >>> dev_pm_opp_set_prop_name() call.
> > 
> > Any inputs on this Dmitry ?
> 
> Could you please give an example?

There are many users of it in the kernel. grep for "opp-microvolt-" in
the DT files and you will see.

The use of this property is to specific multiple microvolt properties
to the same frequency without a need to create separate nodes for them
all. The right microvolt property will be selected based on the call
made to dev_pm_opp_set_prop_name(), search for that too in kernel.

-- 
viresh
