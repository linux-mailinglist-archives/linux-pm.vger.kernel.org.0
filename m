Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44114F86
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEFPMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49949 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFPMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151212euoutp0299b832c7c8e90143c829961851340344~cILTQhlqZ3068630686euoutp02G
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151212euoutp0299b832c7c8e90143c829961851340344~cILTQhlqZ3068630686euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155532;
        bh=Mr3BTXkEo4FT929+iblNccVc2ks6Sb4kT7Jp1aHJ1a8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iqdqa5aii/AbdDQImq2YVtZ1Ed4v25h7bY6pNY6WtNzLoFyT1DY1HX3e6ds3Y+iQn
         q2VY0UofoE39ePlCy7Fot6+R8dvWMggCu3CPimTJW5aoT7GfvS19oZeSatEvqUm7PN
         w7COG7ilcycNdmFpPyEdRyWV8fM10yHm6ENGHUBQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151211eucas1p262e9330d1654cd99d906c06f0ce7b7d9~cILSNbRPh1352413524eucas1p2C;
        Mon,  6 May 2019 15:12:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.A3.04377.ACE40DC5; Mon,  6
        May 2019 16:12:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151210eucas1p2c0821ddc691b150725b38398295f8d9b~cILRa-BLQ1252112521eucas1p26;
        Mon,  6 May 2019 15:12:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151209eusmtrp2f7e54960ffbd3f1c1beca121faf796b6~cILRMwL0E0409004090eusmtrp2-;
        Mon,  6 May 2019 15:12:09 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-75-5cd04eca2b8b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 00.4B.04140.9CE40DC5; Mon,  6
        May 2019 16:12:09 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151209eusmtip106dc7a14693d2d46cb6df453a53e8e9e~cILQb6ucn0052300523eusmtip1e;
        Mon,  6 May 2019 15:12:09 +0000 (GMT)
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
Subject: [PATCH v7 0/13] Exynos5 Dynamic Memory Controller driver
Date:   Mon,  6 May 2019 17:11:48 +0200
Message-Id: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeyxVcQDH/e45597jrmunw/JbyR/XWulBrK3fqhlW26mZMX+0dJMjJ5R7
        cQ9K2rqSNzHNI49JtthNo5vklecd5q0yFUrpsbyqXRSKXIf13+f3+75+f/xIjH5KbCeDVOGc
        WsUGy8VSvLp9sf9Al/uA4mB7li16nFtBoOG5rwQq0vcR6OHPCYDudBWKUE+KEqVPTGGov79S
        gnpvTkvQW40VellXIEaGND1Auf2NIvRIPyZBIzFlYtQ2nUCgplen0MiyGVro/AiczZmF+Uyc
        ydcM4kxt3piE0WmTxExa7KyYaZltEDG3q7SAedIdzRh01h6m3tJj/lxwUCSntnfylQYOTerw
        0NvoavpYAtCA+v3JwJSE1CF4d6aZSAZSkqbKANSPZuNGgabmAOyMCxEEA4DFCy2SzUR5VwwQ
        hFIASz4/wIXDWuJDd+yaQpJiyg7WaMOMAQsqGo4ON2FGD0ZNi2Dv0u/1CXPKBQ4P9KwzTu2C
        i0PJmJFl1ClY9q0PE9as4Zu+pPUwpNolMMWQgRsHIHUcxsVfFDzmcLKjauN1VnC1tkgkMA81
        acVA4OtwIr1ww3MUtnUMEsYajLKFFXX2QqML1Je5C2gGX89sNZqxNcyszsGEaxlMjKeFjj2w
        KnVgY2cbLC3P3uhmYP5y4no3TZ2DBamKDGCd93/pHgBaYMlF8MoAjndUcVfseFbJR6gC7C6E
        KHVg7TN1r3TM1YC6P36tgCKBfIssw3VAQRNsJB+lbAWQxOQWMvZLn4KW+bNR1zh1yHl1RDDH
        t4IdJC63lEWbjJ+lqQA2nLvMcaGcelMVkabbNSAs78eJvzbzDtGVux18psXNyd5+XlFf6mbu
        p5ZUfieeB6dVxD+7X7LPye1ijs3kvitBzjWGud6QMyoV+6KRzrKo90DEkiJz2fG4z4qnWeRp
        bb7qsbPOYcnX9Zdnscknt/E9vodXg7L+HvkkvRXvybyXer8DN7w+Ejunjj5vwEZOXpLjfCDr
        sBdT8+w/TNfOBUgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xu7on/S7EGEx/bmKxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextVXm1gK+iwq+u+2MzYw7tbpYuTkkBAwkVhzqpGx
        i5GLQ0hgKaPEso23WSASYhKT9m1nh7CFJf5c62KDKPrEKLHozQwgh4ODTUBPYseqQpAaEYF6
        if43l8BqmAUamCXWbL/KCpIQFnCUuH7hDNhQFgFViZ9Xu5hBbF4BL4kVL88xQyyQk7h5rpN5
        AiPPAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGxse3Yzy07GLveBR9iFOBgVOLhfWB7
        IUaINbGsuDL3EKMEB7OSCG/is3MxQrwpiZVVqUX58UWlOanFhxhNgZZPZJYSTc4Hxm1eSbyh
        qaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGrLyMx/J5Kad4dvt4XZOa
        vi7trqXBk5ehzG38zu9u7Ks4V2B1ISkp5eHuox8f/Cu1cSk4vb35taRS5XJXnTffGi6In+2s
        q7y1/8n24KzH5oUibmL9HGdti9V2JTuHK/i4PNslkK7+/+BLtiks9+eylE9lvOc3N+fzunvv
        bFZZ17yWeelgdu6LEktxRqKhFnNRcSIA8SFvoqMCAAA=
X-CMS-MailID: 20190506151210eucas1p2c0821ddc691b150725b38398295f8d9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151210eucas1p2c0821ddc691b150725b38398295f8d9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151210eucas1p2c0821ddc691b150725b38398295f8d9b
References: <CGME20190506151210eucas1p2c0821ddc691b150725b38398295f8d9b@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is v7 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
There is also new generic code in of_memory and headers which allows to parse
LPDDR3 memories defined in device-tree.

The patch set depends on changes to Exynos PPMU v3 [1] or newer:
'Exynos Performance Monitoring Counters enhancements'

changes:
v7:
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

 .../devicetree/bindings/ddr/lpddr2-timings.txt     |   52 +
 Documentation/devicetree/bindings/ddr/lpddr2.txt   |  102 ++
 .../devicetree/bindings/ddr/lpddr3-timings.txt     |   58 +
 Documentation/devicetree/bindings/ddr/lpddr3.txt   |   97 ++
 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 -
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 --
 .../bindings/memory-controllers/exynos5422-dmc.txt |   74 +
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5.dtsi                     |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  121 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  122 ++
 arch/arm/boot/dts/exynos5800.dtsi                  |    2 +-
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   75 +-
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/memory/of_memory.c                         |  148 ++
 drivers/memory/of_memory.h                         |   20 +-
 drivers/memory/samsung/Kconfig                     |   17 +
 drivers/memory/samsung/Makefile                    |    1 +
 drivers/memory/samsung/exynos5422-dmc.c            | 1761 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   28 +-
 include/memory/jedec_ddr.h                         |   62 +
 22 files changed, 2744 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
 delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.7.4

