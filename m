Return-Path: <linux-pm+bounces-19635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC19FA193
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A0B188E4AA
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F684D02;
	Sat, 21 Dec 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDi+XgE2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A382594B0;
	Sat, 21 Dec 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734797508; cv=none; b=u0EuKEDvw/F1/8l6khR5JdMvZEuQ7wXDG2Zt+KSkqgumuhyyQWZ8gWpRw3eYzNUDsNfpigi3uQvwhc9fFbhu2+g/sivkq+/PoWJK74QkwJOQzZZaMfyDjw/ngRZqFxCdp+lwoqLB9Y4ACoIgfdUJeWEsD4+WdLyIOVX1QEpaTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734797508; c=relaxed/simple;
	bh=4l6vSmU6H3/gH46c7TY6XexvMpl9Tbn6h6djqCKt68w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5bMVSuDck1CAlEvgII/Y8zpm9MItQKYVEi5qG3Tmt6yoHOSsCWlG2MHF84oSKNcn+9I/DxolFIj6doLnR8oIUO8Jbnv+PdpcCUXoSyVP6CXMDqY0LfskeKHaRbjdfXBHUiNRFJ6CnqkVSlnfQjroqsea9QQST4VGUfCW6NAlls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDi+XgE2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-432d86a3085so19645915e9.2;
        Sat, 21 Dec 2024 08:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734797505; x=1735402305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMCKa2kHuUWmElxWaY1l9q/QxwLZpjC1ScEJmIAvnik=;
        b=XDi+XgE2EBLkusvbtN8fbwaGSVIj4LYg38uBRPZunwvd5pWG4m0lXjtWav9M434kH7
         0Oq7KQ5dhG0Ntdd2YDUUlrwcCPzVDWO76blaF4ELjxVrt9NMkqqWwTbgVoF1VCL7SkMd
         O9R6rHkA+XD79cK7mFR5UFFIF9KW/Etxnn7yqP0fGajx95RUu0z9MrvtjRYEfu8TFmCw
         zMkqjN895oSAesENz6faKo0VdmLl0qBYVEjAwjZzj970tvqhllXejAY9T+VonwoV71Ut
         u4hkP+guu5IG3XCHKUTijtakZrm9/FYNniSkibJxwhZtVlgSbXbGgj6I97JouYbATQZZ
         c8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734797505; x=1735402305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMCKa2kHuUWmElxWaY1l9q/QxwLZpjC1ScEJmIAvnik=;
        b=RQDJumYgm3iUnNojNnwg8zJuLpIG+FVFIjRjl6EirizdSsmLXKsmbD6HDyp6qO8Ggy
         BkQDvJB9d6wcXwAPI7ERIXsYn6rEx4w5pu5b9I882G3mt3q6jCT8yXejwmLw3j+97OOc
         O9v9EGQCkMrxFdiw3TBxyBgWqk+65Lefr9RLuasS7ZTGKD6GVPBz463pMEY38lEW68AJ
         AfY4YruuX0DXJbwHEbSj4EAPw1vtZMS2nnIXKG77sl3W6CNP04xTgaWjjxLJEri5ao6p
         dCWbvomlOo/NTgeO7Uf7goPkfkgZFFySMuDBwa8qsUSw9s5NrlUTIGXyKM8bIyr4ELzQ
         xP9w==
X-Forwarded-Encrypted: i=1; AJvYcCVP+rH8k4Y0qzl1N9zBitxUniXB9iVRV7Zi9elcJnieLNQvPkcL18KPKjYYO4p73rotjUFklCXQ92TNpw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYmaCxMPMvtaGoHUAMRd6aq/C9mOmbGes/daAn19T17yTcolw
	3wS2jvkFe8C/YPx5pV1w44S17yNhE9UgUQDmZrrnSrgVbtpZ8DnxBrrOITUS2o4z3w==
X-Gm-Gg: ASbGncvXYEK9F8Uxx2RHZ2qEb68cAUIiglH9aO6oAy7zOzCJQ/yNiolo0qQ6ivaKHoW
	P43Xv8HvLu+yJBr231LcWSoq1+szaFWIv5vq8PXdew1bP0aIVp8srbjv2LP5Tg7FUJJlmgneIqQ
	+evovW3sQavK19mb1IA89BwtjF6MjEPUvKb4c4fWLmhpj4aTVwRRE0T6Xc32cnQyh4VCLMyf92p
	R1QF8q2fO/Ug9G5JBa6d5JLfHHpyOCDA4G9LVVtmIehD9UYkerJTFOhYbeda8grJaowBO3SmfU=
X-Google-Smtp-Source: AGHT+IH9HC2tOVk0CiZdhCmYlO8INNupobIw3rS9nlIH3hrcesT/WFoijknnm7fcoZ7uwydnFxokDQ==
X-Received: by 2002:a05:600c:3b9d:b0:436:6160:5b81 with SMTP id 5b1f17b1804b1-43668643bd7mr61138965e9.14.1734797504697;
        Sat, 21 Dec 2024 08:11:44 -0800 (PST)
Received: from tpt440p.. (ssh2.paris1.alwaysdata.com. [185.31.41.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219611sm79936385e9.23.2024.12.21.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 08:11:44 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	pali@kernel.org,
	linux-kernel@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2] power: supply: bq2415x_charger: Immediately reschedule delayed work on notifier events
Date: Sat, 21 Dec 2024 18:10:23 +0200
Message-ID: <20241221161124.114989-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the notifier is called we want to schedule the worker as
soon as possible. Thus it makes sense to reschedule any waiting
work and only queue a new one if there is none.

Suggested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 * Changes from v1:
   - Reworded the commit description per comments from v1 review

 drivers/power/supply/bq2415x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 18a6c3dbc758..22f6a3b71632 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -842,7 +842,7 @@ static int bq2415x_notifier_call(struct notifier_block *nb,
 	if (bq->automode < 1)
 		return NOTIFY_OK;
 
-	schedule_delayed_work(&bq->work, 0);
+	mod_delayed_work(system_wq, &bq->work, 0);
 
 	return NOTIFY_OK;
 }
-- 
2.45.2


