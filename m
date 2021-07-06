Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F93BC7F7
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhGFIkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhGFIkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 04:40:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFCC061574
        for <linux-pm@vger.kernel.org>; Tue,  6 Jul 2021 01:37:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w22so15184167pff.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Jul 2021 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWgvKKd9osi8SGdjen6Va73AEJitP6PkOyyL250Hc5U=;
        b=q6MSDnZJwF/Jm8J6jWqoXAzm9qMDznp9uzk2mBfuzMVf9itme1DOpOH6m+ANt3ety4
         Z/TTE9gMa3hzCbc2Qn/DGXQ+kUqyIa3UOJ4OGajH73Zas+2Sv9O9xij6FDrfKuBt7d/i
         wucuBWSxxSENcgfQF5g4s/U6ZeXaWf225NntXDekKGQDl7k+EuC4bKbYgxolltNXv0Wo
         9u+t0DBlMunLH/jVYpbxGWSsXi3swlggjBYoQfTYIQcuf85Ur1oN7zjAnbSoy8MZow9Q
         mQTrOH6Md0i2sKrF0hc5fyPudAkuJU9ECb8/mFFPrdyedNy3j0Q2v8jVo+XVELl5xF0H
         7r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWgvKKd9osi8SGdjen6Va73AEJitP6PkOyyL250Hc5U=;
        b=sEJ/xz+B2M6pIKajgtr6l272/y+rBonDCnOBTjarhP70Mad2XiZEO3RVd7oss0faIw
         cARUOdTk7j+jZBx1jByzb7afTsH/27zuosIncyEWKgDetDwOu5SM87zhyBMpoo+RdOz2
         PlOsFrcFOvJBcfHFiM/g6sbDpOgYPuOGtDpk9xQaNv5VfLz+KyjknA7iCw77D38PlYxd
         pFhNNiewzQ+sE9JVOBld0AWHHHDe6L+lGXysg7EsW6O6i384yyH/AYNhKl1VeZhdEZv3
         v0zKaJk47C0xrMRocffMuRBEL9KVZBqDKyB4UAs8g0H+26R+70tXQpEAuTl07C25uuPM
         yoLQ==
X-Gm-Message-State: AOAM533tyHLa5b8B49ZSZ6c9Va8suKY1ljmeKmJpEaNppERj8WwMPafh
        nygV3oux9OEXNCJsF8Wvq3da3A==
X-Google-Smtp-Source: ABdhPJxs3itQvh1azP21+EUk9rXUx2ynOcj9yWBpwHAbOl1Nx3W3Nej1n/H1zfYciD/DJZc4UO/OxA==
X-Received: by 2002:a63:4302:: with SMTP id q2mr19779873pga.428.1625560664263;
        Tue, 06 Jul 2021 01:37:44 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id y3sm18250013pga.72.2021.07.06.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 01:37:43 -0700 (PDT)
Date:   Tue, 6 Jul 2021 14:07:41 +0530
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
Message-ID: <20210706083741.2ihy6wf6bfff6lvs@vireshk-i7>
References: <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
 <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <CAJZ5v0hOXHtoN3Z+Mw9Ym_HaY0OxessNAKTEpp6GM5_pnLJauw@mail.gmail.com>
 <a660b9ec-3ee7-28b2-569c-5a8d1510d927@arm.com>
 <CAJZ5v0iQve59SxD0TJ19wonj=WO7qVSApM-xPf_FYUf42Z3d5Q@mail.gmail.com>
 <20210702191658.GA30379@e120877-lin.cambridge.arm.com>
 <CAJZ5v0ijLepOyGX0Et1h3j6AbtFxV_-mq+2uNrv8syG0RPiJbg@mail.gmail.com>
 <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706081256.GA216826@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-07-21, 09:12, Vincent Donnefort wrote:
> Of course, I can implement this instead of a cpufreq_policy flag in v4.

Why should this ever be a policy flag and not governor's flag ?

-- 
viresh
