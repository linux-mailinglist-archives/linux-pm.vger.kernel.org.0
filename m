Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED22501AA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHXQFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 12:05:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8065 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgHXQEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 12:04:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43e47f0006>; Mon, 24 Aug 2020 09:02:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 09:04:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 09:04:06 -0700
Received: from [10.26.74.138] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 16:02:24 +0000
Subject: Re: [PATCH v3] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200709173532.15431-1-digetx@gmail.com>
 <69c57c9c-a8e4-2367-3f72-232b6b3456b8@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c7e79586-f948-3681-6046-a51852ab2523@nvidia.com>
Date:   Mon, 24 Aug 2020 17:02:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <69c57c9c-a8e4-2367-3f72-232b6b3456b8@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598284927; bh=tnamZSPAa6+zvxxL1eNXRdhByZgvdWqa/x1tggg/uVY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Th+DnOD3eJfMKP8xcULi+khKUkagyuL14tA4lDflfkLjgvzIBrhxf4oLaRD1gwUgS
         7ByCrEYCWoxQxBmNwsdXkmkmjEGA1BeMcfjYZJi7r9dhMRWgRuw45nRkDpfqbxzgBm
         om9E+FwfcsCFYYyGVJCHCH7Oj3d7Hpuq1UEkIeKXpo4lz8jKPBh1LjJQvWXaEn0y5c
         DIeqt1IwxOaBsNi0tjXD2hzWrEKWqi62DZqNpQzQgpc8V+Q7RIKHtgM+nTzQzakH3q
         603LcCYFH1PCooaETQvvwcNcbWro0bCdi3xxSRFsWsJEDHO4b3IBH8hdbyGOaXcqZL
         i+YyZuUFGxzvg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 14/08/2020 18:53, Dmitry Osipenko wrote:
> 09.07.2020 20:35, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> The enter() callback of CPUIDLE drivers returns index of the entered idl=
e
>> state on success or a negative value on failure. The negative value coul=
d
>> any negative value, i.e. it doesn't necessarily needs to be a error code=
.
>> That's because CPUIDLE core only cares about the fact of failure and not
>> about the reason of the enter() failure.
>>
>> Like every other enter() callback, the arm_cpuidle_simple_enter() return=
s
>> the entered idle-index on success. Unlike some of other drivers, it neve=
r
>> fails. It happened that TEGRA_C1=3Dindex=3Derr=3D0 in the code of cpuidl=
e-tegra
>> driver, and thus, there is no problem for the cpuidle-tegra driver creat=
ed
>> by the typo in the code which assumes that the arm_cpuidle_simple_enter(=
)
>> returns a error code.
>>
>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_ID=
LE
>> is disabled in a kernel's config, but all CPUIDLE drivers are disabled i=
f
>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ev=
er
>> see the error code from arm_cpuidle_simple_enter() today.
>>
>> Of course the code may get some changes in the future and then the
>> typo may transform into a real bug, so let's correct the typo! The
>> tegra_cpuidle_state_enter() is now changed to make it return the entered
>> idle-index on success and negative error code on fail, which puts it on
>> par with the arm_cpuidle_simple_enter(), making code consistent in regar=
ds
>> to the error handling.
>>
>> This patch fixes a minor typo in the code, it doesn't fix any bugs.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v3: The tegra_cpuidle_state_enter() now returns entered idle-index on
>>     success instead of 0. Hence the error message will be shown by the
>>     tegra-cpuidle driver if arm_cpuidle_simple_enter() will ever fail.
>>     Again thanks to Jon Hunter!
>=20
> Hello, Jon! Do you see anything else that could be improved in this patch=
?
>

Sorry for the delay. Looks good to me ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

--=20
nvpublic
