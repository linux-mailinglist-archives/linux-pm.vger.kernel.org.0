Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836AA2A3DD4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKCHkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 02:40:23 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29805 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgKCHkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 02:40:22 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201103074019epoutp01ce2fc4fe1a1544bc546b7b4217cedc2d~D736KotuW2940029400epoutp01T
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 07:40:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201103074019epoutp01ce2fc4fe1a1544bc546b7b4217cedc2d~D736KotuW2940029400epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604389219;
        bh=CpF6fCF9Ej0ij/j844g6OegZ8bzLWvldVIAiixTTzuk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kYwMd2kYj/NbacFbm14RcKCzzulfYCis7n5bXogy/ZLAsveI3oplGEKbP9UsGBY2c
         qlnUjl9NzIukhMTFIKLYJg8lraTESoyVu4OR271Kd7NZhdTLpl0NhlLXHY1Hg7ud+v
         Tx+Hav5vyQeWqHo80aNvFOBayNiT5ON8KfoQCwiU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201103074017epcas1p1b207204cd37afa270e8a46facd41e4be~D734TStBW0499404994epcas1p1u;
        Tue,  3 Nov 2020 07:40:17 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CQMBk4HnTzMqYkZ; Tue,  3 Nov
        2020 07:40:14 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.E5.09582.E5901AF5; Tue,  3 Nov 2020 16:40:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201103074012epcas1p1b0711cfde3b20238de9aaf0b1db41551~D730ZK_l_2387723877epcas1p1L;
        Tue,  3 Nov 2020 07:40:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201103074012epsmtrp1a6ff7644cedb15b2e7b251b8f1a27e0e~D730YVpGB1889518895epsmtrp1c;
        Tue,  3 Nov 2020 07:40:12 +0000 (GMT)
X-AuditID: b6c32a37-e2fb8a800000256e-78-5fa1095e8fbd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.28.13470.C5901AF5; Tue,  3 Nov 2020 16:40:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201103074012epsmtip1a2909f0f02ca079f4e5362d7a0f3512f~D73z96PRA0898008980epsmtip1p;
        Tue,  3 Nov 2020 07:40:12 +0000 (GMT)
Subject: Re: [PATCH v7 0/6] Exynos: Simple QoS for exynos-bus using
 interconnect
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        georgi.djakov@linaro.org, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b586c2b7-9ca1-e641-b70c-27493ffd05e0@samsung.com>
Date:   Tue, 3 Nov 2020 16:54:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmnm4c58J4g0Odihb357UyWmycsZ7V
        Yv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BucXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        WvceYbc4/Kad1WLG5JdsDvwem1Z1snncubaHzeN+93Emj74tqxg9Pm+SC2CNyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpXSaEsMacUKBSQWFys
        pG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdsebxIuaCbR4V
        CxZ+YGtgbDPuYuTkkBAwkZixdjJbFyMXh5DADkaJPYfXskI4nxglJn35DpX5xijx+MscRpiW
        RX/+QlXtZZSYc/orE4TznlFi3+wfbCBVwgJBEmsntgN1cHCICMRIrH8XARJmFjjBJHHkjiCI
        zSagJbH/xQ2wcn4BRYmrPx6DLeAVsJM4secBE0gri4CKxJ1JtiBhUYEwiZPbWqBKBCVOznzC
        AmJzClhLdHXeYIIYLy5x68l8KFteonnrbGaQ0yQEbnBIvD20hQniAReJNYtOs0LYwhKvjm9h
        h7ClJF72t0HZ1RIrTx5hg2juYJTYsv8CVIOxxP6lk8GOYxbQlFi/Sx8irCix8/dcRojFfBLv
        vvawgpRICPBKdLQJQZQoS1x+cBfqBEmJxe2dbBMYlWYheWcWkhdmIXlhFsKyBYwsqxjFUguK
        c9NTiw0LjJEjexMjOCVrme9gnPb2g94hRiYOxkOMEhzMSiK8NZHz4oV4UxIrq1KL8uOLSnNS
        iw8xmgLDdyKzlGhyPjAr5JXEG5oaGRsbW5gYmpkaGiqJ8/7R7ogXEkhPLEnNTk0tSC2C6WPi
        4JRqYLp1OfzSuhWqtz+curU5h0U/VSsh9mSgXsHDT7EMO7hzb1in53w7t+hC9lodlfYt598l
        svrO0vtjHKlscZGph22N5FUX4eQ1Qqwe7Oa2aawWclcf1yZ1Tz93/+oquUP3NzdFy2vwRj8r
        jitp6Ob5srT4ompr7V2R6Debr9jO5vM3S8ws+u/gXWjuzXBrtn8c04sboq3HH3C92z7tSONz
        eYXQZ793Mt7bUWl5Rb7OtH0787S0jjdRJREqFyNvq2tGb5D83e33RuHJvC2PdnSpflqQf/9z
        f91rh4JrncwyD/Pfp4osaEi8P+H0jZ7rbSHbmvj6TAU5zfZVXUhoqd7wg5GhY2XY98/OT98V
        uXV8UmIpzkg01GIuKk4EAFo40gBSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSnG4M58J4g7e3NCzuz2tltNg4Yz2r
        xfwj51gtrnx9z2Yxfe8mNotJ9yewWJw/v4Hd4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7BZ
        tO49wm5x+E07q8WMyS/ZHPg9Nq3qZPO4c20Pm8f97uNMHn1bVjF6fN4kF8AaxWWTkpqTWZZa
        pG+XwJWx5vEi5oJtHhULFn5ga2BsM+5i5OSQEDCRWPTnL2sXIxeHkMBuRokPB9pYIRKSEtMu
        HmXuYuQAsoUlDh8uhqh5yyixrOcjI0iNsECQxNqJ7WC2iECMxKnJs1hAipgFTjBJfFz1gAmi
        o49RYnvXHhaQKjYBLYn9L26wgdj8AooSV388BuvmFbCTOLEHpIGDg0VAReLOJFuQsKhAmMTO
        JY+ZIEoEJU7OfAI2hlPAWqKr8wZYnFlAXeLPvEvMELa4xK0n86Hi8hLNW2czT2AUnoWkfRaS
        lllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4PrU0dzBuX/VB7xAj
        EwfjIUYJDmYlEd6ayHnxQrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgt
        gskycXBKNTCxcn+a6BVo+bN+JrPiXdGrX7cc3qUx5X5e6EzLsNNMxw5Jn/dalafSuLdhXktI
        ybs7lSL/VrU9L5ufbld9IOQP74/Y2C2z89nOPrsz625i1tbZkwsuz22Ocj93efmtEmMji+ll
        lb1a658nsj35su5bLFfJ8wzR0uI3i6OiV5tEdM/+c917se4ehj0/l/LfVY9sybuvs7Z26S6z
        my+3l5hMbZg2d+/U03tcTYX8fi+qnMZQu+nBK0km+1+xmgLmEZ6eHjXt1ptW6oU4tpXtP8nC
        ppMs6/f9bMLtfFvn6adkBUrEU9zjt39bOu8n52aupm81jydybVG+5LitlrvBaeqao2JfDhZu
        kp4mMPPKu3XmSizFGYmGWsxFxYkAafLqjT4DAAA=
X-CMS-MailID: 20201103074012epcas1p1b0711cfde3b20238de9aaf0b1db41551
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776
References: <CGME20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776@eucas1p1.samsung.com>
        <20201030125149.8227-1-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

When I tested this patchset on Odroid-U3,
After setting 0 bps by interconnect[1][2],
the frequency of devfreq devs sustain the high frequency
according to the pm qos request.

So, I try to find the cause of this situation.
In result, it seems that interconnect exynos driver
updates the pm qos request to devfreq device
during the kernel booting. Do you know why the exynos
interconnect driver request the pm qos during probe
without the mixer request?

PS. The passive governor has a bug related to PM_QOS interface.
So, I posted the patch[4].


[1] interconnect_graph
root@localhost:~# cat /sys/kernel/debug/interconnect/interconnect_graph 
digraph {
        rankdir = LR
        node [shape = record]
        subgraph cluster_1 {
                label = "soc:bus_dmc"
                "2:bus_dmc" [label="2:bus_dmc
                        |avg_bw=0kBps
                        |peak_bw=0kBps"]
        }
        subgraph cluster_2 {
                label = "soc:bus_leftbus"
                "3:bus_leftbus" [label="3:bus_leftbus
                        |avg_bw=0kBps
                        |peak_bw=0kBps"]
        }
        subgraph cluster_3 {
                label = "soc:bus_display"
                "4:bus_display" [label="4:bus_display
                        |avg_bw=0kBps
                        |peak_bw=0kBps"]
        }
        "3:bus_leftbus" -> "2:bus_dmc"
        "4:bus_display" -> "3:bus_leftbus"


[2] interconnect_summary
root@localhost:~# cat /sys/kernel/debug/interconnect/interconnect_summary 
 node                                  tag          avg         peak
--------------------------------------------------------------------
bus_dmc                                               0            0
  12c10000.mixer                         0            0            0
bus_leftbus                                           0            0
  12c10000.mixer                         0            0            0
bus_display                                           0            0
  12c10000.mixer                         0            0            0


[3] devfreq_summary
root@localhost:~# cat /sys/kernel/debug/devfreq/devfreq_summary 
dev                            parent_dev                     governor        timer      polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
------------------------------ ------------------------------ --------------- ---------- ---------- ------------ ------------ ------------
soc:bus_dmc                    null                           simple_ondemand deferrable         50    400000000    400000000    400000000
soc:bus_acp                    soc:bus_dmc                    passive         null                0    267000000    100000000    267000000
soc:bus_c2c                    soc:bus_dmc                    passive         null                0    400000000    100000000    400000000
soc:bus_leftbus                null                           simple_ondemand deferrable         50    200000000    200000000    200000000
soc:bus_rightbus               soc:bus_leftbus                passive         null                0    200000000    100000000    200000000
soc:bus_display                soc:bus_leftbus                passive         null                0    200000000    200000000    200000000
soc:bus_fsys                   soc:bus_leftbus                passive         null                0    134000000    100000000    134000000
soc:bus_peri                   soc:bus_leftbus                passive         null                0    100000000     50000000    100000000
soc:bus_mfc                    soc:bus_leftbus                passive         null                0    200000000    100000000    200000000


[4] PM / devfreq: passive: Update frequency when start governor
https://patchwork.kernel.org/project/linux-pm/patch/20201103070646.18687-1-cw00.choi@samsung.com/


On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
> 
> This patchset adds interconnect API support for the Exynos SoC "samsung,
> exynos-bus" compatible devices, which already have their corresponding
> exynos-bus driver in the devfreq subsystem.  Complementing the devfreq
> driver with an interconnect functionality allows to ensure the QoS
> requirements of devices accessing the system memory (e.g. video processing
> devices) are fulfilled and aallows to avoid issues like the one discussed
> in thread [1].
> 
> This patch series adds implementation of the interconnect provider per each
> "samsung,exynos-bus" compatible DT node, with one interconnect node per
> provider.  The interconnect code which was previously added as a part of
> the devfreq driver has been converted to a separate platform driver.
> In the devfreq a corresponding virtual child platform device is registered.
> Integration of devfreq and interconnect frameworks is achieved through
> the PM QoS API.
> 
> A sample interconnect consumer for exynos-mixer is added in patches 5/6,
> 6/6, it is currently added only for exynos4412 and allows to address the
> mixer DMA underrun error issues [1].
> 
> Changes since v6:
>  - the interconnect consumer DT bindings are now used to describe dependencies
>    of the interconnects (samsung,exynos-bus nodes),
>  - bus-width property replaced with samsung,data-clk-ratio,
>  - adaptation to recent changes in the interconnect code
>    (of_icc_get_from_provider(), icc_node_add()).
> 
> The series has been tested on Odroid U3 board. It is based on v5.10-rc1.
> 
> --
> Regards,
> Sylwester
> 
> 
> Changes since v5:
>  - addition of "bus-width: DT property, which specifies data width
>    of the interconnect bus (patches 1...2/6),
>  - addition of synchronization of the interconnect bandwidth setting
>    with VSYNC (patch 6/6).
> 
> Changes since v3 [4] (v4 skipped to align with patchset [1]), detailed
> changes are listed in each patch:
>  - conversion to a separate interconnect (platform) driver,
>  - an update of the DT binding documenting new optional properties:
>    #interconnect-cells, samsung,interconnect-parent in "samsung,exynos-bus"
>    nodes,
>  - new DT properties added to the SoC, rather than to the board specific
>    files.
> 
> Changes since v2 [5]:
>  - Use icc_std_aggregate().
>  - Implement a different modification of apply_constraints() in
>    drivers/interconnect/core.c (patch 03).
>  - Use 'exynos,interconnect-parent-node' in the DT instead of
>    'devfreq'/'parent', depending on the bus.
>  - Rebase on DT patches that deprecate the 'devfreq' DT property.
>  - Improve error handling, including freeing generated IDs on failure.
>  - Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().
> 
> Changes since v1 [6]:
>  - Rebase on coupled regulators patches.
>  - Use dev_pm_qos_*() API instead of overriding frequency in
>    exynos_bus_target().
>  - Use IDR for node ID allocation.
>  - Reverse order of multiplication and division in
>    mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.
> 
> 
> References:
> [1] https://patchwork.kernel.org/patch/10861757/ (original issue)
> [2] https://protect2.fireeye.com/v1/url?k=383efc40-67a5c559-383f770f-000babff3793-a505fcd0b7477e5e&q=1&e=ad8ffb9f-f90b-49a7-a3df-2ab066a8c4ee&u=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-samsung-soc%2Fmsg70014.html
> [3] https://protect2.fireeye.com/v1/url?k=13f0c488-4c6bfd91-13f14fc7-000babff3793-98a59bf1c5c6f1fb&q=1&e=ad8ffb9f-f90b-49a7-a3df-2ab066a8c4ee&u=https%3A%2F%2Fwww.spinics.net%2Flists%2Farm-kernel%2Fmsg810722.html
> [4] https://lore.kernel.org/linux-pm/20191220115653.6487-1-a.swigon@samsung.com
> [5] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> [6] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)
> 
> 
> Artur Świgoń (1):
>   ARM: dts: exynos: Add interconnects to Exynos4412 mixer
> 
> Sylwester Nawrocki (5):
>   dt-bindings: devfreq: Add documentation for the interconnect
>     properties
>   interconnect: Add generic interconnect driver for Exynos SoCs
>   PM / devfreq: exynos-bus: Add registration of interconnect child
>     device
>   ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes
>   drm: exynos: mixer: Add interconnect support
> 
>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  68 ++++++-
>  arch/arm/boot/dts/exynos4412.dtsi                  |   7 +
>  drivers/devfreq/exynos-bus.c                       |  17 ++
>  drivers/gpu/drm/exynos/exynos_mixer.c              | 146 ++++++++++++++-
>  drivers/interconnect/Kconfig                       |   1 +
>  drivers/interconnect/Makefile                      |   1 +
>  drivers/interconnect/exynos/Kconfig                |   6 +
>  drivers/interconnect/exynos/Makefile               |   4 +
>  drivers/interconnect/exynos/exynos.c               | 198 +++++++++++++++++++++
>  9 files changed, 438 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c
> 
> --
> 2.7.4
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
