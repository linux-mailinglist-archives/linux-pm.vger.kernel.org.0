Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A07361AF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfFEQya (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32866 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfFEQya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165428euoutp015287a2a98c5bc182f0e26fc4f3a15fbe~lW7KIKApD3068430684euoutp019
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165428euoutp015287a2a98c5bc182f0e26fc4f3a15fbe~lW7KIKApD3068430684euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753668;
        bh=MErTamP5M3GfJ7G7TZmcmWQdbx1uMAN9aw7lByR9EHM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fT94KG58HPPtJnaoKIH/ROOY+rjA6nA8hHLp3WIE7mtYNWANDZAyG3fyGd/QT+Epr
         syfHFpHidk+MCSKr8C91pqfWiDjJX9eCOBu7b6LpwCscaHD9M3GJRr+JEQYiJdJ7+K
         1M0yBSRqtuXe28+Czx05V1ay0gW1v7O9EloUCuJA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605165427eucas1p2c3e72b98602266d1ed04a9fa7efc54dd~lW7JU2TFZ0466904669eucas1p2z;
        Wed,  5 Jun 2019 16:54:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9A.08.04325.3C3F7FC5; Wed,  5
        Jun 2019 17:54:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605165426eucas1p20524669a299f740b5502db24977b098f~lW7IbxjIQ0085900859eucas1p2X;
        Wed,  5 Jun 2019 16:54:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165426eusmtrp2fb963d931d0e128fb047c72d3dffdac0~lW7IMFvFH2868028680eusmtrp2F;
        Wed,  5 Jun 2019 16:54:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-2a-5cf7f3c32b7e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.3D.04140.1C3F7FC5; Wed,  5
        Jun 2019 17:54:25 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165424eusmtip13f54458e6395146a51c38ece093b9f83~lW7GzQ-iS0338903389eusmtip1I;
        Wed,  5 Jun 2019 16:54:24 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v8 00/13] Exynos5 Dynamic Memory Controller driver
Date:   Wed,  5 Jun 2019 18:53:57 +0200
Message-Id: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7qHP3+PMeh8xm6xccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZxSXTUpqTmZZapG+XQJXRs/uC2wF7S4Vxz79
        ZG5gnGXWxcjBISFgIjHvVU0XIxeHkMAKRon2DY9Zuxg5gZwvjBJXD6pD2J8ZJRbeLAOxQerv
        7t3JBtGwnFGi4do6JggHqOHjt23sIFPZBPQkdqwqBGkQEaiWuHN9PzNIDbPAGyaJs79+sIAk
        hAWcJJrO3mUDsVkEVCXe75rHCGLzCthL/O/cxAixTV5i9YYDYM0SAofYJSa9m8UGkXCRuL5k
        CVSRsMSr41vYIWwZif875zNB2MUSDb0LoWpqJB73z4WqsZY4fPwiK8ihzAKaEut36UOEHSU+
        tN5jhYQKn8SNt4IgYWYgc9K26cwQYV6JjjYhiGoNiS09F6AWiUksXzMNariHxMU5W6BhGCvx
        8f0bxgmMcrMQdi1gZFzFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmJpO/zv+dQfjvj9J
        hxgFOBiVeHglNn6PEWJNLCuuzD3EKMHBrCTCm3j7S4wQb0piZVVqUX58UWlOavEhRmkOFiVx
        3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxnVB4WbJ6ukZ8WXHJvF036xbcDpH5ctM67KDq1R7
        Ztm2H8mbd80p2erRLinluGWeTHsFkl+4zp7Pczp5++JJM2y1GrWn2jZ2skXfvv7uuIDUge4Q
        m5QZ9769/9y/tuzxyofP9V71Bqol/1cqiyivcXq3tVFxTvD/9utV+ZZJ4i1qH6omS1xUUmIp
        zkg01GIuKk4EAGpuBRhJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xu7oHP3+PMfh2ysJi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jJ7dF9gK2l0qjn36ydzAOMusi5GTQ0LAROLu3p1s
        XYxcHEICSxklbhzYyQ6REJOYtG87lC0s8edaF1TRJ0aJjiMPgBIcHGwCehI7VhWC1IgI1Ev0
        v7kEVsMs0MAssWb7VVaQhLCAk0TT2btsIDaLgKrE+13zGEFsXgF7if+dmxghFshLrN5wgHkC
        I88CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgbGx7djPLTsYu94FH2IU4GBU4uGV2Pg9
        Rog1say4MvcQowQHs5IIb+LtLzFCvCmJlVWpRfnxRaU5qcWHGE2Blk9klhJNzgfGbV5JvKGp
        obmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsZjvw1Ts7QPpNwrNZJ9eOjG
        I725sy08zEv3L+A5rOeVWTur03qd6MeXlYyPc+Im2bZdYLHjMQs7LPEyJlrLpvZg+Vefss3q
        127o8K4/vHZBsFuM7GHfG9p13Am3/eWjTUOnfFt90y4sK8L6H8+EOIttubOVmaMO+rQu2M7n
        4DN5d+s39S89/5VYijMSDbWYi4oTAYGtVEajAgAA
X-CMS-MailID: 20190605165426eucas1p20524669a299f740b5502db24977b098f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165426eucas1p20524669a299f740b5502db24977b098f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165426eucas1p20524669a299f740b5502db24977b098f
References: <CGME20190605165426eucas1p20524669a299f740b5502db24977b098f@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v8 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scaling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
There is also new generic code in of_memory and headers which allows to parse
LPDDR3 memories defined in device-tree.

The patch set has been cut to land mainline quickly and the dependency
on PPMU patches are removed. It implies that the debugging code which was
presenting details about traffic on the AXI slots has been removed.
It will be added when this driver got mainline and the PPMU code got mainline.
Also DT dependency of PPMU header has been removed.

changes:
v8:
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
 .../memory-controllers/exynos5422-dmc.txt     |   84 ++
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/exynos5.dtsi                |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi             |   81 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  116 ++
 arch/arm/boot/dts/exynos5800.dtsi             |    2 +-
 arch/arm/configs/exynos_defconfig             |    1 +
 drivers/clk/samsung/clk-exynos5420.c          |   74 +-
 drivers/devfreq/event/exynos-ppmu.c           |    6 +
 drivers/memory/of_memory.c                    |  154 ++
 drivers/memory/of_memory.h                    |   18 +
 drivers/memory/samsung/Kconfig                |   17 +
 drivers/memory/samsung/Makefile               |    1 +
 drivers/memory/samsung/exynos5422-dmc.c       | 1265 +++++++++++++++++
 include/dt-bindings/clock/exynos5420.h        |   18 +-
 include/memory/jedec_ddr.h                    |   62 +
 20 files changed, 2057 insertions(+), 11 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.17.1

