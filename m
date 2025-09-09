Return-Path: <linux-pm+bounces-34229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6247AB4A89F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B47BCEE8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D22D0C63;
	Tue,  9 Sep 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9hEuPpr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419E2D2496
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411063; cv=none; b=Piu+M2DX0tqE3b/3WnyqhpKEe73L1km4Gl5NTaRPpmbWNGCa+GWyS8pZYrqbAaQ0qa2qXpbBDp/XdJSespxD4LRGx31BqUJX5vRmWmZoObJlDki+/KQ8VO6hyy0Yh3J2TfUu1z4i95bMW6ea2d8B8OJ6rHyANOfAx2W13Sjt7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411063; c=relaxed/simple;
	bh=eLy6bDCevS2tNK9rNs6DH/hKKBVbYKeLTD6U+wj9K14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdSXgrupqeUoZ4A5Q73ZS+oJcSF7MDTEwXIZ0HqId4AamFv0ljCgSwcN5LuSkJnBoL4JlisbVY8BLNI6ttZ9zDMO4//mwP5h/baKRnPTOfphfZejkjgTVEa3jfgrSeRxST8UxeiAaukJIko+ZU3teW8vvjI7qNhB0qiGho3NBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C9hEuPpr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244580523a0so58056495ad.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757411061; x=1758015861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNSKqA4FeSJiysOxNOABoHv8THsX2hgL8yWWgcs2JIU=;
        b=C9hEuPpr6p/YMxskQJeReNOhXTPdo2R0pBdCsdvUC31HskzClwu55ulTiVeXKmHJ2D
         VhVVXf8US0HOJ8yvfoJWB5e7sJgAzz6vsbKlBxFKEy9ZFokK0R6AVFLqpvZQWO/EhcMs
         4B+6C6NrXacxXimtYrpi3C8gKvNu6YbXAwkQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411061; x=1758015861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNSKqA4FeSJiysOxNOABoHv8THsX2hgL8yWWgcs2JIU=;
        b=wNRCXvzjwjaby11Vg6E1+U+epngMiTesNoHb6Q/sbhdwMYWT1kL09kb1gTVz018vUw
         k674wFW5A4C8NwFHjKvvzvpi8wO3TCiDMjRcEhsFYIhTZ1lu/dMGf0oDUVKl5mHfeGug
         KPP6zK09tu6h5NnngV3McFNbgFbTxDnjHzzQt7Wx0tcQfTpwDBOaEHdIikF9G3MMWRUH
         apYWmPf5+LMK/T/KHsRsata6XpzvsKijTYcjy/Vg4NTBAK0faVt6FGOhb1RMtlm5IOWE
         rHlyLAnWUICxnQ8YEJctIe/FF3JCxn3Ec2PlfkX3aKuUo8s6FTogNKsXPYjNn1hWgE+z
         OzKg==
X-Forwarded-Encrypted: i=1; AJvYcCWoIPWa7zEd5j/1yIC2dVMTNmOi8UMRHeIYc9rAXQr/6weJaDxIWlfDPrDjVjLGmw0CYZY1kJFjEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvv7+JWo2P/9R4O406LLcTLRGSM27YpEDoMtXbnFf+tcTptYpT
	SLSPnjS8zbjsHZr4hCZF4GsY4NVBes6yDMkPnXssPmCFZznux4NOLpORDDrBxzLOAQ==
X-Gm-Gg: ASbGncsV0q7gNCbez0e7kUOtj31xW2LbeAnHFIhMIc/r66O3o3/83nx0bverj9WFhJV
	BLyATkk9DZ77tzS2duQmOnuiHp/TU3L2FHXaDBJ9UH8y9uAQNi3zA/Ybz8KbsuaCVqf0zuISA+/
	wLRj7VT9RgsPz/7Dba6+b+BEqsSvP2UHDmOapIPZK5OkNpSDOGLilwi8Hi+2/viTuIaDC8UCRBp
	G7q98RNTC2FJQdgYBhxfsRJjTL30F0ZErKHfWZun/56ILyQdOpXM6EFenLwDL6HduFZdPQgR0d2
	ufdUNIBi/oz5kWeimmnJhnx5RlvTABwZQsMnJxZl8wrERqvoygaZ3sBati81FicDFmMggC7eMei
	t47ZHwEOI8g7lzi6Pb9DN77GmQIqVEoknprGVlZj1PPd6tWeGWFEV4i/o1s04T+zc0n3Gno9wz4
	lrcAt80EKtVsXxNHN0/uc=
X-Google-Smtp-Source: AGHT+IEJbCkMk2WOO7Rli+cDTTLMIoXQSbucT4RRaZh+UkjjwMN9fgCH9pmoHw713wmDTDIQIB2SnQ==
X-Received: by 2002:a17:903:2ca:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-2517286296cmr132776965ad.55.1757411061526;
        Tue, 09 Sep 2025 02:44:21 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:c214:51cd:3c3a:7a03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea628sm120471065ad.6.2025.09.09.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:44:21 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
Date: Tue,  9 Sep 2025 17:43:30 +0800
Message-ID: <20250909094335.1097103-1-treapking@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
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

Add DL_FLAG_SYNC_STATE_ONLY in dpm_wait_for_consumers() and
dpm_wait_for_suppliers() to fix this.

Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/base/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 2ea6e05e6ec90..3271f4af2cb65 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * walking.
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
 			dpm_wait(link->supplier, async);
 
 	device_links_read_unlock(idx);
@@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * unregistration).
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
+		    !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
 			dpm_wait(link->consumer, async);
 
 	device_links_read_unlock(idx);
-- 
2.51.0.384.g4c02a37b29-goog


