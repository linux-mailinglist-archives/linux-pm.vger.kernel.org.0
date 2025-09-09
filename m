Return-Path: <linux-pm+bounces-34283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B176B50257
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5050163B46
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26C34F490;
	Tue,  9 Sep 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5sXPnEK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C133A01A;
	Tue,  9 Sep 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434749; cv=none; b=WuhPg/wYHCTw0iY57Q0xFW96tArbHo6NCs9nR/EpbWCog5QtcAcFczzyx8+2q637cVRtmaW3WR4x/ugXzs0juDAj8qBbK1Q9mnJvWbmD67VDZ4lysJ9c2fMfmF4/PWIvqAY4DRCpoeaApkdEpmt8ENlv/oqiB2UxUyY3/tJ1sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434749; c=relaxed/simple;
	bh=5+oqeQqKcOcNexLLWSaNP8FwXROd5N6zTPNxd1c9umA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G88c48Hn1Jm8F9M4dJnitjW9nutfSXjeOUQpcKLWKsLHIbMYFulMEqywqX5y+UiKLza8lX3oqLywAh4iMLbVqdfDllGOFrcl+ZNpc7CaTKZwKZDEmEhJ7mz6fpyBTjT3iL1uMQpnfc4ww0b337Qx25EE9hw6sBSDZc1efgfwx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5sXPnEK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cb39fbd90so48719015ad.3;
        Tue, 09 Sep 2025 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757434747; x=1758039547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAi4h7GkC5BQfTMRwYsmkT5Tfbmlnk4jobHVH0SykIo=;
        b=l5sXPnEKk0LR4ccF5FAyPuiQk+wurRvsvDXs1X0iddwlzLdEjYMTxcjMGS9eKnI7zi
         aNQ1FvCd1sMVhQoCf9hn26YyZQwAKfw1Jh93nwiPAnx/GMt/Wp6+ikk38/EGekNXovKK
         PT5XzQ2UKt0p4hMhfGHUXN/iG11wKGac5C8modnQkovLw4IBLvMKwbQgTIWf5BSAWNR8
         l6IJQQYWZzBfUVyLakn8D1aHkyA6MlOmRtmkE+mTJv0qzOQlPD+VD1OceGSl+yv/vGhI
         61k78fUajVWYTCrzjyK1ZzxeoO1cZXofkqAqH+hVc5gU9qkC8y4gpwdiV2hWBGY5pyaw
         cOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434747; x=1758039547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAi4h7GkC5BQfTMRwYsmkT5Tfbmlnk4jobHVH0SykIo=;
        b=Au0Q5iGpZQWuRQY/8e4t5tIqj6SQC8h8Zib90QLO11f5xAkdNaO5QVLgtMoOn5GbNc
         NbrUD/1mNZVdr7ZmHltdtXa36KwZpqtlSnEO8U6rJa0VuuqSxbt0Tohg2F2HN+QN7Xs1
         eiJSMxo80LkivaP+QazavfHV0FePYAV2xwaKVZd3Da2enebCatIBBqgb1K3bqLVrxrnX
         SbVVm7f/4bJgBkdhclBi+YQ5OryRmG69mQVMFRw4yxdXoXNCeTtzQG/DW1jHwn3NIW3S
         H2//F4os7WW6M1IdMuJwie5kPulFg4o7R2mLz9ZS2Y6WviLmCVvTpyb2UcSpFcpCrcUb
         NXrw==
X-Forwarded-Encrypted: i=1; AJvYcCU47gN6Saqg0e5qDpS1CA8SrFfbO2nVYOTNloJUeSjlIxZK+Ur+HTsMty+F73ZiJjtiuG43oh9ojAsp1QI=@vger.kernel.org, AJvYcCVHUqV14pSVroZq4gzVuVtrTXe/PomOg20hpSm7VPOIR/JofGtdKhGagnOSqWVN2gbFwuswdQKPrQE=@vger.kernel.org, AJvYcCWFyOBc1fBHoqwm/tWyKjX6CescWsHpe/V1qD8zsE52XZEd9Xrh28hFM8DuaehRwUGTgBMtYf/NOy52@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvwtC1N9oOCsA+qLmy8MRAB+e+VsGtuJZr5V8DLYMxcyS3eo3
	G618Yw2RboWKGJtInP/oqbhjSzf/GTtP3iI3y9b982rjRpjZ64dcwjWe
X-Gm-Gg: ASbGncshLozy3pywiRQ2Og6lVL0Kpfe63crFzOvK5I9s2hROYyYP3FSf5g03zMCCWLq
	412dNpswb0582pUURlaTLHrwkxRml1qmwF55b5Nb2ulMw/hBVHoXRXCOsR5TC/3nimFXlNKmyqi
	5ZJ8lEC7qnOLn6S1fKVl/BEO1ko1OkgMtRpNRallBZSwiTfQmHaI86LpJUhtgNC+B0+N7ZC0cEQ
	pzX60J0winKTTGKMLeyP6TCSokJFPdrWocWGN29Xo0lW4eKUgX/HJdQQ9IF+Wkjp96thQN4fdwM
	3KDdxGimsS3QFtPjTCQy8+EQHYqUy4YFPQJsrnTiOc+MpB+MAOc26JQdEIcbZVkKFw3sQg6dIUM
	rlEV3ZCQLHNx8TGsmebtDIXE=
X-Google-Smtp-Source: AGHT+IFc01xMg0RhYt92nNhZiu4xLaJuYGnO9/E2/g5lUU+8IKkN3wggu++B8oAay63yya0pPMnlBQ==
X-Received: by 2002:a17:902:f78f:b0:240:3eb9:5363 with SMTP id d9443c01a7336-2516e69aedamr146484675ad.27.1757434746918;
        Tue, 09 Sep 2025 09:19:06 -0700 (PDT)
Received: from localhost ([104.28.247.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422decsm2241595ad.4.2025.09.09.09.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:19:06 -0700 (PDT)
From: Ryan Zhou <ryanzhou54@gmail.com>
To: stern@rowland.harvard.edu
Cc: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	rafael@kernel.org,
	royluo@google.com,
	ryanzhou54@gmail.com
Subject: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate child device xxx.dwc3 but parent is not active
Date: Wed, 10 Sep 2025 00:19:01 +0800
Message-Id: <20250909161901.10733-1-ryanzhou54@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue description:During the wake-up sequence, if the system invokes
 dwc3->resume and detects that the parent device of dwc3 is in a
runtime suspend state, the system will generate an error: runtime PM
trying to activate child device xxx.dwc3 but parent is not active.

Solution:At the dwc3->resume entry point, if the dwc3 controller
is detected in a suspended state, the function shall return
immediately without executing any further operations.

Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
---
 drivers/usb/dwc3/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 370fc524a468..06a6f8a67129 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
 	struct device *dev = dwc->dev;
 	int		ret = 0;
 
+	if (pm_runtime_suspended(dev))
+		return ret;
+
 	pinctrl_pm_select_default_state(dev);
 
 	pm_runtime_disable(dev);
-- 
2.25.1


