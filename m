Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714232FDACA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 21:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbhATU0w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 15:26:52 -0500
Received: from m12-14.163.com ([220.181.12.14]:47924 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387875AbhATN5W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 08:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hrdhG
        az8gDPEnZPEUy95ik6pEd/YqLL0i9CWiIXBNIs=; b=aA376+qLVSO1i3uSD/D77
        kraFp1GZfLCk7arOqr6OZryWcPnav/Ch5GqoCYd0N9DzL9W5OqKJQ/vhFdkj7FXu
        AXlJxlbJ3Lt++EX668A1cKUtwLdPywEs9lpzSkgAyQl6dXQLJ7dbj8XAwNr4v5Is
        UPryXjPc9XVgvAGcYpGuLs=
Received: from DONGJIAN-NJ.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowADXqeXY_QdgK0fqgw--.18973S2;
        Wed, 20 Jan 2021 17:54:40 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, dongjian@yulong.com, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: [PATCH] power-supply: Constify static psy_tzd_ops struct
Date:   Wed, 20 Jan 2021 17:54:26 +0800
Message-Id: <20210120095427.10592-1-dj0227@163.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADXqeXY_QdgK0fqgw--.18973S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF45AFy3KFy8Cr4fJFWrKrg_yoWfurgE93
        48Xw1IgrZ5WFy0yrn09w47XFy8tr17u3yfJF40qFW3tFyYq3WDZr1DWryqqF1UWrWUuFZr
        XFWqqF43tFy8WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbm9atUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/xtbBEAAg3VUMVXFi3AAAsu
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dongjian <dongjian@yulong.com>

The usage of this struct is to assign operation function's address
to the field in thermal_zone_device_ops, it is a const pointer.
make it const to allow the compiler to put it in read-only memory.

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 38e3aa64..ae34856 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -952,7 +952,7 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 	return ret;
 }
 
-static struct thermal_zone_device_ops psy_tzd_ops = {
+static const struct thermal_zone_device_ops psy_tzd_ops = {
 	.get_temp = power_supply_read_temp,
 };
 
-- 
1.9.1


