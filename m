Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A84BC291
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 09:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409303AbfIXH07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 03:26:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36486 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409268AbfIXH06 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 03:26:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C9621A00B5;
        Tue, 24 Sep 2019 09:26:57 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4ED4C1A0018;
        Tue, 24 Sep 2019 09:26:57 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D3751205E6;
        Tue, 24 Sep 2019 09:26:56 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: Check NULL governor in available_governors_show
Date:   Tue, 24 Sep 2019 10:26:53 +0300
Message-Id: <921db734cb5c92875c3f81250126e2027bf6144b.1569309756.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The governor is initialized after sysfs attributes become visible so in
theory the governor field can be NULL here.

Fixes: bcf23c79c4e46 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:
* Add Fixes tag and Reviewed-by
Link to v1: https://patchwork.kernel.org/patch/11157333/

Don't add cc: stable since it's a theoretical race condition.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b905963cea7d..60859a2400bc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1193,11 +1193,11 @@ static ssize_t available_governors_show(struct device *d,
 
 	/*
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (df->governor && df->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor_name);
 	/*
 	 * The devfreq device shows the registered governor except for
 	 * immutable governors such as passive governor .
-- 
2.17.1

