Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76F1ED65E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCStk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 14:49:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35009 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgFCStj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 14:49:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200603184938euoutp01a6b0796e13216dba7da9b3935539726b~VHTn0mOIZ1406414064euoutp01e
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 18:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200603184938euoutp01a6b0796e13216dba7da9b3935539726b~VHTn0mOIZ1406414064euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591210178;
        bh=YKIUkBl+i3nWmua71Tqp7CpD5PkjVjfibSNwRGPfGsg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LQj5gdjsRROIv657HcLTWwgLyaayR7fmN6EmqCfSxe9WSDRtbrMg//fso2uA/ubIR
         QJbjipTMcDv0wQOVjFLQ8VZqgz73XvL/DhdO9gbQ6OS57pu5zsSfcwiRqM0cM/GGfL
         U5CPJidj/oYrSml6nEPVNeBnn1XM37tmJrz1nxAw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200603184937eucas1p2afab162e8479be72f2e25e827ee5798b~VHTnpgMZU2433624336eucas1p2W;
        Wed,  3 Jun 2020 18:49:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 35.3F.60698.1C0F7DE5; Wed,  3
        Jun 2020 19:49:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200603184937eucas1p20bd459cd754b6ccf28ae318740325e5d~VHTnPCk4E0047300473eucas1p20;
        Wed,  3 Jun 2020 18:49:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200603184937eusmtrp2b93537329eba0628cf79ebfb05c8e63e~VHTnOZsUK0281802818eusmtrp2W;
        Wed,  3 Jun 2020 18:49:37 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-1e-5ed7f0c137f0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.A2.08375.1C0F7DE5; Wed,  3
        Jun 2020 19:49:37 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200603184936eusmtip222e2e6b2fa1d5ee11d5d1128bf245253~VHTmm3Ta-0069500695eusmtip2-;
        Wed,  3 Jun 2020 18:49:36 +0000 (GMT)
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a210e6e0-32db-98e9-f217-cec538407191@samsung.com>
Date:   Wed, 3 Jun 2020 20:49:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602180119.52izs7kd72u3kmr4@earth.universe>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7oHP1yPM1gzwcRi/pFzrBbNi9ez
        WWw+18NqcXnXHDaLz71HGC1mnN/HZDH3y1Rmi9a9R9gt7r72c+D02HF3CaPHplWdbB77565h
        9/i8SS6AJYrLJiU1J7MstUjfLoErY8mqeYwFv3Ur3szzbmBsVe9i5OSQEDCRWNfYzd7FyMUh
        JLCCUeLA6jPMEM4XRokl096zQjifGSV+LzzHBtNyYkEDE0RiOaPEljmX2UESQgLvGSVW7/cA
        sYUFLCS+LPoNFhcRMJc4cesmI0gDs8AqJok56/qZQRJsAoYSXW+7wKbyCthJ3F22hwnEZhFQ
        kfhx6CKYLSoQK9Fz/xUzRI2gxMmZT1i6GDk4OAVsJV5dEAEJMwvISzRvnc0MYYtL3HoyH+w4
        CYFd7BJ7f61igbjaReLKgy2sELawxKvjW9ghbBmJ/zthGpoZJR6eW8sO4fQwSlxumsEIUWUt
        cefcLzaQzcwCmhLrd+lDhB0lJh7ezQwSlhDgk7jxVhDiCD6JSdumQ4V5JTrahCCq1SRmHV8H
        t/bghUvMExiVZiH5bBaSd2YheWcWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcx
        AlPR6X/Hv+5g3Pcn6RCjAAejEg8vQ931OCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwMhjIV+Y/V4xSvfFmRsnijr2
        /pKz73q6l39O1uTCe6kN678xLppXmuS/YqVNYH9NpvfJBa7KP749LAwOsE6ZcUU8iDe88aOI
        xqUHdkwy8+a0S03WupPSriP+Lf3BTf48Vy6nmy8r+qS0ni6S1vZQXu6tmalxZ0drdOTxzJk5
        6zOeV/7QMbAsUmIpzkg01GIuKk4EAOOgsaFBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oHP1yPM7h9SMJi/pFzrBbNi9ez
        WWw+18NqcXnXHDaLz71HGC1mnN/HZDH3y1Rmi9a9R9gt7r72c+D02HF3CaPHplWdbB77565h
        9/i8SS6AJUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEvY8mqeYwFv3Ur3szzbmBsVe9i5OSQEDCROLGggamLkYtDSGApo0TH3bvMEAkZiZPTGlgh
        bGGJP9e62CCK3jJK/L72mR0kISxgIfFl0W8wW0TAXOLErZuMIEXMAquYJP4fW8EC0fGSSWJT
        13qwsWwChhJdb0FGcXLwCthJ3F22hwnEZhFQkfhx6CKYLSoQK9G9+Ac7RI2gxMmZT4AGcXBw
        CthKvLogAhJmFjCTmLf5ITOELS/RvHU2lC0ucevJfKYJjEKzkHTPQtIyC0nLLCQtCxhZVjGK
        pJYW56bnFhvqFSfmFpfmpesl5+duYgRG37ZjPzfvYLy0MfgQowAHoxIPL0Pd9Tgh1sSy4src
        Q4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BfptIrOUaHI+MDHklcQbmhqaW1gamhub
        G5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgbLy6beIMOYeImM9Xhf8uEiwQy3g/p3bX
        oifr97vn78h6wrDt1Le9mptcl/WG3MvNW3P50wqOrrYj3npzCqS/hd1u2iKQdmW6XPiiPW2C
        F+I4Tv7in7T0otCh+u1KvBmux9eJpe5qDOG6p6MxozXF58zph1fuBBxwkLhvuGBuSlmcs2y0
        a+sBHSWW4oxEQy3mouJEACqcDyvUAgAA
X-CMS-MailID: 20200603184937eucas1p20bd459cd754b6ccf28ae318740325e5d
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
        <b3fd35de-1dd6-1ddc-7e57-2d9ab2860e81@samsung.com>
        <20200602180119.52izs7kd72u3kmr4@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 02.06.2020 20:01, Sebastian Reichel wrote:
> On Tue, Jun 02, 2020 at 09:17:09AM +0200, Marek Szyprowski wrote:
>> On 01.06.2020 19:05, Sebastian Reichel wrote:
>>> On Mon, Jun 01, 2020 at 12:40:27PM +0200, Marek Szyprowski wrote:
>>>> On 13.05.2020 20:55, Sebastian Reichel wrote:
>>>>> This patchset improves support for SBS compliant batteries. Due to
>>>>> the changes, the battery now exposes 32 power supply properties and
>>>>> (un)plugging it generates a backtrace containing the following message
>>>>> without the first patch in this series:
>>>>>
>>>>> ---------------------------
>>>>> WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4/0x104
>>>>> add_uevent_var: too many keys
>>>>> ---------------------------
>>>>>
>>>>> For references this is what an SBS battery status looks like after
>>>>> the patch series has been applied:
>>>>>
>>>>> cat /sys/class/power_supply/sbs-0-000b/uevent
>>>>> POWER_SUPPLY_NAME=sbs-0-000b
>>>>> POWER_SUPPLY_TYPE=Battery
>>>>> POWER_SUPPLY_STATUS=Discharging
>>>>> POWER_SUPPLY_CAPACITY_LEVEL=Normal
>>>>> POWER_SUPPLY_HEALTH=Good
>>>>> POWER_SUPPLY_PRESENT=1
>>>>> POWER_SUPPLY_TECHNOLOGY=Li-ion
>>>>> POWER_SUPPLY_CYCLE_COUNT=12
>>>>> POWER_SUPPLY_VOLTAGE_NOW=11441000
>>>>> POWER_SUPPLY_CURRENT_NOW=-26000
>>>>> POWER_SUPPLY_CURRENT_AVG=-24000
>>>>> POWER_SUPPLY_CAPACITY=76
>>>>> POWER_SUPPLY_CAPACITY_ERROR_MARGIN=1
>>>>> POWER_SUPPLY_TEMP=198
>>>>> POWER_SUPPLY_TIME_TO_EMPTY_AVG=438600
>>>>> POWER_SUPPLY_TIME_TO_FULL_AVG=3932100
>>>>> POWER_SUPPLY_SERIAL_NUMBER=0000
>>>>> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=10800000
>>>>> POWER_SUPPLY_VOLTAGE_MAX_DESIGN=10800000
>>>>> POWER_SUPPLY_ENERGY_NOW=31090000
>>>>> POWER_SUPPLY_ENERGY_FULL=42450000
>>>>> POWER_SUPPLY_ENERGY_FULL_DESIGN=41040000
>>>>> POWER_SUPPLY_CHARGE_NOW=2924000
>>>>> POWER_SUPPLY_CHARGE_FULL=3898000
>>>>> POWER_SUPPLY_CHARGE_FULL_DESIGN=3800000
>>>>> POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3000000
>>>>> POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=12300000
>>>>> POWER_SUPPLY_MANUFACTURE_YEAR=2017
>>>>> POWER_SUPPLY_MANUFACTURE_MONTH=7
>>>>> POWER_SUPPLY_MANUFACTURE_DAY=3
>>>>> POWER_SUPPLY_MANUFACTURER=UR18650A
>>>>> POWER_SUPPLY_MODEL_NAME=GEHC
>>>> This patch landed in linux-next dated 20200529. Sadly it causes a
>>>> regression on Samsung Exynos-based Chromebooks (Exynos5250 Snow,
>>>> Exynos5420 Peach-Pi and Exynos5800 Peach-Pit). System boots to
>>>> userspace, but then, when udev populates /dev, booting hangs:
>>>>
>>>> [    4.435167] VFS: Mounted root (ext4 filesystem) readonly on device
>>>> 179:51.
>>>> [    4.457477] devtmpfs: mounted
>>>> [    4.460235] Freeing unused kernel memory: 1024K
>>>> [    4.464022] Run /sbin/init as init process
>>>> INIT: version 2.88 booting
>>>> [info] Using makefile-style concurrent boot in runlevel S.
>>>> [    5.102096] random: crng init done
>>>> [....] Starting the hotplug events dispatcher: systemd-udevdstarting
>>>> version 236
>>>> [ ok .
>>>> [....] Synthesizing the initial hotplug events...[ ok done.
>>>> [....] Waiting for /dev to be fully populated...[   34.409914]
>>>> TPS65090_RAILSDCDC1: disabling
>>>> [   34.412977] TPS65090_RAILSDCDC2: disabling
>>>> [   34.417021] TPS65090_RAILSDCDC3: disabling
>>>> [   34.423848] TPS65090_RAILSLDO1: disabling
>>>> [   34.429068] TPS65090_RAILSLDO2: disabling
>>> :(
>>>
>>> log does not look useful either.
>>>
>>>> Bisect between v5.7-rc1 and next-20200529 pointed me to the first bad
>>>> commit: [c4b12a2f3f3de670f6be5e96092a2cab0b877f1a] power: supply:
>>>> sbs-battery: simplify read_read_string_data.
>>> ok. I tested this on an to-be-upstreamed i.MX6 based system
>>> and arch/arm/boot/dts/imx53-ppd.dts. I think the difference
>>> is, that i2c-exynos5 does not expose I2C_FUNC_SMBUS_READ_BLOCK_DATA.
>>> I hoped all systems using SBS battery support this, but now
>>> I see I2C_FUNC_SMBUS_EMUL only supports writing block data.
>>> Looks like I need to add another patch implementing that
>>> using the old code with added PEC support.
>>>
>>> In any case that should only return -ENODEV for the property
>>> (and uevent), but not break boot. So something fishy is going
>>> on.
>>>
>>>> However reverting it in linux-next doesn't fix the issue, so the
>>>> next commits are also relevant to this issue.
>>> The next patch, which adds PEC support depends on the simplification
>>> of sbs_read_string_data. The old, open coded variant will result in
>>> PEC failure for string properties (which should not stop boot either
>>> of course). Can you try reverting both?
>> Indeed, reverting both (and fixing the conflict) restores proper boot.
> Ok, I pushed out a revert of those two patches. They should land in
> tomorrows linux-next release. Please test it.


Today's linux-next (20200603) boots fine on the Samsung Exynos-based 
Chromebooks. Let me know how if you need any help debugging the issues 
to resurrect those patches.


>>> If that helps I will revert those two instead of dropping the whole
>>> series for this merge window.
>>>
>>>> Let me know how can I help debugging it.
>>> I suspect, that this is userspace endlessly retrying reading the
>>> battery uevent when an error is returned. Could you check this?
>>> Should be easy to see by adding some printfs.
>> I've added some debug messages in sbs_get_property() and it read the
>> same properties many times. However I've noticed that if I wait long
>> enough booting finally continues.
> So basically userspace slows down itself massively by trying to
> re-read uevent over and over when an error occurs. Does not seem
> like a sensible thing to do. I will have a look at this when I find
> some time.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

