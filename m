Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B81235803
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHBPRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 11:17:45 -0400
Received: from cmta18.telus.net ([209.171.16.91]:38344 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgHBPRp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 11:17:45 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 2Fk3k07pBqUs32Fk5kwvbT; Sun, 02 Aug 2020 09:17:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596381463; bh=7yx5DHZVR4Bf4soMGU2O4bZ1p/Atq1qa07SFqPWXFMk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=VEgQ20gT9SmAepU+aT59dUcwDnchfiz4cegDrR0SYHTpHpUbn+NDC7pEGlIGkGaEy
         85NAzOrLvcVdd5btsjek4ZziRxls4hKQZoS+WM5ViznvsdE7jxEg4qk7vC4RBiarDw
         g2Pqs0zVYREtaQl62fIb2CGhcRgsEnFDz8q4XDsAo8UIqBSaFxxsuhDqQnHSQo9MXO
         bAHGwW71vOu2YaDCUn28hXlQmrYCWN93sZNq4nAgAAwxmeohjrivQNeNlrf4e4ujzD
         VVNGAZkNrN9G+GTArvvJlqpv5aLfvnb7pRc0Fm2BkUffFv6CLHnQlT9U7y+GHpzp+8
         h6hChavKO9dcw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Mo8sFFSe c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=QyXUC8HyAAAA:8 a=UsCfWBr0eeNdIiIU1ZUA:9 a=QEXdDO2ut3YA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <3955470.QvD6XneCf3@kreacher> <000f01d65ae8$0c607990$25216cb0$@net> <CAJZ5v0jGbfqfqqoPLjneFD5HLb20Yv9p25juNTzaumL70iFogg@mail.gmail.com> <001201d65c3f$6e2371c0$4a6a5540$@net> <CAJZ5v0j+gziYE0t+d2bBMZ3+4Daa0L_OiX+CeTtNU8Mkv0bCBA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+gziYE0t+d2bBMZ3+4Daa0L_OiX+CeTtNU8Mkv0bCBA@mail.gmail.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Sun, 2 Aug 2020 08:17:39 -0700
Message-ID: <000b01d668e0$11508160$33f18420$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZdwcgH6zLGOaAfSA21EJrq7yhj/wLHOiKg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfG/rL9C52wKK5hP+HOLGpqQlUp5Uzxjhdy/1fHo9eLK3ljt8H899s3S2Q8faN4Wb9ADIOs3Hu1F/eRI7b4HE7kJS0ruT97A6KZ2eEjwzWzwmIVBA89a6
 2UDs5MdZjzDAKT9BjZJFfo0aQJWVmuCnXJMEsEXozZqpqZXYEZXbg15F7Psw7Ozr1RQnJvWxRp7rudtd+GZUUBj9LUUTegVBVlFUIke11jelLDNFlrpe8Z2i
 Rf45OmIcadbzpf/CTH6owFHQiz91lBcmYTq3AQwrRmhmpuls4eBSjLRQiEiVPxrePkJCyTZxYo1vm0wG02dJBwanski3MIrgoSz9vLz7CdTljAKQXE7/WcyE
 zfRX8fuM+Il1htIJR9lubR8qgrlat8MBK3YMzqJ9c/4vNMU+rwCzQmTyS4MBqQSkU+tSuJ4HI8W0FdCysytdUXHo8Pvsf2lRdhey69heoMgncRo5Toc=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 2020.07.19 04:43 Rafael J. Wysocki wrote:
> On Fri, Jul 17, 2020 at 3:37 PM Doug Smythies <dsmythies@telus.net> wrote:
> > On 2020.07.16 05:08 Rafael J. Wysocki wrote:
> > > On Wed, Jul 15, 2020 at 10:39 PM Doug Smythies <dsmythies@telus.net> wrote:
> > >> On 2020.07.14 11:16 Rafael J. Wysocki wrote:
> > >> >
> > >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> ...
> > >> > Since the passive mode hasn't worked with HWP at all, and it is not going to
> > >> > the default for HWP systems anyway, I don't see any drawbacks related to making
> > >> > this change, so I would consider this as 5.9 material unless there are any
> > >> > serious objections.
> > >>
> > >> Good point.
> >
> > Actually, for those users that default to passive mode upon boot,
> > this would mean they would find themselves using this.
> > Also, it isn't obvious, from the typical "what driver and what governor"
> > inquiry.
> 
> So the change in behavior is that after this patch
> intel_pstate=passive doesn't imply no_hwp any more.
> 
> That's a very minor difference though and I'm not aware of any adverse
> effects it can cause on HWP systems anyway.

My point was, that it will now default to something where
testing has not been completed.

> The "what governor" is straightforward in the passive mode: that's
> whatever cpufreq governor has been selected.

I think you might have missed my point.
From the normal methods of inquiry one does not know
if HWP is being used or not. Why? Because with
or without HWP one gets the same answers under:

/sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

... Doug


