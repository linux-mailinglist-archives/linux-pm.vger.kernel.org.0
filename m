Return-Path: <linux-pm+bounces-19688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFD9FAF18
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4AB1885A55
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9E1B2196;
	Mon, 23 Dec 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONpLbVqG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02051B0F11;
	Mon, 23 Dec 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962400; cv=none; b=oGZMqF/3V2QX7DO+GBrLK38ZmF3sZkQ2p6KyMdChGDKeSbNMLTbbVebnk4bFIHn9LG5XRt0tuWEg8tM8kCzXxkg0WmFtX/lIODsqIdafKMoUVNrNS3jLcS0b2lOSgqyfIB50/DQW/P/MYbNvZ3ZtWXS8xywer2KW//sn+iufipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962400; c=relaxed/simple;
	bh=uK2VytpAhIaw1vGXP3QtafCIlq4zr6S/aIWCWDyWjKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dd29PJo2scFTb2DwEPY47ugxtDZrnjuZaYsEHgt+aXiPsync1b/tIeKeE1fW1OnqBTyrIHjC093QKHhmk2axwhpFtqIjOwr4tEgzM3QZH2P4wWeAr/hYpra9FpI+rWh14fOTUHVAsbaj7GnQknmn3WcCvXN/P0lkaAtVgV2cpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONpLbVqG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so887022a12.3;
        Mon, 23 Dec 2024 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962397; x=1735567197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2aKeZ7sTU4LK+Isj7RaoM/yVOdhmMcPqm/rlVkOhUE=;
        b=ONpLbVqGXHNQq1JlXKNpi7lkmJTrhDkvZwHITwgiQXKIYCycKFgrE+NEzxPJObQOFL
         WPOAE8L4oE5rO/slkhnZ84DXaBCaM4+abjGgX7LPy20kKxpDZFnZ3vCFBurkNCe2od4D
         cT8ufPxccoDJCYButgelu7wX3Nl8FmkHKPfyTZcfi0J832peWhY00XqN4ILI7dt7Hs0D
         meKxUl0ZsdfiYG6dyEbb1I5ULHcsEiuDvvqUE7epCon9nX+6LPRCzbyIqydfGuEa/B9o
         AVLEZCrkNmKP0me/g6bAWYqImJdYxAtHORnT4sHhQfC8g/orSHpJHQZVuM0MVNUGAwIj
         k+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962397; x=1735567197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2aKeZ7sTU4LK+Isj7RaoM/yVOdhmMcPqm/rlVkOhUE=;
        b=WUzh7BhzciiuhQO4fi7vCRr4F6DhcgFMWCA+YOnp/o6TIahKrx0GT1ubmd8D5oRikt
         HRW+NEV4SnV4aXu64kPE9IAGS9yz1rWOrZWeXusjRaH8pjbxVpaFHr0dHgdo+NMdU8Yz
         R9eQO9ntKYP9MGHf6SNHoZswTOM/asWl+kNIy5qkCwPNtHUQWPvsp5ccCB3tjoRLb5pi
         JILma+QC4b3KaGmckFtrWV7kpnFdlXkH1gH5DphVlR9tSAqilpbo6LHRbzmNlnB4zjO3
         u/QAsggITzEzWBGg4zU5y9Tu0xMptetBXg9IQkUfwHyQzdjllvfY1nfn+LAmXTgFI/jc
         sCVg==
X-Forwarded-Encrypted: i=1; AJvYcCUGMNs5d/YzCvuJnjsvVWNpdQ6s0+ZTBMkrdQjatnlI1ArASpFYewQbp9wJEQVC8sKOKq8BTE+q/9l/Ow==@vger.kernel.org, AJvYcCUOFesFii4U7lfCC1lMwct0otH7JbmwOt0F+i5QHSzCSSoy1QuCYgQt7/NoACoSiJQkGFYHmFi9/UUr@vger.kernel.org, AJvYcCWZZKqDCNEnPCbZRUzAt93pDN9Ev1V7gmik5iWz/k63cdmHAjD6JHqKVEBy7Qgq5G/tsqICceIEepgAchM=@vger.kernel.org, AJvYcCX9iBdWizQtZ74Tk+G/z69CimwgmqMGCFvfDeK/O21OOZYkSG5FqTLj2aLQ/QQRIPp1ohmwx35ZGBUhsdqQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1129s3GAijhnEGq/sY6bUMpEZpVQb2oOoWYb2GgrIOMlpqWM
	e02YXLKA2CnViC7c57eJLAfAXm2v+SzXU9s8hRgL4TCIpRR4h2jiuDjYrw==
X-Gm-Gg: ASbGncvG2oJm0mQIcRrVvMA2m0ptXp5oOP6KOvp/46SLrdSdkPojfMfZcKYM4XSHkAL
	qtsnFIfZMLiJRcj51Xl87EEetP4Dn6YnzI0tOkMhzLHK6i2NtqVaSV455SrHgvatowlLZXylbBv
	YjtfRB6tDXGLm58/19FzubSh0RJncuDjUuK8F1kZmePDXtg7ZjZbuw3QRk8l3HXgmQ5yJbAgJHL
	WsoPZiMtlSHgEAB8/48009oSaRiqLCvsfgS8A+IjV/Bd3oTugNxAaj8dqPeMTNFIb9wbcBfYvde
	OP68neDYFuSHo6gUek4tWUJTtQ==
X-Google-Smtp-Source: AGHT+IHTfmT3ii1i2dJgNpjE2IqZYfi+fJgTM2xXw0SQlEkYnt2ovxRwwJDnN/nyJ9K9i3e6FVU9kQ==
X-Received: by 2002:a05:6402:3589:b0:5d0:eb2d:db97 with SMTP id 4fb4d7f45d1cf-5d81ddf7fccmr10377640a12.25.1734962396804;
        Mon, 23 Dec 2024 05:59:56 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:59:55 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:39 +0300
Subject: [PATCH v13 02/10] dt-bindings: power: supply: max17042: add
 max77705 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-2-fbc610c70832@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=795;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=uK2VytpAhIaw1vGXP3QtafCIlq4zr6S/aIWCWDyWjKo=;
 b=ugl74q59mV/wQrBKKqtejK6GTmpABtafWcPMnX1gkwiqYcdAjMVQzi3p6Lpbbvyl2YwWMS3zR
 RMb2jvgor7dChZGG794P3CVh0mqsdxSrExup5LxvzKQi4yBYqORd8pa
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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


