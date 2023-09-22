Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3627AB584
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjIVQHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Sep 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjIVQHR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 12:07:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDA198
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 09:07:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81646fcf3eso2996836276.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695398831; x=1696003631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xr7kuFN6juosnD7pV2K+XCmCrqnUJ7hjGVPi9yEcRC4=;
        b=4zT5NTfDBouBX/t+CFOSZPiMnOD/u1FPJVea6Mg6nM3pG7fV/mQ8Poen7Y8/7RZrEk
         qXHDVrWD4jplS5j4LUHHJj4EsHh3RAs67IyPjyvZZcS4e1+W/KwGzVHxQAg9K5TYjJF/
         jVN41v4E3V9Ckjsa5s0IQQawu7D4BOog7mjb8nKOX8uRaG87hro1bPKi+DZ+GXDY1GBB
         zdKJ5uNReM8nf/eA6Pwgume4gse8DSI4HknXVSKB2ISNraUR7WBVBzt4pZkcabfFLjjW
         x2nmv/X6O5Dd7JWa+KgFfZMRZxXmWyN/hu7dMTh0MSY/M/V/4/qrxvOH6pYbcUVnDzvc
         tjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695398831; x=1696003631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xr7kuFN6juosnD7pV2K+XCmCrqnUJ7hjGVPi9yEcRC4=;
        b=EssqUhaSwwqPtoDRX8p/2/kwzQ0M6Gaj8kz3m7xiz9J2MEK6Bd0Owigb7Hd0+YZGxZ
         4UKhwuELOnK2JPNK6RjomyjINlBYb9yrHGjV95n95D4RvwXyHMhi6c+/UTjsRIWwwWRo
         kO5/Ek+U9QJQbUasjiD6zOIfPUGd3mDXPvrheK+hViMUMCFRiAAGn3JukVrksj+GakQ2
         ejN6A//NI1vUzR7TwcZiv2WJ5XWkovsmd1cCXajuCZm6wXJZuds5LCiqxTZenWXIKY9P
         tpgqeUNyMRFtEzZAI7vv7ns3Dih3gkE8c/+hUgU7u4OpK1eYuV3KGDpOsOKvv2/VfVIa
         qtcw==
X-Gm-Message-State: AOJu0YxwoIHLpmv84zW3NFqd/4Nm7+DqoRtMq4IKitqNaSSa2m4Nyl8K
        Da2+T0oFIS7NhIbK27GrQzVNV8zJimzV
X-Google-Smtp-Source: AGHT+IGVb7ofk/0yHXHjCjAofJnuira/SMpyG+N49vFZHQCOf548qiOomD5P0oFa9Ales9KeVgwVz+cdM4tX
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a25:5090:0:b0:d7e:752f:baee with SMTP id
 e138-20020a255090000000b00d7e752fbaeemr120348ybb.10.1695398830992; Fri, 22
 Sep 2023 09:07:10 -0700 (PDT)
Date:   Fri, 22 Sep 2023 12:07:04 -0400
In-Reply-To: <20230922155336.507220-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20230922155336.507220-1-bgeffon@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922160704.511283-1-bgeffon@google.com>
Subject: [PATCH] PM: hibernate: clean up sync_read handling in snapshot_write_next
From:   Brian Geffon <bgeffon@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Fixes: 8357376d3df2 ("[PATCH] swsusp: Improve handling of highmem")
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

