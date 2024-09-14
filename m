Return-Path: <linux-pm+bounces-14220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F4978D9F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53F81C2263F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E205464E;
	Sat, 14 Sep 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz909u8+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99652B2F2;
	Sat, 14 Sep 2024 05:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291533; cv=none; b=Zvdmzsind93oxpX/+QDPfqR2nY/giLVyRA94CVtQDQokXl8ynCLmy/mEzghJiBi3r5FinRRLmECKDSr7URRj60II4SV44Lmoge78qYNdV9ggJsy22jRzLZe1jVt/6jcTlBKDNxg78wORVJez9HZaHlR3NFwqQBcmbbocP4XoL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291533; c=relaxed/simple;
	bh=F+fvD8tj9Q89DXXtcIua1ke1r+dlwF7u6BI3SFUU4HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgmddjgNpDFBwc8bW7r7Ql2U9zKbltPTqFIGnhxUQNTCvo9/66nh6WoP4ptTO6izjOGnfKOxe7vNrCnwU5KzFm5b5jkmvQLlBemInh0cAATAYAnDDX6aWEYZmE0FfLfW+I5Yl0DyZ1k3k60wZn4sDNvNRco6EkuBnZzaUfb6xFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz909u8+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718816be6cbso2252874b3a.1;
        Fri, 13 Sep 2024 22:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291531; x=1726896331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g//YBvaXm4NDbD/O/tpcG0z+ryfJ+nqPnLFYEOt6ung=;
        b=Uz909u8+jLFCGV66dAsTJRkpcxW/p326pQZOFFbYQeM+IJbl98XfZlC0z6md/qhpAa
         I0KIfupaNAh1q6y1Ur8sBDVSX2Z+ZzPzf4GC+KjkiSxGEehMUm9jYJx/JpCSU8+j3+6E
         3WvH/krbHrXJF0lWFjYkH5hnz74i7OulguUYsq0RGqoQMdv1CtlfzwAQO+JN1PP7GSkZ
         efruUGywUFclEqJbVEUNzKH8vmvHJGr+9T7u8sqqJt43Vp7LDRDdoASo2L7fDixv/rdb
         KzwLkCFrKTCSNg8QryRhogfgFHcSJNNvn45VO1CejYoXospki1v5H5s5GC5OuKhdeXQi
         SwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291531; x=1726896331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g//YBvaXm4NDbD/O/tpcG0z+ryfJ+nqPnLFYEOt6ung=;
        b=SaVMA2JyjoLJOQ6rXxV3T9N9/eCUi1Ej9fwLTd2doaV5a5AUEEea9Uv00EwkMp7O/s
         EN0muzNsJ0xI+2pqeEIyF1YTDi6VqJounRZ2avADIT5E0NXeNfi2lYvnYie1VEsVN5vj
         KTuBOD6xAkXQxORhFKMsv8T1OJCXXki35LvUb5IcNBPGuFxM7TTmw61NiwBfMLdMXfhd
         Z1gTzvWzi9V6sDAFM1ZJrscCVtajO5jvPJpjrhqC1PEAyDdbp4/sh3ig7/VPnm82Ph7/
         Yo2n2eeVWilm77+wKns/2ju18jBz4WQzUFyoSWQ0IAegviFYM29C9ROjHXsGF8TWWctC
         xdQw==
X-Forwarded-Encrypted: i=1; AJvYcCUYj1Xder8OcI2C/weQLgrbMO0PLrNqZP9/uJYgq5KOnVfNkIu77ajsSx4AHUTko95Fep4LwSchZ2wq24cL@vger.kernel.org, AJvYcCVNzmrlhsG3TXybnPbSoQC5zpBOYzNIdlUTxM3NijLy/y3Cn8VPVEwNfiC++y+IkkSoV7DQyTl1ttg=@vger.kernel.org, AJvYcCW3RVeyCZFTNWxwrTuygUJ5YYj1caNPiMCfl2gGUBDG2Q7mE3GoxPWI8C4itrTiDHMZwFi2oKeuLw+Fzo67IrE=@vger.kernel.org, AJvYcCWEQ0THNEYbza0KllQwmHcMDlgm+Rr/ls2Wxkkrvx5f43KQklCoEcE9RgqQpuE6Cad/WqBmere8HHyK2A==@vger.kernel.org, AJvYcCWH0tzJ3gI21U/mKLsnogrAngErIB70i9nAsCuHyemvnCkvTgjs0nZTBcg24FfoajMcCQ+cRIIARsf4@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWT2hhI4WEHt6QoAjiR+HZkfFvSUUnVaxK3iAIXi2iGaBrE2O
	53uiwOKtGdHsvshFhPRk2j7/JIEZgR0W2vDvhXqLl15Uw3v4nXM4
X-Google-Smtp-Source: AGHT+IGQSFu6QY66e69mAhTPIHg3eNOkel13pASKa6+pvmxCzW50S4DffsbQlwvOy6w9642wKkbLuA==
X-Received: by 2002:aa7:8895:0:b0:718:da06:a4bf with SMTP id d2e1a72fcca58-71926067e21mr11597097b3a.2.1726291530977;
        Fri, 13 Sep 2024 22:25:30 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:30 -0700 (PDT)
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
Subject: [PATCH v2 04/22] dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
Date: Sat, 14 Sep 2024 13:17:13 +0800
Message-ID: <20240914052413.68177-8-towinchenmi@gmail.com>
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

The block found on Apple's A7-A11 SoCs are compatible with the
existing driver so add their per-SoC compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 9c07935919ea..63737d858944 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -18,6 +18,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pinctrl
+          - apple,t7000-pinctrl
+          - apple,s8000-pinctrl
+          - apple,t8010-pinctrl
+          - apple,t8015-pinctrl
           - apple,t8103-pinctrl
           - apple,t8112-pinctrl
           - apple,t6000-pinctrl
-- 
2.46.0


