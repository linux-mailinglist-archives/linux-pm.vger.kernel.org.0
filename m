Return-Path: <linux-pm+bounces-19384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD49F5405
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF83C1891C2A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7471F9AA6;
	Tue, 17 Dec 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTE8IGJD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F81F9409;
	Tue, 17 Dec 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456645; cv=none; b=jX2Q2oFLoC4TB5fggu7QO3nUzvTKgUH7qosvL/K3iwmkyWmLFMpB3XP89P0g0irxaNKcb580GI9uNiyQnH8RJlpU2HCYhg2mkOW/lTdvBDPHrl8lgfOguGorr5J7waiEfsYNY3JZ/39Yvhr+/a1GwrTcSGRx4Z6Bkvgq/pmkv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456645; c=relaxed/simple;
	bh=ov88MZvaoV/gsvJQTFMLzJ21tbwH+Yq0QbAua0kHSkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bir6l7mbV2MHQQBXSAw+yRuDPXfxLGYTPSfHL9T6cYndzb7fyqBuhSs1uoWY/0sH/YBDB9Gh5pAvjqIifAGvKy24sAWiPbVBY3H9IOzHwFLGiU+cR22uppZhhJP3r3QYT1VaAgQf232V7JdC8cqR5TMy+awyWlC/Icri8Htavzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTE8IGJD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa692211331so1039877166b.1;
        Tue, 17 Dec 2024 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456642; x=1735061442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL0NB4wZEOA9rq/xLXkLm9tFDuVeVMes+GSNBIWRSr4=;
        b=LTE8IGJDPobQ4VRuMszeu2hqMEX9BEXIwuzLGeRdnBD1lBWn+WqbtSV+igORQ36kiJ
         mmu3kGGbnVPGOm2QAL4OCojLQzW2pBMZoRRBJloaQ8gI7j2ij2O65jQnO7hWDVkdoMei
         0RYqDxvsZapoS0DQdLExQkFE99SsHtcObo2rrtPkNgjVhsIthPZXFzR2eFcjh8F6oA0L
         HkhETa3MZWO4O60x505jhwp457N46aO69o0M0Aqoo+Y3k62OZ5KFLAB5I4G8F6KlfNfJ
         xFb7E3jukdX6DJvI+K1vXWCWgtLF7u69dl+EazphkwGcY2YlZY7g7EnccCHAZm+pSLmh
         gdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456642; x=1735061442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL0NB4wZEOA9rq/xLXkLm9tFDuVeVMes+GSNBIWRSr4=;
        b=V7ILn7/tFxN/R/lQVR23DWDB0X3eKRkXhT2ztIfNXsCdz/mjImMOieZ1x19u2q1a9Z
         E/diLUpE44aqFYsBg8vEvrMbsy4T2bjb5bbdm0sCMnGteLzDH7WW/DiYpHal+H6wIHG5
         MJKBDcBCza+a+joC8AZvLvUHvns7w2NzjlOpxYUeAapbV+lsvcHyJGBDV208ccu0ewdH
         MbpR1DPlIwLfKb/jSBJeprh4vzzjF9lTpMcqxQuTzHn5R6OowjaZGkxqj/btN5aszZ7R
         /fKzMuDYWQNzCXF66g53G33iD/arjryeFMrLFkFvhkETly/z30ze1xsNqx7HyedbHGuT
         AAbg==
X-Forwarded-Encrypted: i=1; AJvYcCVG2Nss89IoxNRiQ5eO45ABKhXYNGCUPS2tzUEPKXHJKWlbREmshFWtYn1xLHc9+T2/sWs0nr0ZW0fHzsVT@vger.kernel.org, AJvYcCVYNOVY4jrJQMF8BlCfZwcwvi6fiuklWWbJLCTx3wKVQXcMXR2e4I3I2QInMdkwUyrkHTMHSaPXU8yJ@vger.kernel.org, AJvYcCWgQhl5l+W8e/4hvDFrdoY7wj6RtrBk8wvPJhBKV1DTKsL0xBlaIzOFBrsXXN+7PCOkf/9T7MaR62oUiQ==@vger.kernel.org, AJvYcCX5bbcC83lpbJStP9RPJ1davZq4SngF/EEuQ5DoZ5NnoiupyTR++KY7Wey/SQmMUEAG6eogDdeTrON9AT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22LiLjn+mjdIIQ2GjPLLkLm5Z8i1tHMayhiEU7MR52p3uGazP
	QREtjsXwYogoaxvz5+HviRPlyZ4KEIAQNSUIBUJYi4VvDl3h2mqL
X-Gm-Gg: ASbGncuIReuHJUnsOWAPn8KgrbxEdr7DW9iJEb0Yw3k8Fn9Jy/zY3JQjd9Q6JEz6Jt1
	Gmy5RiBZVoL2FkoURxqvc/WqWap9sn+g+KnalfPOp+Xm5RJUQCDZl7KuXfvPa7SYe4hzqFAoIpN
	+k2argLu/SxppPx2pN6FcwzWXO6uqN+aFq7AWb48YIsDxLki07lKN0hWLIuoUfprgPQiwoNYSzt
	BBie8K2NXkABfyJuHVuEbgYNDqB4/mCiB/+1ucn7c1FvyYOTCPcjXw=
X-Google-Smtp-Source: AGHT+IEtHTtnPcyrOy04wnZ4nQ2TcNi89mpKpHr0ALzOfO/hQ7Cw7ZfU+4vHa/HDAKoQUWhCvctoLg==
X-Received: by 2002:a17:906:32d9:b0:aa6:79c0:d8ce with SMTP id a640c23a62f3a-aabdc8815b8mr359015466b.1.1734456641773;
        Tue, 17 Dec 2024 09:30:41 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:41 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:04 +0300
Subject: [PATCH v12 06/11] power: supply: max17042: add max77705 fuel gauge
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-6-ed840944f948@gmail.com>
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
 bh=ov88MZvaoV/gsvJQTFMLzJ21tbwH+Yq0QbAua0kHSkY=;
 b=0+R8VqdXHH5BDKIxbGZ1rR+AbmiM4f5fColan0su7Tb8PoYmIyTe4o6MdkgCFrqC66LOA6RKz
 sQK6pkyEtUCBVwrs1eypTudcUz+4rnMvbB8wVgPaBNcvNf+3rP5uehU
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
index 9424c1c108e3..a254967eef1b 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1233,6 +1233,8 @@ static const struct of_device_id max17042_dt_match[] __used = {
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17050 },
 	{ .compatible = "maxim,max17055",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17055 },
+	{ .compatible = "maxim,max77705-battery",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ .compatible = "maxim,max77849-battery",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ },
@@ -1255,6 +1257,7 @@ static const struct platform_device_id max17042_platform_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };

-- 
2.39.5


