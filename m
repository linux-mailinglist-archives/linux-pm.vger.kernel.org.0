Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3975E23DFBF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgHFRwu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:52:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42113 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgHFRwt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 13:52:49 -0400
Received: by mail-yb1-f196.google.com with SMTP id a34so21128399ybj.9;
        Thu, 06 Aug 2020 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgg7zjRmtBHf2LasBRhwIDC6917kX0SOQm5jVjzS8IY=;
        b=nCh3eFAgcnGVQJwt76xeSrzviRhoMjBHsIuHNXqkAq8EOA6dy151e3y+EG3BLYtRsh
         QVeqmj+OgHWIwCP9EHVbkmOZsDgAbBuH0dI7NHHm319inLAaqbVq/v+48emOBsxM6sWB
         4Uou/DL6sXdDtY+GNzLwQ0+7EzprdDbQfmVlF0N+uCoYrknPp3yYJZ6yA+knEqTqoBsU
         XVN16pumaeUUCx+7anFWCojmZ0K8GyeljDlxH4WvNJlOFyN76PG3WtFTD8rFogDet6Z8
         yOvGcAKvVIEHQsT1SH3N+Xmmmu/i9Lfmau5NboSDdDGB1SlooRci5+T8xpI66ULIppIl
         BKiA==
X-Gm-Message-State: AOAM53190UqgjPg+EZxVr2A0wv07M7iXN69bNIdS4VZwdt5D43irDMsD
        2tGgc1XaPcR21iWPafAUO1lK94+qINHbf97L/4p8cg==
X-Google-Smtp-Source: ABdhPJxULzaMdb2r5HtAoGgvyO5tjHQhRFpUAVkZo1s1fFBs4k39zAEGh6ZRygcyIDYC1Ra54huZqcZBjxPgAvBb0BE=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr6761257oth.262.1596713126064;
 Thu, 06 Aug 2020 04:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
 <3226770.pJcYkdRNc2@kreacher> <004701d66bb6$22a11410$67e33c30$@net>
In-Reply-To: <004701d66bb6$22a11410$67e33c30$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Aug 2020 13:25:13 +0200
Message-ID: <CAJZ5v0gz89CXmNmFE50oB78JigrDzo=EPYcGQORRtz7WbWv9fQ@mail.gmail.com>
Subject: Re: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 6, 2020 at 1:04 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2020.08.05 09:56 Rafael J. Wysocki wrote:
>
> > v6 -> v7:
> >    * Cosmetic changes in store_energy_performance_prefernce() to reduce the
> >      LoC number and make it a bit easier to read.  No intentional functional
> >      impact.
>
> ??
> V7 is identical to V6.
>
> Diff:

Oh.

It looks like I sent the v6 instead of it, then.

I'll send the right one shortly, sorry for the confusion.
