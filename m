Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D698C3FA654
	for <lists+linux-pm@lfdr.de>; Sat, 28 Aug 2021 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhH1PCO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Aug 2021 11:02:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51226 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229799AbhH1PCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Aug 2021 11:02:09 -0400
X-UUID: 3d2bd27b280b4d1b9955348bd6d2f68b-20210828
X-UUID: 3d2bd27b280b4d1b9955348bd6d2f68b-20210828
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1609193618; Sat, 28 Aug 2021 23:01:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 28 Aug 2021 23:01:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 28 Aug 2021 23:01:15 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v14] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Sat, 28 Aug 2021 23:01:09 +0800
Message-ID: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPUfreq HW present in some Mediatek chipsets offloads the steps necessary for changing the frequency of CPUs. 
The driver implements the cpufreq driver interface for this hardware engine. 

From v13 to v14, there are three modifications.
1. Replace cpu domain map to policy driver data 
2. Remove dummy performance-domain parsing
3. Separate modification in cpufreq.h to another patch

From v12 to v13, there are two modifications.
1. Move related_cpus function to common place, so all performance-domain cpufreq driver can refer.
2. Make cpu resource init to each policy rather than per-cpu

From v11 to v12, there are two modifications.
1. Based on patchset[1], align binding with scmi for performance domain(latest version).
2. Shrink binding example wording. 

From v8 to v9, there are three more modifications.
1. Based on patchset[2], align binding with scmi for performance domain.
2. Add the CPUFREQ fast switch function support and define DVFS latency.
3. Based on patchser[3], add energy model API parameter for mW.

From v7 to v8, there are three more patches based on patchset v8[4].
This patchset is about to register power table to Energy model for EAS and thermal usage.
1. EM CPU power table
- Register energy model table for EAS and thermal cooling device usage.
- Read the coresponding LUT for power table.
2. SVS initialization
- The SVS(Smart Voltage Scaling) engine is a hardware which is
  used to calculate optimized voltage values for CPU power domain.
  DVFS driver could apply those optimized voltage values to reduce power consumption.
- Driver will polling if HW engine is done for SVS initialization.
  After that, driver will read power table and register it to EAS.
- CPUs must be in power on state when doing SVS. Use pm_qos to block cpu-idle state for SVS initializing.
3. Cooling device flag
- Add cooling device flag for thermal
[1]  https://lore.kernel.org/linux-devicetree/20210517155458.1016707-1-sudeep.holla@arm.com/
[2]  https://lore.kernel.org/lkml/20201116181356.804590-1-sudeep.holla@arm.com/
[3]  https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c250d50fe2ce627ca9805d9c8ac11cbbf922a4a6
[4]  https://lkml.org/lkml/2020/9/23/384


Hector.Yuan (3):
  ndings: cpufreq: add bindings for MediaTek cpufreq HW
  cpufreq: Add of_perf_domain_get_sharing_cpumask
  cpufreq: mediatek-hw: Add support for CPUFREQ HW

 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml |  70 ++++
 drivers/cpufreq/Kconfig.arm                   |  12 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/mediatek-cpufreq-hw.c         | 319 ++++++++++++++++++
 include/linux/cpufreq.h                       |  39 +++
 5 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
 create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c

