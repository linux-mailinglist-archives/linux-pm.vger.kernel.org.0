Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8F459A6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfFNJyf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:54:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35829 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfFNJxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095322euoutp018d0817b876018d5754d8f4edd94c8be8~oB-DggPmy0765507655euoutp01O
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095322euoutp018d0817b876018d5754d8f4edd94c8be8~oB-DggPmy0765507655euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506002;
        bh=EEMK9w78j87lqfuJPFFkSqyrL66eM2GM9eUBmO4lepk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dEOLBdoS18n708nGalFN3ghUZ11mTkSeWxqGOsCNkmAwAGoVgVgL5nFqilqPTjNOu
         i6lDeEkwZxeLXGo670xmpJRF7u43E4oaCQOLCoJ5sQL/dSwBcHA1X7y655gTq9CSQb
         bXCypuIl3e04hjChJxMrv6I8o8eqHe+PLaL+dzr8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614095320eucas1p2fea6165f3ed3de7aebde889109cf3918~oB-CiOaWC0479404794eucas1p2u;
        Fri, 14 Jun 2019 09:53:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.A5.04298.09E630D5; Fri, 14
        Jun 2019 10:53:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095319eucas1p2d47b6bd9179c7e4190972d6b22092ad7~oB-BlPv7b0478804788eucas1p2x;
        Fri, 14 Jun 2019 09:53:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095319eusmtrp29bd6568298fc6558df18414be8ac76e7~oB-BkgF552148521485eusmtrp2u;
        Fri, 14 Jun 2019 09:53:19 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-21-5d036e90ace9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.DA.04140.F8E630D5; Fri, 14
        Jun 2019 10:53:19 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095318eusmtip26364febb82ab420463e490505771c7d1~oB-AlQsky2320823208eusmtip2M;
        Fri, 14 Jun 2019 09:53:18 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v10 00/13] Exynos5 Dynamic Memory Controller driver
Date:   Fri, 14 Jun 2019 11:52:56 +0200
Message-Id: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTQRh2uqdoyVqJjBdqE1FIOEx8mAjxJtnAAyT44lGx6gpGWrULAmKk
        QlSsYA2oEK5qPCkgpRBUlIJQqAGl4q2gEJsgyH0aIBUpW/XtO+f7H4bGJB+IZfRRZQynUsqj
        paQLXtk42eJzVYnJ/Bu7vFBZdimBPo79IJDO3EKgomEbQCm3S0mU2ZQvQi8vK5DW1oshq9VA
        oVfJfRT6ol6BhtO+EehtVR6JRtPNAGVbTSJUYv5KodamINR27gGJ6vsuEuj3hzIc1bwLRm3T
        rmjixXew1Z2dGM/A2cFP5yk2V92Ks09yvlKsUX+JZGvyiyk2PWWAZJ8PPBOxVyr0gC1vTmRH
        jR5hC/a4BB7moo+e4lR+mw+4RHWZBkUntMHxRZpnuBpcD9CA+TRkNsJ7mkygAS60hHkAoKE/
        kxLIGIDlhnZCIKMAGnOuif5WMsd7nJX7AA5MZIF/lV+6rllC0yTjCx/rTzoKbkw2gLnd4Y4M
        xjzCYH9bO3AYi5kdcLy6kHJgnFkLr9msc1jMbIHl+oeksLYKFhlqMUcZMsMULC7vA4KxE5ZU
        f8YEvBj+tFRQAl4BZ57onKfyUJ1+y5k/A23afGcmANZbWgnHoRjjBUur/AR5G7S/N83JkHGF
        n/oXOWRsFmZUZmGCLIapFyRCej2sSHvtHFoC7xffcD7OwpreoTldwsjgxyE9eRV45PzfugmA
        HrhzsbwikuM3KLk4X16u4GOVkb6HjiuMYPa3Nf+2jDwG428O1gGGBtKF4tpNIpmEkJ/iExR1
        ANKY1E1cEIDJJOLD8oTTnOp4hCo2muPrwHIal7qLE+d17pUwkfIY7hjHneBUf10RPX+ZGqwJ
        XxonQqYCuf+ObouqfcwnSZcTareyIUEt+yb276K6g/h6V9fVCQAPuZ46Ythd+NS7x7I9T+vZ
        GXSuwb72btiRkItKlGQ/Y9fNNJsor8Cm6YjklVOe3T9LZr7dqY1PNdp8z67z0pIa8+S9mIY3
        zzt6Qtebps0eUxsTdB1xZinOR8k3eGMqXv4HgC+7D2kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xe7r9ecyxBv9mGllsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLwm3ZWi3/XNrJY7L/iZXH7N5/FtxOPGB3E
        Pb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2DwOvtvD5NG3ZRWjx+bT1R6f
        N8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        ZTzb956poN+rYnXXHpYGxqnWXYycHBICJhKTv75k7GLk4hASWMoosbb/HhtEQkxi0r7t7BC2
        sMSfa11sEEWfGCU2b/zO1MXIwcEmoCexY1UhSFxEYA6jxM+ubWCTmAXOMkvsXvGGCaRbWMBZ
        4uvelWCTWARUJaY8Pg9m8wrYS2xetQ5qm7zE6g0HmCcw8ixgZFjFKJJaWpybnltspFecmFtc
        mpeul5yfu4kRGFfbjv3csoOx613wIUYBDkYlHt4DVkyxQqyJZcWVuYcYJTiYlUR451kzxwrx
        piRWVqUW5ccXleakFh9iNAVaPpFZSjQ5HxjzeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGPV2Je7boJmiUtIQ8CUupWOR37uNluLBHhp/Qg/Kyx95xTrj+9rT
        yaI5y+8atU5TWNV1ocjbe2F0hnqny40/s+/knF7gd+lRgGfF41M5+eIFJtbvglMeblm90Hju
        rDydd50dryNUc+o9nIxXLqy8Zi4qLC10yFtnS4luteMehq2dGfFC/bWzlViKMxINtZiLihMB
        Z1fwpsECAAA=
X-CMS-MailID: 20190614095319eucas1p2d47b6bd9179c7e4190972d6b22092ad7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095319eucas1p2d47b6bd9179c7e4190972d6b22092ad7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095319eucas1p2d47b6bd9179c7e4190972d6b22092ad7
References: <CGME20190614095319eucas1p2d47b6bd9179c7e4190972d6b22092ad7@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v10 which introduces minor changes. The patch set adds support of
Dynamic Memory Controller for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scaling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
There is also new generic code in of_memory and headers which allows to parse
LPDDR3 memories defined in device-tree.

The patch set has been cut to land mainline quickly and the dependency
on PPMU patches are removed (which was in v7). It implies that the debugging
code which was presenting details about traffic on the AXI slots has been
removed. It will be added when this driver got mainline and the PPMU code
got mainline. Also DT dependency of PPMU header has been removed.

changes:
v10:
- added disabling counters and cleaning clocks in probe when it fails
- added Reviewed-by for dt-bindings: memory-controllers from Rob
- based on v5.2-rc4 tag
v9 [4]:
- disable bpll instead of spll clocks in the remove path
- safely disable 'bypass' clocks when error was captured
- removed unused clocks and related code
- changed code to make 'if' statement clean as Krzysztof sugested
- removed cloks from dt-binding and DT
- minor fix for clocks to read the state for DIV with NOCACHE
- removed spaces in #define and put tabs
- removed duplicated entry for OPPs phandle in dt-binding
- collected ACKs
- based on v5.2-rc3 tag
v8 [3]:
- removed chipID dependency, as Krzysztof suggested and drop the whole checking
  code in the driver (which also Marek suggested offline) (it might be needed
  in future when other configuration would be supported). It also avoids
  a misunderstandings and simplifies the documentation.
- reordered clock IDs in 1st patch to keep the old IDs and add the new clocks
  at the end as Chanwoo suggested (added also his ACK there)
- in patch 6 (dt-bindings) added explicit clocks and names in the right order
  needed for the driver
- added proper address for the memory node in the documentation and in the DT
  (lpddr3-timings@0 -> @80000000)
- fixed wrong reg offset for pause feature
- removed debug code which shows AXI slots traffic and removed DT ppmu events
- in the driver code usage of 'dev', 'pdev->dev' has been aligned
- manipulating clocks has been aligned as Krzysztof suggested, now it enables
  only two clocks (and disables) and enables/disables the 'bypass' clocks
  on demand
- added comments in the documentation why there is a need of clock registers
  to be accessed via syscon regmap
- added proper link to Documentation/devicetree/bindings/ddr/lpddr3.txt
  in dt-bindings for memory controller doc
- removed unneeded prints when there was a deferred probe or during remove
- added 'syscon' also to exynos5420-clock node as Krzysztof suggested
- from 2nd patch removed blank line and added Acked-by: Chanwoo Choi
- collecting ACKs, which makes the clock related 3 patches
  ready to be merged (4 ACKs),
- patches 4,5 got 'Reviewed-by' from Rob
- it is now based on v5.2-rc3 tag
v7 [2]:
- added using regmap in chipid registers and clock registers
- in DT added "syscon" to compatible field in clock and chipid
- added two addition clocks in clocks definition file which were there
  in first implementation but now are grouped and commented properly
  (CLK_DOUT_PCLK_DREX0, CLK_DOUT_PCLK_DREX1)
- the BPLL ratio table now is set for Exynos 5422 and 5800 and not for 5420
- in DMC driver, changed code macro which generates functions for setup events
  into normal three functions as Krzysztof suggested
- moved 'clock_prepare_enable()' calls into the same function where 'disable'
  were called
- changed 'timing_reg' static variables into static const
- in DMC driver: the proper device_node *np_ddr is now put correctly
- in DMC driver: removed code related to counters_enabled
- mapped only 0x100 from DREX registers
- in DT memory node there is now 'reg' as Rob suggested instead of 'max-freq'
- in Documentation/devicetree/bindings/lpddr2 renamed into 'ddr' and the lpdd3*
  files landed there.
- cleaned the commit subject and message as Rob suggested for the patch 4/10 in v6
- added doxygen comments to exported functions in of_memory file
- cleaned minor issues like: missing space, 2 empty lines, in the doc JESD209-2 ->
  JESD209-3C, removed 'status = "okay"' from the doc file, etc
- based on v5.1 (+ PPMU patches from [1])
v6:
- driver code has been converted to use generic code which parses DT memory
  definition in drivers/memory/of_memory.c
- extended of_memory by LPDDR3 support (there was LPDDR2 made by TI)
- extended jedec_lpddr.h by the needed structures for LPDDR3 (AC timings)
- driver file moved to proper directory, where other memory controllers
  live, which is in this case drivers/memory/samsung/
- driver code now uses regmap_{read|write} to access registers for pausing
  and changing timings set, as suggested by Chanwoo
- DT contains simple definition of memory device, similar to LPDDR2 made by TI
- driver code generates the needed timings for registered OPPs, based on
  memory description in DT
- patch 1 contains Rob's ACK,
- simplified memory bandwidth calculation
- added debug information files with timings, raw counters and statistics
- updated dt-bindings files accordingly
- based on v5.1-rc5 (+ PPMU patches from [1])
v5:
- removed unneeded wrapper functions i.e. for regulator_set_voltage
- removed unused defines
- removed direct access to clock register base and used CCF for
  pause and timing set usage
- switched to OPP comming from DT according to Chanowoo's comments
- switched to timings comming from DT, added parsing function
- extended dt-binding with description of OPPs and timings
- according to Rob Herring comment, moved dt-binding file before driver code
  in the patch set.
- rebased on top of v5.0
v4:
- removed unneeded DPLL and G3D clocks IDs
- changed names of parent clocks for mout_mx_mspll_ccore_phy_p
  and added one more parent: mout_sclk_epll
- removed 933Mhz and 138MHz from the BPLL ratio table
v3:
- in DTS align to proper indent the clocks and clock-names entries
v2:
- changed file name exynos5-dmc.c -> exynos5422-dmc.c
  and related entries in other files
- changed dt-binding file name
- changed config entry to CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ
- removed sysfs and print info messages (print only one line)
- removed function exynos5_read_chip_info and compact code
- changed dt-binding patch and move it up in the patch set
- new entries in MAINTAINERS are added with the driver c code
- clean-up in DTS file: renamed nodes to 'ppmu' and 'memory-controller',
  entries moved to suggested location (before nocp nodes or after),
  moved according to alfabetical order, compacted clocks names with right indent.

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/4/19/158
[2] https://lkml.org/lkml/2019/5/6/829
[3] https://lkml.org/lkml/2019/6/5/687
[4] https://lkml.org/lkml/2019/6/7/488


Lukasz Luba (13):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  dt-bindings: ddr: rename lpddr2 directory
  dt-bindings: ddr: add LPDDR3 memories
  drivers: memory: extend of_memory by LPDDR3 support
  dt-bindings: memory-controllers: add Exynos5422 DMC device description
  drivers: memory: add DMC driver for Exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: dts: exynos: add chipid label and syscon compatible
  ARM: dts: exynos: add syscon to clock compatible
  ARM: dts: exynos: add DMC device for exynos5422
  ARM: exynos_defconfig: enable DMC driver

 .../{lpddr2 => ddr}/lpddr2-timings.txt        |    0
 .../bindings/{lpddr2 => ddr}/lpddr2.txt       |    2 +-
 .../bindings/ddr/lpddr3-timings.txt           |   58 +
 .../devicetree/bindings/ddr/lpddr3.txt        |   97 ++
 .../memory-controllers/exynos5422-dmc.txt     |   75 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/exynos5.dtsi                |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi             |   75 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  116 ++
 arch/arm/boot/dts/exynos5800.dtsi             |    2 +-
 arch/arm/configs/exynos_defconfig             |    1 +
 drivers/clk/samsung/clk-exynos5420.c          |   78 +-
 drivers/devfreq/event/exynos-ppmu.c           |    6 +
 drivers/memory/of_memory.c                    |  154 ++
 drivers/memory/of_memory.h                    |   18 +
 drivers/memory/samsung/Kconfig                |   17 +
 drivers/memory/samsung/Makefile               |    1 +
 drivers/memory/samsung/exynos5422-dmc.c       | 1262 +++++++++++++++++
 include/dt-bindings/clock/exynos5420.h        |   18 +-
 include/memory/jedec_ddr.h                    |   62 +
 20 files changed, 2041 insertions(+), 13 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.17.1

