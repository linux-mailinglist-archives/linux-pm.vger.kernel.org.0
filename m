Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345C12AEEC6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgKKKaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 05:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgKKKaV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 05:30:21 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18012C0613D1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 02:30:21 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e21so1160723pgr.11
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 02:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LqT3Xk8OKEYeP3Y8ngka+rENJ5NBnY9XjAXcGfB12DQ=;
        b=JGYnSPTGq8Yg1Gfe2Vg6FgJkVKDerr9e1rD5mKBtXcJVZGt9Vl0Fn4KMvVEOl9U7l3
         Fo0s9Xv/RRwuDRQFv7peQGJIgLsvY3fpQnzNEknnT/7Wn7sts4DjwX/K3Fc/eKbJ3ERg
         QJyJRFepykd7e8nxYXeYrOclTHlDHsIluyIq7LarcjgG4MtV/HRSaAPdNJkN3PgWKTyQ
         pMlk1aSs5dRId/4VB9E0aUhkGZE6wOBEaIsX4YScDcx+GszXPWCktmWUQJyFBA2wmevp
         7YzEpyaTTOoJFq4s8520tfglfbOgBycwohHobkSWkiRmzgd+RgVtsfoOAyHI4yNxGE9I
         5XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LqT3Xk8OKEYeP3Y8ngka+rENJ5NBnY9XjAXcGfB12DQ=;
        b=g93cvDLNw2iwvsmz1CaYNVrpIvEaul4FDKK6hpwUCUGU+lV2838pbiOtsEW74HMXXs
         M/ctePoEp1yCfBptS/WsWsD3S6Or10NpYpFVTbv6uvtCUs/M+YvjxYneFJiBxMgk8zs3
         yNZPZ8aSR0fvLKXHgZyd4EI0UJbz27RPGf+emxvTekCoUa73Fn6+QXQqEiwDz1lqPRGC
         i/pWNj+F4uZ0z2CO3/4Kh33vuryKqBfidu8ehpU4ubBjRJ55LAVR3w1aksRFKpV6k1YE
         KpCOsgl8cYexDfVTW3ZMTkQhiHsnBa1dYW/XyAggT3Hg7H8E96b8lRl+f+G4buHfxwA1
         IP5g==
X-Gm-Message-State: AOAM531tk7ukNegq4fNhKGqogwfOGcozgNQ849W7XIhRlrj8p0cvyq91
        Q9Zk9bTU8b17aqvzzTvjO+1zSw==
X-Google-Smtp-Source: ABdhPJyE5XoZ/pKawPCOfGvtrw+ykbdOntJCkp5wMY0tvxnLIyuIPSpa/BcVDOcD4Q0WyCA0mGNWTA==
X-Received: by 2002:aa7:86c9:0:b029:18b:b0c:53e5 with SMTP id h9-20020aa786c90000b029018b0b0c53e5mr22175141pfo.57.1605090620606;
        Wed, 11 Nov 2020 02:30:20 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id q2sm2062957pfb.106.2020.11.11.02.30.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 02:30:19 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:00:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thomas Renninger <mail@renninger.de>
Cc:     linux-pm@vger.kernel.org
Subject: Re: Off-topic therml_stats - trans_table - File too large (exceeding
 static page alloc)
Message-ID: <20201111103018.6xixvclldfw4m3ok@vireshk-i7>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
 <4294133.gPUqu62deI@c100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4294133.gPUqu62deI@c100>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-11-20, 09:42, Thomas Renninger wrote:
> Hi,
> 
> sorry for high-jacking this thread, it is at least related and afaik you are
> deeper involved in this:
> 
> (cutting CC list)
> 
> Am Dienstag, 10. November 2020, 12:07:37 CET schrieb Viresh Kumar:
> > The cpufreq and thermal core, both provide sysfs statistics to help
> > userspace learn about the behavior of frequencies and cooling states.
> ...
> > /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 4097
> There is the trans_table for cooling devices in the same dir:
> /sys/devices/virtual/thermal/cooling_device*/stats/trans_table
> 
> I recently stumbled over this in a bug report and realized that it it seem
> to overflow rather quickly due  to static memory usage.
> Fixing it seem to be rather complex, not sure it's worth it.
> 
> for device 0-3 I get:
> cat /sys/devices/virtual/thermal/cooling_device0/stats/trans_table
>  From  :    To
>        : state 0  
> state 0:       0
> 
> and when it seem to get interesting (device 4 and 5), I get:

How many total states are there ? Must be really large.

> cat /sys/devices/virtual/thermal/cooling_device4/stats/trans_table
> cat: /sys/devices/virtual/thermal/cooling_device4/stats/trans_table: File too large
> 
> 
> Just a heads up.
> Maybe it's worth to touch this as well if sysfs is changed in this area anyway.
> Afaik sysfs forbids such data like whole transition tables in one file and dynamic
> mem alloc.

Yes, but cpufreq was already in since a long time and this went in
with the same philosophy.

> Either it gets split up into
> ../cooling_device0/stats/trans_to_1
> ../cooling_device0/stats/trans_to_2

I think yes.

> or maybe this should better live in debugfs?

I think I tried the debugfs way earlier but the maintainers of thermal
asked me to do it sysfs way.

-- 
viresh
