Return-Path: <linux-pm+bounces-19691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A19FAF29
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E427A2C3C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3011B85F6;
	Mon, 23 Dec 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6+9kZNb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB71AB528;
	Mon, 23 Dec 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962407; cv=none; b=YiISThugCO7WQDLH7CCqgR77Z77hn1NpREHQ0+8eMwt+pixiPH+ts6qs+UTSp0L2aiPlUd65g+drn3ua38srYqn585PA6TBfrF+nLf83WtWHrZboxoMTS3Hg8zIhUSl0oFIZhRYNrkZCfe9m7FM6VISKp0I5ICRnhEYTevblTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962407; c=relaxed/simple;
	bh=iiRnf4Wt6mhhESchgHXjPJDU1ILplxAAXBKmr7mHB+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tp0EX3Glyivuz6oM/ND51tDFy3qf0uXbSEMLV2PkIMqrS7rhS3oy9iee+FV5128Cs+NlWhf0GVnZTmQge/zE8D710Kv4ygjpIQnjrR7qC1NNqHo4gPGCKHhvg8tm2bZKXTjvHkr3k8I1Xy5s6WIuRqq2M/D5vUtQHvTJY+Gw8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6+9kZNb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so6923761a12.2;
        Mon, 23 Dec 2024 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962403; x=1735567203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny34XKwUX+MJKcT29KzUxMJWJuevNw9zT0IEL+SXaPw=;
        b=b6+9kZNbj00VRJHzFDKKexYsC58KoAUkfDye5yWmIUprC3BU4NF3Jy0E4GcZACOgbU
         JbGaVPK1nJxG6xOeUV3IWiqIR6G8jOnwOPAfq1BmcyAPubhtYwMTKDJfzjmtVSH+jd+R
         qug9++vwzBJgC/nzg9agMCnK+DfHquN7Pfrl60UAXwDxNbkbdtSZtOPlYNt6/zyahyxr
         BBg9D7S6eIBW6d2gblDudMs2ohrdfnZTgj23W5T5pdyCnwAXrRIsMzZF2YfhDj0Zreb/
         udLjj5kKRRuMwe541urWdYiTVXgB2DQ9zW1xcN8mn5mtwmAnMMTcvoXJLr0aV604+xii
         mSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962403; x=1735567203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny34XKwUX+MJKcT29KzUxMJWJuevNw9zT0IEL+SXaPw=;
        b=g3euoXxw7tPa/kz2YxPkX9m1WxJ0CmIdMd01r03O81N1aVdPuS5SkPpoNhAFo3pjiH
         guS3v7ZTvHvmrisRZRTsb0kWlFXeuN07Mo1/UmoxlSQMX7k6pkTSjCsOLwhg5YaRHEg3
         QtbqsFHHKCXyYWUtVDfzTAYO6VdRFlOGBponjwafJEBYseDYoe0LGYGeetAAV4WEoxK1
         NeeIzzSSpJCR7RESuiyZVeRSWv3kCL4hWqA3UTgcmEWgzpyNU4O0P2Pv/PmAHWmm52zf
         /v++EADlDA1GeldoA6e2ec2PzKSHCgZU29LV9x7BwDyS2WZEO00DolUfqh6804nQuP7a
         lpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA5Tv7kqNv9PktDGiLYD4rxNU2pdFkD/Pcxp9u8chjFUEe89mlVo7YJusXAEOGfeHJj1TPAiCbQOkvqA==@vger.kernel.org, AJvYcCVmN/emcZSw3fZNAEgmkD78He5c3FZ9CofXG33Bl3rd4j5zhLyQICwSMjK5P2HmkgtKi3Mi5hSeB7dylFU=@vger.kernel.org, AJvYcCWXR/mhBS0zaUt++qo6FjJ/YCpA5/qPFgmaytzs0sQJxxjhWIdXs1AcYGy6GrrZKFytjL84RuBDzWb4@vger.kernel.org, AJvYcCWyahWQDA1L0W2S1igin/LHvqWQJLB+UZghqe1ojnNs884pegGnY44YxoZIgzxMCYWPvO7mGK1vl7Kjb5mm@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7QFWYARtT9EoY8HOjRr6wjK9MS1Bccxm/W63DJSl11u94ZE1
	DnyE9henSNY5MlUnk3QiQK3s0EfAGVkJb7Lx/Bamc2bEvGBj1pAYn85+SA==
X-Gm-Gg: ASbGncsmPHJil0UBp6HC31Bgub7XD64GKBPLT455Oceb9RSS6U4eE1p2SafAr5PNlX1
	cQHdMNJ6yxREe7tRji3wPUH+12YnnbFjeoWMcVkAK6DgZjUfPS/HqL2bLMa50/Hf1khdajTfg3R
	TEFf7dzxxTlILlELFDUyCNbVNhq0oFKsqjO3YNTrEq+KVl8rRRpSWuVK3E2u6zKJ921UkqmgO5v
	jGRHHYPurdVXwhyP4TU9LYDOGctDv14FulM5YtvFuIimWxp6Jn1isXjAtwc5Wrx18yEejO1XAvh
	nu7u57fnDDl0rA6PG93lexDzjQ==
X-Google-Smtp-Source: AGHT+IGpn5wHrBJunR1KMzyucrBTjlRpbJha9jZ1iPfl8wogGhhi4lxWlgScM2CfhFfDWR4udtEPYA==
X-Received: by 2002:a05:6402:2344:b0:5d0:e410:468b with SMTP id 4fb4d7f45d1cf-5d81dd64032mr9926960a12.2.1734962403472;
        Mon, 23 Dec 2024 06:00:03 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.06.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:00:03 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:42 +0300
Subject: [PATCH v13 05/10] power: supply: max17042: add max77705 fuel gauge
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-5-fbc610c70832@gmail.com>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=1366;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=iiRnf4Wt6mhhESchgHXjPJDU1ILplxAAXBKmr7mHB+o=;
 b=R4Hatde9fNd2nAj2joX9Unc4pmaSd8KkOnjVS/EwE3gEKrZHiv97Dteh0FTGnDrZ800oS0HZE
 nn3ers4mzZqD2KqkXRyIhtDFE1PzGevSveIQybwdycA9XUPFkLSZmzp
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v12:
- add only to platform version IDs

Changes in v11:
- add device type to compatible

Changes in v10:
- keep alphabetical order
---
 drivers/power/supply/max17042_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 4037843e25bb..655b3f25dbd7 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1234,6 +1234,8 @@ static const struct of_device_id max17042_dt_match[] __used = {
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17050 },
 	{ .compatible = "maxim,max17055",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17055 },
+	{ .compatible = "maxim,max77705-battery",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ .compatible = "maxim,max77849-battery",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ },
@@ -1256,6 +1258,7 @@ static const struct platform_device_id max17042_platform_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };

-- 
2.39.5


