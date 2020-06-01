Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1701EA206
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFAKkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 06:40:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51405 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 06:40:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601104028euoutp02aad44531638b19e717ff9f934e968a2c~UZV9vPx7u1460114601euoutp021
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 10:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601104028euoutp02aad44531638b19e717ff9f934e968a2c~UZV9vPx7u1460114601euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591008028;
        bh=/Gdbip4R8JUAfQa6cujlq0e0Q4h2fBOUhAoNV4LwAeo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VqZYir9kppvdPXw6Bbip7iz3RaeY/1E9izZyW1Mt7WUOnEmQd0XkDyCFXB1iSZsv3
         VYsvblNFL7er/ORRMEn+5jhtosAixDAm1eE2DIV5jGEMC09BhgtFQ8MJUNRvRa1AsY
         tsedVhOblA2VPkIB5/hKOYM/josL9F37NM3XmiMc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601104028eucas1p18a9b6c867e9c4cb90d5a9a9ad0212728~UZV9f-sJg2526625266eucas1p13;
        Mon,  1 Jun 2020 10:40:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.93.60698.C1BD4DE5; Mon,  1
        Jun 2020 11:40:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601104027eucas1p2b076ee860520d709e8178c41550653f7~UZV8wqHUV1744917449eucas1p2J;
        Mon,  1 Jun 2020 10:40:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601104027eusmtrp2b227ba4119a30344c41228ead9a83b91~UZV8v9bf90787807878eusmtrp2b;
        Mon,  1 Jun 2020 10:40:27 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-82-5ed4db1c01cf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.7A.08375.B1BD4DE5; Mon,  1
        Jun 2020 11:40:27 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601104027eusmtip1adaa625ff84700328004b3295bca4bce~UZV8NBDXU0602606026eusmtip1Y;
        Mon,  1 Jun 2020 10:40:27 +0000 (GMT)
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <15933a91-dd89-1f94-c2f2-79be4395f4c1@samsung.com>
Date:   Mon, 1 Jun 2020 12:40:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7oyt6/EGbz7rGIx/8g5VovmxevZ
        LDaf62G1uLxrDpvF594jjBYzzu9jspj7ZSqzReveI+wWd1/7WZzeXeLA5bHj7hJGj02rOtk8
        9s9dw+7xeZNcAEsUl01Kak5mWWqRvl0CV8a3D1OYChqkKp5MPsPUwHhQrIuRk0NCwETi/cMr
        7F2MXBxCAisYJdYdvcwI4XxhlDh94j5U5jOjxJp3SxhhWj62XmeCSCxnlHj77ycrhPOeUWLl
        t/1sIFXCAhYSXxb9BmsXEbjDKHHnzCtWkASzwEpGiS/9ISA2m4ChRNfbLrAGXgE7iUW/T4LV
        sAioSPw9vBJsnahArETP/VfMEDWCEidnPmEBsTkF3CSmTX3ICDFTXqJ562xmCFtc4taT+WDn
        SQgcYpeYvvA0K8TdLhJXjtyAsoUlXh3fwg5hy0j83wnT0Mwo8fDcWnYIp4dR4nLTDKivrSXu
        nPsFdCoH0ApNifW79CHCjhITD+9mBglLCPBJ3HgrCHEEn8SkbdOhwrwSHW1CENVqErOOr4Nb
        e/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiB
        ien0v+NfdzDu+5N0iFGAg1GJh1fj0uU4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccX
        leakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAKHNzQU379HBWB1WDm3vkF6bc
        XpRxN5Zt7ad56X8io281v8k40dD58ZCO4wUZt+7c6vUbNvLeqJYukYuaL3behWHC9xdFlqFe
        5n/jpXuMQ3M3qf+McaiyZVdPimQ59iqbvff14szH/nLPFCY+E8px8F6ekjN/4Z8/eg+cn0+y
        PCS/gEtAO1JMiaU4I9FQi7moOBEA1jBJh0gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7rSt6/EGbzbamwx/8g5VovmxevZ
        LDaf62G1uLxrDpvF594jjBYzzu9jspj7ZSqzReveI+wWd1/7WZzeXeLA5bHj7hJGj02rOtk8
        9s9dw+7xeZNcAEuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsa3D1OYChqkKp5MPsPUwHhQrIuRk0NCwETiY+t1JhBbSGApo8SrM6EQcRmJk9Ma
        WCFsYYk/17rYuhi5gGreMkqceLGDESQhLGAh8WXRb3aQhIjAPUaJxVca2UESzAIrGSWO7Qvq
        YuQA6nCVWLI2CCTMJmAo0fUWZBAnB6+AncSi3yfBFrAIqEj8PbwSbKaoQKxE9+If7BA1ghIn
        Zz5hAbE5Bdwkpk19yAgx3kxi3uaHzBC2vETz1tlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQs
        YGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERiD24793LyD8dLG4EOMAhyMSjy8F85fjhNi
        TSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucD00NeSbyhqaG5
        haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG3zizWy8y5my6oz9LIp/n4TPX
        r8o/qqcymCh/Xf8iof4m97m+4y777CM23ti2yXHio8YCbhHrAyWFPEvuG007Hpf/5siqZ8pJ
        fk9f/57y8r3R6ZDr27nyXe6c4jLjkbK4yZxr9qyf4c6a450HZVd+C1t+Z55ymkekcuquyQ9y
        7UKDzsTJGug4KbEUZyQaajEXFScCAFjiS2TXAgAA
X-CMS-MailID: 20200601104027eucas1p2b076ee860520d709e8178c41550653f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601104027eucas1p2b076ee860520d709e8178c41550653f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601104027eucas1p2b076ee860520d709e8178c41550653f7
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
        <CGME20200601104027eucas1p2b076ee860520d709e8178c41550653f7@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 13.05.2020 20:55, Sebastian Reichel wrote:
> This patchset improves support for SBS compliant batteries. Due to
> the changes, the battery now exposes 32 power supply properties and
> (un)plugging it generates a backtrace containing the following message
> without the first patch in this series:
>
> ---------------------------
> WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4/0x104
> add_uevent_var: too many keys
> ---------------------------
>
> For references this is what an SBS battery status looks like after
> the patch series has been applied:
>
> cat /sys/class/power_supply/sbs-0-000b/uevent
> POWER_SUPPLY_NAME=sbs-0-000b
> POWER_SUPPLY_TYPE=Battery
> POWER_SUPPLY_STATUS=Discharging
> POWER_SUPPLY_CAPACITY_LEVEL=Normal
> POWER_SUPPLY_HEALTH=Good
> POWER_SUPPLY_PRESENT=1
> POWER_SUPPLY_TECHNOLOGY=Li-ion
> POWER_SUPPLY_CYCLE_COUNT=12
> POWER_SUPPLY_VOLTAGE_NOW=11441000
> POWER_SUPPLY_CURRENT_NOW=-26000
> POWER_SUPPLY_CURRENT_AVG=-24000
> POWER_SUPPLY_CAPACITY=76
> POWER_SUPPLY_CAPACITY_ERROR_MARGIN=1
> POWER_SUPPLY_TEMP=198
> POWER_SUPPLY_TIME_TO_EMPTY_AVG=438600
> POWER_SUPPLY_TIME_TO_FULL_AVG=3932100
> POWER_SUPPLY_SERIAL_NUMBER=0000
> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=10800000
> POWER_SUPPLY_VOLTAGE_MAX_DESIGN=10800000
> POWER_SUPPLY_ENERGY_NOW=31090000
> POWER_SUPPLY_ENERGY_FULL=42450000
> POWER_SUPPLY_ENERGY_FULL_DESIGN=41040000
> POWER_SUPPLY_CHARGE_NOW=2924000
> POWER_SUPPLY_CHARGE_FULL=3898000
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3800000
> POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3000000
> POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=12300000
> POWER_SUPPLY_MANUFACTURE_YEAR=2017
> POWER_SUPPLY_MANUFACTURE_MONTH=7
> POWER_SUPPLY_MANUFACTURE_DAY=3
> POWER_SUPPLY_MANUFACTURER=UR18650A
> POWER_SUPPLY_MODEL_NAME=GEHC

This patch landed in linux-next dated 20200529. Sadly it causes a 
regression on Samsung Exynos-based Chromebooks (Exynos5250 Snow, 
Exynos5420 Peach-Pi and Exynos5800 Peach-Pit). System boots to 
userspace, but then, when udev populates /dev, booting hangs:

[    4.435167] VFS: Mounted root (ext4 filesystem) readonly on device 
179:51.
[    4.457477] devtmpfs: mounted
[    4.460235] Freeing unused kernel memory: 1024K
[    4.464022] Run /sbin/init as init process
INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.
[    5.102096] random: crng init done
[....] Starting the hotplug events dispatcher: systemd-udevdstarting 
version 236
[ ok .
[....] Synthesizing the initial hotplug events...[ ok done.
[....] Waiting for /dev to be fully populated...[   34.409914] 
TPS65090_RAILSDCDC1: disabling
[   34.412977] TPS65090_RAILSDCDC2: disabling
[   34.417021] TPS65090_RAILSDCDC3: disabling
[   34.423848] TPS65090_RAILSLDO1: disabling
[   34.429068] TPS65090_RAILSLDO2: disabling

Bisect between v5.7-rc1 and next-20200529 pointed me to the first bad 
commit: [c4b12a2f3f3de670f6be5e96092a2cab0b877f1a] power: supply: 
sbs-battery: simplify read_read_string_data. However reverting it in 
linux-next doesn't fix the issue, so the next commits are also relevant 
to this issue.

Let me know how can I help debugging it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

