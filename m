Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704D338D5B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfFGOf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:35:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50109 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbfFGOf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143525euoutp01ce060950db0052b4f612eafc2a0a8e14~l8UVH7Pmd0114101141euoutp01r
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143525euoutp01ce060950db0052b4f612eafc2a0a8e14~l8UVH7Pmd0114101141euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918125;
        bh=LfIzVpHvL6QUADSI2AZywhT+Vizxo3HFKvCNEc672TY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sxIV4KNux0twg31+a20iskFvwrG/B9GblIIGYUyKjvCU8dPwRpuJT+UG1f0d50vOG
         vRp8sGM7ohOQBLuGkemAXhmwcnB7spdzA0ecZNfjGv2qklQ+5yspFdHHMhvFKyGpd6
         ifTLfbFYeDNK1ko+u+NOsOJg4uyiCa5FPcRwkfnU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607143524eucas1p21c628de9975bf25a675e7c5ed9a4abe5~l8UUF_b072161821618eucas1p2N;
        Fri,  7 Jun 2019 14:35:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 32.D0.04325.C267AFC5; Fri,  7
        Jun 2019 15:35:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143523eucas1p1015a614a64ed22f4c65ace8b795dd6d0~l8UTOYbT_1212112121eucas1p1v;
        Fri,  7 Jun 2019 14:35:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143523eusmtrp1b65ec071b994034d5999dc9bd1d61174~l8US_je-S1284512845eusmtrp1Q;
        Fri,  7 Jun 2019 14:35:23 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-8a-5cfa762c6bb7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.C0.04140.B267AFC5; Fri,  7
        Jun 2019 15:35:23 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143522eusmtip19de1cde106eb8ef250a153c0d882ce54~l8USE36Pm2644726447eusmtip1s;
        Fri,  7 Jun 2019 14:35:22 +0000 (GMT)
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
Subject: [PATCH v9 00/13] Exynos5 Dynamic Memory Controller driver
Date:   Fri,  7 Jun 2019 16:34:54 +0200
Message-Id: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzHfe93vwen4+dq7rskdsvkKRqzr3k27Kch5p+mxKXfKrqj++nk
        Ye1kqHRXq61uPQwzqiuq0061ntwdUagWiZKHSsmJpNYDl87v8N/78/68Pvu899mHwiQtuDsV
        oTzJqpTySBkhEpoejjUuX6YeD1pZ+ckVleiLcPTyRy+Orlqf4ahgsAugCzeKCJRWnyNAT64o
        UHLXZww1NhaT6GmcjUSvNR5oMKkTRy0V2QQa0loB0jdWC9Bt6xsSNddvR+3n8whksV3Gkb21
        RIhqnvuh9omZaOTRB7BZyowMpwqZr20XSSZL0yxkyjPfkIzRkEAwNTmFJKO9MEAw9wcqBYyu
        1ACYuw1nmSGj594ZB0TrQ9nICDWrWrHxsCj8dbeOOFHBxLzX2oAGfFibCKZTkF4N7+gNZCIQ
        URI6D8DuvByCL34A2BtXjfHFEIA3iyeFf0eMVQ8wh5bQuVNUfcy/iXjLpCARUBRB+8AyQ5SD
        caP1AGb17XcwGH0Pg1/aO4CDcaW3QrNF6mCE9EJoGm/FHVpMb4LGzFsYv2s+LCiu/RMC0sMk
        LCgdFPCNbTCr45sTcoX9daUkrz1gQ1qSMygHNdrrgNfnYFdyjpNZBy11zbgjA0YvhkUVK3h7
        C0zvHvljQ3ombPsy22FjUzLVlIHxthjGX5LwtDcsTWpyhpkDcwvTSR5h4APtGf44B6Et9TOZ
        Ajwz/6+6BoABSNloThHGcquU7CkfTq7gopVhPkeOK4xg6tUa7HXDZaD6Z4gZ0BSQuYgZcixI
        gsvV3GmFGUAKk7mJ1U2jQRJxqPz0GVZ1/JAqOpLlzGAuJZRJxWenvQuU0GHyk+wxlj3Bqv52
        BdR0dw0497EwOfBx7NjDyfK8zlc7XXbpdpPfrSHK/HVVdV6+Gbj/nrRFE56181LKQ/b1jQan
        JNjag4e8e94zo/p8jDCJmnylHm5l/TH+dqNdmtGhswTEX/IzzerbcDRjgcuqX+ae1QMBEaHD
        neFelUferYlq2ZErdl0a++jpC1322ygm8JlMyIXLfZdgKk7+G4m859ZmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7raZb9iDCZ8k7bYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y7j1pI+tYJdHxcPeN4wNjI8suxg5OSQETCQ27T3K3MXIxSEksJRR4sCTBSwQCTGJSfu2s0PY
        whJ/rnWxQRR9YpRYt+sokMPBwSagJ7FjVSFIXERgDqPEz65tjCAOs8BZZondK94wgRQJCzhJ
        HDosDjKIRUBVYtuva6wgNq+AvcSmWcuYIRbIS6zecIB5AiPPAkaGVYwiqaXFuem5xUZ6xYm5
        xaV56XrJ+bmbGIFRte3Yzy07GLveBR9iFOBgVOLhncH0M0aINbGsuDL3EKMEB7OSCG/ZhR8x
        QrwpiZVVqUX58UWlOanFhxhNgZZPZJYSTc4HRnxeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
        9MSS1OzU1ILUIpg+Jg5OqQZGrXuMbxc8KeTU/Xv09WuVdxXz6uxWPFBfrrLed2pq4cSvtX8b
        GQXX5Uy/cj4tpoFlZTCHxUtp+aObPup8UCreFKq/j8Hgini2wptVN50tlogtPXrI8Xacz7FJ
        u58qVRdZhv21NqqbxdBV8Xd5sHnVcsl/FiVl76IO3v4ZuMr7guMrr0vJFhodSizFGYmGWsxF
        xYkAlM/eVsACAAA=
X-CMS-MailID: 20190607143523eucas1p1015a614a64ed22f4c65ace8b795dd6d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143523eucas1p1015a614a64ed22f4c65ace8b795dd6d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143523eucas1p1015a614a64ed22f4c65ace8b795dd6d0
References: <CGME20190607143523eucas1p1015a614a64ed22f4c65ace8b795dd6d0@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v9 which introduces minor changes. The patch set adds support of
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
v9:
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
 drivers/memory/samsung/exynos5422-dmc.c       | 1261 +++++++++++++++++
 include/dt-bindings/clock/exynos5420.h        |   18 +-
 include/memory/jedec_ddr.h                    |   62 +
 20 files changed, 2040 insertions(+), 13 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.17.1

