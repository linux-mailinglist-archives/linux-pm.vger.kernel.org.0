Return-Path: <linux-pm+bounces-34557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842EFB55230
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEEB18985BC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6E310635;
	Fri, 12 Sep 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ign2kE1j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EB2264CD
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688486; cv=none; b=QcGAmlKDirVxtKAZqRd0IpksOpqoSOHwR8Ftqb4weJ2LYY2ogFDbYJKNBBbPsCq5JcvDPkJRcQFxRdlzXqJtcyl6X5Z7JHYIlw/2jTn/03gfH/iws8BidwR1k1QYtEQcb+PNNF+UyiOZzKzNAQDeH0jIL2A4Nn1dNv1P8kzH+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688486; c=relaxed/simple;
	bh=Yy5SXGkU+dfrrg0VvHW6KEb8jA0uCNGXZ12r9AAlWcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gS6bHECNeFjYAqEVmAEPCh0M1KhWXbAZB5MVNqw7epQDmmQlD36IivptMJja1+aqNxRDMj8/Y6Sb0z3xljY6NsyURJQuf+ve8AF6TYbHigzLAz5oIeW57+tDBM05SSnWeFGSEYnWxqxKiCBIDjVIG9pjtm6K4Zi+BEVYczQEVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ign2kE1j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24eb713b2dfso17289755ad.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757688484; x=1758293284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yxEB70AFkeGldP2C4gWWQqO1ZnbDO4yOVeM1sfcVx4=;
        b=Ign2kE1j2gc9zqcos39L0KcGzBtvpqzSQP5c+xV0jm2JhkFiQMDe0gDV5KTReT0KVS
         ThnMOBDmwBXl4h6v1Ixq1lgwEIcYbFzUTApWZvM8txP+twRf2jLH9if4UH/EEqeCFdWL
         GAIyfflwNANpymDJ3gmvenQtnlGn3idYcFT10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688484; x=1758293284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yxEB70AFkeGldP2C4gWWQqO1ZnbDO4yOVeM1sfcVx4=;
        b=jfe/BxNt+tw0yirO5ZBYKATkvJ7KFXQEv6SToYI60AFgm/NynBo//fvCPTUPCb9kH1
         qOjPcKsGlE9FnGeCssDWWmUusO50DgQuUTrgqMryrPIt80UGv6A8jZQIXmspMICMpB3B
         qFUUE1D+wbXUv0qGAxc7uZag0KMMIiSKOTn8ufjvOwQL9D2EgK4bBGCloXjY8cxJxB+N
         KGZ0To+hGtPg8fiCsHOF3xVHtbexw+58Yoq76WDVnOWO4SegeuxDPpKsxoWjFXTtW6Yk
         LGr7tWbdu5RUoPrQPvqEQOgKhzYDWB9CzVIaR0MF+Aerj2BWtWBpbzCb0+vuV6hIdlcp
         a6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVddHN52bIIk84P38E12W4HR+IRSwsbACdVAx3Tghs2ZGaqI+Op2mj0H3MECvX9L63nHqbsNGzklA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJp/Q6QYloEueaTm2a8519Zu/YuLFTq0lQXR9/X1uGB2JWYy8
	dxt3oyxoVHfxmRlfqr1sXWz9WuQy1VRzcflzAqh1BUO8jevMZUTiFy/pBLRRzunzkg==
X-Gm-Gg: ASbGncthfrbb5hl1oM2WVOWYHSCpXckmKLSO2AvpKnoCSTauDa/EbEefkI1LSEefiZu
	T8BnpRm3WmjZanY2G/74zbflBtHOpcEfZczCvPhZh7rT/mGyL80R3kpeonTC99rm+N841wHf8ZM
	vwYm6CQJT1HSmd0l3Kk11/9aFw26+XcFJFA4bmP2y7lL7TGwh59L2Ql3hLHKPc8wOR0rrxJuExY
	i8hIsMCy+vKwjLgPeRDQl3o/NtnhlR7Nfrb1n+oeZ7tZNetgVE7mF20PBbJewbCL9xygGn4lNIx
	EW4SKVFt/6vLAehVLyaGPHBamD6N18CjPTwyYILWoWhwq/qq9g5pV1RgBl63YkhVnMizBRTsloK
	HSAgU7thi+kL1EDCrQoiTLeIddzQlAPby7bP4bs5YZYubxxMfW8bBEE597O6OUKaTZKxsYjn7e/
	ay82IUVKkw
X-Google-Smtp-Source: AGHT+IEPimbWX9IBV5n2l+0Ugiz/uhskkY0eUSm/DiWJXOTN+IfUI4glCrLUVfKmtCzUPkmJFCqwBQ==
X-Received: by 2002:a17:903:32c4:b0:258:f033:3ff1 with SMTP id d9443c01a7336-25d242f314bmr43662285ad.12.1757688483924;
        Fri, 12 Sep 2025 07:48:03 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:97c5:89a8:4826:4337])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25d9c7e5b2fsm21338855ad.85.2025.09.12.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:48:03 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-pm@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
Date: Fri, 12 Sep 2025 22:39:07 +0800
Message-ID: <20250912143911.445452-1-treapking@chromium.org>
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
index d22d6b23e758..741aa0571fc7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -287,7 +287,7 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 #define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
 				 DL_FLAG_CYCLE | \
 				 DL_FLAG_MANAGED)
-static inline bool device_link_flag_is_sync_state_only(u32 flags)
+inline bool device_link_flag_is_sync_state_only(u32 flags)
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
2.51.0.384.g4c02a37b29-goog


