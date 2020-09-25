Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FA27858C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIYLJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 07:09:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46086 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYLJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 07:09:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id u126so2337088oif.13;
        Fri, 25 Sep 2020 04:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0XOyqHWfOpDLt9M6Ig1oO+6ZMp3I1SUHg/BkMQAork=;
        b=QRM7el//GDK2ayZ8x/LWKn1KAYaVT73F3+R4ocrRRA0R6G41eU5lXTBCuYgsKTYNeI
         EV7U8udqJM4MkRkLAUvkoPMJbaiiy6mtiDMsbnIqHOembCIh/xvpKUFT+QK/kd3Yl0jU
         InPVbhXYZgTOBwx+F9IYBzOPpYS28DfsNfPCk8m3rMmMRu7gTMA2fLrhKkom/mcSDOrh
         p7Ga7OcFSCk/BYQSTtMeP+uA11Jci6xpX9rlYV/m60PHJYGjTMiry/I4kZVqaehzlCVr
         q2TJn+4G+AkQnAwrPKyYGKp0pbOxyly7GnKCs5pO1Ag46ILPl9yNbVTqxa4X6+SE3Mnb
         0c2A==
X-Gm-Message-State: AOAM5328sG6I24r8LlLQ835W/NRNSGj8rAfj6iaBzmJpK2SwYzc3WB//
        MztOnr09/QASUwX4jhlQCaKVaNouEMCkJ77Pwx8=
X-Google-Smtp-Source: ABdhPJxciLZD1CftNy0xx8NjNfqeXSw6jM3Y3ux4IPYmuYNHFOYdVRyzws3CukCu0BvJrZKIUXnyf8knGbw5ODTJ0+o=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr1167842oib.68.1601032181317;
 Fri, 25 Sep 2020 04:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <20200924131543.eury5vhqy3xt35v6@vireshk-i7> <CAJZ5v0g8Bmxt=GEKcNrKjY1cHnsURV5oe3+n1R2+U_2VJnwfRQ@mail.gmail.com>
 <20200925105830.xsmiwkjohlqb5joj@vireshk-i7>
In-Reply-To: <20200925105830.xsmiwkjohlqb5joj@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 13:09:30 +0200
Message-ID: <CAJZ5v0guU0GDs06W98boFpdCopHTiF_ojwTPrZFNP0Bk3DiQXQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 25, 2020 at 12:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-09-20, 12:04, Rafael J. Wysocki wrote:
> > I'm actually wondering if reset_time is necessary at all.
> >
> > If cpufreq_stats_record_transition() is the only updater of the stats,
> > which will be the case after applying this series IIUC, it may as well
> > simply set the new starting point and discard all of the data
> > collected so far if reset_pending is set.
> >
> > IOW, the time when the reset has been requested isn't particularly
> > relevant IMV (and it is not exact anyway), because the user is
> > basically asking for discarding "history" and that may very well be
> > interpreted to include the current sample.
>
> There are times when this would be visible to userspace and won't look nice.
>
> Like, set governor to performance, reset the stats and after 10 seconds, read
> the stats again, everything will be 0.

Unless I'm missing something, the real reset happens when
cpufreq_stats_record_transition() runs next time, so the old stats
will still be visible at that point, won't they?

> Because cpufreq_stats_record_transition()
> doesn't get called at all here, we would never clear them until the time
> governor is changed and so we need to keep a track of reset-time.

Or trigger a forced update.
