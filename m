Return-Path: <linux-pm+bounces-23604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5219A56023
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 06:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB31893808
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 05:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709313C9A3;
	Fri,  7 Mar 2025 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSyqezQ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DE7FD
	for <linux-pm@vger.kernel.org>; Fri,  7 Mar 2025 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325908; cv=none; b=Ci5Ihyd9y8IW3JYB6CJSMm4NEf2rzuF2KFHLXOtqbLKybuHcmW+8H8YucMLuobrxkbykedKPk/p3Hpp7+ykH5spd5XyqSzyfGyTq7JAZ+ZhbjybXcT+qSILvWZiSCi4z+45SQxyzDwZapDw5GiBVBNdk6+xC48MGKhZwtxMGqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325908; c=relaxed/simple;
	bh=IW4vIFZWOjZ59KI5KErWGC5iRY88eTLYJwt2dHLfqgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBS/r02Ir/k3XKD+qEHLLYS+393JUCgqID6XwprDREhEuIS5fRUYgc9qm3YrnIufesPsjkPfF4GVXRPGRyxfCU578CkZK8GFoYfe3fMfEikRlCdQA9jUSFH9P1LagVE2274uFT6iHV144K4bgrvv3dhtfBeSNCPEJDRa3wYG5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSyqezQ3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a04so15373361fa.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 21:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741325904; x=1741930704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrNW8kSm2go2+vpcDO5w+9NJP60EUvhz4lr501KWPjw=;
        b=cSyqezQ3dIPGbnXhBunaVuYk+g6OAVIml5tPraSXPy+e0KEJVBg9OSLDdaaJjmc4MD
         +eLysNNqWtKbjL4QICYwP3oyMo37mgkS2bsKVjLztWLrLOypO/1nbWcJo9tlEylTzxn/
         iuL0cznuWutYl/enQMU92RYS128qIkolpvbOq55QsDJ5PM9clqUN7HTWX+01hMp/d2KM
         0ST8HnRHGY1GWjWGLyQFJx0areW97Gu/kq6sY+iQBDrEDhPqqUqwFhz45gTHl5PTyRYX
         V5tp11cSY1C18HX3cHkC1IQAQ5PiTzGDKMZtIpElT8OO9qDV1ce2bWk0TiFKaoR6/FvJ
         4W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741325904; x=1741930704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrNW8kSm2go2+vpcDO5w+9NJP60EUvhz4lr501KWPjw=;
        b=V5gnF4SFhCqY7/yibz+WrFrLrtW0V1h005+D0QMCZTL8lk52B7iBGqQazoEWz/gCRT
         BpGzjxoV03/ytuSuA63Q/CdEynSPEXoWsnPB9FBDgg4RL/C4SfT1imSRYWCftCNn2gdB
         kqRWUSSaixK+AnFDiirEiRD8VHhbwUljyre6HugN0arozrjVP37KGNtfNN6J7jyBhArR
         g3FRWpDjb6Qb5H7hrSE4Kky8OnTNANKxMOtGkBz41H3YP6onoW35SWOGXPpLazNKeFK2
         Rf0SErjNmUgWr4hgK8r9DxH5AYqk4HHq4eXAp/f8NXXhYSp/aAY5hMz8eyVWuik99WXC
         9ltw==
X-Gm-Message-State: AOJu0YwVz8N3BN1YHpiIXsxAhfWhvWdrFAxGklw9Se72zhS0v6HlDUsi
	Ibtx1NN+KfzHZFrEiITfKi6KM4EfS0WfrJEWbS+p69yDo2SqSujs3UmgUym4
X-Gm-Gg: ASbGncvV8dWeXyba5cC54fPd8JVGuWRpFY0jRGp36LmNWc8shGJau8ENwK45MChXtu7
	F38/ddVK0EcCzkXPllfdYK1Vvm7x8nKSIZRColAoYyH3k+USQCqIbTDEVuG1mCJJ8O5/YG/pVAf
	zQuJQsN7Kxfp0FGmuF3mglXN7IB+0N8OvFVMw16J+ra8+f/mRbtIpL+3GGs5n+dw2sv+bViHvlo
	fi5Uz6jgqJr/jek8bnCSxdgJeuOY8+EQtA7ykuPBH22bUfc/SCqoY5wK6T4D1D2wVBxApSZS5As
	hW27mdEMEHQluu9tYxpG9ZuKxehV++7MUUb4HoECClE65dyZ9iayVa1anJNsxWUikKQ=
X-Google-Smtp-Source: AGHT+IEp7SoG/F7KyDIyYNCIh3EbQ88+sR7Ca9biQFRmiQKnEigynrMoZ4zlZE7rilhZczzDNdjbyA==
X-Received: by 2002:a2e:a590:0:b0:30b:c328:3c9a with SMTP id 38308e7fff4ca-30bf462cb07mr4984351fa.29.1741325904140;
        Thu, 06 Mar 2025 21:38:24 -0800 (PST)
Received: from localhost.localdomain ([188.243.23.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98d07e5sm4595701fa.22.2025.03.06.21.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:38:21 -0800 (PST)
From: Alexander Shiyan <eagle.alexander923@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: [PATCH] power: reset: at91-reset: Optimize at91_reset()
Date: Fri,  7 Mar 2025 08:38:09 +0300
Message-Id: <20250307053809.20245-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a small optimization to the low-level at91_reset()
function, which includes:
- Removes the extra branch, since the following store operations
  already have proper condition checks.
- Removes the definition of the clobber register r4, since it is
  no longer used in the code.

Fixes: fcd0532fac2a ("power: reset: at91-reset: make at91sam9g45_restart() generic")
Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 drivers/power/reset/at91-reset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 036b18a1f90f..511f5a8f8961 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -129,12 +129,11 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 		"	str	%4, [%0, %6]\n\t"
 		/* Disable SDRAM1 accesses */
 		"1:	tst	%1, #0\n\t"
-		"	beq	2f\n\t"
 		"	strne	%3, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
 		/* Power down SDRAM1 */
 		"	strne	%4, [%1, %6]\n\t"
 		/* Reset CPU */
-		"2:	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
+		"	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
 
 		"	b	.\n\t"
 		:
@@ -145,7 +144,7 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
 		  "r" (reset->data->reset_args),
 		  "r" (reset->ramc_lpr)
-		: "r4");
+	);
 
 	return NOTIFY_DONE;
 }
-- 
2.39.1


