Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF246305254
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 06:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhA0FqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 00:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhA0Eax (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 23:30:53 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD8C06174A
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 20:30:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so714700pgo.6
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 20:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=//ioNvWDQkvk42Fc89Zh4vygy6z/RRR07z1hB6ofzIU=;
        b=d3GR+gHmnaa96Nm0QcKgBXmK3NGGMKMwA33oyu6d7nrqpoeQY+1ytoD4gwsnG1vqfY
         TY/HPQ7TS8N7jTwjK+vxUfiRVR1YpM43Br5CXg9JWVgPt1d7sV6EYtL6cQV6ISSbTHfg
         m54M+yzrLlRq7bNu167pbivdFiYFw2H6fi5lqieiqc29Wp+txQhPG2FMsvmC2a9AaNKE
         xfi593mYnvYKMeb7gRwZgmLR4u+ScXbnIabpUw1jz5coZnfIjOViHg8BB7nrHDGDkxEF
         UsZXFq/187R3pD6qVIYH8eKwX0DI9tibhvmOlEodYAOj7gL35FyEh6hQ7809px5Jmqbh
         SYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=//ioNvWDQkvk42Fc89Zh4vygy6z/RRR07z1hB6ofzIU=;
        b=XKK3sAjZkmMO1es2qoDtRGK7qyXCPxqFKXl/oPXQ14qHi0xAAzNeXpvU1r5vNK4w7/
         N6j5cLuS6ptwcNXrGmJ+Qdi9SOUe0Ne/U8QnI/mrtRbMCj9X+RaEm9HE1DULFhzj2+Ib
         g0NCY3iJ9LR7/0Z1rLMVj5VYryGkrqNj1EQPIWSDUG0EgktCwDc4q760qgObl0FFBOyu
         XzmdR0aRnEPkq678/rUAA8whsMqSrFCOc3BwsdfzDwEd9g4TspkUk4BKUNY6a+EVD+qe
         WxVt7IcbpfvfEJfE7RS5plhijPbdIjcE/Nn/L0yABDdp5L3SJua/Jsl/N1Ty+6Fw6f5K
         aZMg==
X-Gm-Message-State: AOAM533BmPPl1rZ+B3yr7/1Mj+W9B/gPNBOq+jrcBXOnQxxk+xNrtHGL
        04iv5Q0VysuPB/F+eoRy/3ZOhQ==
X-Google-Smtp-Source: ABdhPJyqKTCjg4RoXfa5PGfc0trCuDCoxGmhg6h3Uthbq8A5dQcjfqyDV5/szcFEstejMp18qWeXGw==
X-Received: by 2002:aa7:8d86:0:b029:19e:cb57:2849 with SMTP id i6-20020aa78d860000b029019ecb572849mr8603482pfr.54.1611721812500;
        Tue, 26 Jan 2021 20:30:12 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 17sm533107pgy.53.2021.01.26.20.30.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 20:30:11 -0800 (PST)
Date:   Wed, 27 Jan 2021 10:00:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] opp: Add dev_pm_opp_sync_regulators()
Message-ID: <20210127043009.rwy4l3u7fohlibec@vireshk-i7>
References: <20210120222649.28149-1-digetx@gmail.com>
 <20210120222649.28149-3-digetx@gmail.com>
 <42abee3f-ce18-7930-b584-17ae69bdc498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42abee3f-ce18-7930-b584-17ae69bdc498@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-01-21, 01:30, Dmitry Osipenko wrote:
> 21.01.2021 01:26, Dmitry Osipenko пишет:
> > Extend OPP API with dev_pm_opp_sync_regulators() function, which syncs
> > voltage state of regulators.
> > 
> > Tested-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/opp/core.c     | 41 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  6 ++++++
> >  2 files changed, 47 insertions(+)
> 
> Hello Viresh,
> 
> This is the last patch that is left unmerged from this series. We will
> need it for implementation of the PD driver for NVIDIA Tegra20/30 SoCs.
> Please consider applying it, thanks in advance!

I have replied to 0/4 earlier giving the reason why I haven't applied this.

-- 
viresh
