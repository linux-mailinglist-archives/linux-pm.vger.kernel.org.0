Return-Path: <linux-pm+bounces-37570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85BC3DB6A
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 23:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1888C3A3EF6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6BC34D4D4;
	Thu,  6 Nov 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdvlU66X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F302E7BDE
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469981; cv=none; b=nqKmE5aVVINtKAnKOe9v74yN0OlxUy1cA8XM9sH07+fEnRT1lOexlodVVt9CR3U12frzy1JKYjRu+SFuA+UchAEz6SVjtdAukduTiEfFu5hwnIPKhnSy2w+0UnSU23NUEs+nB4A4AhvBXIXb/QY/iJnSAT7LVcmOp07CiQ0r3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469981; c=relaxed/simple;
	bh=iFfgKGXsxXqqbK/r1KQuykijR7+PTg19keFMmyCyV/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f3XIMLb46eIBlkWYwsjesbjB5NzMvRqmvU5bKKsbwUk2i+MsC7qK2wbzzdOZffv+31246miVNbONbSJVi9BzbQLmz0Pt99M6R3nMEobPANEEDAW5+y76jnLtQDXke+3AC1CnfaOmSLz3rahKQIJalBt1G1A6VNz1rQ14IvcKsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdvlU66X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477442b1de0so812015e9.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469978; x=1763074778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hi+9G52pGopoyYkFySoeof3Qn+i2cqX8N5/nDU8LmHc=;
        b=XdvlU66XZG2f0KbIRjcpkYjKyaWtcWqyh5F3UoI+Kw/2coHxWSUBYX9AfNMHLoQR1s
         /yDowRKhKIWZzi/ludKPlYzFqVCdjIKUcDZMeqdAKEXvABubvLjtoWPQL5ppEySF6/4z
         eJGMQK0FVuPLpGA0Nh7Mf34NkcvTFkvhNEdAPfjCZNIK9WJmgJu5JsioMHTSlFca4v/x
         TSGMwfTq/Wt/R3Ql9j9A54+Gay+udE8JG0ljy/axECGyWO7Eg2xSZVsmoHp0xld6jsdQ
         nMB8AnCzdLDw3/7QuAKhedik5mxARc9VZbUuKjnrY98hcczQA9hALocDlwmiww53c6eh
         djzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469978; x=1763074778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi+9G52pGopoyYkFySoeof3Qn+i2cqX8N5/nDU8LmHc=;
        b=Ac9N8NR4npbCgFw5sglXERjNRMUp2IgEOCBHzg/wjNXwCSXUjS/7gnBLXGvdiv3jwV
         5yYrSPPkZhKlkKrBbpGqj4ot//hFAYDCnhi72ApYC0o96XROUzUobV3rxg6gB9a2NpPH
         b8cfttcnP3XJcLAblqbjsbBIzSHJ4iz8Epm9qwmaprSq42VzvbINaedq3q1UKT6q5/Qn
         mdQ0JQg0WIcET1eZ9bBxlq/3pZfN2EIE/4LvgIZvaHcaAAtRqQwE6FL/h4SeB6pjvr/7
         Nr+uL8tLCAGIRLUDeCwH+MOos+gXYzcTK4F2Sl4gupDonX7En8i78PcNdXnJbkWXw2I1
         7CZg==
X-Forwarded-Encrypted: i=1; AJvYcCVFLCf5MZ0XtvBqwUvxG8i+H/tbdwrluKLjzUvKQeQKMslQ8trbTN8/rTLPDkqpdqYGTPR6PUN1mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDV/L0ZRxyY9XvSDPlsFo7IcI8tfgq829ctda2g2dw731BgoxH
	UV1MJJK8OiN8M50jdamPyOm343aHU+EiBNzIJJHXSqZDjbyFwt4hcIgI
X-Gm-Gg: ASbGncsDZGhmKYaIWkWNGkh8bPRhsOBbKpMQr6w/o7Oqh9mVol1ydl/HCUALi++eEKN
	8/aooLfbKtf51Ei2445xBQnNKkXXvkOrOZup+KcPkcD+YIxwpZN8BjPjKGcFX6vTqzYzIslUpqs
	tl32KPbz8y0efhe4yBze0Stp9Qx5RtcifaPHFLvHnYNglexqTdNxp3Y0eiRuQp+BF8Hg1j3ACm0
	2VV+a8XUp+TINr2BHqajTCHUIgLJaqQ55Wg8Suw+33MDoGZWP/Uc337qQpZySE8GC8305+d3DYx
	Cf3E2zoVDKKMbOxhgsH9Gp0vmIcRPh1GReUkxmm+A42MA8Bg3YT3USVoTk3v1rxx352l+RLAGNC
	eWrTkqDZEk08DOmCoDZ5QWTYF1tzP54PYW/3UdjctD9MXUD+/6R0dpJrkeER2RLkvvXDAm+0mvG
	OtPFYWGbcNtlNaBC6tCpWKL3OApGZ44g==
X-Google-Smtp-Source: AGHT+IENtlLcnvy44GLQGVYhK7qjs2eOpO1qdt6HoWtPgjvFNjDk1DciOd6xmPl52n+wvIT69vB/Yg==
X-Received: by 2002:a05:600c:6305:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-4776bcc756fmr7905035e9.41.1762469977539;
        Thu, 06 Nov 2025 14:59:37 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm1640000f8f.42.2025.11.06.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:59:37 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/5] thermal/drivers: airoha: Add support for AN7583
Date: Thu,  6 Nov 2025 23:59:09 +0100
Message-ID: <20251106225929.1778398-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series implement all the required changes to
support Airoha AN7583 Thermal Sensor.

The SoC dropped the Monitor subsystem and only provide
temperature reading. Some generalization was required
to at least save the common code with also the help of
reg field API.

Changes v3:
- Property use chip-scu for thermal sensor
Changes v2:
- Update DT schema patch to implement dedicated schema

Christian Marangi (5):
  thermal/drivers: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |  14 +
 drivers/thermal/airoha_thermal.c              | 368 +++++++++++++++---
 2 files changed, 318 insertions(+), 64 deletions(-)

-- 
2.51.0


