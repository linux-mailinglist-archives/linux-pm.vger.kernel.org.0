Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90188F592
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfHOUO4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 16:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40777 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOUO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 16:14:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyM92-0005Rc-Vs; Thu, 15 Aug 2019 22:14:49 +0200
Date:   Thu, 15 Aug 2019 22:14:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family
 15h/16h
In-Reply-To: <20190815153447.GH15313@zn.tnic>
Message-ID: <alpine.DEB.2.21.1908152212120.1908@nanos.tec.linutronix.de>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com> <20190815071940.GB15313@zn.tnic> <768aa720-1db1-81ca-4d0d-adf31f4d134b@amd.com> <20190815153447.GH15313@zn.tnic>
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

On Thu, 15 Aug 2019, Borislav Petkov wrote:
> On Thu, Aug 15, 2019 at 01:47:24PM +0000, Lendacky, Thomas wrote:
> > I think this is a clearer indication that the action has taken place.
> 
> Yeah, but what does that bring us? You wanna know this now, while
> testing. Once that whole effort is done, it is a useless printing of
> info which you have in cpuinfo already.

No. Print something useful in dmesg, telling the user that and also why
this has been disabled.

That avoids stupid questions and if they come up nevertheless we can reduce
the answer to LMGT4Y.

Thanks,

	tglx
