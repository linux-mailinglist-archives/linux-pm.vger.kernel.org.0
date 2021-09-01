Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8994F3FD33F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhIAFtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242168AbhIAFtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 01:49:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2BC061764
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 22:48:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id r13so1164933pff.7
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Fu7LKKRJjW440Z2ObsB6RluKhLefXiiAWgwLg8qYv3c=;
        b=Ca2ji+kvbJuiGYX9IdmK4ysPPLPCfMfK8Jmqt0nbVM6mN09cSV5IhhdI+bA31RbABL
         erE8lmntFDumv721Sv/YzC1VViPKNJs4B2pEovnokyi+0s7Oy+umj/EHQ5ufDiahHif7
         OmiDOLOWS6SUg6Wzgq5+y/BgGUa9ow71YpHCPz+TwUwR3I7tUyK+Wvy7S2wzKPY32HH/
         tsO++SaQR8HJXQbjUUbXXj1hJ2dLjtgRXO9QYM6fuqmtzcb/E5e3FnXvBuX9lStXnUFy
         c9c9AWZSAYWFddLJZFAhap6qaG7UZFQfEo/886u+OHzaCCXzXMYOzR1F89Oizq86iB1o
         QhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fu7LKKRJjW440Z2ObsB6RluKhLefXiiAWgwLg8qYv3c=;
        b=CAtDAda5qTIes4ra7sK9OR8ZnRF95103b8BqMQIeZWJMLLurHipsEqIa3TpfpEfi4m
         IEXI0GWizW1NxFa0tMrgNMn67Xm6JSFZieXbTggR3pujbQuZe/38mPC92cJApb0QDWZA
         vC7UkjT09vazF3RHrbEdL2kX5hh2+/4F8DTrBeXSTtcyM5sIyQ1G+8oZKPCckOJM4p9O
         MVYN5HsbGSyDxJYGIiWfRiN159RTKKm6x079SMEvhp4VXdaJxlQdBjI8ron/cPqsjbBg
         PO7LQYYjftynCCWFYRPRCPovI6XGGx2cmm+q2XOF+aTGGo2Js13jXWku2QuoVjruppXE
         /xgg==
X-Gm-Message-State: AOAM5332QddwdlZthSPM9rokkSkXKY/TGnNII0egBkJ2DHerXSTrsYxV
        XdskyE2NqpZIB4bVDNl1p6bq7g==
X-Google-Smtp-Source: ABdhPJwD+9Ue+IoeaBYIvCfAqgAjhGKwCFzKaMHRiBmF+UcAq5RjUQpsKzIb6maIoEjI3ltNLVx86A==
X-Received: by 2002:a63:d814:: with SMTP id b20mr30365995pgh.268.1630475306650;
        Tue, 31 Aug 2021 22:48:26 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id o15sm4233026pjr.0.2021.08.31.22.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:48:25 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:18:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 3/8] opp: Change type of
 dev_pm_opp_attach_genpd(names) argument
Message-ID: <20210901054824.yfse5txuyeoj5j2l@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-4-digetx@gmail.com>
 <20210901044117.abfwfebqw5lbn5zj@vireshk-i7>
 <e166f6e8-6de1-6e10-2607-78fbdc196a9d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e166f6e8-6de1-6e10-2607-78fbdc196a9d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-09-21, 08:44, Dmitry Osipenko wrote:
> 01.09.2021 07:41, Viresh Kumar пишет:
> > On 31-08-21, 16:54, Dmitry Osipenko wrote:
> >> Elements of the 'names' array are not changed by the code, constify them
> >> for consistency.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/opp/core.c     | 6 +++---
> >>  include/linux/pm_opp.h | 8 ++++----
> >>  2 files changed, 7 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> >> index 602e502d092e..d4e706a8b70d 100644
> >> --- a/drivers/opp/core.c
> >> +++ b/drivers/opp/core.c
> >> @@ -2359,12 +2359,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >>   * "required-opps" are added in DT.
> >>   */
> >>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> >> -		const char **names, struct device ***virt_devs)
> >> +		const char * const *names, struct device ***virt_devs)
> > 
> > I am sure there are issues around space around * here. Please run
> > checkpatch with --strict option for your series.
> > 
> 
> It is the other way around. This fixes the checkpatch warning and that's
> what checkpatch wants. You may also grep the kernel to find that this is
> the only variant used in practice.

Heh, you are right. I somehow thought that * never has a space right
after.

-- 
viresh
