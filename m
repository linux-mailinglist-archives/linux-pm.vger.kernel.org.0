Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1BA3B6FDA
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhF2JHw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhF2JHw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 05:07:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB3C061766
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 02:05:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 21so16665471pfp.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxf0nNdDqyVoap8M6CG4HmjTediBPHub6WIWm3X9tdg=;
        b=oTXq0/zjuzYPodSFGvMyuSPm6dwszJ3EXXtGSdCk4pk1sIZN2jSadWGy9UglSbV4Id
         Ak/vFfrERdzVadO8t+3Ll8wZbk6NySFl1q6Iqmkt8moV4/trIjpr+Hil3Z99I73TixFJ
         zKkHDRWcaWS+vA4PTWDWT3GbCCsVwQp1MKHH/codd3Gg6YHr6rwlnVXsumEwnSAKd5mc
         fhwJHhDBxLyoun0TjEQi5HIvBhNjwOa8GHN46cwYv4tS8LA3sibk2GeFpXnPnU3mtcmc
         v75Nb3QrIXAHfdz0fZT0dZUmXyMGgivobj3/yRzZXqkLo03Tzk4GLHe0Cu8xkiBD6lZq
         l8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxf0nNdDqyVoap8M6CG4HmjTediBPHub6WIWm3X9tdg=;
        b=Mc8Bz6jPbll2+ivdNQLwM9rsNJJGMZFZh5ZNETGdJ8Eiod8rHO8J7/AnG1bHFQsolX
         UvTs3e3dfqHJATA9W23wfwvDXLHsDagXA/i4eYGI3J8fGMWL6B9gOTuLDaLasZF2+ttg
         k1TKoAgCirMyn4ZEmAEh47J3BMXHIhwQORmPV4cC36dNPYYcaPfB6l1N2gSTuKcmbJEi
         UAuqnYjg/bDhlLbAgDYtoOOQec6x0TFWjkJMKAluHak+98d5TiwbzsnJ9eWqG+65v0oB
         Zib9YyDyceBxTsZgu7Du8oxTWrQXW5Wh9GW8k7gQdwrA02ODuIdNyV4B7W34TxusxC8e
         0ydQ==
X-Gm-Message-State: AOAM5332j6L2LBfgP7jhxCVfXsNVdJr/YLU0srFD9/AhwF0SeYnEtLkK
        Rxkjx/ryksXYpHOuWwfv1JoChQ==
X-Google-Smtp-Source: ABdhPJyUPZgwjS4wGEte0i7vATCyxhKkaNbcvSyv/AlwzZqne0dvhsrD9mp5zq7yjYCtC/F8sRmOQQ==
X-Received: by 2002:a05:6a00:8:b029:308:1d62:ba56 with SMTP id h8-20020a056a000008b02903081d62ba56mr27553764pfk.60.1624957524945;
        Tue, 29 Jun 2021 02:05:24 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id nr12sm2303013pjb.1.2021.06.29.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:05:24 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:35:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210629090522.jsiwkrki6lavo33z@vireshk-i7>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
 <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
 <1624781848.1958.16.camel@mtkswgap22>
 <20210628072641.amqk5d3svwolvhic@vireshk-i7>
 <20210628090956.uwkrozdqvawsm3xp@bogus>
 <20210629024719.nmcygaigtx5wn7g5@vireshk-i7>
 <20210629090238.n23zcttkiqvzpbb5@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629090238.n23zcttkiqvzpbb5@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-06-21, 10:02, Sudeep Holla wrote:
> On Tue, Jun 29, 2021 at 08:17:19AM +0530, Viresh Kumar wrote:
> > On 28-06-21, 10:09, Sudeep Holla wrote:
> > > Probably in driver/cpufreq or some related headers if it needs to access
> > > related_cpus and is more cpufreq related in that way ?
> >
> > It just needs to set a mask, so doesn't really depend on cpufreq. I
> > was wondering if drivers/opp/of.c may be used for this, and I am not
> > sure.
> >
> 
> Sounds good to me.

Okay.

Hector, add the routine to of.c in OPP core.

-- 
viresh
