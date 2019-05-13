Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA951B782
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfEMN4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 09:56:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfEMN4P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 09:56:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7B970CC575E000F61F42;
        Mon, 13 May 2019 21:56:09 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 21:56:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] thermal: tegra: Make tegra210_tsensor_thermtrips static
Date:   Mon, 13 May 2019 21:55:59 +0800
Message-ID: <20190513135559.43836-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix sparse warning:

drivers/thermal/tegra/tegra210-soctherm.c:211:33: warning:
 symbol 'tegra210_tsensor_thermtrips' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/tegra/tegra210-soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d31b500..d0ff793 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -208,7 +208,7 @@ static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
 	.fuse_spare_realignment = 0,
 };
 
-struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
+static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] = {
 	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
 	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
 	{.id = TEGRA124_SOCTHERM_SENSOR_NUM},
-- 
2.7.4


