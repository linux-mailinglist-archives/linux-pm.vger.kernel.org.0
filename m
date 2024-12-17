Return-Path: <linux-pm+bounces-19386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314699F5429
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3491740DD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F941F9F62;
	Tue, 17 Dec 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acxmSJJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F11F9EBB;
	Tue, 17 Dec 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456648; cv=none; b=fNTPEwem7Z6UE12Pi16pV8f8wFHnorqC5RToJ1aJld/hjnRWMz23HtAKj507AzgBFSLL9dHOYd5G3g8hod/05T17CZ6XaQczRzt9BCdIRAoo5ZdI/WyfFBRKGEeraR0xJ4MreqBOmQFOrFdufTjsowoiG3D84xp+OTLTY0OeTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456648; c=relaxed/simple;
	bh=+FFiRlSo99k/2BJM4fC8uS16GzJJXvxO8BQM/0zU0VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+8PKJuXDFM11zf4dMcKOCCKFQEUmO95LRybOsQb20gPRsuMyzcdt3m+3CmARjTyoildiX8ciSQj6weFqDZm7WACHmvwEvzXGVPly6oCgVtOTJDN9mfRg4pqnwusLyvGQqGEvQXn9ma7Mx4f6Og0T4G775Xs+t6kRgVvJi3xq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acxmSJJ3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so918384966b.2;
        Tue, 17 Dec 2024 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456645; x=1735061445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LqDPKMP8x/bUFI6SrSGeUk5x3byOylHQFv08vPFx6w=;
        b=acxmSJJ3VHL3aOyn9omp/W4ZMECKOKru94+nFh6A6xBgLk6DNHfHkJ81mIHGM1fCXO
         Z6cbvtkFyUn5hhp50LVj+3vi7L48W1vvpY8XfZdGr2eMp0CjxzWXQkHkPJqr36C3biup
         zknIw2NOfLk17Sb/rtqX35TlRNV8ai/RY/i865ZHL5RxeWNMN+G2QTY4qU1vm4hWeaUU
         dNuS9BiBlI8bbVcGC3JK5MEehH9VdqmPd9S1msKO8s26uzUa2ysQIJyE4ocdUNBfeA7k
         oJXuITwliBxs56eQix0B5Em7joK2bRZDIFI8d8sJBcJLzHy47hs1+0S7vdyi49oTke3q
         KLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456645; x=1735061445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LqDPKMP8x/bUFI6SrSGeUk5x3byOylHQFv08vPFx6w=;
        b=SXJrC4bvz7R/CtxzBB6nlzrUpeRYGof0nuoriciA2wjideHJsAvOEPkpdCLrqm9Lmb
         pICa8B//D870BMW4OcQpuPlqlizJlytILD0VelVaVb7TCPgfJvH4CX3pKXIsSg+FjDsF
         TXRUmSV3i1mahqOq2ur3hpCF8M4YlbdTRmFlbDOGqjFS0zMk992SmHtGtQ4lpLdW0usF
         WqmSpCL28iasTAPBkcnFTy3CxIh3oPYypC6zyDQ8GKsYt8FNYsAWEulujdzexwp4OLeD
         k6DheMR3Gd4Sgl9Y9VbwVS8vq5zmgQv+iZM8ESaWLxKAPJjzRUEqP30KZbq7v1kK3sNm
         eRnA==
X-Forwarded-Encrypted: i=1; AJvYcCULPIC4bI623PPHFv3w8tdS1lirkCfLCXykFgmIglhRPBrkpOCQR9rA0JxjDMCN0VeIzNn/assa9C+iD3Q=@vger.kernel.org, AJvYcCVV7rl2UFoUSJu0pc9yFmdsE9IySFKRbTYWYoUPuqvtYgSfOSuoIbv6Ywiz/PhECGY69zcXAkwuGm/5/R16@vger.kernel.org, AJvYcCWAXQXG5HvUroLuiTlAAvhQg07TDa+oZ279vnYYrs4ippr6GnN+aWwNwG/K+nby8YpflwQFfwKZbroP/g==@vger.kernel.org, AJvYcCX8LxGjNUJmKS5ssfAZLK5emAYNrVr96a6j9GOGae+T/gjm0rjmJyHLZ7jPIX63W1HHluqpVvPB20Ry@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPwI/LSp9semewNzj7AycDa0sVmK/GSXoeyppdMiUA6rCyeu/
	cZPyH55xonmhaSQH/BCnsSQMrFlG/VelI1lIbM17ERHg3KjXDGDfQvqSbg==
X-Gm-Gg: ASbGncuKC/DrCjgPs9fHa458kz6oYncKFgrlO6d9ZdaeOYnKJY9jGKTNR/RWctyR7EZ
	vljk3kImpqIv5XKY562I1kXYmDDeLH3dQrXkhqZUgdkOUjOYVEXZlTyngcMdKjYOWWzc+6PjO0n
	4Cl3Qzjcdm2zBm7zwCaVAWTVqSsKd1ZWS5hdJhOcCdG9xFCUH0hRJ51Gr0KB71/QUBYyG4uWSdr
	Nc+r9wrcp4AI+FapIeqyD3qOoGuGW/qb6ba0G1nDpvgsNkpkLhzPB0=
X-Google-Smtp-Source: AGHT+IHyJ1xzTMr00z/xVI0EuUuBw+7rjBe7/iaEUnQtszYu7MmySsEEdGvbwvxqylshhTNr7ZLyFA==
X-Received: by 2002:a17:907:3f23:b0:aa6:9fad:3c1d with SMTP id a640c23a62f3a-aab77ea5969mr1931278366b.39.1734456645114;
        Tue, 17 Dec 2024 09:30:45 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:44 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:06 +0300
Subject: [PATCH v12 08/11] mfd: simple-mfd-i2c: Add MAX77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-8-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=1366;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=+FFiRlSo99k/2BJM4fC8uS16GzJJXvxO8BQM/0zU0VA=;
 b=rdErnLbkKIKZVkHDkkOh5Tel0i3+R4O2Q7EKdJjNVI0Ci7/Tvap+dguurlHkl5U0M3Rn1fVG/
 6Cx68MdA7jBCrdRW4tDiKhg79AA34VQcstDC7zAgjK4SkOQUwDXUDQN
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add MAX77705 support - fuel gauge and hwmon devices.
Hwmon provides charger input and system bus measurements.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 6eda79533208..d6563f4263dd 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -83,11 +83,22 @@ static const struct simple_mfd_data maxim_max5970 = {
 	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
 };
 
+static const struct mfd_cell max77705_sensor_cells[] = {
+	{ .name = "max77705-battery", .of_compatible = "maxim,max77705-battery" },
+	{ .name = "max77705-hwmon", },
+};
+
+static const struct simple_mfd_data maxim_mon_max77705 = {
+	.mfd_cell = max77705_sensor_cells,
+	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
 	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
+	{ .compatible = "maxim,max77705-sensors", .data = &maxim_mon_max77705},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

-- 
2.39.5


