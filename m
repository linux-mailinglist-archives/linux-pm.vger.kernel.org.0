Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CB39B717
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFDKcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:32:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230019AbhFDKcF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:32:05 -0400
X-UUID: 5276b84daedb47eeb47fe31345d17f1b-20210604
X-UUID: 5276b84daedb47eeb47fe31345d17f1b-20210604
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 656624887; Fri, 04 Jun 2021 18:30:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Jun 2021 18:30:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 18:30:11 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH 00/12] Add driver for dvfsrc, support for interconnect
Date:   Fri, 4 Jun 2021 18:29:47 +0800
Message-ID: <20210604102959.13807-1-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series is based on v5.13-rc1.

The patchsets add support for MediaTek hardware module named DVFSRC
(dynamic voltage and frequency scaling resource collector). The DVFSRC is
a HW module which is used to collect all the requests from both software
and hardware and turn into the decision of minimum operating voltage and
minimum DRAM frequency to fulfill those requests.

So, This series is to implement the dvfsrc driver to collect all the
requests of operating voltage or DRAM bandwidth from other device drivers
likes GPU/Camera through 3 frameworks basically:

1. interconnect framework: to aggregate the bandwidth
   requirements from different clients

[1] https://patchwork.kernel.org/cover/10766329/

There has a hw module "DRAM scheduler", which used to control the
throughput.
The DVFSRC will collect forecast data of dram bandwidth from
SW consumers(camera/gpu...), and according the forecast to change the DRAM
frequency

2. Regualtor framework: to handle the operating voltage requirement from
   user or cosumer which not belong any power domain

Changes in V10:
* rebase all patches on v5.13-rc1
* add acked TAG for interconnect provider driver (Georgi)
* update comment message for typos. (Georgi)
* update cover leter for typos.

Changes in V9:
* modify the configuration of dvfsrc.yaml. (Rob)

Changes in V8:
* Fixed the dt_binding_check error of dvfsrc.yaml. (Rob)
* Remove Kconfig dependency of DVFSRC

Changes in V7:
* Fixed the dt_binding_check error of dvfsrc.yaml. (Rob)
* Fixed the checkpatch complains of "Signed-off-by:
email name mismatch". (Georgi)
* Fixed coding style of interconnect driver. (Georgi)
* Update comment of the years to 2021. (Georgi)

Changes in V6:
* Remove the performace state support, because the request from consumer
can be replaced by using interconnect and regulator framework.
* Update the DT patches and convert them to DT schema. (Georgi)
* Modify the comment format and coding style. (Mark)

Changes in V5:
* Support more platform mt6873/mt8192
* Drop the compatible and interconnect provider node and make the parent
node an interconnect provider. (Rob/Georgi)
* Make modification of interconnect driver from coding suggestion. (Georgi)
* Move interconnect diagram into the commit text of patch. (Georgi)
* Register the interconnect provider as a platform sub-device. (Georgi)

Changes in V4:
* Add acked TAG on dt-bindings patches. (Rob)
* Declaration of emi_icc_aggregate since the prototype of aggregate
function has changed meanwhile. (Georgi)
* Used emi_icc_remove instead of icc_provider_del on probe. (Georgi)
* Add dvfsrc regulator driver into series.
* Bug fixed of mt8183_get_current_level.
* Add mutex protection for pstate operation on dvfsrc_set_performance.

Changes in V3:
* Remove RFC from the subject prefix of the series
* Combine dt-binding patch and move interconnect dt-binding document into
dvfsrc. (Rob)
* Remove unused header, add unit descirption to the bandwidth, rename
compatible name on interconnect driver. (Georgi)
* Fixed some coding style: check flow, naming, used readx_poll_timeout
on dvfsrc driver. (Ryan)
* Rename interconnect driver mt8183.c to mtk-emi.c
* Rename interconnect header mtk,mt8183.h to mtk,emi.h
* mtk-scpsys.c: Add opp table check first to avoid OF runtime parse failed

Changes in RFC V2:
* Remove the DT property dram_type. (Rob)
* Used generic dts property 'opp-level' to get the performace
state. (Stephen)
* Remove unnecessary dependency config on Kconfig. (Stephen)
* Remove unused header file, fixed some coding style issue, typo,
error handling on dvfsrc driver. (Nicolas/Stephen)
* Remove irq handler on dvfsrc driver. (Stephen)
* Remove init table on dvfsrc driver, combine hw init on trustzone.
* Add interconnect support of mt8183 to aggregate the emi bandwidth.
(Georgi)

V9: https://patchwork.kernel.org/project/linux-mediatek/list/?series=440389
V8: https://patchwork.kernel.org/project/linux-mediatek/list/?series=421713
V7: https://patchwork.kernel.org/project/linux-mediatek/list/?series=411057
V6: https://patchwork.kernel.org/project/linux-mediatek/list/?series=406077
V5: https://patchwork.kernel.org/project/linux-mediatek/list/?series=348065
V4: https://lore.kernel.org/patchwork/cover/1209284/
V3: https://patchwork.kernel.org/cover/11118867/
RFC V2: https://lore.kernel.org/patchwork/patch/1068113/
RFC V1: https://lore.kernel.org/patchwork/cover/1028535/

Henry Chen (12):
  dt-bindings: soc: Add dvfsrc driver bindings
  soc: mediatek: add header for mediatek SIP interface
  soc: mediatek: add driver for dvfsrc support
  soc: mediatek: add support for mt6873
  arm64: dts: mt8183: add dvfsrc related nodes
  arm64: dts: mt8192: add dvfsrc related nodes
  dt-bindings: interconnect: add MT6873 interconnect dt-bindings
  interconnect: mediatek: Add interconnect provider driver
  arm64: dts: mt8183: add dvfsrc related nodes
  arm64: dts: mt8192: add dvfsrc related nodes
  arm64: dts: mt8183: add dvfsrc regulator nodes
  arm64: dts: mt8192: add dvfsrc regulator nodes

 .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   |  67 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  13 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  14 +
 drivers/interconnect/Kconfig                       |   1 +
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/mediatek/Kconfig              |  13 +
 drivers/interconnect/mediatek/Makefile             |   3 +
 drivers/interconnect/mediatek/mtk-emi.c            | 331 +++++++++++++
 drivers/soc/mediatek/Kconfig                       |  11 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c                  | 535 +++++++++++++++++++++
 include/dt-bindings/interconnect/mtk,mt6873-emi.h  |  41 ++
 include/dt-bindings/interconnect/mtk,mt8183-emi.h  |  21 +
 include/linux/soc/mediatek/mtk_dvfsrc.h            |  35 ++
 include/linux/soc/mediatek/mtk_sip_svc.h           |   4 +
 15 files changed, 1091 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 include/dt-bindings/interconnect/mtk,mt6873-emi.h
 create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
 create mode 100644 include/linux/soc/mediatek/mtk_dvfsrc.h

-- 
2.14.1

