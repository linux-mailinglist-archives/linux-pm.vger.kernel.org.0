Return-Path: <linux-pm+bounces-13984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B84974D07
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C52D1C21AB4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70415C13F;
	Wed, 11 Sep 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4xMwuNN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0C14A606;
	Wed, 11 Sep 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044415; cv=none; b=i9fNc9BatiicW2VfWY+46T6nJGqopSUYeGRWoANKCOqOd8z9WV7fKa97rlOc7mvAzlN+Hc/hAO9tiQQcRW/eExjaFz4TacElyMlCQsmORbeszl70nWgbWpkHmLjwVIDwVSUMs5eg+92Aj/wNjsl6HaaqjlXd/b8EqVOTBCF6+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044415; c=relaxed/simple;
	bh=PGn83Yidma26xXl4an9r0j3fqQh/M6sJ06wRtXqaK1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f46RP1zJAcFOBiyYYBSdFUwfYMngp0sH7mLc+EhwxKsLp1p49wJJbR6MbJX+7pamS+3s7c7nxZzn2+vIZC2VPZTyniB/ytXvFV2tSHMyxUc9hClgVUs/12u3vdBUNm3BNdYHjbN2zsjr1ZfH8p4FgVL74HVcYStZU63BxCyQW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4xMwuNN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718a3b8a2dcso3967445b3a.2;
        Wed, 11 Sep 2024 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044412; x=1726649212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FW1/BtXf0DDZF6QM0V+QwjHQw4Ee1wCPRNp4qZ3KaCU=;
        b=J4xMwuNN1TU9scFWE83mV0nim8WEiGkv51P0srh/mmOW0e92gzSQ1Q8mZtOgyNJ2St
         FialXWfSIzapLbM7qYq7Z+NjQtuIvvNHp7AvCGI6JBnBYuN8BhU/2v70MUoyO0ZkMF7u
         0w+EaxjAIfPgU4izs51gsUgVXHjgw8A3kDnoEHYDqxLWZPVbZAvyhAk8MW8pQHFYng6n
         ILXLi5HHp/TrN97yj14Yy2yJGNFq1YiIVn8JlNdrWdX2tRrTFBDwS3g/5qJvHWIz3ERe
         5MW8pl0wk1fihbI1LpSVCQea7GuFzDHbkDDe+bN0SbM+Git5D+ZYy8mtYZwib2nS0Ktm
         F1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044412; x=1726649212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW1/BtXf0DDZF6QM0V+QwjHQw4Ee1wCPRNp4qZ3KaCU=;
        b=NesOHMspgqtP/XiILifSLQgqKHx6HTsBuBvM/MRwy3I83NgVX8ZzgMMWiNlytDZRbU
         GfmACtpr33hFf0gK9yeDdwHpl0On9RJXJVhsNpTMyrtNzsQEAkcOtC/s1gVfDRvCB/Wb
         bfq4/eLKOB8/4/v8MULQeap8dKxt4QrFq/68oTvkHc+7OHh1eEx1CxUFLIVfPLInNbD/
         JMah4OPM3ybBFj0t83rYv7wX649mOuwHbEsp8QbXEJU2V8AKhgifXr5d9AYlgK5M3qUp
         wcX68yEAYVaz1no2u/bKusVLx9K3Dv0CPJ9zlT0GG+oSSKozbzqCJvviWRgw9+B9tutw
         wfLA==
X-Forwarded-Encrypted: i=1; AJvYcCU+kfK56LOONWlXvkoshq4bECreuEZd9jEqla/EYx9D8YEwm0KOCMIf7Ji5uIEimcJNLd4d4eU42w5fVf9WIM4=@vger.kernel.org, AJvYcCUgOayWuIgQe09HirWccH/bm5dogBlue74wbRqtn9d4jV4N5osiIfneei23xLR17b7K75nh1hgRYgw=@vger.kernel.org, AJvYcCV+zHyz3w/N8GcR5VYrxU4HWn946+nQbMQrbojh4YMFI7nFO6N3dLagpsDI5nFWk3lPF6WM9bj37v5e8g0H@vger.kernel.org, AJvYcCV6R8Gg8zbljequphl+wk4henrT1jL5xDsRMZXMtOLpSY42mGTAwRb0zEIn7PqmzqWbxpXSNYPROSDo@vger.kernel.org, AJvYcCXGm+omKWscfWQpDDjHaw/bL6uZxzo7XUMAJnNR3TIEFO91JRTkfPKzF7sbxVPjlFLI2u3BfnLi6E7j5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbSZDlBB3WZHJADVucxlY+YUSUVZuItIvqUC9b//3pckwY19Y
	EhAyFytwVqPvqUz8K5mv1D8tfrdgI1Ogz/egJ65yqf1xn4ugp2/W
X-Google-Smtp-Source: AGHT+IH83l3xFXj0fxnNctpZP7vnaqVwdExXDpp1HdTAXfwuFzGmYyY0OGZ0uMpU84i+wk2Ul4Wxvw==
X-Received: by 2002:aa7:90d3:0:b0:718:f026:6c78 with SMTP id d2e1a72fcca58-718f0266dccmr10572628b3a.13.1726044411932;
        Wed, 11 Sep 2024 01:46:51 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:46:51 -0700 (PDT)
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
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 00/22] Initial device trees for A7-A11 based Apple devices
Date: Wed, 11 Sep 2024 16:40:50 +0800
Message-ID: <20240911084353.28888-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds device trees for all A7-A11 SoC based iPhones, iPads,
iPod touches and Apple TVs.

The following devices has been excluded from this series:
  - All T2 devices (A10-based): bootloader does not work (yet)
  - HomePod: Not tested, and it's also a different form factor

This series supports the following on all devices:
- SMP (spin-table)
- UART
- simple-framebuffer
- watchdog
- timer
- pinctrl
- AIC interrupts

The following is supported on A7-A10:
- gpio-keys
The buttons on A11 based devices like the iPhone X is a SMC subdevice,
and cannot be supported in this way.

The following is supported on A10:
- cpufreq

A10(X) has performance and efficiency core pairs that act as single logical
cores, and only one type of core can be active at a given time. This results
in a core that suddenly have its capacity lowered in low p-states,
so the frequencies of the low p-states must be adjusted.

Patch dependencies:
- The required AIC patches[1] has been sitting in linux-next since
next-20240906, through the tip tree.
- The important serial fixes[2] will go through the samsung tree and should
be in good shape though those have not been merged.
- The optional patch to disable 32-bit EL0 on A10(X)[3] has not received
any comments (v1 or v2).

Authorship information:
- The commits to actually add the dts files are mostly made by Konard,
and Konard's sign-off is added by me with permission. I also updated the
Konrad's email in the actual dts files. Konrad can confirm this.

- Everything else is entirely made by me, including the cpufreq additions
into the dts file for A10.

[1]: https://lore.kernel.org/asahi/20240901034143.12731-1-towinchenmi@gmail.com
[2]: https://lore.kernel.org/asahi/20240911050741.14477-1-towinchenmi@gmail.com
[3]: https://lore.kernel.org/asahi/20240909091425.16258-1-towinchenmi@gmail.com

Nick Chan
---

Konrad Dybcio (8):
  arm64: dts: apple: Add A7 devices
  arm64: dts: apple: Add A8 devices
  arm64: dts: apple: Add A8X devices
  arm64: dts: apple: Add A9 devices
  arm64: dts: apple: Add A9X devices
  arm64: dts: apple: Add A10 devices
  arm64: dts: apple: Add A10X devices
  arm64: dts: apple: Add A11 devices

Nick Chan (14):
  dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
  dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
  dt-bindings: cpufreq: apple,cluster-cpufreq: Add A10 compatible
  dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
  dt-bindings: arm: apple: Add A7 devices
  dt-bindings: arm: apple: Add A8 devices
  dt-bindings: arm: apple: Add A8X devices
  dt-bindings: arm: apple: Add A9 devices
  dt-bindings: arm: apple: Add A9X devices
  dt-bindings: arm: apple: Add A10 devices
  dt-bindings: arm: apple: Add A10X devices
  dt-bindings: arm: apple: Add A11 devices
  arm64: dts: apple: t8010: Add cpufreq nodes
  arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE

 .../devicetree/bindings/arm/apple.yaml        | 160 ++++++++++-
 .../devicetree/bindings/arm/cpus.yaml         |   6 +
 .../cpufreq/apple,cluster-cpufreq.yaml        |   4 +-
 .../bindings/pinctrl/apple,pinctrl.yaml       |   5 +
 .../bindings/watchdog/apple,wdt.yaml          |   5 +
 arch/arm64/Kconfig.platforms                  |   4 +-
 arch/arm64/boot/dts/apple/Makefile            |  52 ++++
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |  52 ++++
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |  52 ++++
 arch/arm64/boot/dts/apple/s5l8960x-j71.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j72.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j73.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j85.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts   |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j86.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts   |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j87.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts   |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |  52 ++++
 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi |  13 +
 arch/arm64/boot/dts/apple/s5l8960x-n51.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x-n53.dts    |  14 +
 arch/arm64/boot/dts/apple/s5l8960x.dtsi       | 147 ++++++++++
 arch/arm64/boot/dts/apple/s8000-j71s.dts      |  15 +
 arch/arm64/boot/dts/apple/s8000-j72s.dts      |  15 +
 arch/arm64/boot/dts/apple/s8000-n66.dts       |  15 +
 arch/arm64/boot/dts/apple/s8000-n69u.dts      |  15 +
 arch/arm64/boot/dts/apple/s8000-n71.dts       |  15 +
 arch/arm64/boot/dts/apple/s8000.dtsi          | 179 ++++++++++++
 arch/arm64/boot/dts/apple/s8001-j127.dts      |  14 +
 arch/arm64/boot/dts/apple/s8001-j128.dts      |  14 +
 arch/arm64/boot/dts/apple/s8001-j98a.dts      |  14 +
 arch/arm64/boot/dts/apple/s8001-j99a.dts      |  14 +
 arch/arm64/boot/dts/apple/s8001-pro.dtsi      |  45 +++
 arch/arm64/boot/dts/apple/s8001.dtsi          | 167 +++++++++++
 arch/arm64/boot/dts/apple/s8003-j71t.dts      |  15 +
 arch/arm64/boot/dts/apple/s8003-j72t.dts      |  15 +
 arch/arm64/boot/dts/apple/s8003-n66m.dts      |  15 +
 arch/arm64/boot/dts/apple/s8003-n69.dts       |  15 +
 arch/arm64/boot/dts/apple/s8003-n71m.dts      |  15 +
 arch/arm64/boot/dts/apple/s8003.dtsi          |  19 ++
 arch/arm64/boot/dts/apple/s800x-6s.dtsi       |  50 ++++
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi    |  44 +++
 arch/arm64/boot/dts/apple/s800x-se.dtsi       |  50 ++++
 arch/arm64/boot/dts/apple/t7000-6.dtsi        |  50 ++++
 arch/arm64/boot/dts/apple/t7000-j42d.dts      |  18 ++
 arch/arm64/boot/dts/apple/t7000-j96.dts       |  14 +
 arch/arm64/boot/dts/apple/t7000-j97.dts       |  14 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |  51 ++++
 arch/arm64/boot/dts/apple/t7000-n102.dts      |  49 ++++
 arch/arm64/boot/dts/apple/t7000-n56.dts       |  14 +
 arch/arm64/boot/dts/apple/t7000-n61.dts       |  14 +
 arch/arm64/boot/dts/apple/t7000.dtsi          | 147 ++++++++++
 arch/arm64/boot/dts/apple/t7001-air2.dtsi     |  44 +++
 arch/arm64/boot/dts/apple/t7001-j81.dts       |  14 +
 arch/arm64/boot/dts/apple/t7001-j82.dts       |  14 +
 arch/arm64/boot/dts/apple/t7001.dtsi          | 154 ++++++++++
 arch/arm64/boot/dts/apple/t8010-7.dtsi        |  45 +++
 arch/arm64/boot/dts/apple/t8010-d10.dts       |  14 +
 arch/arm64/boot/dts/apple/t8010-d101.dts      |  14 +
 arch/arm64/boot/dts/apple/t8010-d11.dts       |  14 +
 arch/arm64/boot/dts/apple/t8010-d111.dts      |  14 +
 arch/arm64/boot/dts/apple/t8010-fast.dtsi     |  27 ++
 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi    |  45 +++
 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi    |  15 +
 arch/arm64/boot/dts/apple/t8010-j171.dts      |  14 +
 arch/arm64/boot/dts/apple/t8010-j172.dts      |  14 +
 arch/arm64/boot/dts/apple/t8010-j71b.dts      |  14 +
 arch/arm64/boot/dts/apple/t8010-j72b.dts      |  14 +
 arch/arm64/boot/dts/apple/t8010-n112.dts      |  48 ++++
 arch/arm64/boot/dts/apple/t8010.dtsi          | 227 +++++++++++++++
 arch/arm64/boot/dts/apple/t8011-j105a.dts     |  14 +
 arch/arm64/boot/dts/apple/t8011-j120.dts      |  14 +
 arch/arm64/boot/dts/apple/t8011-j121.dts      |  14 +
 arch/arm64/boot/dts/apple/t8011-j207.dts      |  14 +
 arch/arm64/boot/dts/apple/t8011-j208.dts      |  14 +
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |  45 +++
 arch/arm64/boot/dts/apple/t8011.dtsi          | 175 ++++++++++++
 arch/arm64/boot/dts/apple/t8015-8.dtsi        |  12 +
 arch/arm64/boot/dts/apple/t8015-8plus.dtsi    |   9 +
 arch/arm64/boot/dts/apple/t8015-d20.dts       |  14 +
 arch/arm64/boot/dts/apple/t8015-d201.dts      |  14 +
 arch/arm64/boot/dts/apple/t8015-d21.dts       |  14 +
 arch/arm64/boot/dts/apple/t8015-d211.dts      |  14 +
 arch/arm64/boot/dts/apple/t8015-d22.dts       |  14 +
 arch/arm64/boot/dts/apple/t8015-d221.dts      |  14 +
 arch/arm64/boot/dts/apple/t8015-x.dtsi        |  15 +
 arch/arm64/boot/dts/apple/t8015.dtsi          | 269 ++++++++++++++++++
 88 files changed, 3257 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j72.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j73.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n51.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n53.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j127.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j128.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j99a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pro.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j81.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j82.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d10.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d101.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d11.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d111.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-fast.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j171.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j172.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j71b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j72b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-n112.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi


base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
-- 
2.46.0


