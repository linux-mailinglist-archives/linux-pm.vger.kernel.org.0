Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD53266A16
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGLJjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 05:39:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5678 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfGLJjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 05:39:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2855610000>; Fri, 12 Jul 2019 02:39:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jul 2019 02:39:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jul 2019 02:39:50 -0700
Received: from [10.26.11.231] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jul
 2019 09:39:48 +0000
Subject: Re: [PATCH v2 1/6] ARM: tegra: Remove cpuidle drivers
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190711031312.10038-1-digetx@gmail.com>
 <20190711031312.10038-2-digetx@gmail.com>
 <c087a5cb-2ffa-1cf6-f0bf-631234759a22@nvidia.com>
 <a6e4b43e-369c-c501-6d2e-69d5b940ff9c@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <73781434-d25a-b17b-aacb-95ace5ac5f95@nvidia.com>
Date:   Fri, 12 Jul 2019 10:39:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a6e4b43e-369c-c501-6d2e-69d5b940ff9c@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562924385; bh=BjEEnlO9O+zgudZW6w3hxaxX8/FGppOMM/Qa3Jlnws0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p8V9Fe27cbTQDdxy6BaYPu1UaWNdHPFxaBAXSh3B1eFXjKn9t1rFMWge+n48VM1jx
         sAyEzqcX2d+5dRWWMaoUjfTegYfTtOZexWga1qzERUVFWsPtCvYgRq5Tkw84niUv9r
         L7jvU+fM/uKU70UxnhEgLMMDymy/j4Ikxivsyo/+iH39a1/lGeAIpTY/IrpUz4jTeA
         rFy1ZDxrbIkjVX3HMwQMtHmYi/S9cTseqW33SZQK5E/WDPMFSekeO5UGYyxHgCzA5U
         F8WhlXjZtrjk6007ZMoVZCSOT+OxHa7KUsp9MLsjpUQaZlKmTEnUzjl4bw3q5N0uvd
         ffDfg49DVV1Ow==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/07/2019 18:03, Dmitry Osipenko wrote:
> 11.07.2019 12:26, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 11/07/2019 04:13, Dmitry Osipenko wrote:
>>> Remove the old drivers to replace them cleanly with a new one later on.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  arch/arm/mach-tegra/Makefile           |  13 --
>>>  arch/arm/mach-tegra/cpuidle-tegra114.c |  89 -----------
>>>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -------------------------
>>>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 ---------------
>>>  arch/arm/mach-tegra/cpuidle.c          |  50 ------
>>>  arch/arm/mach-tegra/cpuidle.h          |  21 ---
>>>  arch/arm/mach-tegra/irq.c              |  18 ---
>>>  arch/arm/mach-tegra/irq.h              |  11 --
>>>  arch/arm/mach-tegra/pm.c               |   7 -
>>>  arch/arm/mach-tegra/pm.h               |   1 -
>>>  arch/arm/mach-tegra/reset-handler.S    |  11 --
>>>  arch/arm/mach-tegra/reset.h            |   9 +-
>>>  arch/arm/mach-tegra/sleep-tegra20.S    | 190 +---------------------
>>>  arch/arm/mach-tegra/sleep.h            |  12 --
>>>  arch/arm/mach-tegra/tegra.c            |   3 -
>>>  drivers/soc/tegra/Kconfig              |   1 -
>>>  include/soc/tegra/cpuidle.h            |   4 -
>>>  17 files changed, 5 insertions(+), 779 deletions(-)
>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.c
>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.h
>>>  delete mode 100644 arch/arm/mach-tegra/irq.h
>>
>> By removing all the above, it is really hard to review the diff. Is
>> there any way you could first consolidate the cpuidle drivers into say
>> the existing arch/arm/mach-tegra/cpuidle-tegra20.c and then move to
>> drivers/cpuidle?
>=20
> I'm afraid that it will make reviewing even more difficult because
> everything that is removed here is not returned in the further patches.
> The new driver is based on the older ones, but I wrote it from scratch
> and it's not only looks different, but also works a bit different as you
> may see.
>=20
> Could you please clarify what exactly makes it hard to review? The diff
> looks pretty clean to me, while squashing everything into existing
> driver should be quite a mess.

Ideally a patch should standalone and can be reviewed by itself.
However, to review this, we need to review patches 1, 2 and 3 at the
same time. So IMO it is not that convenient from a reviewers
perspective. Furthermore, patches 1 and 3 are large and so easy to miss
something.

Is there really no way to have a patch to combined the existing drivers,
then a patch to convert them into the newer rewritten version you have
implemented, then move the driver?

Jon

--=20
nvpublic
