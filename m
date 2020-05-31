Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A72D1E9A8F
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 23:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgEaViw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 17:38:52 -0400
Received: from cmta17.telus.net ([209.171.16.90]:51276 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgEaViv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 17:38:51 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id fVfLjawOZmjwffVfMjxPtj; Sun, 31 May 2020 15:38:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590961130; bh=hZ+hhNier4XC/8ApzoxNCakA8kucvvlqVc02iJbZ+a0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=mc9J5VttWVXGnXJuxhhKjjlIVALj2VD0hRD6ZXcHggdc+YykWgAjs6vZGAZ6ZjHnU
         tV4PY06igY9a4Ni1GPpSnvw16XNklIcLkfxiErFi92JmabPo62fBn7LjJQQW5TD2um
         ZkUCpVRUTvv4ojwR2mVkmwwNqw9PBYJjEB6QHWRskJw4h5km1AceLbEqpHvCxB/t7P
         nC49SOEr08c7XsHNszMDvHt2Ai+Z9dbedvzhkSWi8ZJftp6cFedZzd9OI3qv9Yg/w6
         3BBIEZuw4hBl2eyOy+3Hrs4fPdeiLWnEkNvOob7CPbwsYKharZDSIALt145VpxKLnt
         dQ/Plq8urSVFQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ea5DgIMH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=KQQmxn6s5cfZ4KPhJ9QA:9
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
References: <2931539.RsFqoHxarq@kreacher>        <000001d6376a$03bbaae0$0b3300a0$@net>   <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>        <000201d63776$2d56f330$8804d990$@net>   <4793937b5e2b8b03a1aa0943bb5f62d17496cfee.camel@linux.intel.com> <0c2c0962167ecb854e962ed7e92991712f9db6ca.camel@linux.intel.com>
In-Reply-To: <0c2c0962167ecb854e962ed7e92991712f9db6ca.camel@linux.intel.com>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
Date:   Sun, 31 May 2020 14:38:45 -0700
Message-ID: <000301d63793$de8a3cd0$9b9eb670$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdY3gbdTaHrTgQCKS8CZRRAe2de7HQACG01g
X-CMAE-Envelope: MS4wfOFIoj/LUQLGIyTEwPUv/mgpJ8bclfelwgSrNTlOd0rwmlg0dnqE+7R9vjqGkz1AmUY3rCv11O9YmsMHGIh+wZqkc63h/Id5nboVFZyHrPU3lzUrxNfo
 FyPE/YwhpD7tKtql32nGISlfHDgubJs3o+W5L0ls4+hywtl3prQsaY3fq+Cwvd/tJH2ZjPPCBKBiB7Vvl6kL4Obvk5gthr9jMzegHeDgAlQjNBESLOSLoRDP
 USZeRKVje4pX39BIqAS/a5SjIC4R2gMSbx622RY23bW81wMumDlXb/1xMMrRFtEWMMdSas3y+Ro+DjQ+W9e1kgQMB/nMRq9N6AKiAYNWErYClXb0zFan+hWk
 oVUoBshmUnpqgJUiae96iqch0nZBodX3Nz2M24NtsxJSrayKqKjyNDwmdy2ucfEW0SPKY8xU
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.05.31 12:29 Srinivas Pandruvada wrote:
> On Sun, 2020-05-31 at 11:59 -0700, Srinivas Pandruvada wrote:
>> On Sun, 2020-05-31 at 11:06 -0700, Doug Smythies wrote:
>> > Hi Srinivas,
>> >
>> > Thanks you for your quick reply.
>> >
>> > On 2020.05.31 09:54 Srinivas Pandruvada wrote
>> > > On Sun, 2020-05-31 at 09:39 -0700, Doug Smythies wrote:
>> > > > Event begins at 17.456 seconds elapsed time.
>> > > > Previous event was about 107 milliseconds ago.
>> > > >
>> > > > Old min ; new min ; freq GHz; load % ; duration mS
>> > > > 27      ; 28      ; 4.60    ; 68.17  ; 10.226
>> > > > 28      ; 26      ; 4.53    ; 57.47  ; 10.005
>> > >
>> > > Seems you hit power/thermal limit
>> >
>> > No.
>> >
>> > I am nowhere near any power limit at all.
>> > I have meticulously configured and tested the thermal management of
>> > this computer.
>> > I never ever hit a thermal limit and have TDP set such that the
>> > processor
>> > temperature never exceeds about 75 degrees centigrade.
>> >
>> > There should never be throttling involved in these experiments.
>> > I can achieve throttling when compiling the kernel and with
>> > torture test mode on the mprime test (other CPU stressors,
>> > including my own, are not as good at generating heat as
>> > mprime).
>> >
>> > This system can run indefinitely at 99.9 watts processor package
>> > power.
>> > Example (turbostat, steady state, CPU freq throttled to 4.04 GHz):
>> >
>> > doug@s18:~$ sudo ~/turbostat --Summary --quiet --show
>> > Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 12
>> > Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
>> > 100.21  4045    72231   66      99.93   0.00
>> > 100.21  4043    72239   65      99.92   0.00
>> >
>> > > Is this some Lenovo system?
>> >
>> > No. The web page version of my original e-mail has
>> > a link to the test computer hardware profile.
>> >
>> > The motherboard is ASUS PRIME Z390-P.
>> >
>>
>> OK, this seems a desktop system.
>>
>> > > If you disable HWP you don't see that?
>> >
>> > Correct.
>> >
>> > > What is the value of
>> > > cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius
>> >
>> > ? "No such file or directory"
>> >
>> > > cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
>> > > mmio:0/constraint_0_power_limit_uw
>> You may not have
>> CONFIG_INT340X_THERMAL=y

I have:
CONFIG_INT340X_THERMAL=m

>>
>> What is
>> #rdmsr 0x1a2

From the turbostat startup spew of stuff
(also in a link on the web page version of the e-mail):

MSR_IA32_TEMPERATURE_TARGET: 0x0064100d (100 C)

Or manually now:

root@s18:/home/doug/prime95# rdmsr 0x1a2
64100d

>>
>> Try changing energy_perf_bias and see if it helps here.

Yes, that is a test I meant to do, and should have done.

No, it doesn't help.

>>
> Also if
> MSR 0x1FC bit 19 is 0, change to 1.
> 

Ya, I have always found documentation on 0x1FC somewhat lacking.
Anyway, the bit is already 1.
Is the bit EE_TURBO_DISABLE?
Anyway, I tried that bit as 0, and it didn't help.

> Thanks,
> Srinivas
> 

... Doug


