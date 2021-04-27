Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028336CBEF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhD0TpS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbhD0TpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:18 -0400
Date:   Tue, 27 Apr 2021 19:44:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahJHEyLsX2lTE/D7PvDCkyzY5fgthNOevel5nEBU8sU=;
        b=Xk094gpLo4h6c+zhur5it+i117/uXQGkdsHaVOL8YiNWWiaSxLztil/6eFjs0mKQZclHND
        abpvFLmiAqRGciuJny2jpXDRwQ9h0bEg/FHdatoijwZvRWaJVzF09nM2pwgdUSyEG7m23K
        qvEvF/ZPta/KvtdjbjdBT+fto/zyPvjN30UctIqtFXHjYCjRZHp97flJLVx0UEkuRCQc7U
        eFbvchdmWvqWFSuvwXJ8CM7PQs1P8T+GpxU4kKLebJ+h9ZahzC5tSVl/NqDjyhgoFPqiav
        +4/RK9Bh7Ur7YXXd5AFCRNc3lUjK+LKzgsyOA9pnmzWVTF5bN++bi+RNwwl4NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahJHEyLsX2lTE/D7PvDCkyzY5fgthNOevel5nEBU8sU=;
        b=Hxc8pzKDoVGRvmp3IEIppIRYsByVleYepIZYDJ8qGS4wnoYtlq0/eisDIcZMAN116W1Um1
        i6Q/CJqfB7XrXLBg==
From:   "thermal-bot for Ye Bin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/hisi: Remove redundant
 dev_err call in hisi_thermal_probe()
Cc:     Hulk Robot <hulkci@huawei.com>, Ye Bin <yebin10@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210409075224.2109503-1-yebin10@huawei.com>
References: <20210409075224.2109503-1-yebin10@huawei.com>
MIME-Version: 1.0
Message-ID: <161955267329.29796.10846130053666149008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     beaa41029fdea9d3e01af3a1a800538542d30869
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//beaa41029fdea9d3e01af3a1a800538542d30869
Author:        Ye Bin <yebin10@huawei.com>
AuthorDate:    Fri, 09 Apr 2021 15:52:24 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 09:18:57 +02:00

thermal/drivers/hisi: Remove redundant dev_err call in hisi_thermal_probe()

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210409075224.2109503-1-yebin10@huawei.com
---
 drivers/thermal/hisi_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d902db9..9a21ac0 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -572,10 +572,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->regs)) {
-		dev_err(dev, "failed to get io address\n");
+	if (IS_ERR(data->regs))
 		return PTR_ERR(data->regs);
-	}
 
 	ret = data->ops->probe(data);
 	if (ret)
