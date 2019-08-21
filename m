Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1657397749
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfHUKnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:43:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35637 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfHUKnV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104319euoutp02813fc459db4c8e6680a6372db76cbb50~86iFKTPfb0273902739euoutp024
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821104319euoutp02813fc459db4c8e6680a6372db76cbb50~86iFKTPfb0273902739euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384199;
        bh=f3wLyHimzjUSTT7T66Ch/UfMQRVvmyGyE4ItTn8wVqE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kM7X+ywJ4UyLg6DQYuAr1lGpjoq9svJEl7OhPEYhLio0EJ7DN9mOcLpac8vj7p0i2
         s0u4sN/0f6JKg2bpssp9ibEVASPcQBeWWLujq6mCuLT5fRJv664Hi7kEvu1Rw0VYjt
         ojXpWDV+tfbN87zOrB/ZXGQ5YvpIGIHRFhZZmYyc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821104317eucas1p2b3e3f3db56979e7d32f44faadb51ef66~86iEC0dm50890708907eucas1p2C;
        Wed, 21 Aug 2019 10:43:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.A6.04374.5402D5D5; Wed, 21
        Aug 2019 11:43:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8~86iDDUovf0930409304eucas1p2W;
        Wed, 21 Aug 2019 10:43:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104316eusmtrp26eae727cdae03b4d9cf385dfa04bcbe1~86iDCaXzG2827528275eusmtrp2y;
        Wed, 21 Aug 2019 10:43:16 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-50-5d5d20458cac
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.38.04117.4402D5D5; Wed, 21
        Aug 2019 11:43:16 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104315eusmtip235af88bda0a5da9b34ba2a58ef2adecc~86iB7RrcF1223712237eusmtip2F;
        Wed, 21 Aug 2019 10:43:15 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v13 0/8] Exynos5 Dynamic Memory Controller driver
Date:   Wed, 21 Aug 2019 12:42:55 +0200
Message-Id: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzHfe93v/v9Ol1+fjU+ysJNG0Z5Gt9haDK/ZTabmY3ddOmnbrrD
        /fRsHEnFJZOpVScKpbr1oEmeu25denQeKiwPtZUelPSAEF13+O/1eX8e3p/vZ1+aYNtJd1ql
        OcJrNcpQuUQqvl39vXHJ5rkKxVJ9uRcuSSsicctwF4mzzI0kLhjsQDg2p0iCU2oNIlx/Vo2T
        O3oJ3NRUTOGGk30Ufq2bjQf1b0n8/G6mBA8lmRFOa3oowkZzG4Wvt1hF2Fq7Gb85kSfBcQ/M
        FK7qiyfxeHOJGD964Y/f/HDBozXtaOMsrvByIeJGRy6IuYHWOIrL0FnFXEV6G8WV5idKuEeG
        QopLiu2XcJX990XcubJ8xN2qi+GGSj23O++WrgviQ1XhvNZnfYA0JKOjgToUC5F5FVE61Mme
        QU40MCvhWlM2cQZJaZbJQ2BMzaHswTCCir5SRzCEoKAqBf1tqXxlomzMMrkIGquP/+toM16a
        SNC0hPGGO/mHbTVuTBqCjI87bDUE84GAc8bMyUGujC/oT7WQNhYzXmDtTyFsLGM2QO99k8Ns
        DhQUP57cD5hEGsZHvpH2hB8UNHc72BV6LGWUnWfD74oskZ0F0CVddQw6Ch3JBkfNWqiyWEnb
        ogSzEIru+thlX+ipiUc2GRgXaP003SYTE3jhdiphl2WQcNpxuQVQpn/qMJoBuYX2lwPDQeLA
        fPt1FFBlfiU+jzzT/1tdQSgfzeTDBHUwL6zQ8BHeglIthGmCvfcdVJeiiZ9XN24ZuYMe/gw0
        IYZGcmdZQMseBUsqw4UotQkBTcjdZJGZuxWsLEgZFc1rD+7VhoXyggl50GL5TFnMlPd7WCZY
        eYQ/wPOHeO3frIh2cteh/dJ64+8Nq722HHvJer3bOY13DqyL113c6GSOMbDX5uNj57ND3t20
        hCdV7rrHJD8LGihXxUW7uUz3udfentvtF0Bnf322qTP3cNdZkT7oVslYztQXCZ71wQGqq/4z
        5lWv8ru++MsNjFWB28ZGen9FJJdvLbZ8XpPoG7hc88R/zY1oD7lYCFEuW0RoBeUfnOY4VHUD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7ouCrGxBk3n9Cw2zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFkuvX2SyuHjK1eJ24wo2i9a9R9gtDr9pZ7X4d20ji8X+K14W
        t3/zWXw78YjRQdJjzbw1jB7fvk5i8Xh/o5XdY3bDRRaPnbPusntsWtXJ5rF/7hp2j97md2we
        B9/tYfLo27KK0WPz6WqPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
        TJX07WxSUnMyy1KL9O0S9DJmPz7LXtAsUbFiZ2UD4zOhLkZODgkBE4mDNw+xg9hCAksZJZYf
        T4WIi0lM2redHcIWlvhzrYuti5ELqOYTo8TL52cZuxg5ONgE9CR2rCoEiYsIzGGU+Nm1jRHE
        YRb4zSxx8G4/WLewgKNET8t1VhCbRUBV4uK7ycwgNq+AvcTrPYcYITbIS6zecIB5AiPPAkaG
        VYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIERt+3Yzy07GLveBR9iFOBgVOLh3XEzOlaINbGs
        uDL3EKMEB7OSCG/FnKhYId6UxMqq1KL8+KLSnNTiQ4ymQMsnMkuJJucDk0FeSbyhqaG5haWh
        ubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGsVDLz5NMaip3n30crWk74z+Pr6rk
        TS5lpqen/4bH1nNFz3st9pHhAZtS+XS7fysb1u589VfbdlagxhqunxoMxYzX17H4M3fNutQU
        IruXV27FleDdOnbFzNM3Wxqc8e3VceDSFXj0pMQperFgwfREh81f2oImnnn25iWj9nbL0g6l
        23PYsxYqsRRnJBpqMRcVJwIAKZWt8M4CAAA=
X-CMS-MailID: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v13 which makes cosmetic changes. It is based on current mainline
(v5.3-rc5) with with devfreq/for-next where there is a PPMU patch [1].

The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scaling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
There is also new generic code in of_memory and headers which allows to parse
LPDDR3 memories defined in device-tree.

Here are the last changes suggested by Krzysztof during his review.
For the previous changes in older revisions please refer to [2], there is
more detailed change log.

changes:
v13:
- skipped patch with chipID changes in DT, since it is not used anymore,
- removed license comment in of_memory.c since SPDX has been merged,
- aligned comment to the current fields in the structure,
- changed printed warning when timings are not found,

Regards,
Lukasz Luba

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b617376df8f01c975dee66802f4da16291f92079
[2] https://lkml.org/lkml/2019/7/22/251


Lukasz Luba (8):
  dt-bindings: ddr: rename lpddr2 directory
  dt-bindings: ddr: add LPDDR3 memories
  drivers: memory: extend of_memory by LPDDR3 support
  dt-bindings: memory-controllers: add Exynos5422 DMC device description
  drivers: memory: add DMC driver for Exynos5422
  ARM: dts: exynos: add syscon to clock compatible
  ARM: dts: exynos: add DMC device for exynos5422
  ARM: exynos_defconfig: enable DMC driver

 .../{lpddr2 => ddr}/lpddr2-timings.txt        |    0
 .../bindings/{lpddr2 => ddr}/lpddr2.txt       |    2 +-
 .../bindings/ddr/lpddr3-timings.txt           |   58 +
 .../devicetree/bindings/ddr/lpddr3.txt        |   97 ++
 .../memory-controllers/exynos5422-dmc.txt     |   73 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/exynos5420.dtsi             |   73 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  116 ++
 arch/arm/boot/dts/exynos5800.dtsi             |    2 +-
 arch/arm/configs/exynos_defconfig             |    1 +
 drivers/memory/jedec_ddr.h                    |   61 +
 drivers/memory/of_memory.c                    |  149 ++
 drivers/memory/of_memory.h                    |   18 +
 drivers/memory/samsung/Kconfig                |   13 +
 drivers/memory/samsung/Makefile               |    1 +
 drivers/memory/samsung/exynos5422-dmc.c       | 1257 +++++++++++++++++
 16 files changed, 1926 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.17.1

