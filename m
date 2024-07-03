Return-Path: <linux-pm+bounces-10495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60C92555C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1311C223B9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24231311AC;
	Wed,  3 Jul 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDKXnheg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADC2C879
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995445; cv=none; b=reeK19caUuJ7r0LR0G5yOCE255g4HdXb/UGJmmRB5nADlcnInXDX2kZn8vq4QvFckliY7Cb/67BLt191fOfUC4iuKdDC9SpJCuA/ZmukyCZQ9dy5kIkkgIZR1EaqjapS4y1+6Ja1f7eAE1RU81zVu+ZbDWTkI61cqEx7jXgtaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995445; c=relaxed/simple;
	bh=kpSp09z9l65LGLeoiNxvNF9tKw48UToBsdik82/pzXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LC8skxbS8JPEkTQSImFWvQTIqLrfyBk/yyJFO8SoVTLV9NrAFvhCd7gZtFEk7Ac2KNUNeEM/y7jTilrLDIad/O/qUpz316fDqEd1HAdXzTd1cBocV2vRfSuoVq44+lrW3irxNU/rgugmNY2cAKJ1zPW6Hjyp4jCm7gaaOtJyda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDKXnheg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36742cc9c12so3324749f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995442; x=1720600242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDi8IaRkk+Cjp4SeIDuRWKdtZkOON6mpqHjWnbp/CVs=;
        b=QDKXnhegixBB0rRq5jMQ+O+9wOHPypYDiv2WXlORUmpQOHwuwv1KSyZelUA8VCR76c
         viwHFjtBBBs59yRX0sfssZtLsOkFTNGH1d/xH4GAxVhJ3yAOyyZhw4323wPEewS+Jm7B
         F2j1dry0tBb0YmmYkiQhKfr/ubW2MwQqPXrcJqZC44m4QpJXVvsNb2dd5sKn11u3V3RR
         teyCAvfBuHwa5LBhFbsjEwQWjhHK1hZ3MblOboE0EbbhbBzNKYHCBe2qO477OvDwN2m4
         M0xZdRpwCH1mIxs4MDheKbut+Wg+zAny3l1V4uelXrlBSuXB2gKoDZm4fOSqLe+9XFT4
         Eydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995442; x=1720600242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDi8IaRkk+Cjp4SeIDuRWKdtZkOON6mpqHjWnbp/CVs=;
        b=NTel9gNMCrpe2caG34tetaG0LShLK8F2A/mo/l0ZEiqkhjAJLwxupOVgFyY4o6TXTB
         k7mBQvS5NBBOH0JtOPkSfOgfObv/G14KQ840kr4rRZbLNLShvA0yAxeuOZhNPGbQt0UI
         LhZODEdrqB0n106CqAiKZrwOPCEdgGGAnk3atC2JVohMWne7O29Azk6o1XD7n8Ax32hK
         y/7V/cWsOfBAwkdw3Ue0as9qsy3PAmmwYMzEaPnnCgDyomrq2iBrJNTobRpOl9O/W+uK
         Mm4brjAAZ6Pjebflzqn7X78Zo8BSafZVDBIupFq65kVQaOvWV6+JGN69/BvFf1oyYTqB
         pnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdtNKVhXNlwcW7NaU/DdcbvmmmKcrGpCtXhT8WE2bvF5IO83c774pH+h905Robd2o2pceTqcUHamFxthJKUkzb2qvJK3cAtyk=
X-Gm-Message-State: AOJu0YySD/3kV2dPyPfMfYerj6aObinc2cyFgVOgSKpyiN5JzsGVcPTC
	mFXkQ1n3TFTleHRkvCtJGFrE9pKa/Vi/TjqFO2X8sQLWbR0X8tuDyDpykbE5jwsp0BUtuaN7scg
	hkt4=
X-Google-Smtp-Source: AGHT+IFmuVW/1p7lFLWxtwEKJATmACtFZc9wUEgKR4WTWUJsCZsXt2d8FtH8L/lbl9nCjbyd+7L/Jw==
X-Received: by 2002:a5d:6c66:0:b0:366:e991:b9ac with SMTP id ffacd0b85a97d-367756a3423mr6929835f8f.14.1719995442214;
        Wed, 03 Jul 2024 01:30:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8daasm15127345f8f.30.2024.07.03.01.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:30:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: sequencing: simplify returning pointer without cleanup
Date: Wed,  3 Jul 2024 10:30:38 +0200
Message-ID: <20240703083038.95777-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'return_ptr' helper for returning a pointer without cleanup for
shorter code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/sequencing/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 9e606c9f6f04..9c32b07a55e7 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -687,7 +687,7 @@ struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
 		/* No device matched. */
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return no_free_ptr(desc);
+	return_ptr(desc);
 }
 EXPORT_SYMBOL_GPL(pwrseq_get);
 
-- 
2.43.0


