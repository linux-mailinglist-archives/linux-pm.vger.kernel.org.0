Return-Path: <linux-pm+bounces-14223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C7978DB6
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFBD1C226FA
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9AE770FB;
	Sat, 14 Sep 2024 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgN+rsOX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B714F132;
	Sat, 14 Sep 2024 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291549; cv=none; b=tsCjb+E38yTT15Z0KXn8etl1t49CHTGIKnPq6IC+3rWo01w2SgQiXfvEs0ZQgFQt9tjtIW0LryZk1m13MoIWXoOqG4NF1xXyXN8DA8d3LNkSd1bB8gBcXSRFndW3nu1hwCclLC6PwP/FMcNNPh98vDPOXztqT2imN1LA38XB4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291549; c=relaxed/simple;
	bh=zpZe6xZCfSGF7rqzh/aDNFZKpuhqDtvGqPzTaqzxLlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vk6xM0Cc5VUM2u2cx6jreahZC6GxrK236a7svNrnJFAcomImaAY6xMqEBQR6PDQ2Dqch9t1/Sk+0kdaehPWoI82NUV42EoAhFBdLGjw1LX8b7SOm09W2gCg5jKlDzW8YgBV7bFMs8GNl201mIPMDqTZC4l8PuiYjV4D5ceun/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgN+rsOX; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db19de6346so1778330a12.2;
        Fri, 13 Sep 2024 22:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291546; x=1726896346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKnY2tYCpQX1BHWQ11UETog6WmuVGfr1qz3Xgo6tJ4U=;
        b=BgN+rsOXSjWLtB9tXEJObXvxxZiugCqMrC370M0kcFW2TA+SDm7WwUDd0qfyso1Oo+
         5zVESM/mXmnb2gPUhJgU+5N2aIdKVI8N9JKG/Pw2e2pQz2IEBHdVBP8yluzziO8AXbHv
         f21mPSgh0bUQ69DOpjNfZQRafe/g4Zrp4XzjhKAPp9DbfBDwXatxaPAqqhpgfqRgZbUq
         +PFLvfgqv9M+XCGbx/fgfgGL8myTzO50ZwNG5xrIo0GUGjSwAtQF+iNs8Pvh76669I8e
         ZbkdFTKy4xc/sJBQyM6WL4dU9Yu/4+N7a5Wn0uWh4MG5qkR4UrXuFlGjdQhlOIJkuqzd
         9BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291546; x=1726896346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKnY2tYCpQX1BHWQ11UETog6WmuVGfr1qz3Xgo6tJ4U=;
        b=xG1O0wIsp9hvZqUAbq5XedV1UKPxSBMbma+STOSiRQ+gxZ0harcrICBy5e0pQpHpC8
         Y0G89XQFrUgVtwPBuSSSUZ6z/tpmxAbGy/GKp6eerU9kJldfhFtxuQuKs5hcW8Dz2ftf
         7uTABabWR6WPjfO9jCYfodaIjNieqQVd0U/xlCfVOAHpa3sz/EKNw57dgaOBVzX6Vq6/
         gR3xSPMqnYnCJAAxZLKUgpDfnsQjBNSGyIIfuAeRUE9kww1xXtXfey8mwsEJd/+ivvR6
         fPi67y9JHY4SdqXKkZMHGcINld9sp8TIRAFlkdEeoGDgUf2MMB6rklG7CYhqGIPeJnwq
         5mqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKB9kkNUCjkxHAv1q9Tix4aqUn2+O2Na+Zh62gLMmhRJy6SySw1/98+teIMvN1NCHccQHw18Xh4QP0fWfD@vger.kernel.org, AJvYcCVZMCKv77cKHd94swH6EKHac29DREkPDicyeaotqy9TMF6/xWaCN8zPSXQ60W1fbfzu2VvqVGwgy65vmA==@vger.kernel.org, AJvYcCWXT/26uIrU+F3uS/HccWPMFUpbhKj7hPe7QylOaqak9EbiLHByH6sK56/zBLMgvorrGkpPYE4+RT4tD3Lifek=@vger.kernel.org, AJvYcCWcqcUFme0c1MhZAvPiDa/d0cOSR/wO0VfC2jwVADeEHBMggW9Mxv5e16EzBDCvw5u6KBzV8vo5p4r/@vger.kernel.org, AJvYcCXJ3puhtKNu/UjDCfwcSl2zypmkat7DIN+RaGdBHCr/XmO5j+cjFzFUljC+4EInhagsqceDSa/SqnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZw2tP4IK9j+Z480rKP2FVoVMdAfaNg5rlMK+iVuCvMMPeA6+
	FifrBznw9Xcf+PtrlNV1kFpMnnU9JfonokXhOW+K2rMPP+79sC/7
X-Google-Smtp-Source: AGHT+IH9nRZfznFybfbPMBOkFdFbVQJJrzXWZhqJ6/jdwYElHzC3dy6jikge0iEfZkznzI0FlsDzxQ==
X-Received: by 2002:a05:6a20:e607:b0:1cf:4932:aaa with SMTP id adf61e73a8af0-1cf761e58e0mr10573497637.33.1726291546154;
        Fri, 13 Sep 2024 22:25:46 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:45 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 07/22] dt-bindings: arm: apple: Add A8X devices
Date: Sat, 14 Sep 2024 13:17:16 +0800
Message-ID: <20240914052413.68177-11-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914052413.68177-1-towinchenmi@gmail.com>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the only platform based on apple,t7001, the iPad Air 2.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 691f3af19622..0e6a51fad2fc 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -27,6 +27,10 @@ description: |
   - iPod touch 6
   - Apple TV HD
 
+  Device based on the "A8X" SoC:
+
+  - iPad Air 2
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -109,6 +113,14 @@ properties:
           - const: apple,t7000
           - const: apple,arm-platform
 
+      - description: Apple A8X SoC based platforms
+        items:
+          - enum:
+              - apple,j81 # iPad Air 2 (Wi-Fi)
+              - apple,j82 # iPad Air 2 (Cellular)
+          - const: apple,t7001
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


