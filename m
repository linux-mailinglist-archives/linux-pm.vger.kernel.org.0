Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4AD232B8F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 07:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG3Fwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 01:52:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3Fwl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 01:52:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B3F6BC4A0DFB5A49D45D;
        Thu, 30 Jul 2020 13:52:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Jul 2020 13:52:29 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <sre@kernel.org>
CC:     <john.garry@huawei.com>, <linux-pm@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [RFC PATCH] PM:runtime:Remove the link state check in function rpm_get_supplier()
Date:   Thu, 30 Jul 2020 13:48:49 +0800
Message-ID: <1596088129-88814-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

To support runtime PM for hisi SAS driver (the dirver is in directory
drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
(consumer device) and hisi_hba->dev(supplier device) with flags
DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
After runtime suspended consumers and supplier, unload the dirver which
cause a hung. We find that it calls function device_release_driver_internal()
to release supplier device hisi_hba->dev, as the device link is busy, 
it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
device_release_driver_internal() to release consumer device
scsi_device->sdev_gendev). Then It will try to call pm_runtime_get_sync()
to resume consumer device, as consumer-supplier relation exists, it will try
to resume supplier first, but as the link state is already set as 
DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume 
consumer which cause a hung (it sends IOs to resume scsi_device while 
SAS controller is suspended). Simple flow is as follows:

device_release_driver_internal -> (supplier device)
    if device_links_busy ->
	    device_links_unbind_consumers ->
		...
		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
		device_release_driver_internal (consumer device)
    pm_runtime_get_sync -> (consumer device)
	...
	__rpm_callback ->
	    rpm_get_suppliers ->
		if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
		...
    pm_runtime_clean_up_links
    ...

It should guarantee correct suspend/resume ordering between a supplier
device and its consumer devices (resume the supplier device before resuming
consumer devices, and suspend consumer devices before suspending supplier
device) for runtime PM, but it seems the check in rpm_get_supplier() breaks 
the rule, so remove it.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/base/power/runtime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9f62790..a8edd92 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
 				device_links_read_lock_held()) {
 		int retval;
 
-		if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
-		    READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
+		if (!(link->flags & DL_FLAG_PM_RUNTIME))
 			continue;
 
 		retval = pm_runtime_get_sync(link->supplier);
-- 
2.8.1

