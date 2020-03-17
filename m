Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CE1879FA
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 07:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQGzU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 02:55:20 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48626 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgCQGzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 02:55:19 -0400
Received: by mail-pg1-f202.google.com with SMTP id f14so13836162pgj.15
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pBzGjleoRDABxMsluExcps57eD2wDVloI24KvIbaURE=;
        b=UledzLdGZZjZgCktwDrReM83P2/tmN5F4Qnd1xTlFNMGgY4exTx7PpUlYpVJcYkHn2
         qOqSDPrlyo1Tg8E7TNmeCbcaRvzN8X/3p3klGc1pbS5gp4joG2QV+m7zPocAKbdG/djV
         mjbSeXmumJlZpNyD2H16Tr4UjjvSjJ9VFvp84bYCSC8nAKD0ptzQmWlkEpmb2H+YyfEx
         Q5CmFKr/pxFMWAzVJsJwrAUZbJgxAjQUKhVZinz2cSSZ3AoAfMo2MvYj7YHTC2PK7FYy
         y7OzDTmhrmK/3gX546uw6Y/xdIMPy5ZSM/4+vdG2TJbkV4Jqx4cGvW2bLV42+qET+yvr
         zeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pBzGjleoRDABxMsluExcps57eD2wDVloI24KvIbaURE=;
        b=F25hXIpTPAl1zXv5ZZIiiEVxFC7UyKaO/Po2upe32o12kS9KB3GjwixshRSuLxK9bj
         n83/Qawb6mxzW4jKg7ajjZZjD8oa2v+SOWvOoMDDVHt4/e02WEwNeK0r2iJa1PLqwP1p
         GfmPP8C0DmOsiHO8qoLLDzuL4xiLg6+ri+TBNBRjWYTuQOzIlKUU1sUvhJSWqNVINglf
         Oj6gD+WVaD3QlrA6khZNnjvg7KhzfSoNQYFHiDTsOqArve11uvbERgej6fDnbu2jjxHb
         BkigYOhOytpNHYTfwxej3DPnbdy32z0JkGJOzHdiOi+AYb6bLOWK8O+hcSl1FoZd819t
         V07A==
X-Gm-Message-State: ANhLgQ3a8i6KscyBEuwEuD9HKioIYvMFE37ffef1nggs59foJBs/Jdh1
        xm+Kg14qTq/nlsHFXqelUNb9/n8shZ2dfKk=
X-Google-Smtp-Source: ADFU+vsI46mjOrzK35IlZFKtn+I16f/ZJ36YpcLgiFZqwRzWEH2bTScx3tkAxfqOUW2oCR5e/5W0bdip3gPKHnQ=
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr3975908pja.132.1584428117265;
 Mon, 16 Mar 2020 23:55:17 -0700 (PDT)
Date:   Mon, 16 Mar 2020 23:54:52 -0700
In-Reply-To: <20200317065452.236670-1-saravanak@google.com>
Message-Id: <20200317065452.236670-7-saravanak@google.com>
Mime-Version: 1.0
References: <20200317065452.236670-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v1 6/6] driver core: Fix creation of device links with
 PM-runtime flags
From:   Saravana Kannan <saravanak@google.com>
To:     stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After commit 515db266a9da ("driver core: Remove device link creation
limitation"), if PM-runtime flags are passed to device_link_add(), it
will fail (returning NULL) due to an overly restrictive flags check
introduced by that commit.

Fix this issue by extending the check in question to cover the
PM-runtime flags too.

Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/7674989.cD04D8YV3U@kreacher
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit fb583c8eeeb1fd57e24ef41ed94c9112067aeac9)
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 31007af4cb79..928fc1532a70 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -213,6 +213,9 @@ void device_pm_move_to_tail(struct device *dev)
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER)
 
+#define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
+			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -274,8 +277,7 @@ struct device_link *device_link_add(struct device *consumer,
 {
 	struct device_link *link;
 
-	if (!consumer || !supplier ||
-	    (flags & ~(DL_FLAG_STATELESS | DL_MANAGED_LINK_FLAGS)) ||
+	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
-- 
2.25.1.481.gfbce0eb801-goog

