Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474D7AB54C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjIVPxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Sep 2023 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjIVPxs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 11:53:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437B122
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 08:53:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d859ac9ea15so3301993276.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695398021; x=1696002821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7bK6hAXjxwm2ijcRkbUrk4xLVSp4X3nArYEjpbBtYs=;
        b=DAXFv3e5pUF9pzB10KB8TtxXzK2gSyPdF7EAw/GwB5nE1zmwi8f0hApHd3bZIxa2BD
         3Q8OxKq1c8+kOJfjArMAWN5qJEeWnqLv3xUA1k+HhTHSElaCC5GiDP5qg9g9eeyZDFir
         ytiq6/4irTp71UeD7lP4m8KIixKTKKoOl6WQdp08L9bYOeBwtFOifjwJH8U5a1l5rSE9
         +VH2UogrMDjq9KPx4u+1Ye77DHcg76ye7SiIKnZpQ4B39TJq6X1/TP/LKo1VgbDIslU7
         z98hZftyDIQJVdpZJrw+O/ZzcNk5JvHkzoBCy1t+TrbNdRFpfSpKD/jhMk2MSqsyVcqW
         KPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695398021; x=1696002821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7bK6hAXjxwm2ijcRkbUrk4xLVSp4X3nArYEjpbBtYs=;
        b=ijVljklLvs5qodj+MUrq1putE1YIQvEwsKrnr5QjmP8iN9LXAMiVQpUyaerI7Mph8+
         TrhOxEcCHw/3FsjtfqdJuq16cnn96p0pwfa5eWd5U6fly37Y26t4RuIwh/Zm8WCfUZrS
         DJnwiWEWjAkh9uk2HGNdfMNwcG4NuB2Eh8lDsFbqFH1wOlbhq5n6fKiJ64O+hzm+vlvR
         Tt8Wvj7/EtB0PBMIjkCCTK3MKmqS28/d5MC/wrK6/A0FScmpWNEocVQ3SUwb2xB9CaI+
         gHR6F3UpTIdO7/aWEjIXRjcs9ARpWnniU2sW/xC6r+Bmxc+CuOAIjKxVj++VrDuNsQkX
         81cg==
X-Gm-Message-State: AOJu0YwnUolfvB2nBLAMfQNq/6MQ7B3gd+EI4GSZnZKivFkogf/8jCza
        MJRxVlXUNqLkkynEDN35/5SCtGDrhHim
X-Google-Smtp-Source: AGHT+IHDDnP0ZSOPgk0DlTlo+bvkM6ULCHtAWJPl4dAhWDlxfr7ZOa9+PCIY6cT541j4sLdcJgiVygLsLTa1
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a25:ae66:0:b0:d7e:79c3:cd0b with SMTP id
 g38-20020a25ae66000000b00d7e79c3cd0bmr114598ybe.3.1695398021726; Fri, 22 Sep
 2023 08:53:41 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:53:36 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922155336.507220-1-bgeffon@google.com>
Subject: [PATCH] PM: hibernate: clean up sync_read handling in snapshot_write_next
From:   Brian Geffon <bgeffon@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In snapshot_write_next sync_read is set and unset in three different
spots unnecessiarly. As a result there is a subtle bug where the first
page after the meta data has been loaded unconditionally sets sync_read
to 0. If this first pfn was actually a highmem page then the returned
buffer will be the global "buffer," and the page needs to be loaded
synchronously.

That is, I'm not sure we can always assume the following to be safe:
		handle->buffer = get_buffer(&orig_bm, &ca);
		handle->sync_read = 0;

Because get_buffer can call get_highmem_page_buffer which can
return 'buffer'

The easiest way to address this is just set sync_read before
snapshot_write_next returns if handle->buffer == buffer.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Cc: stable@vger.kernel.org
---
 kernel/power/snapshot.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 190ed707ddcc..362e6bae5891 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2780,8 +2780,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages + nr_zero_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2824,7 +2822,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			memory_bm_position_reset(&zero_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2834,9 +2831,8 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
-		if (handle->buffer != buffer)
-			handle->sync_read = 0;
 	}
+	handle->sync_read = (handle->buffer == buffer);
 	handle->cur++;
 
 	/* Zero pages were not included in the image, memset it and move on. */
-- 
2.42.0.515.g380fc7ccd1-goog

