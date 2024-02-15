Return-Path: <linux-pm+bounces-3959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCFB856889
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02CE1F25F44
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA7133409;
	Thu, 15 Feb 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJumb62/"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440B6341F
	for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012307; cv=none; b=mAVuZyJ3YqgdwIFhIoRUECA6LzpWCEuezay3QauCkyWOU5fQH6OwBApS9lzYRYm9oLGDEEmTFli+ur81oe+LekIort7UnVEi0pb+tUbuUkrcmklOb8KW5C8KCU1OceKnroXMnRKEzlNZYFVYpydE4JPwxDQkT52swOKAxtwXx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012307; c=relaxed/simple;
	bh=dcxHchKdgCSpzKklCc/1+Mqnv/FF5OPZrTxJ9etuOxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jN+RPlpVQKle8E9UhIYyAFeYrT76ZXF4re1c8wyKArIhCNdHaYnd9y1i6QMJvaSueDdsLktMDCTW2A7fKCDMDhVm5QIYaof/xeRTqaJ0Nc9GD+d46uY4XFDNNhKG2YIm2bDUzjzVEGc4ntlsoQ452HXZkJQRVyM4+2aVg1E7xXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJumb62/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708012305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=knh4HV4gATl1xMEbyc8r3QE4iatQDzgvoLnbJLPVnAY=;
	b=XJumb62/uCwg25m8HNPg5/YWgLcfBJo3PsnfvlNGhCYDDcoG/AnjmVbMi+bQBkZvwIUWOp
	aJutQeJ4/McEuKHN2Et88qey0El5QzFx3d7aIh67OUY8bQJB0UZy1oUF17IEGySN7eNKjW
	aZ9GZEAGHoLV3jHCjJtZsxabvi1IaQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-DHzENEn_P1uXcAMtaPBDuw-1; Thu, 15 Feb 2024 10:51:43 -0500
X-MC-Unique: DHzENEn_P1uXcAMtaPBDuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41B23811E79;
	Thu, 15 Feb 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6EADBC185C0;
	Thu, 15 Feb 2024 15:51:42 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Marek Vasut <marex@denx.de>,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: bq27xxx-i2c: Do not free non existing IRQ
Date: Thu, 15 Feb 2024 16:51:33 +0100
Message-ID: <20240215155133.70537-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The bq27xxx i2c-client may not have an IRQ, in which case
client->irq will be 0. bq27xxx_battery_i2c_probe() already has
an if (client->irq) check wrapping the request_threaded_irq().

But bq27xxx_battery_i2c_remove() unconditionally calls
free_irq(client->irq) leading to:

[  190.310742] ------------[ cut here ]------------
[  190.310843] Trying to free already-free IRQ 0
[  190.310861] WARNING: CPU: 2 PID: 1304 at kernel/irq/manage.c:1893 free_irq+0x1b8/0x310

Followed by a backtrace when unbinding the driver. Add
an if (client->irq) to bq27xxx_battery_i2c_remove() mirroring
probe() to fix this.

Fixes: 444ff00734f3 ("power: supply: bq27xxx: Fix I2C IRQ race on remove")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 3a1798b0c1a7..9910c600743e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -209,7 +209,9 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 {
 	struct bq27xxx_device_info *di = i2c_get_clientdata(client);
 
-	free_irq(client->irq, di);
+	if (client->irq)
+		free_irq(client->irq, di);
+
 	bq27xxx_battery_teardown(di);
 
 	mutex_lock(&battery_mutex);
-- 
2.43.0


