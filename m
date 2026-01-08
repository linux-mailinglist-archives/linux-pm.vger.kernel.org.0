Return-Path: <linux-pm+bounces-40432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A1D0320C
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 14:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7255230491A0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158A37F73D;
	Thu,  8 Jan 2026 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N3bIEiry"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650A37F117
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862723; cv=none; b=A8/4TxnvCouR2UGzRa2PJATldqBdTOw59dKPne8K6ymHnRcwKJq12qqWlDtp4zDfK0w1cPzCSHX+bQQh4CGRCuTIX5Hp4MiFQ6QNlIqlpp6X6GLiKVjbCzbGu5O3kY18V7q/b7r6eYFXbQkQbXw4VDf0ayglsHF1To6wEH6HObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862723; c=relaxed/simple;
	bh=GFHSD6T+yl7vb4jLNYxTvC5Cl/m0iAwSIwdgU2lJoFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zcxf6qMOZUYhxWH3hXUxxvYPWjoU9bhp4cEBUv4v0kCrVG47FjXiRVDhNApDELNvwx6Hb6jmmpr3VMYLnKHl8whyMW3ii2EhgIgqtbmCbqE0SFKoJq62VqO8NWle/SqYpzUqjHPoHp9ShY9GdCHvoZKt+kTjsascnU5ilf9/zPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=N3bIEiry; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ae53df0be7so3785942eec.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 00:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1767862717; x=1768467517; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YLNYm7sDAJHbYjTNraEzX4Le1VPIWBSAnfsbzRwqAk=;
        b=N3bIEiryc7rQfbvZKLr1VEBvHg01R9oj5UtEYrZUzEyAJBmbJEeDDRlPwYGNFcWAzz
         JADfuveCJXTEHxKU7bFDDC6ltkSrehRh9qz0VZpafTURnTQLBpAGt16hREcqSnvldw3+
         CCuXAyIAfdbvfFS55IK1lPPD/9yHGpnNHSIomiDfAJkKaBK5cY0Rxgq5wZ31zGal3fwB
         hHZEfwBPuxAsqqXYuJdOhfRr3Em3tSlIWRjfGJfqiCZdlen4M/+l2GwYUCe6cH/Ip/TU
         kJE/BqKoY0brWby26XqlbDpGEBl7yg3owhOEh6q25EQ0L9ip97vsALQStOda2f8VUA3/
         a1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862717; x=1768467517;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YLNYm7sDAJHbYjTNraEzX4Le1VPIWBSAnfsbzRwqAk=;
        b=kdu8xiVwL62p5sznE/0ygX3sysETBQzhBC+gdehuHfL5B5U6cdciO/vTYWMbGV8s+V
         bhvsIFcOJYBoE8gk9g98t1Z0TgfFZvHiayRw8iURyJEJ7iAYEO7/A5Eyrx5gp3N6kLBv
         WO1i+O1bAfl6WdOKZNEhy+ff7rjtOtwGLPFN3V0BLy69tc/yHC7e2TwOZ9EykimOYZdz
         x1JJTuuYILlLzZFppzUSCSl0cL3BnUgMCkyW5kgzk2WO5DYWH5559dhry3rWHDZrH4Pt
         bL8PpZTcVfqtDD0mfLRXFnNdow5wdUSbKJnzn/Fh8PlLorw+E2Gk5FI7lc732zLcX/rv
         YS0A==
X-Forwarded-Encrypted: i=1; AJvYcCUQFZYqw0+sW6/KkyZ+7qczG89Zl+wWXafjmjHHZHzVojN821asye3kxbYUT/LRb3UWOXrxfpv3mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5TATax/sHLw9+cB0peZhCFuVaPQeHMjTKNfem9UmB8Y6d29z
	CSvetiBooLy11yWmlNPsjBz0Kjgh1298DHhe57ystjFlG24mFWLn2LVGYalPeAbkshg=
X-Gm-Gg: AY/fxX4sbkv7THLGcHCPE8YtvIZ0gTFOX/nscrRbH0IS6QpvsjEY32Ca+ZwjUASQQ+a
	PsQLxlH9KwnS/TF9AD0m2c8qbnhFcjXlXfMGk4ExeBIHmhiiu3SOSKSAvZBLFDjYZlJ1q7ad+gb
	p1ZA6m9PRP0rr7ETIc14jdzYD/BFN4dl7jF4oVHxa++WZkimvxzizKM+5E162sEKtq89X4W6DP6
	VCWMZkguwgm5UfwsrwPv4f+06CPDENoXo+GghfHM4y5lNHHXf2amm3HXEn44zstHbIYi9x69doC
	vjC2QdwoKdJmiu7hCU1GgcVIDfLosyNdzpkiKfl7ohq7ZyLE90/m14AlLNI4fq5zdXOcoUTRgWm
	peqj+70Di32/wi+Wafksy9pCXf4dXlVz/buqWOhgruJfmucUOg3J9Ac1jik7pLVepy+j4tUtg3a
	fg0juzXQTlYhg6xUGkp2iAhJc=
X-Google-Smtp-Source: AGHT+IE8UPhQsz/7Gn8i+wwXqoBhoOITsJ3Hs7nIToFk4RFrh69fxx3eoriotXBWNMydajNNbAyQiQ==
X-Received: by 2002:a05:7301:fd8b:b0:2ae:5b24:1cf6 with SMTP id 5a478bee46e88-2b17d30f886mr3883489eec.32.1767862717072;
        Thu, 08 Jan 2026 00:58:37 -0800 (PST)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm8833634eec.2.2026.01.08.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:58:36 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v4 0/3] Add SiFive power provider driver
Date: Thu, 08 Jan 2026 00:58:23 -0800
Message-Id: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9xX2kC/z3MQQrCMBCF4auUWTsliSatrryHuKjJxAzStEy0C
 KV3Nyi4e9/i/SsUEqYCp2YFoYULT7nisGvApyHfCTlUg1HGaqM6LBx5IZwDBqlDCjoXyFmt+pv
 2UH+zUOT3t3m5VkeZRnwmoeFfUp0y6qjN3rXW9Bo1ZvaPNr3Ov3zrpxG27QPlXR2fngAAAA==
X-Change-ID: 20251207-sifive-pd-drivers-66de65108b1c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Cyan Yang <cyan.yang@sifive.com>, 
 Nick Hu <nick.hu@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3

This patchset introduces the SiFive power provider driver, which sets up a
generic power domain (genpd) provider to coordinate with the RISC-V SBI
CPU idle driver.

To enable this coordination, split the power domain initialization out
of the RISC-V SBI CPU idle driver. This allows coordination between
power domain management and CPU idle states on SiFive platforms.

Changes in v4:
- Split the power domain initialization out of the RISC-V SBI CPU idle
  driver in PATCH 1
- Refine the commit messages of PATCH 1 and PATCH 3
- Rename cpuidle-sifive-dmc-pd.c to cpuidle-sifive-dmc-domain.c
- Rename SIFIVE_DMC_PD_CPUIDLE to CONFIG_SIFIVE_DMC_CPUIDLE_DOMAIN

Changes in v3:
- Update the explanation for the absence of the SoC-specific compatible
  string.
- Drop the smc3/tmc3/cmc3 bindings.
- Separate the genpd init and the idle driver init. The genpd remains
  functional even when the idle state is absent.
- Address the warning from the kernel test robot

Changes in v2:
- Add the driver for SiFive TMC, CMC and SMC
- Drop the `sifive,feature-level` property

Nick Hu (3):
  dt-bindings: power: Add SiFive Domain Management controllers
  cpuidle: riscv-sbi: Work with the external pmdomain driver
  cpuidle: Add SiFive power provider

 .../devicetree/bindings/power/sifive,tmc.yaml |  58 ++++++++++
 drivers/cpuidle/Kconfig.riscv                 |  11 ++
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-riscv-sbi.c           |  46 ++++----
 drivers/cpuidle/cpuidle-riscv-sbi.h           |  20 ++++
 drivers/cpuidle/cpuidle-sifive-dmc-pd.c       | 102 ++++++++++++++++++
 6 files changed, 220 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/sifive,tmc.yaml
 create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.h
 create mode 100644 drivers/cpuidle/cpuidle-sifive-dmc-pd.c

--
2.17.1

_______________________________________________
linux-riscv mailing list
linux-riscv@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-riscv

---
Nick Hu (3):
      cpuidle: riscv-sbi: Split PM domain init out of the cpuidle driver
      dt-bindings: power: Add SiFive Domain Management controllers
      cpuidle: Add SiFive power provider driver

 .../devicetree/bindings/power/sifive,tmc.yaml      |  58 +++++++
 MAINTAINERS                                        |   2 +
 drivers/cpuidle/Kconfig.riscv                      |  25 ++-
 drivers/cpuidle/Makefile                           |   2 +
 drivers/cpuidle/cpuidle-riscv-sbi-domain.c         | 176 ++++++++++++++++++++
 drivers/cpuidle/cpuidle-riscv-sbi.c                | 178 ++-------------------
 drivers/cpuidle/cpuidle-riscv-sbi.h                |  29 ++++
 drivers/cpuidle/cpuidle-sifive-dmc-domain.c        | 124 ++++++++++++++
 8 files changed, 423 insertions(+), 171 deletions(-)
---
base-commit: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
change-id: 20251207-sifive-pd-drivers-66de65108b1c

Best regards,
-- 
Nick Hu <nick.hu@sifive.com>


