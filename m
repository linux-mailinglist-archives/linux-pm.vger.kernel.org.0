Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292711EB679
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFBHRO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 03:17:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35169 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgFBHRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 03:17:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200602071709euoutp0155ad7070c37db935532f935d0b427eb2~UqNuHaULj2403824038euoutp01S
        for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2020 07:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200602071709euoutp0155ad7070c37db935532f935d0b427eb2~UqNuHaULj2403824038euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591082229;
        bh=JsgrURxyyIUcRr6e0rQIdWvE6G69hadgaZJB07kL+hs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ieQ+EmLbJmtY47rMx9ZGpyrMKpV/16ysGNgllmAb0rnMaCNgCKGEGGJcA2E4ackyV
         A9/IIPqjEc1pn14t/UKQPuSpw1XVWNDdIIca/fMuHycMxyZd7q4FaHJ0UTi8jGenPV
         D6twUl/BWSOhOk3kap5r3PD6RvKz94T85fRXK1pY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602071708eucas1p239b7a316344c6da38d1951b79654c573~UqNt6nhjP3233632336eucas1p2x;
        Tue,  2 Jun 2020 07:17:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.BB.61286.4FCF5DE5; Tue,  2
        Jun 2020 08:17:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602071708eucas1p2649a2c4ff129269aa3d643c84dacf5f3~UqNtZ5QDZ0274302743eucas1p2e;
        Tue,  2 Jun 2020 07:17:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602071708eusmtrp1bb2e028cec46324e7b291f98e43e930f~UqNtYjVOu1355213552eusmtrp19;
        Tue,  2 Jun 2020 07:17:08 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-f3-5ed5fcf4afb1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.CE.08375.4FCF5DE5; Tue,  2
        Jun 2020 08:17:08 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200602071707eusmtip28efe06720880f12a3644fb3d6ad60776~UqNs4hMYN0686806868eusmtip2K;
        Tue,  2 Jun 2020 07:17:07 +0000 (GMT)
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b3fd35de-1dd6-1ddc-7e57-2d9ab2860e81@samsung.com>
Date:   Tue, 2 Jun 2020 09:17:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601170528.r5w3aeijny3v5yx3@earth.universe>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7pf/lyNM5i1ytJi/pFzrBbNi9ez
        WWw+18NqcXnXHDaLz71HGC1mnN/HZDH3y1Rmi9a9R9gt7r72c+D02HF3CaPHplWdbB77565h
        9/i8SS6AJYrLJiU1J7MstUjfLoErY8urb+wFyzQr5p04w9bA2KjcxcjBISFgIrHsO2sXIyeH
        kMAKRolXp627GLmA7C+MEnNP3mGBcD4zSpy68J8NpAqk4cjPXcwQieWMEmu6D7JBOO8ZJRqX
        HWAGqRIWsJD4sug3O4gtImAuceLWTUaQImaBVUwSc9b1gxWxCRhKdL3tAhvLK2An8eT8LVaQ
        m1gEVCS+HAQLiwrESvTcf8UMUSIocXLmExYQm1PAVuL2k5dgNrOAvETz1tnMELa4xK0n85lA
        dkkI7GOXuLBtKgvE2S4SJ+b9Y4ewhSVeHd8CZctInJ7cwwLR0Mwo8fDcWnYIp4dR4nLTDEaI
        KmuJO+d+sYFcxyygKbF+lz5E2FFi4uHdzJCA5JO48VYQ4gg+iUnbpkOFeSU62oQgqtUkZh1f
        B7f24IVLzBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3
        MQJT0el/xz/tYPx6KekQowAHoxIP74b7V+KEWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqU
        H19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOj29eu9GSL6b9Lkg/tkPGU
        e2BTURSdulP5fPFqltS5Fv//v1mk6Z6uMEl+ddObqfuTct873NXeFpZsapO9ZVvIqfMLcm8I
        SD/mvsBx9OtO+6Ae718fEkOYXrA/WZMcf5015GtB1V7/33Hlvpc2q1vqTchy/xnDzpMcYPBh
        d6jhl5mbPFKD+6SVWIozEg21mIuKEwF1g6GrQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7pf/lyNM/i0R8xi/pFzrBbNi9ez
        WWw+18NqcXnXHDaLz71HGC1mnN/HZDH3y1Rmi9a9R9gt7r72c+D02HF3CaPHplWdbB77565h
        9/i8SS6AJUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEvY8urb+wFyzQr5p04w9bA2KjcxcjJISFgInHk5y7mLkYuDiGBpYwSd08sZYJIyEicnNbA
        CmELS/y51sUGUfSWUaLp2ydGkISwgIXEl0W/2UFsEQFziRO3bjKCFDELrGKS+H9sBQtERyOT
        xP0rz8DGsgkYSnS9BRnFycErYCfx5PwtoBUcHCwCKhJfDoKFRQViJboX/2CHKBGUODnzCQuI
        zSlgK3H7yUswm1nATGLe5ofMELa8RPPW2VC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnF
        KJJaWpybnltsqFecmFtcmpeul5yfu4kRGH/bjv3cvIPx0sbgQ4wCHIxKPLwb7l+JE2JNLCuu
        zD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wNTQ15JvKGpobmFpaG5
        sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkadd5kioc5bgjLrD/uW71a2N825oC7d
        eNTs7/7+1XN3+E8sdqv/EXqRr3I7j0jzoociEy8qn3zPO2XH8glxKwz9fl9oOb1BzubQTZNf
        G6P7tt2rz01Zyce7wY+j6amph3BzTUesrcGkPtZ3yi57fk1yc84J2PjD6PpCt/fbenqfcK/N
        2hvLekWJpTgj0VCLuag4EQBtMWe91QIAAA==
X-CMS-MailID: 20200602071708eucas1p2649a2c4ff129269aa3d643c84dacf5f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601104027eucas1p2b076ee860520d709e8178c41550653f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601104027eucas1p2b076ee860520d709e8178c41550653f7
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
        <CGME20200601104027eucas1p2b076ee860520d709e8178c41550653f7@eucas1p2.samsung.com>
        <15933a91-dd89-1f94-c2f2-79be4395f4c1@samsung.com>
        <20200601170528.r5w3aeijny3v5yx3@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 01.06.2020 19:05, Sebastian Reichel wrote:
> On Mon, Jun 01, 2020 at 12:40:27PM +0200, Marek Szyprowski wrote:
>> On 13.05.2020 20:55, Sebastian Reichel wrote:
>>> This patchset improves support for SBS compliant batteries. Due to
>>> the changes, the battery now exposes 32 power supply properties and
>>> (un)plugging it generates a backtrace containing the following message
>>> without the first patch in this series:
>>>
>>> ---------------------------
>>> WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4/0x104
>>> add_uevent_var: too many keys
>>> ---------------------------
>>>
>>> For references this is what an SBS battery status looks like after
>>> the patch series has been applied:
>>>
>>> cat /sys/class/power_supply/sbs-0-000b/uevent
>>> POWER_SUPPLY_NAME=sbs-0-000b
>>> POWER_SUPPLY_TYPE=Battery
>>> POWER_SUPPLY_STATUS=Discharging
>>> POWER_SUPPLY_CAPACITY_LEVEL=Normal
>>> POWER_SUPPLY_HEALTH=Good
>>> POWER_SUPPLY_PRESENT=1
>>> POWER_SUPPLY_TECHNOLOGY=Li-ion
>>> POWER_SUPPLY_CYCLE_COUNT=12
>>> POWER_SUPPLY_VOLTAGE_NOW=11441000
>>> POWER_SUPPLY_CURRENT_NOW=-26000
>>> POWER_SUPPLY_CURRENT_AVG=-24000
>>> POWER_SUPPLY_CAPACITY=76
>>> POWER_SUPPLY_CAPACITY_ERROR_MARGIN=1
>>> POWER_SUPPLY_TEMP=198
>>> POWER_SUPPLY_TIME_TO_EMPTY_AVG=438600
>>> POWER_SUPPLY_TIME_TO_FULL_AVG=3932100
>>> POWER_SUPPLY_SERIAL_NUMBER=0000
>>> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=10800000
>>> POWER_SUPPLY_VOLTAGE_MAX_DESIGN=10800000
>>> POWER_SUPPLY_ENERGY_NOW=31090000
>>> POWER_SUPPLY_ENERGY_FULL=42450000
>>> POWER_SUPPLY_ENERGY_FULL_DESIGN=41040000
>>> POWER_SUPPLY_CHARGE_NOW=2924000
>>> POWER_SUPPLY_CHARGE_FULL=3898000
>>> POWER_SUPPLY_CHARGE_FULL_DESIGN=3800000
>>> POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3000000
>>> POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=12300000
>>> POWER_SUPPLY_MANUFACTURE_YEAR=2017
>>> POWER_SUPPLY_MANUFACTURE_MONTH=7
>>> POWER_SUPPLY_MANUFACTURE_DAY=3
>>> POWER_SUPPLY_MANUFACTURER=UR18650A
>>> POWER_SUPPLY_MODEL_NAME=GEHC
>> This patch landed in linux-next dated 20200529. Sadly it causes a
>> regression on Samsung Exynos-based Chromebooks (Exynos5250 Snow,
>> Exynos5420 Peach-Pi and Exynos5800 Peach-Pit). System boots to
>> userspace, but then, when udev populates /dev, booting hangs:
>>
>> [    4.435167] VFS: Mounted root (ext4 filesystem) readonly on device
>> 179:51.
>> [    4.457477] devtmpfs: mounted
>> [    4.460235] Freeing unused kernel memory: 1024K
>> [    4.464022] Run /sbin/init as init process
>> INIT: version 2.88 booting
>> [info] Using makefile-style concurrent boot in runlevel S.
>> [    5.102096] random: crng init done
>> [....] Starting the hotplug events dispatcher: systemd-udevdstarting
>> version 236
>> [ ok .
>> [....] Synthesizing the initial hotplug events...[ ok done.
>> [....] Waiting for /dev to be fully populated...[   34.409914]
>> TPS65090_RAILSDCDC1: disabling
>> [   34.412977] TPS65090_RAILSDCDC2: disabling
>> [   34.417021] TPS65090_RAILSDCDC3: disabling
>> [   34.423848] TPS65090_RAILSLDO1: disabling
>> [   34.429068] TPS65090_RAILSLDO2: disabling
> :(
>
> log does not look useful either.
>
>> Bisect between v5.7-rc1 and next-20200529 pointed me to the first bad
>> commit: [c4b12a2f3f3de670f6be5e96092a2cab0b877f1a] power: supply:
>> sbs-battery: simplify read_read_string_data.
> ok. I tested this on an to-be-upstreamed i.MX6 based system
> and arch/arm/boot/dts/imx53-ppd.dts. I think the difference
> is, that i2c-exynos5 does not expose I2C_FUNC_SMBUS_READ_BLOCK_DATA.
> I hoped all systems using SBS battery support this, but now
> I see I2C_FUNC_SMBUS_EMUL only supports writing block data.
> Looks like I need to add another patch implementing that
> using the old code with added PEC support.
>
> In any case that should only return -ENODEV for the property
> (and uevent), but not break boot. So something fishy is going
> on.
>
>> However reverting it in linux-next doesn't fix the issue, so the
>> next commits are also relevant to this issue.
> The next patch, which adds PEC support depends on the simplification
> of sbs_read_string_data. The old, open coded variant will result in
> PEC failure for string properties (which should not stop boot either
> of course). Can you try reverting both?
Indeed, reverting both (and fixing the conflict) restores proper boot.
> If that helps I will revert those two instead of dropping the whole
> series for this merge window.
>
>> Let me know how can I help debugging it.
> I suspect, that this is userspace endlessly retrying reading the
> battery uevent when an error is returned. Could you check this?
> Should be easy to see by adding some printfs.
I've added some debug messages in sbs_get_property() and it read the 
same properties many times. However I've noticed that if I wait long 
enough booting finally continues.
> That would mean a faulty battery could stall complete boot without
> a useful error message, which is bad and needs to be fixed.
>
> Sorry for the inconvience and thanks for your report,

No problem, finding regressions is one of the linux-next goal.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

