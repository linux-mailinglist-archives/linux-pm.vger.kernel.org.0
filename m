Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643CB357310
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhDGRXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 13:23:49 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:35358 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDGRXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 13:23:46 -0400
Received: by mail-oi1-f172.google.com with SMTP id x2so19537312oiv.2;
        Wed, 07 Apr 2021 10:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rkdu8+l6BGRFtlZuPgRS4588UVpEsZHH3+pJ7Lsomjo=;
        b=D3QkplMaPwTy+C869vIDCckIOOrIFcmiqL83pkVklo3ppNokYn+FJnZWDOo7nZYgaA
         8ydCszGIzAaJ+gAi9J66h8KA+aTQQG4/up1bDznmbCYsqiAIunCp/ORCsyykPuRdPdrr
         vEk9agAlILAC5KKkwqmN4C6I3VmicK0DCypG/Bv9/x6L7mz+UGI+iIeeaaiz2qytdHU8
         dI1nQn+vMiYpk+bfoaq1TZn8RF6qySLku/ONxspqL1QDQRszi8F+n9KLAgvfYDFppRu0
         fWNzH8363W6bRcmaV54tNb4zTaB7XUG2fIEY0TuUzMZ77fLd5Xrzme3Sp8fRAHNVvOGM
         1XsA==
X-Gm-Message-State: AOAM532suJnpA+NqgiNA2NGbURxqq9Ti3d9Ejwv1S4lSFs/0zWB2I6VW
        mxdRzkbW4OEw/YLR0C8gSHgLM6D3YbTvKnGor1U=
X-Google-Smtp-Source: ABdhPJzps5NTECKCtvxzufHr2bPXF8124nGW2e+neaAmOF2twcZBxLs/VpNnFWZ6vxEh1t3xQwXdTJLLkZyNbS8PJqs=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr3034768oie.157.1617816216713;
 Wed, 07 Apr 2021 10:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
 <20210331232614.304591-4-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0jS0Wfzq0M45ZbP2vNX4y=e+tvZjrmn4AiE+ycxij+CWg@mail.gmail.com> <579db6b4-d6ed-2dcb-b633-fe7fb94cb3c9@linux.intel.com>
In-Reply-To: <579db6b4-d6ed-2dcb-b633-fe7fb94cb3c9@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 19:23:25 +0200
Message-ID: <CAJZ5v0jVc4mQZVXGNFUYx1tk7pk4Sfkbj1aZV52GX-4VYnxb+Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] PM: runtime: remove kernel-doc warnings
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 4:13 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 4/1/21 8:40 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 1, 2021 at 1:26 AM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >> remove make W=1 warnings
> >>
> >> drivers/base/power/runtime.c:926: warning: Function parameter or
> >> member 'timer' not described in 'pm_suspend_timer_fn'
> >>
> >> drivers/base/power/runtime.c:926: warning: Excess function parameter
> >> 'data' description in 'pm_suspend_timer_fn'
> >>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >> ---
> >>   drivers/base/power/runtime.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> >> index fe1dad68aee4..1fc1a992f90c 100644
> >> --- a/drivers/base/power/runtime.c
> >> +++ b/drivers/base/power/runtime.c
> >> @@ -951,7 +951,7 @@ static void pm_runtime_work(struct work_struct *work)
> >>
> >>   /**
> >>    * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
> >> - * @data: Device pointer passed by pm_schedule_suspend().
> >> + * @timer: hrtimer used by pm_schedule_suspend().
> >>    *
> >>    * Check if the time is right and queue a suspend request.
> >>    */
> >> --
> >
> > I can apply this along with the [4-5/7].  Do you want me to do that?
>
> Works for me. I wasn't sure by looking at the MAINTAINERS file which
> files in drivers/base/ are maintained by whom, so sent the patches as a
> single set.

All three applied now as 5.13 material, thanks!
