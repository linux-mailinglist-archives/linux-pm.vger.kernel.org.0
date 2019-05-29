Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483A52E207
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfE2QKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 12:10:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58631 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QKk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 12:10:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A594E30B97AA;
        Wed, 29 May 2019 16:10:34 +0000 (UTC)
Received: from treble (ovpn-123-24.rdu2.redhat.com [10.10.123.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56CDF17A8F;
        Wed, 29 May 2019 16:10:30 +0000 (UTC)
Date:   Wed, 29 May 2019 11:10:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190529161028.a6kpywzpjazgql5u@treble>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 29 May 2019 16:10:39 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 29, 2019 at 12:32:02PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> As explained in
> 
> 	0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> 
> we always, no matter what, have to bring up x86 HT siblings during boot at 
> least once in order to avoid first MCE bringing the system to its knees.
> 
> That means that whenever 'nosmt' is supplied on the kernel command-line, 
> all the HT siblings are as a result sitting in mwait or cpudile after 
> going through the online-offline cycle at least once.
> 
> This causes a serious issue though when a kernel, which saw 'nosmt' on its 
> commandline, is going to perform resume from hibernation: if the resume 
> from the hibernated image is successful, cr3 is flipped in order to point 
> to the address space of the kernel that is being resumed, which in turn 
> means that all the HT siblings are all of a sudden mwaiting on address 
> which is no longer valid.
> 
> That results in triple fault shortly after cr3 is switched, and machine 
> reboots.
> 
> Fix this by always waking up all the SMT siblings before initiating the 
> 'restore from hibernation' process; this guarantees that all the HT 
> siblings will be properly carried over to the resumed kernel waiting in 
> resume_play_dead(), and acted upon accordingly afterwards, based on the 
> target kernel configuration.

hibernation_restore() is called by user space at runtime, via ioctl or
sysfs.  So I think this still doesn't fix the case where you've disabled
CPUs at runtime via sysfs, and then resumed from hibernation.  Or are we
declaring that this is not a supported scenario?

Would it be possible for mwait_play_dead() to instead just monitor a
fixmap address which doesn't change for kaslr?

Is there are reason why maxcpus= doesn't do the CR4.MCE booted_once
dance?

-- 
Josh
