Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593F6440312
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2T1O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhJ2T1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 15:27:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479ACC061570
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 12:24:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n23so132188pgh.8
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QSxhE5r/ZgGfaD75aNjGarCFi6+5alziBCSKa958aU=;
        b=ZnRBubYecE2jp7wawPeqf/8TidZUhbRkgqVxwO2ap7/vROnjkIGUt7ejft0sAYQVsr
         7XhvsrJm7ien9kMIwTjciAMaJXK/XSp4KChmSlu3j+9WUocHmmLt10ocTLwg53a6ZR4s
         vSEI5kygt/0EvapJ08VR1kcnriVth9TlJtRJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QSxhE5r/ZgGfaD75aNjGarCFi6+5alziBCSKa958aU=;
        b=gyUxwpjX1Jpyobf3HjvX9wJSDi2yqGh4CKjD0mh9wfez9vruE9Ylxc7YGhA4Ky+5+M
         TbtiebEGNn2yJV+LsFa5B1ky+jEIXVKCx1z7WhaxIYzA74RRTnvKnIpEUlK2a2ejmMZo
         QFSEpK+1VE8z9BuuOr/xY2/N04hxigQfxEMgAQN0M5Ko7dsgE94vswV+e5gXKlPxBE1o
         GYVb2c5SgFTXv7iepTc/KkJCqksI7kmNaGU/u4Gl6nQQH1kX4E7rapPFN9jQhm3X7Tfj
         DABNXxYbtKMpaBUZvvl7EQkj0x9847Rl+UjaT1TFzkreHgOVOGUfX3HzskC8alTPVGmT
         ps0w==
X-Gm-Message-State: AOAM5308RVRKaoop3IHXu7qAWKRWcPZJxcTF/CmLPacyXNaK4QtPozmq
        IGRhgty5fcQ73d0vqLU5qz8ANQ==
X-Google-Smtp-Source: ABdhPJyhCmbPKiOFMh9Z48rlxvioHBI5YSAgRoSyK9zemZZxBIizZ5InFQJ8XdcUYZSh9zHXevCv8A==
X-Received: by 2002:a05:6a00:1a8d:b0:480:203b:4ccb with SMTP id e13-20020a056a001a8d00b00480203b4ccbmr260068pfv.25.1635535484778;
        Fri, 29 Oct 2021 12:24:44 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:ee49:1984:f0a3:a0bd])
        by smtp.gmail.com with ESMTPSA id c22sm7518317pfv.69.2021.10.29.12.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:24:44 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] PM / hibernate: Fix snapshot partial write lengths
Date:   Fri, 29 Oct 2021 12:24:22 -0700
Message-Id: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

snapshot_write() is inappropriately limiting the amount of data that can
be written in cases where a partial page has already been written. For
example, one would expect to be able to write 1 byte, then 4095 bytes to
the snapshot device, and have both of those complete fully (since now
we're aligned to a page again). But what ends up happening is we write 1
byte, then 4094/4095 bytes complete successfully.

The reason is that simple_write_to_buffer()'s second argument is the
total size of the buffer, not the size of the buffer minus the offset.
Since simple_write_to_buffer() accounts for the offset in its
implementation, snapshot_write() can just pass the full page size
directly down.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 kernel/power/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 740723bb388524..ad241b4ff64c58 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 		if (res <= 0)
 			goto unlock;
 	} else {
-		res = PAGE_SIZE - pg_offp;
+		res = PAGE_SIZE;
 	}
 
 	if (!data_of(data->handle)) {
-- 
2.31.0

