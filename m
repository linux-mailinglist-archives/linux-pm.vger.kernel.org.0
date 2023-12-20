Return-Path: <linux-pm+bounces-1391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C518195BF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 01:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5841C1C23EE2
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C670210A;
	Wed, 20 Dec 2023 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6wHUvC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9823AF
	for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ba2e03e21cso3503626b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 16:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703032546; x=1703637346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVIqEmxOFGrdJ9VzcnxPa8VmDc3wzhFPf9Yfc6yWDcw=;
        b=U6wHUvC5oGNVpvtUaN8QksyCnr2LIIab2+SEHUdZete8MCK+M9aqr7jSvxWzvrPSP8
         8B8uslaulkIpXw2VWVoTo+TiEob97bs7UcfIR/9cm1pIvODStZcm6HxKI5vtAEsjjFkm
         vewU7BQuQVwX2OljGhz+Okhwo0oj8T/WiFo9mDqoDFCyEXLyXQHnccXKDojNmnnXy4Zf
         oWImWoCRaTKHvafzg/IddxcXL6Uw60RkxnNlHUi0RFZUzBlrXQ2jxB8dJf9kbkF3UMn/
         RrM9R5lM6q/oHY97qSmB3Smpfma67d3JKEO6lVtRvv1cc8hP2TY6nucEEdqFtSeqvXEu
         yMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032546; x=1703637346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVIqEmxOFGrdJ9VzcnxPa8VmDc3wzhFPf9Yfc6yWDcw=;
        b=P7/+dHaI4CHqyICRBwfEFEsdvVsuwaujRrGdTEU6FoKcNrF+8WQo06Y53FiVhBG78P
         b53vRE2DUSt0e/pu2ANBKDCLMvfAc9pULfvL4mbyRcIWpdPnhyk5JiXFBtfOzmpJ+wY3
         BmhsgPqEvKPbuR/h+BzaXKRzhlvZKxq93N3Fw+/yvqSzLlQxUUESIvJQ94z4Y9qg1W9y
         SfwzlY5+uxHYOq3gkMxe/fL6zgwTiu3co4CgstAYfbh5oBDJknBZo/Q9ywfa30hUzlmc
         JgVq24LcgJSpkU618+iqa4nregYP/jI6L8DIwo9gLnNz67iW7w+fLmRTH7IRsXg3OAm0
         5Q+g==
X-Gm-Message-State: AOJu0YxR+MicqoYaeMU65k7s726MbiaiP6NH83ZQDMsMZEeeJBvooVUF
	fy8vhZ6SEjTijlYvUrw+o5A=
X-Google-Smtp-Source: AGHT+IFU4jHH45pDWmTx/skYyydg0A1jH4eyQn6uhxNTmmFU/y2zXsZQIKbPHE7+rgVTGOoo3I6LrQ==
X-Received: by 2002:a05:6808:6549:b0:3ba:12af:8325 with SMTP id fn9-20020a056808654900b003ba12af8325mr13720634oib.111.1703032546261;
        Tue, 19 Dec 2023 16:35:46 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id cn15-20020ad44a6f000000b0067f6ebda88asm128187qvb.1.2023.12.19.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:35:45 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: Remove obsolete comment from unlock_system_sleep()
Date: Wed, 20 Dec 2023 08:35:35 +0800
Message-Id: <20231220003535.714831-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the freezer changes introduced by commit f5d39b020809
("freezer,sched: Rewrite core freezer logic"), the comment in
unlock_system_sleep() has become obsolete, there is no need to
retain it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Remove the entire comment from unlock_system_sleep().

 kernel/power/main.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b0..b1ae9b677d03 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -60,22 +60,6 @@ EXPORT_SYMBOL_GPL(lock_system_sleep);
 
 void unlock_system_sleep(unsigned int flags)
 {
-	/*
-	 * Don't use freezer_count() because we don't want the call to
-	 * try_to_freeze() here.
-	 *
-	 * Reason:
-	 * Fundamentally, we just don't need it, because freezing condition
-	 * doesn't come into effect until we release the
-	 * system_transition_mutex lock, since the freezer always works with
-	 * system_transition_mutex held.
-	 *
-	 * More importantly, in the case of hibernation,
-	 * unlock_system_sleep() gets called in snapshot_read() and
-	 * snapshot_write() when the freezing condition is still in effect.
-	 * Which means, if we use try_to_freeze() here, it would make them
-	 * enter the refrigerator, thus causing hibernation to lockup.
-	 */
 	if (!(flags & PF_NOFREEZE))
 		current->flags &= ~PF_NOFREEZE;
 	mutex_unlock(&system_transition_mutex);
-- 
2.39.2


