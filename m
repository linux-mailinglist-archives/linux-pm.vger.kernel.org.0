Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8AF5BC9E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfGANMo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49136 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGANLx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131151euoutp02978ba61aa720aa52143bb70143bd4e12~tSqNsYonc1063810638euoutp02W
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190701131151euoutp02978ba61aa720aa52143bb70143bd4e12~tSqNsYonc1063810638euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986711;
        bh=YJeFbalqd+qWF4YGvZEIpj6/rX59tRYrPhdtDBDyxfw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=o91J2qOAF4dTjnN9KyYoZyI9vHz65iVN4qIosoZtLqfo9h5sDtz7P9X5NN0dz8Qdq
         o10X7bgXKzXhU/cQqeP999kYQdBbH/w4BlLtV1NsPP8mqqEwbmc9eDGhcjvsTmOTxZ
         Dis7vmTBS3eo0VBdQZrdSB6AGLas7Nqv4Cod/rws=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701131150eucas1p24c12c22985dabba5985413293ae41e31~tSqMye_QT1082510825eucas1p2R;
        Mon,  1 Jul 2019 13:11:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8B.77.04325.6960A1D5; Mon,  1
        Jul 2019 14:11:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131149eucas1p1911af36ecdd9efc6b00039b67d810721~tSqLvtuFb0099700997eucas1p1X;
        Mon,  1 Jul 2019 13:11:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131149eusmtrp28670386e7c153c02cd6dc941c2239520~tSqLhZ1Bf0788807888eusmtrp20;
        Mon,  1 Jul 2019 13:11:49 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-cc-5d1a0696dee8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1E.F1.04146.5960A1D5; Mon,  1
        Jul 2019 14:11:49 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131148eusmtip154508f09ddccffdd87ace69c881d1aee~tSqKoUCfZ2623726237eusmtip1Z;
        Mon,  1 Jul 2019 13:11:48 +0000 (GMT)
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
Subject: [PATCH v11 0/9] Exynos5 Dynamic Memory Controller driver
Date:   Mon,  1 Jul 2019 15:11:29 +0200
Message-Id: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeyyVcRjH/c57dXLa26H8ktGO1aotFf74lW7W7V2tZtNW05RT3jDOofNS
        iT8OCrlEFKbc1swlElkh4ZysU8flpCLLoYtJ5dJMWqdMeXup/z7P83y/v++zZz8ak78kHOhg
        dQSnUStDFaQUv//EYlqfTTr4bRy5boNqcqsJ9PrbCIEK27oIdHtyCKD4W9UkyjLmS1BHigql
        D41iyGS6S6HOuDEKvdE6osnUQQK9bLxJoqm0NoByTc0SVNU2QKFu4x7UH1tGosdjiQSa7a3B
        Ucur/aj/12L0/ekHsNOe/T6dibNf+y5R7A1tN8425A1QbG3FZZJtya+k2LT4CZLVTTRJ2Ct1
        FYC91x7NTtU6eS/ylW4N4EKDz3KaDdv9pUFdxgPhLQfPx+u6cC3I2J4MrGnIeEBzapEkGUhp
        OVMG4OecGUIsvgE4nJmIi8UUgN2Tl8kFS92VIkpgOVMKYGzVvn+Ohz9SQDKgaZJxhfUVZwSN
        HZML4I1PPoIGYx5gcLzfDISBLeMF21OKJQLjzCqYlHOVErwyZgdMyFstZjnD23dbMcELmUkK
        Zuelzy+xG94Z7sdEtoVfDHWUyI7wd0OhRGQeatOKgcgxcCg9f17jCR8bugkhC2PWwurGDWLb
        Cz4bN/xdATKLYd/4EqGNzWHm/RxMbMtgUoJcVK+BdanP54OWwdLK7PnHWTh87S0hXscPvtW9
        pzKAU97/rCIAKoA9F8mrAjneXc2dc+WVKj5SHeh6KkxVC+a+WvusYboeNM+c1AOGBgobmdYM
        /eSE8iwfpdIDSGMKO1lL2XI/uSxAGXWB04Sd0ESGcrwerKBxhb0s2urdMTkTqIzgQjgunNMs
        TCW0tYMWdJYD9yqOdvZ/HxO3lq7cUuRmtbKn3FBSetxtl93gCXtjhq5vc4iPce+hyLjwhKmc
        qpiafSX8Lsvxno/eRz18OxOTCjrM7k66Y4+6XPwtp80vjrSGzEhdBrcpuZ/++o6l01aeNpbD
        sa2OWaNOBXhS/dfVkgO+vU2yiy+c8faJLAcFzgcpN63DNLzyDxePt/xmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7pT2aRiDaYu47TYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        yzh3yrtgv29F88FzLA2ME+y6GDk5JARMJLb0LWDvYuTiEBJYyijR8vEpO0RCTGLSvu1QtrDE
        n2tdbBBFnxglXrw/zNLFyMHBJqAnsWNVIUhcRGAOo8TPrm2MIA6zwFlmid0r3jCBdAsLOEqc
        7l4IZrMIqEp0TJ/IDtLMK2Av0TZLDWKBvMTqDQeYJzDyLGBkWMUoklpanJueW2yoV5yYW1ya
        l66XnJ+7iREYU9uO/dy8g/HSxuBDjAIcjEo8vBq3JGKFWBPLiitzDzFKcDArifDuXyEZK8Sb
        klhZlVqUH19UmpNafIjRFGj3RGYp0eR8YLznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpgDDs9zfvakaOXs816BU6Xf7y0aWKvPEPPw0YTzWWxeS++Z4rHlkl/
        FFxXonSwRC4g8IF3DLeJp5tz5LPnrvX8Fk/mhF9jE5PLPNbnb3GyqVXuYKDFq73/DzS8DS03
        SnQtcOAQnSMnzMUmv/FJjOS87fKpU3L3rLP9XTLJqagnKyWgXPfJj7tKLMUZiYZazEXFiQDL
        GtNJvwIAAA==
X-CMS-MailID: 20190701131149eucas1p1911af36ecdd9efc6b00039b67d810721
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131149eucas1p1911af36ecdd9efc6b00039b67d810721
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131149eucas1p1911af36ecdd9efc6b00039b67d810721
References: <CGME20190701131149eucas1p1911af36ecdd9efc6b00039b67d810721@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v11 which introduces minor changes. The patch set adds support of
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
v11:
- added code during probe in clocks init which disables 2 paths to PHY,
  which should be done in the bootloader but some of them missed it.
- removed unused macros and changed into BIT(x) sets.
- changed 'selects' in Kconfig into 'depends on', added COMPILE_TEST
  and moved in alphabetical order entry in MAINTAINERS file
- it is based on Samsung clk development tree 'for-next' where there are 3
  patches with Exynos5422 clocks (they are skipped here)
- skipped PATCH v10 09/13 with new PPMU events, since it is in devfreq tree
  'for-next' now
- caution: possible conflict with 'next-20190621' or newer due to a patch
  in there, which moves include/memory/jedec_ddr.h into drivers/memory/;
  my changes: '[PATCH 3/9] drivers: memory: extend of_memory by LPDDR3 support'
v10 [5]:
- added disabling counters and cleaning clocks in probe when it fails
- added Reviewed-by for dt-bindings: memory-controllers from Rob
- based on v5.2-rc4 tag
v9 [4]:
- disable bpll instead of spll clocks in the remove path
- safely disable 'bypass' clocks when error was captured
- removed unused clocks and related code
- changed code to make 'if' statement clean as Krzysztof suggested
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
[5] https://lkml.org/lkml/2019/6/14/296


Lukasz Luba (9):
  dt-bindings: ddr: rename lpddr2 directory
  dt-bindings: ddr: add LPDDR3 memories
  drivers: memory: extend of_memory by LPDDR3 support
  dt-bindings: memory-controllers: add Exynos5422 DMC device description
  drivers: memory: add DMC driver for Exynos5422
  ARM: dts: exynos: add chipid label and syscon compatible
  ARM: dts: exynos: add syscon to clock compatible
  ARM: dts: exynos: add DMC device for exynos5422
  ARM: exynos_defconfig: enable DMC driver

 .../{lpddr2 => ddr}/lpddr2-timings.txt        |    0
 .../bindings/{lpddr2 => ddr}/lpddr2.txt       |    2 +-
 .../bindings/ddr/lpddr3-timings.txt           |   58 +
 .../devicetree/bindings/ddr/lpddr3.txt        |   97 ++
 .../memory-controllers/exynos5422-dmc.txt     |   73 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/exynos5.dtsi                |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi             |   73 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  116 ++
 arch/arm/boot/dts/exynos5800.dtsi             |    2 +-
 arch/arm/configs/exynos_defconfig             |    2 +
 drivers/memory/of_memory.c                    |  149 ++
 drivers/memory/of_memory.h                    |   18 +
 drivers/memory/samsung/Kconfig                |   13 +
 drivers/memory/samsung/Makefile               |    1 +
 drivers/memory/samsung/exynos5422-dmc.c       | 1257 +++++++++++++++++
 include/memory/jedec_ddr.h                    |   61 +
 17 files changed, 1929 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.17.1

