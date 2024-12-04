Return-Path: <linux-pm+bounces-18572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA989E4763
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 23:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA74FB625D5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF012066DC;
	Wed,  4 Dec 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO8yu3RS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61D2066CA;
	Wed,  4 Dec 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343021; cv=none; b=CKKhcHbP0ZHi+76OkgswbCLKLysbzCc/bGJZ58Rd3VqqKEU7KcqFfYR7gM75+oV1D5OxqZkRH5ZV9Fvyoihriz36BUizJZEgoELpM+gZgWcIO09lPMZqIkaXdOEvobZh2bAkh1h6gDOZ5/grOSULoTnedZ29XRm1RQskyNblcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343021; c=relaxed/simple;
	bh=B9Jbf+WbkiUfqaxn+TOcx+7YMUZN7KJwybjo44749ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpQipYYPf6s3BM2HvjeIyc33C6hJG68wyfPywmAewlungYZnn7UPa/rRaCHp73P2cZDyJJHolUpJDSF5Sdj+GxOOCnbS65V1K4Bs/rUnFCC8Xj9UZNugCmof5Lh7ZSNynMFHCAIx5mH773S5D11lTWjUjM/DN7abXNYazfgiOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO8yu3RS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0419so100012a12.1;
        Wed, 04 Dec 2024 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343017; x=1733947817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93Jf5nOyXsKVNvOE6Npmd8LTxOlqIpdv9VlXWGYeyOo=;
        b=RO8yu3RS1kQl9in/9y+rgHQCnPzc4s1nvaKXnWftxfXMJmq+MZMqkZrgRyVNhfyIYu
         +Yd2XKrtvjU32GdykwDwZw7jbIQCgO1gLB5dwXq4XEjX/14nChLaLtto/DYWuzQPyYfl
         uLTAS6EcVC9M54cHHnJ7SFDeK40OBdj1zBI7lG8AT/lq/YxOsBFOqmICCR/E+Wr4yz7U
         PIY6oll/EaF6uzvz37uQs2bwA+ewgVE0bGKipD8N8e27sf2BD6GPCQFkZJb7K9PfLk7Z
         7PSZVXHQIkih2nhRuOLLTYEd7Ln24Q5Fl9axzdp9nxAEFWFrxg2QwcI6d5v8+huYg2xD
         bWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343017; x=1733947817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93Jf5nOyXsKVNvOE6Npmd8LTxOlqIpdv9VlXWGYeyOo=;
        b=Edv6GdkfIshQ20mkX04xCu4oUIv1+NJjmG8eQ8hBmY9yKfdslRzDsFc2zU8M+Exm6J
         gf28eBzx3Xh46KooZ15Xk4/U28niD+T/l9sArmuCLx9noapResR5EFT09sqDWhw5lSJO
         Fdz9SHwKQgX21HzOXhjqKlzDfmMjeBNBpUeMJXq73ODQX8MPWe13dOw9P/iP0UhILZVb
         bI5NOUEvtXdckBs5N1rexlNuJKYh/8rtlY1EuDWaVs2qCEIQdt1PPck7tsdudeBqBVbp
         eDYCUoz7OXGk+WHw75qmJWfUWOyZuSgtVz10Rn/9s0NLrAIghcStExjevEM7RIlLdHTh
         j+9A==
X-Forwarded-Encrypted: i=1; AJvYcCUbBGUZ2K9l5l/DhuWDvZRvX3CU5nqtMIlcVbfk3fAi+JZ90I3KHCUdsv66dS2b5Jg2RYJfUwak5PVt5tWA@vger.kernel.org, AJvYcCUg6HucmmoWkfR2H9IC5R+yAESsKf34ixAmgkd+StaHjQaEzoZWdEQAf2QOwq9aBH2nzsm9/lhc1whF@vger.kernel.org, AJvYcCWka42CWyq/u3uuvM8yQOb9ABQ0Jiyrdz1gzt/8XB75BDYNqayLowZ9aFCQuPLdtyD70gUtkxIEuQY4kNg=@vger.kernel.org, AJvYcCXKpWUga0aKcQD1D1c/EiJpa+wVOWuwkExFVBfj4QcIxOdFlJFW35Zz8XNklGof2XDiVSY6ekDVgvsqnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nistmV0VSC5uhdjJXGcCOj2LA6305lKYDlu+/luBuexHnu8b
	y9pCq+Mcjxam4gfBMtqHRfylcgqnC479O/fNv526GwQalgH/o3Go5Jp7cA==
X-Gm-Gg: ASbGncs2roEYX9SfTZl1h9QuU46qDiF65jNfI2ahF1XYoW00AQUXDJi3G+UDQfv3df2
	oA4iu7uYeYFC+8F2L8uDUOUk6oCWlvCckkZEEi6HoIm9GXDcOKxmvgsyvBKAxq1ETfNkSyDmjZx
	x3lttVa0EUzRdiBJKnddyI69Tdfm0evyVerVFt2R2N0dqCw1fPAfnpWUKTIwQC9BCHo/s9NehO5
	RtoKh37SkxQEt4FGbcVNIprCXUzfXHO5WSjufqVsxCIO0JC
X-Google-Smtp-Source: AGHT+IF51W1SEOzVa626MR/gy1PX4tY2BtLHGIUrRWAE7Hnfg+dcSSwsfktBrJRHgEF1cWc7tuaNzA==
X-Received: by 2002:a05:6402:4499:b0:5d0:e254:cbb3 with SMTP id 4fb4d7f45d1cf-5d10cb8023bmr6949842a12.27.1733343016450;
        Wed, 04 Dec 2024 12:10:16 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b7ce5584sm6266526a12.54.2024.12.04.12.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:10:15 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 04 Dec 2024 23:09:54 +0300
Subject: [PATCH v10 4/8] power: supply: max17042: add max77705 fuel gauge
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-starqltechn_integration_upstream-v10-4-7de85e48e562@gmail.com>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733343003; l=1475;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=B9Jbf+WbkiUfqaxn+TOcx+7YMUZN7KJwybjo44749ec=;
 b=g8H8TnLuVXQ9NCIPUC2xRw5dN8cEt0FvHDi/C/OJkexSVCF3pnGsSckTPoMN9LuMQ+DhUfHRk
 /8XLyHIkwDNA1bxXL46i9e5QiMJtLJAI0MGKb2Xs3ux0dL1qDljBzy1
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v10:
- keep alphabetical order
---
 drivers/power/supply/max17042_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 6a1bfc4a7b13..d52757e70eda 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1211,6 +1211,7 @@ static const struct of_device_id max17042_dt_match[] = {
 	{ .compatible = "maxim,max17047" },
 	{ .compatible = "maxim,max17050" },
 	{ .compatible = "maxim,max17055" },
+	{ .compatible = "maxim,max77705-battery" },
 	{ .compatible = "maxim,max77849-battery" },
 	{ },
 };
@@ -1222,6 +1223,7 @@ static const struct i2c_device_id max17042_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };
@@ -1232,6 +1234,7 @@ static const struct platform_device_id max17042_platform_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };

-- 
2.39.5


