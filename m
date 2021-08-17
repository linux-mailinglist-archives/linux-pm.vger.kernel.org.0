Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A977E3EE6F6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhHQHG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 03:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhHQHG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 03:06:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86269C061764
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 00:06:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so3659164pjz.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ep5aIKB7cRnTH/tfEnZ2+htazn11KVo7QDDZB9lxKAY=;
        b=AccPbIxTU09RzfYhfRKFu31aBKwl//5TRRGKjvgAVpKZ1raAi3H0XoK4i0wRAmsn13
         y4sJyLl80zQ8X5jAAoRe25NaxAFOr+Gqb4ZgjT1kL5NhLf2CSZ0wnaIYrxA4wsj4t6T3
         7yllTyQY3+6RmwDigy14++JahJBDHN1NRtT3LuDP8lewwZA/NvAvjNoMadJh/IlbgzGh
         C5/EG3uiu/GlBYlaWfGGHJ0hlUa+ZZ+RI52UN2cgLluR8nwePsGD+6TVR7nYdMXWS7Ah
         f8USXT2Q/u4yR2PgkWcuptkIPqWpqmBeQQahFrdF4afWU+Saz7NqizP9OwMQ6I/8PGDo
         vruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ep5aIKB7cRnTH/tfEnZ2+htazn11KVo7QDDZB9lxKAY=;
        b=GY+5hybJsGHSY2vVLee9cWjG5zzRO9j0dHz79mpR5EAPCrGbFYnkUtoFV/Tl1TJ6TV
         65YBgE4KfJ77VF5wdjzlSUGLCIIu+0bMzTA2n/kRJ522ymJeMLpxVbVG3O2YMiKwsjy2
         7j8NEdfSlcUKY6thlkCePvlawZqE2PYe3i9hHOGaySzglSIzPGM9n4kAuX9q6ZmoSZwM
         /GTvLWOeaD84yz1AkJKriK6bQLZ/YdwbqK+/DucNVwf4oDU+R8NV/7BOFoshknSuaWq8
         otEjvv53rZOHhPPn/MLbAnb4zrG1DswDZ3BS+74hdO1+tPDCaAoiSfVfSZrIAlJ/o7f9
         owag==
X-Gm-Message-State: AOAM5333vIW8IfNsJkbaxYzii6r3CbXLZlrgJ32ByBeK5o7LsYuzXAYJ
        0IKyYmYCPqmHkGOz1R8IDjhArA==
X-Google-Smtp-Source: ABdhPJz2XYAoQingNO5HnM70me71DcnSdGGwtBFC0R8cKcY13sze8U/r+v4njbM1vLjgNTVQsdCe4Q==
X-Received: by 2002:a63:3c7:: with SMTP id 190mr2141445pgd.240.1629183983105;
        Tue, 17 Aug 2021 00:06:23 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id w145sm1379021pfc.169.2021.08.17.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:06:20 -0700 (PDT)
Date:   Tue, 17 Aug 2021 12:36:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210817070619.g6ootmga3nyxm7tz@vireshk-i7>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <CAJZ5v0hta1mEVatT=6ZMLhZCs3btcSbTT10YEihfdvB-WxDuzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hta1mEVatT=6ZMLhZCs3btcSbTT10YEihfdvB-WxDuzQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-08-21, 16:19, Rafael J. Wysocki wrote:
> On Tue, Aug 10, 2021 at 8:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >  I understand  that this was done to not do the efficient stuff in case of
> >   userspace/powersave/performance governors.
> >
> >   What about reusing following for finding all such cases ?
> >
> >         policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING
> >
> >   The driver can set a flag to tell if it wants efficient frequencies
> >   or not, and at runtime we apply efficient algorithm only if the
> >   current governor does DVFS, which will leave out
> >   userspace/performance/powersave.
> 
> As long as this can be done without actually accessing
> policy->governor->flags on every transition, it sounds like a good
> idea.

Great.

Vincent, I hope you will be taking this forward then ?

-- 
viresh
