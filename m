Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045EC293147
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgJSWdJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388205AbgJSWdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 18:33:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD67C0613CE
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 15:33:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so831291pfc.7
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRjo2HvYrN2YlB7PX+blFf8vNEJz+jYGbB/nTBk0Ba8=;
        b=OC1dGuQQU6DMsWrKaHis4dloEGAs6n41NTtAe9LMiaBcJ2/K05WNyxvaq3h1OtI6TH
         Kb4YbJhU16bT6ftitK6musRNCmsn5BcYU4gPT30kNnP6dq+jIJtWlXQrmv3jVAeRMkPv
         0L1pc3rfXNArykrq0o3ZFqtB7llzIqY/nSSsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRjo2HvYrN2YlB7PX+blFf8vNEJz+jYGbB/nTBk0Ba8=;
        b=qz7ahT4Zyt4qUTD3LZoFZIm+i8pJSSEWllANkOGYtWrdbPM4upwifg3pMstYWPu03i
         EyOpdkrxK8ng2HzmoUe+nOxU/PbMOyd914Xs/TVLNYkOFpgY5b4S2VnrM8fWFgHj1LJr
         KUC8YbPdhB+4Nbni8EsdnAcFHKoefpBbrxNyttTCj7Xp6piRNehjSuGcZxgnFBc2n2yo
         0oDg+KgcRameqfa3yc5OuCmWmv+CyCRKrdOa8M8l0BhkdWxPCIM4kB51L+Gk8HWeAK4U
         2pyE4PUj85v2UI9EYhnxYhwX0agZ5HGjJHlktKuFVqgIDZluipR48bvf0oft3Zo7R4Er
         ZmUw==
X-Gm-Message-State: AOAM530Ss6k0cswY9Xkvrb9TzqxZDVaYP1c9nYn8bJOub/ekJXscmfXV
        jv6Y6U8WQtuPFX0evxBytgdbYQ==
X-Google-Smtp-Source: ABdhPJyTbuytBMp2b9itw0xRGEp0pJ/7XBda2m5Bgy8XEUYi7Nw/fAI/195+z3HlU3iNnktZRLY8BA==
X-Received: by 2002:a63:f84c:: with SMTP id v12mr29801pgj.125.1603146786040;
        Mon, 19 Oct 2020 15:33:06 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id s20sm10897pfu.112.2020.10.19.15.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:33:05 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/1] kobject: Don't emit change events if not in sysfs
Date:   Mon, 19 Oct 2020 15:32:57 -0700
Message-Id: <20201019153232.1.I797f9874972a07fc381fe586b6748ce71c7b1fda@changeid>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201019223257.261223-1-abhishekpandit@chromium.org>
References: <20201019223257.261223-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a check to make sure the kobj is created and in sysfs before sending
a change event notification. Otherwise, udev rules that depend on the
change notification may find that the path that changed doesn't actually
exist.

Fixes: a45aca510b73b7 (PM: sleep: core: Emit changed uevent on wakeup_sysfs_add/remove)
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 lib/kobject_uevent.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7998affa45d49a..f08197e907d5ce 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -473,6 +473,11 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	if (action == KOBJ_REMOVE)
 		kobj->state_remove_uevent_sent = 1;
 
+	if (action == KOBJ_CHANGE && !kobj->state_in_sysfs) {
+		pr_debug("kobject: can't emit KOBJ_CHANGE until in sysfs\n");
+		return -EINVAL;
+	}
+
 	pr_debug("kobject: '%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

