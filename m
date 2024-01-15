Return-Path: <linux-pm+bounces-2190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2B82D6E1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0223C1C21636
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98314F4FA;
	Mon, 15 Jan 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Bx4lfp/d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFAF9CE
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-598e01ce434so876597eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705313466; x=1705918266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+D1l7MDJ7PqRKV1gRx82cPii/0bkhIwCmY25QP/RxaE=;
        b=Bx4lfp/dAV5DrKNyckkBvP2tsq5kqUN1tWbObT5zPvJkTRXIvCeqc2fV0F4eRiOraY
         Zll2cLGqgDOkFxRLIWQ7yJ9k+aERXZM024/GpxAnCTT4hxQlSOl2lD6YhOySyw3Kj6Tf
         7vFoNvWYa4tPIIwjxPOIKtI9bgQ5PjatxQZnhgtdU6slJJZJg8+DWT5R886xaRaMxAD7
         1LsOr527caCLPKlIO+3YiwBHt5vajTBHQre6sAXY7FZIPafMcX+sA57O2RQmFzL/CI+j
         wx37gTwSyqByN5HdThaKzowq7oXLHhuLh5WrRLnHEm59zBQzna7y2tNmgx/RfrH69NoZ
         8T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313466; x=1705918266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D1l7MDJ7PqRKV1gRx82cPii/0bkhIwCmY25QP/RxaE=;
        b=DJUhCMmYcYXt1eXu5A107bfStNemhinbzz+h7nEkT5NeoIbTPUHd/TEAOzT6hM/ZZz
         x0Nx+GfGGLbqvYwAJ1H67lnoeUXggvUxzqRBb9HxgOjMuNw5Z4JAogDH6oEG3KP+lP5v
         9DA043aFi9dJcfJ9LqZ0Prv5Zu7HRNWFaeoe3vmD6BEjuWiCthOcz+Zz+q3xVGyMv9hh
         dY42ahnPAvzcMYWASy1c32XHaxp7vxuZQGNsYvbQjcC+v91NVBs9ylL3o+Ie2CltQiTg
         tNiXe6mA6eQp36mR8zxF1WvE/lYUz2lcPx7XCzmMQcjDmqHUTouO34UBggDQeBec9r86
         eqfg==
X-Gm-Message-State: AOJu0YydtkiSzC6NiHColGN4rPzfSykWWu6mg4IjYMnFBNEIzNgSZPs4
	ysd5F9r0khVaxa8rsiNi8Hhd+cakqlZcrrFQN/iJKEM9l24FvA==
X-Google-Smtp-Source: AGHT+IF47ROODJD0FnkWocuvC9yXVXK34tP9aIvQB8RqdRDE264JjbYTVF4hhoy3J/3GEi8o7KQVOg==
X-Received: by 2002:a05:6359:6b81:b0:170:64cd:8aac with SMTP id ta1-20020a0563596b8100b0017064cd8aacmr3471927rwb.62.1705313465983;
        Mon, 15 Jan 2024 02:11:05 -0800 (PST)
Received: from localhost.localdomain ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b006d9b8572e77sm7348256pfm.120.2024.01.15.02.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:11:05 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Pavel Machek <pavel@ucw.cz>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 0/3] RISC-V: ACPI: Add LPI support
Date: Mon, 15 Jan 2024 15:40:53 +0530
Message-Id: <20240115101056.429471-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Low Power Idle (LPI) on ACPI based
platforms. 

LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
enable this is available at [2].

[1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#lpi-low-power-idle-states 
[2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v/riscv-ffh.pdf

Changes since v1:
	1) Reordered the commits such that the patch which enables
	   ACPI_PROCESSOR is the last one in the series.
	2) Used GENMASK and other changes to address Drew's comments.
	3) Moved common functions required by both DT and ACPI based cpuidle
	   drivers from the DT driver to common arch/riscv/suspend.c.
	4) ACPI cpuidle driver is added under drivers/acpi/riscv
	5) Rebased to latest for-next branch of linux-riscv.

Sunil V L (3):
  cpuidle: RISC-V: Move few functions to arch/riscv
  ACPI: RISC-V: Add LPI driver
  ACPI: Enable ACPI_PROCESSOR for RISC-V

 arch/riscv/include/asm/suspend.h    |  3 ++
 arch/riscv/kernel/suspend.c         | 47 +++++++++++++++++
 drivers/acpi/Kconfig                |  2 +-
 drivers/acpi/riscv/Makefile         |  3 +-
 drivers/acpi/riscv/cpuidle.c        | 81 +++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-riscv-sbi.c | 41 +--------------
 6 files changed, 135 insertions(+), 42 deletions(-)
 create mode 100644 drivers/acpi/riscv/cpuidle.c

-- 
2.34.1


