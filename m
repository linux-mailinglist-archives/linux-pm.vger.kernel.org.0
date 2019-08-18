Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7F917D8
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHRQcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 12:32:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44787 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRQcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 12:32:41 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzO6Y-0008RU-Iy; Sun, 18 Aug 2019 18:32:30 +0200
Date:   Sun, 18 Aug 2019 18:32:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family
 15h/16h
In-Reply-To: <919c80f1-53a5-44d2-d785-88890e449b38@citrix.com>
Message-ID: <alpine.DEB.2.21.1908181831340.1923@nanos.tec.linutronix.de>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com> <a24a2c7d-cfab-a049-37e8-7260a9063a7c@citrix.com> <20190815210547.GL15313@zn.tnic> <312b307b-19cc-84f8-97e6-07dbdf07dd12@citrix.com> <20190817084410.GA15364@zn.tnic>
 <919c80f1-53a5-44d2-d785-88890e449b38@citrix.com>
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

On Sat, 17 Aug 2019, Andrew Cooper wrote:
> On 17/08/2019 09:44, Borislav Petkov wrote:
> > On Thu, Aug 15, 2019 at 10:25:24PM +0100, Andrew Cooper wrote:
> >> I'm afraid that a number of hypervisors do write-discard, given the
> >> propensity of OSes (certainly traditionally) to go poking at bits like
> >> this without wrmsr_safe().
> >>
> >> You either need to read the MSR back and observe that the bit has really
> >> changed, or in this case as Thomas suggests, look at CPUID again (which
> >> will likely be the faster option for the non-virtualised case).
> > One thing I didn't think of when we talked about this: this happens only
> > after you resume the hypervisor.
> 
> :) It hadn't escaped my notice, hence the intervention on this thread.
> 
> > And the words "resume the hypervisor" already means an improbable use case.
> 
> Qubes and OpenXT are two laptop+hypervisor oriented distros where
> suspend/resume is a big deal, and these will have to follow AMD's
> recommendation here.
> 
> However, for servers which don't do S3/S4, we can reason about safely
> leaving RDRAND enabled, irrespective of guest configuration.

Let the administrator reason about it. Default is off for sanity sake.

Thanks,

	tglx
