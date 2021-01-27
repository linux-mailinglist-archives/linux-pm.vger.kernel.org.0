Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B045730580C
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhA0KP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 05:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhA0KN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 05:13:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE26C061788
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 02:13:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id md11so978764pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 02:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mcz+n2KoieLg/hGSE9zSgqjZ3omTpFzpCsqi6lR9mNU=;
        b=Ahc7KfA/dLG+hjxO7xTdu6fZyx4C/906vWzeWofgUe/6CaRU1DHJK5ISHOazKQP5WJ
         6Vr0BDQGq7izi6Zn6QRim0jmb2b6k/ej8k7bpDdHpa5p7vjSA66sXk+yi8r7Wk4ZxBdK
         0vjhlayifatx1tNVCOOMy7OzKOILKO1D2MdZtwr1NEKPX+evVrs1X4d+OaEmBPBbeg0a
         VhQAb6Hd2g/Hj48lrIqzrVc/5eHLCCXWWmd/g6BXpMz5HYGQYEWSpMqIkEWsvnVHlCAF
         f/1roVVMKousaGUqN2vEgwIuZjT8K4EthxaOI0uOgvWfvSCS+axfIg7UDkBVdN3KVuxT
         VJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mcz+n2KoieLg/hGSE9zSgqjZ3omTpFzpCsqi6lR9mNU=;
        b=Mi2Nc752yGfhKtL/Mdzchuu9vm4Kb3Dhr9TiROAyniewMbhOoZ9MIOm+VIPCp+nrn2
         Wsw3X1f9zaKlHfL89OOUH5hTET3R2V39VmKiXCPpDPc+qGX5zmxOh8dXQ5KihOzM2UwA
         FPkcLmS3W6LNoyBxNyX+g3d8R9v83pITCpPozrmP7+CW+z1Ra++WKSWw+r1v8TofEXSX
         oEMJc7vH+7fbNYn1MwoGGwHJeAoIZrOnBAIO1lT1SydEF+FIHDMYiZovHsKW39aijZST
         31J0mMCwqgT6XOdYn4RpfPrJkMZuHC91br2tydFZHFAJ7siq+62nX2doToQGMp1r6xGq
         uEYg==
X-Gm-Message-State: AOAM532X1Y9cw3863VbwpXjNI7kAtE4mUEHcpPcsATJ+xDLGBf6EycsW
        8FlIBNXXD/+kxGhCypTUwRDoTQ==
X-Google-Smtp-Source: ABdhPJzEix8bPHI1p6ys7MVr2aWJCOVZqkIIlbL9JmuGH0aKPJCG52MhIgXpVz4ZqkPs7cmilM6n5w==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr4935503pjt.64.1611742395169;
        Wed, 27 Jan 2021 02:13:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a189sm2056145pfd.117.2021.01.27.02.13.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 02:13:14 -0800 (PST)
Date:   Wed, 27 Jan 2021 15:43:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
Message-ID: <20210127101312.ve7qlpvda6tabquu@vireshk-i7>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <20210127091540.xesvwoeavyaf37jn@vireshk-i7>
 <9aecd2cd-771e-58b8-6672-f133600b70b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aecd2cd-771e-58b8-6672-f133600b70b5@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-01-21, 10:11, Lukasz Luba wrote:
> 
> 
> On 1/27/21 9:15 AM, Viresh Kumar wrote:
> > On 26-01-21, 10:39, Lukasz Luba wrote:
> > > As it's a RFC, it still misses the cpufreq sysfs implementation, but would
> > > be addressed if all agree.
> > 
> > Not commenting on the whole stuff but if you ever need something for cpufreq, it
> > is already there. Look for these.
> > 
> > store_one(scaling_min_freq, min);
> > store_one(scaling_max_freq, max);
> > 
> > Hopefully they will work just fine.
> > 
> 
> So, can I assume you don't mind to plumb it into these two?

No :)

As I said at the top, I am not commenting on the whole thing yet, may
need to think over a bit and Rafael will comment as well.

-- 
viresh
