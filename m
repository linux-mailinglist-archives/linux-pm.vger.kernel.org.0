Return-Path: <linux-pm+bounces-17287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D379C3461
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94CA28211C
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46014A62B;
	Sun, 10 Nov 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acSfFGVf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CE146A79;
	Sun, 10 Nov 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731266671; cv=none; b=Zb8eo/RbtcNiWdweRZlrIdiVHOSPXrVFhms1k/WWt7RZxg7ENnrDnbN3lw3P2cVrcFyDROCdKK7tEi8G9FxyyGDLmhVPy4Beywly/6aScJ62jGEgB3ShnzkWpAdx/mX0ZvKHuEJlLD+c/dMrMNWE4LeHOa3yD0+vMlxH84/V2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731266671; c=relaxed/simple;
	bh=gES/YI8J+uY43qFcYFJFQDdZCjIIvFKdVHt8Cx7j4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6R29HxcZn+z5pamznpxDlQlaXZ57nXYCNPYoZvEd/ysGFRapEfFeii7e1/0tBp8GKTrHqxTea6QPUlE+XiMJA0NS9I4ESd1rLjmPJW6cEdgFjVK5goDQUJYOXNkcN9a1gODlhGmxN53AJUM8U4ZBqvrFkUsk91PyRsMO9/i5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acSfFGVf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316cce103dso48645655e9.3;
        Sun, 10 Nov 2024 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731266668; x=1731871468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7VSA4VpES10XaA8gB1WdvZsXgmDNfsDCe5+S5WIIkA=;
        b=acSfFGVfuzr3frauGhqb49l3H7Rg1Ar2YtBjNyT4te41f1VfFzv6vaOcuri92aYSvd
         hDxTm7hmhrankWp9G2uzuWSrsNHsnCk9wqkABZltbJ8HAsGIYHti6XEF+pQ6tXowv5+A
         imUfQD8/EgGFj3HWkDCaZOT1ba7Gzxpg42CIY08OPao8Yep8rgKtS2j6AdlKneESMbkM
         ba7SOrGG4zymySU1PaTqvuFF5qwQ6lYCShksc6vacGjz8tT0tB0eQDDZT0R3R5oNZK0h
         xGiiruSLIjH9m/PtLOn+dvB9OW62QZCtydwvZyHjoFSj8LjK0GF1hMQuV2u08ikvOyeF
         vatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731266668; x=1731871468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7VSA4VpES10XaA8gB1WdvZsXgmDNfsDCe5+S5WIIkA=;
        b=Qc16OrsuxzU0R5OK+DgSkCYIZ8bYPel6BF12hguhO3n//L/tFXRxc0A2gHgUIdYY/z
         F/AX4HxUr62SmJh+HczZxyXLE8A0mwk6nfxmLFER1WBdSTtQovWyn7dLCdLFeRQleI3o
         RPOTRlapt+Z7JungUClmY6mCD6LCy8MXseTZ2y1T7myhpM/VTMX8x2Y/8H490Tmvn7G4
         OiQLYNHdDmBMb8pNkxK5d+I4qrRRVdsWoBJjom09FUYPkEKfRZ0AwbLNkm8/NKkWntZO
         PoEAh3+4AdRU6aEyapoWkFfwic3jPQJT1PED8yfOr7MMh2FDTJuBvizOj7d3blJSZsi+
         hj5w==
X-Forwarded-Encrypted: i=1; AJvYcCU320BUkOixURxRqRXvpsuB4EdoJkjJUh5DIHyLuumzz5sM9vEy11tMVEFgPw6EW1EP8t4YCXoGRsy5@vger.kernel.org, AJvYcCVqUhvIzSqp7zf9BAlg0bu4jvqpV2IJc9OiGea8NwYC2qwsmYfUYDJubVJyIoObpFaj8Hlrsy8NnhI0+Y2K@vger.kernel.org, AJvYcCWNB8Jn3+8FEC/dPXfnUtKJ+McexPfGUmZJBSGnUAospFFhdPj12PNhW1uny3yE5yyji9R+RuQFsUxgiiBYBQ==@vger.kernel.org, AJvYcCXtdK/CM1SDp7dS2b2vsv1AXwBI9mWT4tTENMaOOjOu/FbQhc/HLA+e2WZO2Dy0segqzLI0R/jGyVpj0GdM0bNXSKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3nJzfiGIO8CtqfVjZhfh8Mhgv6PHIFCfRzwn5UVd+1hU0p6o
	C1Y07OGbjSOpg9PgJeldjUdM28rjKjxe/qOz69xeNWbrkFFFFdCJ
X-Google-Smtp-Source: AGHT+IGgpSw3jllLpv9qQZg4A+baIMwrCRGNX/rDvc376OiGzFy2u/Lnf48/wvV7+Plv5EMw7gqc9g==
X-Received: by 2002:a5d:6c66:0:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-381f186c5f2mr11167988f8f.21.1731266668020;
        Sun, 10 Nov 2024 11:24:28 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0e0fabesm502497666b.174.2024.11.10.11.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 11:24:27 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 10 Nov 2024 22:24:15 +0300
Subject: [PATCH v2 1/2] power: supply: max17042: make interrupt shared
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-b4-max17042-v2-1-f058f7a16bab@gmail.com>
References: <20241108-b4-max17042-v2-0-f058f7a16bab@gmail.com>
In-Reply-To: <20241108-b4-max17042-v2-0-f058f7a16bab@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731266662; l=1055;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=gES/YI8J+uY43qFcYFJFQDdZCjIIvFKdVHt8Cx7j4Ks=;
 b=hkNy7+sERWKdTJVRRUXl6kSD0hutXgVSx9H34Jeil05Y2fuKUhG/CScfxoHg1ESGkG6jYCRBA
 rN9iIrmtHkCCHftg66YAeKHeBlQNA7x7LKlJkd0nxvrukflRvAwcT+L
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Fuelgauge blocks often are incorporated in bigger chip,
which may use only 1 line for interrupts. Make interrupt
shared.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 496c3e1f2ee6..99bf6915aa23 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1103,14 +1103,7 @@ static int max17042_probe(struct i2c_client *client)
 	}
 
 	if (client->irq) {
-		unsigned int flags = IRQF_ONESHOT;
-
-		/*
-		 * On ACPI systems the IRQ may be handled by ACPI-event code,
-		 * so we need to share (if the ACPI code is willing to share).
-		 */
-		if (acpi_id)
-			flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
+		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
 
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL,

-- 
2.39.2


