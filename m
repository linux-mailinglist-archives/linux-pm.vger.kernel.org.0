Return-Path: <linux-pm+bounces-40612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F2D0F660
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F31D03033F86
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02CB3491E8;
	Sun, 11 Jan 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buV9a9rc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FA3033E4
	for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768147669; cv=none; b=nf+Uex3xH2mB4wLMD2c94QFOvZXp+byHta8eqlJJ7Q22qn+EdD+V5dEBqoVFXZldTHDgQZuGiFhG9H9up8HLVeIb5jktdj9gt0ed+UG9hi11QCHwZ1pemOOOwpUdl83lM0gN8FfO+uHFuETIUwgl7WtQHxQgiYB0PAsnCH+ziPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768147669; c=relaxed/simple;
	bh=AjihE1tXzhMtiGfocyMzLC0q603Ldg2m0mAOz/9hnmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBZhO9Yp4EgNb7HA3V8oblsDpSXLDEs+I4dxfv/K/hee9oaPTknRfsgObabkpp6oBN6++OCL9y1sWn3eFaXKIrqWB0NskH2xwaTBEhh738rb/dL6KhjcbUml5EylqrVJXujSvUZiJqE0GxeCawSccQFPEUnzbxYyvhkIVxhH+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buV9a9rc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f3d6990d6so423168b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768147668; x=1768752468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6SdMvLD2sWx3FTJPBUP8cXTdbOmBvwbO6CGnoPJ9/xE=;
        b=buV9a9rcxZSEaAX1+fiGMiQvdFNDR5vz0P+38K289+tTq7tI/QZTMvme9iZEXV/QLX
         +/zFaOSkRd/zC7AuOYVb4sS4HtD+Xi08zpybxlD+cqLIcaaFwDYfgCCOfC6A5n5QgsCj
         tCzZrQkwP2plyPLzet7VqOXJa7hY8DSpxPf9heafo9ioAI61Gil+M0ZnH+6WCw8drmwJ
         EhWE700afaDHcaSNz3F3g0JoF+Piq0cxYd/RjWWaW8zvzYiEkyMv2MiH8v88M1TpgWja
         ZaYjrCmJH5LFvEJRWJVxgQ8U9eLLOyS1j96EaebtrG8IkEK5d5auXTK6d3fLO6EKIsBd
         Lu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768147668; x=1768752468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SdMvLD2sWx3FTJPBUP8cXTdbOmBvwbO6CGnoPJ9/xE=;
        b=Jc0nvctU3F1nlCtNaV8Rf+rgjeuDUi6BqXJFtFDd2x9Q7UXJ4s0sTCs06iN9eBTQWp
         91ua63RgAtmzEw52hZ3aaoU4Oj6wYYRSkVa69IvL59YEnXLbCLdvB2TI6MKIEKk2N7Cb
         uchaBIG7K5xRSoDrDxRdEuwkllAHFe5q3ioHCVl3BDtAFYHSGaIZ8gX2FFvwSAQXG0Jc
         S4fxXs88VYQrMVz33OjWr3gmUL1EXLdBD5zwkiUfAs3DJJf91nT0+PRd01wlvatvqP7x
         adrF7sPd0u0Rnsd1QSx6/u/aXatu/8DjXWfZFurK+M9kA29KUkibMdk33x3AeKiKzG67
         gr9g==
X-Forwarded-Encrypted: i=1; AJvYcCV1yavckAr9zt3FcuBlDiPbwMpr6jmbhxrEMdn6ex26YlaYurBoTSZC6ET2/bHAiAtHZlwjAf4aqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwRllR5yEcK8FFEpcqgflRSFZs1J5SSj91nU2DwAv2+qrHEAI
	iQM5zg00K7To5rI2KzVpKtvkwYqk12tG1nuB1vdC51bOP23Gm/AbhJgZ
X-Gm-Gg: AY/fxX5joNJU+bLHipJbXOiOKsz+PwLWElF9svaxVF77iSL+qgOBLz55WePhfMsMa4c
	Z8OMcYKlQ/mFAa8Op6EciTSCFwIRuLuNMnWMtICxlrEA9XoPqbQV7AxSK+QoD3KthAMYMxP5CuF
	eO8tq6EqiYEPfMhespG36CBEErL36KLsBeJmt0kF8BUcowsYQOc5VWBWrmiSZGb4YQxXgZwODhZ
	z78ItsdRyxoQ309jiMkUSW1H831W/NIFiP73dN8l2UgjVw75Xo6if0nHO2EovjwEAVZ18o9RQnn
	4JMxlm0JPM3IXJvKA6RtQig/PexidRNBabf2Sv1Frc2ShVYXK/xIlskRuEwAMvpi8/EIyj4mhdA
	ctJrIWCRJhRHk/nLOWUr1dtHBOcR+WWjbPlKtrTuY23aDGU//7b/iOJ0AKDUhj24kJpvq+fZo/9
	gD6EnSQA10BEw02sc=
X-Google-Smtp-Source: AGHT+IFeGRfRn7ouHLko8LqNscZovYZVIkQrQga3ciBBylnW6APpH0B4WhS4MXya8AuNydrIc8BrDg==
X-Received: by 2002:a05:6a21:998b:b0:34f:a16f:15ad with SMTP id adf61e73a8af0-3898f9dcb77mr15804077637.53.1768147667639;
        Sun, 11 Jan 2026 08:07:47 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:df65:ffa4:d9b6:3e58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5c66sm15125986a12.24.2026.01.11.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:07:47 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] thermal: intel: fix typo nagative in comment for cpu argument
Date: Sun, 11 Jan 2026 21:37:39 +0530
Message-ID: <20260111160739.15984-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "nagative" -> "negative" for cpu argument value in
comment section.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/intel/intel_tcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index b2a615aea7c1..ab61fb122937 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -172,7 +172,7 @@ static u32 get_temp_mask(bool pkg)
 
 /**
  * intel_tcc_get_tjmax() - returns the default TCC activation Temperature
- * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @cpu: cpu that the MSR should be run on, negative value means any cpu.
  *
  * Get the TjMax value, which is the default thermal throttling or TCC
  * activation temperature in degrees C.
@@ -199,7 +199,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, "INTEL_TCC");
 
 /**
  * intel_tcc_get_offset() - returns the TCC Offset value to Tjmax
- * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @cpu: cpu that the MSR should be run on, negative value means any cpu.
  *
  * Get the TCC offset value to Tjmax. The effective thermal throttling or TCC
  * activation temperature equals "Tjmax" - "TCC Offset", in degrees C.
@@ -224,7 +224,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, "INTEL_TCC");
 
 /**
  * intel_tcc_set_offset() - set the TCC offset value to Tjmax
- * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @cpu: cpu that the MSR should be run on, negative value means any cpu.
  * @offset: TCC offset value in degree C
  *
  * Set the TCC Offset value to Tjmax. The effective thermal throttling or TCC
@@ -267,7 +267,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, "INTEL_TCC");
 
 /**
  * intel_tcc_get_temp() - returns the current temperature
- * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @cpu: cpu that the MSR should be run on, negative value means any cpu.
  * @temp: pointer to the memory for saving cpu temperature.
  * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
  *
-- 
2.43.0


