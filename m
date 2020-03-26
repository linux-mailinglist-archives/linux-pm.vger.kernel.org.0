Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2311935AA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 03:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgCZCQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 22:16:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37264 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgCZCQ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 22:16:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FE2C1A078A;
        Thu, 26 Mar 2020 03:16:25 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 923B41A0785;
        Thu, 26 Mar 2020 03:16:25 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 80CBB203CD;
        Thu, 26 Mar 2020 03:16:24 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Martin Kepplinger <martink@posteo.de>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8] interconnect: Add imx support via devfreq
Date:   Thu, 26 Mar 2020 04:16:12 +0200
Message-Id: <cover.1585188174.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds interconnect scaling support for imx8m series chips. It uses a
per-SOC interconnect provider layered on top of multiple instances of devfreq
for scalable nodes along the interconnect.

Existing qcom interconnect providers mostly translate bandwidth requests into
firmware calls but equivalent firmware on imx8m is much thinner. Scaling
support for individual nodes is implemented as distinct devfreq drivers
instead.

The imx interconnect provider doesn't communicate with devfreq directly
but rather computes "minimum frequencies" for nodes along the path and
creates dev_pm_qos requests.

Since there is no single devicetree node that can represent the
"interconnect" the main NOC is picked as the "interconnect provider" and
will probe the interconnect platform device if #interconnect-cells is
present. This avoids introducing "virtual" devices but it means that DT
bindings of main NOC includes properties for both devfreq and
interconnect.

Only the ddrc and main noc are scalable right now but more can be added.

Also available on a github branch (with various unrelated changes):
	https://github.com/cdleonard/linux/tree/next
Testing currently requires NXP branch of atf+uboot

Martin: I believe you should be able to use this to control DRAM
frequency from video by just adding interconnect consumer code to
nwl-dsi. Sample code:
	https://github.com/cdleonard/linux/commit/43772762aa5045f1ce5623740f9a4baef988d083
	https://github.com/cdleonard/linux/commit/7b601e981b1f517b5d98b43bde292972ded13086

Changes since RFCv6:
* Replace scalable-nodes stuff with just a fsl,ddrc property. Future
scalable nodes can be added as additional phandles on the NOC
* Allow building interconnect drivers as modules
* Handle icc_provider_del errors in imx_icc_unregister (like EBUSY).
* Rename imx-devfreq to imx-bus, similar to exynos-bus
* Explain why imx bus clock enabling is not required
* All dependencies accepted (some time ago).
Link: https://patchwork.kernel.org/cover/11244421/

Changes since RFCv5:
* Replace scanning for interconnect-node-id with explicit
scalable-nodes/scalable-node-ids property on NoC.
* Now passes make `dtbs_check`
* Remove struct imx_icc_provider
* Switch to of_icc_xlate_onecell
* Use of_find_device_by_node to fetch QoS target, this causes fewer probe
deferrals, removes dependency on devfreq API and even allows reloading ddrc
module at runtime
* Add imx_icc_node_destroy helper
* Remove 0/1 on DEFINE_BUS_SLAVE/MASTER which created spurious links
Link: https://patchwork.kernel.org/cover/11222015/

Changes since RFCv4:
* Drop icc proxy nonsense
* Make devfreq driver for NOC probe the ICC driver if
#interconnect-cells is present
* Move NOC support to interconnect series and rename the node in DT
* Add support for all chips at once, differences are not intereseting
and there is more community interest for 8mq than 8mm.
Link: https://patchwork.kernel.org/cover/11111865/

Changes since RFCv3:
* Remove the virtual "icc" node and add devfreq nodes as proxy providers
* Fix build on 32-bit arm (reported by kbuilt test robot)
* Remove ARCH_MXC_ARM64 (never existed in upstream)
* Remove _numlinks, calculate instead
* Replace __BUSFREQ_H header guard
* Improve commit message and comment spelling
* Fix checkpatch issues
Link to RFCv3: https://patchwork.kernel.org/cover/11078671/

Changes since RFCv2 and initial work by Alexandre Bailon:
* Relying on devfreq and dev_pm_qos instead of CLK
* No more "platform opp" stuff
* No more special suspend handling: use suspend-opp on devfreq instead
* Replace all mentions of "busfreq" with "interconnect"
Link to v2: https://patchwork.kernel.org/cover/11021563/

Leonard Crestez (8):
  dt-bindings: interconnect: Add bindings for imx8m noc
  PM / devfreq: Add generic imx bus scaling driver
  PM / devfreq: imx: Register interconnect device
  interconnect: Add imx core driver
  interconnect: imx: Add platform driver for imx8mm
  interconnect: imx: Add platform driver for imx8mq
  interconnect: imx: Add platform driver for imx8mn
  arm64: dts: imx8m: Add NOC nodes

 .../bindings/interconnect/fsl,imx8m-noc.yaml  | 138 ++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  24 ++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  24 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  24 ++
 drivers/devfreq/Kconfig                       |   9 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/imx-bus.c                     | 181 +++++++++++
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/imx/Kconfig              |  17 +
 drivers/interconnect/imx/Makefile             |   9 +
 drivers/interconnect/imx/imx.c                | 298 ++++++++++++++++++
 drivers/interconnect/imx/imx.h                |  62 ++++
 drivers/interconnect/imx/imx8mm.c             | 108 +++++++
 drivers/interconnect/imx/imx8mn.c             |  97 ++++++
 drivers/interconnect/imx/imx8mq.c             | 106 +++++++
 include/dt-bindings/interconnect/imx8mm.h     |  49 +++
 include/dt-bindings/interconnect/imx8mn.h     |  41 +++
 include/dt-bindings/interconnect/imx8mq.h     |  48 +++
 19 files changed, 1238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
 create mode 100644 drivers/devfreq/imx-bus.c
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx.c
 create mode 100644 drivers/interconnect/imx/imx.h
 create mode 100644 drivers/interconnect/imx/imx8mm.c
 create mode 100644 drivers/interconnect/imx/imx8mn.c
 create mode 100644 drivers/interconnect/imx/imx8mq.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h
 create mode 100644 include/dt-bindings/interconnect/imx8mn.h
 create mode 100644 include/dt-bindings/interconnect/imx8mq.h

-- 
2.17.1

