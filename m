Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A410F146BE8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAWOxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 09:53:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44744 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAWOxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 09:53:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200123145331euoutp0274cdc26083b6ee9ddd4f43f2ea9028aa~si7yxf7bC1717817178euoutp023
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200123145331euoutp0274cdc26083b6ee9ddd4f43f2ea9028aa~si7yxf7bC1717817178euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579791211;
        bh=P6FG+f6HuuA00XGzamn8AIRt26JDmC1Q+1ir7vYLc14=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LX1cJC27aLt7liueuXmAbvo/9CFDMmDKFAemkOi6vCE3frK8czoZ0pPnndckGEQb6
         jyjhDWPPwK3RYeNyZ6WbyZLqReHpoBP7eosOIDnqbQbwrX9YVjLM1gh/dnlN8v1Ux4
         PXxrXAXS1Ce9DWL2b7FKaXrIYYA8OSr2FZSWLg5A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200123145331eucas1p2c663ff38877a0b0eed7f00b5840af2db~si7yEJLff1422014220eucas1p2a;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.7B.61286.A63B92E5; Thu, 23
        Jan 2020 14:53:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200123145330eucas1p1a03da39c2381d02188a8354659a09480~si7xnIZfo2150721507eucas1p1q;
        Thu, 23 Jan 2020 14:53:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200123145330eusmtrp1985d7b664672899ac85ecac803a5dfec~si7xmXVcV2757127571eusmtrp1R;
        Thu, 23 Jan 2020 14:53:30 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-1c-5e29b36ab56e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.93.08375.A63B92E5; Thu, 23
        Jan 2020 14:53:30 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145329eusmtip27c273e130243c0aad00f6b5f7fa90078~si7w2yRlg1819418194eusmtip2f;
        Thu, 23 Jan 2020 14:53:29 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 0/3] PM / devfreq: change load calc in Exynos5422
Date:   Thu, 23 Jan 2020 15:53:10 +0100
Message-Id: <20200123145313.27539-1-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7rZmzXjDDbdZLLYOGM9q8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JYe+Quu8XtxhVsDtwem1Z1
        snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxr/uOYwF7ReZKj50NbE2MF5tZepi5OSQEDCR
        WL7iGZDNxSEksIJRYt22nYwQzhdGie/X1kE5nxkltmw6xN7FyAHWcvZLPUR8OaPE9V2PmeA6
        3s6ZAjaXTUBf4uDZkywgtoiAtETnoolgcWaBLmaJ819NQWxhAUeJE01tYDUsAqoSr7/uZAWx
        eQVsJF63X2CFuE9eYnbjaTaIuKDEyZlPWCDmyEs0b53NDLJYQqCdXeLgr62MEA0uEmfbzrJD
        2MISr45vgbJlJE5P7mGBsMslni7sY4dobmGUeND+ESphLXHn3C82kDeZBTQl1u/Shwg7Smxf
        tZMZ4ns+iRtvBSFu4JOYtG06VJhXoqNNCKJaVeL5qR5o8EpLdP1fB/WKh8S/Ha/ArhQSiJX4
        vGgf4wRGhVlIPpuF5LNZCDcsYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZiCTv87
        /mkH49dLSYcYBTgYlXh4JXo144RYE8uKK3MPMUpwMCuJ8DKGAYV4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpgrHk9XdCw/mChTtAz5xnWb25Zr12pMl2I
        9/3iBEeVdxe0O/c26DDFTDaa5mtxt4+Vx0NH5PFd/+sMN0oi/j84PPcf16a4XaeZ7odfFD4U
        8klJINdgSmPV3KiWFA1th5Q0sd+7tHy8qhxTzxd5fNrmede+61VVWjm/Zp1MxZm90XLRqRNl
        1D8rsRRnJBpqMRcVJwIAI7xKlT0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Pd2szZpxBruaZS02zljPanH9y3NW
        iwWfZrBa9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB59W1YxenzeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Ka
        k1mWWqRvl6CX8a97DmNB+0Wmig9dTawNjFdbmboYOTgkBEwkzn6p72Lk4hASWMoosW7xKdYu
        Rk6guLRE4+nVTBC2sMSfa11sILaQwCdGiXN7o0BsNgF9iYNnT7KA2CJA9Z2LJjKBDGIWmMQs
        sefFM7AGYQFHiRNNbWBFLAKqEq+/7gRbwCtgI/G6/QLUMnmJ2Y2n2SDighInZz4Bq2cGijdv
        nc08gZFvFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJDf9uxn5t3MF7aGHyI
        UYCDUYmHV6JXM06INbGsuDL3EKMEB7OSCC9jGFCINyWxsiq1KD++qDQntfgQoynQsROZpUST
        84FxmVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbH+00HfuRNP
        Xd++X2+Wk0CM8zlGiVen/Q4E5Ruu5n3w/VTFdOXse7V3jH9+bfj56J5teUrZLk2dirqgZ0+v
        vj31gXvG/r+HPJ+K2l4008o2XpzwVrbmY8CjmTc+Lth9q+rqY6P+n6sXu+2oXPt4hc1Nxp33
        LhlP+6fw6OTdv+KTfMrvxDlNK3I5osRSnJFoqMVcVJwIAD2tWxmTAgAA
X-CMS-MailID: 20200123145330eucas1p1a03da39c2381d02188a8354659a09480
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200123145330eucas1p1a03da39c2381d02188a8354659a09480
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200123145330eucas1p1a03da39c2381d02188a8354659a09480
References: <CGME20200123145330eucas1p1a03da39c2381d02188a8354659a09480@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two problems with exynos-nocp driver. First one is reading
bytes and cycle counters and comparing them one to one without taking
into account wcore bus width. Second one is that cycle counter depends
on DREX DRAM clock, not on wcore clock. The latter problem was exposed
by commit 6e7674c3c6df5 ("memory: Add DMC driver for Exynos5422"),
which changes DRAM clock depending on memory read/write pressure and when
it gets at higher freqency, NoCP cycle counter also increases. Note that
both of these problems was there before this commit.
The proposed solution is to use byte counter from NoCP h/w registers
for current wcore bandwidth calculations and derive max bandwidth from
current frequency. While at it, change from bytes to kilobytes to avoid
overflow in later calculations in exynos-bus and devfreq drivers.

---
All tests were run on Odroid XU3 with Exynos 5422 SoC. FullHD monitor was
connected. Three programs were used for tests: stream for memory stress
(no wcore activity), dd with eMMC read and modetest (both dd and modetest
generate data transfers through wcore). First test was performed on idle
system without running any mentioned programs. In all tests there was
applied "PM / devfreq: add possibility for delayed work", so data from
dev_dbg are printed at regular intervals ~60ms.

Below is first test without current patchset with idle system. Change of
governor from powersave to performance makes wcore frequency change from
88MHz to 532MHz but cycle counter keeps at 4,9*10^6. Additionally,
byte/cycle ratio also keeps around 310% (15285144 * 100 / 4915741).

# mkdir /mnt/debug
# mount -tdebugfs debug /mnt/debug/
# echo -n 'file exynos-nocp.c +p' > /mnt/debug/dynamic_debug/control

root@target:~/devfreq# uname -a
Linux target 5.5.0-rc5-next-20200113-00004-g1374a52f3252 #89 SMP PREEMPT Wed Jan 22 15:14:17 CET 2020 armx
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/available_governors
userspace powersave performance simple_ondemand
root@target:~/devfreq# echo powersave > /sys/class/devfreq/devfreq2/governor
root@target:~/devfreq# sleep 1
root@target:~/devfreq# dmesg|tail
[  537.340710] devfreq-event event2: nocp@10ca1800 (event: 15110160/4980473)
[  537.340749] devfreq-event event3: nocp@10ca1c00 (event: 0/4910429)
[  537.400676] devfreq-event event0: nocp@10ca1000 (event: 15386976/4936165)
[  537.400731] devfreq-event event1: nocp@10ca1400 (event: 0/4934961)
[  537.400783] devfreq-event event2: nocp@10ca1800 (event: 15167708/4933305)
[  537.400834] devfreq-event event3: nocp@10ca1c00 (event: 0/4931505)
[  537.460635] devfreq-event event0: nocp@10ca1000 (event: 15523208/4924365)
[  537.460678] devfreq-event event1: nocp@10ca1400 (event: 0/4920169)
[  537.460717] devfreq-event event2: nocp@10ca1800 (event: 15285144/4915741)
[  537.460755] devfreq-event event3: nocp@10ca1c00 (event: 0/4911197)
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
*  88700000:         0         0         0         0         1     77030
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
  532000000:         1         0         0         0         0    513100
Total transition : 2

root@target:~/devfreq# echo performance > /sys/class/devfreq/devfreq2/governor
root@target:~/devfreq# sleep 1
root@target:~/devfreq# dmesg|tail
[  537.340710] devfreq-event event2: nocp@10ca1800 (event: 15110160/4980473)
[  537.340749] devfreq-event event3: nocp@10ca1c00 (event: 0/4910429)
[  537.400676] devfreq-event event0: nocp@10ca1000 (event: 15386976/4936165)
[  537.400731] devfreq-event event1: nocp@10ca1400 (event: 0/4934961)
[  537.400783] devfreq-event event2: nocp@10ca1800 (event: 15167708/4933305)
[  537.400834] devfreq-event event3: nocp@10ca1c00 (event: 0/4931505)
[  537.460635] devfreq-event event0: nocp@10ca1000 (event: 15523208/4924365)
[  537.460678] devfreq-event event1: nocp@10ca1400 (event: 0/4920169)
[  537.460717] devfreq-event event2: nocp@10ca1800 (event: 15285144/4915741)
[  537.460755] devfreq-event event3: nocp@10ca1c00 (event: 0/4911197)
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat 
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         2    398100
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
* 532000000:         1         0         0         0         0    524440
Total transition : 3

---
Below are logs from memory stress stream running on linux next-20200113
and applied patchset "PM / devfreq: add possibility for delayed work"
with config option DEVFREQ_DELAYED_TIMER set on but without current
patchset.

After end of stream program, cycle counter drops gradually from 24*10^6
to 22*10^6, 18*10^6, 16*10^6, 12*10^6, 8*10^6. These corresponds to DRAM
frequences, while bytes counts stays around 15*10^6, with debug prints in
60ms periods. Wcore frequency keeps at 532MHz. It shows that NoCP cycle
counters counts DREX cycles.

root@target:~# cat /sys/class/devfreq/devfreq0/name
10c20000.memory-controller
root@target:~# cat /sys/class/devfreq/devfreq0/available_frequencies
165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000

root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/name
soc:bus_wcore
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19600
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
* 532000000:         0         0         0         0         0    276830
Total transition : 1

[3]+  Done      ../stream_gnueabi
root@target:~/devfreq# dmesg|tail
[  408.795693] devfreq-event event2: nocp@10ca1800 (event: 15439456/24502701)
[  408.795756] devfreq-event event3: nocp@10ca1c00 (event: 0/24462297)
[  408.855906] devfreq-event event0: nocp@10ca1000 (event: 15676712/24742161)
[  408.856058] devfreq-event event1: nocp@10ca1400 (event: 0/24779693)
[  408.856200] devfreq-event event2: nocp@10ca1800 (event: 15412224/24806561)
[  408.856339] devfreq-event event3: nocp@10ca1c00 (event: 0/24832709)
[  408.915511] devfreq-event event0: nocp@10ca1000 (event: 15529520/24311941)
[  408.915543] devfreq-event event1: nocp@10ca1400 (event: 0/24313465)
[  408.915572] devfreq-event event2: nocp@10ca1800 (event: 15126880/24182937)
[  408.915602] devfreq-event event3: nocp@10ca1c00 (event: 0/24182621)
root@target:~/devfreq# dmesg|tail
[  409.465639] devfreq-event event2: nocp@10ca1800 (event: 15399964/22002313)
[  409.465690] devfreq-event event3: nocp@10ca1c00 (event: 0/21989117)
[  409.525424] devfreq-event event0: nocp@10ca1000 (event: 15671172/18876933)
[  409.525451] devfreq-event event1: nocp@10ca1400 (event: 0/18863021)
[  409.525476] devfreq-event event2: nocp@10ca1800 (event: 15389640/18848269)
[  409.525501] devfreq-event event3: nocp@10ca1c00 (event: 0/18833213)
[  409.585407] devfreq-event event0: nocp@10ca1000 (event: 15615780/18943765)
[  409.585430] devfreq-event event1: nocp@10ca1400 (event: 0/18939237)
[  409.585451] devfreq-event event2: nocp@10ca1800 (event: 15311112/18933717)
[  409.585473] devfreq-event event3: nocp@10ca1c00 (event: 0/18928025)
root@target:~/devfreq# dmesg|tail
[  410.195489] devfreq-event event2: nocp@10ca1800 (event: 15456592/18901525)
[  410.195513] devfreq-event event3: nocp@10ca1c00 (event: 0/18890417)
[  410.255525] devfreq-event event0: nocp@10ca1000 (event: 15641556/18975417)
[  410.255571] devfreq-event event1: nocp@10ca1400 (event: 0/18979225)
[  410.255616] devfreq-event event2: nocp@10ca1800 (event: 15350596/18981701)
[  410.255659] devfreq-event event3: nocp@10ca1c00 (event: 0/18983885)
[  410.315492] devfreq-event event0: nocp@10ca1000 (event: 15722964/18910573)
[  410.315523] devfreq-event event1: nocp@10ca1400 (event: 0/18900445)
[  410.315552] devfreq-event event2: nocp@10ca1800 (event: 15392616/18888593)
[  410.315582] devfreq-event event3: nocp@10ca1c00 (event: 0/18877473)
root@target:~/devfreq# dmesg|tail
[  410.915913] devfreq-event event2: nocp@10ca1800 (event: 15284056/16183805)
[  410.916053] devfreq-event event3: nocp@10ca1c00 (event: 0/16191953)
[  410.975616] devfreq-event event0: nocp@10ca1000 (event: 15643540/16119365)
[  410.975678] devfreq-event event1: nocp@10ca1400 (event: 0/16092877)
[  410.975731] devfreq-event event2: nocp@10ca1800 (event: 15310112/16070749)
[  410.975818] devfreq-event event3: nocp@10ca1c00 (event: 0/16058261)
[  411.035711] devfreq-event event0: nocp@10ca1000 (event: 15568372/16212845)
[  411.035736] devfreq-event event1: nocp@10ca1400 (event: 0/16170909)
[  411.035759] devfreq-event event2: nocp@10ca1800 (event: 15207864/16139825)
[  411.035781] devfreq-event event3: nocp@10ca1c00 (event: 0/16100285)
root@target:~/devfreq# dmesg|tail
[  411.695736] devfreq-event event2: nocp@10ca1800 (event: 15307112/12243577)
[  411.695799] devfreq-event event3: nocp@10ca1c00 (event: 0/12215505)
[  411.755546] devfreq-event event0: nocp@10ca1000 (event: 15492580/12310437)
[  411.755594] devfreq-event event1: nocp@10ca1400 (event: 0/12302877)
[  411.755628] devfreq-event event2: nocp@10ca1800 (event: 15195176/12290805)
[  411.755662] devfreq-event event3: nocp@10ca1c00 (event: 0/12277981)
[  411.815659] devfreq-event event0: nocp@10ca1000 (event: 15663508/12364637)
[  411.815742] devfreq-event event1: nocp@10ca1400 (event: 0/12372049)
[  411.815819] devfreq-event event2: nocp@10ca1800 (event: 15363208/12377025)
[  411.815895] devfreq-event event3: nocp@10ca1c00 (event: 0/12382285)
root@target:~/devfreq# dmesg|tail
[  412.475472] devfreq-event event2: nocp@10ca1800 (event: 15336068/8174697)
[  412.475500] devfreq-event event3: nocp@10ca1c00 (event: 0/8166397)
[  412.535552] devfreq-event event0: nocp@10ca1000 (event: 15559072/8245049)
[  412.535606] devfreq-event event1: nocp@10ca1400 (event: 0/8246885)
[  412.535644] devfreq-event event2: nocp@10ca1800 (event: 15300092/8245173)
[  412.535682] devfreq-event event3: nocp@10ca1c00 (event: 0/8243145)
[  412.595670] devfreq-event event0: nocp@10ca1000 (event: 15707976/8233633)
[  412.595757] devfreq-event event1: nocp@10ca1400 (event: 0/8238765)
[  412.595836] devfreq-event event2: nocp@10ca1800 (event: 15463796/8241561)
[  412.595916] devfreq-event event3: nocp@10ca1c00 (event: 0/8244441)
root@target:~/devfreq#

---
Logs from dd program without patchset:

root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19600
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
* 532000000:         0         0         0         0         0    636660
Total transition : 1

uname -a
Linux target 5.5.0-rc5-next-20200113-00004-g1374a52f3252 #89 SMP PREEMPT Wed Jan 22 15:14:17 CET 2020 armv7l GNU/Linux
root@target:~# cat /sys/class/devfreq/devfreq0/available_frequencies
165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000
root@target:~# cat /sys/class/devfreq/devfreq0/governor
simple_ondemand
root@target:~# cat /sys/class/devfreq/devfreq0/name
10c20000.memory-controller
root@target:~# cat /sys/class/devfreq/devfreq2/name
soc:bus_wcore
root@target:~# cat /sys/class/devfreq/devfreq2/governor
simple_ondemand
root@target:~# cat /sys/class/devfreq/devfreq2/available_governors
userspace powersave performance simple_ondemand
root@target:~# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     21890
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
* 532000000:         0         0         0         0         0    148180
Total transition : 1
root@target:~# dd if=/dev/mmcblk0p5 of=/dev/null &
root@target:~/devfreq# dmesg|tail
[  203.960365] devfreq-event event2: nocp@10ca1800 (event: 16527152/4949925)
[  203.960404] devfreq-event event3: nocp@10ca1c00 (event: 0/4947305)
[  204.020027] devfreq-event event0: nocp@10ca1000 (event: 16682948/4909245)
[  204.020082] devfreq-event event1: nocp@10ca1400 (event: 0/4910441)
[  204.020228] devfreq-event event2: nocp@10ca1800 (event: 16489972/4916613)
[  204.020272] devfreq-event event3: nocp@10ca1c00 (event: 0/4914745)
[  204.080072] devfreq-event event0: nocp@10ca1000 (event: 16478288/4924185)
[  204.080132] devfreq-event event1: nocp@10ca1400 (event: 0/4925193)
[  204.080182] devfreq-event event2: nocp@10ca1800 (event: 16264096/4923477)
[  204.080230] devfreq-event event3: nocp@10ca1c00 (event: 0/4921769)
root@target:~/devfreq# dmesg|tail
[  246.059861] devfreq-event event2: nocp@10ca1800 (event: 20070832/28829017)
[  246.059881] devfreq-event event3: nocp@10ca1c00 (event: 0/28824933)
[  246.129815] devfreq-event event0: nocp@10ca1000 (event: 20427304/28827105)
[  246.129841] devfreq-event event1: nocp@10ca1400 (event: 0/28829773)
[  246.129861] devfreq-event event2: nocp@10ca1800 (event: 20069316/28826285)
[  246.129883] devfreq-event event3: nocp@10ca1c00 (event: 0/28822925)
[  246.189805] devfreq-event event0: nocp@10ca1000 (event: 17431936/24698601)
[  246.189827] devfreq-event event1: nocp@10ca1400 (event: 0/24698561)
[  246.189847] devfreq-event event2: nocp@10ca1800 (event: 17122664/24694697)
[  246.189866] devfreq-event event3: nocp@10ca1c00 (event: 0/24690477)
root@target:~/devfreq# dmesg|tail
[  305.689792] devfreq-event event2: nocp@10ca1800 (event: 19897292/28827045)
[  305.689811] devfreq-event event3: nocp@10ca1c00 (event: 0/28823497)
[  305.759748] devfreq-event event0: nocp@10ca1000 (event: 20428188/28829305)
[  305.759772] devfreq-event event1: nocp@10ca1400 (event: 0/28829941)
[  305.759792] devfreq-event event2: nocp@10ca1800 (event: 20069112/28826421)
[  305.759811] devfreq-event event3: nocp@10ca1c00 (event: 0/28822505)
[  305.829759] devfreq-event event0: nocp@10ca1000 (event: 20431388/28833721)
[  305.829784] devfreq-event event1: nocp@10ca1400 (event: 0/28835077)
[  305.829805] devfreq-event event2: nocp@10ca1800 (event: 20072332/28831797)
[  305.829826] devfreq-event event3: nocp@10ca1c00 (event: 0/28828669)
root@target:~/devfreq# 22501344+0 records in
22501344+0 records out
11520688128 bytes (12 GB, 11 GiB) copied, 202.816 s, 56.8 MB/s

[1]+  Done                    dd if=/dev/mmcblk0p5 of=/dev/null  (wd: ~)
(wd now: ~/devfreq)
root@target:~/devfreq# dmesg|tail
[  706.099607] devfreq-event event2: nocp@10ca1800 (event: 15308600/4922945)
[  706.099639] devfreq-event event3: nocp@10ca1c00 (event: 0/4919705)
[  706.159726] devfreq-event event0: nocp@10ca1000 (event: 15430964/4950105)
[  706.159782] devfreq-event event1: nocp@10ca1400 (event: 0/4949257)
[  706.159825] devfreq-event event2: nocp@10ca1800 (event: 15213116/4947661)
[  706.159878] devfreq-event event3: nocp@10ca1c00 (event: 0/4946217)
[  706.229632] devfreq-event event0: nocp@10ca1000 (event: 18023796/5745053)
[  706.229674] devfreq-event event1: nocp@10ca1400 (event: 0/5741853)
[  706.229714] devfreq-event event2: nocp@10ca1800 (event: 17752680/5737085)
[  706.229753] devfreq-event event3: nocp@10ca1c00 (event: 0/5732637)
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     21890
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
* 532000000:         0         0         0         0         0    682170
Total transition : 1
---
Logs from modetest program without patchset:

root@target:~/devfreq# ../modetest -s 43:1920x1080 -P41:1920x1080 &
[1] 768
root@target:~/devfreq# trying to open device 'i915'...failed
trying to open device 'amdgpu'...failed
trying to open device 'radeon'...failed
trying to open device 'nouveau'...failed
trying to open device 'vmwgfx'...failed
trying to open device 'omapdrm'...failed
trying to open device 'exynos'...done
setting mode 1920x1080-60Hz@XR24 on connectors 43, crtc 41
testing 1920x1080@XR24 overlay plane 36
^C

[1]+  Stopped                 ../modetest -s 43:1920x1080 -P41:1920x1080
root@target:~/devfreq# dmesg|tail
[  820.619367] devfreq-event event2: nocp@10ca1800 (event: 30328644/24548753)
[  820.619409] devfreq-event event3: nocp@10ca1c00 (event: 0/24524329)
[  820.679405] devfreq-event event0: nocp@10ca1000 (event: 30494152/24711057)
[  820.679449] devfreq-event event1: nocp@10ca1400 (event: 0/24771605)
[  820.679616] devfreq-event event2: nocp@10ca1800 (event: 30235156/24749273)
[  820.679673] devfreq-event event3: nocp@10ca1c00 (event: 0/24749361)
[  820.739321] devfreq-event event0: nocp@10ca1000 (event: 30302840/24562317)
[  820.739347] devfreq-event event1: nocp@10ca1400 (event: 0/24538725)
[  820.739375] devfreq-event event2: nocp@10ca1800 (event: 29936448/24513753)
[  820.739399] devfreq-event event3: nocp@10ca1c00 (event: 0/24490281)
root@target:~/devfreq# dmesg|tail
[  839.159763] devfreq-event event2: nocp@10ca1800 (event: 30353968/24842849)
[  839.159823] devfreq-event event3: nocp@10ca1c00 (event: 0/24865157)
[  839.219307] devfreq-event event0: nocp@10ca1000 (event: 30557856/24492825)
[  839.219339] devfreq-event event1: nocp@10ca1400 (event: 0/24471425)
[  839.219369] devfreq-event event2: nocp@10ca1800 (event: 30199176/24448969)
[  839.219398] devfreq-event event3: nocp@10ca1c00 (event: 0/24426201)
[  839.279298] devfreq-event event0: nocp@10ca1000 (event: 30428216/24658369)
[  839.279328] devfreq-event event1: nocp@10ca1400 (event: 0/24653145)
[  839.279356] devfreq-event event2: nocp@10ca1800 (event: 30068856/24616381)
[  839.279383] devfreq-event event3: nocp@10ca1c00 (event: 0/24592713)
root@target:~/devfreq# fg %1
../modetest -s 43:1920x1080 -P41:1920x1080

root@target:~/devfreq# dmesg|tail
[  849.109306] devfreq-event event2: nocp@10ca1800 (event: 15005132/18570965)
[  849.109334] devfreq-event event3: nocp@10ca1c00 (event: 0/18536625)
[  849.169188] devfreq-event event0: nocp@10ca1000 (event: 15774388/18925857)
[  849.169211] devfreq-event event1: nocp@10ca1400 (event: 0/18919609)
[  849.169232] devfreq-event event2: nocp@10ca1800 (event: 15467076/18912721)
[  849.169253] devfreq-event event3: nocp@10ca1c00 (event: 0/18905821)
[  849.229241] devfreq-event event0: nocp@10ca1000 (event: 15638480/18969689)
[  849.229278] devfreq-event event1: nocp@10ca1400 (event: 0/18971713)
[  849.229310] devfreq-event event2: nocp@10ca1800 (event: 15342996/18971197)
[  849.229343] devfreq-event event3: nocp@10ca1c00 (event: 0/18971037)
root@target:~/devfreq# dmesg|tail
[  852.689344] devfreq-event event2: nocp@10ca1800 (event: 15166292/6141665)
[  852.689386] devfreq-event event3: nocp@10ca1c00 (event: 0/6139661)
[  852.749342] devfreq-event event0: nocp@10ca1000 (event: 15636760/6165141)
[  852.749401] devfreq-event event1: nocp@10ca1400 (event: 0/6164021)
[  852.749458] devfreq-event event2: nocp@10ca1800 (event: 15390668/6162173)
[  852.749510] devfreq-event event3: nocp@10ca1c00 (event: 0/6225561)
[  852.809320] devfreq-event event0: nocp@10ca1000 (event: 15417248/6147685)
[  852.809396] devfreq-event event1: nocp@10ca1400 (event: 0/6146713)
[  852.809467] devfreq-event event2: nocp@10ca1800 (event: 15171716/6144453)
[  852.809538] devfreq-event event3: nocp@10ca1c00 (event: 0/6141765)
root@target:~/devfreq# dmesg|tail
[  856.079392] devfreq-event event2: nocp@10ca1800 (event: 14908768/4852089)
[  856.079437] devfreq-event event3: nocp@10ca1c00 (event: 0/4845833)
[  856.139479] devfreq-event event0: nocp@10ca1000 (event: 15412824/4944089)
[  856.139547] devfreq-event event1: nocp@10ca1400 (event: 0/4943049)
[  856.139620] devfreq-event event2: nocp@10ca1800 (event: 15193496/4941817)
[  856.139694] devfreq-event event3: nocp@10ca1c00 (event: 0/4940997)
[  856.199282] devfreq-event event0: nocp@10ca1000 (event: 15449800/4903065)
[  856.199329] devfreq-event event1: nocp@10ca1400 (event: 0/4896677)
[  856.199372] devfreq-event event2: nocp@10ca1800 (event: 15199216/4889889)
[  856.199408] devfreq-event event3: nocp@10ca1c00 (event: 0/4883005)
root@target:~/devfreq# dmesg|tail
[  860.859354] devfreq-event event2: nocp@10ca1800 (event: 15083684/4906997)
[  860.859397] devfreq-event event3: nocp@10ca1c00 (event: 0/4901577)
[  860.919310] devfreq-event event0: nocp@10ca1000 (event: 15551720/4933873)
[  860.919380] devfreq-event event1: nocp@10ca1400 (event: 0/4933309)
[  860.919447] devfreq-event event2: nocp@10ca1800 (event: 15336016/4932153)
[  860.919513] devfreq-event event3: nocp@10ca1c00 (event: 0/4930965)
[  860.979224] devfreq-event event0: nocp@10ca1000 (event: 15315932/4914741)
[  860.979272] devfreq-event event1: nocp@10ca1400 (event: 0/4907993)
[  860.979317] devfreq-event event2: nocp@10ca1800 (event: 15063744/4901321)
[  860.979360] devfreq-event event3: nocp@10ca1c00 (event: 0/4894661)
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     21890
  133000000:         0         0         0         0         0         0
  177400000:         0         0         0         0         0         0
  266000000:         0         0         0         0         0         0
* 532000000:         0         0         0         0         0    873990
Total transition : 1

---
Logs after applied both "PM / devfreq: add possibility for delayed work"
and current patchset, tested with three programs: (a) stream, (b) dd from
eMMC memory and (c) modetest.

(a) stream test (no wcore freq change):

root@target:~/devfreq# . nocp_debug 
exit code: 0
root@target:~/devfreq# dmesg |tail
[  193.344624] devfreq-event event2: nocp@10ca1800 (event: 252318/709600) 60ms 35% 0x00e70110
[  193.344657] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[  193.404790] devfreq-event event0: nocp@10ca1000 (event: 260404/709600) 60ms 36% 0x00ee6854
[  193.404880] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[  193.404956] devfreq-event event2: nocp@10ca1800 (event: 256331/709600) 60ms 36% 0x00eaad94
[  193.405034] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[  193.464521] devfreq-event event0: nocp@10ca1000 (event: 257190/709600) 60ms 36% 0x00eb76f4
[  193.464556] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[  193.464588] devfreq-event event2: nocp@10ca1800 (event: 252946/709600) 60ms 35% 0x00e79468
[  193.464618] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     20430
  133000000:         0         0         0         0         0         0
* 177400000:         0         0         0         0         2    172220
  266000000:         0         0         1         0         0       180
  532000000:         0         0         2         1         0       220
Total transition : 7

root@target:~/devfreq# ../stream_gnueabi &
[1] 733
root@target:~/devfreq# -------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 10000000 (elements), Offset = 0 (elements)
Memory per array = 76.3 MiB (= 0.1 GiB).
Total memory required = 228.9 MiB (= 0.2 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.

-------------------------------------------------------------
Your clock granularity/precision appears to be 5 microseconds.
Each test below will take on the order of 142436 microseconds.
   (= 28487 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------

root@target:~/devfreq# dmesg |tail
[  226.928746] devfreq-event event2: nocp@10ca1800 (event: 257500/709600) 60ms 36% 0x00ebbfc4
[  226.928766] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[  226.998460] devfreq-event event0: nocp@10ca1000 (event: 261658/709600) 70ms 36% 0x01177b24
[  226.998486] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 70ms 0% 0x00000000
[  226.998507] devfreq-event event2: nocp@10ca1800 (event: 256611/709600) 70ms 36% 0x01121734
[  226.998527] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 70ms 0% 0x00000000
[  227.058393] devfreq-event event0: nocp@10ca1000 (event: 260563/709600) 60ms 36% 0x00ee8da4
[  227.058414] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[  227.058433] devfreq-event event2: nocp@10ca1800 (event: 255456/709600) 60ms 36% 0x00e9e0ac
[  227.058450] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
root@target:~/devfreq# Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            4797.5     0.041159     0.033351     0.051780
Scale:            825.3     0.205380     0.193868     0.227955
Add:             1143.5     0.218550     0.209885     0.234103
Triad:            670.2     0.374949     0.358115     0.407750
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------

[1]+  Done                    ../stream_gnueabi
root@target:~/devfreq# dmesg |tail
[  237.444983] devfreq-event event2: nocp@10ca1800 (event: 249059/709600) 60ms 35% 0x00e40568
[  237.445018] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[  237.504918] devfreq-event event0: nocp@10ca1000 (event: 258668/709600) 60ms 36% 0x00ecd184
[  237.504953] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[  237.504994] devfreq-event event2: nocp@10ca1800 (event: 254219/709600) 60ms 35% 0x00e8bec0
[  237.505029] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[  237.564841] devfreq-event event0: nocp@10ca1000 (event: 259859/709600) 60ms 36% 0x00ede874
[  237.564872] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[  237.564898] devfreq-event event2: nocp@10ca1800 (event: 256008/709600) 60ms 36% 0x00ea61f0
[  237.564923] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     20430
  133000000:         0         0         0         0         0         0
* 177400000:         0         0         0         0         2    214770
  266000000:         0         0         1         0         0       180
  532000000:         0         0         2         1         0       220
Total transition : 7

(b) dd test (wcore enters 2nd freq 266MHz):

dmesg |tail
[ 1241.311174] devfreq-event event2: nocp@10ca1800 (event: 252036/709600) 60ms 35% 0x00e6bf08
[ 1241.311206] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1241.371136] devfreq-event event0: nocp@10ca1000 (event: 259618/709600) 60ms 36% 0x00edaff8
[ 1241.371168] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1241.371198] devfreq-event event2: nocp@10ca1800 (event: 255889/709600) 60ms 36% 0x00ea460c
[ 1241.371229] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1241.431204] devfreq-event event0: nocp@10ca1000 (event: 256887/709600) 60ms 36% 0x00eb2fe4
[ 1241.431240] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1241.431275] devfreq-event event2: nocp@10ca1800 (event: 253194/709600) 60ms 35% 0x00e7ce8c
[ 1241.431308] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat 
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
* 177400000:         0         0         0         0         4    997330
  266000000:         0         0         3         0         0    194010
  532000000:         0         1         2         3         0     27930
Total transition : 15
root@target:~/devfreq# dd if=/dev/mmcblk0p5 of=/dev/null &
[1] 788
root@target:~/devfreq# dmesg |tail
[ 1266.461371] devfreq-event event2: nocp@10ca1800 (event: 273550/709600) 60ms 38% 0x00fa7170
[ 1266.461400] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1266.531256] devfreq-event event0: nocp@10ca1000 (event: 278666/709600) 70ms 39% 0x0129a5e8
[ 1266.531303] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 70ms 0% 0x00000000
[ 1266.531339] devfreq-event event2: nocp@10ca1800 (event: 275211/709600) 70ms 38% 0x0125f530
[ 1266.531372] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 70ms 0% 0x00000000
[ 1266.601314] devfreq-event event0: nocp@10ca1000 (event: 274246/709600) 70ms 38% 0x0124ed54
[ 1266.601375] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 70ms 0% 0x00000000
[ 1266.601417] devfreq-event event2: nocp@10ca1800 (event: 270819/709600) 70ms 38% 0x0121444c
[ 1266.601456] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 70ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
  177400000:         0         0         0         0         5   1020500
* 266000000:         0         0         3         0         0    200780
  532000000:         0         1         2         4         0     28000
Total transition : 17
root@target:~/devfreq# dmesg|tail
[ 1297.511213] devfreq-event event2: nocp@10ca1800 (event: 284350/1064000) 60ms 26% 0x010454b0
[ 1297.511228] devfreq-event event3: nocp@10ca1c00 (event: 0/1064000) 60ms 0% 0x00000000
[ 1297.571207] devfreq-event event0: nocp@10ca1000 (event: 292658/1064000) 60ms 27% 0x010befd8
[ 1297.571226] devfreq-event event1: nocp@10ca1400 (event: 0/1064000) 60ms 0% 0x00000000
[ 1297.571242] devfreq-event event2: nocp@10ca1800 (event: 287516/1064000) 60ms 27% 0x01073a94
[ 1297.571258] devfreq-event event3: nocp@10ca1c00 (event: 0/1064000) 60ms 0% 0x00000000
[ 1297.631178] devfreq-event event0: nocp@10ca1000 (event: 288329/1064000) 60ms 27% 0x0107f944
[ 1297.631199] devfreq-event event1: nocp@10ca1400 (event: 0/1064000) 60ms 0% 0x00000000
[ 1297.631221] devfreq-event event2: nocp@10ca1800 (event: 283311/1064000) 60ms 26% 0x01036108
[ 1297.631238] devfreq-event event3: nocp@10ca1c00 (event: 0/1064000) 60ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat 
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
  177400000:         0         0         0         0         5   1020500
* 266000000:         0         0         3         0         0    268040
  532000000:         0         1         2         4         0     28000
Total transition : 17
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat dmesg|tail
[ 1345.621291] devfreq-event event2: nocp@10ca1800 (event: 287629/1064000) 60ms 27% 0x01075520
[ 1345.621307] devfreq-event event3: nocp@10ca1c00 (event: 0/1064000) 60ms 0% 0x00000000
[ 1345.681261] devfreq-event event0: nocp@10ca1000 (event: 289991/1064000) 60ms 27% 0x01097ebc
[ 1345.681281] devfreq-event event1: nocp@10ca1400 (event: 0/1064000) 60ms 0% 0x00000000
[ 1345.681298] devfreq-event event2: nocp@10ca1800 (event: 284773/1064000) 60ms 26% 0x0104b7d8
[ 1345.681315] devfreq-event event3: nocp@10ca1c00 (event: 0/1064000) 60ms 0% 0x00000000
[ 1345.741266] devfreq-event event0: nocp@10ca1000 (event: 290210/1064000) 60ms 27% 0x0109b214
[ 1345.741286] devfreq-event event1: nocp@10ca1400 (event: 0/1064000) 60ms 0% 0x00000000
[ 1345.741305] devfreq-event event2: nocp@10ca1800 (event: 284920/1064000) 60ms 26% 0x0104da28
[ 1345.741323] devfreq-event event3: nocp@10ca1c00 (event: 0/1064000) 60ms 0% 0x00000000
root@target:~/devfreq# 22501344+0 records in
22501344+0 records out
11520688128 bytes (12 GB, 11 GiB) copied, 205.316 s, 56.1 MB/s

[1]+  Done                    dd if=/dev/mmcblk0p5 of=/dev/null
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
* 177400000:         0         0         0         0         5   1025540
  266000000:         0         0         4         0         0    394620
  532000000:         0         1         2         4         0     28000
Total transition : 18
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat dmesg|tail
[ 1474.562026] devfreq-event event2: nocp@10ca1800 (event: 254570/709600) 60ms 35% 0x00e910e8
[ 1474.562140] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1474.631393] devfreq-event event0: nocp@10ca1000 (event: 255645/709600) 70ms 36% 0x01110f0c
[ 1474.631440] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 70ms 0% 0x00000000
[ 1474.631474] devfreq-event event2: nocp@10ca1800 (event: 251797/709600) 70ms 35% 0x010cf2e0
[ 1474.631508] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 70ms 0% 0x00000000
[ 1474.691361] devfreq-event event0: nocp@10ca1000 (event: 257693/709600) 60ms 36% 0x00ebece4
[ 1474.691390] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1474.691416] devfreq-event event2: nocp@10ca1800 (event: 253602/709600) 60ms 35% 0x00e82e2c
[ 1474.691441] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000

(c) modetest test (wcore enters highest freq):

root@target:~/devfreq# dmesg|tail
[ 1519.281376] devfreq-event event2: nocp@10ca1800 (event: 244940/709600) 60ms 34% 0x00e04008
[ 1519.281409] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1519.341390] devfreq-event event0: nocp@10ca1000 (event: 258097/709600) 60ms 36% 0x00ec4ba4
[ 1519.341449] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1519.341505] devfreq-event event2: nocp@10ca1800 (event: 254087/709600) 60ms 35% 0x00e89fcc
[ 1519.341558] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1519.401322] devfreq-event event0: nocp@10ca1000 (event: 258749/709600) 60ms 36% 0x00ece454
[ 1519.401352] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1519.401382] devfreq-event event2: nocp@10ca1800 (event: 254742/709600) 60ms 35% 0x00e93960
[ 1519.401410] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
* 177400000:         0         0         0         0         5   1073960
  266000000:         0         0         4         0         0    394620
  532000000:         0         1         2         4         0     28000
Total transition : 18
root@target:~/devfreq# ../modetest -s 43:1920x1080 -P41:1920x1080 &
[1] 821
root@target:~/devfreq# trying to open device 'i915'...failed
trying to open device 'amdgpu'...failed
trying to open device 'radeon'...failed
trying to open device 'nouveau'...failed
trying to open device 'vmwgfx'...failed
trying to open device 'omapdrm'...failed
trying to open device 'exynos'...done
setting mode 1920x1080-60Hz@XR24 on connectors 43, crtc 41
testing 1920x1080@XR24 overlay plane 36
^C

[1]+  Stopped                 ../modetest -s 43:1920x1080 -P41:1920x1080
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
  177400000:         0         0         0         0         6   1089830
  266000000:         0         0         4         0         0    394620
* 532000000:         0         1         2         4         0     40520
Total transition : 19
root@target:~/devfreq# dmesg|tail
[ 1552.161498] devfreq-event event2: nocp@10ca1800 (event: 498005/2128000) 60ms 23% 0x01c7f020
[ 1552.161528] devfreq-event event3: nocp@10ca1c00 (event: 0/2128000) 60ms 0% 0x00000000
[ 1552.221416] devfreq-event event0: nocp@10ca1000 (event: 513190/2128000) 60ms 24% 0x01d5d710
[ 1552.221486] devfreq-event event1: nocp@10ca1400 (event: 0/2128000) 60ms 0% 0x00000000
[ 1552.221552] devfreq-event event2: nocp@10ca1800 (event: 508518/2128000) 60ms 23% 0x01d18ff0
[ 1552.221616] devfreq-event event3: nocp@10ca1c00 (event: 0/2128000) 60ms 0% 0x00000000
[ 1552.281311] devfreq-event event0: nocp@10ca1000 (event: 505519/2128000) 60ms 23% 0x01ced138
[ 1552.281336] devfreq-event event1: nocp@10ca1400 (event: 0/2128000) 60ms 0% 0x00000000
[ 1552.281358] devfreq-event event2: nocp@10ca1800 (event: 499471/2128000) 60ms 23% 0x01c947b4
[ 1552.281380] devfreq-event event3: nocp@10ca1c00 (event: 0/2128000) 60ms 0% 0x00000000
root@target:~/devfreq# dmesg|tail
[ 1557.951773] devfreq-event event2: nocp@10ca1800 (event: 510726/2128000) 60ms 24% 0x01d39584
[ 1557.951851] devfreq-event event3: nocp@10ca1c00 (event: 0/2128000) 60ms 0% 0x00000000
[ 1558.011229] devfreq-event event0: nocp@10ca1000 (event: 502846/2128000) 60ms 23% 0x01cc5eac
[ 1558.011261] devfreq-event event1: nocp@10ca1400 (event: 0/2128000) 60ms 0% 0x00000000
[ 1558.011291] devfreq-event event2: nocp@10ca1800 (event: 497245/2128000) 60ms 23% 0x01c73dfc
[ 1558.011320] devfreq-event event3: nocp@10ca1c00 (event: 0/2128000) 60ms 0% 0x00000000
[ 1558.081269] devfreq-event event0: nocp@10ca1000 (event: 511612/2128000) 70ms 24% 0x02227618
[ 1558.081300] devfreq-event event1: nocp@10ca1400 (event: 0/2128000) 70ms 0% 0x00000000
[ 1558.081328] devfreq-event event2: nocp@10ca1800 (event: 506381/2128000) 70ms 23% 0x021cdfa0
[ 1558.081355] devfreq-event event3: nocp@10ca1c00 (event: 0/2128000) 70ms 0% 0x00000000
root@target:~/devfreq# fg %1
../modetest -s 43:1920x1080 -P41:1920x1080

root@target:~/devfreq# dmesg|tail
[ 1568.641483] devfreq-event event2: nocp@10ca1800 (event: 257123/709600) 60ms 36% 0x00eb675c
[ 1568.641533] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1568.701434] devfreq-event event0: nocp@10ca1000 (event: 262797/709600) 60ms 37% 0x00f09930
[ 1568.701479] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1568.701522] devfreq-event event2: nocp@10ca1800 (event: 257838/709600) 60ms 36% 0x00ec0ef0
[ 1568.701565] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
[ 1568.761201] devfreq-event event0: nocp@10ca1000 (event: 258960/709600) 60ms 36% 0x00ed15e0
[ 1568.761220] devfreq-event event1: nocp@10ca1400 (event: 0/709600) 60ms 0% 0x00000000
[ 1568.761236] devfreq-event event2: nocp@10ca1800 (event: 253698/709600) 60ms 35% 0x00e844a8
[ 1568.761253] devfreq-event event3: nocp@10ca1c00 (event: 0/709600) 60ms 0% 0x00000000
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat
     From  :   To
           :  88700000 133000000 177400000 266000000 532000000   time(ms)
   88700000:         0         0         0         0         1     19630
  133000000:         0         0         0         0         1        90
* 177400000:         0         0         0         0         6   1094030
  266000000:         0         0         4         0         0    394620
  532000000:         0         1         3         4         0     57630
Total transition : 20

---
After appling proposed patches devfreq changes wcore frequencies according
to bus load.

Kamil Konieczny (3):
  PM / devfreq: exynos-nocp: fix debug print type
  PM / devfreq: exynos-bus: prepare for change in load calc in
    exynos-nocp
  PM / devfreq: exynos-nocp: change load and total calculations

 drivers/devfreq/event/exynos-nocp.c | 61 ++++++++++++-----------------
 drivers/devfreq/exynos-bus.c        | 21 +++++++++-
 include/linux/devfreq-event.h       |  4 ++
 3 files changed, 48 insertions(+), 38 deletions(-)

-- 
2.25.0

