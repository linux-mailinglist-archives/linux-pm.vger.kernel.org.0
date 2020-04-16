Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC321AD153
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgDPUkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 16:40:16 -0400
Received: from cmta19.telus.net ([209.171.16.92]:37658 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgDPUkP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 16:40:15 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id PBIwjhLWDFblkPBIxj6pVE; Thu, 16 Apr 2020 14:40:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1587069613; bh=kMrSu5wL+W/PT4AK4fBhYDNmaytt313olJcVR9Tlz1g=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=tKMoiJzjnG4seufXgIta8ArcQIDrvLyDrKglytbfYtWYoq5d1pY7d2dC9EwaAVGT3
         LosdB78kONx/JQw8lZ9BZQDjAB8zNjhn1ZEG+xvTI2pkHy7+bkeMrjcss+JDwSuXA7
         pXh2O3ihrPJox7LxneIgGhjC3xUh/RR5twnTmeJn6LEg13ITxUI5dE3FH3RP7nKmJN
         W0dzMAcpmfbimLPmdWQWiJxfMd9BAHp0FiIleSNGlvFL1S/45Bg9cQgyps1HSYRZg9
         2NDAwe2e8QTpFfv8hIHr3IvPdx5nNTcvX3kmTUhtWfJgcDpESKavrXOcuDitWP9ihh
         73V207wd1t1Qg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=BNTNU2YG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=Ic_2fVt4t7qr8CzPNX0A:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Chen Yu'" <yu.c.chen@intel.com>
Cc:     "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <cover.1586782089.git.yu.c.chen@intel.com> <db96fd31afd0ff65e4041665293b96c984e675bc.1586782089.git.yu.c.chen@intel.com> <001901d613a4$010e0a70$032a1f50$@net> <20200416170611.GA23628@chenyu-office.sh.intel.com>
In-Reply-To: <20200416170611.GA23628@chenyu-office.sh.intel.com>
Subject: RE: [PATCH 2/3][v2] tools/power turbostat: Introduce functions to accumulate RAPL consumption
Date:   Thu, 16 Apr 2020 13:40:09 -0700
Message-ID: <001201d6142f$39fcde20$adf69a60$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYUEUlAclnAOCYlSaea7n5JOlcPYAAHAhlw
X-CMAE-Envelope: MS4wfMI4Diz8wlDDwDXTilLSmN6awGayPgr4FX4048AH1mpBUd26YhPDXL1JdzVXnqEKKcZVfJgXUT7KpaAGct5mXxdhhk0zMwHcZCr5aNe/Y23zfV5yaNsU
 4oK3hW61E9q5I1ynDhhXRGrM6mL5SmgwM94luH/3u0eaZQTXWLa2yjt4Bmuurg/dUymywk08L3xDgemI9g7hCRK2tjnEz5VcfUcEuMmNmlHPOEby63Zm1mbQ
 cYynMKeHADu/40OseeHzWNhUtFTwzvafqbrvzK4pi7KEvAp7niKFNcbQb8UVLrFJ
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.04.10:06 Chen Yu wrote:
> On Wed, Apr 15, 2020 at 09:03:34PM -0700, Doug Smythies wrote:
>> On 2020.04.15 05:57 Chen Yu wrote:
> 
>>> +	/*
>>> +	 * A wraparound time is calculated early.
>>> +	 */
>>> +	its.it_interval.tv_sec = rapl_joule_counter_range;
>> 
>> Would this be o.K.?
>> 
>> +	its.it_interval.tv_sec = rapl_joule_counter_range / 2;
>> 
> This should be okay. I've checked the defination of TDP, and
> on a wiki page it has mentioned that[1]:
> "Some sources state that the peak power for a microprocessor
> is usually 1.5 times the TDP rating"
> although the defination of TDP varies, using 2 * TDP should
> be safe.

O.K. Great.
By the way, I have already tested it (in addition to the previously e-mailed patch correction):

First, with this:

	its.it_interval.tv_sec = rapl_joule_counter_range;

Result:

sudo ./turbostat --Summary --interval 3200 --show Avg_MHz,Busy%,Bzy_MHz,IRQ,PkgTmp,PkgWatt,GFXWatt
...
RAPL: 2759 sec. Joule Counter Range, at 95 Watts
...
cpu0: MSR_PKG_POWER_INFO: 0x000002f8 (95 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
cpu0: MSR_PKG_POWER_LIMIT: 0x4283e800dd8320 (UNlocked)
cpu0: PKG Limit #1: ENabled (100.000000 Watts, 28.000000 sec, clamp ENabled)
cpu0: PKG Limit #2: ENabled (125.000000 Watts, 0.002441* sec, clamp DISabled)
...
Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
4039    100.20  4031    7211202 64      18.29   0.00
4033    100.22  4024    7254993 66      18.00   0.00

actual (using a shorter interval, that doesn't wrap around):

Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
4032    100.22  4023    676360  65      99.92   0.00
4029    100.23  4019    676629  65      99.91   0.00
4032    100.22  4023    676771  65      99.91   0.00
4037    100.22  4028    675430  65      99.91   0.00
4032    100.22  4023    675819  65      99.91   0.00
4028    100.23  4019    676541  65      99.91   0.00
4042    100.22  4033    675857  64      99.91   0.00
4029    100.23  4020    675597  65      99.91   0.00
4027    100.23  4017    676201  65      3751748943144.71        0.00
4034    100.22  4025    676402  65      99.91   0.00
4035    100.22  4026    674982  65      99.91   0.00
4032    100.22  4023    676012  64      99.91   0.00
4034    100.22  4025    723696  66      99.91   0.00
4039    100.22  4030    676342  64      99.91   0.00
4028    100.23  4018    676082  65      99.91   0.00
4028    100.23  4019    676218  65      99.91   0.00
4038    100.22  4030    675771  65      99.91   0.00
4031    100.22  4022    674282  65      3751749380702.93        0.00
4031    100.22  4022    676314  65      99.91   0.00
4039    100.22  4030    676197  65      99.91   0.00

And now with this:

	its.it_interval.tv_sec = rapl_joule_counter_range / 2;

Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
4032    100.22  4023    7205931 65      99.91   0.00
4033    100.22  4023    7208003 65      99.91   0.00
4034    100.22  4024    7205563 65      99.91   0.00

and using the shorter interval:

Avg_MHz Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
4028    100.23  4019    676147  64      99.92   0.00
4027    100.23  4017    675857  65      99.91   0.00
4036    100.22  4027    675736  65      99.91   0.00
4032    100.22  4023    674758  65      99.91   0.00
4032    100.22  4022    675692  65      99.91   0.00
4032    100.22  4023    676275  65      99.91   0.00
4043    100.22  4035    676001  66      99.91   0.00
4028    100.23  4019    676277  65      99.91   0.00
4028    100.23  4019    676420  65      99.91   0.00
4028    100.23  4019    675884  65      99.91   0.00
4037    100.22  4028    675293  65      99.91   0.00
4030    100.23  4021    674025  66      99.91   0.00
4031    100.22  4022    676462  65      99.91   0.00
4032    100.22  4023    676007  66      99.91   0.00
4047    100.21  4038    676424  65      99.91   0.00
4030    100.22  4021    676853  65      99.91   0.00
4028    100.23  4019    676553  65      99.91   0.00
4034    100.22  4025    675880  65      99.91   0.00
4036    100.22  4027    674824  65      99.91   0.00
4033    100.22  4024    674577  65      99.91   0.00
4031    100.22  4022    676599  65      99.91   0.00
4041    100.22  4032    676675  66      99.91   0.00

Note that it is very much on purpose that I have set
TDP to 100 watts on this processor, whereas the
default is 95 watts. Notice the package temperature,
after several hours of running power throttled to
a CPU frequency of 4.03 GHz.

... Doug


