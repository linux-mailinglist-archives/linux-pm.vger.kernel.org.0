Return-Path: <linux-pm+bounces-2327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2498312BE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 07:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4BB283DF6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F29AD35;
	Thu, 18 Jan 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UojUzUzv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8411CAE
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559399; cv=none; b=e9JsSl/hVm29X3PBRiI+mBe/lwhdhvznxFlElr2CFt3szGSZkaeFDwmknZvtXf1lP1BrdUmEcMcM6cIUwLPXPVnIFM+fp7ID1Jv1cGz2GWzDS6EdzgZNaZv+mxq34v83BRP8NghpW0/0EINxVKwgyRY6vYJyhxFnXvUvD12D7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559399; c=relaxed/simple;
	bh=s0jCrtcsnupGkX8Rh/JQOe2YBiR/JeRC946luu2mtS8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=sPMtz4bHEt/8YPj0dP5tU7mkaK8pL6NRmBjtH1w/xm5xmcXuczRM3wB0s1O3aPUVO+abnw+XDwPY+izsMwvOFtLO/YfKY4UxlJ1konp2osdf1F2EERG/sJbUhsb2O91WxVcve3pPhlXmgf1saQENHC5YuarAmwQkOSQnsUmHxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UojUzUzv; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3608e1d27ceso42620945ab.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 22:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705559397; x=1706164197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=UojUzUzv24vzKx8LoRVUqy+GH3tnYvLx6nxhIdmKNRHtZt5k827VZNiTDqRLpaUggM
         0c6zZAM07/9NpdX3ZN890z4INf7iHl1L2+cT1aHcY+BIEHVSQ7ICMWiwegTJEGFIs00s
         562W/JY0SrDUTEPg1Gy36ZSGZRql2w8T7FhIbey8GsECnhweTWcIlEJwvNhBJOfATpXT
         u2sxvhrltg2cne/Y5X/dK+nlYe51jneghQxDxAaSujLJwmQhnGTREj7DZz5IAzW5hTLh
         TpZHbUuYAT+Nwouicz2cQqv25vFDdUfS+sX5yIp39Cpna8XMnIZMJrEcjjmGwq7aNi0e
         Ctkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559397; x=1706164197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=IFrPVTYE6YJcVIMeDeZq6Vkhw4JNP6lwZvsldxMy0A7G9Pp+eK8jhPDfWZhX4HEclJ
         VoyWDcqBWuM+G2VmjRqAJ97deF3llhMlNGELgtjFQ9SQU3A8CrG3zppLNWV0K+A6mgTb
         QT+fGuxrRRfnoP6v8RNTOxlAdjvBF486nDWgcKJTwqFi6HF/9T7ABGpVBqDBoE+c33Qe
         OdZrIdSnHnII3koaJxqL+yA65Wyp21lYTkFP1YyJG6QbkFgmGDXH7r//AF4LpSDguE/J
         ApX/Qf4rQWxSULOITjlVq43aAVvPggPUI7znOavsR0l106tLdldJJlNdIG4lGYSczBT+
         v30A==
X-Gm-Message-State: AOJu0Yy6uTPhSCurT5G7bny2qT5dkjjsN6yafNwuRah7wgtxSW5EcBZx
	YmW+gny/GP1/Z8PEvTsDC/zjcmCA6vxI8nvGTKJIvFQWw93FcIJxaAcjjyJ1HQrIHCqAfosdRAZ
	BabY=
X-Google-Smtp-Source: AGHT+IG5FtqixEBaNJDSNquSyctMTnCf+hskKjTKsUAyOqYtmHJhBUoYOvToNqCtx5vuaVjQy/gmAg==
X-Received: by 2002:a92:4a01:0:b0:361:993b:7f3 with SMTP id m1-20020a924a01000000b00361993b07f3mr523402ilf.11.1705559397011;
        Wed, 17 Jan 2024 22:29:57 -0800 (PST)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056e02339c00b0035fec699584sm4663269ilb.13.2024.01.17.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 22:29:56 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 -next 3/3] ACPI: Enable ACPI_PROCESSOR for RISC-V
Date: Thu, 18 Jan 2024 11:59:30 +0530
Message-Id: <20240118062930.245937-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI processor driver is not currently enabled for RISC-V.
This is required to enable CPU related functionalities like
LPI and CPPC. Hence, enable ACPI_PROCESSOR for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f819e760ff19..9a920752171c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -282,7 +282,7 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || ARM64 || LOONGARCH
+	depends on X86 || ARM64 || LOONGARCH || RISCV
 	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
 	select THERMAL
-- 
2.34.1


