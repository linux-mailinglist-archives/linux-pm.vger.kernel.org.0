Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D311E99FB
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgEaS7d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 14:59:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:50486 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgEaS7d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 14:59:33 -0400
IronPort-SDR: 9uOOC67XA79tDo/o0pxYM34LgIhTj09y/gbFkdtPIEwImiShULA0BTHH762qbloh6+4068gIF3
 3hz1lQ1GlXhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 11:59:32 -0700
IronPort-SDR: 56iY8jhYpdvBBecgymTD6YTS5a9w3t+NCJr7GpBavGewE9vX2aQxwyFe/x65dkdZGzFOeFS7Qh
 bk6LDZEU0Cuw==
X-IronPort-AV: E=Sophos;i="5.73,457,1583222400"; 
   d="scan'208";a="292954603"
Received: from nibndana-mobl2.ger.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.251.11.254])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 11:59:31 -0700
Message-ID: <4793937b5e2b8b03a1aa0943bb5f62d17496cfee.camel@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode
 with HWP enabled
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     'LKML' <linux-kernel@vger.kernel.org>,
        'Len Brown' <len.brown@intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Francisco Jerez' <francisco.jerez.plata@intel.com>,
        'Linux PM' <linux-pm@vger.kernel.org>
Date:   Sun, 31 May 2020 11:59:30 -0700
In-Reply-To: <000201d63776$2d56f330$8804d990$@net>
References: <2931539.RsFqoHxarq@kreacher>
         <000001d6376a$03bbaae0$0b3300a0$@net>
         <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>
         <000201d63776$2d56f330$8804d990$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-05-31 at 11:06 -0700, Doug Smythies wrote:
> Hi Srinivas,
> 
> Thanks you for your quick reply.
> 
> On 2020.05.31 09:54 Srinivas Pandruvada wrote
> > On Sun, 2020-05-31 at 09:39 -0700, Doug Smythies wrote:
> > > Event begins at 17.456 seconds elapsed time.
> > > Previous event was about 107 milliseconds ago.
> > > 
> > > Old min ; new min ; freq GHz; load % ; duration mS
> > > 27      ; 28      ; 4.60    ; 68.17  ; 10.226
> > > 28      ; 26      ; 4.53    ; 57.47  ; 10.005
> > 
> > Seems you hit power/thermal limit
> 
> No.
> 
> I am nowhere near any power limit at all.
> I have meticulously configured and tested the thermal management of
> this computer.
> I never ever hit a thermal limit and have TDP set such that the
> processor
> temperature never exceeds about 75 degrees centigrade.
> 
> There should never be throttling involved in these experiments.
> I can achieve throttling when compiling the kernel and with
> torture test mode on the mprime test (other CPU stressors,
> including my own, are not as good at generating heat as
> mprime).
> 
> This system can run indefinitely at 99.9 watts processor package
> power.
> Example (turbostat, steady state, CPU freq throttled to 4.04 GHz):
> 
> doug@s18:~$ sudo ~/turbostat --Summary --quiet --show
> Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 12
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 100.21  4045    72231   66      99.93   0.00
> 100.21  4043    72239   65      99.92   0.00
> 
> > Is this some Lenovo system?
> 
> No. The web page version of my original e-mail has
> a link to the test computer hardware profile.
> 
> The motherboard is ASUS PRIME Z390-P.
> 

OK, this seems a desktop system.

> > If you disable HWP you don't see that?
> 
> Correct.
> 
> > What is the value of
> > cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius
> 
> ? "No such file or directory"
> 

> > cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
> > mmio:0/constraint_0_power_limit_uw
> 
You may not have
CONFIG_INT340X_THERMAL=y

What is
#rdmsr 0x1a2

Try changing energy_perf_bias and see if it helps here.

Thanks,
Srinivas


> ? "No such file or directory"
>  
> > You may want to run
> > Try running dptfxtract once.
> 
> No, I am not going to.
> 
> I am not running thermald. Eventually I will, as a backup
> in case of cooling failure, so as not to hit the processor limit
> shutdown. I just haven't done it yet.
> 
> > Then try to get again
> > 
> > cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius
> > cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
> > mmio:0/constraint_0_power_limit_uw
> > 
> > 
> > Thanks,
> > Srinivas
> 
> 

