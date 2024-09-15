Return-Path: <linux-pm+bounces-14297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74FE979563
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF079283D57
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4891386B3;
	Sun, 15 Sep 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN32IjKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3CF9DA;
	Sun, 15 Sep 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387721; cv=none; b=QK8JgrnHdlI1gvwIv+dnUB9Io0XPUQSl/mAop0Hq3EGa6HaU4ZV5qElISivmd5h7T0IurigTCg2TX/2dU0up0RNkk5AYHuypoKF9S//dugEyxRtMv91MuS2E9TUOIPYVW1OGObIOFr4JBGaTaI05a2owrpMYC7OFGhQf7x1GBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387721; c=relaxed/simple;
	bh=1/0kBarxJdeH0ODjM886OO6FOOEXyxF3Df2gBqXy/CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8GU/mdTbB5ynkjLZyD52grsYRtEJ0TJz0jZG1IlB9clP7MNfVQ+9qQVTLa5n07vIyRLaUNQYLdqcXVGZvh+xlzsYEDnSES7hcyDWNSbklE9pucr9enGBvGGmP18UkaPx7GNagZJc5A8I4lpZJHbFezL3XCW9LO52D7R1d2QcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN32IjKD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2068acc8b98so31018055ad.3;
        Sun, 15 Sep 2024 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387718; x=1726992518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCeCV/1xwkdl5BzxyfA7coBD1+lL/3DpL3W4/CdUMdE=;
        b=hN32IjKDN4eLPTI+nfBoVjr10nslf9RMAevIrBiJUrWEb1F+RdF8lVfgrQ1YU8Wcml
         PsHBZpStUEbF9a2dA/CojHDWHZ39KUdy/O/T8UitxYZ94/eV6tMe6Y84acxnRJZmdi7J
         NstcDciScMOWKy1hcaM/HvW8uKYJ9KR2Q/oRagUe6oJ8UPfWVvApgbmsI2YewhiZrOrc
         nQTxbsEK817g3Snw5NlQ16Gsqb+/uCNxkx9y6Wa21yPJuJ+vGjpYnfiYzcCYT8fxa9nQ
         5aYi8Y0pUxZ0XIORVd7EiMzDWR60oxZRDXPjiUW6SPwddxywCJFUgkgTTIjtKsA4eZrS
         UaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387718; x=1726992518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCeCV/1xwkdl5BzxyfA7coBD1+lL/3DpL3W4/CdUMdE=;
        b=S7y9nIpZ3wczSudRY5gQlEy6BvyPYWNUebLUuPjIXCHYpQZxKTNl3TFqvUBPB2UTO8
         v0CsoLK54YAQSMyQlNlzDegPv0+l5Mmwkz5Yar+QATZdH3rIvNtL/WumUd2G4q8BXtUI
         ziFWgzFUSX8X+xQRePivBktSQ8dAb7arXHAL76jxEcf1fFvOG9mjw7Wx4/ENBCKHCI6O
         MB/e2obuR7DqqYu2fnXtnVicQq38i7jAt+yI6ROL1+YGS37VuGg63QpsuV+0YM50szpy
         /2nEIsN/S6yCHmXcBRE+8XvQMhgFiM/tnEy+mGL2vFcFjH8PGl+4luWQOOBOqLp/ikC6
         kqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUgjJbzOmHJ8268sMOYbrWIScmkaPe+CtZKd7ODH9RryfJ5pNC5YDB3yS9WI/wmEUvW9flAhMrLFg8eAUSz@vger.kernel.org, AJvYcCWWnUgcyxpGy3hUguSpkym47HLJpFDs2qem7eSrSqsAOja1Xv8yqm8LNa6fFiOu8vB5wkjKJoFyooWirQ==@vger.kernel.org, AJvYcCX+d3WaImx+9h2yRLvzZaGTz98WBSQusMnbDqa/Ky7hLKHHCe7NXWwYcgqqUCWvzQavlTMtSC95BXtWHgbKVzI=@vger.kernel.org, AJvYcCXX3dLPZMU9rjkB2zlvdBjdTVLQPQjhC6t+1gtB4mhEjuPlgMeDV7KTNnQHhqZZdFW93/RazHTsY5yf@vger.kernel.org, AJvYcCXrk3fcsgsIsccnOIqTEZVkzmXC2XDb2gme3sz6nKXNlPpdYvJA1LWmP63dhKRlaYEfRlZSyy0szac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qm9q051eXl9UyVQZ4yTW8X9SY2MMIUyMLtIeZzwvQesONf69
	/JiIGclRB/+o7DnVDE9XSfVDeXwc9WuXqp9dFSF2YLJBknTxLi+e
X-Google-Smtp-Source: AGHT+IHebPyOY1XNR/e+vdqULneCJ+RVuSOsjS3g46ZPR9rwY9JaB3S5x4I/SyYN8reGXwfPGUtoTg==
X-Received: by 2002:a17:902:d54a:b0:202:9b7:1dc with SMTP id d9443c01a7336-2076e44ba5emr155141685ad.54.1726387718546;
        Sun, 15 Sep 2024 01:08:38 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:38 -0700 (PDT)
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
Subject: [PATCH v3 05/20] dt-bindings: arm: apple: Add A8 devices
Date: Sun, 15 Sep 2024 15:58:50 +0800
Message-ID: <20240915080733.3565-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the following apple,t7000 based platforms:

 - iPhone 6
 - iPhone 6 Plus
 - iPad mini 4
 - iPod touch 6
 - Apple TV HD

The remaining HomePod is not supported as part of this patch.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/arm/apple.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 89c1e35e404b..c05a4414c8b6 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -19,6 +19,14 @@ description: |
   - iPad mini 2
   - iPad mini 3
 
+  Devices based on the "A8" SoC:
+
+  - iPhone 6
+  - iPhone 6 Plus
+  - iPad mini 4
+  - iPod touch 6
+  - Apple TV HD
+
   Devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
@@ -89,6 +97,18 @@ properties:
           - const: apple,s5l8960x
           - const: apple,arm-platform
 
+      - description: Apple A8 SoC based platforms
+        items:
+          - enum:
+              - apple,j42d # Apple TV HD
+              - apple,j96  # iPad mini 4 (Wi-Fi)
+              - apple,j97  # iPad mini 4 (Cellular)
+              - apple,n56  # iPhone 6 Plus
+              - apple,n61  # iPhone 6
+              - apple,n102 # iPod touch 6
+          - const: apple,t7000
+          - const: apple,arm-platform
+
       - description: Apple M1 SoC based platforms
         items:
           - enum:
-- 
2.46.0


