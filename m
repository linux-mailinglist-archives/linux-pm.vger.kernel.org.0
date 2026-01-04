Return-Path: <linux-pm+bounces-40168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC967CF1292
	for <lists+linux-pm@lfdr.de>; Sun, 04 Jan 2026 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD14A300819A
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jan 2026 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A620B7E1;
	Sun,  4 Jan 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ohhItlKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCF1E520C;
	Sun,  4 Jan 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767547015; cv=none; b=vBupAMa8CnvKTCLXWU9wtgj8NYchHbnCgqB7NSXZJupUBcgqxwkVMi9n2cEmf49VEzgccfYkjbARBNh39RRD06Kob2sRw/0koJNpoiC6Neir2E/W/Tkh+TmQdSDDjvcJKu6I2Bz/XSHvVUQBqDAdOoT1HmxebWJCBrl4WC6q7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767547015; c=relaxed/simple;
	bh=do7PrGXGKBqJG/GVaoNNmxrkL5sFHtFTmOCIpmcA7MA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JB3ynn3K6H5INaHCFeU02tXFX7OlU0EoyaAwct6H+OszhzDvir2dWFyI/N3KnjsxCKWLWgMQyVN6eakEh1ncbVrCTg1uPBs3Q4ALv5sB3bTSJ1mN8fIWnmg0NPNNs8MIzMjrOLLPFD/aQQL6rRcWtt7X0SMu/nEUKqdOlvAXLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ohhItlKZ; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B+VIMQCaJeUOuYcR/SekdE5pwgQ/eHItITPjSlLrErw=;
  b=ohhItlKZskJQkMMhG9YowNpa+z5RmGJv9yU62AA/k7L/dSSM1I6f5a45
   kymMMdRtr4RsK8r6vyfEyvM6ggutcQ36f4XZ1xX6f9CqliEPAkKCpPNnS
   A0CaHPhfj98j5XusUAB99QQqieod2nwaeheCeElV/j8H2jMm6TD66XrLf
   Y=;
X-CSE-ConnectionGUID: P+TRORtOS+yKlTWomMt+RQ==
X-CSE-MsgGUID: +FoUaWWfQBqboIdDiR6EOQ==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,201,1763420400"; 
   d="scan'208";a="135016037"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2026 18:16:50 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	jonghwa3.lee@samsung.com
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: power: update documentation about removed function
Date: Sun,  4 Jan 2026 18:16:44 +0100
Message-Id: <20260104171644.292437-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function cm_notify_event() was removed in commit 9584051f3cf3
("power: supply: charger-manager: Remove cm_notify_event function").
Remove the documentation that suggests how it can be used.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

There is also a reference to cm_notify_event in
drivers/power/supply/charger-manager.c that is less clear what to do
with:

        /*
         * Charger-manager is capable of waking up the system from sleep
         * when event is happened through cm_notify_event()
         */
	device_init_wakeup(&pdev->dev, true);
        device_set_wakeup_capable(&pdev->dev, false);

 Documentation/power/charger-manager.rst |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/power/charger-manager.rst b/Documentation/power/charger-manager.rst
index 84fab9376792..b29c962cacdc 100644
--- a/Documentation/power/charger-manager.rst
+++ b/Documentation/power/charger-manager.rst
@@ -183,17 +183,7 @@ struct charger_desc elements:
 	the value of measure_battery_temp.
 
 
-5. Notify Charger-Manager of charger events: cm_notify_event()
-==============================================================
-If there is an charger event is required to notify
-Charger Manager, a charger device driver that triggers the event can call
-cm_notify_event(psy, type, msg) to notify the corresponding Charger Manager.
-In the function, psy is the charger driver's power_supply pointer, which is
-associated with Charger-Manager. The parameter "type"
-is the same as irq's type (enum cm_event_types). The event message "msg" is
-optional and is effective only if the event type is "UNDESCRIBED" or "OTHERS".
-
-6. Other Considerations
+5. Other Considerations
 =======================
 
 At the charger/battery-related events such as battery-pulled-out,


