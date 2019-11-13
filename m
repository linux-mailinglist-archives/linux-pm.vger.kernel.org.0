Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E253FBC73
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 00:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfKMXVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 18:21:43 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56004 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKMXVm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 18:21:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1E051A03DB;
        Thu, 14 Nov 2019 00:21:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 940B61A0117;
        Thu, 14 Nov 2019 00:21:40 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 245B8205D5;
        Thu, 14 Nov 2019 00:21:40 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH 4/5] PM / devfreq: Don't use devm on parent device
Date:   Thu, 14 Nov 2019 01:21:34 +0200
Message-Id: <68ebb238c57c5a7f7c6f62860ef02b033e2e21be.1573686315.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573686315.git.leonard.crestez@nxp.com>
References: <cover.1573686315.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1573686315.git.leonard.crestez@nxp.com>
References: <cover.1573686315.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In theory a driver can call devfreq_add_device, get an error in return
and still probe succesfuly. If this happens the freq_table allocated by
set_freq_table is effectively leaked.

Now that device_initialize is called early inside devfreq_add_device we
can use devm on devfreq->dev inside set_freq_table instead. Since that's
always freed if devfreq_add_device fails there is no need to devm_kfree
on any path.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b38e98853fda..2a035374ae74 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -166,11 +166,11 @@ static int set_freq_table(struct devfreq *devfreq)
 	count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
 	if (count <= 0)
 		return -EINVAL;
 
 	profile->max_state = count;
-	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
+	profile->freq_table = devm_kcalloc(&devfreq->dev,
 					profile->max_state,
 					sizeof(*profile->freq_table),
 					GFP_KERNEL);
 	if (!profile->freq_table) {
 		profile->max_state = 0;
@@ -178,11 +178,10 @@ static int set_freq_table(struct devfreq *devfreq)
 	}
 
 	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
 		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
 		if (IS_ERR(opp)) {
-			devm_kfree(devfreq->dev.parent, profile->freq_table);
 			profile->max_state = 0;
 			return PTR_ERR(opp);
 		}
 		dev_pm_opp_put(opp);
 		profile->freq_table[i] = freq;
-- 
2.17.1

