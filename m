Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779B0193C57
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgCZJyc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 05:54:32 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:63610 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgCZJyc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 05:54:32 -0400
Received: from xps-7390.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 48p0h51GZfz1TMS;
        Thu, 26 Mar 2020 05:54:28 -0400 (EDT)
Date:   Thu, 26 Mar 2020 02:54:27 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Zhang Rui <rui.zhang@intel.com>
cc:     linux-pm@lists.linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: Why do I sometimes "lose" the "psys" RAPL counter?
In-Reply-To: <alpine.DEB.2.21.2003260234210.26874@xps-7390>
Message-ID: <alpine.DEB.2.21.2003260247290.3029@xps-7390>
References: <alpine.DEB.2.21.2003252212220.2971@xps-7390>  <691eb7a6efd7a954295f234a70f548fd0c81e2f8.camel@intel.com>  <alpine.DEB.2.21.2003252353370.2971@xps-7390> <7e1562ce93b83a685aa54dd2ae5a5b36c5737cb6.camel@intel.com> <alpine.DEB.2.21.2003260225200.2971@xps-7390>
 <alpine.DEB.2.21.2003260234210.26874@xps-7390>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> > what does "rdmsr 0x64D" return when there are [now 4] fixed counters?

OK, so I rebooted after a power cycle, and here's the results with 4
fixed counters (i.e., it sees the "psys domain"):

$ sudo rdmsr 0x64D
a6e824
$ dmesg | fgrep RAPL
[    1.761697] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    1.761703] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    1.761706] RAPL PMU: hw unit of domain package 2^-14 Joules
[    1.761709] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.761712] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    3.119434] intel_rapl_common: Found RAPL domain package
[    4.007495] intel_rapl_common: Found RAPL domain package
[    4.009635] intel_rapl_common: Found RAPL domain core
[    4.011749] intel_rapl_common: Found RAPL domain uncore

> > if it returns 0, which I think it is the case, does reading the msr
> > from other cpus return non-zero value, by using rdmsr -p parameter?

Here's the "4 counters" case:

MSR value on CPU 0 for 0x64D is: 1079240
MSR value on CPU 1 for 0x64D is: 10793e2
MSR value on CPU 2 for 0x64D is: 1079512
MSR value on CPU 3 for 0x64D is: 10796e4
MSR value on CPU 4 for 0x64D is: 107987d
MSR value on CPU 5 for 0x64D is: 1079a23
MSR value on CPU 6 for 0x64D is: 1079ab2
MSR value on CPU 7 for 0x64D is: 1079b4e

> > > > if that is not the problem, please attach the output of "grep .
> > > > /sys/class/powercap/intel-rapl*/name" in both cases.

Here's the "4 counters case" (same running kernel as above):

$ sudo egrep -r . /sys/class/powercap/intel-rapl*/name
/sys/class/powercap/intel-rapl:0:0/name:core
/sys/class/powercap/intel-rapl:0:1/name:uncore
/sys/class/powercap/intel-rapl:0/name:package-0
/sys/class/powercap/intel-rapl:1/name:psys
/sys/class/powercap/intel-rapl-mmio:0/name:package-0
$

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
