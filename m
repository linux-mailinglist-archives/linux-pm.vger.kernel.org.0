Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671CB12EABE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 21:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgABUBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 15:01:16 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:46206 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgABUBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 15:01:16 -0500
Received: by mail-vk1-f201.google.com with SMTP id h18so16488866vkh.13
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 12:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IWftFaF/7pwaE+hKN0rmHHTDccHnFs4MwoJXhQKr9TA=;
        b=ETFtyUbGasImdWusI7+XxX+jtfzy6TbJUp8B/J87NDJKrN0tpvcu+AhRbowiMtcdgg
         bgjYmyFMHeiZP1YyPkOJe2abYtU+18pqk98PIqIpdmXhiL+NCzGaUfwooMn7yIw2l2sK
         XNt0kZnYXtKpSNWS81hh9vYloEblPeBm9UO7rjtiG9Mnbfl6BL6rQonfw28PD19VxaYB
         AtHFPgoQq9kWjklvzY6rcLgQZVIhOxkgZQILADhE/vJ2AnmTJgZg/Nokpsq0P1dpwgGQ
         hJ0Kkj0DAet+gYl0w8PbWpXOWeuJ4xr8D2GffvLt2+nHrPQgHnWpO70Z1VvVu5hp/FdP
         hVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWftFaF/7pwaE+hKN0rmHHTDccHnFs4MwoJXhQKr9TA=;
        b=L+a0UOf2TVfJA0Ol6tLBXcB2cCn3NVgZdHVy5zSj4wGMxbvYFkB4Qx93SVRSdWKlHW
         og7FObF/KSbX04LbEu52zBUGlbDacr0xUymOmttATl3FaT39t7MlOfMxaAGcmXe5XDEA
         RPK9znhwuPPm4sV7SHyEKg2VK9S9IwZY3XUlmyQlOWHWI0S2GYk5oEX6uCla0uf4Bth6
         hpSzVRgfZbGwahwNtJuj9oj01kXBaQ3QRKG73SGJnpLI6kMtSRHP8yHR+IjKjPaAq7qw
         EsF0U0vy833C+DqUfvB/91+nVh1IoN/BzZgUrjzyF0kBcKvr4EGcDyYBRzGwxKJXqhhY
         UP8g==
X-Gm-Message-State: APjAAAWjDX9K3BIiI+E6Bcvc77Nd0KBNJS9hnSkPKpceMAARlCBO6SRF
        VtHAfXpsJ7STrAGhTsQKsUh8wkO/oIF2yv7I16H/6Rf9DUUYrWg6LBfxnhV3SuMQG78Dg/boy5b
        1ar9TY2e9wGFmuzpO0/zlECNUbUOn5xN9MyGJZx88miDDJoTPnqXoXNjKWT69/wWeNJEH/eKJ
X-Google-Smtp-Source: APXvYqwtC1Uvje2fbb36HVwCkmW0QcIlFAti3E9fgJHG6wwvnd7vXeyx2pz2lLd6Iz8RTxqnfNJndL5sU4NFASA=
X-Received: by 2002:a1f:d904:: with SMTP id q4mr43772171vkg.13.1577995274922;
 Thu, 02 Jan 2020 12:01:14 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:00:52 -0800
In-Reply-To: <20200102200052.51182-1-semenzato@google.com>
Message-Id: <20200102200052.51182-3-semenzato@google.com>
Mime-Version: 1.0
References: <20200102200052.51182-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 2/2] pm: add more logging on hibernation failure
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hibernation fails when the kernel cannot allocate enough memory
to copy all pages in use.  This patch ensures that the failure
reason is clearly logged.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 kernel/power/snapshot.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168321e7..df498717a97e 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1705,16 +1705,20 @@ int hibernate_preallocate_memory(void)
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
@@ -1804,8 +1808,11 @@ int hibernate_preallocate_memory(void)
 		alloc -= pages;
 		pages += pages_highmem;
 		pages_highmem = preallocate_image_highmem(alloc);
-		if (pages_highmem < alloc)
+		if (pages_highmem < alloc) {
+			pr_err("Image allocation is %lu pages short\n",
+				alloc - pages_highmem);
 			goto err_out;
+		}
 		pages += pages_highmem;
 		/*
 		 * size is the desired number of saveable pages to leave in
@@ -1836,13 +1843,12 @@ int hibernate_preallocate_memory(void)
 
  out:
 	stop = ktime_get();
-	pr_cont("done (allocated %lu pages)\n", pages);
+	pr_info("Allocated %lu pages for hibernation shapshot\n", pages);
 	swsusp_show_speed(start, stop, pages, "Allocated");
 
 	return 0;
 
  err_out:
-	pr_cont("\n");
 	swsusp_free();
 	return -ENOMEM;
 }
-- 
2.24.1.735.g03f4e72817-goog

