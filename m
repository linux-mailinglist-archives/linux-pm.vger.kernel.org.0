Return-Path: <linux-pm+bounces-4803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCEE876D4E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 23:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C05F1F2250F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED915AF;
	Fri,  8 Mar 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFLV3qf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A93FBB5
	for <linux-pm@vger.kernel.org>; Fri,  8 Mar 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937903; cv=none; b=D8y30207iDkSA93P3X2VDL4Q3GqQOMckHl+Cm6ELtw/3Cb62uCHQgDy3Q0ZsUT1f+cdCiT8cRLR0XUMyZZ5fUGtgAzSeCpeEvhWgteniUEAcjwgMl3G0iXlpJ4lUmCslEFdb1X7bc643gEy5DfAdXBNGbwZo8RXphpEIWMBDxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937903; c=relaxed/simple;
	bh=KZRGbBNF0GTtJzvOMXF5VklG5k9DvU5JzIOJGPDdwQI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=nWlFK22DD2bhAXjmkgNIbvinW46JqOTNj2VsUD08P7GL9IxFXpEGBwSPAYOplrZ6ZUF4u+bqctT1MHbSrqGBdKLatJbwhdf5/n8hM6Ust3OBk36ovix1xdKLv8nnt6v4jC/YnbCLv1xAoZSpLfz/G2kd9RVqth3hEm8UBgIJLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFLV3qf5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so4596785276.2
        for <linux-pm@vger.kernel.org>; Fri, 08 Mar 2024 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709937901; x=1710542701; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IiMp4Q84ZRHG2huJ3D03WkrKLgdFSmD9U9ReR7uCK6U=;
        b=RFLV3qf5sNxacB65Ib0q1PqL8+KAYXKGUgu879ZIcdJ0qVLrQl70VUI0FMxg1c4MdX
         QEZWlqoBgF5rzKlo0bBXekOUJGCFfDI1yF+x0Agp5HXF+gjIkiC4m0LTPziwaC3FFXfQ
         bAq0a8ceovtmA8MQv7yNtdzhTukpnLVLitUK24sub4LMQLhOQSTbg/iGfGbq6GD5RD2n
         l7YrxZc4cWrw1At1W3odrUYEF8jUC0BiLhTmjAdKWSTNYYNUiDgFYWgiy0iv1urSwUAj
         4yW1QEjk35psTJxtTv2ExH5TDSoHIb6HxDkXe/yt5bBdjEjJCds4yzFgCF3zX+fLtajR
         EcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937901; x=1710542701;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiMp4Q84ZRHG2huJ3D03WkrKLgdFSmD9U9ReR7uCK6U=;
        b=kfczeZsCMw+acycBI9wjAeSh27IEBaHydvag9BC459RAPLidBA2S7WKT4q/jb9g7Zp
         USBQjB/iNwp2vtl0+VMxOZDZZh+GL8gQ+IDVce6Hg0nco+raD/GrUkZvZEUMteMc9Dtp
         qwNHpVqmvyw6Osqiwg9If94uOtmgRKo4QrVx1HFhVRtOzatuSxS44JwNdDEMYCnFxPtx
         cKFfX+0huLfJ7vFp82uMHqc8iZOp6NB22Y+nvgXH5a1UWG8Wm6dTaNRVrQ2MrAUFL4GF
         KKljkaMI0Y0qu2WT/FGMMH/8wLYn9Ob5tdiBmKcrRucxsCcuVf2kIHK+4mh18fC4lxK4
         V4rA==
X-Forwarded-Encrypted: i=1; AJvYcCWim/K89cPTLuraTMdan03HQejLIBV3PMqWOyHRm7j9LQ3Qn9R4CRCSh9mR+ddK1+4y6vJcfgMlm+JCJ0IkZGvEG85OJu7R2Jo=
X-Gm-Message-State: AOJu0Yyf/wzrrIWL9BONZdK0VZYPyOBSjb/L3kqVLEXCjvP3yltfSRk6
	QIIp1a3wBo4cyJk7coXhCwhegJ1d69aBrVBte7OhCmYGiJAWhyZNd+dPTyaTRlTDQsh96MkpzSX
	LHpC8uBqJFZKdIQ==
X-Google-Smtp-Source: AGHT+IG/emX2/VZdtlMuRgEiAhbEydXKKDZZNEwpuRFiPRm8SORpqs38ydYiV9bQtRKmc6lUxN4XqNmkfzHamhE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:b307:13b8:5743:15a9])
 (user=saravanak job=sendgmr) by 2002:a05:6902:102b:b0:dcc:e1a6:aca9 with SMTP
 id x11-20020a056902102b00b00dcce1a6aca9mr96836ybt.9.1709937900881; Fri, 08
 Mar 2024 14:45:00 -0800 (PST)
Date: Fri,  8 Mar 2024 14:44:50 -0800
Message-Id: <20240308224450.2327415-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH] Documentation: power: Fix typo in suspend and interrupts doc
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Typos are bad. Fix them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/power/suspend-and-interrupts.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/suspend-and-interrupts.rst b/Documentation/power/suspend-and-interrupts.rst
index dfbace2f4600..f588feeecad0 100644
--- a/Documentation/power/suspend-and-interrupts.rst
+++ b/Documentation/power/suspend-and-interrupts.rst
@@ -78,7 +78,7 @@ handling the given IRQ as a system wakeup interrupt line and disable_irq_wake()
 turns that logic off.
 
 Calling enable_irq_wake() causes suspend_device_irqs() to treat the given IRQ
-in a special way.  Namely, the IRQ remains enabled, by on the first interrupt
+in a special way.  Namely, the IRQ remains enabled, but on the first interrupt
 it will be disabled, marked as pending and "suspended" so that it will be
 re-enabled by resume_device_irqs() during the subsequent system resume.  Also
 the PM core is notified about the event which causes the system suspend in
-- 
2.44.0.278.ge034bb2e1d-goog


