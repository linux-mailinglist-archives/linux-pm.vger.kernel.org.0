Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D086EA3B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 19:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfGSRbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 13:31:45 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:52985 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbfGSRbo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 13:31:44 -0400
Received: from hp-x360 (173-8-203-89-Oregon.hfc.comcastbusiness.net [173.8.203.89])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 45qyjT3WcCz11Cf;
        Fri, 19 Jul 2019 13:31:41 -0400 (EDT)
Date:   Fri, 19 Jul 2019 10:31:40 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Zhang Rui <rui.zhang@intel.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
In-Reply-To: <1563550442.2455.1.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1907191030130.2853@hp-x360>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360>  <1563514893.2433.3.camel@intel.com>  <alpine.DEB.2.21.1907182308321.2769@hp-x360>  <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>  <alpine.DEB.2.21.1907190601580.2769@hp-x360>
 <1563550442.2455.1.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 19 Jul 2019, Zhang Rui wrote:

> please try the patch below and confirm if it helps or not.
>
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 19 Jul 2019 23:25:14 +0800
> Subject: [PATCH] powercap: adjust init order

The patch fixes the boot crash, yes.

----
$ dmesg | fgrep -i rapl
[    0.816376] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    0.816383] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.816387] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.816390] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    0.816394] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    1.098943] intel_rapl_common: Found RAPL domain package
[    1.100438] intel_rapl_common: Found RAPL domain dram
[    1.911092] intel_rapl_common: Found RAPL domain package
[    1.912577] intel_rapl_common: Found RAPL domain core
[    1.913989] intel_rapl_common: Found RAPL domain uncore
[    1.915343] intel_rapl_common: Found RAPL domain dram
$
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
