Return-Path: <linux-pm+bounces-20092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E74A05E35
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123CF1640AB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060831FDE2E;
	Wed,  8 Jan 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZviKUWDl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284A1FCFF5;
	Wed,  8 Jan 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345655; cv=none; b=nyoalskF/+9+PhGQv8DphnKtUPRtu1u6t2/ixj+GMmXLXqoDjb3ESciUkgOcmQiUeVL8obrT88uUvi1qBjjmE4HPposNZ6t0Xl7re4LOTFuCopF53CM1RgidukWDNFbE786Jg+bW9Lhrgkur7sTcJb/c5+Y2prSZXG0KJiVomwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345655; c=relaxed/simple;
	bh=LRRZ1LF62sUfrrQaRQZQnd6FxEzB6hrrJNyuB8N+gNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkGSD0upc7MpAaz7K2lGWxubbeKmSwefEArblnF6fh8XWjMB9fzQm0PyyphV1h5Vr8bgIOFR4MVkK26/TIDCjbZcK0ZdheJLildoHaOHE7bvRKtL3+nmHhWOSjncyWjRpHK6aJBEeiXp/nx5yDdHvqESozv+xwcVLVr+9mVSZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZviKUWDl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so24986170a12.1;
        Wed, 08 Jan 2025 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345646; x=1736950446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyujKwEsNfDHScoNav6ae3GjHsN1+8L3jPXCGfk2bqY=;
        b=ZviKUWDlvHWzJC59FxpYs9kn0BGIPn+4v9AoasN2jzoTEo5v0BPC7gEFsr0Llb5Zf3
         2PzT9XHS+nxFC8if6N74+XLnPMeiTOtEa4WSrly8Ab7fm2HNWSLv5sEHf5azDCcowPrT
         4ykuov4VV6uupRKpQSYYqFByh/B5fQ+PtwO/1zFFMug5DUu5Uc9tug0ldEI/emDwj3Q+
         dK47z20R9ZA0eXb8wINbJKUxTEkJt9OntwZX0W5y2/Hc8TANsuimFmfekFvKZEkq0t/Z
         qhKhSIdQK/NkOkgfBFnfFdQ/p6yftb5rbo0CnEh9SHqgfP+cZyiPZCcGTPQDVahIwG0E
         8KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345646; x=1736950446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyujKwEsNfDHScoNav6ae3GjHsN1+8L3jPXCGfk2bqY=;
        b=qQAzIQNIMly/4Vft/BR6tRmFTypsnglhfRbl7Sdi7oV034tnCD98x20guNYM5yHhCT
         Roks0+vB9d5BX8rpEGkVK7xWy3xnp2hml+ZbEEeS0oYL/tU230hSzypANo7pBsNWXFi2
         4drFH/3AMLGufd3dh4Ldd8yVr2uoqf7Nkaq0aw9lSNuE2pPE+Q/BjWBxhpj7b86OehMR
         e4Ud6k+AptylIe3B9a7mjTsUgXdiXAzC/vOS57UAim6JDkorfYk+29wXeHkldhdzJD3V
         CjpEAfO+8AY1wkdofc4no84+Z91g7ms0DIVSHMTcifVFMXBnBMpo22/6sN7Xei5tfYBS
         CYfg==
X-Forwarded-Encrypted: i=1; AJvYcCW9el4xVyT0XWE/0Ss3ytBDWwXfj87LNOaG+dbkbSYu1kKTIqmdNkKLjS8+YTDKOUgAUl5V1PkObmr02A==@vger.kernel.org, AJvYcCWRoV+t+zqfPF+bnySQPisdcW3CLMKnPuJ2v2jUAxA5ZrBfJ4f7uGleHjxo7eD3Kq06ObuX94fmDt7e5GU=@vger.kernel.org, AJvYcCXg7NHCnBWi+p1JlpLcDJ4cf9L8iVeAQyt/k3OYlJXaBjTbMigzi7yIwcDoefRGhNfHgZc234uOyHIZ@vger.kernel.org, AJvYcCXlpXYgTQc4f81WAWaEMqLfgvhxMJWUOg04BaF9Jrt7oasVh3NmsH4y5BM4X1Uiveo62j0+5Cdq9+TYAg/c@vger.kernel.org
X-Gm-Message-State: AOJu0YwEL5Dd/7VJzvZYJ8rKOounYX0+pY+B8l89Lr+0u807MRjOdgqU
	R69DKqMWRVUL5G20Rd/NVIA8FCZ4dHESU6wM25C/MrgXH1JkvRM+
X-Gm-Gg: ASbGncuCAFHqT3EAZyPWrJd8tLi+TB9GkPLqIjq0A9rHjVyyDmhtgxGTOYO2gM5R5D0
	zXZ4M9lIGm1sQTIjbqiubed0sFtW8JQysFpJ1hrG0/CfdatUrD7Th3diz1Yxofma1EZd3IOPUgL
	zRB8OP0kF1qCMg92SsaqjNHtZTExQDhLZRTyegZOlm8PyafDa4Up7AEd4MLjSx7UuYTj5y0yUU+
	cPoRa3iJpXd/G5LOpfvu+5gvjwBH0VFsNfYn+vJqsH0fV7IBCc5JjQJfXx3WaN2cLR7AzjAYtYg
	9lpbiukCVJamqcqE5+9c8DH8sg==
X-Google-Smtp-Source: AGHT+IGVM5pD1YcoKYnzP654hghnKgGHGlW/glRlDkDsJcU4SselCB7M3z74Cs4SO4Tf4FrZNUuH5g==
X-Received: by 2002:a05:6402:35ca:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d972e0b954mr6919492a12.11.1736345645944;
        Wed, 08 Jan 2025 06:14:05 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:05 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:46 +0300
Subject: [PATCH v14 02/10] dt-bindings: power: supply: max17042: add
 max77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-2-f6e84ec20d96@gmail.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=906;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=LRRZ1LF62sUfrrQaRQZQnd6FxEzB6hrrJNyuB8N+gNI=;
 b=nlwz+W7BOSRQcqzk0vd9qZ7XPsoXHIGVqTz9Q48a7M/o8VyxKMa1YFk7CmcGpYA0OY0NO/Dfh
 PiWDngZDtUrDWJkqRMjJso2wSlVx2FfA/5GV/MBDqdlpMdOyZS2K9q9
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v14:
- add reviewed trailers

Changes in v10:
- keep alphabetical order
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 085e2504d0dc..14242de7fc08 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -19,6 +19,7 @@ properties:
       - maxim,max17047
       - maxim,max17050
       - maxim,max17055
+      - maxim,max77705-battery
       - maxim,max77849-battery
 
   reg:

-- 
2.39.5


