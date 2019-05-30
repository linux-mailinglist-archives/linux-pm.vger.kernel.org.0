Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E252C30487
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE3WDV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 18:03:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfE3WDV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 18:03:21 -0400
Received: from [207.225.69.115] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hWSaW-0005GO-4E; Thu, 30 May 2019 23:27:52 +0200
Date:   Thu, 30 May 2019 14:27:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Jiri Kosina <jikos@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm> <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 May 2019, Rafael J. Wysocki wrote:
> >
> > Cc: stable@vger.kernel.org # v4.19+
> > Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> > Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> LGTM
> 
> And I would prefer this one to go in through the PM tree due to the
> hibernate core changes,

Ok.

> so can I get an ACK from the x86 arch side here, please?

No. Is the following good enough?

    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
