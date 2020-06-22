Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3048203E4E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgFVRs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 13:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbgFVRs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 13:48:26 -0400
X-Greylist: delayed 1106 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Jun 2020 10:48:26 PDT
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950BC061573;
        Mon, 22 Jun 2020 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D6RYs2e9cp/tiQdgjUAxoJL7fGpw4g7U5+v8QSSYE+o=; b=RXfsOigMRTty6ZaUB7G7FJXMVv
        f25gQtP8ZWeaSDC+T5BEBziK6Qh4jMqv7/yXp5g4o8UmkRbxLdwJYNaNFJfIRMg7zjUXLSCZGN9EM
        gG+8rXX5LSu9ON0+l2oEWIigdXmqsFyPlhm5QqDR7g3jwUmX5n8kUxQORnFwNBhQxMNprfcSJriAw
        hVzpLG+h6Vy7bKHRWV5UEYvQSv7lwH5ehd3ZopU0YBF3V3Wn6/eLHBKvajKBA92GZYQS4D3Z8qTA4
        xRMwmxXNh+EPPMfIrbNeYlK0ibTwUCc+YNrvYYHNL5UpMcrGEF018JN3NIihc7SYAdAcqaq8zMD2b
        9XLyQ7Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnQGJ-00027e-Fr; Mon, 22 Jun 2020 17:29:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0050E303DA8;
        Mon, 22 Jun 2020 19:29:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6CE12B6335C0; Mon, 22 Jun 2020 19:29:36 +0200 (CEST)
Date:   Mon, 22 Jun 2020 19:29:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>
Subject: Re: [PATCH][v2] PM / s2idle: Clear _TIF_POLLING_NRFLAG before
 suspend to idle
Message-ID: <20200622172936.GA4781@hirez.programming.kicks-ass.net>
References: <20200616040442.21515-1-yu.c.chen@intel.com>
 <CAJZ5v0gBVBAjdCOXsM-Fa-iAkuv2JMi2mVkG5w7ADcg9dWencA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gBVBAjdCOXsM-Fa-iAkuv2JMi2mVkG5w7ADcg9dWencA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 22, 2020 at 06:19:35PM +0200, Rafael J. Wysocki wrote:
> > Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Peter, any more comments here?

Only that the whole s2idle stuff could do with a cleanup :-)

> > +static int call_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > +                      int index)
> > +{
> > +       if (!current_clr_polling_and_test())
> > +               s2idle_enter(drv, dev, index);
> > +
> > +       return index;
> 
> Is the value returned here used at all?
> 
> > +}
> > +
> >  /**
> >   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
> >   * @drv: cpuidle driver for the given CPU.
> > @@ -187,7 +197,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> >          */
> >         index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> >         if (index > 0)
> > -               enter_s2idle_proper(drv, dev, index);
> > +               call_s2idle(drv, dev, index);
> 
> I'm wondering why this can't be
> 
>     if (index > 0 && !current_clr_polling_and_test())
>             enter_s2idle_proper(drv, dev, index);

Works for me. Some Wysocki guy wrote much of it, best ask him :-)

The thing that confused me is that all this is way different from the
normal idle path and didn't keep the invariants.

Ideally; much of that gets folded back into the normal patch somehow.
