Return-Path: <linux-pm+bounces-24537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA7A71E4A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D085818972C5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C624EAA6;
	Wed, 26 Mar 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IG4wIeSx"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7124A07E;
	Wed, 26 Mar 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013591; cv=none; b=f+w+UBTQ6E5k+FDcALfnD3UwIqwKmfuzyIbv17jRp0etIMYH20uFF0EGn+v3A3RgDcKG7AydSh1g1qr7EDaJyEkooKzRUqeHBaqLogtG8L43aIosgpi0j1asvSpOJlxpA/yxaajSbnEoJ4vrRLSVlbCfwJmWj6ucajsF1IwWXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013591; c=relaxed/simple;
	bh=gn+/v6cRhBjIEnPOAF3lYIh+p+xfjG6vTeeGnJcNiFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hl1Kp9nLAUkEG/IO+T/CAudZctrqkmAZ8R5imfWMo7PZlU3az4V4aqVByZi04R1aYj0Uocgv/Re00xUCcnHk/n4w+i55Wa9F/4GTnBlQISPwEkhRTHS2gKjEBXQP/Fh7TPq2M5/FKbrErKmca+7eowW6r5JLcI8ZgYpwJjuNrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IG4wIeSx; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 672D244440;
	Wed, 26 Mar 2025 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPoylJSd+/GX5nIi3NjyD3T+AJXrnqwS94Z+NkVmwp0=;
	b=IG4wIeSx82JQe6FTP9/qWcU07pXwenyenDJyN9FrAyqWIFDHWiIE/oy3aFzdY3FhHKOSDD
	50JvAh9Qmy+OUMb5NAiH2g67l9KrDBPqFyOzKw6kOr1EB+29HgcSeqUeQCmnVbx+7vXlQi
	fn3SIzEYxe3pF41EmeOhfgMSpeHMqkZlWFB9tzJuGU2epdcqDjeywlOoOMajxy/Tg4lkhu
	pA2P0US/bMWr/JlXUUiEfVjz8QoKXowUGf1BbeTgSEvlbdNMiBxKlJ8NgAYH16iBasJgQs
	XAGFxwrt66doiVBqz0NtuA2PiFPmot3IwWz8tFLglIJSVIhXxW7p782i5XIJgQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:16 +0100
Subject: [PATCH RFC 01/10] PM: runtime: Add helpers to resume consumers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com>
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
In-Reply-To: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Kevin Hilman <khilman@kernel.org>, Fabio Estevam <festevam@denx.de>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-imx@nxp.com, Ian Ray <ian.ray@gehealthcare.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Saravana Kannan <saravanak@google.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqihhmgiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdpr
 hgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhhhilhhmrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

The runtime PM core currently allows to runtime resume/suspend a device,
or its suppliers.

Let's make it also possible to runtime resume/suspend consumers.

Consumers and suppliers are seen here through the description made by
device_links.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/base/power/runtime.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486bc73225b3e971164466647b3ce6d3..04bb66c18e3e4a45751fb3f9a6a1267d73757310 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1841,6 +1841,60 @@ void pm_runtime_put_suppliers(struct device *dev)
 	device_links_read_unlock(idx);
 }
 
+static void __pm_runtime_get_consumers(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				device_links_read_lock_held())
+		if (link->flags & DL_FLAG_PM_RUNTIME) {
+			pm_runtime_get_sync(link->consumer);
+			__pm_runtime_get_consumers(link->consumer);
+		}
+}
+
+/**
+ * pm_runtime_get_consumers - Resume and reference-count consumer devices.
+ * @dev: Supplier device.
+ */
+void pm_runtime_get_consumers(struct device *dev)
+{
+	int idx;
+
+	idx = device_links_read_lock();
+
+	__pm_runtime_get_consumers(dev);
+
+	device_links_read_unlock(idx);
+}
+
+static void __pm_runtime_put_consumers(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				device_links_read_lock_held())
+		if (link->flags & DL_FLAG_PM_RUNTIME) {
+			pm_runtime_put(link->consumer);
+			__pm_runtime_put_consumers(link->consumer);
+		}
+}
+
+/**
+ * pm_runtime_put_consumers - Drop references to consumer devices.
+ * @dev: Supplier device.
+ */
+void pm_runtime_put_consumers(struct device *dev)
+{
+	int idx;
+
+	idx = device_links_read_lock();
+
+	__pm_runtime_put_consumers(dev);
+
+	device_links_read_unlock(idx);
+}
+
 void pm_runtime_new_link(struct device *dev)
 {
 	spin_lock_irq(&dev->power.lock);
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d39dc863f612fe18dc34182117f87908d63c8e6d..151c885a3f421f09509232f144618da62297d61d 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -89,6 +89,8 @@ extern u64 pm_runtime_autosuspend_expiration(struct device *dev);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
 extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
+extern void pm_runtime_get_consumers(struct device *dev);
+extern void pm_runtime_put_consumers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);

-- 
2.48.1


