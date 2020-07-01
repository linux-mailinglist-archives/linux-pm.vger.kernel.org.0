Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E915C210CE3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgGAN4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 09:56:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3026 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbgGAN4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 09:56:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efc95de0000>; Wed, 01 Jul 2020 06:55:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 06:56:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 06:56:32 -0700
Received: from [10.26.73.166] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 13:56:29 +0000
Subject: Re: [PATCH v1] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200629222625.674-1-digetx@gmail.com>
 <d9efb0f5-d6ab-f3db-540e-c6ae1b42e45e@nvidia.com>
 <4bae133b-1b51-281c-1759-ca0d259b18ca@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a55f74fd-1105-1576-8f73-d6d3062541ef@nvidia.com>
Date:   Wed, 1 Jul 2020 14:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4bae133b-1b51-281c-1759-ca0d259b18ca@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593611742; bh=EMWMJUejyuuhJ9vm4W0toQ1U+9WqTXqXluLjiCBms6M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GlZ/8wIpNAblSfcm0TGvny5LI+9hdzzTt5QPr0ey9uLdpDJmfX3eNJv4y1v+IRNzr
         I7Yz/nAf1gcnVUyL7KkJEGmuyWkjuLdObFblJI7ErLeRPFvWKMb7/m5IM0e/1orRe0
         FTA28VqH2TL9rM+guvb5MRuz3Jh+Zfzu35TF+QeowlgNs3XGy6eV8zPrDcNOmXkzDe
         +5Fxcyf+vdr3UK7zFxLMybeHz+t/CZpIgRfFROAzrlT5vyD2IHiPRijoNEpkILhe7a
         RicVQjQ3iV7cyDPGOJBeL8jH+T0I8oAOnEI6QOs9uTLmeGjBg1xaYz+1bwhdlB8SO9
         AMKiD05UOCO6g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 30/06/2020 19:54, Dmitry Osipenko wrote:
> 30.06.2020 12:02, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 29/06/2020 23:26, Dmitry Osipenko wrote:
>>> The arm_cpuidle_simple_enter() returns the entered idle-index and not a
>>> error code. It happened that TEGRA_C1=3Dindex=3Derr=3D0, and hence this=
 typo
>>> was difficult to notice in the code since everything happened to work
>>> properly. This patch fixes the minor typo, it doesn't fix any problem.
>>
>> I guess that is dependent on if CPUIDLE is enabled ...
>>
>> #ifdef CONFIG_CPU_IDLE
>> extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>>                 struct cpuidle_driver *drv, int index);
>> #else
>> static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>>                  struct cpuidle_driver *drv, int index) { return -ENODEV=
; }
>> #endif
>>
>> Looks like it could return an error.
>=20
> Hello Jon!
>=20
> The cpuidle's enter() callback returns an index of the entered state on
> success, on negative value on failure.

Yes, however, when I read the first sentence of the changelog it seemed
to suggested it would never return and error code. Perhaps you meant in
the context of the Tegra CPUIdle driver because CPU_IDLE is always enabled?

> The negative number *could be* a proper error code, but in the same time
> it also doesn't matter what's the exact negative value is for the
> cpuidle's core code. Please see more below!
>=20
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/cpuidle/cpuidle-tegra.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-=
tegra.c
>>> index 150045849d78..9e9a9cccd755 100644
>>> --- a/drivers/cpuidle/cpuidle-tegra.c
>>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>>> @@ -236,14 +236,14 @@ static int tegra_cpuidle_enter(struct cpuidle_dev=
ice *dev,
>>>  			       int index)
>>>  {
>>>  	unsigned int cpu =3D cpu_logical_map(dev->cpu);
>>> -	int err;
>>> +	int err =3D 0;
>>> =20
>>>  	index =3D tegra_cpuidle_adjust_state_index(index, cpu);
>>>  	if (dev->states_usage[index].disable)
>>>  		return -1;
>>> =20
>>>  	if (index =3D=3D TEGRA_C1)
>>> -		err =3D arm_cpuidle_simple_enter(dev, drv, index);
>>> +		index =3D arm_cpuidle_simple_enter(dev, drv, index);
>>>  	else
>>>  		err =3D tegra_cpuidle_state_enter(dev, index, cpu);
>>> =20
>>>
>>
>> However, I do think that there is something not right in the error handl=
ing
>> here. Would also be nice to get rid of these -1.
>=20
> IIRC, the -1 was borrowed from some other cpuidle driver, for example
> cpuidle-psci[1] and coupled.c[2] are returning -1 on a failure.

Indeed. Maybe we just let sleeping dogs lie in this case.

Jon

--=20
nvpublic
