Return-Path: <linux-pm+bounces-18328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0B9DFDA9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F1DB24508
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA51FCD14;
	Mon,  2 Dec 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw57USkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39821FC7DB;
	Mon,  2 Dec 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132894; cv=none; b=ozbC0YfEp93tQ3fo/VUS8a9TpbJtdEB3SbP0ui8+wlSxWDudOgLREpXMZ4WuOfpRLPeYZnTrXSulKYSa7KeB7BsQLt9WMOcBkzreU1OlVtoR3WE/SQjCqgdylbApK0veHDOVyduSe6MPu0kkQaOlN9cDYtbIfYzfwzk09bDoUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132894; c=relaxed/simple;
	bh=25GZxtAq4n+C/Yvdz0amIVqfYjK/Qv0YaoQj/wQrB3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pG+oFLV7C8mTWaAcLXWUnpQSPsOzHFOUn47q/LQF9MJoDJ9xx/C2BsACh8Y2DgShzVlY2ejLzJL3TS9JyMuFtxLa2fAwnsqFH5zIsMq3alw5JjDmFqUD06ooAj5sTFYeVnSIwgw8vrmB8WIEVrG4vv6pX2ntA3Ve1q3T2gpY4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw57USkM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so651685166b.2;
        Mon, 02 Dec 2024 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132891; x=1733737691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM6JAaZkYYk1PpNLi9iq+4RSHcDTGuGEA6QqhqV5EhM=;
        b=mw57USkMcaNlV/qYKC4GnrciwSS8lVK8AC1WjR82XOVeabyq3/TbWj12ivk2PDqJSe
         ZoPOCR+znX+JUzKadtQDV6NNqbklA2pmw1+4foCvus2fi/nfGpEtnArHSG+Szw1QTSx4
         oGiQ17p7iNA9s78BoM/9tt+TZtaI6Bh0ChSiy+e9agQUvrpd4OSmqN+Bj4DKSXAQBxaC
         2ffDD3o2H9gppcz0m5Exc6bNduta6Kg7POqBinXR1mRBvCJlkNoSv4N3RUWEw5bTGasz
         8mX0sS0IFvwlCrHpmMCkOEQrUecBiCtT9k9p+Hkf45Q73VDlLiOki0whe8fx+d62NeAW
         Kx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132891; x=1733737691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM6JAaZkYYk1PpNLi9iq+4RSHcDTGuGEA6QqhqV5EhM=;
        b=QeG5b66FtaEQ4TNof/WQOVA7AuXrCL3JzqQs3SjcyNDef+ePqZzQ+tusM/hJ5VKZZ6
         r7kMvt65C+EjNWnRn0IgXYkzjIwhQiJEbmsYGogmcAurwfUHSK7fcDfLZ86yG8on24E7
         DB6zb+QOGYaWed2UtplYLepOdlFnDkmE55Xzi9dUnCCq8HUAJWMXebffDywLs9Nmtq0l
         rxRvTR+DEkjdb1AkHmnJLKSPXNQysc0Ot+MBih5jFkH19EFIIXMYO0odXOFQIBqyZnlL
         ozM/m+afcWB1S2GSuC5Rohaz19zy0pPB1Cq+a+QMa87pid15v6fLFFJ6uK0c20gTrR7T
         IUYA==
X-Forwarded-Encrypted: i=1; AJvYcCUmInYHoKWdpc0mK3ObWNr50fOh3MY26UQ0emMhpiexpIImt2ZodoTRd5CKvhrByLPKD3Tvbc6Q2qO0@vger.kernel.org, AJvYcCVh3SmVqTEkgVyYgSnKSFYg1loVsb6G6fFEcXAvOnLzfH0XLSqL1tfbYJcosZhvWPAXB4tqZxgvlV/8nw==@vger.kernel.org, AJvYcCWXTOoW70agjWz5LLbA6m1QkQvbO8OvDC7MDEEJtt6JoqlKAuHxs++IUs4bt3JCBQXxpdpt2fi4f+ztcDg=@vger.kernel.org, AJvYcCXaw/iblLsoeSUuf7L4frEg1O0Y8fCPEfshl55ddkH1+X7BIhTLQZkEvZtbLoB/2SYy2fBmE++i9zBWz3AU@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBeMma1I5Hy6OJGOZjsrhX9saeqZMhsw58xLVkAqkzWPyGHqZ
	WkM4a5bQH0LyEhdOZ9jnXB1ygD90IDTorGbrb59eyYcgwMIgJfy4Io2zEfkp
X-Gm-Gg: ASbGncsL7Zl84xMTqUVrNUJGDXfTAfiZ5coAGBlNY4/I4FNCI7Ei/6cyCqX7O2ldJrR
	Kjt0oGfhbMw6wWsziOVMyf4o8iSycGeLsn3qQJVI77k42HbnBMMXVg4XW0vXc+UCTcBk3S4KGD6
	4yhA0pYR4RsPbydz1bPx9IGidBwxQTCS4o6kkDdG8mP7x+5rbWYbfgGLaiuOWIr0SDJDhLC7S2r
	AwfWS9e24nl0jM7P/LrvV95/2R260gEh/yHT4fYsiqd6txX
X-Google-Smtp-Source: AGHT+IGZG0fKD+yecn7TPHhSyNdq+I6v94rfB+0umVt5hkPNqC01neYZfSHTADkYcURer0+3iaEd1Q==
X-Received: by 2002:a17:906:2192:b0:aa5:e01:1471 with SMTP id a640c23a62f3a-aa5810330a4mr1467684366b.37.1733132890902;
        Mon, 02 Dec 2024 01:48:10 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:10 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:47:58 +0300
Subject: [PATCH v9 5/9] power: supply: max17042: add max77705 fuel gauge
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-5-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=1433;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=25GZxtAq4n+C/Yvdz0amIVqfYjK/Qv0YaoQj/wQrB3U=;
 b=PueYmnRPpCnczN6ZC/RImFFhEvkjdRxVjh3yCfa/ugTnJjpN8JVKk48XSnrGYrPNo6Jy1Itts
 ArL1IwTZDkfC1iTTsdvWNPmEeJze9UyaF4wBNhrv13x7I+UXt5RhGu/
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 6a1bfc4a7b13..8623c89ad274 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1212,6 +1212,7 @@ static const struct of_device_id max17042_dt_match[] = {
 	{ .compatible = "maxim,max17050" },
 	{ .compatible = "maxim,max17055" },
 	{ .compatible = "maxim,max77849-battery" },
+	{ .compatible = "maxim,max77705-battery" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, max17042_dt_match);
@@ -1223,6 +1224,7 @@ static const struct i2c_device_id max17042_id[] = {
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
@@ -1233,6 +1235,7 @@ static const struct platform_device_id max17042_platform_id[] = {
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, max17042_platform_id);

-- 
2.39.5


