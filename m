Return-Path: <linux-pm+bounces-2193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107182D6EB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EF3281046
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CABF9F5;
	Mon, 15 Jan 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bZKZ5RwK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B62C683
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-598cf18b259so611890eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705313481; x=1705918281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=bZKZ5RwK6GYmMq55zsZlx2tlAro4s+tYGUdDy1IyT7cxNlm3sg2RcFWucVShUI0mFz
         7qubWVp+X0/fH7EzXoyzDOMjty36jijZimF7+2pucQzkGxA6suzmJxegpMOKAg7Gqy8G
         D3FeqFX3vEoAs4NvNoOU9mtl700IW2fOJEYRxYJfEyS39KHC88o59chDKW/Xb2swzdBs
         QWL9qCxDl25p/mb0GIKiDQb1AEmX7ZzqKB1QD1+gzQkwzDwEgH0ZTvcI/5DeMPTm4CQ4
         vYO6f9pKWvpp1HXMuQY/+xC2TbLgxyHBVlnV+lBuApnR5d6zVsr+J/wi0BJxceOucuw5
         k5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313481; x=1705918281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=ruQdovkKx82oiYRwRL6EURjm+0vSNpU49SZAMRAIfngN9wczXslx51oMqVmP3ho7qp
         Seib1n7py/Rb8GVbFAzBDB7/H3Xd09XqsD57vFzxo9ZYq14f3MooJjLE2eCa5QJE2A/h
         UgPJB0/jcU2MDDbZLjznWQtYX9BFExtYehxkAiJiCJasgzwshgdC5Y2DPDPsfPsI/h06
         4kSfNW0m9r/FoEDFC6gy0fUD5mfI5UbDSAYq2KQQ68j+U1l9WjQYbFDOpQn0Ya3cVLIx
         uo2t7RppVWOXVjWM5VpyapVS3Si3YMlwkHOZ9pnDhP7A/T8aLxmqrY+/vniilzw2DxV8
         HRNg==
X-Gm-Message-State: AOJu0Ywd3WtI+V1nqtQM2Mg72+OG0CppbvaMwVYi42J22Soc08S6i+wJ
	eWNczVvjRKhZwa4YkBhymMu0nE9ocWoU1w==
X-Google-Smtp-Source: AGHT+IEKOzlQXK85GuUQTpMoHri2twLXfd45mzkf3PZf+G55H8FBWt+pX+2+cyIqrJVcLKFALAXomQ==
X-Received: by 2002:a05:6358:7689:b0:175:4f3e:bd4d with SMTP id e9-20020a056358768900b001754f3ebd4dmr2404643rwg.49.1705313481257;
        Mon, 15 Jan 2024 02:11:21 -0800 (PST)
Received: from localhost.localdomain ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b006d9b8572e77sm7348256pfm.120.2024.01.15.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:11:20 -0800 (PST)
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
Subject: [PATCH v2 -next 3/3] ACPI: Enable ACPI_PROCESSOR for RISC-V
Date: Mon, 15 Jan 2024 15:40:56 +0530
Message-Id: <20240115101056.429471-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115101056.429471-1-sunilvl@ventanamicro.com>
References: <20240115101056.429471-1-sunilvl@ventanamicro.com>
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


