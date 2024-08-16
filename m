Return-Path: <linux-pm+bounces-12322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349319543D6
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF3FB23771
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C013B58F;
	Fri, 16 Aug 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA8rz0S6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5513A276;
	Fri, 16 Aug 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796360; cv=none; b=s2oiC07xXRFsQp7YogQjNlMqsSJPqOT7Jxs7AhZYp3bvY6wZ9Ml8QRjmTfHbFoYVWefNBfGO3QUNQjBviK5SeTWOBxWhRMt8bOdHcCuUF/CBbHgPgJZdMahIMd4lXdAy7BJSbMiM2s2YTXMMA/xGXuOyac5VQpVo81j+nG84S4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796360; c=relaxed/simple;
	bh=oLtK+rl/xh8MKLhG48HPNKV+158PkAGnfAvRTrZidfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiE/2cf/fHxoqksTR2JFX8mkvFaRRLNjG0UPBCFUdazsDtVPtReKedWPkTrZdHYc2E42KBQzGInjPZ2VDsaDkyQ+22rP8hXqtkeB0u5kwxCVqGazSQQeqOL4dr6RqRGW3VxME/a+l2++FBAKL6mbn7PdaTc4AkZcAVR/cFMf+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA8rz0S6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42819654737so11597205e9.1;
        Fri, 16 Aug 2024 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796357; x=1724401157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5GGelLjYWwSvPbwd1YOlnT/u3Ig9vn8D+D3f7YMN/w=;
        b=lA8rz0S6cUQxWCtQD8hEfC65g3/p8Osz2Qd7wpU/mSNdNVn7AujdO6h4Dkp7cdlS8n
         aULWwhKpwKNP/N2eUeAOfXQvmezo5J1twyyCw1+PxBr+4ZPFoTTGqjhJBsjtJJjNgd4H
         iqwOGIS0TFuv1S9gxS9plreGBF5plNkpbjk1AXxKKSRy4h02Y7MNMhNBBUXlJaY7WDL2
         LmsvnJJ5cIk4cUk0tQRZ0EyCF/fmQXw+Nz6te/SA952+kP2erbEWEtlxqMxasF8un+YO
         /G+wSY5HrL/O1ldCjW/LKoI0eBaxJP9cFoEVbFbWJD9qmU56H1Jd6RB9gzFeKepXmzOS
         0UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796357; x=1724401157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5GGelLjYWwSvPbwd1YOlnT/u3Ig9vn8D+D3f7YMN/w=;
        b=I2oxzjpo8R/TpwcqlGkIQhYY9qlgvZ719sMlJye2A8lRfY8IucS46K6VW1h/lSkOkv
         Spl7pa9q2mS6kM2PQvX3QZixbM+KvnIHTQNiX1z4gHOdlXSv9R2d1m5wEJHFCHEBy75B
         4VBoW91/z4cIS/p18cSJhfPVpwC0j/Eqqwi6/KbEgmF7ckSyyggyk9khVoAPtOfSDVTd
         uD0J6UDqxrYyyhy1lgnwM22JUxFXWoy2O1A5uNAA9nyzRJJ61RE/BzKHJ4Lmt46UtGyj
         khnDwWaU/Al99dXp0LRWlGMK+5HJeqF2QAgnKHr/VyOM1OZK6rdVruEsW1Ie61eLgMGQ
         PuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGeeqUyc+dzqF5WeLVhHCNPPngzvH6R8I1BWIbH9y8UpNOjGzg3QNBlZHt0h1ELC9Wz7EKMbtlQm5LMzfKZRDP9wlddJ+eB5bZx11SB+NSgbai6Njdy9w5metzMKTwBxFG8IHuR0UE03vcwPC0V6G0IvkJbtmjcGxXJIv5QqyUgvKI1teC3jaJ49qbr5/9oEuLnPzuYDlPHQcWfrR0X4Y6yUjRU/Q=
X-Gm-Message-State: AOJu0YxJqbub2GjoqGlBXBnMfQk5PW7UyjcRqEO5RVTGCtoPXjoUfQGz
	zqdgVCf5Gc+WanLXfN0hxKArXuD4KSrd8ecLAPoEz9DxRI3QInVO
X-Google-Smtp-Source: AGHT+IG+Uz/T5oTdVQui1Mq2wyi/zZtWBpLViG8h7lZW49iHDcyaQtP7H3xLp1xh2IZsa0WBRX1u7A==
X-Received: by 2002:a05:600c:470a:b0:428:3b5:816b with SMTP id 5b1f17b1804b1-429ed785f71mr11868585e9.3.1723796357298;
        Fri, 16 Aug 2024 01:19:17 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:16 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:08 +0200
Subject: [PATCH v4 02/10] dt-bindings: power: supply: max77693: Add
 maxim,usb-connector property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-2-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=oLtK+rl/xh8MKLhG48HPNKV+158PkAGnfAvRTrZidfU=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt9+Ha/AoAqXfYc3dWFaQW09z6DS7oTYtY3C
 y7Bk1Eh+/GJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfQAKCRCzu/ihE6BR
 aLbGD/9ytkW76lJ1Y7PNFfIEcx6RH2wKgUqiNbsDfsbHinrY/kozgUOSEKfCTr+HZ9BWSsS+H8s
 tavLYd+CwYoof3p64J90xQI9+XCWJ1sX3ICvkjtxIRP1mJfDa+hWZ9eyIGUuNHRoGOKiF2eWBva
 DLzkqq8HbQX3p8oGjAMKiHpKMAjvAzyVaxgppnmrKcgJCW25A2JEC4Fzmo2qtPpwBd6I4Nl3sqr
 dud6O+x8QqifYgQo2OmROqAalbg9nBT2m66uyhqWJgnhKiWeWeh7SI/+xHNxpRHDWo8XyuQNVnD
 bRJ7vK4otQmVmer807sptQVk34GFzzi5DiMdeeyr3K1OlvZ4RpFjCj31/V+/eEBm6/+PHwcGfsY
 c4ilvB7SSHr2Fah/unnXj0g0gdq0GcAPRF/qM4ph1qNyn0dDpLZ93O98CzUzUSNBOOgt0Vn8wRW
 3Dy3rscTo6cjoNXkYqQnFB/BvCSIdXyVeHRZ0PgeJ8wid3AZwH2ueClPInXcRvKlGSiF3bdHWeT
 1aILGfsrr2Oxnso3aACavX8q+mpnwZfepOWFVmGHm6/NYFzzrjRSZIzyLizm46n68aMPHkbOjUE
 S6hLSwYhdIG1XhcVaKITS3rJaM2f3s3YZmLTSifS4zQdZDkaEh2cz8xMwyB0Vjdze3pWr0zU9kR
 otFxrpN+LOjxwcw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Allow for specifying a USB connector to use for charger type/OTG cable
detection.

The way this is done is inspired by the rt5033-charger implementation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index 2f4437dafdc0..b70c171bd4b9 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -73,6 +73,12 @@ properties:
     enum: [4300000, 4700000, 4800000, 4900000]
     default: 4300000
 
+  maxim,usb-connector:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      USB connector to use for charger type/OTG cable detection. Phandle
+      to a USB connector according to usb-connector.yaml.
+
 required:
   - compatible
 

-- 
2.46.0


