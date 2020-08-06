Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7631D23D69A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 07:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHFFyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 01:54:55 -0400
Received: from cmta19.telus.net ([209.171.16.92]:41095 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgHFFyy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 01:54:54 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 3YrYk5XS8pULu3YrakoH4d; Wed, 05 Aug 2020 23:54:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596693292; bh=ZKRCmfmY7qH1fYpcTFnkxc4BBI/P+hB+ur+vMXpXInE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=cYf8dodneEcXRANPNqohD4vRf1YhXlcXh+fZWg+2Jpa1HXqUO2bj5cP5bpDrWkJS0
         X7+zOH4JQQfAMo5ic0hieekcLF9p3HF+QsJZsjBRosQsNFooHK/kQns4dAFI3Kh9Ge
         I8iAo5spxKcKv/oAGRsnfAs7LRKvxW7lc2D+C6pfxJb+Ry5qUOYjl6akaRzTGi/6F3
         zApE5gUaCFg8aHpOZWv25TdEH+moCwYM1wGTg/+FTcWsp9aPgkqTO0Gn8ISSNzBNtG
         BGhNRK6aKyCFKTWhIrQ+aeW4HkY/C0H5Ose+61dlfQI41X4v8G8EBSRT4ZEzRXvg/j
         1OPSO+pjToeCQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8
 a=QyXUC8HyAAAA:8 a=kxsy6qjK8mjSY2g15b0A:9 a=CjuIK1q_8ugA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <3955470.QvD6XneCf3@kreacher> <CAJZ5v0j+gziYE0t+d2bBMZ3+4Daa0L_OiX+CeTtNU8Mkv0bCBA@mail.gmail.com> <000b01d668e0$11508160$33f18420$@net> <2418846.A4mPlhI7ni@kreacher>
In-Reply-To: <2418846.A4mPlhI7ni@kreacher>
Subject: RE: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Wed, 5 Aug 2020 22:54:47 -0700
Message-ID: <004601d66bb6$199ce1a0$4cd6a4e0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZpuL2bqTQ7WVOQQDGjuypkZ2m0fQB/FDrw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfNeNeYgtpMCRSyru0hnnAznLpIvQeKA3hO2SbSq2DdMtsX1dcU3AOaz5jRYZe1Iu0rbgkIfXcTLyKRhaShDxshuUaj9DoQntc+bLcKc49Db9p0A/+hWz
 Dd3hddYsNbsTFxopZ/1W/irsqKGQhKR8z8jxhWkkD8EzhVVgLBLVHSWDfStldxgh2bYmWTEhlaDQxjxPGC92XkZZTiExZ/ExFAkfOtITCbNG6NLdpBNMbg6Y
 5M72MeZwaq2pTBpAk6kaN19cL33Q2WhVc+FNCBYY2Flo8VDCNbZzwX4UPWkm+ForjdlxnYPZZuMpVeGqhHMqmShyvpH2ahM98DqCtL9y7MDrGA5bAe2LWxG0
 hDYmWeXFH865H/0xbJ/+KhVci6lsaTbaOmAKo+j0OtfOnREeoVf7aNKWorjmjmHNy4CR6tXjYqlUV7/JdBbQTD3jg5C+6568AfSvZ9iBSMyxKGTralE=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.08.03 10:09 Rafael J. Wysocki wrote:
> On Sunday, August 2, 2020 5:17:39 PM CEST Doug Smythies wrote:
> > On 2020.07.19 04:43 Rafael J. Wysocki wrote:
> > > On Fri, Jul 17, 2020 at 3:37 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > On 2020.07.16 05:08 Rafael J. Wysocki wrote:
> > > > > On Wed, Jul 15, 2020 at 10:39 PM Doug Smythies <dsmythies@telus.net> wrote:
> > > > >> On 2020.07.14 11:16 Rafael J. Wysocki wrote:
> > > > >> >
> > > > >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >> ...
> > > > >> > Since the passive mode hasn't worked with HWP at all, and it is not going to
> > > > >> > the default for HWP systems anyway, I don't see any drawbacks related to making
> > > > >> > this change, so I would consider this as 5.9 material unless there are any
> > > > >> > serious objections.
> > > > >>
> > > > >> Good point.
> > > >
> > > > Actually, for those users that default to passive mode upon boot,
> > > > this would mean they would find themselves using this.
> > > > Also, it isn't obvious, from the typical "what driver and what governor"
> > > > inquiry.
> > >
> > > So the change in behavior is that after this patch
> > > intel_pstate=passive doesn't imply no_hwp any more.
> > >
> > > That's a very minor difference though and I'm not aware of any adverse
> > > effects it can cause on HWP systems anyway.
> >
> > My point was, that it will now default to something where
> > testing has not been completed.
> >
> > > The "what governor" is straightforward in the passive mode: that's
> > > whatever cpufreq governor has been selected.
> >
> > I think you might have missed my point.
> > From the normal methods of inquiry one does not know
> > if HWP is being used or not. Why? Because with
> > or without HWP one gets the same answers under:
> >
> > /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
> > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
> Yes, but this is also the case in the active mode, isn't it?

Yes, fair enough.
But we aren't changing what it means by default
between kernel 5.8 and 5.9-rc1.

... Doug


