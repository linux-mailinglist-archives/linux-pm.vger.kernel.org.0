Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7522F3057A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 01:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3XiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 19:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE3XiM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 May 2019 19:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0818F3082A9A;
        Thu, 30 May 2019 23:38:12 +0000 (UTC)
Received: from treble (ovpn-124-142.rdu2.redhat.com [10.10.124.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C437A462;
        Thu, 30 May 2019 23:38:07 +0000 (UTC)
Date:   Thu, 30 May 2019 18:38:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190530233804.syv4brpe3ndslyvo@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm>
 <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
 <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
 <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 30 May 2019 23:38:12 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 30, 2019 at 11:38:51PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 30, 2019 at 11:27 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, 30 May 2019, Rafael J. Wysocki wrote:
> > > >
> > > > Cc: stable@vger.kernel.org # v4.19+
> > > > Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > > > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > >
> > > LGTM
> > >
> > > And I would prefer this one to go in through the PM tree due to the
> > > hibernate core changes,
> >
> > Ok.
> >
> > > so can I get an ACK from the x86 arch side here, please?
> >
> > No. Is the following good enough?
> >
> >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Yes, it is, thanks!

I still think changing monitor/mwait to use a fixmap address would be a
much cleaner way to fix this.  I can try to work up a patch tomorrow.

-- 
Josh
