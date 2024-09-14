Return-Path: <linux-pm+bounces-14227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4807978DCD
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518E4B26B49
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFFC1714A8;
	Sat, 14 Sep 2024 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq6gSv0f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A498063C;
	Sat, 14 Sep 2024 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291565; cv=none; b=KZoci8b1xlfycwrqMhgQbZNhkg6l37KQes6OccMBqgtRSo9McupB+7ptSMIdgf9YXsit+tNGp8CszThN+HcWoP3iYHjeFxI5YUi2nNRDSTyhn65DJR4fY4YPrsdxt4s1pWaHuonHYFoO5q9NCLRJkXPv+cTx2uFy0T4SbtLNzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291565; c=relaxed/simple;
	bh=FeY5rH2Qiz+FAfwmm6AVDJ21Mv5JbNCvSdeGNgfNLX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwFSXy8Ki8h0Up4YHFMwc0t84LVvc29PPmdcdX1PcOzGgh28PiH8+QMkyW3mMGFG51kaLNw6Yq/9ujD9L/XsWtzb91EdwTTMx9nBgz7AvZWafHK29eTB4wNxcMJUO++XC4wwkwSywjEX6XfcQ4PHlqEiCnN2SXFI/ysjSJP2608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq6gSv0f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e285544fso1326809b3a.1;
        Fri, 13 Sep 2024 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291564; x=1726896364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVu1SjDRNaTLjEcb9gqcIIxYP7YMiACMFhnku4atreU=;
        b=Fq6gSv0fBc/CGa2usMfZyhnGSStPUc8RVsghJbaTSLqoQBocJiI7xV2/nmlwB8gXEh
         S8wTWYW42JlhLJteWfrBQ0gP0FblBYFcatifcRTZ/ue+Z2D0ylXVA9BsTe0+5rs1tXa/
         IVp9oBmwC0nyCkky1kyl+1HnoLgSO7W1xmYdDfRXM6SQGvGTO5mG/iS+SidJ60mqKf03
         fCAb2cmFZ9EZBdjzLE6WCokiSfC6Eb1A31+EtEPApuCpDEkxWn+9eXh8a1h1EHXOzULN
         9Qn9UIsUHxSijCpFjG2m4Vx6Obph8wyQCZkaESLQ4Nx/EKwyaZoBJHeWVDNoVzPIWy1i
         XHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291564; x=1726896364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVu1SjDRNaTLjEcb9gqcIIxYP7YMiACMFhnku4atreU=;
        b=degDEqYqOKF+EcLHDbqKmo3yT1oeR/Tm9QpBec9GOKoEtpBfLJx4Yn/QNdWjIUkaG8
         1g+0LZV9ZLwW9XcvRbRqBRl+s0TNSppJtVAlMNYLKwAJHtzoPYi+KPVy7lRHTbzwt0xl
         D+bfJlKi7+U6oIiKc7Vvu9Ik5dzZjauQnuGoHNQl/tfqfZ+tyiWzQEwDlR87xAeTjwI1
         yO7HOkGoaOCIvXpojv539LAqcxUA4AjL9/LuQMy4ULwpVcRV+SOGLz0kR1vsWb4NC4e2
         kzU5iyeQdCp7UbATck1Yjc3absTX68somS9o0vZo/RShKSfz5/doKKq/0MdTL7BrpCjd
         9okQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhFJKp0VPZhEvg3r6xwcfzSByhilCWPsj7miKCeAdRNQQ1Zawt4W6WvJ/rYoGekMpia99M5GMFQTXwriT7yPM=@vger.kernel.org, AJvYcCUyYFtjHJ3Hpu1VSW7aBI6A7kWbJB7OjsKy9+4FrBwhUhlxp9Inftpb36e1hc5pJUxOtmPiE50bsy02@vger.kernel.org, AJvYcCWQwekCqOS3mHw1CWdBBjqO/WQ2z2magKKJ/uKVHwuKs6n+6hRz7uoAjeiVwapo6iMhIzz1TMy68Kt5kg==@vger.kernel.org, AJvYcCXPa53MQzCDJ8toRvbmlqhScRi/kcSTQwdTZXxF1VwnuG+PmBOGK2uZBnzA8g/rspKYR/e9JYbxcFc=@vger.kernel.org, AJvYcCXns5SXty7S02QBHv3vK4jOngVyQkaL3KCItad1JxEuBO+gn8ZUmCmT3y4Kc28Ufj8ZYIoTEr2fKoobCjTs@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRuTvxCvJvQDeeTG5Zn+tQqSU8sXWchH1McXndU4r7srfgytd
	xVmKWAzUAJ8G9O0ylVFKn5U3cFWEuToVnCTRvZ2GSbbfnJan+xna
X-Google-Smtp-Source: AGHT+IFcuKsB4caXjpEXM2wDj1LEyR4AEu2lgTGmde7vP+Ph0/AD48c7IH53OChI2N4UCrHaoB+JJA==
X-Received: by 2002:a05:6a00:13a9:b0:714:173f:7e6b with SMTP id d2e1a72fcca58-71936a3abdemr7922571b3a.2.1726291563917;
        Fri, 13 Sep 2024 22:26:03 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:26:03 -0700 (PDT)
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
Subject: [PATCH v2 11/22] dt-bindings: arm: apple: Add A10X devices
Date: Sat, 14 Sep 2024 13:17:20 +0800
Message-ID: <20240914052413.68177-15-towinchenmi@gmail.com>
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

Add the following apple,t8011 based platforms:

- Apple TV 4K
- iPad Pro (2nd Generation) (10.5 Inch)
- iPad Pro (2nd Generation) (12.9 Inch)

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index cb33bd1e7a2c..92fb48aafc39 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -51,6 +51,12 @@ description: |
   - iPad 6
   - iPad 7
 
+  Devices based on the "A10X" SoC:
+
+  - Apple TV 4K (1st generation)
+  - iPad Pro (2nd Generation) (10.5 Inch)
+  - iPad Pro (2nd Generation) (12.9 Inch)
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -188,6 +194,17 @@ properties:
           - const: apple,t8010
           - const: apple,arm-platform
 
+      - description: Apple A10X SoC based platforms
+        items:
+          - enum:
+              - apple,j105a # Apple TV 4K (1st Generation)
+              - apple,j120  # Apple iPad Pro 2 (12.9-inch) (Wi-Fi)
+              - apple,j121  # Apple iPad Pro 2 (12.9-inch) (Cellular)
+              - apple,j207  # Apple iPad Pro 2 (10.5-inch) (Wi-Fi)
+              - apple,j208  # Apple iPad Pro 2 (10.5-inch) (Cellular)
+          - const: apple,t8011
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


