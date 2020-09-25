Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69937278056
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 08:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgIYGKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgIYGKD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 02:10:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A9C0613D3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 23:10:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so2169411pfd.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 23:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEje2tQ6P9L6RCswV6XKybFquVMo4l5f1E6EwfoI7TI=;
        b=lmuiFQOautmpJ4q7kOwzyE0hq/RC1OFtqTVhktOah6RQSzR14te1pF9MRdoJOUGmsD
         491+XFxLj248tnwVGcW5F1GtrHGfR62Mww9xS6Yejopx1eA3ZFEkxTYy7QGUmYocvOPB
         n6qkTYuQhxfU6NBFN41a3EPRQWwffOMiVzcTk8BNfRfJhMz5FBqz7FXDuNjVj7uT+Uyj
         G+ZJg+xaH1T6TIK+Rf0qiLtqze2sFrJtLQOLTSwwLCF9hxNp2mdUe4rBKv7JC2PtorRH
         vl2+tYqzdmmgYPe0T1OwDV4ts9dM87iaz/bMujFvE6FocAsUqotoYSQ9XRK/0QOxyNcH
         BaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEje2tQ6P9L6RCswV6XKybFquVMo4l5f1E6EwfoI7TI=;
        b=af6wa/QL3jyo2yTVUjmsiSqm95FXEchNxwiatEulv3b6mxkTwuJQnEu40d2rAiWaKt
         wXeJ9wLx1SnZQnTv9r3qPbKi7MapEbEWOIXcVZgwosYpRvGHVYkr94r3kxPvb+17tgdf
         8aORvCvuaCTVzCvxP7M2BmXP5iyiPCnSRHRQU+biS+tDoEwzpxKeC7IavyFbqtmrmCz9
         FmVhC25kkLNt4QRJ1NqIWEChkCqym/dmttK6EGNox9qD0Df2hSbIVSVxiRDS4lQxhg9z
         Z8kvE9SYzXRXmIprn8keAiKYNOdM9BLunznn/IWRaKmt4fJwA5yvwlR3qN9BbXwKEcEv
         Urpw==
X-Gm-Message-State: AOAM532qU1QTTUrYhHOx/TWJ1ysZMnHVNUKT9yC3GMMUmwS8ACl15fA4
        THuJ/Dp2MWwkXmio7RuFjFs/bw==
X-Google-Smtp-Source: ABdhPJw8PSlHPX7vdpw3iNTAvkxKTtz7+XYs77IQpPe0B1mmVlusC/As4pERGp6iDX967U9mKOrf3A==
X-Received: by 2002:a17:902:9a06:b029:d0:cb2d:f276 with SMTP id v6-20020a1709029a06b02900d0cb2df276mr2758912plp.15.1601014202602;
        Thu, 24 Sep 2020 23:10:02 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id g9sm1397329pfo.144.2020.09.24.23.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:10:01 -0700 (PDT)
Date:   Fri, 25 Sep 2020 11:39:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200925060954.k5quasxz2epjdmdq@vireshk-i7>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <a4c5a6b9-10f8-34f8-f01d-8b373214d173@arm.com>
 <CAJZ5v0iFjzqTKTPFF5hB5C0TYSQn2rxL_6099gqUwoTARKRnZA@mail.gmail.com>
 <ae5771c8-6297-e447-4449-e39ae2ea5a0e@arm.com>
 <CAJZ5v0hkBnU_W-ZXHTfppu9pVWnQcJHho7DQPi7N7yeLOt5cgg@mail.gmail.com>
 <20200924123921.iiaqw2ufe2utnjtg@vireshk-i7>
 <f57626de-6021-e87d-63ab-33ccc46a2900@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57626de-6021-e87d-63ab-33ccc46a2900@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-09-20, 17:10, Lukasz Luba wrote:
> Because of supporting this reset file, the code is going to be a bit
> complex

I will say not very straight forward, but it isn't complex as well.

> and also visited from the scheduler. I don't know if the
> config for stats is enabled for production kernels but if yes,
> then forcing all to keep that reset code might be too much.
> For the engineering kernel version is OK.

I am not sure either if they are enabled for production kernels, but even if it
then also this code won't hit performance.

> I would say for most normal checks these sysfs stats are very useful.
> If there is a need for investigation like you described, the trace
> event is there, just have to be enabled. Tools like LISA would
> help with parsing the trace and mapping to some plots or even
> merging with scheduler context.

Right, but stats is much easier in my opinion and providing this reset
functionality does make it easier to track. And that it is already there now.

> From time to time some engineers are asking why the stats
> don't show the values (missing fast-switch tracking). I think
> they are interested in a simple use case, otherwise they would use the
> tracing.

Right and I completely agree with that and so this patchset. I think there
aren't any serious race conditions here that would make things bad for anyone
and that this patchset will eventually get in after a little rearrangement.

-- 
viresh
