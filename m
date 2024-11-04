Return-Path: <linux-pm+bounces-16923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBAC9BADB9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CF61F226B1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F981A7240;
	Mon,  4 Nov 2024 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XaaNKC6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m254101.xmail.ntesmail.com (mail-m254101.xmail.ntesmail.com [103.129.254.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16918C038;
	Mon,  4 Nov 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707763; cv=none; b=T9UDIlamTZ+gfJMgBjuSfe1vSNWwLItMwehXkGt2eCG1iziOiFcCNF7RbOG4YrQs6uqFfkvtXiMFL+W6TQ3FCT9a96s+/w4mdNhVVJerRz+Uq61jhAt7lU8cKanoFTV9SfojHeHkRM3pfom4RzpJJWElzGE0qmXcSIE32hMKT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707763; c=relaxed/simple;
	bh=4j6Mjcq1lKQkcwIydEOgAZLeSymMQK6Xj+ogsucBgGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lCLkuc+xB/e/xreSFg+1zBv9kiemnsynhG2fDO+3bcUl8hDErT1V8VYbZkfiI+NBnGjba1ErmjtqcKRGWL25jYjjfL1TvFcSknAr84mlG7WG3jIHXauBSnOcaEefJW1aiQ4DF8zScsT5A1kEB8hGOV0BiqkqWkb9w1QkkLFh9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XaaNKC6e; arc=none smtp.client-ip=103.129.254.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b5f86df;
	Mon, 4 Nov 2024 15:33:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 6/7] PM: wakeup: Add device_clr_wakeup_path()
Date: Mon,  4 Nov 2024 15:32:00 +0800
Message-Id: <1730705521-23081-7-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhITVZJH05CTB0dH0lCQxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f61826b509cckunm1b5f86df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6Syo4EjIuQzpKDiwaNUk5
	IjEwFDBVSlVKTEhLTEtOTUhJTkhPVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpJTks3Bg++
DKIM-Signature:a=rsa-sha256;
	b=XaaNKC6e9jeXqryncvNsBaCCLREY+vONROjoHez11dB18+jm+UL9dCm5gu9pODOQRIl0A8t23sXpeJ+FzyI9QzD6BGxmG/KAnDhEVmefnISft1PjWZBhxdSPXQG/ed9FGHJlLxhwwOBy3cy2im1j7JNJ8kMwyN5lx0ehTWW8MNs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=WAt8KEoMkcRQkVhcAHLvz96VVs1tPx6HkdCub024pBU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

device_clr_wakeup_path() is used to disable wakeup path support
which is symmetrical to device_set_wakeup_path().

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/linux/pm_wakeup.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 76cd1f9..45405a3 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -94,6 +94,11 @@ static inline void device_set_wakeup_path(struct device *dev)
 	dev->power.wakeup_path = true;
 }
 
+static inline void device_clr_wakeup_path(struct device *dev)
+{
+	dev->power.wakeup_path = false;
+}
+
 /* drivers/base/power/wakeup.c */
 extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
@@ -177,6 +182,8 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline void device_clr_wakeup_path(struct device *dev) {}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}
-- 
2.7.4


