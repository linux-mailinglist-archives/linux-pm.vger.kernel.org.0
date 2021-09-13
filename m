Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354CB409ACA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbhIMRjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:39:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43548 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243680AbhIMRjk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4890A1A039A;
        Mon, 13 Sep 2021 19:38:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A66C1A0394;
        Mon, 13 Sep 2021 19:38:23 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 63C2020363;
        Mon, 13 Sep 2021 19:38:22 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 01/19] dt-bindings: interconnect: imx8mq: Add missing pl301 and SAI ids
Date:   Mon, 13 Sep 2021 20:37:56 +0300
Message-Id: <1631554694-9599-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the bus diagram, there are two more pl301s that need to
be added here. The pl301_per_m which is an intermediary node between
pl301_main and its masters: usdhc1, usdhc2 and sdma. The pl301_wakeup
is an intermediary node between pl301_main and its masters, in this case
all the SAIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/dt-bindings/interconnect/imx8mq.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/interconnect/imx8mq.h b/include/dt-bindings/interconnect/imx8mq.h
index 1a4cae7f8be2..1953de8af5cb 100644
--- a/include/dt-bindings/interconnect/imx8mq.h
+++ b/include/dt-bindings/interconnect/imx8mq.h
@@ -44,5 +44,14 @@
 #define IMX8MQ_ICM_PCIE1	26
 #define IMX8MQ_ICM_PCIE2	27
 #define IMX8MQ_ICN_MAIN		28
+#define IMX8MQ_ICN_PER_M	30
+
+#define IMX8MQ_ICN_WAKEUP	31
+#define IMX8MQ_ICM_SAI1		32
+#define IMX8MQ_ICM_SAI2		33
+#define IMX8MQ_ICM_SAI3		34
+#define IMX8MQ_ICM_SAI4		35
+#define IMX8MQ_ICM_SAI5		36
+#define IMX8MQ_ICM_SAI6		37
 
 #endif /* __DT_BINDINGS_INTERCONNECT_IMX8MQ_H */
-- 
2.31.1

