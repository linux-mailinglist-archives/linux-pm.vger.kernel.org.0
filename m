Return-Path: <linux-pm+bounces-32033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C68B1D788
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC6727E36
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E982522B4;
	Thu,  7 Aug 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDY+A7XQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CC253351;
	Thu,  7 Aug 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568870; cv=none; b=Cpb+TvWk1zPV9hFjT4tBAU5nDuvJAHAzbGghAyBC0xJIJIJtzjgo8Q9PNlyLGF2etNOhcLgmTsN1xrPOGPF3KNkK/WtkjgXu0GLiuf5ij5Hr10rqelsFnCqsaBiXZa/7ZKeBzKfIwtJgApSLFAbduq2jPavkXMyho8LRiHfnAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568870; c=relaxed/simple;
	bh=zEfKvxCGsksFx0cOWCeN3rSo3TD1UVcOgZ+kg33gJoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB5/bUl2vDOSZnUT68Ve7Eq/OCdZox0rCSWJ2x1e4FbkVuDrfUCrL/uP6O1oF39mRH83py5nDZP7M4xBYBmMp+L+8AZ9+nuX3Pj97mQOt/gGd1Q1fzx6XVD7tcxupqhgSyL6sd4oJGFqRxMOgpgheuVemJwHylbv8lMXCGowlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDY+A7XQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso6934705e9.1;
        Thu, 07 Aug 2025 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754568867; x=1755173667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOvxPdhdkRmgXuqA5D4OZ0OGc0TX4IdKP6S9H5e+35E=;
        b=GDY+A7XQRo9pNJE3B2Nwp/G82jvEZN6zBtu9rfWKKO0D+ylLcKQyZ0zGQjDHxN4z0y
         g0jP4IowqgH3XdWKhosaryoIwHhQ0NQyiXyXmRdC1p5R+pShd+Bw64Uy3SfrP/EKSplM
         7kMGG+TIojJBQ6Guy5bkZj8sMDKiNCpex4XCz0gDM35XRQSO3RcE/4yNuMajpoRDQ8OK
         FbeatuWggaFDuAuEFZkVg+ND4O62mVcCkbR74P+V9dgvSZ24zr+oCM3eweGEeerRV98w
         BMsGthiABPcvlRT53BcuRkeQf+HwQ+piW2zcnNA6PpI6xOn+a+SygqHnaaOvBFDkN4rg
         hDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754568867; x=1755173667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOvxPdhdkRmgXuqA5D4OZ0OGc0TX4IdKP6S9H5e+35E=;
        b=ZQnBwZM9vMqzngjXVk3dA1dbETyOWMZZRrXd8qMImoX2JSD2f3Ztjj2pUIv5nYV2IU
         vuApyN68MBLwwCQTre/jJILsXM8VNyM4mmL1uboyOPRxhx6BBvvM0stpVaaLcyS1kL8u
         jzQh2oBBwk7yhYC36sTYKVCTP6rhVPPxZveyBeD6xp2iz5g6Pm2dQ7s8z2gPmuOm5Nyr
         BHbS6sCefbc5eWb5lDiXvtf2DWZ4v8oryFSwXul42hZ5lhl3owGPWpPTHmCBH+mtwfaY
         8DEWYhYTXMGIy518mzXmjf2tELdLcxrGwHjRmw/YOnzauTz1HM3ZQuakgwVq/5yaX0sc
         Os3A==
X-Forwarded-Encrypted: i=1; AJvYcCV/wxz9+zjSMo7IV8nlEwJwwi5eUtGQGyP2tZ15HcEzhmSGoI471fSHOj55Y/TsLaiPmu99+dF6L7I=@vger.kernel.org, AJvYcCXw8lpiwArnYvpvB7Bn4kasqsUOQL3izLXgVxsQUAiYvhQje/f26/b0zXvGiU1dhM5poaQuTx0jJpo6z+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguqSInZFUb72kTJYLaRTIu18UyAtJQp3MEjdSLmY0rLyztVze
	5mwmokf8WAhYohOGLyPuyLpqWv70hi4Rzie82EJNcuN9pTq1ZSaHjLMVhCu3K8jXQTQ=
X-Gm-Gg: ASbGncuZbdC6N0T9lEAguW/p3GXOgx3QRA1VcmYqm+wQd4E4yblgqjBcU0c4zZQHBWZ
	xithf4jT678/6vrX0OE0eDr7JxqWixlq2fx48fCNFemIJxZH9yQw7DC6/sjxwZ0m1dnO1Dscb4p
	xsgid6Xj6Gn4K/WSUjy+3sssxTDP175F7T/thQbOp/hY3tt03RvT0AZDDt0JCPKuYvMO1kXHMaX
	fPkd4P0JRULKpfR7LcTtDxJ9HgFo+t2Ls1jSuqX2KeRan/rmpm4TFxeZk0wtZtTyVvqIdKr3hd0
	KjMQUcODDf5hDjnIx8X6UxLLiGrqoEn0yVLdv2EnparpHJGHEhWGC7o1yKsi8ad4qNUaQ7JBqEm
	7WmUOh+dTBHzzvhU9owYA
X-Google-Smtp-Source: AGHT+IFTsPrkYUi4hoaFQ8iZd6m5pc/Quo2AQuS9Wt7r6JJPPCobmoHZ4FcuWwsU3o6X9A7AomJ/JA==
X-Received: by 2002:a05:600c:4fc3:b0:456:ed3:a488 with SMTP id 5b1f17b1804b1-459f39c50bdmr2643125e9.1.1754568866537;
        Thu, 07 Aug 2025 05:14:26 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4530a8sm26578463f8f.38.2025.08.07.05.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:14:26 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: 88pm860x: make fsm_state array static const, simplify usage
Date: Thu,  7 Aug 2025 13:13:49 +0100
Message-ID: <20250807121349.460862-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array fsm_state on the stack at run time,
instead make it static const, this reduces the object code size as
the data is placed on the data segment and this removes the need to
have code to set the array up on each call.

Note that making the size of the strings to a more optimal 11 bytes long
does not seem to reduce the overall size. Making the array an array of
pointers to the strings increases the code size due to the dereferencing
overhead.

Simplify the array access with &fsm_state[info->state][0] with the simpler
expression fsm_state[info->state] to clean up the code.

Original:
   text    data     bss     dec     hex filename
  22884    8272      64   31220    79f4 drivers/power/supply/88pm860x_charger.o

Patched:
   text	   data	    bss	    dec	    hex	filename
  22695	   8368	     64	  31127	   7997	drivers/power/supply/88pm860x_charger.o

Difference:
   text	   data	    bss	    dec
  -189     +96        0     -93

Reduction of 93 bytes total.

gcc version 14.2.0 (x86-64)

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/88pm860x_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/88pm860x_charger.c b/drivers/power/supply/88pm860x_charger.c
index 2b9fcb7e71d7..8d99c6ff72ed 100644
--- a/drivers/power/supply/88pm860x_charger.c
+++ b/drivers/power/supply/88pm860x_charger.c
@@ -284,8 +284,8 @@ static int set_charging_fsm(struct pm860x_charger_info *info)
 {
 	struct power_supply *psy;
 	union power_supply_propval data;
-	unsigned char fsm_state[][16] = { "init", "discharge", "precharge",
-		"fastcharge",
+	static const unsigned char fsm_state[][16] = {
+		"init", "discharge", "precharge", "fastcharge",
 	};
 	int ret;
 	int vbatt;
@@ -313,7 +313,7 @@ static int set_charging_fsm(struct pm860x_charger_info *info)
 
 	dev_dbg(info->dev, "Entering FSM:%s, Charger:%s, Battery:%s, "
 		"Allowed:%d\n",
-		&fsm_state[info->state][0],
+		fsm_state[info->state],
 		(info->online) ? "online" : "N/A",
 		(info->present) ? "present" : "N/A", info->allowed);
 	dev_dbg(info->dev, "set_charging_fsm:vbatt:%d(mV)\n", vbatt);
@@ -385,7 +385,7 @@ static int set_charging_fsm(struct pm860x_charger_info *info)
 	}
 	dev_dbg(info->dev,
 		"Out FSM:%s, Charger:%s, Battery:%s, Allowed:%d\n",
-		&fsm_state[info->state][0],
+		fsm_state[info->state],
 		(info->online) ? "online" : "N/A",
 		(info->present) ? "present" : "N/A", info->allowed);
 	mutex_unlock(&info->lock);
-- 
2.50.1


