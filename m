Return-Path: <linux-pm+bounces-40972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E9D2D3B9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 08:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22C68308953D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 07:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6402DC33F;
	Fri, 16 Jan 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7sj79pE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC52C327D
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548611; cv=none; b=c9a0cfkvo+7yuvWviTgS3KYAG61dRelRhtvbGDjG9uipF1NqwT0NQczJU9E2bJdBPOH2Zknsjf5fIrY6Grh37hq4YipRV12xw1SOM+39elkV8xsllDC4qlx1CFc7I3MYXtypyDaS0pdp1xIjlBzNUIwmBMvXkKdMHg0iupByRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548611; c=relaxed/simple;
	bh=kfc2gu+JDiA504aEuqqB2yOn1wTCL0D1jfoSwyCjLNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8pLIH22Rea4v6erV9tYcGg/I7qPQR9EcTzrs11xhikWudfliOAr3uqClYUpSNDpnGajjQlA7nBc3IaV5MV7EzzFs6hhx7Z2QyH6jAp9ZiOodWHe6zreaVumwpTeTpcLQJlu/bspYjIF/K5or0fAINIZgvLbLSF4Gqgruzo0i+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7sj79pE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b75e366866so517193b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 23:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768548609; x=1769153409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z9dR9n/XbIPD+NwoXj4aiKTiL+BG3no3tdpgFPxOgg=;
        b=I7sj79pEEVb6YqTkpYa8ZQ7DkuAuYNUQ0F9DO11/w656RPFABpxnFUnD1EklZnk11H
         B+3vj5avKulXmgiLrNr2KqWsGoCNxQ1VXGwwX1mA6VlYBr7cpJkGN+LdswGzfQ0946Z5
         sF4BX6MfgIj0xF8FauYwX/2mGEhDuahzNt7zJ5Drd5R/FCzI7EPwvfd01uxocUyyeyJn
         upSqZ9YxibY+qlXTUcuziyjxdl0dCObch8AkJVyXxzqUwKX2arLfjtUE45eUJH/dVLgG
         DS5VICsYbCgI1irqvMD4f3OMo43008Dc/R/EDBDqHUF3vY0LTioTL/MKlemOU48HXtN3
         GJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548609; x=1769153409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z9dR9n/XbIPD+NwoXj4aiKTiL+BG3no3tdpgFPxOgg=;
        b=lzvs6By7wNZxVOSe5E7WrGEeNFZVvsKjNA4MDeKxf++rXDqkVDA9ekM8E6KTU87jb9
         8jfWYFEE1fuX71UJTYe9kRGwSslToidIXjQv6xRhPumxg078jRrvj6QAdADWPji7WiNa
         qYkytMpTtkZZ0usefbKHaLKj0rYfDK5WPJYE/rZAAHgR899IcOuzUFzdWrWxqegsVYIm
         XUEIFC2Y6o4+M3rUpbY6xLuPuT6jNCJ0kT33cBlAzYR/nAirWDaV8KBqslBqXnBuTWzY
         xCloHYOcnNrka6t8ljh1hDPROCAOhGuxach7EXOqh0afbRPs5tTSVj8zsQI47FJR9vPh
         uUuA==
X-Forwarded-Encrypted: i=1; AJvYcCV4xE86nSAXGY3ztz/SoCJrG5B0t5CDzhsQJuHmhyCThmL5H5oo+s1JP81v89gfQfJK1H3ESBOn4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YylvfvJcPOeNc7Ee72mdm9Ru9kdr8iU+Lb+oVhl5c+G8oTsyBaG
	wWIm10ir0NMgKTIeMiNgZP/H4DU2RB2mgB317r5weUVQFz59Xsle8LNy
X-Gm-Gg: AY/fxX521eRyIB/55r8GYQ5eXZ2nl7qfTJLMh6vC34/YHEF4pCszLQXX7cJCkhgE7/N
	O9FCXZatFe549RHvDutW1r9dCbAy86mNX3A5Rc5f3qlO7KarbFL6jKRTVFcCS39UZjMfwJKpABc
	/DrBkjmUCTozA2M2h+Boaom3pO9zaJM0f2PsbdUgsLljAhJLQbOrdFAIOV1WLGccroLYbxpmpFJ
	uvFAYzrHXNtNqRYFHY8zyzRRh05rq0RlkmFJQ96LCq3Xu5HIQDqTeQT5ZPE5vHzehUhcutlEUAW
	PH1Z7+1pO+hU7pkDS1pv3ryfEhcNKc/LjMzOVzFiM4dKSXrk0EGHg89TAfNOGfC/BxEI1ZWgtkc
	pNC1nF5VSK1FHV+Y2YwkBHXBWDkjv6cqNj4+UJ7QAQypgXcb0kv5VL8xUsZ5i+G8ZfTs2QG+gBh
	esnCuJLAPSdIPRS/Z9gVUM5nFUrDw3G144obq8dmWLd61TZKjgR6S3i0x1PP5WrZtrYTzHpn4Bv
	pHAuULJo3nHO3yGDW20vj/GIYKBMwIlmmnsMxxGYtWs8y4=
X-Received: by 2002:a05:6a00:4008:b0:81e:6d2d:a121 with SMTP id d2e1a72fcca58-81fa03395bbmr2087675b3a.62.1768548608940;
        Thu, 15 Jan 2026 23:30:08 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291a48sm1261509b3a.50.2026.01.15.23.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:30:08 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] thermal/of: fix device node refcount leak in thermal_of_cm_lookup()
Date: Fri, 16 Jan 2026 07:30:02 +0000
Message-Id: <20260116073002.86597-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() returns a device_node pointer with refcount
incremented. The caller must use of_node_put() when done.

thermal_of_cm_lookup() acquires a reference to tr_np via
of_parse_phandle() but fails to release it on multiple paths:
  - When tr_np != trip->priv (continue path)
  - When thermal_of_get_cooling_spec() returns true (early return)
  - At the end of each loop iteration

Add the missing of_node_put() calls on all paths to prevent the
reference count leak.

Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/thermal/thermal_of.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff6..ef3e5d4e3b6e8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -284,8 +284,10 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 		int count, i;
 
 		tr_np = of_parse_phandle(child, "trip", 0);
-		if (tr_np != trip->priv)
+		if (tr_np != trip->priv) {
+			of_node_put(tr_np);
 			continue;
+		}
 
 		/* The trip has been found, look up the cdev. */
 		count = of_count_phandle_with_args(child, "cooling-device",
@@ -294,9 +296,12 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 			pr_err("Add a cooling_device property with at least one device\n");
 
 		for (i = 0; i < count; i++) {
-			if (thermal_of_get_cooling_spec(child, i, cdev, c))
+			if (thermal_of_get_cooling_spec(child, i, cdev, c)) {
+				of_node_put(tr_np);
 				return true;
+			}
 		}
+		of_node_put(tr_np);
 	}
 
 	return false;
-- 
2.34.1


