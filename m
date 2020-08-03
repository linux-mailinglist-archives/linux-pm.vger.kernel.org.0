Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7783E239D0A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHCA0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 20:26:34 -0400
Received: from cmta16.telus.net ([209.171.16.89]:50104 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHCA0e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 20:26:34 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 2OJAky0C25b7l2OJBkGkKZ; Sun, 02 Aug 2020 18:26:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596414391; bh=OzKdaN6shwOvhXo+DLx43ep5Lhv4yZVCcDMi841OidI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=tlKP98xQjZq2UvO+CaB38haED/uFYZAgBfwJ5cxVPTvqTCQ9q7UXl7zK044Ht2P+S
         Un/tDywlgamARVCfnOWAzp1lZkZamkBHxllM0ugdPPFcrJqewGURUo1XQgrhmvW7wM
         65VNRPQFTndxEJLckWtN8ITOPTp/4dqLJmSF+Z5Vh1aqt0PVZiDzUQhpb0IP8UAbFf
         wGVW3JjvSWNn3DkC8Mp1IRzVrCa0U/gojoxzbFkLNAiNEC8D+Xm+ALbknY9qt7IXOV
         wdKDQ2PDBakFtahY1WB86Q/UBOI9I77+JILld+f6OZ4MEf7othlW2r1olpf9wBDCVX
         HcIp4XznqVbjQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=TeswGVX_M4DXQs4YhE0A:9 a=eCsET7RYUF58Bk87:21 a=QYMj-0FJlSCgP01B:21
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>  <13207937.r2GEYrEf4f@kreacher>  <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>        <000301d668d5$45c10a10$d1431e30$@net> <24a3011a9004bdbd7a37c029f9c2153f3db61476.camel@linux.intel.com>
In-Reply-To: <24a3011a9004bdbd7a37c029f9c2153f3db61476.camel@linux.intel.com>
Subject: RE: [PATCH v4 0/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Sun, 2 Aug 2020 17:26:27 -0700
Message-ID: <000001d6692c$bc5605c0$35021140$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZo/DaI9v1ri9sAR0isEjECaQnrNgALClsg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfCvYaSucJJVgw7O/2uYTcLKWQbUa4Lqdp3l76R9nnrJ/BtCofkpLpU9jngHorlo/TT0MNJuGKi75GbtlCITJAcsJ+grBvVbJia3eQ2pNIsPT5QVbs7Cb
 DiOsWOxbK6kZ/Ni5H1BAW1XvSzIWi1voJgHCsH9uf/asLtU2UcBMSA4d2z19PvqMxf5CNpLOAt6O+VESJGFEXIqQEhDk7hqSYccsoLHr2VzM+x9m3GR3BiDC
 GbVPYqpQswESk9y8bhOXJUWdy1DZfobTcXiYokILeqOqPQ00BzAnoguTfT6ZxepCGsj7cGAQxBchCFpXXPiP9eDx/R218D+DeLBFzdZoNf+futjvlgVqfdtj
 C2/Ni73l+o6epEd1ATZKlc52jUWFxnjBRnDDjA+6bKrCxcntQbd6asX9/9RFrm3qrJe1wK39uo8mOub+Wpoi+NtKjRUddw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

Thanks for your help. I was missing several needed patches.

On 2020.08.02 11:39 Srinivas Pandruvada wrote:
> On Sun, 2020-08-02 at 07:00 -0700, Doug Smythies wrote:
> > On 2020.08.01 09:40 Srinivas Pandruvada wrote:
> > > > On Monday, July 27, 2020 5:13:40 PM CEST Rafael J. Wysocki =
wrote:
> > > > > On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki
> > > > > wrote:
> > > > > > This really is a v2 of this patch:
> > > > > >
> > > > > > https://patchwork.kernel.org/patch/11663271/
> > > > > >
> > > > > > with an extra preceding cleanup patch to avoid making
> > > > > > unrelated
> > > > > > changes in the
> > > > > > [2/2].
> > > I applied this series along with
> > > [PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active
> > > mode
> > > on 5.8 latest master (On top of raw epp patchset).
> >
> > Would you be kind enough to provide a "git log --oneline" output
> > of what you did.
>=20
> 69dd9b2b11cd (HEAD -> 5-9-devel) cpufreq: intel_pstate: Implement
> passive mode with HWP enabled
> 63efaa01b06a cpufreq: intel_pstate: Fix EPP setting via sysfs in =
active
> mode
> e11e0a2edf83 cpufreq: intel_pstate: Rearrange the storing of new EPP
> values
> 93c3fd6a315c cpufreq: intel_pstate: Avoid enabling HWP if EPP is not
> supported
> 7cef1dd371c3 cpufreq: intel_pstate: Clean up aperf_mperf_shift
> description
> a3248d8d3a11 cpufreq: intel_pstate: Supply struct attribute =
description
> for get_aperf_mperf_shift()
> f52b6b075b07 cpufreq: intel_pstate: Fix static checker warning for epp
> variable
> 4a59d6be0774 cpufreq: intel_pstate: Allow raw energy performance
> preference value
> 7b34b5acdcc6 cpufreq: intel_pstate: Allow enable/disable energy
> efficiency
> ac3a0c847296 (origin/master, origin/HEAD, master) Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> >
> > I have been trying unsuccessfully to apply the patches,
> > so somewhere I obviously missed something.
> >
> > > When intel_pstate=3Dpassive from kernel command line then it is =
fine,
> > > no
> > > crash. But switch dynamically, crashed:
> >
> > I'll try to repeat, if I can get an actual kernel.

I could not repeat your crash.

I tried booting with and without intel_pstate=3Dpassive
on the kernel command line and then switching back and
forth thereafter.

However, I do confirm EPP is messed up. But not min
and max from MSR 0x774, they behave as expected,
based on quick testing only.

Since you mentioned:

>>> Don't have a recipe to reproduce this.

Maybe I simply didn't hit whatever.

... Doug

Useless additional stuff:

# cat /proc/cmdline
BOOT_IMAGE=3D/boot/vmlinuz-5.8.0-rc7-dssp =
root=3DUUID=3D0ac356c1-caa9-4c2e-8229-4408bd998dbd ro ipv6.disable=3D1 =
consoleblank=3D450 intel_pstate=3Dpassive cpuidle_sysfs_switch =
cpuidle.governor=3Dteo

Went "active" then "passive" and set ondemand governor. 2 X 100% CPU =
loads:

# /home/doug/c/msr-decoder
How many CPUs?: 6
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 =
:  46 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 883C0000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled =
OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 882D0000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO =
disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B252E : high 46 : =
guaranteed 37 : efficient 11 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: FF002E0A : FF002E2E : FF002E2E : FF002E08 : FF002E18 : FF002E08 =
:
    min:       10 :       46 :       46 :        8 :       24 :        8 =
:
    max:       46 :       46 :       46 :       46 :       46 :       46 =
:
    des:        0 :        0 :        0 :        0 :        0 :        0 =
:
    epp:      255 :      255 :      255 :      255 :      255 :      255 =
:
    act:        0 :        0 :        0 :        0 :        0 :        0 =
:
7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : =
lowest 0

Kernel:

d72c8472dbd5 (HEAD -> k58rc7-d3) cpufreq: intel_pstate: Fix EPP setting =
via sysfs in active mode
c2f4869fbc27 cpufreq: intel_pstate: Implement passive mode with HWP =
enabled
85219968fab9 cpufreq: intel_pstate: Rearrange the storing of new EPP =
values
5c09a1a38106 cpufreq: intel_pstate: Avoid enabling HWP if EPP is not =
supported
9f29c81fe0b3 cpufreq: intel_pstate: Clean up aperf_mperf_shift =
description
2a863c241495 cpufreq: intel_pstate: Supply struct attribute description =
for get_aperf_mperf_shift()
4180d8413037 cpufreq: intel_pstate: Fix static checker warning for epp =
variable
7cd50e86a9e6 cpufreq: intel_pstate: Allow raw energy performance =
preference value
56dce9a1081e cpufreq: intel_pstate: Allow enable/disable energy =
efficiency
92ed30191993 (tag: v5.8-rc7) Linux 5.8-rc7


