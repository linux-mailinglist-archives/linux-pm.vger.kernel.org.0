Return-Path: <linux-pm+bounces-18817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3659E9247
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148522814A3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD8A21E09A;
	Mon,  9 Dec 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsLJwvYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D221E080;
	Mon,  9 Dec 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743770; cv=none; b=eiawggeQtmsFdb9Skq2Red3ROeKTQUjEMPRGftx+zp5qPKItECKg7PGhPfidp1Dt6lER3ehlsJfahWS0cNWZLayh9Ryz1rXsWZYpCXPpOiWcygHLgE4UfTbd3II7lQtwdLa37DZV8xry9NvT9Rn9bMAfvCrbtx9ZhVebMtiAOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743770; c=relaxed/simple;
	bh=B9Jbf+WbkiUfqaxn+TOcx+7YMUZN7KJwybjo44749ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hy0Vpm14PJjX8MZ/paAhRWgVD08trYjTy7NT+OEpNg0CD2mlXMjvh2oOPYuqkn8fV96ytMG2NI2+9oHVDHdEHYsSqxwkbJq/E7qWUYQqUi/Ans0uRuPwyXOJgbI99Rs/Wd4hnVEMACLEkBh2NcMNB2VwwDmaOry5FhpXfg7SgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsLJwvYo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so2408801a12.3;
        Mon, 09 Dec 2024 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743767; x=1734348567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93Jf5nOyXsKVNvOE6Npmd8LTxOlqIpdv9VlXWGYeyOo=;
        b=AsLJwvYoFSsJoJUGuwgA+hnkiLymibc3IhrnUVO0RBHSPxb9bQwrlzfy10h7YKvw6L
         ve3MaYoYbbF1NPuVIzGjsUjWpiXX+x+0tNGw+aq79Cd+kNG/y957kiQTX+R7LrKEWftu
         XELHIXQwCGJVcSCzaPa1emL8h3ImNRx+5GPlheRH0fTSeq1GVYsMmwfmb4O1ebhGSLmB
         7VmeOtoLjgenOKpdJ9Cih9qwrGdgRZpx7lVHbLvCz75H7XoaOdCdTm7BMlw/sIAYWTR3
         LZ/pzj9bb7c+k8nLgAfAf/7Zal6Me+xXi5XYVKwQCqJHdhshF2+14qN/Kx3ZgbSKG1jG
         nGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743767; x=1734348567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93Jf5nOyXsKVNvOE6Npmd8LTxOlqIpdv9VlXWGYeyOo=;
        b=p+qLuyZ2OQPc/4jgB/Keyo/ubNw1nlgpIZPmkP7YeSJbOcKm+6+EEXO5uWB6WgvjU/
         2kIn5hhNTNq/Aflj/SR8Rj34BNZT0DJpFm2+9wdqwdXsdJBT2fCQLQN3KT0nxeKdalP8
         R70KX2ydqLevSrbNoUHckIpyFNov00DzqUb/zpTAZ04T5J5+Gwt8pByCBJHkrbol045O
         bV/bq3Q5Hz2J6zLuwW6ouwqk+d72xE543apf3lVYPLJv/DMdP8LDFZOwucRS0ShN4r2T
         nAcKMj7qv1bOO9hOWyrpUFp7oApKHtDNeHNhcjsDCeVpxHshVkNxE7N7vUjnXi6WbLuK
         9FPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+mr19LdQM8s4aDvLCifNDB3IqmIFL2jMRoWWaOYfLHM2vcDnPimaABLpUUT/aiD1FTLqvWCldrPhNRa0=@vger.kernel.org, AJvYcCUSH+obS+m94IXU2vc1P1lQOmjY7VXx2Yw3gY2Zt7KYooH5jl5h102iUWPztSdLlqf/eyVCYmTN5RaY@vger.kernel.org, AJvYcCUn43pAwNw92vfejLgA+S6iF/vmLrNaWzU6ynSBn8L8+UnrExT97oA7SJD+YUC+fckLz9SKYVp7480g+Q==@vger.kernel.org, AJvYcCWH9ygkjMYGB9F16m6bRMSseULEsXXiRFkqu9auirpZySXtYgZ+Lr4B7XHnSP72KA8plWdqkP/spoujEgAH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfad8IBOddAIJCUZlDLuAFKmUS7UYzGOzDXdnxuLgGctE2pkNl
	7jzSpdPmUXMCsF+1H8JRW0QO4HlziyNjnUY2SkmoCmfRX6DFHvVMRcdEYJoU
X-Gm-Gg: ASbGnctzrArq1AiGSrJZsIy9W7iDSSasr2IPfICbqTm6lEPh/1p9OLRu4/7T6vhrhhr
	gPS8P/F4/dCKukO+91VRbhy25FLYIXzGpqQrOuMkEbp+1NZr6lqWVVqzuv4eP8up7g7OVte8urV
	zPQnWgaMppjXAEN3SnxjY1npGaj6j/xZuFt7eL8IxXILsj3aw9nvChtIgEqFxjHYTHKfMYIL0+5
	2KKKs8+hklmGmuq7rBuyGXlhCK43IVHKZQjKTlfonUtfB+R
X-Google-Smtp-Source: AGHT+IGlNJ4iK26DG1tYcNZtRm473HIjKWV9GLKFxYf1JOW25imu8t/AkG3YEm59TGatSswfM0IYsQ==
X-Received: by 2002:aa7:d3c8:0:b0:5d3:cd5b:64a9 with SMTP id 4fb4d7f45d1cf-5d3cd5b656dmr8927328a12.34.1733743766889;
        Mon, 09 Dec 2024 03:29:26 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:26 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:29 +0300
Subject: [PATCH v11 5/9] power: supply: max17042: add max77705 fuel gauge
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-5-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=1475;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=B9Jbf+WbkiUfqaxn+TOcx+7YMUZN7KJwybjo44749ec=;
 b=qTvYP6gEi0pAQhJ8MoVJ4Rd3PYyFLHDblDXQxCl/oboj2gSqUTCSdAeobCDTM9ldgzBPpj/pr
 JY46ChZC18cC87J1SRd0numIbA91kJ7e/XJpxB+CVpmwdWfeomzmki/
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


