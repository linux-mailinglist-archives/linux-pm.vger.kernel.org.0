Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01B5219BA8
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGIJGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 05:06:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3945 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGIJGe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 05:06:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f06ddae0000>; Thu, 09 Jul 2020 02:04:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 02:06:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jul 2020 02:06:34 -0700
Received: from [10.26.72.135] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 09:06:32 +0000
Subject: Re: [PATCH v2] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200702001354.27056-1-digetx@gmail.com>
 <4ffff3d8-2d41-3fb2-ed16-c9662d18d261@nvidia.com>
 <3bc2064e-e94d-984c-edab-50b4dc2fd2dd@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <be99caca-b50a-0e12-29dc-2da0d924af43@nvidia.com>
Date:   Thu, 9 Jul 2020 10:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3bc2064e-e94d-984c-edab-50b4dc2fd2dd@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594285486; bh=8qisClleseagOjMZhpG3BPg84Jvhtb/1QRMvMnOEW9Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=g+QhVkb1ExcABcfE19R/xeH0NhOQ6DMWOpfRBM21qw6Ucdf6c3VXucHRkZ0L5ACiZ
         NCyQoPvV1n9rNXge2P3gyUivBb8Vg+GM0Gs/obNKWniXH+nzo9wYhTNLaLlY09k1ey
         T1vuYDInT/b6gHhJ3F5vOin6HtSDHop/g7MNQFZwtSvzJpLC40tvXbleF8R0UleP3+
         tsyBPFWwdTOwBh9jqKXZKnRFkdbhQpkhbizc4QVMWKddI5HkhiIphQia1emraQ4n3D
         HOB3y6XkyM/3qGjPRPjPSZaTXYTKBIeOMf4m0hXIZMOaGBhY+JszxWORNCWRmxDJaQ
         kzFWGSDBxMeJg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 08/07/2020 15:32, Dmitry Osipenko wrote:
> 08.07.2020 15:34, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 02/07/2020 01:13, Dmitry Osipenko wrote:
>>> The enter() callback of CPUIDLE drivers returns index of the entered id=
le
>>> state on success or a negative value on failure. The negative value cou=
ld
>>> any negative value, i.e. it doesn't necessarily needs to be a error cod=
e.
>>> That's because CPUIDLE core only cares about the fact of failure and no=
t
>>> about the reason of the enter() failure.
>>>
>>> Like every other enter() callback, the arm_cpuidle_simple_enter() retur=
ns
>>> the entered idle-index on success. Unlike some of other drivers, it nev=
er
>>> fails. It happened that TEGRA_C1=3Dindex=3Derr=3D0 in the code of cpuid=
le-tegra
>>> driver, and thus, there is no problem for the cpuidle-tegra driver crea=
ted
>>> by the typo in the code which assumes that the arm_cpuidle_simple_enter=
()
>>> returns a error code.
>>>
>>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_I=
DLE
>>> is disabled in a kernel's config, but all CPUIDLE drivers are disabled =
if
>>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't e=
ver
>>> see the error code from arm_cpuidle_simple_enter() today.
>>>
>>> Of course the code may get some changes in the future and then the typo
>>> may transform into a real bug, so let's correct the typo in the code by
>>> making tegra_cpuidle_enter() to directly return the index returned by t=
he
>>> arm_cpuidle_simple_enter().
>>
>> Are you suggesting that arm_cpuidle_simple_enter() could be updated to
>> actually return an error? Sorry it is not clear to me what you are imply=
ing.
>=20
> Hello, Jon!
>=20
> Yes, I'm saying that *potentially* arm_cpuidle_simple_enter() could be
> updated to actually return error.


OK, then I am confused, because after your change, we would now ignore
any error that could be returned in the future. Yes the current code
does not set the variable 'index' correctly, but before we set the value
of 'index' shouldn't we check that the value being returned is not a
negative error code first?

Jon

--=20
nvpublic
