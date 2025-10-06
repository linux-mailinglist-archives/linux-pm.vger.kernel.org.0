Return-Path: <linux-pm+bounces-35742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117CBBEB14
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33D3E4EB650
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3D2DEA73;
	Mon,  6 Oct 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMc9fMnW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA782DCF46
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769013; cv=none; b=ior2HrwNfjo8r7AOMQILlnv6kCry66R4aOjJCL6CV0BdhfXx++gSK8/LB9xyHdBwg4q+/yTgC+EXfxtZ5kbHA49b+aBLkmY8c3sedTRiRFwD9qKtbQLjdQgNGqPrFF17oyOFpz3yDQuX8Ao3/FkJDgy5+XftKOB9a8BdcHwGmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769013; c=relaxed/simple;
	bh=HMtcLDEIKjq6G2Zgr0JytIoIw9ewVlt1cHK9VF+l//w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+/hLsOWhLbNK/vR7Vj0Tfkh4Znp4ulfG1yc6oH1RmEKsVbGtgJ3eZO6Gic0CXQVK0TU076wvGBxHKpc5o2qZqWDzHEvuIGaIZX2q3CreTxm0H1lOzcrQB4Wvf3uuBCxI36XxR53YMrB7pmSzS0BpHbu2lrA/Vn0Jk9JLyHYH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMc9fMnW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1067488866b.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769008; x=1760373808; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKtphuJ/4di9yNIsz6yNlkrtQKgCMc1BLXd/ATWAWto=;
        b=tMc9fMnWJiszVnxWCzpauPGyIxTsvBolcKNfpM2X6yK1w79upYCSF4SuOdm78GkLbl
         8uTaAwDZziqJrKughTM1EUR7cR5ztBLGVBlcTT1iza5Tvt4l+ZC5ENf2pjHYvhqv3vub
         7Iqcu3KhnuCzkLuDSf2s+lARm11qdCUgqY2AjXic4HhKgHeA4Y48MkQ/S68k3kMbFoCl
         Ha042F+gF4iJ3wHFXtz2lMrFMWH38w+6JpSkqGIVYZTkrSwfK2+5h1dmqDUHA4E8Gudn
         eE+a/972ST2e5F01hWkVBbZR75stysD1C33NDz+paYOYmFYzBZuRLz1W386bsZ79QmVl
         7bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769008; x=1760373808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKtphuJ/4di9yNIsz6yNlkrtQKgCMc1BLXd/ATWAWto=;
        b=NSJeYl0Vims8a5F1b/ReGkoRS5dJMOU7AMoQ+M0EjevBuZHSdHuYhfIjer5dEoySky
         7++g9M/1DLT1p74qI2brq5SCgJnlMDkqXz1Yuim5AinhSuQA06lZEr+iNGkQppNyswU2
         SkVUZoLP3LB0pGhVjuim9AhDAlUWRIXoeayuCrihyIkKwKV6KgOfYhd/lyOTJM7yZYx7
         rDqX2lR7OEd+Zyx0fkqrMnDdgTPVVUZi61Yg1BErVkLzZZbrxehyXct4fusRuDhZHlZT
         jmpbhQ9Yh+wo9WUs6eibQqxlfXqHTI0MJcZ91J5WZG8G1f1NBdwjMUX7XcrsqO8TdiiH
         SAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdfTeqcN/B867WbXreDlL8q7rirEwSTahob8rW1VIZghNmDlo5HZuplq1asKyeo+uSAreg9JAz+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzhlu2aNo9qZPRCky3sGXdJHR4GYAkcdIAzAOSN0skG4e08Qh1
	XQaDL104F/QHRtXhngzmCJQmbjdnGy3FD5pdHry7J6vUnAmyegMyMDir859Z7wk0c1c=
X-Gm-Gg: ASbGncv+i3y7IAS0CBxzN/CeTOLTgAoy0l3o21mtxpGz+jsR3Jj2Ct3Bc1vOsyh+F/I
	lGZzcBVEK/35+JWYqsq/h7WJq2B7yD89FfTK9gDVM9tigQsNsrNzvrO7LUzyB5aHSQmPT1WSZ5m
	+4FNvKeMT9gk6SGDeDD/SnWmleHX9X+WNk7mWMA3F+chxiLLO+ygRSASwQ3lcEPlezGzji3D2nJ
	Bi+97r1umVwjsYlqol2/cDE0C2fWcudsmHhj0ldHqfvbsGw+ZflXFH13rcfAj04Q+IBCai/yY2k
	Jtxo++a56Kwu4f11P93ud251Yi636MHnnssTT5rPgHXPgZKlMeGlk/e/5eP+HBNvNDs3bsjS2jp
	Q5FwRbFSASw9JQmtI5kPlL/7sf3hhY7KfGLKppD90sgKYcv01JAhOIa2RhtG3H9Lc5cljJNU9ux
	G29RJ0j8c+8jRcjR/P/jyWuVNIOlZtiMG5CtAzo/kTpalbEFuPJD4=
X-Google-Smtp-Source: AGHT+IEH9sBJd0VNAAJtz9rRu8u+k/yXhel69FaA4JYwSprBvbLGJFT33oMJuv5fmnK6KbnU7ExmwA==
X-Received: by 2002:a17:906:7951:b0:b44:7c83:cd9 with SMTP id a640c23a62f3a-b49c47accbdmr1839696566b.40.1759769008357;
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 00/10] pmdomain: samsung: add supoort for Google GS101
Date: Mon, 06 Oct 2025 17:43:26 +0100
Message-Id: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK7x42gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3fRiQyBZkKKbYpKSbGmeYm6QaGGiBFReUJSallkBNio6trYWAAe
 OGYtaAAAA
X-Change-ID: 20251001-gs101-pd-d4dc97d70a84
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Hi,

This series adds support for the power domains on Google GS101. It's
fairly similar to SoCs already supported by this driver, except that
register acces does not work via plain ioremap() / readl() / writel().
Instead, the regmap created by the PMU driver must be used (which uses
Arm SMCC calls under the hood).

The DT update to add the new required properties on gs101 will be
posted separately.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (10):
      dt-bindings: power: samsung: add google,gs101-pd
      dt-bindings: soc: samsung: exynos-pmu: allow power domains as child on g101
      pmdomain: samsung: use to devm_kstrdup_const() to simplify error handling
      pmdomain: samsung: convert to using regmap
      pmdomain: samsung: convert to regmap_read_poll_timeout()
      pmdomain: samsung: don't hardcode offset for registers to 0 and 4
      pmdomain: samsung: selectively handle enforced sync_state
      pmdomain: samsung: try to get PMU (syscon) regmap
      pmdomain: samsung: use dev_err() instead of pr_err()
      pmdomain: samsung: add support for google,gs101-pd

 .../devicetree/bindings/power/pd-samsung.yaml      |   1 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |  53 ++++++++-
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 126 +++++++++++++++------
 3 files changed, 145 insertions(+), 35 deletions(-)
---
base-commit: a5f97c90e75f09f24ece2dca34168722b140a798
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


