Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904D934400E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 12:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVLna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 07:43:30 -0400
Received: from m12-16.163.com ([220.181.12.16]:50673 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCVLnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 07:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=EFaLyKkDHtOT5zlDgy
        DGUA1PT4AqFIHW/Lj7odhIEJ0=; b=XgEDdDZnaVDc918qWvxMWUpwL/yVRrx2MX
        kQbZWSzKrQ/Ty+PImATkF2phl2bM/uFXbiaLLTxqK13CzmmzhUJ+wXT/9DO6sK4G
        dHRylkD3KG+BDbYMFU2iUlbjrsbYo2KL1XHIUntPxaTyKTUF50VaY9phSklQCUtm
        tFvNC1FNM=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowACHjiqzglhgjcd6hw--.11033S2;
        Mon, 22 Mar 2021 19:42:56 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     sre@kernel.org, liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com,
        dongjian <dongjian@yulong.com>
Subject: [PATCH] power: reset: remove Unneeded semicolon
Date:   Mon, 22 Mar 2021 19:42:27 +0800
Message-Id: <1616413347-149266-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: EMCowACHjiqzglhgjcd6hw--.11033S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF48tF1rKF45KFWfuw4kZwb_yoW3XFc_Ja
        y7JrWfKF93W3Wj9rZxAayfuryF9Fy29F4SvF4Igry3Cry3Xw1DGr1kZr1jkF1DWw1UZr98
        GFy8J39xZFyfujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0oq2tUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiTABd3VSIm+7-vQAAsn
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dongjian <dongjian@yulong.com>

Fixes coccicheck warning:
drivers/power/reset/vexpress-poweroff.c:136:2-3: Unneeded semicolon

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/power/reset/vexpress-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 1fdbcbd..447ffda 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -133,7 +133,7 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	case FUNC_REBOOT:
 		ret = _vexpress_register_restart_handler(&pdev->dev);
 		break;
-	};
+	}
 
 	return ret;
 }
-- 
1.9.1


