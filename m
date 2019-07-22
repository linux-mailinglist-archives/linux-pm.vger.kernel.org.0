Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D76FCB9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGVJr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42135 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfGVJr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094726euoutp0233a3009670acd61ddfaf3225ef19e0be~zsauTzyoZ2848028480euoutp02v
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094726euoutp0233a3009670acd61ddfaf3225ef19e0be~zsauTzyoZ2848028480euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788846;
        bh=S12yyKlOLnnSwlb+8J5gxAmo4VOk+LffYfEu/ohNJfw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k51VXZB2JicygE01Y56q7BKu+CRsZma4epYpWCzHlpRpcS6s5UN8A8ZR3nnD3+S9S
         81Behew+aTxDTxujwc6tT11BQz4U1fh3xVEuVd7dPc8g0GKzIlbwlxTXwWrEoCuLBB
         922C5UElv2AINBtqH+9FQcAs1y0JxbIHJissn5+Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722094724eucas1p1f67560ed954029a009218b5139889df2~zsatOw3Sy1120311203eucas1p1H;
        Mon, 22 Jul 2019 09:47:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 30.85.04298.C26853D5; Mon, 22
        Jul 2019 10:47:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094724eucas1p21d37e28f25f632081f2b0f48ace70826~zsasb-S0D2046920469eucas1p2H;
        Mon, 22 Jul 2019 09:47:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722094723eusmtrp151e5a32faf727b2f99569d2720648321~zsasNgxpN3266032660eusmtrp1l;
        Mon, 22 Jul 2019 09:47:23 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-9c-5d35862c963a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.1A.04140.B26853D5; Mon, 22
        Jul 2019 10:47:23 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094722eusmtip2327c554f3cf4e673095f0b1d35c08f5d~zsarM_ui11003910039eusmtip2Q;
        Mon, 22 Jul 2019 09:47:22 +0000 (GMT)
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
Subject: [PATCH v12 0/9] Exynos5 Dynamic Memory Controller driver
Date:   Mon, 22 Jul 2019 11:46:37 +0200
Message-Id: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj22znbOUqz47T8UjNYdDHLjAq+yC5CwSFSjP6ZkrNOJm0zd9LS
        SpbmdbpCy5a6LqS55sTbEgunpiPLmZcylUrRJDS1m1MhC8ntTPr3vM/le15ePhITfeZ7kbHy
        C4xCLpGKBS54/cvfXdu2ZuyODKzN8EM1mio+Gpgd56P75i4+qvg1BlDaoyoBKujQ8lCnSoZu
        jE1hqLu7mkBvUqcJ9EHpg37lDvPRu+clAmTNMwOk6W7ioUrzEIHKBnp5qLfjMPp4TSdA6SYz
        gdqmM/losb8GR819R9DHP65o/tVncHANbbhnAPT8XD5O/xhMJ+hiZS9OPysaIuhafbaAbtYa
        CDov7buAfvG9kUerjXpA11ku09Za37AV4S5BpxlpbCKj2L4/yuXs+/mk8yOhl1ItdTwlUB/I
        Ac4kpHZB0/RjQQ5wIUWUDsAX+mGcG2YBVD2p5HGDFUB1VgOxHJks/eQQygHUTk7ZBXukdArL
        ASQpoAJggz7eRntQGgCLJ47b/Bg1ikF1ZQmwCe5UMBwZLrNjnNoAi01jfFtWSB2A91QhXNc6
        WFHdgtmykMomYWnFUx4nHIJz14cwDrvDyXajYzkfaCnIxTnMQmXeQ8DhK3Dshtbh2Qvb2nvt
        XRjlB6ueb+foYGh4MGynIeUKB7+52WhsCebX38E4WgizMkScezM05vY4llkNyw2FjsdpqG5+
        B7iDRMK+vkziJvAt+t/1AAA98GQSWFkMw+6QMxcDWImMTZDHBJyKk9WCpZ9nWWyfaQBzb6Nb
        AUUC8QphYP2uSBFfksgmyVoBJDGxh1AeuDtSJDwtSUpmFHEnFQlShm0F3iQu9hRedho5IaJi
        JBeYcwxznlEsqzzS2UsJokv8DVmDfwdMx9wvNX7VJbY3r4pLXci45ZvvnfzFkrTgFmG6m+12
        pu3o+pSU8kCVJaos59mazhnphFG3SYP3R1SrTvr5k/Hf9vzUhpsv+oRufIt1OK3VT/YUWvc1
        jmIhxNVqhWZnqryl6fb+8fEgp5aG1yvDWs0tPoawqZ9y0lOMs2clO7ZgClbyD9Bh4it1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7rabaaxBk0vdS02zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFkuvX2SyuHjK1eJ24wo2i9a9R9gtDr9pZ7X4d20ji8X+K14W
        t3/zWXw78YjRQdJjzbw1jB7fvk5i8Xh/o5XdY3bDRRaPnbPusntsWtXJ5rF/7hp2j97md2we
        B9/tYfLo27KK0WPz6WqPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
        TJX07WxSUnMyy1KL9O0S9DKufqsseOBX0XR6M1MDY599FyMnh4SAicSrJXeYuhi5OIQEljJK
        rP55iRkiISYxad92dghbWOLPtS42iKJPjBJLWrcCdXBwsAnoSexYVQgSFxGYwyjxs2sbI4jD
        LPCbWeLg3X6wbmEBR4kH95YygtgsAqoSs/c+ZgVp5hWwl5jX7QuxQF5i9YYDzBMYeRYwMqxi
        FEktLc5Nzy020itOzC0uzUvXS87P3cQIjLhtx35u2cHY9S74EKMAB6MSD++NzSaxQqyJZcWV
        uYcYJTiYlUR48wxMY4V4UxIrq1KL8uOLSnNSiw8xmgLtnsgsJZqcD0wGeSXxhqaG5haWhubG
        5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGIMWsP9JEKr+MmP3T7/Ku4Z5/8+vTZ4k
        5LxBN75JTiP2z57Sjy6Wf3dyvJkYr/ur3vVK6PNHd5d+TpomK5q6e59VXaZ4TbLy/rIiwebk
        nZuu3ws7u8HPj0Ft7qOHW1K+tsqFX7lxMfeh9nuLaxeZn2yNjJ7JXra7u2LSn5j9My/HmesW
        brr/froSS3FGoqEWc1FxIgC5OQ5VzgIAAA==
X-CMS-MailID: 20190722094724eucas1p21d37e28f25f632081f2b0f48ace70826
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094724eucas1p21d37e28f25f632081f2b0f48ace70826
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094724eucas1p21d37e28f25f632081f2b0f48ace70826
References: <CGME20190722094724eucas1p21d37e28f25f632081f2b0f48ace70826@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v12 which only align to v5.3-rc1 where ddr header has been moved.

The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
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
v12:
- based on v5.3-rc1, where  JEDEC ddr has been moved to drivers/memory
- align to the new location of header jedec_ddr.h
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
 arch/arm/configs/exynos_defconfig             |    1 +
 drivers/memory/jedec_ddr.h                    |   61 +
 drivers/memory/of_memory.c                    |  154 ++
 drivers/memory/of_memory.h                    |   18 +
 drivers/memory/samsung/Kconfig                |   13 +
 drivers/memory/samsung/Makefile               |    1 +
 drivers/memory/samsung/exynos5422-dmc.c       | 1257 +++++++++++++++++
 17 files changed, 1933 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2-timings.txt (100%)
 rename Documentation/devicetree/bindings/{lpddr2 => ddr}/lpddr2.txt (96%)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.17.1

