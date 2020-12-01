Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF902CAD8C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 21:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgLAUnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 15:43:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11757 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLAUnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 15:43:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6aac10000>; Tue, 01 Dec 2020 12:42:41 -0800
Received: from [10.26.72.142] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 20:42:33 +0000
Subject: Re: [PATCH v10 17/19] ARM: tegra: Add EMC OPP properties to Tegra20
 device-trees
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Kyungmin Park" <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        "Peter Geis" <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-18-digetx@gmail.com>
 <60657f5e-bd30-094e-f8df-6ba69e0d6a3e@nvidia.com>
 <1ed05baf-3a01-3a2b-cd79-98b356c846cf@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7725904d-e623-a389-2c41-fe0640afcf86@nvidia.com>
Date:   Tue, 1 Dec 2020 20:42:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1ed05baf-3a01-3a2b-cd79-98b356c846cf@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606855361; bh=ld6kAg1ZGh9k+yMFotmNwIWPtWIZHMAcX5cj9qgmwHM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Zmzy4nbs0RS7fFDgUWb4EfpZwT1/EeyUp2PWE2OS3XHzA24MgwTDAdrbXR1dWG463
         4s7OGfmpZ2IA+DjoxwmATD3NdbxYI2V+gXiW1kQOuqz65aaNww17A/wOMXjKgNOzVX
         C6sn7spIMa0nNR4I3SZiyX5PvhzcA4scysgzQmnlaZKGTN7bHCCMpHcDo4myiR4sDv
         ZeBGPbT9B4KlygU9HXq7t+Xek3nsaO1VUznLI1EFs4vf3QfXXrqHJZvheUxEr0j1uX
         Mja2NGB1syddUj+IOrYino9xivHVkTrlmgxuDRA8WA3bRslrl2EWJ4/IvG92he+geG
         2ZLiCaY1PT2MQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 30/11/2020 22:57, Dmitry Osipenko wrote:
> 01.12.2020 00:17, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hi Dmitry,
>>
>> On 23/11/2020 00:27, Dmitry Osipenko wrote:
>>> Add EMC OPP DVFS tables and update board device-trees by removing
>>> unsupported OPPs.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> This change is generating the following warning on Tegra20 Ventana
>> and prevents the EMC from probing ...
>>
>> [    2.485711] tegra20-emc 7000f400.memory-controller: device-tree doesn=
't have memory timings
>> [    2.499386] tegra20-emc 7000f400.memory-controller: 32bit DRAM bus
>> [    2.505810] ------------[ cut here ]------------
>> [    2.510511] WARNING: CPU: 0 PID: 1 at /local/workdir/tegra/mlt-linux_=
next/kernel/drivers/opp/of.c:875 _of_add_opp_table_v2+0x598/0x61c
>> [    2.529746] Modules linked in:
>> [    2.540140] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc5-next=
-20201130 #1
>> [    2.554606] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> [    2.560892] [<c011136c>] (unwind_backtrace) from [<c010bb60>] (show_s=
tack+0x10/0x14)
>> [    2.568640] [<c010bb60>] (show_stack) from [<c0bcee54>] (dump_stack+0=
xc8/0xdc)
>> [    2.575866] [<c0bcee54>] (dump_stack) from [<c01235dc>] (__warn+0x104=
/0x108)
>> [    2.582912] [<c01235dc>] (__warn) from [<c0123690>] (warn_slowpath_fm=
t+0xb0/0xb8)
>> [    2.590397] [<c0123690>] (warn_slowpath_fmt) from [<c0825ad0>] (_of_a=
dd_opp_table_v2+0x598/0x61c)
>> [    2.599269] [<c0825ad0>] (_of_add_opp_table_v2) from [<c0825b90>] (de=
v_pm_opp_of_add_table+0x3c/0x1a0)
>> [    2.608582] [<c0825b90>] (dev_pm_opp_of_add_table) from [<c087b774>] =
(tegra_emc_probe+0x478/0x940)
>> [    2.617548] [<c087b774>] (tegra_emc_probe) from [<c0654398>] (platfor=
m_drv_probe+0x48/0x98)
>> [    2.625899] [<c0654398>] (platform_drv_probe) from [<c0652238>] (real=
ly_probe+0x218/0x3b8)
>> [    2.634162] [<c0652238>] (really_probe) from [<c0652540>] (driver_pro=
be_device+0x5c/0xb4)
>> [    2.642338] [<c0652540>] (driver_probe_device) from [<c0652740>] (dev=
ice_driver_attach+0x58/0x60)
>> [    2.651208] [<c0652740>] (device_driver_attach) from [<c06527c8>] (__=
driver_attach+0x80/0xbc)
>> [    2.659730] [<c06527c8>] (__driver_attach) from [<c0650610>] (bus_for=
_each_dev+0x74/0xb4)
>> [    2.667905] [<c0650610>] (bus_for_each_dev) from [<c06515f8>] (bus_ad=
d_driver+0x164/0x1e8)
>> [    2.676168] [<c06515f8>] (bus_add_driver) from [<c06532a8>] (driver_r=
egister+0x7c/0x114)
>> [    2.684259] [<c06532a8>] (driver_register) from [<c0102208>] (do_one_=
initcall+0x54/0x2b0)
>> [    2.692441] [<c0102208>] (do_one_initcall) from [<c10010cc>] (kernel_=
init_freeable+0x1a4/0x1f4)
>> [    2.701145] [<c10010cc>] (kernel_init_freeable) from [<c0bd4510>] (ke=
rnel_init+0x8/0x118)
>> [    2.709321] [<c0bd4510>] (kernel_init) from [<c01001b0>] (ret_from_fo=
rk+0x14/0x24)
>> [    2.716885] Exception stack(0xc1501fb0 to 0xc1501ff8)
>> [    2.721933] 1fa0:                                     00000000 000000=
00 00000000 00000000
>> [    2.730106] 1fc0: 00000000 00000000 00000000 00000000 00000000 000000=
00 00000000 00000000
>> [    2.738278] 1fe0: 00000000 00000000 00000000 00000000 00000013 000000=
00
>> [    2.751940] ---[ end trace 61e3b76deca27ef3 ]---
>>
>>
>> Cheers
>> Jon
>>
>=20
> Hello Jon,
>=20
> That is harmless and expected to happen because the patch "memory:
> tegra20: Support hardware versioning and clean up OPP table
> initialization" isn't applied yet, while Thierry already applied the DT
> patches from this v10.


Thanks, pulling in that patch did fix it.

Jon

--=20
nvpublic
