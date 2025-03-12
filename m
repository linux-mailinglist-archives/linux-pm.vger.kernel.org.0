Return-Path: <linux-pm+bounces-23911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F28AA5DAD7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D71D17A1A4
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E223ED63;
	Wed, 12 Mar 2025 10:47:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC51DB124
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776452; cv=none; b=r/cyDepITVYOVA2bQKqNNfth1A1Onh6gd206ZHrPqcvMkLCjaBZN4QR2Zeus60Vk4lyICz6va9flcJFAzzu7y3ety2eIjLhCnrxQ8PYbgRcGbyfICLY1Fs/a7j+iCN0IzVw6AUCh1v8gHOi/wEUW1oA9qqbH4TtTU0DLM9c9Szk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776452; c=relaxed/simple;
	bh=3xsN0kx24BXP3yguHMFGTD7H6CnWMEE7M3OPME5SAFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0TCWmA2Nc2YoIuF7w2fvivcmlY6uFgzk+c73BQDjaIJEnFDuozJ9PwumuheZTwOpJ9s+Qjjaw8A7NJj6KDcyoYzP00XV+ZyRBFpZyaS8HAYRN3z6U22wVN0GZeKp+gE4IYnJ42UYBLwIuYyf5EG2i77+4ZRyiwWp/sGeHR/Lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:bb30:6286:99f4:5b9d])
	by albert.telenet-ops.be with cmsmtp
	id PmnN2E0014xs17S06mnNQp; Wed, 12 Mar 2025 11:47:22 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tsJc2-0000000Dg35-1VaC;
	Wed, 12 Mar 2025 11:47:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tsJcQ-00000000Rr8-08zI;
	Wed, 12 Mar 2025 11:47:22 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM: core: Fix indentation in dpm_wait_for_children()
Date: Wed, 12 Mar 2025 11:47:19 +0100
Message-ID: <9c8ff2b103c3ba7b0d27bdc8248b05e3b1dc9551.1741776430.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The body of dpm_wait_for_children() is indented by 7 spaces instead of a
single TAB.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e4103d29a21a6b2f..2fc37658b0b582e2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -249,7 +249,7 @@ static int dpm_wait_fn(struct device *dev, void *async_ptr)
 
 static void dpm_wait_for_children(struct device *dev, bool async)
 {
-       device_for_each_child(dev, &async, dpm_wait_fn);
+	device_for_each_child(dev, &async, dpm_wait_fn);
 }
 
 static void dpm_wait_for_suppliers(struct device *dev, bool async)
-- 
2.43.0


