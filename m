Return-Path: <linux-pm+bounces-20003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B001A03B28
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 10:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492043A4909
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF481E3DF9;
	Tue,  7 Jan 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7L16J9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C21E0DEE;
	Tue,  7 Jan 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242311; cv=none; b=XDlzcjd0UTZ6CdY3Vx35FgcPkffqQUeXUmJwZiZOSjdcXJhWNk/1v23r1OUfm5PrDlVgxl3qbiR1EfEAQfothXEd0btDGJ2REfcDvUuO9PMx57kjeaf1abBhSm0j76qQAkOFbs3vGZZFZyo1zeOkn1HIvouKN5CLutyzMFpCOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242311; c=relaxed/simple;
	bh=OsA1dEJLjjYZ2BIUPRu/DSyAQjTWyqdaRkl5xknsg7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8gcmju21WH3iSx05T7cNYBkbdTGTmmQbaWUeG3ZQpwtXPwxg9D9zQfzh2toEfLphY6E5tKl1OGV1l+wAADLibVRgvcSH8faYA3JMW2XVGShYGuAGfnnhVo3Jyh++GPrjxwGPflc2acIQ+Gqxa1nKqd4gfGVScxUEsqWaTBIcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7L16J9T; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso28856521a12.2;
        Tue, 07 Jan 2025 01:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736242305; x=1736847105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVVIvwMJ1kFj7ARNI9PQB5xeCct+X8ALPUkf7yd8p6g=;
        b=Q7L16J9Tucu1i7DQb7DLh8yT0wPY/X2IA2ZnUH5JuvgdlGBypTEeQLgl+60AH9ObrN
         4p8DUTE05l8+2NNgKOheAqrsuUs4nziayrEIPF8X6pdpVSNRm0cDaboHTxdfL23sgTr9
         FL2ORhHGM2DSghsS9wS57lg37LoK+6tNyY/671LBpFkSbEVgsid3IsSIj2+cYYAZoXQY
         KBs2RgbzHyvUPXjhEgdejjdwnQvIND7osKXkAEXrUkc4amCGZeJRvdk7gUlbl0jWFqp+
         ywnl+ZyDn2nGay3p8PEAjEZuKPvzvlf6bMCzRwBWQ7YfqvbEOlP8IOxQaH7h6xTuauon
         xpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736242305; x=1736847105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVVIvwMJ1kFj7ARNI9PQB5xeCct+X8ALPUkf7yd8p6g=;
        b=pllXhJ1Sx1nF+Bp4I8it9ht9p+8QDQ6cKo37Fyt4YlMd089Fhlq3MNHwJ2YHf/X1tn
         qOOvFRaJp4e4y8Q4E0jsr9w7VjSYYchCJH7q0/crZy+U2rBjmIR1W3kDolwoFGG0xPPd
         9c1G5yd7qVGFHDZsGLTmeIOQXKNoQy9whX8F/O5rZJVzyocTEZPX+IiCVl+X0bPXutS3
         9mfEMdvbXKbBnoPZ6DG/Uz2GsLZpkw1gmVODHrvcvSZn28kSzrVeiL9ehoYwc6O9OGev
         BIxpfbMS3EA0NFk+vyfjBI/sqRD5MdTqNXi9Ha2jE40WA9okwy3PI6xC7ZUoaTvGwGK4
         75XA==
X-Forwarded-Encrypted: i=1; AJvYcCUglZu331my0Gf9B2bwbZayTP5RpWO7yqKVxSlWAz0LNGqD0Z/FPD4nLl1MJ/w/TtorzOyC5F3o0aLg@vger.kernel.org, AJvYcCV5KEg/mwO2yzD6jvRLLkJeEoN5R3CuNGKL5O3UeY4dAffefms4UgXaxareo6XgewEqeeGo3QF2cc0P4GSxkKII6nY=@vger.kernel.org, AJvYcCVn5biw57SIq917eAHMpUJtGRm4JFwIzp/VYRtMzwwF/njxIihcujhcG/BFLgwo+CQtjGTLQjYJ19f6JWleeQ==@vger.kernel.org, AJvYcCVqBLzyP03js2BEMpKlsbGOVWnml7nFHcPqAYsMd2Uwey42siuOLfYz1Aqv5z4s/FHXiCFD5egbIslibcYg@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWQG09E/F7wEY31izqTsD0GOhqHPEeq5knUQE9TmO+SIYivTa
	Eg2om4WwdG3OyS3fEtzT6ZoOIQleCHrL42H3lVDNSMO0myZLsDAd
X-Gm-Gg: ASbGnctAY2vhu4UqiYS1sRdqvZ4Uvz2bM0/3edHna/DxuCPA9L+jC+1b63YAhV66xfZ
	8IZfJKt+IuOsfNvb+qDHue7izQMP6E9h3MrxhWw4ZagZCgdVtaJZw4O/oQBIZDb7St3uh9aL6ZM
	6rhfC1MCDe6IbWlbhNaS3lClepEwa0jaDVmtOyXq3+DmE63EfVIQxVXDQFtMHBIWSE9PaRK0ta3
	EVC3vgQEpNdTD0023b48+ZBQYlnGjTUuB3KVYFb8HKxTn/xV6yd4YOgp1L9nF57tNxc+sJq1ACI
	JOIiHGXb07BeHslsAzwL+KjTcw==
X-Google-Smtp-Source: AGHT+IFxd3YBOxk4ntPc+MGfHTxmMyeBqIw3Ey/TIoViFJfaz0wCgI08UnQ4BfUpSjzeL2SymnOtSw==
X-Received: by 2002:a50:cb83:0:b0:5d9:a55:810c with SMTP id 4fb4d7f45d1cf-5d90a55817emr12774693a12.5.1736242304417;
        Tue, 07 Jan 2025 01:31:44 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806feddfasm24976300a12.58.2025.01.07.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:31:43 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 07 Jan 2025 12:31:30 +0300
Subject: [PATCH v6 1/2] power: supply: max17042: make interrupt shared
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-max17042-v6-1-3d0104ad5bc7@gmail.com>
References: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
In-Reply-To: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736242298; l=1245;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=OsA1dEJLjjYZ2BIUPRu/DSyAQjTWyqdaRkl5xknsg7U=;
 b=J0dWnGbnmiouoiodH/YY3fMMFLG4B8Gx/vWl0yc/WZJl8KQeP94ZetXT2O/N9KE1/fYvk0BB4
 x1EvIJYj6moAFniEnk39u1QMcPvRqdk7vkeILsipJQhrNpB8Lnhv7v2
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Fuelgauge blocks often are incorporated in bigger chip, which may use
only 1 line for interrupts. Make interrupt shared.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v6:
- reformat commit message with vim 'gq' to wrap closer to 75 chars
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
2.39.5


