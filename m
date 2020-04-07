Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F11A1548
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDGSzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 14:55:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10343 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGSzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 14:55:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8ccc2a0001>; Tue, 07 Apr 2020 11:53:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Apr 2020 11:55:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Apr 2020 11:55:12 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr
 2020 18:55:12 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr 2020
 18:55:07 +0000
From:   sumitg <sumitg@nvidia.com>
Subject: Re: [TEGRA194_CPUFREQ Patch v2 2/3] cpufreq: Add Tegra194 cpufreq
 driver
To:     Dmitry Osipenko <digetx@gmail.com>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <mperttunen@nvidia.com>, <sumitg@nvidia.com>
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
 <1586028547-14993-3-git-send-email-sumitg@nvidia.com>
 <67f9feb1-ba51-f1ac-b6eb-4587924d0748@gmail.com>
Message-ID: <538ddcf4-b760-a342-eab6-5a61c9bd860a@nvidia.com>
Date:   Wed, 8 Apr 2020 00:25:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <67f9feb1-ba51-f1ac-b6eb-4587924d0748@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586285610; bh=9hwDPF9VnbM85J5PKb1WmMWXNhaY35UANwXzXHCJb2w=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RpyBtvuW4zXVIrNxiDX8UX/Xomrv4A7Z1yqgIwYlAcurOdV36H+rD1k/iCneY13Hb
         BYk5O90k96V1wzaJPZZRJNnfi/xRQZjTWt1o8o2/CxaD84gq0hvbejKpJkcc4+u0Aw
         eBTOFS12N1UXN6XEBSuhB6mw7X6RLWRF3oNEcb9ZRQmKPka04lrRIBWoYAK/NUvyEK
         +GtOEw3fTZijPq2+kMcQbb8av8mxL38StLZL6bi22+1zkGxGNu5jMe3SeDKl2seMov
         rCoaXtZGRBaJaGjFY/nalQmATSCQjKt95+sdsoicBKJ3THhoMW6rliFPHzmo3GYRNI
         XpJ5uv/kQ8UCw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 05/04/20 7:35 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> 04.04.2020 22:29, Sumit Gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +static void tegra_read_counters(struct work_struct *work)
>> +{
>> +     struct read_counters_work *read_counters_work;
>> +     struct tegra_cpu_ctr *c;
>> +     u64 val;
>> +
>> +     /*
>> +      * ref_clk_counter(32 bit counter) runs on constant clk,
>> +      * pll_p(408MHz).
>> +      * It will take =3D 2 ^ 32 / 408 MHz to overflow ref clk counter
>> +      *              =3D 10526880 usec =3D 10.527 sec to overflow
>> +      *
>> +      * Like wise core_clk_counter(32 bit counter) runs on core clock.
>> +      * It's synchronized to crab_clk (cpu_crab_clk) which runs at
>> +      * freq of cluster. Assuming max cluster clock ~2000MHz,
>> +      * It will take =3D 2 ^ 32 / 2000 MHz to overflow core clk counter
>> +      *              =3D ~2.147 sec to overflow
>> +      */
>> +     read_counters_work =3D container_of(work, struct read_counters_wor=
k,
>> +                                       work);
>> +     c =3D &read_counters_work->c;
>> +
>> +     val =3D read_freq_feedback();
>> +     c->last_refclk_cnt =3D lower_32_bits(val);
>> +     c->last_coreclk_cnt =3D upper_32_bits(val);
>> +     udelay(c->delay);
>> +     val =3D read_freq_feedback();
>> +     c->refclk_cnt =3D lower_32_bits(val);
>> +     c->coreclk_cnt =3D upper_32_bits(val);
>> +}
>> +
>> +/*
>> + * Return instantaneous cpu speed
>> + * Instantaneous freq is calculated as -
>> + * -Takes sample on every query of getting the freq.
>> + *   - Read core and ref clock counters;
>> + *   - Delay for X us
>> + *   - Read above cycle counters again
>> + *   - Calculates freq by subtracting current and previous counters
>> + *     divided by the delay time or eqv. of ref_clk_counter in delta ti=
me
>> + *   - Return Kcycles/second, freq in KHz
>> + *
>> + *   delta time period =3D x sec
>> + *                     =3D delta ref_clk_counter / (408 * 10^6) sec
>> + *   freq in Hz =3D cycles/sec
>> + *              =3D (delta cycles / x sec
>> + *              =3D (delta cycles * 408 * 10^6) / delta ref_clk_counter
>> + *   in KHz     =3D (delta cycles * 408 * 10^3) / delta ref_clk_counter
>> + *
>> + * @cpu - logical cpu whose freq to be updated
>=20
>=20
>> + * Returns freq in KHz on success, 0 if cpu is offline
>=20
> I don't see any checks in the code about whether CPU is offline.
>=20
> Googling for "queue_work_on offline cpu" suggests that this function
> should hang.
>=20
Tried this and didn't get crash or hang.
show_cpuinfo_cur_freq() returns "<unknown>" value on reading frequency=20
from a cluster having both it's cores offline.
If only one cpu is offline, then frequency of other online cpu which is=20
managing the policy of that cluster is returned.
Have still added below check as guard in get|set() freq calls.
	if (!cpu_online(cpu))
		return -EINVAL;
Thankyou for the input.

>> + */
>> +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>> +{
>> +     struct read_counters_work read_counters_work;
>> +     struct tegra_cpu_ctr c;
>> +     u32 delta_refcnt;
>> +     u32 delta_ccnt;
>> +     u32 rate_mhz;
>> +
>> +     read_counters_work.c.cpu =3D cpu;
>> +     read_counters_work.c.delay =3D delay;
>> +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
>> +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
>> +     flush_work(&read_counters_work.work);
>> +     c =3D read_counters_work.c;
>> +
>> +     if (c.coreclk_cnt < c.last_coreclk_cnt)
>> +             delta_ccnt =3D c.coreclk_cnt + (MAX_CNT - c.last_coreclk_c=
nt);
>> +     else
>> +             delta_ccnt =3D c.coreclk_cnt - c.last_coreclk_cnt;
>> +     if (!delta_ccnt)
>> +             return 0;
>> +
>> +     /* ref clock is 32 bits */
>> +     if (c.refclk_cnt < c.last_refclk_cnt)
>> +             delta_refcnt =3D c.refclk_cnt + (MAX_CNT - c.last_refclk_c=
nt);
>> +     else
>> +             delta_refcnt =3D c.refclk_cnt - c.last_refclk_cnt;
>> +     if (!delta_refcnt) {
>> +             pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
>> +             return 0;
>> +     }
>> +     rate_mhz =3D ((unsigned long)(delta_ccnt * REF_CLK_MHZ)) / delta_r=
efcnt;
>> +
>> +     return (rate_mhz * KHZ); /* in KHz */
>> +}
>=20
