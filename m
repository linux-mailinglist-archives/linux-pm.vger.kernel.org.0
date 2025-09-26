Return-Path: <linux-pm+bounces-35451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0150BA3565
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1607862648B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF632EFDAE;
	Fri, 26 Sep 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/NchGsh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6327A92A
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882212; cv=none; b=MwyFTNE6sxWK0ioshv3AC1LuumGrM66zzd61bvzQxcKg1yVGUxh9QurhDJXlVNDrKG7cbyjbNUGWjKUtL7rjwQDOaNC4RWxe+ZQgg6kRK9elyRG6HerRBUmxkJAPm/lWScBKQxeohWkJvAAP/uSQ2AVWfsoABNZVN1Hmk4Hk/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882212; c=relaxed/simple;
	bh=4K0wqVJ9eczfWiqnopYF3vVChENOHFUsOcB5QiOAapo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNN2c8M6nvLALXsZqn3445f26mmNWtM1YpE1TKKQDWwyi5hUOY5sVH64DHCryYLcQqLRTRyU2uPgRK/ssGYa6VbSFUwrdXcCJkmwhObOqsnr3ZHs5G2zkg4cHZL6W2fu4GQqmLeMKLMcm1iYUK/+izoHXpKSytT+sO3o9oZycrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W/NchGsh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78115430134so538745b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758882209; x=1759487009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5mjd6nLxKs02Ww/P7pqDd7HAKGioYvOr/N7xDzcLcY=;
        b=W/NchGshZGkPeVP8GG7wOKY5VR+lybtOt9IlroG7tBRzFRTjvtjhl6REcR6cClcOYO
         6FVQAcXU2VtVyFJG0DE4GEDMM977Lpi+6PKFEOtYOHZTAWSUCpgM0MFj3ReMA7iIrn8G
         wVQbZvkXzlc+/wzhl0QR3qqYULLjbZ8DV5qro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882209; x=1759487009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5mjd6nLxKs02Ww/P7pqDd7HAKGioYvOr/N7xDzcLcY=;
        b=Nf6SKv6aZ9BEf+kFGRKOP4BpvuMZmrnr8fF9Tz3hBj8FMeXWQjY3/sucDTakRRQnSR
         lBa+hebkfWaM+9EaSlkIkgYpUyi4F8DuodeTfM88+ysmCLFYuHjHPf9uiEvhto9ln6XP
         x8DSXoDLZPob9meRXHEMgC88UpWa0ziIDTjpMckB4vfbu0kkiKBDezM0+9QadRjv+XZ4
         f5jVU8tlYCy7qvutgbjMijKjmLmGhdiQ9pErsk9WRkfWVEaUhq06nt4DuEtEKRhfT0ZI
         BZTRQ42QGn4iByM0Z65LufpLN6iSCgeaMBHIiPbPQe4P7wGpx4RAnJHfT+LCRZVSUzwa
         /Mtg==
X-Forwarded-Encrypted: i=1; AJvYcCXlcBCl2IxqXqqDq0qMMEKBUXFB+xcdQWh+TwE5kujWSiHhCcK33KgSxGwEAuOogsjY7C1dORKxPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsiGSxFadsMA9NLpXXGEUqX7jGjTl8XKmw2SV2RNELJDxRQGE
	hOIruoig5EvTV88JJ7djb+HRdzy4+BDgLwf7Bu0A8VjlmFFJV08MxgN9RLNFvHGzvw==
X-Gm-Gg: ASbGncuvupCkZktRpoXT/nDLOh5wivy1vPUQU36Uk1PnUKrxYCtgoGhL/4Or731KDl/
	+944FbIeOALAnRyPZp88s3v7a/u0hbeR40nCpNiJVMAIOjxbkjRU6LyxAztmXyhoDSwv7BiXhHo
	WAcz5xkQgM81SR4aQHF5+5KcnWSxsM4clxHD25oyjpapMM81hRLIubt67fUVaIg2ZO1jZCgZTWA
	T6/f0S2DDh7V9466PuEgcUWVn8dVjbUb+dTdqv20v2un8IACVJ/W1irGT6VCe6QCmsZ2IdmMcWA
	a7t8dyAbHCDh30qyhKqlMrBb5v4JY1fve8IJvxTGnaXD3CQA2Kj9vrBptir/ciPVwLA7cRGf3j3
	XUiQQvDF890lKEuBMXrQI3nh0tDAnpkbidH1iDEhPlOWmrWbqD7o6FrdUjcaqKGzEqQba9AEdz2
	xy/QATzhj/tjBQDkT006I=
X-Google-Smtp-Source: AGHT+IGYRUggPUFZvLH1WiVKpxyZzaen0jkQTx9Ti3sbPmMgM6KTc3sQs3R4T678nozJvNs7/WD6Ig==
X-Received: by 2002:a05:6a00:1896:b0:77f:4b9b:8c34 with SMTP id d2e1a72fcca58-780fceeb3b7mr7559015b3a.31.1758882208839;
        Fri, 26 Sep 2025 03:23:28 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:2900:382d:6893:1b9b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238f11esm4137236b3a.19.2025.09.26.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:23:28 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v4] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
Date: Fri, 26 Sep 2025 18:23:18 +0800
Message-ID: <20250926102320.4053167-1-treapking@chromium.org>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
and resume, and functions like device_reorder_to_tail() and
device_link_add() doesn't try to reorder the consumers with such flag.

However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
check this flag before triggering dpm_wait, leading to potential hang
during suspend/resume.

This can be reproduced on MT8186 Corsola Chromebook with devicetree like:

usb-a-connector {
        compatible = "usb-a-connector";
        port {
                usb_a_con: endpoint {
                        remote-endpoint = <&usb_hs>;
                };
        };
};

usb_host {
        compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
        port {
                usb_hs: endpoint {
                        remote-endpoint = <&usb_a_con>;
                };
        };
};

In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
between usb_host (supplier) and usb-a-connector (consumer) is created.

Export device_link_flag_is_sync_state_only() and use it to check this in
dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.

Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v4:
- Remove inline for device_link_flag_is_sync_state_only()

Changes in v3:
- Squash to one patch and fix the export approach

Changes in v2:
- Update commit message
- Use device_link_flag_is_sync_state_only()

 drivers/base/base.h       | 1 +
 drivers/base/core.c       | 2 +-
 drivers/base/power/main.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 123031a757d9..80415b140ce7 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -248,6 +248,7 @@ void device_links_driver_cleanup(struct device *dev);
 void device_links_no_driver(struct device *dev);
 bool device_links_busy(struct device *dev);
 void device_links_unbind_consumers(struct device *dev);
+bool device_link_flag_is_sync_state_only(u32 flags);
 void fw_devlink_drivers_done(void);
 void fw_devlink_probing_done(void);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..a54ec6df1058 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 #define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
 				 DL_FLAG_CYCLE | \
 				 DL_FLAG_MANAGED)
-static inline bool device_link_flag_is_sync_state_only(u32 flags)
+bool device_link_flag_is_sync_state_only(u32 flags)
 {
 	return (flags & ~DL_MARKER_FLAGS) == DL_FLAG_SYNC_STATE_ONLY;
 }
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 2ea6e05e6ec9..73a1916170ae 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * walking.
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_flag_is_sync_state_only(link->flags))
 			dpm_wait(link->supplier, async);
 
 	device_links_read_unlock(idx);
@@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * unregistration).
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_flag_is_sync_state_only(link->flags))
 			dpm_wait(link->consumer, async);
 
 	device_links_read_unlock(idx);
-- 
2.51.0.536.g15c5d4f767-goog


