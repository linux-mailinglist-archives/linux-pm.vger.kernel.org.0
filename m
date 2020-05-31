Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1661E99C8
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgEaSGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 14:06:23 -0400
Received: from cmta16.telus.net ([209.171.16.89]:56877 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgEaSGS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 14:06:18 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id fSLejoJBf2DNIfSLfjKyaC; Sun, 31 May 2020 12:06:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590948377; bh=r5KOrq6Ds+ho7g3meSTHwvX+K3kZN2HxgXShNbekzZ4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Mq9zdrB326EOBCnhfmFD/rYRjPzaLqyKKORn/cdoQftUlsK3PrZv844HnKAy0tLl0
         Q7t1xsQXuIzV9cqlNeMuSVXr4dKdgpDmVtLxzne8k79O5XlhsLw9IUBAb5mLe06zd6
         MUUO/EsUpTUGa6/kcGy7nRv/IuVAMI9J8QuTTADpTIdigvg/xM6sHouWXvdCOJXUyH
         vj7bR5pYYbKQnrwY1flbqSDzGIaCP4SVlMpLFJ0tQnxVPA/mkAmI13r8q915oAgrtw
         EppCSmhngjomyBQ099syBdiYXRKXGacxLuHAFSivVSDSlHphijFhleQIeKKQXhukHs
         tLr4piyTvrUtw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=H+qlPNQi c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=745QobAnVKdQoEg0E7cA:9
 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2931539.RsFqoHxarq@kreacher>        <000001d6376a$03bbaae0$0b3300a0$@net> <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>
In-Reply-To: <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
Date:   Sun, 31 May 2020 11:06:13 -0700
Message-ID: <000201d63776$2d56f330$8804d990$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdY3bCT0dMErDJdzQFCwkA2hers8QwAA/SAw
X-CMAE-Envelope: MS4wfIcAZouttRHjxc46v52Sx1hEqlHfsIRf0xTsVbtv/+SBX7/jFO8q3KCbrNooKAWArZQnLaatv/DbcHJX3RF+gfr4fuKNd9xbdRnOHLSwitEHB2kTEUmv
 yRmAe0eNT3fl+Wu8qbCOGNc+/ROFEfMMCtUh7ZBV250fukhPtefmXPe8a4ghaEIczkdgmC7+pmnWr2eC1/F8fSxWTYHteYhk6COKZGq+6zdJYLy3sk4ZKsQO
 JEFPKyZ5AknuOPVIE+1j3zcZzR8pemfJkKcE+CK5JGZ/VgWMpw97KiOhX4TSwwOtX1bk2wWWczLrMTDu5yVVurQah8SkAbbLEdmD/4jTwzitTwf0oJFKG4DK
 jv1lBI3boDV65RpEu3YoYar9jpccLgm2iXoO1voJ6vtrOgjdV4f1g2brhsMgITUNhpImJfUn
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

Thanks you for your quick reply.

On 2020.05.31 09:54 Srinivas Pandruvada wrote
> On Sun, 2020-05-31 at 09:39 -0700, Doug Smythies wrote:

>> Event begins at 17.456 seconds elapsed time.
>> Previous event was about 107 milliseconds ago.
>>
>> Old min ; new min ; freq GHz; load % ; duration mS
>> 27      ; 28      ; 4.60    ; 68.17  ; 10.226
>> 28      ; 26      ; 4.53    ; 57.47  ; 10.005
> 
> Seems you hit power/thermal limit

No.

I am nowhere near any power limit at all.
I have meticulously configured and tested the thermal management of this computer.
I never ever hit a thermal limit and have TDP set such that the processor
temperature never exceeds about 75 degrees centigrade.

There should never be throttling involved in these experiments.
I can achieve throttling when compiling the kernel and with
torture test mode on the mprime test (other CPU stressors,
including my own, are not as good at generating heat as
mprime).

This system can run indefinitely at 99.9 watts processor package power.
Example (turbostat, steady state, CPU freq throttled to 4.04 GHz):

doug@s18:~$ sudo ~/turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 12
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
100.21  4045    72231   66      99.93   0.00
100.21  4043    72239   65      99.92   0.00

> 
> Is this some Lenovo system?

No. The web page version of my original e-mail has
a link to the test computer hardware profile.

The motherboard is ASUS PRIME Z390-P.

> 
> If you disable HWP you don't see that?

Correct.

> 
> What is the value of
> cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius

? "No such file or directory"

> cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
> mmio:0/constraint_0_power_limit_uw

? "No such file or directory"
 
> You may want to run
> Try running dptfxtract once.

No, I am not going to.

I am not running thermald. Eventually I will, as a backup
in case of cooling failure, so as not to hit the processor limit
shutdown. I just haven't done it yet.

> 
> Then try to get again
> 
> cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius
> cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
> mmio:0/constraint_0_power_limit_uw
> 
> 
> Thanks,
> Srinivas


