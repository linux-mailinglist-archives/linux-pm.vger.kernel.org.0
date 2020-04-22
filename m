Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4D1B36BE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgDVFP4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 01:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDVFP4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 01:15:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F332C061BD3;
        Tue, 21 Apr 2020 22:15:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so515622pgi.5;
        Tue, 21 Apr 2020 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESHOCSla3cw+Nj7T3ApIC5nkdM4500s3bEzuUZQ57tw=;
        b=NQq+GjWdbNVDbABi4BUIyMgzMxdUn0DHqSQ4XTiAJFlEpf7t9lTTIGhSxChGUALiOV
         ShDrrpzsoqxc/vSSzGGteBeJoSXa+XkYoOb0mCmlzVuIgwKsj9VLMRQOf+LAUcXnrIgy
         M/CFY/8PXLl2Eba06WrU0d3/mctyW/+uCV1WMhoheCwQ/zvIdlHoKgERHz3KAKCxOAhB
         6B1X7s00j1NoiYh88mYjKL9SFGWz1J8pRalUIyool6GzYGfSguJQgvsWd57y0ohMRbA0
         6vkJJRr4cwZCQfBjM5sz8bbUK6DdOgXzOg6h/Jdk40jdjzHeKljuvjzHhM7IUes39yRj
         8UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESHOCSla3cw+Nj7T3ApIC5nkdM4500s3bEzuUZQ57tw=;
        b=BOcg/tdvHvK6U6UJ+5II6WmmMcPjPdbS2JUAp1ZSqjZp4v5MDHC2k5Ir5tYqmNYBKg
         TovJQlWVWiGRU489qB7I+oAlg1vFv1JUpyYFqSasiBBGX73swdDYkZBRnbvIgvALptxT
         pdf6qrZYseZFDBBaM7HAFqTqzmgeWpzAXmoNiU5Q6E+IZb0Hj+DTeqR2K4mM2EPFjLvX
         4KtR07z1imhAtGPICNSHjTvliH52G5k7bKvxX6Yjvq+mj5DS2kkm3N1G8Xs4+aANKT0O
         KVPz3i50mdcdZviId5ayFmETYIa0ZCQMDrPHpX4Hg6GEGrRbJtWsi4meM0p2kxPoNSgg
         SEYg==
X-Gm-Message-State: AGi0PuYD2rXyya2/b+oc2bRcY7OIOlE+i2qJ92q1eE8a/KfXrQGN4OAG
        QsSwTodnVKEJl9XuJ9dFN/E=
X-Google-Smtp-Source: APiQypI6Mu8MV5fceWlOjbgCk3lOwpu5G+5dCRNwKzbNNX1eFE6KL+QNcqNI+jRCRS+6AIETsqLheQ==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr24276595pgg.229.1587532555497;
        Tue, 21 Apr 2020 22:15:55 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s44sm4273008pjc.28.2020.04.21.22.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 22:15:54 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Samer Xie <samer.xie@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] PM: sleep: call devfreq_suspend/resume and cpufreq_suspend/resume in pairs.
Date:   Wed, 22 Apr 2020 13:15:29 +0800
Message-Id: <20200422051529.30757-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Vincent Wang <vincent.wang@unisoc.com>

If dpm_prepare() fails in dpm_suspend_start(), dpm_suspend() can't be
called. And then, devfreq_suspend() and cpufreq_suspend() will not be
called in the suspend flow.

But in the resiume flow, devfreq_resume() and cpufreq_resume() will
be called.

This patch will ensure that devfreq_suspend/devfreq_resume and
cpufreq_suspend/cpufreq_resume are called in pairs.

Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
Signed-off-by: Samer Xie <samer.xie@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/base/power/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index fdd508a78ffd..eb3d987d43e0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1866,9 +1866,6 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
-	devfreq_suspend();
-	cpufreq_suspend();
-
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
@@ -1988,6 +1985,9 @@ int dpm_prepare(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
 	might_sleep();
 
+	devfreq_suspend();
+	cpufreq_suspend();
+
 	/*
 	 * Give a chance for the known devices to complete their probes, before
 	 * disable probing of devices. This sync point is important at least
-- 
2.20.1

