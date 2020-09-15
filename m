Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4642C269C4A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 05:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIODEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 23:04:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgIODEC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Sep 2020 23:04:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6D36DA49835B84F75CA4;
        Tue, 15 Sep 2020 11:04:00 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 11:03:51 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] power: avs: qcom-cpr: simplify the return expression of cpr_disable()
Date:   Tue, 15 Sep 2020 11:26:29 +0800
Message-ID: <20200915032629.1772569-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/power/avs/qcom-cpr.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index bd7c3e48b386..b24cc77d1889 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -665,8 +665,6 @@ static int cpr_enable(struct cpr_drv *drv)
 
 static int cpr_disable(struct cpr_drv *drv)
 {
-	int ret;
-
 	mutex_lock(&drv->lock);
 
 	if (cpr_is_allowed(drv)) {
@@ -676,11 +674,7 @@ static int cpr_disable(struct cpr_drv *drv)
 
 	mutex_unlock(&drv->lock);
 
-	ret = regulator_disable(drv->vdd_apc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_disable(drv->vdd_apc);
 }
 
 static int cpr_config(struct cpr_drv *drv)
-- 
2.25.1

