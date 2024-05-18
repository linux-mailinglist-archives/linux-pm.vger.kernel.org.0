Return-Path: <linux-pm+bounces-7961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCA8C90BC
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CD4282BEC
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928C2E417;
	Sat, 18 May 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA79+6Ft"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DA1094E;
	Sat, 18 May 2024 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716034372; cv=none; b=fYiHq3R1cL+EYOJDLOmw8zQSvvF6jwaSJGkovtpqe5h8tsMZHRt2d6WD1pp5AVVpQRymIHrOHW0fg40Oo++AEENB4Xau1Z7592Vru1wfvgJum55DuJ56mNe19QrXxzoFCMujVUthemOYl7e2Rl/fYdT7A2AJeku3zh1sWbnS2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716034372; c=relaxed/simple;
	bh=r0t6CFjvmenX7VMTCLm+I26+KFRJnJj9fycDvnMM4gM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f05OkQmcWJe2D1sbcyPu6qF0SVw8N/BwRkbrcfNLd8cefBGqQR7Mp+WWpRD/cayjyWGmaZfY/HeLuR7Zz4hVLz1rkRmRI3+84WgylzsSDrkd3aPjPEoOC3IMzEhTUZeNyxBQr/5vGmoZWhefDneGcY756t8Z3mez/BCdaT3l3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA79+6Ft; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-351d4909711so525614f8f.1;
        Sat, 18 May 2024 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716034369; x=1716639169; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjQuoZFHMHA8S1ZSu4KweX7Wc6yX45qb5CUfF3JC+3g=;
        b=aA79+6FtC6DpTgnVfl0JNsp61zCxh3pOWU2uT9UbpuHXBazYrLgXnk2f1CVeUjzbUh
         NFAcaDzTmShxo1aQ8HyScIa98uXmgfDaiDAYuHAbReoYcXM9ygKCMBZqqnWx2QpW/Ubt
         QfX505S8hMsbnFQATsfDBwZI7OcQnfDyWxd7KhkjGNDXqb7Cs5b++f5TDXeRJFT9c7qQ
         NW8tNjFunbUF/ZKG9ZyTrsSJPh8DLf0Sbv+LOSGL15CurGwUnMycn2+WmZ54Ie6myheK
         u/zuWx+HD0d6lJoEXgHXUfujK8QGi4AJ0i4leiUgjFqybLpklXldERH6H3vaQOQ8nNFU
         +/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716034369; x=1716639169;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjQuoZFHMHA8S1ZSu4KweX7Wc6yX45qb5CUfF3JC+3g=;
        b=v+kAJjh5TImS8xHl1z9E8Jw+9e0c9gnBu+xosa8dm+2kdfSjKDxlJQ9J39BW2DCA5v
         SEYpSwXsc7OjTldL+Ikz4M1V9+JRWAs5BHo1y5i6HFvqIMPjjIdi6RKVmQvn+LbLmCIE
         qsFtM7w8G4G1Ig21+PoQOhSt44icj1J+1EIicN1ntZGd7rW/l9jsJ6UXz/jU0gy9TmOq
         hEzTHgKlW6ATtZ3lAgu1vzB6LgesT/T24Xe32JJLmokR8SayEVmv1x5UNDuCCgM02Oh3
         1S2kTH1FW/lWfgkBc3rWJbCfn0gitMV/hK2RFjtoDSfu9VApZZZdFFZPUk7oA9r75cxl
         dRyw==
X-Forwarded-Encrypted: i=1; AJvYcCWveb12L4r1rodXCTLq2aC/vhDGoSzQ4SnLz1u3bqHQKFVGKYNm9GMgNANj84gLgL/1ZIo0TB7y7Hi1odm4BL+xs6Prtn6y0PTiPRk2qxUzsOpCK/VAoFrJBG4GPAY9L0FzRjz7yA1Hdg==
X-Gm-Message-State: AOJu0Ywx7KJ02ikzsL4f0H/0ofeTo8czYje/xcWmAKc8Ll2UEC4nK9Ya
	apjsrJmV+2ZtiSgQqvHYooYl0gqEtXd+aVi21c+7rCddozTokQOc
X-Google-Smtp-Source: AGHT+IGPNIPUXCl8p9mcn96OQDjPifRyietNIMcyjKmJFSVcHTvDZHbrKpLqRbHX7v2igTtLoYFISQ==
X-Received: by 2002:a5d:4484:0:b0:34c:e0d6:bea6 with SMTP id ffacd0b85a97d-354b8e3733bmr1436214f8f.29.1716034368352;
        Sat, 18 May 2024 05:12:48 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a76e6sm24059321f8f.62.2024.05.18.05.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 05:12:48 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH 0/3] Add thermal management support for STi platform
Date: Sat, 18 May 2024 14:12:03 +0200
Message-Id: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABObSGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0ML3ZKM1KLcxBxdizQzI1MTI4vE5DRLJaDqgqLUtMwKsEnRsbW1AJA
 ZiwxZAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.13.0

This patch series enhances the st_thermal driver in order to enable
support for thermal zones. The changes include:

1. Replace deprecated PM runtime macros with their updated counterparts.
2. Implementing devm_* based thermal of zone functions within the driver.
3. Updating the stih418 device-tree.

The device-tree patch depends on an earlier patch sent to the mailing
list [1].

As it is currently implemented, an alert threshold of 85°C is set to
trigger the CPU throttling, and when the temperature exceeds the
critical threshold of 95°C, the system shuts down. There is for now no
active cooling device on the platform, which explains the use of the
cpufreq framework.

[1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com

To: Rafael J. Wysocki <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Raphael Gallais-Pou (3):
      thermal: st: switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      thermal: sti: depend on THERMAL_OF subsystem
      ARM: dts: sti: add thermal-zones support on stih418

 arch/arm/boot/dts/st/stih407-family.dtsi |  6 +++--
 arch/arm/boot/dts/st/stih418.dtsi        | 41 +++++++++++++++++++++++++++++---
 drivers/thermal/st/Kconfig               |  1 +
 drivers/thermal/st/st_thermal.c          | 24 +++++++++----------
 drivers/thermal/st/st_thermal_memmap.c   |  2 +-
 drivers/thermal/st/stm_thermal.c         |  8 +++----
 6 files changed, 58 insertions(+), 24 deletions(-)
---
base-commit: c75962170e49f24399141276ae119e6a879f36dc
change-id: 20240518-thermal-8f625428acf9

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


