Return-Path: <linux-pm+bounces-12330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BB9543FF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23EA1F24641
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD71494AC;
	Fri, 16 Aug 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbTbKBYd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B59148315;
	Fri, 16 Aug 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796377; cv=none; b=PYulz0fxtlqWGxrd97KYwYSUTtQXfmKPUO6NnCd07cjFsgkL+iwDQjnFpV18Z9xpljogtOAQOE2L6I2Ussk650YScv4q+bkWlQ7fgdz5mz4h3I7qeFWpGexp/GgfOOJ5S+fJy7bGMoCbazl8oiCrDprKIjaQ85pvbRivbT48aZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796377; c=relaxed/simple;
	bh=pjgYD11c54exrZ8m269TLJVT43T5YCmqEN99/6iD93k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcvxXtRti5jxlwedLqTEGayMfjbwoiFZMjtVsijF8aIjeSZQrHQ7QfVhozxdpC1MJ3t0ZxTkDjgEsdhc3C2i1rU41MoX5IBu2q5ld3HXeMX7XPOAUjXyT5shBPybzz2Db84DioeHbNYJ5YbkPztRd8Krztr51WscIUVoN3qbBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbTbKBYd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so6358225e9.2;
        Fri, 16 Aug 2024 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796374; x=1724401174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5udT0n/Uqzr1KlRUtr7rqEFm30NSV47i2ezdGcvvF4=;
        b=QbTbKBYdfIVuLTDi6H8pRjCAOzFVRnl8bZeX5ZVTXbszglTfyKq8NwGszf4ZCbAW1D
         AorjD8u7gOFJ7ZO0uDlBzjWLnIG6p7wlAMU/luk/qP/kgYXtpemrUJDIT9PLNPPfWsip
         jnsG6yvHKU97pY0ExxTnHunZEOprYJ5L/9vPzbnE3EJzB/719Jl9yMetd7fyvMTIzQVr
         amwmwOeG2TW1/E4WkmCSUtdTNwnnzh/hlUBdvhGFWyQoxFq0QJnIMB4QJg82km8I3nLF
         APZeomxaSlATxogM7JoZgzraQ7EmrCRSD2LaUJDenxZ8BeTW1OHuhzqRTqULanyTdEMO
         1hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796374; x=1724401174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5udT0n/Uqzr1KlRUtr7rqEFm30NSV47i2ezdGcvvF4=;
        b=d+NeicB8GXio2HRV2PpJkZis6Uo6TP1uIxuXlB+DakPg0bvMQ/KQlewe0bapDojv2X
         Rx69ulvVBnN1rW9z+qo2gq7+f4JoVrI7Fv9yqjT6n+q0PJ6UQ8MrYBzBZ8lo8cT7O5Zm
         DJOX8OIo7Fd82Bmq20g9BMnAmY4naFUOupFYTnWxGOVNcBLSFGfbk92+fIU0dRV8ZHCQ
         c+EeOA3od0ChVjwNsDY2YyIDpQMLr/HR47nv6I25DC51oP4aupeYKV+EWQIOytsw81Ki
         4Qzm1MOYwL69uIhpaX4tvBh+TzhTLzk+JlH9rPekymRBNj0xPDxipTrsQIl8d+Iah2fI
         cpsg==
X-Forwarded-Encrypted: i=1; AJvYcCXEb1VKAS8LU0yLufeVY+V1yEyIklO7moe8+eArNUHSCrjSrq1Je+AlYHQaQRnRYYKttfkzbrsDQ50hUkePCf7qk/Z8OWTy0tUASAKlEMWScHLdjIgE0Uix9zgrvh4QDjLDWWJxHm1aCLjY4fKzp3WIddY4Jgu5EuHLE1CQdJypnXmtIuySY4kq8Dz1LjN+VA/KyiE48wb30W3b/Jo2t3IWTclZlDg=
X-Gm-Message-State: AOJu0YzEV8v3qbitzuli+f2ufyMaObC3zJFeL9bpTFu7IJLFkiFiNa9n
	xIxt5AIdPoV8m1mhA87TrLLUcMtdpm36c7+wqvnFL36jamFLbHyx
X-Google-Smtp-Source: AGHT+IGVihTx7DF9CA3WeQUqGyrU1McVynpK1eOqsyz+lrrkdgotxkn0n0Eid0Zaq5twCQuOzduvxQ==
X-Received: by 2002:a05:600c:458b:b0:427:d8f2:550 with SMTP id 5b1f17b1804b1-429ed789223mr13392715e9.14.1723796374248;
        Fri, 16 Aug 2024 01:19:34 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:33 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:16 +0200
Subject: [PATCH v4 10/10] ARM: dts: samsung: exynos4212-tab3: Drop CHARGER
 regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-10-050a0a9bfea0@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=pjgYD11c54exrZ8m269TLJVT43T5YCmqEN99/6iD93k=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt/XPOgNOeA0/kB1uYI9Owyq0vvyqkI41oxe
 LuOWXtGQ/uJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfwAKCRCzu/ihE6BR
 aI5oD/4wqf4ZXhZPpaDYnhpxMAUxmWILeIu9ZpgVjitfkFDgQ6qFd2N4yrL+GzegGOji3q9wg5r
 TMSMARGd7Lx2L0MmQ6Eu0MsuJivZ7C6h9K944cpSRGqi57AtWiUksN/6bm8qVh/OCfPngFejQvf
 dCygLCx4kgcDw100dylqEcpgNeY7iGwvWWvZ73fhNnE+DjIZLN++V4TndNyTEluH2/i8kJ3tAkq
 h7js357Q1xVEXKBJhGCzlo/3moIgljMRUsT4vr/2Pj6ytZfeqP1wJp32o86UqRFDWSE4Qwn1bHK
 diMHHLEt8SnMGy6bROV5vkZ5pvym4DO/7DMBn/9as8AaVpQY32tsL2nKIaQ64dems/43fKoE0xo
 P9wclpE6gfy4Dyze2MFAOG6NvPf386mGx/zD09gZHSvUi7BqyCz8XA1/YAbqb8CcqPyLN6uJAgT
 27iYLa6bn8FhBGIxgivT7awnXLwEaDrwP7il/XV6P75cQW2fnlRVoStiw+4QMlZxi6QHVNVUViZ
 6k8OM6RxH3Eiu47JhFKbC0e0ujOq9zIJlR+LSBaSGCKaQEEnffsnIfepdKsMlWDTazrMZxVt73g
 lcfKktJ6Ps2o9CGHzjYIBBeeJ1zPRpSN6vTpYUE4UvB0AwbSzqPzqPnZqDlpvUZOfRSQRwxCOI+
 /1pO9F/k9CzpERg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

We don't use it for managing charging, and it interferes with the
extcon-based charging mode switching.

Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Added this commit
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index 7309b4e1cc3d..2006cdcf3909 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -148,13 +148,6 @@ esafeout1_reg: ESAFEOUT1 {
 				esafeout2_reg: ESAFEOUT2 {
 					regulator-name = "ESAFEOUT2";
 				};
-
-				charger_reg: CHARGER {
-					regulator-name = "CHARGER";
-					regulator-min-microamp = <60000>;
-					regulator-max-microamp = <2580000>;
-					regulator-boot-on;
-				};
 			};
 
 			muic {

-- 
2.46.0


