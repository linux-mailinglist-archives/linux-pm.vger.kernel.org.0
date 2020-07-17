Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5974F2245CF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGQVXC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 17:23:02 -0400
Received: from cmta16.telus.net ([209.171.16.89]:38156 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgGQVXC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 17:23:02 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id wXoojGt2v5b7lwXopjA9Rr; Fri, 17 Jul 2020 15:23:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1595020980; bh=Obs7qdIUZIgX6dl7u6Axy0TTWM4tuguLOeMYKBQ0GWE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=42DGB1ZbW8ZjfFDX5P4Dlp1CXsuH1jel1I42fWeqIEyXW690IiqO9+1t0H6zXk3aR
         xlifKfVLgY2fFEBz3E+Ott3Z+0QetFbjhoXHAI0oTqhT0GSjbISAE2n8wcu/Tk16nW
         felqP9XAPIxaI/bqErOgBRprcuAYRlOoFJv58uRjdHLRC8LC4aIKNaWX/vJ2EZCqgv
         BoPC6GK/+Vg9aSbvxd6F8ysJfasFBvgGL4iMne9o5o76pd3FZDjNZj84yO0sa4X896
         f67HDD4SSlssQ8zAIWUcxMOV6tcmvwg39n1sfMh7A/K9i6YjJoSlqOgxK+LawE55Ss
         oiOhE9rWsfbEg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=fdjANqkvx1eCgfwP2e0A:9 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <000701d656be$c48083e0$4d818ba0$@net> <CAJZ5v0hKeHBNC2Bzdizm=42jtOqq8VOswCNNNk5HA9x_Y2T_Ng@mail.gmail.com> <001d01d65af9$6dd46180$497d2480$@net> <CAJZ5v0gvqhfHDDzVHNP4ODMfujaWA8Y8OuLF_i4JoM_1jVh=2w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvqhfHDDzVHNP4ODMfujaWA8Y8OuLF_i4JoM_1jVh=2w@mail.gmail.com>
Subject: RE: cpufreq: intel_pstate: EPB with performance governor
Date:   Fri, 17 Jul 2020 14:22:57 -0700
Message-ID: <004401d65c80$7254fcf0$56fef6d0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZbaLLjMG7mo7iNQZSVo7KyziRxbwA25HPg
X-CMAE-Envelope: MS4wfK8LNHIcwYyiRS53l4Zy83oik+CZseLif7k+unmlNAqrpi4DOXkDSnC1mXvr8K5Xe4e359elHp/aQsL1Lx+sYFW+DzZqVGTUle2QSq/4Ia4oyRYrY0bI
 fiJwlISue6bedlUMBA9BBpim0dQGz1OKnnythHf+XSLaZh73sX9Bb7rHnoqD2JC+FcPxFve+Q6Dw4gVL+vKJ9ODBIKfs5xGmlcpWNp3vVaLng193phjQluU3
 Gibutn2fDKrEpH6xL2YGXg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thank you for your reply.
I'll give it up after this, I promise.

On 2020.07.16 05:00 Of Rafael J. Wysocki
> On Thu, Jul 16, 2020 at 12:44 AM Doug Smythies <dsmythies@telus.net> wrote:
> > On 2020.07.15 09:47 Rafael J. Wysocki wrote:
> > > On Fri, Jul 10, 2020 at 3:34 PM Doug Smythies <dsmythies@telus.net> wrote:
...
> > > you can simply set the EPB to 0 via
> > > energy_perf_bias for all CPUs and it should stick.
> >
> > And I am saying I should not have to do that, or even know about it,
> > when I want to use the performance governor.
> 
> Again, cpufreq governors are on top of the EPB.
> 
> > But yes, I expect the driver to remember the default, or otherwise set,
> > value of EPB for all the other governors.
> 
> We clearly don't agree here.

Agreed. (That we disagree.)

It is done with EPP in active mode with HWP between performance
and powersave governors, so I struggle with treating the EPB
case differently.
 
> Also in the passive mode of intel_pstate, when the regular cpufreq
> "performance" governor is in use, it's all about setting the frequency
> to the max alone through min = max without touching any other knobs
> which need to be adjusted separately.  That's how it's been always
> working and changing it now may confuse the users who have learned to
> rely on this behavior.

But the behaviour is inconsistent anyhow.

How can we possibly claim that this:

doug@s18:~$ sudo ~/turbostat --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 6
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
18.12   3700    25782   38      13.94   0.00
0.55    3701    3000    38      13.94   0.00
0.01    3701    49
19.29   3700    5529
35.97   3700    6051
26.99   3700    5177
25.92   3700    5976
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
18.12   3700    27042   40      14.15   0.00
0.55    3701    2978    40      14.15   0.00
0.01    3701    22
30.01   3700    6042
28.09   3700    6044
29.18   3700    6046
20.91   3700    5910
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
18.13   3700    27195   40      14.06   0.00
0.55    3701    2983    40      14.06   0.00
0.01    3701    20
27.64   3700    6039
20.31   3700    6043
36.12   3700    6056
24.18   3700    6054

is "performance" mode?
There is plenty enough load on 4 of the CPUs.
In performance mode I would expect 4.6 GHz.

You can see the request for pstate 46,
But only pstate 37 is granted:

root@s18:/home/doug# /home/doug/c/msr-decoder
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  37 :  37 :  37 :  37 :  37 :  37 :
B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
9.) 0x199: IA32_PERF_CTL        : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-5 :   6 :   6 :   6 :   6 :   6 :   6 :
1.) 0x19C: IA32_THERM_STATUS: 883E0000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 883C0000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable

... Doug


