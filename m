Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50481E693B
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405733AbgE1SVD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 14:21:03 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50932 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405782AbgE1SU4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 14:20:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49XwxL6P96z9vYQt
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 18:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fkBzpsZqLY-V for <linux-pm@vger.kernel.org>;
        Thu, 28 May 2020 13:20:54 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49XwxL4jj6z9vYRB
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 13:20:54 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49XwxL4jj6z9vYRB
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49XwxL4jj6z9vYRB
Received: by mail-io1-f71.google.com with SMTP id g3so8525459ioc.20
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z0PvIbGDn0Z17RYgI3zBJ0aJdEFVtvocF0jkm247rpg=;
        b=Mohgw2y48p+edoFuDPTzW7a8j/cRZLBMiAO8TEnkzQI7jCQjkiJhnSRUVG952Twn+j
         tG3NSymdVCNKe+CJj3GS4lnZ4rR62sT9lpiilIWUBgiFtJFqf5HbK2pqZvUxj9RgGK3E
         z/ye9hnqt6X95fgEb6lc5ITDvm2QAK2olG8hOL9cBCrv1TTKYTaLIpFzDMbFH7Pw53Rh
         z3EYRsgj/4n1Ch8sZDHdfbak7/O44D9BkLrprOpnU+vCvI0CXVh3d3KQb/RITdWbzljR
         tqnqGgvOuxJvxqweGWlOE/xwIf2cImibd6+wd28+Azq/qpNOzJJ37+QnYDsJttqyFNlr
         69XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z0PvIbGDn0Z17RYgI3zBJ0aJdEFVtvocF0jkm247rpg=;
        b=T8fJk4omFOjniY/g62jnhjBJBueVzEjTjLTQ9iGKdD7IhxNBeQEJQITkyx8G2oU2MJ
         p/yFcq5RrQLBz40wp0JdgbgPIcBqFXKs/YQqFl2U3hKX0AWHmaDsP30+ooO6GtMZbTZf
         HfNBULtBgLckecSM4m9vlRprTlya7BF3IJblU2/6iwwX9YqigfT/AQLwXi2URlc8E9kk
         bBhswCkhbpOzLeafQ90gx8osN/7Jv8T+bo6n4bDE3S21qb94oXCNy0KSJnBAYA/AXpsK
         HA3HFdJf6mIQdf/udMz7yV9F4B82YZT5tC0VGqQMETVW3CxPJtkd+ROeNxfOd4cvg/By
         ZZGA==
X-Gm-Message-State: AOAM5336dyebMNnGW3fX0hXD/FKbBb2tvxr6hpxnAxSXGMDJFVTCha5Q
        awclsQfwQX35p0SPUos+9aQJF+FEUT1bVh4bB+Lv0g0HlHOXsnyEnucPExl30kVjIP1zTNQdtO3
        Ybh7lEcaCrtAddduow2yrbXA=
X-Received: by 2002:a02:93a1:: with SMTP id z30mr3660275jah.25.1590690053169;
        Thu, 28 May 2020 11:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/jnO9EhpMdxptmG1zZKzrF5o5zH+5CTWhvnVk4DfYgYLm5zOPh3QA1ohplbxSUObSl5kaOg==
X-Received: by 2002:a02:93a1:: with SMTP id z30mr3660245jah.25.1590690052738;
        Thu, 28 May 2020 11:20:52 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id f66sm3628149ilf.63.2020.05.28.11.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:20:52 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: Fix several reference count leaks.
Date:   Thu, 28 May 2020 13:20:46 -0500
Message-Id: <20200528182046.845-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/cpuidle/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index cdeedbf02646..55107565b319 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -515,7 +515,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
 					   &kdev->kobj, "state%d", i);
 		if (ret) {
-			kfree(kobj);
+			kobject_put(&kobj->kobj);
 			goto error_state;
 		}
 		cpuidle_add_s2idle_attr_group(kobj);
@@ -646,7 +646,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
 				   &kdev->kobj, "driver");
 	if (ret) {
-		kfree(kdrv);
+		kobject_put(&kdrv->kobj);
 		return ret;
 	}
 
@@ -740,7 +740,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
 				   "cpuidle");
 	if (error) {
-		kfree(kdev);
+		kobject_put(&kdev->kobj);
 		return error;
 	}
 
-- 
2.17.1

