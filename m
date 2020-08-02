Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF2F23575D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHBOOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 10:14:42 -0400
Received: from cmta18.telus.net ([209.171.16.91]:45141 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHBOOm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 10:14:42 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 2El3kztd8qUs32El4kwnOR; Sun, 02 Aug 2020 08:14:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596377680; bh=CN/fUyh6opJ5vJi1/Nl1Yp+/imy9pfaN03xKOjmbT9E=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=gLYsrnb4IH6bArD+THINQqUeWy6q73DFicOjHiPwsFSF9Gh2GU3libf+0jS34FFty
         1FWULe7Ar3kQd6V6IJ4CHJPa/DTkva8Ecgx6MbspFuT8qNTR2mP7FwbsxTZCIOr+WQ
         jTVXJF7P77w3hkq46lateaksiOL3sPxVPftThQOwgVoJlSY6vtElkzgGQl0TzEuKNO
         8MCt857dk6fODMxv3Scz7GesQnDXewI9XNlP70/epUnilInQQsrUNID1U9+Nd3LPmN
         Hwlmzs+KjB1HbcFUQncAG6SLl9slYZPGSjhhR3Xh3PVTkXAg1Gme7TbIV61vXAkqNb
         ebT6Lv8oCRLpQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Mo8sFFSe c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
 a=UklZroHxuSD7NTiwK3MA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>  <13207937.r2GEYrEf4f@kreacher> <4684795.LlGW2geaUc@kreacher> <0fad4951dbd0143b43d4ec7b0dcab6787e0c7a97.camel@linux.intel.com>
In-Reply-To: <0fad4951dbd0143b43d4ec7b0dcab6787e0c7a97.camel@linux.intel.com>
Subject: RE: [PATCH v4 2/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Sun, 2 Aug 2020 07:14:36 -0700
Message-ID: <000401d668d7$426d8760$c7489620$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZoWn0mlfrYeATWTAeD6K2eVgHS6QAegGvw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfEzoaqLdow3a5Y6lALb9PkjOMLhyfrIOQNzzW+hgN4PayDZQydBAuIQ7pJgOMwT+Zl8VsL8Ome9hRnRjGFEQfE4OozrCJlZfRwq5d4/KzZh47FEnpv+k
 hbzCq9d6A56lOdlZIxlP+9+OQFqtD94KzmYilv/OGmEAWpf1LT+RLICX9G5qNyYcHdAlmPyMeBF4UeIOPkYQGS9LquVCnaDAH9YZBmjO4YqCm0GtQJaLjYZh
 v3/8MxFyGj7UxdBD1aLUpVYMR9vNZp+7eIm8NqijEAVjKcOkE0SEHfIBQW6TAZs6eHvmDGiCV+Y08ntOXviqOJ7egM76O/jmasiTCFDPYFIB7yp2ziwVTYue
 M0G42KoyEzecNyLlFzSXEOdah6lZcgh55SA2imcqOGBmDGtZMU4lniiFSXKdqDpDfLQY8bigt2Z6UtMJmAX1eiPTIaiBOA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.08.01 16:41 Srinivas Pandruvada wrote:
> On Tue, 2020-07-28 at 17:13 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it set the HWP minimum performance limit (HWP floor) to the
> > P-state value given by the target frequency supplied by the cpufreq
> > governor, so as to prevent the HWP algorithm and the CPU scheduler
> > from working against each other, at least when the schedutil governor
> > is in use, and update the intel_pstate documentation accordingly.
> >
> > Among other things, this allows utilization clamps to be taken
> > into account, at least to a certain extent, when intel_pstate is
> > in use and makes it more likely that sufficient capacity for
> > deadline tasks will be provided.
> >
> > After this change, the resulting behavior of an HWP system with
> > intel_pstate in the passive mode should be close to the behavior
> > of the analogous non-HWP system with intel_pstate in the passive
> > mode, except that in the frequency range below the base frequency
> > (ie. the frequency retured by the base_frequency cpufreq attribute
> > in sysfs on HWP systems) the HWP algorithm is allowed to go above
> > the floor P-state set by intel_pstate with or without hardware
> > coordination of P-states among CPUs in the same package.
> >
> Do you mean HWP.req.min will be below base_freq (unless user overrides
> it)?

No.

> With busy workload I see HWP req.min = HWP req.max.
> The base freq: 1.3GHz (ratio 0x0d), MAX 1C turbo: 3.9GHz (ratio: 0x27)
> When I monitor MSR 0x774 (HWP_REQ), I see
> 0x80002727

Yes, that is what I expect to see.

> 
> Normally msr 0x774
> 0x80002704

That would be "active" mode and the powersave governor, correct?.
And yes that is what I expect for your processor.
For mine, load or no load, decoded:
0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 :
    min:        8 :        8 :        8 :        8 :        8 :        8 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :

This thread is about passive mode, and myself, I do not expect the last byte to be
4 (8 for mine) under load.

... Doug


