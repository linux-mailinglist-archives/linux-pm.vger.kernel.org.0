Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410552D7107
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 08:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgLKHo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 02:44:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25947 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389127AbgLKHoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 02:44:24 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201211074340epoutp03ec68f7a7eda74b4f7db6553e8a5ea10e~PmbsCBRIX0577605776epoutp03K
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 07:43:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201211074340epoutp03ec68f7a7eda74b4f7db6553e8a5ea10e~PmbsCBRIX0577605776epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607672620;
        bh=G2N39l3fVZYX0q/DnFoGPUJPUawid4RL234JBKugQks=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Cov1WxPtHZDdcNcfg0kSUbxJttNmB7tEffMPJI2qcoT7u98VMCMyJxqy4+ghUdqkz
         rND4zN1C5fuq+cnMrKmm5roaca4e2DBWkNy1jg1YeftNof4zVw/wN/OPeZI/yVU0Y9
         NCM75GAdZLOnrMNf2g3VWRkXZX4g/a4b4PUeKKK8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201211074339epcas1p1e9512eacb7f216019127f583fae97fd3~PmbrJppib2652826528epcas1p1m;
        Fri, 11 Dec 2020 07:43:39 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CsjT34KTKz4x9Q1; Fri, 11 Dec
        2020 07:43:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.AC.10463.52323DF5; Fri, 11 Dec 2020 16:43:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201211074332epcas1p27c7057fae84f6b6535a7bc4e89737c20~Pmbk7tL9E1787317873epcas1p2r;
        Fri, 11 Dec 2020 07:43:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201211074332epsmtrp26881c68cb6ac389c53a8dbeb925c17de~Pmbk4A5kl2971629716epsmtrp2B;
        Fri, 11 Dec 2020 07:43:32 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-a8-5fd3232574fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.37.08745.42323DF5; Fri, 11 Dec 2020 16:43:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201211074329epsmtip2af86aaabc4bef33c1067d94e0b2463db~PmbiKnM4m1700517005epsmtip2i;
        Fri, 11 Dec 2020 07:43:29 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.11
Organization: Samsung Electronics
Message-ID: <56c09abc-da54-5e53-3313-3185fb84bb71@samsung.com>
Date:   Fri, 11 Dec 2020 16:58:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmnq6q8uV4g307rC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCd0Xrq
        FVvBbN2KmTM7GBsYW5W7GDk5JARMJFo/T2HsYuTiEBLYwSjxu38eG4TziVHi3fK3rBDOZ0aJ
        L9Mus8K0PHg/H6plF6PEqyPz2SGc94wSi09+YOpi5OAQEbCX6PiQCRJnFrjAJHFxUxtYN5uA
        lsT+FzfYQGxhIPv91v/sIDa/gKLE1R+PGUFsXgE7if3dfUwgNouAqkTr60ssILaoQJjEyW0t
        UDWCEidnPgGLMwuIS9x6Mp8JwpaX2P52DjPIYgmBn+wSe7ZNZIc420XixJkXUC8IS7w6vgUq
        LiXx+d1eNgi7WmLlySNsEM0djBJb9l+AajCW2L90MthnzAKaEut36UOEFSV2/p7LCLGYT+Ld
        1x5WkBIJAV6JjjYhiBJlicsP7jJB2JISi9s7oVZ5SJxavJ5pAqPiLCTvzELyziwk78xCWLyA
        kWUVo1hqQXFuemqxYYEJcnRvYgQnTy2LHYxz337QO8TIxMF4iFGCg1lJhFeW5VK8EG9KYmVV
        alF+fFFpTmrxIUZTYABPZJYSTc4Hpu+8knhDUyNjY2MLE0MzU0NDJXHeP9od8UIC6Yklqdmp
        qQWpRTB9TBycUg1MptVW01NzFX71ZU7gyOhv9r2rHNc+6YaFfHpy2lZb7zs+7SaTPnvPEWNk
        eF+wQvlp6VQp9u9zX8i++jd/WcYt0+03uNsYnxgsWxEnWZr6y9MoOlLwcMT0Sa/jHxi+2zq3
        8NHp5qSDEmbvDJ+s/hXMFb39zrGYiaJxW37miWuEb/vd4Z8+j/9VVsCspfWRB3WMFlRyHJiY
        VH5xpf2/baqTUz8nBrE6sYQEKK05NePP01J17t63G1dLGnBPbuxIeuojPK9cy9J5xZWmO9Un
        VZssraddKM2975x3OcuaZb15xQ2lry/UL6yf/VzWaKuyi4D45veP1py5XXxVftk3je/N2V5H
        RCuc+Kdw79XiYXygxFKckWioxVxUnAgAqRdCeycEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvK6K8uV4g6MnNCwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4MpoPfWKrWC2bsXMmR2MDYytyl2MnBwSAiYSD97PZ+xi5OIQEtjBKLG08xg7
        REJSYtrFo8xdjBxAtrDE4cPFEDVvGSWmHJrFDhIXEbCX6PiQCRJnFrjEJLHxzA2wXjYBLYn9
        L26wgdjCQPb7rf/B4vwCihJXfzxmBLF5Bewk9nf3MYHYLAKqEq2vL7GA2KICYRI7lzxmgqgR
        lDg58wlYnFlAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJyFpGUWkpZZSFpmIWlZwMiyilEy
        taA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOCa0tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeWZZL
        8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwWR089Tgu
        pN64LkqD6zz703UfDlzr+OyRrH5Ee8+vsuyXbOwzxLWU1yo7+RXsVrd+/TrYtfNfWEe/g/Xb
        mJ6kZo5VTvOXTNYu/zL3mZSIudC9z3fzDu5e+5ilo03t+CPG5MzjUX2HeLTmsp8Wn/HR1ZYr
        5JzPtrt5r+KaHhSkzPkg7BV7QMIw4sD8fr7wueLKETsPrbu5JLyz+Pzfkz/2TmLtu1x8/2mr
        3OXd3Q/XXrLTmfbNwcX4q0vBO1nJymddyzTyxI4budd8X+gjfvW+cLKt9/elW2RWc/s/splT
        rC7L/0u/eMmTx/EP3237kTp1iujRJFU/iyVK3jMavH8wPDi00a+Wv6Nn6urVm3TslViKMxIN
        tZiLihMByjYasvgCAAA=
X-CMS-MailID: 20201211074332epcas1p27c7057fae84f6b6535a7bc4e89737c20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201211074332epcas1p27c7057fae84f6b6535a7bc4e89737c20
References: <CGME20201211074332epcas1p27c7057fae84f6b6535a7bc4e89737c20@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.11-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.
- tag name : devfreq-next-for-5.11

Best Regards,
Chanwoo Choi


The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.11

for you to fetch changes up to 6a575e84f11e15078629f0d16bff2bc354a6bfc0:

  PM / devfreq: tegra30: Separate configurations per-SoC generation (2020-12-07 10:25:51 +0900)

----------------------------------------------------------------

Update devfreq for 5.11

Detailed description for this pull request:

1. Update devfreq core
- Add new devfreq_frequency tracepoint to show the frequency change
information.

- Add governor feature flag. The devfreq governor is able to
have the specific flag in order to contain the non-common feature.
For example, if governor contains the 'immutable' feature, don't allow
user to change the governor via sysfs.

- Add governor sysfs attribute flag for each sysfs file. Prior to that
devfreq subsystem show the all sysfs files regardless of governor type.
But, some sysfs fils are not supported on the specific devfreq governor.
In order to show the only supported sysfs files according to the governor,
clarify the access permission of sysfs attributes according to governor.
When adding the devfreq governor, can specify the available attribute
information by using DEVFREQ_GOV_ATTR_* constant variable. The user can
read or write the sysfs attributes in accordance to the specified attributes.

- Clean-up the code to remove the duplicate code for the devfreq tracepoint
and to remove redundant governor_name field from struct devfreq

2. Update exynos-bus.c devfreq driver
- Add interconnect API support for the Samsung Exynos Bus Frequency driver
of exynos-bus.c. Complementing the devfreq driver with an interconnect
functionality allows to ensure the QoS requirements of devices accessing
the system memory (e.g. video processing devices) are fulfilled
and allows to avoid issues like the DMA underrun.

3. Update tegra devfreq driver
- Add interconnect support and OPP interface for tegra30-devfreq.c.
Also, it is to guarantee the QoS requirement of some devices like
display controller.

- Move tegra20-devfreq.c from drivers/devfreq/ into driver/memory/tegra/
in order to use the more proper monitoring feature such as EMC_STAT
which is based in driver/memory/tegra/.

- Separate the configuration information for different SoC on
tegra30-devfrqe.c. The tegra30-devfreq.c had been supported both
tegra30-actmon and tegra124-actmon devices. In order to use
the more correct configuration data, separate them.

- Use dev_err_probe() to handle the deferred probe error on tegra30-devfreq.c.

4. Pull the request of 'Tegra SoC and clock controller changes for v5.11'
sent by Krzysztof Kozlowski <krzk@kernel.org> in order to prevent the
build error.

----------------------------------------------------------------
Chanwoo Choi (6):
      trace: events: devfreq: Use fixed indentation size to improve readability
      PM / devfreq: Unify frequency change to devfreq_update_target func
      PM / devfreq: Add governor feature flag
      PM / devfreq: Add governor attribute flag for specifc sysfs nodes
      PM / devfreq: Remove redundant governor_name from struct devfreq
      Merge tag 'tegra-soc-clk-drivers-5.11' of https://git.kernel.org/.../krzk/linux-mem-ctrl into devfreq-next

Dmitry Osipenko (9):
      PM / devfreq: tegra20: Silence deferred probe error
      PM / devfreq: tegra20: Relax Kconfig dependency
      PM / devfreq: tegra30: Silence deferred probe error
      clk: tegra: Export Tegra20 EMC kernel symbols
      soc/tegra: fuse: Export tegra_read_ram_code()
      soc/tegra: fuse: Add stub for tegra_sku_info
      PM / devfreq: tegra20: Deprecate in a favor of emc-stat based driver
      PM / devfreq: tegra30: Support interconnect and OPPs from device-tree
      PM / devfreq: tegra30: Separate configurations per-SoC generation

Matthias Kaehlcke (1):
      PM / devfreq: Add tracepoint for frequency changes

Sylwester Nawrocki (2):
      dt-bindings: devfreq: Add documentation for the interconnect properties
      PM / devfreq: exynos-bus: Add registration of interconnect child device

 Documentation/ABI/testing/sysfs-class-devfreq      |  54 +++--
 .../devicetree/bindings/devfreq/exynos-bus.txt     |  71 +++++-
 MAINTAINERS                                        |   1 -
 drivers/clk/tegra/clk-tegra20-emc.c                |   3 +
 drivers/devfreq/Kconfig                            |  10 -
 drivers/devfreq/Makefile                           |   1 -
 drivers/devfreq/devfreq.c                          | 242 ++++++++++++++-------
 drivers/devfreq/exynos-bus.c                       |  17 ++
 drivers/devfreq/governor.h                         |  33 ++-
 drivers/devfreq/governor_passive.c                 |  44 +---
 drivers/devfreq/governor_simpleondemand.c          |   2 +
 drivers/devfreq/tegra20-devfreq.c                  | 212 ------------------
 drivers/devfreq/tegra30-devfreq.c                  | 159 ++++++++------
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   2 +
 include/linux/devfreq.h                            |   4 -
 include/soc/tegra/fuse.h                           |   4 +
 include/trace/events/devfreq.h                     |  30 ++-
 17 files changed, 456 insertions(+), 433 deletions(-)
 delete mode 100644 drivers/devfreq/tegra20-devfreq.c

