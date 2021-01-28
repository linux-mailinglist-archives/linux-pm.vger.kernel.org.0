Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E173307C89
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 18:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhA1RcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 12:32:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:12536 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233113AbhA1RbL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Jan 2021 12:31:11 -0500
IronPort-SDR: sHAyQ/Ak8dn/Oawho3x03DjJ+UPq/U3aHd9e86TQtauZUCzNgMJBCVK6jQ/jbirqxSILRq6gWh
 M5A7/1NPQUGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="180419008"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="180419008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:29:47 -0800
IronPort-SDR: xElNdHceLJIQ7IeLpvmRFYuffMneSb4iQ+rvSe+x2o98iSEHycdKIh3JGTehBAcEf42uknhElH
 cl2vLQa6vM+A==
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="388912346"
Received: from chengpol-mobl1.ccr.corp.intel.com ([10.249.170.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:29:45 -0800
Message-ID: <53074020f2b19a38811eec925457e828581658f3.camel@intel.com>
Subject: Re: [PATCH] thermal/intel: introduce tcc cooling driver
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     daniel.lezcano@linaro.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org
Date:   Fri, 29 Jan 2021 01:29:42 +0800
In-Reply-To: <000901d6f418$1a9b34e0$4fd19ea0$@net>
References: <20210115094744.21156-1-rui.zhang@intel.com>
         <002601d6ec2a$36663da0$a332b8e0$@net> <000901d6f418$1a9b34e0$4fd19ea0$@net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Doug,

On Tue, 2021-01-26 at 11:18 -0800, Doug Smythies wrote:
> Hi, Just a small follow up on this one:
> 
> On 2021.01.16 09:08 Doug Smythies wrote:
> > On 2021.01.15 Zhang Rui wrote:
> 
> ...
> > Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
> > 67.93   3773    134577  43      54.78
> > 
> > For unknown reason the processor seems to now
> > think it is not heavily loaded. From my MSR decoder:
> > 
> > 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 200020 AUTO AUTOL
> > 
> > From the book:
> > 
> > > Autonomous Utilization-Based Frequency Control
> > > Status (R0)
> > > When set, frequency is reduced below the operating
> > > system request because the processor has detected
> > > that utilization is low.
> > 
> > Which is not true.
> > 
> > Anyway,
> > 
> > Acked-by: Doug Smythies <dsmythies@telus.net>
> 

> O.K. there were 2 things wrong above:
> 
> 1.) I used the wrong intel SDM table for those bit definitions.
> They should have been: RATL and RATLL.
> 
> From the proper page of the book:
> 
> > Running Average Thermal Limit Status (R0)
> > When set, frequency is reduced below the operating
> > system request due to Running Average Thermal Limit
> > (RATL).
> 

> 2.) Due to the already discussed turbostat issue, that was not
> the actual temperature and so the RATL bit being set was actually
> valid at that time.
> 
On my side, I got the "Thermal status bit" set.

> I have not been able to find the time window knob for this, if there
> even is one, similar to the time window knobs for the package power
> limits.
> I wanted to reduce the time constant, just as a test, in an attempt
> to reduce the step function load potential temperature overshoot.
> 


> One additional informational follow up note:
> 
> There always seems to be a significant turn on transient to using the
> TCC offset, appearing as temperature undershoot. I am saying that
> an offset of 0 seems to also act as some sort of on/off switch to the
> running average.
> 
> Example 1 - start with offset 0:
> 
> $ sudo ~/turbostat --Summary --quiet --show
> Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
> 51.17   4600    3531    71      93.57
> 51.37   4600    3543    71      93.60
> 51.37   4600    3590    71      93.63  <<< offset changed from 0 to
> 24
> 50.99   3737    3566    52      43.49  <<< trip point = 76 degrees
> 51.20   3700    3550    51      41.14  <<< TCC offset turn on
> transient
> 51.09   3700    3559    51      41.30  <<< There was no need to
> throttle
> 51.12   3779    3515    53      43.78
> 50.95   4064    3553    58      55.57
> 51.55   4271    3522    63      65.30
> 51.18   4424    3534    67      76.58
> 51.27   4500    3532    68      84.12
> 51.14   4500    3529    68      84.14
> 51.24   4599    3522    71      93.61
> 51.14   4600    3523    71      93.71  <<< Eventually it does return
> to not throttled.
> 

> Example 2 - start with offset 1:
> 
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt
> 51.14   4600    3554    73      94.73
> 51.37   4600    3544    73      94.85
> 51.03   4600    3560    74      94.64 <<< offset changed from 1 to 24
> 51.33   4600    3508    73      94.88 <<< trip point = 76 degrees
> 51.14   4600    3526    73      94.69 <<< No TCC offset transient
> 51.22   4600    3614    73      94.85
> 51.24   4600    3531    73      94.84
> 51.50   4600    3578    73      94.92
> 51.15   4600    3571    73      94.77
> 51.20   4600    3521    73      94.91
> 51.19   4600    3550    73      94.76
> 51.27   4600    3522    74      94.81
> 51.27   4600    3530    74      94.98
> 
> 
Thanks for your test.
I'd prefer this is platform specific. 
Because it behaves really differently from what I observed.

$sudo turbostat --Summary --quiet --show
Busy%,Bzy_MHz,PkgTmp,PkgWatt,IRQ --interval 1
99.45	2216	10656	80	14.81  <<< start with offset=0
99.48	2234	10621	79	15.02
99.47	2233	10436	80	14.96
99.45	2236	10587	79	14.94
99.49	2216	10673	79	15.04
99.46	2226	10685	79	14.87
99.43	2233	10776	79	14.89
99.73	399	9139	66	4.51   <<< offset set to 50
99.76	212	8998	65	3.31
99.77	212	8902	64	3.27
...                                    <<< throttled for 20 seconds
99.76	212	8911	55	2.97
99.77	211	8851	55	2.95
99.76	211	8916	55	2.94
99.77	211	8844	55	3.05
99.77	211	8828	54	3.21
99.77	211	8911	54	3.05
99.74	212	8998	54	3.20
99.77	212	8802	54	2.90
99.77	211	8849	54	2.90
99.76	212	8942	53	2.98
99.76	211	9039	53	3.22
99.74	212	8977	53	2.89
99.77	211	8913	53	2.89
99.76	212	8900	53	2.89
99.77	211	8817	52	2.87
99.77	212	8923	52	2.88
99.77	212	8985	52	2.88
99.73	212	8877	52	2.86
99.58	575	9308	66	5.54    <<< offset set to 32
98.92	2460	13694	66	17.32
98.98	2298	13768	66	15.24
99.03	2244	14652	66	14.48
98.97	2198	14489	66	13.95
99.03	2148	14583	66	13.43
99.02	2107	14093	66	13.45
99.06	2060	13750	66	12.61
99.06	2036	14195	66	12.27
99.07	2007	14240	66	12.07   
99.12	2888	12147	98	28.23   <<< offset cleared
99.03	3413	11503	98	37.21
98.96	3317	11698	98	34.64
99.07	3246	11410	98	32.89
98.95	3210	12107	98	32.13
98.94	3164	11790	98	31.08
99.00	3124	12106	98	30.84
99.00	3086	11876	98	29.60
98.94	3054	12482	98	29.00
98.89	3030	12629	98	28.54
99.39	2377	10764	82	17.62   <<< Didn't do anything, so it
is probably thermald or something 
99.49	2200	10679	81	14.44
99.52	2211	10267	80	14.66
99.49	2221	10318	80	14.71
99.45	2220	10289	81	14.74
99.43	2222	10326	81	14.76

I tried both tests, and the results are the same, in both cases, it
starts throttling immediately (within a second), and no over-throttling 
observed.

Do you have a script to do this? Say, run turbostat in background and
then change tcc offset at certain timestamp? Maybe we can try exactly
the same test on different machines.

thanks,
rui

