Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201591AD51C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDQEXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Apr 2020 00:23:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:25720 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgDQEXN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Apr 2020 00:23:13 -0400
IronPort-SDR: dADuwHyUmlgrbocEtleaCnj6uquCRXU6OLQao29VVq4kOdQCWTRQYIeeW9W0zM7BALaaHIxT+o
 mk43r6qx1C/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 21:23:13 -0700
IronPort-SDR: ZhC7B5BuLPXlFlKDjxKLdbaycScUHrR5tSJTp/wx6gFkWGpHwzPoXdEqrjx8T10YayZY+Mq3rM
 AQp2+TJ50ydw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="428097850"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 21:23:11 -0700
Date:   Fri, 17 Apr 2020 12:23:44 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Len Brown' <lenb@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3][v2] tools/power turbostat: Introduce functions to
 accumulate RAPL consumption
Message-ID: <20200417042344.GA27426@chenyu-office.sh.intel.com>
References: <cover.1586782089.git.yu.c.chen@intel.com>
 <db96fd31afd0ff65e4041665293b96c984e675bc.1586782089.git.yu.c.chen@intel.com>
 <001901d613a4$010e0a70$032a1f50$@net>
 <20200416170611.GA23628@chenyu-office.sh.intel.com>
 <001201d6142f$39fcde20$adf69a60$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201d6142f$39fcde20$adf69a60$@net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 16, 2020 at 01:40:09PM -0700, Doug Smythies wrote:
> On 2020.04.10:06 Chen Yu wrote:
> > On Wed, Apr 15, 2020 at 09:03:34PM -0700, Doug Smythies wrote:
> >> On 2020.04.15 05:57 Chen Yu wrote:
> > 
> >>> +	/*
> >>> +	 * A wraparound time is calculated early.
> >>> +	 */
> >>> +	its.it_interval.tv_sec = rapl_joule_counter_range;
> >> 
> >> Would this be o.K.?
> >> 
> >> +	its.it_interval.tv_sec = rapl_joule_counter_range / 2;
> >> 
> > This should be okay. I've checked the defination of TDP, and
> > on a wiki page it has mentioned that[1]:
> > "Some sources state that the peak power for a microprocessor
> > is usually 1.5 times the TDP rating"
> > although the defination of TDP varies, using 2 * TDP should
> > be safe.
> 
> O.K. Great.
> By the way, I have already tested it (in addition to the previously e-mailed patch correction):
> 
> First, with this:
> 
> 	its.it_interval.tv_sec = rapl_joule_counter_range;
> 
> Result:
> 
> sudo ./turbostat --Summary --interval 3200 --show Avg_MHz,Busy%,Bzy_MHz,IRQ,PkgTmp,PkgWatt,GFXWatt
> ...
> RAPL: 2759 sec. Joule Counter Range, at 95 Watts
> ...
> cpu0: MSR_PKG_POWER_INFO: 0x000002f8 (95 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
> cpu0: MSR_PKG_POWER_LIMIT: 0x4283e800dd8320 (UNlocked)
> cpu0: PKG Limit #1: ENabled (100.000000 Watts, 28.000000 sec, clamp ENabled)
> cpu0: PKG Limit #2: ENabled (125.000000 Watts, 0.002441* sec, clamp DISabled)
> ...
> Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 4039    100.20  4031    7211202 64      18.29   0.00
> 4033    100.22  4024    7254993 66      18.00   0.00
> 
> actual (using a shorter interval, that doesn't wrap around):
> 
> Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 4032    100.22  4023    676360  65      99.92   0.00
> 4029    100.23  4019    676629  65      99.91   0.00
> 4032    100.22  4023    676771  65      99.91   0.00
> 4037    100.22  4028    675430  65      99.91   0.00
> 4032    100.22  4023    675819  65      99.91   0.00
> 4028    100.23  4019    676541  65      99.91   0.00
> 4042    100.22  4033    675857  64      99.91   0.00
> 4029    100.23  4020    675597  65      99.91   0.00
> 4027    100.23  4017    676201  65      3751748943144.71        0.00
> 4034    100.22  4025    676402  65      99.91   0.00
> 4035    100.22  4026    674982  65      99.91   0.00
> 4032    100.22  4023    676012  64      99.91   0.00
> 4034    100.22  4025    723696  66      99.91   0.00
> 4039    100.22  4030    676342  64      99.91   0.00
> 4028    100.23  4018    676082  65      99.91   0.00
> 4028    100.23  4019    676218  65      99.91   0.00
> 4038    100.22  4030    675771  65      99.91   0.00
> 4031    100.22  4022    674282  65      3751749380702.93        0.00
> 4031    100.22  4022    676314  65      99.91   0.00
> 4039    100.22  4030    676197  65      99.91   0.00
> 
> And now with this:
> 
> 	its.it_interval.tv_sec = rapl_joule_counter_range / 2;
> 
> Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 4032    100.22  4023    7205931 65      99.91   0.00
> 4033    100.22  4023    7208003 65      99.91   0.00
> 4034    100.22  4024    7205563 65      99.91   0.00
> 
> and using the shorter interval:
> 
> Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 4028    100.23  4019    676147  64      99.92   0.00
> 4027    100.23  4017    675857  65      99.91   0.00
> 4036    100.22  4027    675736  65      99.91   0.00
> 4032    100.22  4023    674758  65      99.91   0.00
> 4032    100.22  4022    675692  65      99.91   0.00
> 4032    100.22  4023    676275  65      99.91   0.00
> 4043    100.22  4035    676001  66      99.91   0.00
> 4028    100.23  4019    676277  65      99.91   0.00
> 4028    100.23  4019    676420  65      99.91   0.00
> 4028    100.23  4019    675884  65      99.91   0.00
> 4037    100.22  4028    675293  65      99.91   0.00
> 4030    100.23  4021    674025  66      99.91   0.00
> 4031    100.22  4022    676462  65      99.91   0.00
> 4032    100.22  4023    676007  66      99.91   0.00
> 4047    100.21  4038    676424  65      99.91   0.00
> 4030    100.22  4021    676853  65      99.91   0.00
> 4028    100.23  4019    676553  65      99.91   0.00
> 4034    100.22  4025    675880  65      99.91   0.00
> 4036    100.22  4027    674824  65      99.91   0.00
> 4033    100.22  4024    674577  65      99.91   0.00
> 4031    100.22  4022    676599  65      99.91   0.00
> 4041    100.22  4032    676675  66      99.91   0.00
> 
> Note that it is very much on purpose that I have set
> TDP to 100 watts on this processor, whereas the
> default is 95 watts. Notice the package temperature,
> after several hours of running power throttled to
> a CPU frequency of 4.03 GHz.
>
Do you mind if I add Reviewed-by and Tested-by tag from you
in next version?

Thanks,
Chenyu
> ... Doug
> 
> 
