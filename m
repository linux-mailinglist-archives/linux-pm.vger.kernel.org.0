Return-Path: <linux-pm+bounces-33445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FDB3C827
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 07:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167A8A22A47
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA72224AF9;
	Sat, 30 Aug 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTIWyTgk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956911F1505
	for <linux-pm@vger.kernel.org>; Sat, 30 Aug 2025 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532066; cv=none; b=Mx+9pQ1FflRWCqyp7DlTRWsd1mbsQcnKBkzewh7qdACX7hJvVLapuXz1q9TIGgsigW1tti1+Q8bMuQH5mHcdgG3wwB88ppVyO2koYAR/C2qZBPqeuaHFNyTVl98ybNVGSeIzzLxRAfA5+1RBoiIcySWRkUhZpnLM6n2u32/b8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532066; c=relaxed/simple;
	bh=DX0NQTOPctZbUFCUUElKeaodKkfvi3RbqL2OU/+5zPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=td0tbCcQR9sXFRascbgiajEtx+Uu9PU4iwtrJKCHKWn+s9tk08C+/SuieJ5GX46rtv/89lfHINMtDSSpZNrV+ZAEwC6NtEyNqBR0SPKfsL1/KYZhNNC+ols4hjh3/DnDWgIygCncQuuJNsF6tdTuRTWUDyMKc196csXP885L+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTIWyTgk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso20911845e9.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532063; x=1757136863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVRhHrmR4NfDButmA/7Eylnvz3MCnug6Wj2wG9AN7kY=;
        b=uTIWyTgknbypTWhi/vJR5S8mq+r0H2VneuaD3IfAtqSZom24XNIhl92QDSbGi4x2Tu
         8MPSgsfR0p7lOyo10vgRsJ+bO9KKkjXaADpkv6LcFHvBthV9zRRa8VZEyIdZYw7p2WJD
         s5eLqLWazN8XZpe5xz1mtd1QxkYAm/QFPjK4PUQiQgedUEQmjow7rhHS7c7G8pwssnmM
         C6elPu0y2cO9mIShbXM0ffyxfBmT2gIrcoJ3KHPpZk+Zo1llfuWPlXwTSR5tJoioHyj9
         vYFLbqoL//XWBNAvLP7ssPpGnrzggxaC42DmsM6OprPeOZwgTMWi2jodFkkWY7hyuUD9
         3dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532063; x=1757136863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVRhHrmR4NfDButmA/7Eylnvz3MCnug6Wj2wG9AN7kY=;
        b=KgGd23+kUDawxEf8UvN/MTKkDtu+EAFmhYdO9IcUjxT+CEG/A+4YGW1q1dkyMi00Sj
         gr5YavW2/UE10RQAs0xbOKlRkKK+QSaqg8JRdgFhmfqKNuT5UEDRHDVa80zCk45xO5KS
         0nvTV4PCikqhmRcFfhND3WjGZfODxihCK3MZxXvoIJlzX9v/1W/dcGfrh8QtaANRpf9T
         4ppIH85ccvYYD82rBIx5Bw7GBcObtsABeHObFzz8sahdo6m6F/Mm+nW/YH3g7YgIVriP
         iw43r18YU71syKLyzGwZCpQCpOVB+H8DrwVvmko4W5Y086kfvaiSqAjlQD95USCQmLKN
         r33A==
X-Forwarded-Encrypted: i=1; AJvYcCX0wUEbj7GZvRExUtAJ3+84qhkwJQM6//+4tFnOxr5AZ3/3Av1BRJzN/jPMcIqADTKYUX+hAKq2Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywon5ktG76IXdSdSjG9Gr/aXGGF1/llN9Gqw8MD9XLb/nRParSv
	ZBlLbJox1fZ/1WfmGeBblsXK4o8zqXQS553WHrRgm80FsHtnhJy7o1Wi4+lUnP4z4CucbnBkTHo
	saoZtCg==
X-Google-Smtp-Source: AGHT+IH/hkj7qz/dHDeH0vuMVasId5lq5q3nQBrDqMG1o3azH3o7OI5Ed3rSkAS267Dqn9bXmoZaEelZ10E=
X-Received: from wmbel27.prod.google.com ([2002:a05:600c:3e1b:b0:45b:7511:8982])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b2a:b0:45b:8600:2be1
 with SMTP id 5b1f17b1804b1-45b86002e27mr4255385e9.7.1756532063035; Fri, 29
 Aug 2025 22:34:23 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:33:53 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-2-srosek@google.com>
Subject: [PATCH v1 01/12] ACPI: DPTF: Ignore SoC DTS thermal while scanning
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
critical overheating notification. The IRQ 86 is described in the _CRS
control method of INT3401 device, thus Intel SoC DTS thermal driver
requires INT3401 device to be enumerated.

Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE()
macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
is updated to ensure proper enumeration of INT3401 device.

Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Intel SoC DTS thermal driver")
Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 7 +------
 drivers/thermal/intel/Kconfig       | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index a222df059a16..947fe50c2ef6 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -11,10 +11,9 @@
 
 #include "../internal.h"
 
-#define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3400"},
-	{"INT3401", INT3401_DEVICE},
+	{"INT3401"},
 	{"INT3402"},
 	{"INT3403"},
 	{"INT3404"},
@@ -76,10 +75,6 @@ static int int340x_thermal_handler_attach(struct acpi_device *adev,
 {
 	if (IS_ENABLED(CONFIG_INT340X_THERMAL))
 		acpi_create_platform_device(adev, NULL);
-	/* Intel SoC DTS thermal driver needs INT3401 to set IRQ descriptor */
-	else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
-		 id->driver_data == INT3401_DEVICE)
-		acpi_create_platform_device(adev, NULL);
 	return 1;
 }
 
diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index e0268fac7093..47950859b790 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -45,6 +45,7 @@ config INTEL_SOC_DTS_IOSF_CORE
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
 	depends on X86 && PCI && ACPI
+	select INT340X_THERMAL
 	select INTEL_SOC_DTS_IOSF_CORE
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
-- 
2.51.0.318.gd7df087d1a-goog


