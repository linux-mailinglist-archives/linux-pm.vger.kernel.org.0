Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C233EBC365
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391780AbfIXHwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 03:52:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49908 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbfIXHwd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 03:52:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A0B91A018B;
        Tue, 24 Sep 2019 09:52:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D02E1A0018;
        Tue, 24 Sep 2019 09:52:31 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F1E7B205E6;
        Tue, 24 Sep 2019 09:52:30 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] PM / devfreq: Lock devfreq in trans_stat_show
Date:   Tue, 24 Sep 2019 10:52:23 +0300
Message-Id: <da50e95038fea30be506daffbd7d566600589856.1569311390.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no locking in this sysfs show function so stats printing can
race with a devfreq_update_status called as part of freq switching or
with initialization.

Also add an assert in devfreq_update_status to make it clear that lock
must be held by caller.

Fixes: 39688ce6facd ("PM / devfreq: account suspend/resume for stats")
Cc: stable@vger.kernel.org
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

---
Changes since v2:
* Move assert higher
* Drop useless comment
* Add Fixes: tag and Cc: stable
Link to v2: https://patchwork.kernel.org/patch/11157315/

Changes since v1:
* Split from series: low-priority bugfix not strictly required for PM QoS
* Only keep lock during update, release before sprintf
Link to v1: https://patchwork.kernel.org/patch/11149493/

 drivers/devfreq/devfreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 072c0731659d..a2a045e117f0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -158,10 +158,11 @@ static int set_freq_table(struct devfreq *devfreq)
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev, prev_lev, ret = 0;
 	unsigned long cur_time;
 
+	lockdep_assert_held(&devfreq->lock);
 	cur_time = jiffies;
 
 	/* Immediately exit if previous_freq is not initialized yet. */
 	if (!devfreq->previous_freq)
 		goto out;
@@ -1415,16 +1416,21 @@ static ssize_t trans_stat_show(struct device *dev,
 	struct devfreq *devfreq = to_devfreq(dev);
 	ssize_t len;
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
-	if (!devfreq->stop_polling &&
-			devfreq_update_status(devfreq, devfreq->previous_freq))
-		return 0;
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
 
+	mutex_lock(&devfreq->lock);
+	if (!devfreq->stop_polling &&
+			devfreq_update_status(devfreq, devfreq->previous_freq)) {
+		mutex_unlock(&devfreq->lock);
+		return 0;
+	}
+	mutex_unlock(&devfreq->lock);
+
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
 				devfreq->profile->freq_table[i]);
-- 
2.17.1

