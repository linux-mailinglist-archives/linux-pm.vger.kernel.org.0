Return-Path: <linux-pm+bounces-34457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD5B5300D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09FB482B1D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE453164CF;
	Thu, 11 Sep 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aU6B+iof"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A53128CC
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589670; cv=none; b=FHsyq4l8TJ+pa+AoJf6O8u25l9ryjMCM//fS28N0I6KNyi22fn8ed5aa7KI4ipCYqnDX2raS++6xXlgIQYPyyapoKZU0XNPbvQhc5V/NN6W3JVwW+qWUwQBmJh0eskCABH15SV05ab/2sbG5LvfdB+X4rM0JnIf8sjDzrF5cLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589670; c=relaxed/simple;
	bh=NR9ColaEp8pp+MDi+BdpeTN3bf0nrTUvX6PQQ5WUA/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VptxLdSGAYbjHXW7EjfX1OGpegc5Fb9oqBHCNLMXyWdNyDqQ2AmpdSlprlUoljfLyFtGa7GLVoVWjS6+7+z6O6c4jZR9Z88D9UtN1djgHG+cowNFtq/hbRzU1Lf+SN+PQxgLaQY6BmBK9LEDRR9aqYYHtlvL8aUF7vFkHMd8+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aU6B+iof; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso535494b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757589667; x=1758194467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVY1vKQIEXT8t/WKhvqXo/qXgJTq2qVTTi36FllHflw=;
        b=aU6B+iofyhJ7UZ0XGl3xLQFn6hdZn7+mazPXZ6JiuGjfQ0MzKjk9m17IFyt/iGOLDO
         8+mRJywySMS4Er9zTnTQSLsvbxTNOubWZgPYj9YZqlHXeI7TIIy9PfkGTqUzVl65FPJU
         bYt5YQYvBSEIINW5PTKgUhYJIBG7fLztk4g5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589667; x=1758194467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVY1vKQIEXT8t/WKhvqXo/qXgJTq2qVTTi36FllHflw=;
        b=QRxH5/BAaZoKg8pD63MxhFzhNDUh/d9A1SdpAOdviM5bRlxNiI5L58jsMF4qFD8V3X
         i4B4/+y+Dst7znmAte7SffL+4bUH47f3GGqci5OMu/MBmoXZ/JA6+UZpsFD6ptJwUAGE
         zQ0Yfv9cmjgZj3xudEwK5ll7v+BhLZAukUTLJpJrnQ3PnvkA6YNu1lqZCe+5Kp9azDmX
         GXg7ZfA1/AXt0ZFrhmsCcpv7gOdioPfRx1mHaqwhzswemTmXTxYI4fk1naEDBuU8nxhX
         3GdV2qfHKjFRjwlWQWEvKJ554lPQxnvW3mNKwYNBsK8yDnGFy6g1we9r1EdOYF5qqFbD
         My5g==
X-Forwarded-Encrypted: i=1; AJvYcCWQuVKeHm7k0UUhbg5ywJIopctKjDTDBgetpvoqrSy2SlPfmWseccleYJnt20suNz6p45h+9B/8oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFUxC3WnDAUe6pEkz+oNeLY3IBlbIlnLhBmr3C08aUW0bSQnW
	5JQ+K7YRGCB4rXEbU5ufqlwgKRAo72wMql9zxUvqMcvXv5y2md7cIP86ozQEtmjJGA==
X-Gm-Gg: ASbGncsBlWaXepmZvFvdeVUcF8rTnv9irs/X5kAVAW8odjy5f/CCi2ucy815h1hI7qn
	ZuQXdvJzEyJgyGI5nYYA25aDAtBvpPgkr5JRsaHIm8cUTJxZn5GoB0+wGS30Zy4MyZGBvIdjM1l
	+UjGqhjdeoZMXpWKpr8w87hiVoICcoKY+M9QlS9jf9T5AVvVLieS0KwKo04oetsPtmSTWucVBcL
	e8pp96GFRq8ZfZn1lUy7DZpLMkjWbFxNay8+7mkJrF3hj4bnzyTsNjefEi3UrKS/WJ13LdAywFY
	wxhQSGhhR5S8LDQ2iD8ZWE/dHl46s5PTGjQYG50GVM6nGBxVaNeSID93y+hxU2/vEsA/VvXlxwk
	N3XQJhQiRklwMbA4Cgv0XvJ7Hj/GsTOeOmhsOzA0+shhe2RMZd21l577zr2Kd24P64q8iesRYxy
	OYipuz/YaRjmWwHcxh3rA=
X-Google-Smtp-Source: AGHT+IGVYqzudMtnHrOEkbS6RmXPv8F+J1exKZWh11FdOLHldMMRIEyAHOkplwmjDYM8xR7w+eh+AA==
X-Received: by 2002:a17:902:e847:b0:250:c893:6cc1 with SMTP id d9443c01a7336-2516c8957d3mr201383595ad.8.1757589667592;
        Thu, 11 Sep 2025 04:21:07 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:af0d:1ce2:1c09:33c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6323774sm2348048a91.24.2025.09.11.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:21:07 -0700 (PDT)
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
Subject: [PATCH v2 1/2] driver core: Export device_link_flag_is_sync_state_only()
Date: Thu, 11 Sep 2025 19:16:02 +0800
Message-ID: <20250911112058.3610201-1-treapking@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export device_link_flag_is_sync_state_only() for future patches.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- New in v2

 drivers/base/core.c    | 3 ++-
 include/linux/device.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..cc6af9b0d59d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -287,10 +287,11 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 #define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
 				 DL_FLAG_CYCLE | \
 				 DL_FLAG_MANAGED)
-static inline bool device_link_flag_is_sync_state_only(u32 flags)
+bool device_link_flag_is_sync_state_only(u32 flags)
 {
 	return (flags & ~DL_MARKER_FLAGS) == DL_FLAG_SYNC_STATE_ONLY;
 }
+EXPORT_SYMBOL_GPL(device_link_flag_is_sync_state_only);
 
 /**
  * device_is_dependent - Check if one device depends on another one
diff --git a/include/linux/device.h b/include/linux/device.h
index 0470d19da7f2..e27d0bf7c43d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1197,6 +1197,7 @@ const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+bool device_link_flag_is_sync_state_only(u32 flags);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
-- 
2.51.0.384.g4c02a37b29-goog


