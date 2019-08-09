Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56EA8724A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 08:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHIGfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 02:35:34 -0400
Received: from cmta18.telus.net ([209.171.16.91]:58078 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfHIGfb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 02:35:31 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id vyUohmq4Y7TgTvyUqhyzUZ; Fri, 09 Aug 2019 00:35:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1565332529; bh=l4QjEOhaIO0qn/E25uPtBEV8pXfGDw3ibKcIcvx0glg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Ko8CXqC3X73X/TylDbjxHfajbTievNnOmrX7jyB5DGpEOLjkwLi13Z87MfZD5XMAO
         EnWedXB7n+vlB72olWOpkLS0eyni4NcUokJE0ETl8ZFdb8DSCMhLDlsifRUPSbOfoE
         iiTyGh4SHs188Tuu3j1XPODq/AkRav95LMMx9vMOFHqH5TVXECazmXivEGVYHDknKr
         Ii0SotleoAjjnvaBtnudlU6o4I3K9axs9Mrpoyj001enR96DV3zSDmGrQbSr+4zvbw
         dWv3imZZLQomxW6FgSk0x1kcvxxgYUslotS1KyNkjS2xdlJggw4sPIFMWb4bjz312A
         x6fRTroBt7nEw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=e6N4tph/ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8 a=PNFDcKh4-V1H6LwEEroA:9 a=CjuIK1q_8ugA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <linux-pm@vger.kernel.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "'Rafael Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>
References: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org> <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org> <000601d54e05$e93d0130$bbb70390$@net> <20190809021607.j4qj3jm72gbisvqh@vireshk-i7>
In-Reply-To: <20190809021607.j4qj3jm72gbisvqh@vireshk-i7>
Subject: RE: [PATCH V4 2/2] cpufreq: intel_pstate: Implement QoS supported freq constraints
Date:   Thu, 8 Aug 2019 23:35:25 -0700
Message-ID: <001f01d54e7c$a22395d0$e66ac170$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVOWGxlCwZEXTO5Q3+73ydAwQ87uAAIW9cA
X-CMAE-Envelope: MS4wfBg1mTLhUptGM5pCS9mv5bDHbtdRoVilruwf2K5Y2XV4U2u00NuHVOJsaTz2T+FJo/8VMpBc+3ekl+iAs/NtrJ6Av/Hihkhm1YRolHEEBYAdPmVnaiQ+
 d7UEdBGaP0xicyw7az4JlIH7qnnwROH3ysVG0pRPIlW6CY9Ns3IXW/50Zk0yg7PAiGo1lBZXtiUbh0G1qymIU0SZ/SHn93l7bOtppJVVEInWxROHrDk2kgJj
 M0yI+BajE2S6CDeNeFTYQZVXZQ+M1ucSGc4QKGjVGfvCQjpguV2j/DnYoZ2x1x6ID+3rYScmA+t+ZIjRzvRpyytqOkZQHBu1FIgLPgI4ZwKNJJO/A4O3DPaw
 tikCZYyExHWi3lCfl626pSHVQkRN1taYYfQvi/dgLwGTvM9F3bY=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.08.08 19:16 Viresh Kumar wrote:
> On 08-08-19, 09:25, Doug Smythies wrote:
>> On 2019.08.07 00:06 Viresh Kumar wrote:
>> Tested by: Doug Smythies <dsmythies@telus.net>
>> Thermald seems to now be working O.K. for all the governors.
>
> Thanks for testing Doug.
> 
>> I do note that if one sets
>> /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
>> It seems to override subsequent attempts via
>> /sys/devices/system/cpu/intel_pstate/max_perf_pct.
>> Myself, I find this confusing.
>> 
>> So the question becomes which one is the "master"?
>
> No one is master, cpufreq takes all the requests for frequency
> constraints and tries to set the value based on aggregation of all. So
> for max frequency, the lowest value wins and is shown up in sysfs.
>
> So, everything looks okay to me.

O.K. While I understand the explanations, I still struggle with
this scenario:
 
doug@s15:~/temp$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
50    <<< Note: 50% = 1.9 GHz in my system)
doug@s15:~/temp$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy5/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq:1900000
/sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq:1900000

At this point I am not certain what I'll get if I try to
set max_perf_pct to 100%, nor do I know how to find out
with a user command.

So, I'll try it:

doug@s15:~/temp$ echo 100 | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
100
doug@s15:~/temp$ cat /sys/devices/system/cpu/intel_pstate/max_perf_pct
100  <<< Note: 100% = 3.8 GHz in my system)
doug@s15:~/temp$ grep . /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy1/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy3/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy5/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq:2200000
/sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq:2200000

I guess I had set it sometime earlier, forgot, and then didn't
get 3.8 Ghz as I had expected via max_perf_pct.

... Doug


