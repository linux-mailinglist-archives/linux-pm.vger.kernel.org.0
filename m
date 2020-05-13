Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C11D0F8F
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgEMKR7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbgEMKR5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 06:17:57 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A96C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:17:56 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z29so17407942qtj.5
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q75lzvusIubV+x4lbgqEMhPKgN16P1e/agr4F7CRhU8=;
        b=uwsUrcxiOTwLIjtb233G+rChhOemiGDHeJ0c1jkWkD5RIhFt8Q6YmrHmnGdyDFoA7w
         z0JHppk2BirXhBomckaug2Q6s2LRE2zR5cpjHaiHMTvWDIo5I/JvLWkvQ7ESCUFC5BFC
         07nTJBD0DuodW+2vMBPnk+00OKJrj5wMgCEZbieX9GwXN0j2D+MmTtrbGTGttNLAguf2
         jHRbfj7vf7WYDW/IocMKC64tnX1Eo1pLWdQnxc0mOVDxToKO3IRfzFR5UXPGq1WcZE+3
         emUmDjUXTPFNA8JjGNwPB5A+vHABUZ9XtdTgRO2djksNBKY8sIRV/xdNYy9lFv2wQ4mi
         D3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q75lzvusIubV+x4lbgqEMhPKgN16P1e/agr4F7CRhU8=;
        b=ZVxDxTWgJWpjQcLAMJrkqq7Wd2Strg5tB+q+7IqR4MmW66HpCHi4TQFdDBEQKt9C4A
         ml8qGEnSFndmreKroHyOye78YVtEekcxLu+2oBBIKEGB/LgN9cvyx2JhEXvzDyj4mfGI
         8R/IlSwdwL9QJUwHL7ZTjHCMgSOWGyYI8hbIZkR/oZ858PpulIimyS5kfLqN+rsd1DTo
         UTXLNYXxFr7GqxyF+IFQ4MOEOwlM4XtxfBQ6Ol+4VbHUWFVRP3mJTK1oe3agfbhEJXWh
         TaQEDkqnU3QLzYmF4QfYvD6VQDeAP8JS2cj2meCg8qsHoumLbwmOVgl6EtAQDtIebweh
         SB3Q==
X-Gm-Message-State: AOAM533qQX8jRWL4d3uvlEwUHH2qtz2QH9GH9JgCY5cbgJ9gdalVI0Q1
        x+i2JRob82LxGs7lczIfyl3O4871fEQw
X-Google-Smtp-Source: ABdhPJxku65piDYCHVEoRkNVp2hIdWPjpi79AR+BI91IbHBbjaaojhi6JNkGrL2RMnKXnTKmHBxvaO55VMFh
X-Received: by 2002:a05:6214:905:: with SMTP id dj5mr733695qvb.222.1589365075866;
 Wed, 13 May 2020 03:17:55 -0700 (PDT)
Date:   Wed, 13 May 2020 11:17:51 +0100
Message-Id: <20200513101751.111907-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] cpuidle: Delete unused define_one_ro/rw macros
From:   Pascal Terjan <pterjan@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

They were already unused when cpuidle was introduced.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/cpuidle/sysfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index cdeedbf02646..7729cf622d1e 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -167,11 +167,6 @@ struct cpuidle_attr {
 	ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
 };
 
-#define define_one_ro(_name, show) \
-	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
-#define define_one_rw(_name, show, store) \
-	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
-
 #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
 
 struct cpuidle_device_kobj {
-- 
2.26.2.645.ge9eca65c58-goog

