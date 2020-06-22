Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E537B203305
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgFVJNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 05:13:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgFVJNI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jun 2020 05:13:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 133E22A42351A0C15BB4;
        Mon, 22 Jun 2020 17:13:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 22 Jun 2020 17:12:59 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>
CC:     <john.garry@huawei.com>, <linux-pm@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] hibernate: fix some format issues
Date:   Mon, 22 Jun 2020 17:09:13 +0800
Message-ID: <1592816953-204427-1-git-send-email-chenxiang66@hisilicon.com>
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

In hibernate.c, some places lack of spaces while some places have
redundant spaces. So fix them.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 kernel/power/hibernate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 02ec716..5714f51 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1062,7 +1062,7 @@ power_attr(disk);
 static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
+	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
 		       MINOR(swsusp_resume_device));
 }
 
@@ -1162,7 +1162,7 @@ static ssize_t reserved_size_store(struct kobject *kobj,
 
 power_attr(reserved_size);
 
-static struct attribute * g[] = {
+static struct attribute *g[] = {
 	&disk_attr.attr,
 	&resume_offset_attr.attr,
 	&resume_attr.attr,
@@ -1190,7 +1190,7 @@ static int __init resume_setup(char *str)
 	if (noresume)
 		return 1;
 
-	strncpy( resume_file, str, 255 );
+	strncpy(resume_file, str, 255);
 	return 1;
 }
 
-- 
2.8.1

