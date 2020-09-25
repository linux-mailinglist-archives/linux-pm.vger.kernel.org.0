Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098EA2785C2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgIYL1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYL1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 07:27:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B3DC0613D3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 04:27:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id s88so1978814ilb.6
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiVJLOBV5LcmVTiJhnHnDU44FmxZVBCf8/K2rl5lfoU=;
        b=LwlV686z+l+2FKghH/so8g8fDFpHMDDWt7w5TMBjKRTHi4JZxQnYesIgGqgK+osGu+
         jx7m6APWPYvpIXXM0+wqcD+vTSMp3roUI0HEJ2khbbImkdDGNP+WbnFsoF6IAHcWquQ+
         CkPISGcKTwZV1/CiyCAW+aQBD/qZac4B6gbQJICGkgn5LdTByu/g0pPJ7E0z3B1DYoIu
         lF34X8O3qlAXGAn/gNpNho7olYmveqm1L57mzDm+b/CKvaaLHM+Fnq+dYi3PahkbKhfW
         Q5QMZJGS8wQsz0oQEVojJNc3DO5NLX1dhbExJjmrOhYm1LqMma0fXmTVM4CITCy54Kxw
         prOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiVJLOBV5LcmVTiJhnHnDU44FmxZVBCf8/K2rl5lfoU=;
        b=Mfi1eq9v7LhWAgO6FXcHQ25BLyetRS41rrMfTu04vfyb/cMqh30IhobhA5Q+jhWnwp
         V+pukDIvwH3iwUmD/Gg6zhBg/FA5TaGVk44YXft/TCweCLXuorS4vcpeF0/3dQ9xcGo0
         XOJKunONkJi3GiFzIWvEs+KLBU5AEpgckyuuWrv0rLjqYueJ1bF4vpENFbdIhcKqgq9j
         Ai8ZGAp5ZkGw1y3X1y+HTJsny8Ql0PuSIMb56cl2w0Sgil2JGh5QSwUAIkWXeGene7fO
         pkXYlygs2vjSXseHmT35XinOh+U1BQ+8k5qSl1/cbCHhOO8TiXbOXJ5oBjH16QEzdezc
         q4Bg==
X-Gm-Message-State: AOAM531/xcaDxMZvQ5p+a9AvJ0qUk4jGo3gGoTtT54oOdHgIbfoPUuCZ
        GHifohZryvtE+cPNK1ObHC4y4b8CcDxX914a4A3GMg==
X-Google-Smtp-Source: ABdhPJwRwhqEygDtN+4fhAZ/kjJMmmas2CozDB/Ls+XD0FdOOYj3VCXukeYOfRAyINpvB4gAj20a+yQIoxbxi4s9LuU=
X-Received: by 2002:a92:5bd0:: with SMTP id c77mr2742659ilg.31.1601033223767;
 Fri, 25 Sep 2020 04:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <20200924131543.eury5vhqy3xt35v6@vireshk-i7> <CAJZ5v0g8Bmxt=GEKcNrKjY1cHnsURV5oe3+n1R2+U_2VJnwfRQ@mail.gmail.com>
 <20200925105830.xsmiwkjohlqb5joj@vireshk-i7> <CAJZ5v0guU0GDs06W98boFpdCopHTiF_ojwTPrZFNP0Bk3DiQXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0guU0GDs06W98boFpdCopHTiF_ojwTPrZFNP0Bk3DiQXQ@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 25 Sep 2020 16:56:51 +0530
Message-ID: <CAKohpo=2Dm3+9XBpmkj5xp1vpamcR5tufc522uSz1Egkmmf-6A@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Sep 2020 at 16:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 25, 2020 at 12:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-09-20, 12:04, Rafael J. Wysocki wrote:
> > > I'm actually wondering if reset_time is necessary at all.
> > >
> > > If cpufreq_stats_record_transition() is the only updater of the stats,
> > > which will be the case after applying this series IIUC, it may as well
> > > simply set the new starting point and discard all of the data
> > > collected so far if reset_pending is set.
> > >
> > > IOW, the time when the reset has been requested isn't particularly
> > > relevant IMV (and it is not exact anyway), because the user is
> > > basically asking for discarding "history" and that may very well be
> > > interpreted to include the current sample.
> >
> > There are times when this would be visible to userspace and won't look nice.
> >
> > Like, set governor to performance, reset the stats and after 10 seconds, read
> > the stats again, everything will be 0.
>
> Unless I'm missing something, the real reset happens when
> cpufreq_stats_record_transition() runs next time, so the old stats
> will still be visible at that point, won't they?

For userspace the stats shouldn't be visible after reset is requested
by it and so with
this series, we check for reset-pending in all the show_*() helpers and print
stats since the time reset was requested.

> > Because cpufreq_stats_record_transition()
> > doesn't get called at all here, we would never clear them until the time
> > governor is changed and so we need to keep a track of reset-time.
>
> Or trigger a forced update.

That would add races while updating the actual stats. And so I found the current
way to be more reliable.
