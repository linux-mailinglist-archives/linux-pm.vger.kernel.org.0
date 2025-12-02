Return-Path: <linux-pm+bounces-39099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95158C9CC51
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7ED3A90F6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5212DFA3A;
	Tue,  2 Dec 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwDx83VN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799232DF149
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703903; cv=none; b=saTDvOdsi6MTNZJiXTkJt0m4v24rMUN2P+ONbLr+UXO1+4gs8GzHB9AnW4ZlERf90oa5FDrCZOi7whXCJTihPZWmIr1UdaDCdN8S2dx4Gfntc5h2T+0eWXQ7UIXkuJlqIuZ+kycYKiy5O8u5vWPBk5RKEhe9Eqb2nQvas4JnJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703903; c=relaxed/simple;
	bh=89tgRTYNqhu9hOepvJ+82fephEkPsuHCdL6LCEACfzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASGdnv1dD/N0krjAi0b5zrDOZuaMOR75CLl/SUBu7YwH5IQ85Kijp0Epa+B5ImYRq9oGCPQb0wqfBHGa8fB0Vpc6VF/9eknwmXX12diRa59byxjattSxkrue5IoSfCW/LS/Uw2nnr9ROpK37zvgcBKZF6D/MJ0Uf5X37PJwiLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fwDx83VN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so3967988a12.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764703901; x=1765308701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na5v78OCyeT9zlR5GeRvaaoUwV8EP7IcuCIa4acHer8=;
        b=fwDx83VNw7GSrFX+jc02HYlV5np3oLwwRkVjJabOK0Z+If0TUrHEcyZRb6QGMdY1vB
         +dGvPP7LopvXSgVUcA3ZCDd+Z1+o5p/nxOoQxfPoVcxBoF0fobMWdOlSaMrQXFUDFQGS
         wWDklzylYdsVSmkvibyefhyL6Pc7y2T6OVbuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703901; x=1765308701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=na5v78OCyeT9zlR5GeRvaaoUwV8EP7IcuCIa4acHer8=;
        b=KTfR00QbAmpQ3HKi+dPBoYPtnYgjzC+6bSypKSMio+uu29EasI77CGEKZy0TkGE5JP
         E3wat9ohmwyV4R+FCW3VMLCwLN0uaUzn89oqakh/WF9j90tIxor+XDy6ayutk6cyL6Tb
         Q0dMVXUOJUUwaMxV8/BhpHmEBYgwXOd3ZptEFY8g0aHPL/XbsH46hTsVwKMEWrBwAccS
         18AVqr+LGoZId+KY3B2kxYyMFAj/gyqNh779hSn+hN4Cw9h1YF1rsycP5Seh0PZL7iQM
         JpgJh11gUG72NgrxHCwROevKjwXZ7ZB+uYJwPCJOJW5jqrDmCTTzvkayAC+IrUb5qWZ5
         JXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPt1rWCKvCqjSeJ8DB9hDZvKuk8g2VPYg1l81B6k0avsGUZ0KDtSHKWKZecjd3/TkV89TYvm3VLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP+/eTDVtuzsSRbhU/BFchUu3Q4/P8bbBTcQhSLfB+k7eO42O
	87vGfq4XM+amo9VeDTZQL/l2PgnNSCBYxxDp5fkeUbHVwvJkw3X0DAVDm8O8uJKRFXM7HL4o0Cq
	tUOg=
X-Gm-Gg: ASbGncsUDq66I5WBGkcJaqQ7lfYfNolL8FQ9axBJb856TpBPV3fEkF09o4VA81tkkPV
	4fdzM7Qjfse5OoFLsg5jZgojDAx+K3jnZrGPx9z9l2Eb9yyQNcW+uj5RlvyEI0yjrZtSjVG3wlG
	UkN8xfqGifHvqbRAjoRFEGonFUzVXWR2O5Tii3QDqitLsC7L3BbKSb+zn/5wDzN4HeAfpzwknUq
	tONwIR85zlwbcY+vhGp6YajQyJLeZyd6u++9TWL44r8I7nbMBon3DsKwg/4ygZGMdrvWH3L6ZR7
	Pv682lmDmk/S1JWXzxQvztZzEHyMutTrqg059J5dyDMDcH0ipfM9aaYmIIFSU25uxXrvJnl0Qbz
	ttSxX67WhOwRlZVWvBXrLWzUi/EOGbHUPpzZXrImmfqvhXzVOcD+G1I4Sc7t4Ug0X4YvbQxf8Bp
	PanSt7ZpLjQmn3WYEusWDoSSf8hMJ2TdDAU6S5Dm4x6UdV7zS4dImFDR/9IN6X
X-Google-Smtp-Source: AGHT+IFoyTaQnXdPaLai2dhHok1uu5yke3eT/aKrXaUbt+aHtcAOgACJtFffvCzT1E5Z3FpUKLU+6g==
X-Received: by 2002:a05:7022:4191:b0:119:fb9c:4ebb with SMTP id a92af1059eb24-11cbba47b12mr18529414c88.30.1764703900506;
        Tue, 02 Dec 2025 11:31:40 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcaee7076sm74258741c88.4.2025.12.02.11.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:31:39 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] PM: runtime: Make pm_runtime_barrier() return void
Date: Tue,  2 Dec 2025 11:30:25 -0800
Message-ID: <20251202193129.1411419-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202193129.1411419-1-briannorris@chromium.org>
References: <20251202193129.1411419-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No callers check the return code, and that's a good thing. Doing so
would be racy and unhelpful.

Drop the return code entirely, so we don't make anyone think about its
complexities.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/power/runtime_pm.rst |  6 ++----
 drivers/base/power/runtime.c       | 14 ++------------
 include/linux/pm_runtime.h         |  4 ++--
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 8246df3cecd7..455b9d135d85 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -443,13 +443,11 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
       necessary to execute the subsystem-level resume callback for the device
       to satisfy that request, otherwise 0 is returned
 
-  `int pm_runtime_barrier(struct device *dev);`
+  `void pm_runtime_barrier(struct device *dev);`
     - check if there's a resume request pending for the device and resume it
       (synchronously) in that case, cancel any other pending runtime PM requests
       regarding it and wait for all runtime PM operations on it in progress to
-      complete; returns 1 if there was a resume request pending and it was
-      necessary to execute the subsystem-level resume callback for the device to
-      satisfy that request, otherwise 0 is returned
+      complete
 
   `void pm_suspend_ignore_children(struct device *dev, bool enable);`
     - set/unset the power.ignore_children flag of the device
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 62707738caa4..84676cc24221 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1467,30 +1467,20 @@ static void __pm_runtime_barrier(struct device *dev)
  * Next, make sure that all pending requests for the device have been flushed
  * from pm_wq and wait for all runtime PM operations involving the device in
  * progress to complete.
- *
- * Return value:
- * 1, if there was a resume request pending and the device had to be woken up,
- * 0, otherwise
  */
-int pm_runtime_barrier(struct device *dev)
+void pm_runtime_barrier(struct device *dev)
 {
-	int retval = 0;
-
 	pm_runtime_get_noresume(dev);
 	spin_lock_irq(&dev->power.lock);
 
 	if (dev->power.request_pending
-	    && dev->power.request == RPM_REQ_RESUME) {
+	    && dev->power.request == RPM_REQ_RESUME)
 		rpm_resume(dev, 0);
-		retval = 1;
-	}
 
 	__pm_runtime_barrier(dev);
 
 	spin_unlock_irq(&dev->power.lock);
 	pm_runtime_put_noidle(dev);
-
-	return retval;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_barrier);
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 911d7a4d32c1..41037c513f06 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -76,7 +76,7 @@ extern int pm_runtime_get_if_active(struct device *dev);
 extern int pm_runtime_get_if_in_use(struct device *dev);
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
-extern int pm_runtime_barrier(struct device *dev);
+extern void pm_runtime_barrier(struct device *dev);
 extern bool pm_runtime_block_if_disabled(struct device *dev);
 extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
@@ -284,7 +284,7 @@ static inline int pm_runtime_get_if_active(struct device *dev)
 }
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
-static inline int pm_runtime_barrier(struct device *dev) { return 0; }
+static inline void pm_runtime_barrier(struct device *dev) {}
 static inline bool pm_runtime_block_if_disabled(struct device *dev) { return true; }
 static inline void pm_runtime_unblock(struct device *dev) {}
 static inline void pm_runtime_enable(struct device *dev) {}
-- 
2.52.0.158.g65b55ccf14-goog


