Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6D35AAAF
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 06:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDJENM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Apr 2021 00:13:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17302 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhDJENM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Apr 2021 00:13:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FHM431h0Lz9xVG;
        Sat, 10 Apr 2021 12:10:43 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 12:12:49 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <linqiheng@huawei.com>, Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] power: supply: Make symbol 'surface_ac_pm_ops' static
Date:   Sat, 10 Apr 2021 12:12:49 +0800
Message-ID: <20210410041249.12846-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sparse tool complains as follows:

drivers/power/supply/surface_charger.c:229:1: warning:
 symbol 'surface_ac_pm_ops' was not declared. Should it be static?

This symbol is not used outside of surface_charger.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/power/supply/surface_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index c2dd7e604d14..81a5b79822c9 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -226,7 +226,7 @@ static int __maybe_unused surface_ac_resume(struct device *dev)
 {
 	return spwr_ac_recheck(dev_get_drvdata(dev));
 }
-SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
+static SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
 
 static int surface_ac_probe(struct ssam_device *sdev)
 {

