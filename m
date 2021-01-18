Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E962FA280
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 15:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391398AbhARM0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391040AbhARMR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 07:17:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8DC061575
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 04:17:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so10094540pfu.8
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 04:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OK+wvAIWz97i5pOfUTWYOoqWSq+gjxb55ZgsDBZNEUA=;
        b=yP3q5bnE215jn1E384+68S8WpKkBR1Z6hlcrJqXtxx8EHVNXszY6x4n99kbsq00dNs
         ZDoXaqHWgtr16JKaOWXEb30q2lD5phUJ1rBOui0xdAku0cjXD31r7CL1Bji2cS7yYjKe
         PUE7oqytiB3A09eJGiRfHs5ongISYeEOHN88oukQQNATlYSEqgKwHVLuZN6oxqK55uiz
         zqAM525e/wZWS8dItT1IJz5+6J/kuafKxBS84bJDt4SMVfVHI9CgXIp6YwFmeFhBQbet
         dyzJbN2LhMi9DOryAyj3WQho0pcKtkdcrDhCqYgj7gLR4OgbMV66K6HzEgBjeXxK2EPm
         x/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OK+wvAIWz97i5pOfUTWYOoqWSq+gjxb55ZgsDBZNEUA=;
        b=Gq23xmigETugrOqQphacnzBJ3P2RUJ7EdfCGxrF1/xQh1yns8z+6kF2DTvxJ4XNT8N
         KOWRTw/T/57BdkUz8ESaAE30h7fWkvjBweCI1zrcgOJhze+jMY5tK2YvU2B1gRs2Ykla
         z5axEWsONO6RI0nAoBG1B3w/yCtOgXosOLvAywjHsmPleFrUPNm4CiwMQAlREOZ4pKjg
         glAD0hjbjlLhdbELwJIwXZre/tIZuSqCy9/XzD3vLJdiBYN5FeqApZBh7NbHL95lAs44
         hmmx706UyrkVW7VGCumjOl8t2x/mPIVcFsI9psX7B0nGLzozRPGsaS5BAg0mYbhVUAaV
         053g==
X-Gm-Message-State: AOAM530bB2LCijhhdf1FE6Kodtu9yOuremisy4ul1DXuaRDnKkPn7VV1
        dhmWaTgBh70fNGoXEgCiiSBjMou8vaOoQg==
X-Google-Smtp-Source: ABdhPJxUQwXWTzfvNpzdBvric1JiErYgJn0SBmCP6LDT8gJyn3YgSuMpY+a93LQfpzjCCVyGWeT34Q==
X-Received: by 2002:a63:c64:: with SMTP id 36mr25822687pgm.255.1610972237714;
        Mon, 18 Jan 2021 04:17:17 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b6sm15178100pfd.43.2021.01.18.04.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jan 2021 04:17:17 -0800 (PST)
Date:   Mon, 18 Jan 2021 20:17:12 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210118121710.GD2479@dragon>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <X/210llTiuNt3haG@builder.lan>
 <20210113043143.y45mmnw3e2kjkxnl@vireshk-i7>
 <X/5+GbueKg66DoEE@builder.lan>
 <20210113050651.q2txref3d6bifrf3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113050651.q2txref3d6bifrf3@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 13, 2021 at 10:36:51AM +0530, Viresh Kumar wrote:
> On 12-01-21, 22:59, Bjorn Andersson wrote:
> > But that said, why are the ioremap done at init and not at probe time?
> 
> These are some hardware registers per cpufreq policy I believe, and so
> they did it from policy init instead.
> 
> And yes I agree that we shouldn't use devm_ from init() for the cases
> where we need to put the resources in exit() as well. But things like
> devm_kzalloc() are fine there.

I'm not sure why devm_kzalloc() is fine there.  IIUIC, the memory
allocated by devm_kzalloc() in init() is not freed up from exit(), as
&pdev->dev is alive across init/exit cycles and will not trigger devres
auto free-up.

Shawn
