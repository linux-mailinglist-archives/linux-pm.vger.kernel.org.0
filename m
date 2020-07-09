Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74169219C9A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGIJvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 05:51:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14872 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 05:51:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f06e8580000>; Thu, 09 Jul 2020 02:50:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jul 2020 02:51:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jul 2020 02:51:11 -0700
Received: from [10.26.72.135] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 09:51:09 +0000
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
 <be99caca-b50a-0e12-29dc-2da0d924af43@nvidia.com>
 <55744bfb-af5e-ed2e-654c-d6de9b26b696@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fb6370d9-cae9-15dd-a19b-c3116256b471@nvidia.com>
Date:   Thu, 9 Jul 2020 10:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <55744bfb-af5e-ed2e-654c-d6de9b26b696@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594288216; bh=zGvzUUaE4SvvvAl0wHYSmtgiQoAbn1iGMQ3KZm0WerE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Hzqc2bAXYMI5rh2qs+BLXRBl52c6XMxvtmwMuqygF4SpPSa4kM603n5rD6x0y7MsI
         c7hqRiD0FTB2IM5LBxefT4Nx2li+qKK6t4B5yUuXThv5qC+38P1EipFg1TE11SqUr4
         YU+PK6MYgi/PDwTvGpDrkrWX2JYxHHL9M2B7MnN5y/sr88DcrvA4Rz6s0AMFzS5UQJ
         r5XLmP4d97oRO2dLkfHv+HLRWTlftroUSJdIG+MlkYTqHHlCHQSSgDhPhxfXjFyOsx
         r7TFcdaL9RYk7Oi23/dAkrmOaWOtKeBYCzicuCfOY/nUdDMOsMGouPfVQvTDOUXJ+U
         6b11sExlIUULA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 09/07/2020 10:48, Dmitry Osipenko wrote:
> 09.07.2020 12:06, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 08/07/2020 15:32, Dmitry Osipenko wrote:
>>> 08.07.2020 15:34, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 02/07/2020 01:13, Dmitry Osipenko wrote:
>>>>> The enter() callback of CPUIDLE drivers returns index of the entered =
idle
>>>>> state on success or a negative value on failure. The negative value c=
ould
>>>>> any negative value, i.e. it doesn't necessarily needs to be a error c=
ode.
>>>>> That's because CPUIDLE core only cares about the fact of failure and =
not
>>>>> about the reason of the enter() failure.
>>>>>
>>>>> Like every other enter() callback, the arm_cpuidle_simple_enter() ret=
urns
>>>>> the entered idle-index on success. Unlike some of other drivers, it n=
ever
>>>>> fails. It happened that TEGRA_C1=3Dindex=3Derr=3D0 in the code of cpu=
idle-tegra
>>>>> driver, and thus, there is no problem for the cpuidle-tegra driver cr=
eated
>>>>> by the typo in the code which assumes that the arm_cpuidle_simple_ent=
er()
>>>>> returns a error code.
>>>>>
>>>>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU=
_IDLE
>>>>> is disabled in a kernel's config, but all CPUIDLE drivers are disable=
d if
>>>>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't=
 ever
>>>>> see the error code from arm_cpuidle_simple_enter() today.
>>>>>
>>>>> Of course the code may get some changes in the future and then the ty=
po
>>>>> may transform into a real bug, so let's correct the typo in the code =
by
>>>>> making tegra_cpuidle_enter() to directly return the index returned by=
 the
>>>>> arm_cpuidle_simple_enter().
>>>>
>>>> Are you suggesting that arm_cpuidle_simple_enter() could be updated to
>>>> actually return an error? Sorry it is not clear to me what you are imp=
lying.
>>>
>>> Hello, Jon!
>>>
>>> Yes, I'm saying that *potentially* arm_cpuidle_simple_enter() could be
>>> updated to actually return error.
>>
>>
>> OK, then I am confused, because after your change, we would now ignore
>> any error that could be returned in the future. Yes the current code
>> does not set the variable 'index' correctly, but before we set the value
>> of 'index' shouldn't we check that the value being returned is not a
>> negative error code first?
>=20
> Could you please clarify what do you mean by "ignore any error"? Do you
> mean the error message?

Yes exactly. We would skip that, which seems a bit odd.

Jon

--=20
nvpublic
