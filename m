Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D676C6043E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfGEKNo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 06:13:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55410 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGEKNn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 06:13:43 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 83bbb67b149af7d0; Fri, 5 Jul 2019 12:13:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL driver
Date:   Fri, 05 Jul 2019 12:13:41 +0200
Message-ID: <3695289.DUDsO16Ie3@kreacher>
In-Reply-To: <52eaefed-8f94-8cb0-0cfa-c0c16a34bd0b@linux.intel.com>
References: <20190614080523.13464-1-rajneesh.bhardwaj@linux.intel.com> <2359736.lHFMKXy7DL@kreacher> <52eaefed-8f94-8cb0-0cfa-c0c16a34bd0b@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, June 28, 2019 10:21:41 AM CEST Bhardwaj, Rajneesh wrote:
> 
> On 28-Jun-19 3:32 AM, Rafael J. Wysocki wrote:
> > On Friday, June 14, 2019 10:05:23 AM CEST Rajneesh Bhardwaj wrote:
> >> Enables support for ICL-NNPI, which is a neural network processor for deep
> >> learning inference. From RAPL point of view it is same as Ice Lake Mobile
> >> processor.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: linux-pm@vger.kernel.org
> >> Link: https://lkml.org/lkml/2019/6/5/1034
> >> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> >> ---
> >>   drivers/powercap/intel_rapl.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> >> index 4347f15165f8..431c8c8bdf07 100644
> >> --- a/drivers/powercap/intel_rapl.c
> >> +++ b/drivers/powercap/intel_rapl.c
> >> @@ -1157,6 +1157,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
> >>   	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
> >>   	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
> >>   	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
> >> +	INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),
> >>   
> >>   	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
> >>   	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
> >>
> > It is in my queue, but I get build errors when I try to apply it.
> >
> > I guess the definition of ICELAKE_NNPI is not there in the Linus' tree yet.
> 
> Yes, though 
> https://www.spinics.net/lists/linux-tip-commits/msg48978.html is 
> accepted by Thomas already.

It is not in 5.2-rc7, though, AFAICS.

The patch is still in my queue and waiting.



