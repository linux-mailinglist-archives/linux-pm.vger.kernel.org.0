Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717B740C413
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhIOLFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 07:05:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64028 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232468AbhIOLFk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 07:05:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F6h4oX016932;
        Wed, 15 Sep 2021 07:04:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b301k390t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 07:04:20 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 18FB4JIb056036
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:04:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Wed, 15 Sep 2021
 07:04:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Wed, 15 Sep 2021 07:04:18 -0400
Received: from ramonaalexandra-Precision-5520.ad.analog.com ([10.48.65.154])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18FB4HnH006137;
        Wed, 15 Sep 2021 07:04:17 -0400
From:   Ramona Alexandra Nechita <ramona.nechita@analog.com>
To:     <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>, <linux-kernel@vger.kernel.org>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>
Subject: [PATCH] power: supply: Specify variations of MAX8903
Date:   Wed, 15 Sep 2021 14:03:40 +0300
Message-ID: <20210915110340.17411-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ReiOQsyhmahstBOD3o8em38sG9wanA9L
X-Proofpoint-GUID: ReiOQsyhmahstBOD3o8em38sG9wanA9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_02,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=998 mlxscore=0 phishscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150072
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MAX8903 has multiple variations (A-E/G/H/J/N/Y).
Specified them in the Kconfig and in the file comment.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/power/supply/Kconfig           | 2 +-
 drivers/power/supply/max8903_charger.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c84a7b1caeb6..cca779480b1c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -442,7 +442,7 @@ config CHARGER_ISP1704
 	  ISP1707/ISP1704 USB transceivers.
 
 config CHARGER_MAX8903
-	tristate "MAX8903 Battery DC-DC Charger for USB and Adapter Power"
+	tristate "MAX8903A/B/C/D/E/G/H/J/N/Y Battery DC-DC Charger for USB and Adapter Power"
 	help
 	  Say Y to enable support for the MAX8903 DC-DC charger and sysfs.
 	  The driver supports controlling charger-enable and current-limit
diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index 0bd39b0cc257..4e5c669e6607 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * max8903_charger.c - Maxim 8903 USB/Adapter Charger Driver
+ * max8903_charger.c - Maxim 8903A/B/C/D/E/G/H/J/N/Y USB/Adapter Charger Driver
  *
  * Copyright (C) 2011 Samsung Electronics
  * MyungJoo Ham <myungjoo.ham@samsung.com>
-- 
2.25.1

