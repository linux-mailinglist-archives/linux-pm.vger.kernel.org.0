Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0365352B6A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhDBOY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 10:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhDBOY1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Apr 2021 10:24:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 169CD610D0;
        Fri,  2 Apr 2021 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617373466;
        bh=gI487BhAFPlE5oHkIiCHCYtn8mSEtMWk0Gw5ZEJJ/R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyMP8lNt4/WbeL9UPbMrvkumEXVarXIhzUAX/jn5ysmgx4ZbhnMKbkuyahKJMUpdj
         Tlr3iTOKIvUzGlqOc4ISrrFq900RU9DvRI4PzvOR8TdN18O8Ksf61HPuWrye/NsjyX
         gBKVf7N13XnniEICy4xm4YVsTXDSgcO2nNm1HZZA=
Date:   Fri, 2 Apr 2021 16:24:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/7] PM: runtime: remove kernel-doc warnings
Message-ID: <YGcpFzW7/Usqu9qL@kroah.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
 <20210331232614.304591-4-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0jS0Wfzq0M45ZbP2vNX4y=e+tvZjrmn4AiE+ycxij+CWg@mail.gmail.com>
 <579db6b4-d6ed-2dcb-b633-fe7fb94cb3c9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579db6b4-d6ed-2dcb-b633-fe7fb94cb3c9@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 01, 2021 at 09:13:18AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 4/1/21 8:40 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 1, 2021 at 1:26 AM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> > > 
> > > remove make W=1 warnings
> > > 
> > > drivers/base/power/runtime.c:926: warning: Function parameter or
> > > member 'timer' not described in 'pm_suspend_timer_fn'
> > > 
> > > drivers/base/power/runtime.c:926: warning: Excess function parameter
> > > 'data' description in 'pm_suspend_timer_fn'
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/base/power/runtime.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index fe1dad68aee4..1fc1a992f90c 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -951,7 +951,7 @@ static void pm_runtime_work(struct work_struct *work)
> > > 
> > >   /**
> > >    * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
> > > - * @data: Device pointer passed by pm_schedule_suspend().
> > > + * @timer: hrtimer used by pm_schedule_suspend().
> > >    *
> > >    * Check if the time is right and queue a suspend request.
> > >    */
> > > --
> > 
> > I can apply this along with the [4-5/7].  Do you want me to do that?
> 
> Works for me. I wasn't sure by looking at the MAINTAINERS file which files
> in drivers/base/ are maintained by whom, so sent the patches as a single
> set.

That's fine, we can work it out :)
