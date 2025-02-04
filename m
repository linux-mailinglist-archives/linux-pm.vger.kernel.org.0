Return-Path: <linux-pm+bounces-21335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D59A276AA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A46188318A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6D215181;
	Tue,  4 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaNux5v4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560921516A;
	Tue,  4 Feb 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684862; cv=none; b=C2AkH69OWE4B/D2sRolCp94FMap7p8Jv9+sNtlZOEjIMQM/Gs2R9tgpcVfK8biptt9eyORMQHwG+Ro1Ww4OnOhUPYmv1KSVaag0G9KT7akS1UtaWbrVRPozz8vDWXhXsTr5tUssCteq3O//d4jRWUJGriDn+RywvesOBITBNChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684862; c=relaxed/simple;
	bh=Furu2lt9uFeqrf8T3sXnWVfXz+v3n5LkreeZicTFjBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMfbPn0DlICNyZrYyQVw3ON0b8/YxuZLg4omUPqHm2fONUsdXPZSU2CzXvXLlRatv2RNahRFMUgPkZQ5tJZMvh3nGuOfv/A4ja/gCCd6AjHW0FowIiEvroTOIaD43chtsu/CjauarK5x3WOf6DzOIEmvIYjiMfqQ31++E7LafiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaNux5v4; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eba50d6da7so1622818b6e.2;
        Tue, 04 Feb 2025 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684859; x=1739289659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwB+TD2uoxXsGIRkk3c+g+PhyM3yitZRLB/BrmohF00=;
        b=WaNux5v4tFtt2BlxBGjQFH3VPPOVDcgtTHbCc4LoIa0PiWq9sliWWbykgPxpvGsYOm
         /tCHDShNyGWcDz/Vc2RpElFo2TSGtNBTNadbS/o3qJYnyAGRdb5KPlHMm0XfltNfsfZ4
         KJvwZtpTaep0iVzMtvx/bmaGaN7hhnNG/pFZGnk98sgBpPireafxQM3NjFKEYxUilzu4
         o3S7O16107noaICTjfqRff2nIn1il3o6a+9/fQwHDZncoq57gWjkFudXAVs12x3mIWym
         RV9nMYvFLDkpikOPEWihesFIkwozL3hS4BBJxu/f3YcCB21fwdo6bosxCc4f1P0QC+A9
         EbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684859; x=1739289659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwB+TD2uoxXsGIRkk3c+g+PhyM3yitZRLB/BrmohF00=;
        b=IV+qfeXTx9SlOJa7Yd/s/2bRJi20BnIX5ohp444kaMDQALX7SOwzox4OAlnqoqv2Gd
         xUf4TTYg2obUFhXSTCO7mgBv/6u2Mw4VuBUK7Ki6zVUsUPMzR7jkRj16x7csJhEngdpI
         na7BN/HhBnOkjx60jVfG93DPXRgbv3TpScLT2oYS5+q7g/pI0xBQuutdrIIMt1tAx0q/
         uD3Bntrd3bXS8RYZSIeTznbCjVKtXOgdOB0P2jRO3DX25QgbjOEJN+3fV9MgCU/nX7zM
         stzqhLZQtxTAh7zKkbz1+b/r3LnKng9eIUEwCXaTpE/0cxr+rEjWnhNltE6WSLLY5Ztm
         5oMg==
X-Forwarded-Encrypted: i=1; AJvYcCWVvtp/xwjoAh/P4Zwy4LEC+vrttLAa0aIv68+olwL7K39LMqfsMKkH09IBOKsvACHWuXLx8heT+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgtOFEIGDQqai1xudQATXWctKndk0JOx9nlpaF6tm7m6tSE2X
	UM19hYDEK4IE2FjrexVMJhmgqTqtETr14o8ZYQ8/FoaoDTlm7v32
X-Gm-Gg: ASbGncs4QuVHrqOIPhCTfQHcsgAsOJH7S+5nVaDc2FeCtloZq6qJLn9Mtp14cgbCsoM
	W38EL9CvG5H0sGZ8isXih2bNGauUn6gaEPeyBoIanlX9wDGs9kl9DwYKAJPuN51O0QUeOgDrJBF
	uT2rRkMs3yRscWm0y1sCTYMyTKvPXnnuVcTO560o0s/r5yCi9SjH0VsrCqnizXVQhl1wCK91Var
	J3hRcGxt/vE7nebhX9m7JsRadsSbOKFjotDq/2H6s+omEx3N+w+vcUXvdz99muro7mixwYleMwx
	3st6ujQyKxugPm8LAOx5gPofYQ1cfocdhdg=
X-Google-Smtp-Source: AGHT+IG4mgrK9AYF301+xT8ZzvYHAcpmGDbS9oWwv8egYLx1PyvAQb7rPP28umrB/ztOhC7oqyDOkA==
X-Received: by 2002:a05:6808:1b99:b0:3eb:6044:5a85 with SMTP id 5614622812f47-3f323a76658mr18318485b6e.20.1738684859129;
        Tue, 04 Feb 2025 08:00:59 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:f8ca:b029:fcc5:5836])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365be86sm3039570b6e.31.2025.02.04.08.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:00:58 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/4] Fix RG35XX Battery Charging Issues
Date: Tue,  4 Feb 2025 09:58:30 -0600
Message-ID: <20250204155835.161973-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The Anbernic RG35XX devices sometimes fail to charge when the register
for the battery temperature sensor is set to the incorrect value either
by user error or an incorrectly programmed efuse. Allow users to
hard-code if a temperature sensor is not present (which is the case for
all Anbernic RGxx series devices) to prevent this issue from causing
problems. Additionally, a bug was identified with the handling of PMU
faults while this fix was being tested.

Note that the MFD updates to the writeable regs are required build
dependencies of the battery fix, as it defines a register that was
previously not defined or writeable.

Changes from V1:
 - Updated cover letter to note that the MFD updates are build
   dependencies.
 - Removed patch for "power: supply: axp20x_battery: Fix fault handling
   for AXP717" as it has already been accepted upstream.
 - Simplified binding documentation with a "not" statement.
 - Corrected writeable regs in MFD driver.
 - Updated comment in driver to note a correctly defined device tree
   with a simple-battery node is required to apply the thermistor fix.

Chris Morgan (4):
  dt-bindings: power: supply: axp20x-battery: Add 
    x-powers,no-thermistor
  mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable  regs
  power: supply: axp20x_battery: Update temp sensor for  AXP717 from
    device tree
  arm64: dts: allwinner: rg35xx: Add no-thermistor property  for battery

 .../x-powers,axp20x-battery-power-supply.yaml | 20 +++++++++++++++---
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |  1 +
 drivers/mfd/axp20x.c                          |  1 +
 drivers/power/supply/axp20x_battery.c         | 21 +++++++++++++++++++
 include/linux/mfd/axp20x.h                    |  1 +
 5 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.43.0


