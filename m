Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE493A7DFC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFOMUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 08:20:15 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:17346 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhFOMUP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 08:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623759491; x=1655295491;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2p01kvq+G29y436EWXolYoDccfmPacDmDp78aAZq12Q=;
  b=KjmGVncej8PXckIKlFBXc2hYrq9mKU0CuJH/djFAde34H8hgrspiW9xg
   YxrDtTHKyX2M6gZQxEx9NarlJXm0It7hupjJRuRYr6By9rmvuEGiSSsRk
   lPUME4pilraE9BmL9pNnASaBHR4MkZtY2QK6hhiapuhwJkDT3Ux8ivGYC
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2021 05:18:10 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 05:17:57 -0700
Received: from [10.111.175.185] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 05:17:50 -0700
Subject: Re: [PATCH 0/5] cpufreq: cppc: Fix suspend/resume specific races with
 FIE code
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
 <eaaaf171-5937-e0f2-8447-c1b20b474c62@quicinc.com>
 <20210615075056.dfkbiftuoihtrfpo@vireshk-i7>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <19527d26-526e-6c6f-431d-7b78ed92bb34@quicinc.com>
Date:   Tue, 15 Jun 2021 08:17:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615075056.dfkbiftuoihtrfpo@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03b.na.qualcomm.com (10.85.0.98) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/15/2021 3:50 AM, Viresh Kumar wrote:
> Hi Qian,
> 
> First of all thanks for testing this, I need more of your help to test
> this out :)
> 
> FWIW, I did test this on my Hikey board today, with some hacks, and
> tried multiple insmod/rmmod operations for the driver, and I wasn't
> able to reproduce the issue you reported. I did enable the list-debug
> config option.

The setup here is an arm64 server with 32 CPUs.

> 
> On 14-06-21, 09:48, Qian Cai wrote:
>> Unfortunately, this series looks like needing more works.
>>
>> [  487.773586][    T0] CPU17: Booted secondary processor 0x0000000801 [0x503f0002]
>> [  487.976495][  T670] list_del corruption. next->prev should be ffff009b66e9ec70, but was ffff009b66dfec70
>> [  487.987037][  T670] ------------[ cut here ]------------
>> [  487.992351][  T670] kernel BUG at lib/list_debug.c:54!
>> [  487.997810][  T670] Internal error: Oops - BUG: 0 [#1] SMP
>> [  488.003295][  T670] Modules linked in: cpufreq_userspace xfs loop cppc_cpufreq processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core nvme_core firmware_class
>> [  488.021759][  T670] CPU: 1 PID: 670 Comm: cppc_fie Not tainted 5.13.0-rc5-next-20210611+ #46
>> [  488.030190][  T670] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
>> [  488.038705][  T670] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
>> [  488.045398][  T670] pc : __list_del_entry_valid+0x154/0x158
>> [  488.050969][  T670] lr : __list_del_entry_valid+0x154/0x158
>> [  488.056534][  T670] sp : ffff8000229afd70
>> [  488.060534][  T670] x29: ffff8000229afd70 x28: ffff0008c8f4f340 x27: dfff800000000000
>> [  488.068361][  T670] x26: ffff009b66e9ec70 x25: ffff800011c8b4d0 x24: ffff0008d4bfe488
>> [  488.076188][  T670] x23: ffff0008c8f4f340 x22: ffff0008c8f4f340 x21: ffff009b6789ec70
>> [  488.084015][  T670] x20: ffff0008d4bfe4c8 x19: ffff009b66e9ec70 x18: ffff0008c8f4fd70
>> [  488.091842][  T670] x17: 20747562202c3037 x16: 6365396536366239 x15: 0000000000000028
>> [  488.099669][  T670] x14: 0000000000000000 x13: 0000000000000001 x12: ffff60136cdd3447
>> [  488.107495][  T670] x11: 1fffe0136cdd3446 x10: ffff60136cdd3446 x9 : ffff8000103ee444
>> [  488.115322][  T670] x8 : ffff009b66e9a237 x7 : 0000000000000001 x6 : ffff009b66e9a230
>> [  488.123149][  T670] x5 : 00009fec9322cbba x4 : ffff60136cdd3447 x3 : 1fffe001191e9e69
>> [  488.130975][  T670] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000054
>> [  488.138803][  T670] Call trace:
>> [  488.141935][  T670]  __list_del_entry_valid+0x154/0x158
>> [  488.147153][  T670]  kthread_worker_fn+0x15c/0xda0
> 
> This is a strange place to get the issue from. And this is a new
> issue.

Well, it was still the same exercises with CPU online/offline.

> 
>> [  488.151939][  T670]  kthread+0x3ac/0x460
>> [  488.155854][  T670]  ret_from_fork+0x10/0x18
>> [  488.160120][  T670] Code: 911e8000 aa1303e1 910a0000 941b595b (d4210000)
>> [  488.166901][  T670] ---[ end trace e637e2d38b2cc087 ]---
>> [  488.172206][  T670] Kernel panic - not syncing: Oops - BUG: Fatal exception
>> [  488.179182][  T670] SMP: stopping secondary CPUs
>> [  489.209347][  T670] SMP: failed to stop secondary CPUs 0-1,10-11,16-17,31
>> [  489.216128][  T][  T670] Memoryn ]---
> 
> Can you give details on what exactly did you try to do, to get this ?
> Normal boot or something more ?

Basically, it has the cpufreq driver as CPPC and the governor as schedutil. Running a few workloads to get CPU scaling up and down. Later, try to offline all CPUs until the last one and then online all CPUs.

> 
> I have made some changes to the way calls were happening, may get this
> thing sorted. Can you please try this branch ?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/cppc
> 
> I can see one place where race can happen, i.e. between
> topology_clear_scale_freq_source() and topology_scale_freq_tick(). It
> is possible that sfd->set_freq_scale() may get called for a previously
> set handler as there is no protection there.
> 
> I will see how to fix that. But I am not sure if the issue reported
> above comes from there.
> 
> Anyway, please give my branch a try, lets see.

I am hesitate to try this at the moment because this all feel like shooting in the dark. Ideally, you will be able to get access to one of those arm64 servers (Huawei, Ampere, TX2, FJ etc) eventually and really try the same exercises yourself with those debugging options like list debugging and KASAN on. That way you could fix things way efficiently. I could share you the .config once you are there. Last but not least, once you get better narrow down of the issues, I'd hope to see someone else familiar with the code there to get review of those patches first (feel free to Cc me once you are ready to post) before I'll rerun the whole things again. That way we don't waste time on each other backing and forth chasing the shadow.
