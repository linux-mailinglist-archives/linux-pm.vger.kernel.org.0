Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD64104572
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 22:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKTVBM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 16:01:12 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:53501 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKTVBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 16:01:12 -0500
Received: by mail-pj1-f74.google.com with SMTP id d24so204192pjv.20
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 13:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dNu0llNPaQSV32UuNuhQaHHaV2/GDsqX8juVfC7fS/8=;
        b=YJwFugIBfS0Q3wCJrqIZjCPTmSFHoY0vnsgzQ0I6IgKjrwg/s4iHdyvWFiFAtM6rjW
         W3kOfMKZOwcsdPQoc1U43uPJ1yPVtnhTEYCJSNWyjA8GUlpHEMwxb6F8xzqxm3FNI6h9
         C3dJfCwzwtF3gJQbJizICvpla8xpgeqyO8bsq1bEtyUaTA7yYSNCz6b7g3H1rztjpdIO
         Ugn1+/G5S48KZ59zcpBtIdHJ2n+5Abkjjdqv0RHgV+fG1LZHL37FPdv/QqamYhoBI87Y
         wfDOCBfqZzDY+wscPtzrtCuiJy3k3M35CTGkTJn6DwzIogHIm7kIw4CQRR70MgX6HLsT
         uUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dNu0llNPaQSV32UuNuhQaHHaV2/GDsqX8juVfC7fS/8=;
        b=b9kUM6FusS3crGymD99CoEhdbKx2US+3p7qFI0qS8s4sAWpG156dMfoutqRC/PFnZO
         GX2stmYcRJ8kqseN3V8xaz+jpzKHN1TmKvzHU3CW6tJe8J/QiMHYh9URii1fMDtKZK3y
         OERp3IMPkjCenz7QwR6B+a3s0S7bpLpOs9iZCY5bD75i5DRolcLo0wfYVyB7TeBZOdXG
         1ZM2jPyaSC87CdX+md337KLacGUZ1drEphpEJx/CyrbPfCBwXEdA+Zml52vMGR4Z/4lV
         6kxo5bVpJlkoYyhUl+GR9Bq2GPpqBpxyNeZDF91hE8fk91i9HrLm/688zcR2zvOh+Htu
         J2rw==
X-Gm-Message-State: APjAAAVKQwhCHpFabLDSKm+UoohU9x+WY0BnYi+DXhgNjPBtxy/XZnws
        nxqhWGAj1rP1350tBDNzcdjujptnXxWsU29UvinWnqii+Qe04IYCUTYP3Mb18CMHRXaIiPGIwsT
        LwRDcc/LHYVxttH5CheWLuUuPGS+89VIq2PmDN7RLva0TWmZwgNGcnVKhpw31RWNmObIpy83s
X-Google-Smtp-Source: APXvYqyjKPmvPxmxN8PkfgWW6xfq6PABDTybJDJ+iDD2ee9scQgI6ybRVWKos/NAiSWeEiec2bKfnjuDwx9lOGE=
X-Received: by 2002:a63:ce0e:: with SMTP id y14mr5506859pgf.191.1574283669179;
 Wed, 20 Nov 2019 13:01:09 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:00:49 -0800
Message-Id: <20191120210049.254548-1-semenzato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 1/1] power: clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Entering hibernation (suspend-to-disk) will fail if the kernel
cannot allocate enough memory to create a snapshot of all pages
in use; i.e., if memory in use is over 1/2 of total RAM.  This
patch makes this limitation clearer in the documentation.  Without
it, users may assume that hibernation can replace suspend-to-RAM
when in fact its functionality is more limited.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 Documentation/admin-guide/pm/sleep-states.rst | 18 +++++++++++++++++-
 kernel/power/snapshot.c                       | 16 +++++++++++-----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
index cd3a28cb81f4..fd0072eb8c03 100644
--- a/Documentation/admin-guide/pm/sleep-states.rst
+++ b/Documentation/admin-guide/pm/sleep-states.rst
@@ -112,7 +112,9 @@ Hibernation
 This state (also referred to as Suspend-to-Disk or STD) offers the greatest
 energy savings and can be used even in the absence of low-level platform support
 for system suspend.  However, it requires some low-level code for resuming the
-system to be present for the underlying CPU architecture.
+system to be present for the underlying CPU architecture.  Additionally, the
+current implementation can enter the hibernation state only when memory
+pressure is low (see "Limitations" below).
 
 Hibernation is significantly different from any of the system suspend variants.
 It takes three system state changes to put it into hibernation and two system
@@ -149,6 +151,20 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
 configuration option is set.  However, this option can only be set if support
 for the given CPU architecture includes the low-level code for system resume.
 
+Limitations of Hibernation
+==========================
+
+When entering hibernation, the kernel tries to allocate a chunk of memory large
+enough to contain a copy of all pages in use, to use it for the system
+snapshot.  If the allocation fails, the system cannot hibernate and the
+operation fails with ENOMEM.  This will happen, for instance, when the total
+amount of anonymous pages (process data) exceeds 1/2 of total RAM.
+
+One possible workaround (besides terminating enough processes) is to force
+excess anonymous pages out to swap before hibernating.  This can be achieved
+with memcgroups, by lowering memory usage limits with ``echo <new limit> >
+/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
+operation is not guaranteed to succeed.
 
 Basic ``sysfs`` Interfaces for System Suspend and Hibernation
 =============================================================
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 83105874f255..9f3228f1ee26 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1698,16 +1698,20 @@ int hibernate_preallocate_memory(void)
 	ktime_t start, stop;
 	int error;
 
-	pr_info("Preallocating image memory... ");
+	pr_info("Preallocating hibernation image memory\n");
 	start = ktime_get();
 
 	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
-	if (error)
+	if (error) {
+		pr_err("Cannot allocate original bitmap\n");
 		goto err_out;
+	}
 
 	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
-	if (error)
+	if (error) {
+		pr_err("Cannot allocate copy bitmap\n");
 		goto err_out;
+	}
 
 	alloc_normal = 0;
 	alloc_highmem = 0;
@@ -1797,8 +1801,11 @@ int hibernate_preallocate_memory(void)
 		alloc -= pages;
 		pages += pages_highmem;
 		pages_highmem = preallocate_image_highmem(alloc);
-		if (pages_highmem < alloc)
+		if (pages_highmem < alloc) {
+			pr_err("image allocation is %lu pages short\n",
+				alloc - pages_highmem);
 			goto err_out;
+		}
 		pages += pages_highmem;
 		/*
 		 * size is the desired number of saveable pages to leave in
@@ -1835,7 +1842,6 @@ int hibernate_preallocate_memory(void)
 	return 0;
 
  err_out:
-	pr_cont("\n");
 	swsusp_free();
 	return -ENOMEM;
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

