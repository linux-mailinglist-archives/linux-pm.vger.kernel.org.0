Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691F52742BD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVNPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 09:15:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbgIVNPF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 09:15:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0103ED8066E011E2E3F5;
        Tue, 22 Sep 2020 21:15:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 21:14:53 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <sre@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-pm@vger.kernel.org>,
        <john.garry@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH v2] PM:runtime:Remove the link state check in function rpm_get_supplier() and rpm_put_supplier()
Date:   Tue, 22 Sep 2020 21:11:06 +0800
Message-ID: <1600780266-155908-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

To support runtime PM for hisi SAS driver (the driver is in directory
drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
(consumer device) and hisi_hba->dev(supplier device) with flags
DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
After runtime suspended consumers and supplier, unload the dirver which
cause a hung. We find that it calls function device_release_driver_internal()
to release supplier device hisi_hba->dev, as the device link is busy,
it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
device_release_driver_internal() to release consumer device
scsi_device->sdev_gendev). Then it will try to call pm_runtime_get_sync()
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
device) for runtime PM, but it seems the checks in rpm_get_supplier() and
rpm_put_supplier() break the rule, so remove them.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/base/power/runtime.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8143210..6f605f7 100644
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
@@ -312,8 +311,6 @@ static void rpm_put_suppliers(struct device *dev)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held()) {
-		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
-			continue;
 
 		while (refcount_dec_not_one(&link->rpm_active))
 			pm_runtime_put(link->supplier);
-- 
2.8.1

