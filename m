Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4C193C07
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 10:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCZJg6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 05:36:58 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:59246 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgCZJg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 05:36:57 -0400
Received: from xps-7390.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48p0Hp5BJQz1SvC;
        Thu, 26 Mar 2020 05:36:54 -0400 (EDT)
Date:   Thu, 26 Mar 2020 02:36:53 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Zhang Rui <rui.zhang@intel.com>
cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <alpine.DEB.2.21.2003260225200.2971@xps-7390>
Message-ID: <alpine.DEB.2.21.2003260234210.26874@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>  <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>  <alpine.DEB.2.21.2003252353370.2971@xps-7390> <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com>
 <alpine.DEB.2.21.2003260225200.2971@xps-7390>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


(++Srinivas and the right(? other?) linux-pm mailing list)

On Thu, 26 Mar 2020, Zhang Rui wrote:

> what does "rdmsr 0x64D" return when there are 3 fixed counters?

$ sudo rdmsr 0x64D
56bcb63e
$ dmesg | fgrep RAPL
[    1.762354] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[    1.762359] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.762363] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.762365] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.179900] intel_rapl_common: Found RAPL domain package
[    4.053170] intel_rapl_common: Found RAPL domain package
[    4.055152] intel_rapl_common: Found RAPL domain core
[    4.057066] intel_rapl_common: Found RAPL domain uncore
$

> if it returns 0, which I think it is the case, does reading the msr
> from other cpus return non-zero value, by using rdmsr -p parameter?

Well, it didn't, but why not?

CPU 0 MSR 0x64d value: 57a289a6
CPU 1 MSR 0x64d value: 57a28bf7
CPU 2 MSR 0x64d value: 57a28e15
CPU 3 MSR 0x64d value: 57a28f3b
CPU 4 MSR 0x64d value: 57a28fe8
CPU 5 MSR 0x64d value: 57a2912a
CPU 6 MSR 0x64d value: 57a2923d
CPU 7 MSR 0x64d value: 57a29327

> > > if that is not the problem, please attach the output of "grep .
> > > /sys/class/powercap/intel-rapl*/name" in both cases.

Here's the "3 counters case" (same running kernel as above):

$ sudo egrep -r . /sys/class/powercap/intel-rapl*/name
/sys/class/powercap/intel-rapl:0:0/name:core
/sys/class/powercap/intel-rapl:0:1/name:uncore
/sys/class/powercap/intel-rapl:0/name:package-0
/sys/class/powercap/intel-rapl-mmio:0/name:package-0
$

As soon as I get "4 counters" numbers I'll resend with those values.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
