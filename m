Return-Path: <linux-pm+bounces-34458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D02B5300B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA76F1750E7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830EB31A573;
	Thu, 11 Sep 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXz3Qi5w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDB31690A
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589672; cv=none; b=UPjJvnPj7b55OivR+jEdtWduzxAK2cMQjz3IhTydMU6X9KKDo5Xx68f/c3R9h2viN9iAi5Dbu//J10pwGD+yX+7KPvT/zV8+i9RiFQBnP28EgHWGMOMnCXHjI7Dzu1w2qtFB9TJcUYsIpuBHKlKrvpCzEVXHeifGwRU0njtPDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589672; c=relaxed/simple;
	bh=3TNLRvIIIO5E1aQmImk922JzA1orVPMcogbeRTNhSX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0vkY8CHoc/MhB/QstVfLBY5z8HZE08zSra0HoXHQz5TLZEhoPVe1TC/bo6TyclQAWEIpsLNoP0ixzTtCqVoQvCI5Fe3QSOK9tBmhckip3DEHBuINn/H4VVLMcHixZqxZ7v6/M6dM1f8lC70XlrvJddznEHwrcRywFeneFyuRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NXz3Qi5w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso470323a91.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757589670; x=1758194470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF0oLv1QZxcRX5GA9t4zDBjjktfeu8VTvkACGPsXZYw=;
        b=NXz3Qi5wZEg9EUrUMkcCR7/M0aS+cKvR4JOQ34yCXe8mm4pXI7fBAgBZ3KthZVtqd4
         KHck7NUnXXj5AF7SHW2UctCO3GpCM+wueLiM97schKk3rui9IfuTemQlYdjZChFwFT4S
         LvlYpkV9XIwwSrsJuxX7i1KrliZ5qVd8bpNv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589670; x=1758194470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HF0oLv1QZxcRX5GA9t4zDBjjktfeu8VTvkACGPsXZYw=;
        b=V90PR5nwG9bxGiMSDbOgoC+59LJCmtpvwNgPKA1vQqybbmNFDH84MAJRZsAHEt9hxe
         qnx3R3hwo70S0zgGyQ+qfIUZLIBhC6EOOa6PdF6wrYxLQ2QBSXF0wrKg5G9TSlIaSdri
         d0Ox08+Bwo4Dk4jsda8t3UpQau9oqiw3sibBPZGLO5DNgvY5XoSc8P04V6XG2lh44MVj
         FJguRQ+XFMMknJK3IajquW/bgMhGiplsrkCVaRhPTWsVDJ5ykdTkR1QLawRsO4HO0Zgg
         GpiIn9awv0VdV0RdZI84awBpL4o/dlCAcFkH0oR734terpZa2QilqJvx5hw6sVVM1+7o
         Q4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8vFNu5N43wBQyLlpkHHmHskWTLyEx/o2w133sS8T24aTHXiPWgQYdoZEKoAhHAcS5jDK2ug3DIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdzWnnXU29dOfCd716R3J75E9EET8TtLfv4cZONIJ6BKUTwbx
	DWPLyHcXDVGKtf/wnj7wjVyBc3177LWC6N0AFvAsrCgqvUy8j+KFCS9BEA7lsGnnCw==
X-Gm-Gg: ASbGncsNfhZWrRFXepBMrFG0cDkmzbrypRUrS81YCafdJizvkAXzXLi4Fs+jVSbVfUf
	JLRikgHxyRpcP6wuBkz4sYFDcTB41g4caVttgcaHOQmaTwI40sovGmJKt3miABtI3fWTay1z3BH
	/PsXkmmvpL8hhndZP6JSxWDj+VbZm0IBOIVa+r6T3sQTuEjoJqaIYKQF5KR6XvJFpevc1dbDZod
	71RfNXBa8HvUFEeS9wj4kMMPXGbkpFVnXhHbhxSfhB+5BXgsuyuLMcdCcm56UMpBXu00Jik3mcB
	vUMmOVXaf85D2I6+P8BGUrgmdOuPSuZGSdJFwuBza76KPAK21fBdsvxF2tLJ9Rg8WobBz3aOM+w
	7LA2PdyFil3YbTcMAEswjFPNgpnapiNl5RWK92qoxFG55wS5TDZlXKuhq9FLFqhJTb4mukqCuXP
	2tbD4NlGlKp0QtbtTG6iw=
X-Google-Smtp-Source: AGHT+IHCkie8m/G9u6bPNIkvsO2PyuzW+5ryRti5Fx6qIUdWsTUmZQ9uODZMkmow7HkXdJEQM1TZ7g==
X-Received: by 2002:a17:90b:2f84:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-32d43f7df93mr23959038a91.20.1757589670312;
        Thu, 11 Sep 2025 04:21:10 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:af0d:1ce2:1c09:33c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6323774sm2348048a91.24.2025.09.11.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:21:10 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 2/2] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
Date: Thu, 11 Sep 2025 19:16:03 +0800
Message-ID: <20250911112058.3610201-2-treapking@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250911112058.3610201-1-treapking@chromium.org>
References: <20250911112058.3610201-1-treapking@chromium.org>
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

Use device_link_flag_is_sync_state_only() to check this in
dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.

Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v2:
- Update commit message
- Use device_link_flag_is_sync_state_only()

 drivers/base/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
2.51.0.384.g4c02a37b29-goog


