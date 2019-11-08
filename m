Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01145F4396
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 10:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfKHJj0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 04:39:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfKHJjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 04:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U6q7AamrEIGLRpishUTRmM5xQM7syIKBq8vx6TzfFww=; b=RkZ+7rzf2cPC5libGq+XzjraS
        D4VVzHijVNkXo4euixIK/2TggMmj+Uoz/ESax56F0t/jhpeDSGFCGlGRb0NpytVNIwS0qsc/bUCjQ
        P4rxlP3gmb0yPkJjIhghlI8/Yi7D3PDBm8QRafi+SMkvyoS+tgg/byc9KDVr3/VWQ3+g11nKhppf/
        xPf8erhKhrPFCRdAMdOnsOCAwplH46LP+bQuEWWftW6JdWsiFz8keRyRUpD+BRz3Uh9+i11uMnW2+
        LUy4sfn40rwnqLBDG6+cHVGeSAxv5CBeUXVF3X26FgjCOmPofYl7570vMQTkHpXKGh+p4fpFLGwyC
        lcQUzvFpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT0jh-0005GN-3g; Fri, 08 Nov 2019 09:39:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76B10305FC2;
        Fri,  8 Nov 2019 10:38:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DC8F2022B9E1; Fri,  8 Nov 2019 10:39:19 +0100 (CET)
Date:   Fri, 8 Nov 2019 10:39:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpuidle: Use nanoseconds as the unit of time
Message-ID: <20191108093919.GJ4114@hirez.programming.kicks-ass.net>
References: <10494959.bKODIZ00nm@kreacher>
 <3269796.AzLOQfDnpo@kreacher>
 <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jM3+qMvO6dx=FmK-xF0q3YKOwBf-yUPXSBfRjxJ59Cpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 08, 2019 at 02:44:13AM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 7, 2019 at 3:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Currently, the cpuidle subsystem uses microseconds as the unit of
> > time which (among other things) causes the idle loop to incur some
> > integer division overhead for no clear benefit.
> >
> > In order to allow cpuidle to measure time in nanoseconds, add two
> > additional fields, exit_latency_ns and target_residency_ns, to
> > represent the exit latency and target residency of an idle state
> > in nanoseconds, respectively, to struct cpuidle_state_usage and
> > initialize them with the help of the corresponding values in
> > microseconds provided by drivers.  In addition to that, change
> > cpuidle_governor_latency_req() to return the idle state exit
> > latency constraint in nanoseconds.
> >
> > With that, meeasure idle state residency (last_residency_ns in
> > struct cpuidle_device and time_ns in struct cpuidle_driver) in
> > nanoseconds and update the cpuidle core and governors accordingly.
> >
> > However, the menu governor still computes typical intervals in
> > microseconds to avoid integer overflows.
> 
> Since this addresses all of the comments received by the RFC version
> that was posted over a month ago and I don't see any more issues with
> it, I'm tempted to simply queue it up for 5.5 unless somebody sees a
> good enough reason why that would be a bad idea.

Nah, have at.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
