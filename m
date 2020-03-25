Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C611934CE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 01:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCZAAL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 20:00:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9680 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCZAAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 20:00:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7bf02e0003>; Wed, 25 Mar 2020 16:58:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Mar 2020 17:00:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Mar 2020 17:00:10 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 00:00:06 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, <sumitg@nvidia.com>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
 <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
 <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
From:   sumitg <sumitg@nvidia.com>
Message-ID: <aa9fb180-6a23-e27b-51f6-f6b5685d65be@nvidia.com>
Date:   Thu, 26 Mar 2020 05:29:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585180719; bh=9uZbtNMpcvzB0onUSiYkGRUIchw1nTvWyc50DiXbVTI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=O5H4mezIfnNNMGskLSIFsJQ7ogdzqyjRRek8D12N94VW9O89rhhNpnmu5iFtPEFdX
         fvwvks1+8PPrKV9P8jtPk8C+pZtCNHl6QyftlW0Up2g3EBdgIuP/IfRsGSdUpoMFqn
         qN2GDqjEE4EZprdo209/9VP7l25ton6dMRUkUvtMA/fzEwtJcPyja7GoiuqU2Okest
         w4Iftt2ENlhBgoKBJll+Y7j4pnyRYj18PA2EmOfa3Nw6SwLsI6G/5PiVAsZ1NROp/U
         FHPayksZCAK6uQdS5xFUchiPeDMeGn6UmfhIvvIJdMaQwqA/Gy8ue7Uaa4ABzVL5Ok
         lY9GtCYK9Bibw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

Sorry for the late reply.

On 04/12/19 4:57 PM, Viresh Kumar wrote:
> On 04-12-19, 16:25, sumitg wrote:
>> In T194, CCPLEX doesn't have access to set clocks and the
>>
>> clk_{get|set}_rate() functions set clocks by hook to BPMP R5.
>>
>> CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).
>>
>> As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is
>>
>> used to read the counters and calculate "actual" cpu freq at CCPLEX.
>>
>> So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not
>>
>> given by node "scaling_cur_freq".
> Right, but why can't this be hidden in the CPU's clk driver instead,
> so cpufreq driver can just do clk_get_rate() and clk_set_rate() ?
>
>>> - populating cpufreq table, you can probably add OPPs instead using
>>>     the same mechanism
>> We are reading available frequencies from BPMP to populate
>>
>> cpufreq table and not using static opp table.
> Right and lot of other platforms read it from firmware (I believe BBMP
> is a firmware here), and create OPPs at runtime. Look at this for
> example:
>
> drivers/cpufreq/qcom-cpufreq-hw.c
>
> and search for dev_pm_opp_add().
>
- I think we don't need separate CPU clock driver & to reuse

 =C2=A0 cpufreq-dt driver as we will still have to replicate same logic

 =C2=A0 from cpufreq driver to that dummy clock driver for calculating

 =C2=A0 actual cpufreq from MSR value. So, it won't add much value.

 =C2=A0=C2=A0=C2=A0 - "qcom-cpufreq-hw.c" is using clk_get_rate() during in=
it, but

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the frequency ops "get/target_index" write =
to register directly

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and not using clk api's. Also, the clock dr=
iver from gcc-msm*.c

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seem to handle all clocks in CCPLEX.

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tegra SOC's which didn't have BPMP had the =
clock handling

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done by CCPLEX. They were using clk_{get|se=
t}_rate() api's

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as you mentioned. But in Tegra194, all cloc=
k handling is done

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 within BPMP R5 core except CPU clock(which =
is through MSR).

- Adding OPP's with dev_pm_opp_add() is also not required as:

 =C2=A0=C2=A0 1) We don't have any consumer like energy model or EAS in

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tegra194 which it seems was valid wit=
h "qcom-cpufreq-hw.c".

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So, i think it won't be useful for T1=
94.

 =C2=A0=C2=A0 2) Also, there is no way to map ndiv to voltage in kernel. Ke=
rnel

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver passes ndiv value to BPMP(R5) =
which converts to vhint.

Please share your inputs.

