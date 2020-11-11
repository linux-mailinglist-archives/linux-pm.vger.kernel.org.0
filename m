Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6120C2AFC30
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 02:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKLBd3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 20:33:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:38646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgKKXNE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 18:13:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C78ABAB95;
        Wed, 11 Nov 2020 23:13:02 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: Off-topic therml_stats - trans_table - File too large (exceeding static page alloc)
Date:   Thu, 12 Nov 2020 00:13:00 +0100
Message-ID: <4549593.l9KlQ6ThGW@c100>
In-Reply-To: <20201111103018.6xixvclldfw4m3ok@vireshk-i7>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org> <4294133.gPUqu62deI@c100> <20201111103018.6xixvclldfw4m3ok@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 11. November 2020, 11:30:18 CET schrieb Viresh Kumar:
> On 11-11-20, 09:42, Thomas Renninger wrote:
> > Hi,
> > 
> > sorry for high-jacking this thread, it is at least related and afaik you
> > are deeper involved in this:
..
> > and when it seem to get interesting (device 4 and 5), I get:
> How many total states are there ? Must be really large.
..

Ah, yes. The first 4 devices which have 3 thermal states seem to be connected to each CPU
via ACPI:
/sys/devices/virtual/thermal/cooling_device0/device -> ../../../LNXSYSTM:00/LNXCPU:00

The latter two, device 4+5 do not have this "device" sysfs link at all and cooling_device4 has 50,
cooling_device5 20 states.

All cooling devices max_state:
cat /sys/devices/virtual/thermal/cooling_device*/max_state 
3
3
3
3
50
20

cur_state is 0 by default for all.
Doing something like (not sure it was a 2):
echo 2 >/sys/devices/virtual/thermal/cooling_device4/cur_state
ends up in:
Nov 11 23:33:27 c100 kernel: NOHZ: local_softirq_pending 80
Nov 11 23:33:27 c100 kernel: NOHZ: local_softirq_pending 80
Nov 11 23:33:21 c100 kernel: intel_powerclamp: Start idle injection to reduce power
in kernel logs.

But echoing this static cur_state number in, seem to trigger dynamic adjusting
and the number gets up and down by itself:

while true;do cat /sys/devices/virtual/thermal/cooling_device4/cur_state;sleep 1;done
86
83
89
90
90
92
91
^C
c100:/home/trenn # cat /sys/devices/virtual/thermal/cooling_device4/max_state
50

Disabling works with setting cur_state to 0, but cur_state is -1 afterwards ?!?:
echo 0 >/sys/devices/virtual/thermal/cooling_device4/cur_state
cat /sys/devices/virtual/thermal/cooling_device4/cur_state 
-1

echo 1 >/sys/devices/virtual/thermal/cooling_device4/cur_state
c100:/home/trenn # cat /sys/devices/virtual/thermal/cooling_device4/cur_state 
86

It looks like any number echoed into the cur_state device, even above max_state enables
dynamic power adjusting:
echo 10100000 >/sys/devices/virtual/thermal/cooling_device4/cur_state
-> no error.

ACPI related CPU cooling devices 0-3 work as one would expect:
3 states (max_state) one can set them and trying to write something into cur_state
which is above max_state ends up in:
echo 4 >/sys/devices/virtual/thermal/cooling_device2/cur_state
bash: echo: Schreibfehler: Invalid argument.

Hardware:
Dell, Latitude E7470
cpu family      : 6
model           : 78
model name      : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
stepping        : 3
microcode       : 0xd6


Adding Jacob who seem to be involved into powerclamp driver.
Maybe he can shed some light on this...

Thanks,

    Thomas



