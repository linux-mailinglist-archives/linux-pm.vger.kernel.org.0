Return-Path: <linux-pm+bounces-42725-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFlJINkglGmKAAIAu9opvQ
	(envelope-from <linux-pm+bounces-42725-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:03:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B2149879
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB4C302BE83
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C472D7392;
	Tue, 17 Feb 2026 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXR/Z1rL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515F2D0C7B
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315314; cv=none; b=EDV+CPNcbN9behwCqI/ZIKLqG+4EUvFPIuunDdIyfVmPjZtPyVnuA9CVFSQZEKBzaV+G0Qsm55u1jwsYNSDviTSfDaLrOSUTZ/EDVMCQnkrYsuRuovZNnib6KFqlAQRHHXvZOxGJ8GssJb99JkeJ8sL7ALRhx6uMr+N4YROJwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315314; c=relaxed/simple;
	bh=8nP+G60xORVioRFODry6ZjQeDIwlkPrlnyc6+fGyYoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNCrcl3L7G5OqQZmac98WtIHbM9YdVep51ttQloSHBGWOZhA+TFmBNj+HnHFXZ3iW7DklcbbNqp+gnwf8o7pmpoidvDLjCnEoVusY9MRTKg52koNq3yLqlGZFNbJe8J5FzYQ5Fbxog5CmLVioSlhGockC0vG4iR3hxvv1ET41fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXR/Z1rL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-481188b7760so32372775e9.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 00:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315312; x=1771920112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8SIe7TJNGTZOpsiu2TBh23Lr0Mt6PONYwJs1/+BcyM=;
        b=EXR/Z1rLunDELUYp//7MJ+GeqVb1qx49bnC/1KU1ULDBI+i8CJQ2Ib1gh4EUGwOHKw
         atnyado78PyU0TLJsvEfbIQO6lVr56X301nutCUzRy4uI3iCwrf9Kh4lJ68ooBSNQHwM
         HfFJ9FmqvAyTQxsqCTJ/jozImYQyyzru9eBb3p+gGd+5lW1mwsc9LrWmPLjOf/6Nwqes
         NMElAiJOSOVoe9KHv5bUFW2D3yPe6imhWOuGuHHSrf5B0af1L7J2ny0puTwN3bPwbh4t
         K5wm0qCKOGLqyAymL7Pah0elDgAobHtCVNH8t54n+istwJxd3mWY9amVqVC5/SqEoI+o
         S78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315312; x=1771920112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8SIe7TJNGTZOpsiu2TBh23Lr0Mt6PONYwJs1/+BcyM=;
        b=Uk61CyLEzGEa6Do7urwykVjjUw0Yes/+KnV7N6zxeb9Lz/BQk5g9PSs7SXEaORAFxS
         2Px6ZwP5wRzQ6itV8e+w6Kg+lpgm+mzsrBE015tf0ceSjKSMrFZBt2YDkfNtYm0bSTNq
         5H91Ol6IsXnwpTtILZvdpGWkgUFRlKBd5w6bpxYMl0Uf7WGCBfWE7YQf3fHBZgteH2jg
         i+52FguqmGmjoiBjkaag8r5gXRZIJRdf6yvjzVufaI2Ga4WsnOZxzUBR0e10pJpQZZDK
         A2C8IO3jg8ikTPZI4kZoYAkqfzm1Z+FpU1PC7K85Dasrs0NAa6PDB69ztu9NTv88VCS4
         yOOg==
X-Forwarded-Encrypted: i=1; AJvYcCUeUzHM1NbvYClw/thl0rHNCpy4SL4fAEC6wzx4f0sRr++rfbsUOtsF+FJeR79vadgDojqPx0/Kvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfIKF6Giu3I3VvJdOCBvRqUZNXA9Y3qyYbBOzEkZYYlf6ylXxA
	bmVJZ15pzEQKKUfSNZKLyQWv5dbBmfSludlH86Y4V9zuPrbpjH64y0ER
X-Gm-Gg: AZuq6aJS4PH66dWdf0KBUC4x3/d/hEhJQeqLRfumyGsRTmsjGXmX9ar669uwf8EYDER
	mc6sYhUFurIPi6ngWaA59KUu9W52veTC+MpxTd0NobNoSU81BQE6Z9kYxEoGV6ydTWaY5HrIf9U
	I6kY4+3oQpZt29pn5gfrdr8ugA3cX5oKMmiHc7EzYDd/Fgz5VNne1emdszkBrGkaxdylTVQxCmQ
	kEXU1NMCWprQNSjtij2cKUMYNbHgCFvf2DaYMjJF0glx7Rn33EcQ3M/9rqFNliNJOMzpUtLk/Mq
	0PCPNFCMNTcFkNqIUijAESxJmA7jIvNnGo3/m/CnKxPwuMWd/Ma0I8CR5yU5MF4QK1/WCRI2Z4N
	7RiCVXNL53D2BlyD0nj9kgGbcA2rwohi+W810biGDsb0khJIa7IUu+BEn49P2ZyChs86NdPV3E9
	JkL4iWRWnETeleuFPGztj4ttREGshrCGYukDnureLAEoXXLEdpkIt0QYpbcEiuLNThn+uJ0A==
X-Received: by 2002:a05:600c:529b:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483739fc4d0mr244661825e9.3.1771315311694;
        Tue, 17 Feb 2026 00:01:51 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:51 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ionut Nechita <sunlightlinux@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [RFC PATCH 3/3] PCI: Update bandwidth control and thermal cooling for Gen 7 (128 GT/s)
Date: Tue, 17 Feb 2026 10:01:02 +0200
Message-ID: <20260217080102.206581-8-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217080102.206581-2-sunlightlinux@gmail.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,arm.com,wunner.de,gmail.com,vger.kernel.org,yahoo.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42725-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: DE4B2149879
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

Update PCIe subsystem components to support 128 GT/s link speed:

  - bwctrl: Extend pcie_valid_speed() range to PCIE_SPEED_128_0GT,
    add PCIE_SPEED_128_0GT to speed conversion table, widen
    supported_speeds variables from u8 to u16
  - portdrv: Switch hweight8() to hweight16() for supported_speeds
    to match the widened type
  - pcie_cooling: Add static_assert for PCIE_SPEED_128_0GT enum
    contiguity check

Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/pci/pcie/bwctrl.c      | 7 ++++---
 drivers/pci/pcie/portdrv.c     | 2 +-
 drivers/thermal/pcie_cooling.c | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34e..b9125b40cb860 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -50,7 +50,7 @@ static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
 static bool pcie_valid_speed(enum pci_bus_speed speed)
 {
-	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_128_0GT);
 }
 
 static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
@@ -62,6 +62,7 @@ static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
 		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
 		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
+		[PCIE_SPEED_128_0GT] = PCI_EXP_LNKCTL2_TLS_128_0GT,
 	};
 
 	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
@@ -70,7 +71,7 @@ static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 	return speed_conv[speed];
 }
 
-static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
+static inline u16 pcie_supported_speeds2target_speed(u16 supported_speeds)
 {
 	return __fls(supported_speeds);
 }
@@ -88,7 +89,7 @@ static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
 static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed speed_req)
 {
 	struct pci_bus *bus = port->subordinate;
-	u8 desired_speeds, supported_speeds;
+	u16 desired_speeds, supported_speeds;
 	struct pci_dev *dev;
 
 	desired_speeds = GENMASK(pci_bus_speed2lnkctl2(speed_req),
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9a..5ee8795107f26 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -274,7 +274,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
 		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
-		    hweight8(dev->supported_speeds) > 1)
+		    hweight16(dev->supported_speeds) > 1)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
diff --git a/drivers/thermal/pcie_cooling.c b/drivers/thermal/pcie_cooling.c
index a876d64f15827..9a2e39398674b 100644
--- a/drivers/thermal/pcie_cooling.c
+++ b/drivers/thermal/pcie_cooling.c
@@ -75,6 +75,7 @@ static_assert(PCIE_SPEED_5_0GT + 1 == PCIE_SPEED_8_0GT);
 static_assert(PCIE_SPEED_8_0GT + 1 == PCIE_SPEED_16_0GT);
 static_assert(PCIE_SPEED_16_0GT + 1 == PCIE_SPEED_32_0GT);
 static_assert(PCIE_SPEED_32_0GT + 1 == PCIE_SPEED_64_0GT);
+static_assert(PCIE_SPEED_64_0GT + 1 == PCIE_SPEED_128_0GT);
 
 MODULE_AUTHOR("Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>");
 MODULE_DESCRIPTION("PCIe cooling driver");
-- 
2.53.0


