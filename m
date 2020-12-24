Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D032E24AC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 07:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgLXGKW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 01:10:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57724 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727671AbgLXGKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 01:10:21 -0500
X-UUID: cdf1ae6fd10f4fdcbf5580b94c543e99-20201224
X-UUID: cdf1ae6fd10f4fdcbf5580b94c543e99-20201224
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1340448032; Thu, 24 Dec 2020 14:08:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Dec 2020 14:08:55 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 14:08:56 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH V6 00/13] Add driver for dvfsrc, support for active state of scpsys
Date:   Thu, 24 Dec 2020 14:08:41 +0800
Message-ID: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C595E3B4DDF35556E65D7FBC69EB20AFAC7CC588434B800CA5FD33B37EC97AA92000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series is based on v5.10-rc1.

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

There has a hw module "DRAM scheduler", which used to control the throughput.
The DVFSRC will collect forecast data of dram bandwidth from
SW consumers(camera/gpu...), and according the forecast to change the DRAM
frequency

2. Regualtor framework: to handle the operating voltage requirement from user or
   cosumer which not belong any power domain

Changes in V6:
* Remove the performace state support, because the request from consumer can be
replaced by using interconnect and regulator framework.
* Update the DT patches and convert them to DT schema. (Georgi)
* Modify the comment format and coding style. (Mark)

Changes in V5:
* Support more platform mt6873/mt8192
* Drop the compatible and interconnect provider node and make the parent node an
interconnect provider. (Rob/Georgi)
* Make modification of interconnect driver from coding suggestion. (Georgi)
* Move interconnect diagram into the commit text of patch. (Georgi)
* Register the interconnect provider as a platform sub-device. (Georgi)

Changes in V4:
* Add acked TAG on dt-bindings patches. (Rob)
* Declaration of emi_icc_aggregate since the prototype of aggregate function
has changed meanwhile. (Georgi)
* Used emi_icc_remove instead of icc_provider_del on probe. (Georgi)
* Add dvfsrc regulator driver into series.
* Bug fixed of mt8183_get_current_level.
* Add mutex protection for pstate operation on dvfsrc_set_performance.

Changes in V3:
* Remove RFC from the subject prefix of the series
* Combine dt-binding patch and move interconnect dt-binding document into
dvfsrc. (Rob)
* Remove unused header, add unit descirption to the bandwidth, rename compatible
name on interconnect driver. (Georgi)
* Fixed some coding style: check flow, naming, used readx_poll_timeout
on dvfsrc driver. (Ryan)
* Rename interconnect driver mt8183.c to mtk-emi.c
* Rename interconnect header mtk,mt8183.h to mtk,emi.h
* mtk-scpsys.c: Add opp table check first to avoid OF runtime parse failed

Changes in RFC V2:
* Remove the DT property dram_type. (Rob)
* Used generic dts property 'opp-level' to get the performace state. (Stephen)
* Remove unecessary dependency config on Kconfig. (Stephen)
* Remove unused header file, fixed some coding style issue, typo,
error handling on dvfsrc driver. (Nicolas/Stephen)
* Remove irq handler on dvfsrc driver. (Stephen)
* Remove init table on dvfsrc driver, combine hw init on trustzone.
* Add interconnect support of mt8183 to aggregate the emi bandwidth.
(Georgi)

V5: https://patchwork.kernel.org/project/linux-mediatek/list/?series=348065
V4: https://lore.kernel.org/patchwork/cover/1209284/
V3: https://patchwork.kernel.org/cover/11118867/
RFC V2: https://lore.kernel.org/patchwork/patch/1068113/
RFC V1: https://lore.kernel.org/patchwork/cover/1028535/

