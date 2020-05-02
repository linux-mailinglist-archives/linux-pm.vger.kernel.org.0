Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20E1C285A
	for <lists+linux-pm@lfdr.de>; Sat,  2 May 2020 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgEBVUG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 17:20:06 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56916 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgEBVUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 17:20:05 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 May 2020 17:20:05 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49F1xl6CQkz9vKTk
        for <linux-pm@vger.kernel.org>; Sat,  2 May 2020 21:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1pOSXK6vAUt9 for <linux-pm@vger.kernel.org>;
        Sat,  2 May 2020 16:11:07 -0500 (CDT)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49F1xl51jjz9vKSs
        for <linux-pm@vger.kernel.org>; Sat,  2 May 2020 16:11:07 -0500 (CDT)
Received: by mail-qv1-f70.google.com with SMTP id v2so14005627qvy.1
        for <linux-pm@vger.kernel.org>; Sat, 02 May 2020 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=98Gw/YIKBAo25+eia8JVZ/k22pWYO0PDQMHyI7+B3/Y=;
        b=qiXSHn3VnvB/69IWAG+v5cQyvBCq6ZxUOeK/CmnxT5yJCxiSzFhnxlJML24aAdXu8D
         +eaj2Nsq05zO4XATqr44CfX8qbwWcBAq0IVDFn1r4Ful+yx3U24s84fh6ZYmKT5bV1wn
         TPw5LykhGf79lQojJ6PSpVILIStk9+PpXQlaCQe+ShXXT8nFkyWgmOmGucjxQsAUpLNQ
         ECn8BFafsy5uQlIZNhJVhBnNFiOKUAULkKEo55x9szxvFXUvVrT3W5GUgJawmSf0tAV/
         ppNdq0kCTqyO3v+kQbAIi7otRocRzuJ96dpQvq2WrIhPIrgnNj1aYCYJXJ37qjP2yXsI
         iPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=98Gw/YIKBAo25+eia8JVZ/k22pWYO0PDQMHyI7+B3/Y=;
        b=ba4mpEp3cbganwkwZEUH4UutxDMnb46PX0Y22c1nQqXyj4cuXcnhJBDnk9YoxKu4vQ
         jcqZ3xJffj2FbbhUpELcGeqCxfL+KJnOJQU8EMFvt68UeAWLWO9sBPNd9GLaY93hxJxl
         PUWw+au3jkYnlqgbiHfKWrLSoShOi4MEqR5ednbM2/8EmJkTY/bDa/vCD2Xx2CznB8is
         DWJWbumEqo5/tPr2XOnbF7VqNQGq8vQCAP92+bctlwIGpCVQ+vyxcgvLeCh8SVAxK73t
         tEndbvHC+wwmiSobglGWOR217XgR+MyQCPCKYYjSQe4MxQzvsckbl5N3/aP39LzdMOiW
         tnzw==
X-Gm-Message-State: AGi0Puad3q+AWc+gtQX7pD5QMavhzSeO1QeTvOV3y/P186RAh0+9LUH2
        Bx48R55ZKH1Crpe8fma/OZ4lyFxMMHFLb1K5jB9VBnFSRhM8Jy99TVmzie4e9p1kF/zQVtlLnow
        SKco0nviGLgAejbRXZ3a3c3M=
X-Received: by 2002:a37:a186:: with SMTP id k128mr9694069qke.149.1588453867092;
        Sat, 02 May 2020 14:11:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLDJ29emRSGxtOrg7phOUBKtXGhr9D7AIFJJXZK+qKPj9RkQfFg5OekLu1Lbs0v6owzYNPvoA==
X-Received: by 2002:a37:a186:: with SMTP id k128mr9694039qke.149.1588453866425;
        Sat, 02 May 2020 14:11:06 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id l12sm5919552qke.89.2020.05.02.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 14:11:05 -0700 (PDT)
From:   wu000273@umn.edu
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] power: supply: fix memory leaks
Date:   Sat,  2 May 2020 16:10:56 -0500
Message-Id: <20200502211056.20975-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function power_supply_add_hwmon_sysfs(), psyhw->props is
allocated by bitmap_zalloc(). But this pointer is not deallocated
in several error paths, which lead to memory leak bugs. To fix
this, we can call bitmap_free() to free this pointer.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/power/supply/power_supply_hwmon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 75cf861ba492..7453390ab7a4 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -307,7 +307,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
 			      psyhw->props);
 	if (ret)
-		goto error;
+		goto out_free;
 
 	for (i = 0; i < desc->num_properties; i++) {
 		const enum power_supply_property prop = desc->properties[i];
@@ -342,7 +342,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		new_name = devm_kstrdup(dev, name, GFP_KERNEL);
 		if (!new_name) {
 			ret = -ENOMEM;
-			goto error;
+			goto out_free;
 		}
 		strreplace(new_name, '-', '_');
 		name = new_name;
@@ -353,10 +353,12 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 						NULL);
 	ret = PTR_ERR_OR_ZERO(hwmon);
 	if (ret)
-		goto error;
+		goto out_free;
 
 	devres_close_group(dev, power_supply_add_hwmon_sysfs);
 	return 0;
+out_free:
+	bitmap_free(psyhw->props);
 error:
 	devres_release_group(dev, NULL);
 	return ret;
-- 
2.17.1

