Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE76D21BD72
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGJTMO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJTMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:12:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A05C08C5DC
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 12:12:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so5450457edb.11
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BIaSr8IiOMpeoWMqqGaijFBsOLFsLBt74sgvogEh9eg=;
        b=tS/ZDPmK3sYjKDt23wsHMFJ4rfNALMAQe0e2ZDMmPDK1DKVRfGauuzm+ZupRUL+7/s
         4t4qWvoXjzq8+asSwWWCbIfA1rwD7o3MuUtqE37m2QxnrgVVblel7WP8tyv24KbF9cYm
         CkIA9ZxdTDN/T7FjMp2sqXP6O9eBXVq7He2NfXGEoL+aTa9k0+fzbXxEppbEynVXM91V
         q8LcejG3xhz3bmQzRFyhAd8DpoO51U9DJfrpoG4/o1ZsLLtG3Rf+k/xNN9Oh05vJjMjo
         97Pq7wkCVwBt4JP0lLCw7MHjennpptIq7RWkJlUapAyQ2xFCSRiWXupmL0ToDDJVXMpB
         Qrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BIaSr8IiOMpeoWMqqGaijFBsOLFsLBt74sgvogEh9eg=;
        b=RyQ6+ajbcqQ0TSvY2EG+KLO6W0lnKHAdQLPVf+J5cnUR6IIM/Cms1wc+IxN3MhtKK4
         rpBpmjK+oSE8Wr+/S1cWND8E1FvzrPgFWl3TfAORiGdHCUeWiEcK8gm2AtKesWABjPDK
         n96K9sAXSpVRgmercN9MfdghalPcoBNWqeN2mpY3O8H3K3uNCFjMx55KpVfpxOJb0wNb
         /v1tr2c3Bo+Kac/XvGT/eymp9W4AZ6DXH6XqhALgn4tnE5o5Q0bTD1D/UYfFKioXGStq
         h90eLXIHXVkhYAMugh5zW89MdVNe7F8MNibHUme1DX5R4UToX9kNEe+7MvyD5qff9e3z
         hbeA==
X-Gm-Message-State: AOAM530SJxd79lRgHRqYp3JyH2VdtDrgKsyIIWN8TdRMXYEmnK0Stl+P
        MWAxxTIXDMe7n0u2u3fQoHXYmz4=
X-Google-Smtp-Source: ABdhPJz/DmxCGT141kP1yfTUefuxbewNAR9eGdOEbrPypdFdtv4VHnNXVDkjImnz1j0p+gnJmZpbyw==
X-Received: by 2002:a50:b5e3:: with SMTP id a90mr39405140ede.381.1594408333013;
        Fri, 10 Jul 2020 12:12:13 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.22])
        by smtp.gmail.com with ESMTPSA id m14sm4105415ejx.80.2020.07.10.12.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:12:12 -0700 (PDT)
Date:   Fri, 10 Jul 2020 22:12:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] power: spread "const char *" correctness
Message-ID: <20200710191210.GA504670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixed string literals can be referred to as "const char *".

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/power/power.h    |    2 +-
 kernel/power/snapshot.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -32,7 +32,7 @@ static inline int init_header_complete(struct swsusp_info *info)
 	return arch_hibernation_header_save(info, MAX_ARCH_HEADER_SIZE);
 }
 
-static inline char *check_image_kernel(struct swsusp_info *info)
+static inline const char *check_image_kernel(struct swsusp_info *info)
 {
 	return arch_hibernation_header_restore(info) ?
 			"architecture specific data" : NULL;
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2023,7 +2023,7 @@ static int init_header_complete(struct swsusp_info *info)
 	return 0;
 }
 
-static char *check_image_kernel(struct swsusp_info *info)
+static const char *check_image_kernel(struct swsusp_info *info)
 {
 	if (info->version_code != LINUX_VERSION_CODE)
 		return "kernel version";
@@ -2176,7 +2176,7 @@ static void mark_unsafe_pages(struct memory_bitmap *bm)
 
 static int check_header(struct swsusp_info *info)
 {
-	char *reason;
+	const char *reason;
 
 	reason = check_image_kernel(info);
 	if (!reason && info->num_physpages != get_num_physpages())
