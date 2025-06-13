Return-Path: <linux-pm+bounces-28632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339EAD83EE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB451899F75
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53428ECF0;
	Fri, 13 Jun 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWo3182/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFF28EBF1
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799011; cv=none; b=qvWkQtXFcH7qIPA70DEPiyuXwB81lNhXecbmou+B6rEEVQgITe0yZl43F4A5NkvM3v8udGcdvMKrSF0kEvFUyu7N1khOJMQiTPLYj9P7lmskwh9yXp99cPd93Z2gSAoEKP8S7kj0xIOGOetZIboFlfBuBhY4k+lm5Fw+l8P/+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799011; c=relaxed/simple;
	bh=ikGB3PaPKDJ3MFxbiuFsbOiaKxZREXTcoX44pbpvZpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+SsfzLIpkSeR/6ld50q5qGAPS0BiroOTA+fbPHqHJbmc1l4Qelh/Sk4WxPq05DMue7mbzgCcYjRQs/IRVrNOrrmQZHelbilKSXfrYtzA+8ysPxMQvitlbN52z3uyoc/K3Q5hY4p6h5yAjynCca9gBy/EEZzBxfpELwzh79nZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWo3182/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4531898b208so1914725e9.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 00:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749799008; x=1750403808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fv69bovuvm+Pb08hvzVs40FNmn1nR1es7GqKP5snc4=;
        b=PWo3182/UzV++eyAJBwPiOs6BRlQxx1DcMfg0/N1t2kccEkL/lKGob1b654vMDrPFz
         UvByef1bfo6dKFy9Ib/UhIkE8KodMpCPph34Y7PxObepKmOY6e/3Ss9qJAAYXQeV/w2t
         uZpi0o5HwyK87Kj9eIbiPe3kk5w65L2JmvN2VN5di+ZNTNTSj7inI4koDq2JMnbSoBZV
         /AI/zrNdrdEr/o+/k4y68WqP1NPpNXH5OyK8WEX0xr53PmWHDMgxK24WY0JMNOHTSOX0
         s/0QBd4G0xRSV2U/DEjmx0U2p796W6tbz/A0i8Gxn7ROrPq9Da94xxzTPqLKxzmczyhH
         +mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799008; x=1750403808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fv69bovuvm+Pb08hvzVs40FNmn1nR1es7GqKP5snc4=;
        b=i0ulZvRETtWZp7IsfLBlQrMWC5Xx/T1puAL+SFEHvAQ+JmnSKikmdw6aSYKlh+JFEx
         77nhQzOW1ouSWrkDdRoo+GkTmZZvha4VwFtBIKa8+6CMiXtY2kAV73zzjlIUPbNt5//7
         Gh3iF1aJJJKcNz42ee9ZvpgPLNv0OcdMhMrmeG8lS+RQ8OMnj2lV8+3LatgTKKgdyMOw
         4tkIKPJ+j8P43WIwd1Oa2yHzs3yVU4lPiLFhrnEmypRaELZO9PQn8OSY/HAXVtNSBCUT
         prFyisNiW2O1Y1/lZm4DIRwZPlsDT4NjhI6NoNLcMLtEbdMBvny793z3tyJ0l2VRd8tB
         BGkg==
X-Forwarded-Encrypted: i=1; AJvYcCVqCgELj5ViJ+38Iw+8NentUe9a+CDfcSTpgkF6zRPsd8sbgEv2K0sjbna+Lv4edKJt2PQBW+FgSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9z3U8IaLjpoP7uBEaJLXJ4VoX4MM/RUIhso0SnprD0ZKEoEj
	UVUM7FfAVYXA5blgOh82Q9/pfYRQnRYbROQGmQ4m/zzH8uWACX5+WGpq3QvGSmfqqes=
X-Gm-Gg: ASbGncu409GnD7kjMw8v7FUTiiPtmI/XtCTQPlLLA44akvqNVvGeztCSb7c+obDmlwM
	lJrOVuraIpPtQA9BpsxNwH8wct6XAjiFqNrDX2t32aQIkM5TJF+PIZ54Ch7x4mIP8wPWbwMmAS6
	34elUDstu26yyBlvCxhpMh3nsvyj/tA0FLzEUHXNKGjGnWsDUEuLy5xciVefZ/Ow7AZMDB3+Mo/
	kQBBTmbVhfYjLHpFGs4e4SOeE+Yg2R9IHcPE8hI5HqhO8n5KB0JqF2XD3g5bXMvYJn3J7iEK4lu
	O0AEnLE2G2Dm2OcrUIRhyENwVdfFk7VqCwAM52qaVtEa6zqvpV6bv8tyrVnF+ifjzhZ5lP764A=
	=
X-Google-Smtp-Source: AGHT+IEouw2NsfDahsieU/ds8sAFUKZF8nkQYwWmiRsIPTzuT+5LOlyePYyXZlerd2b78gEPXxyFXA==
X-Received: by 2002:a05:6000:310e:b0:3a4:f7ae:7801 with SMTP id ffacd0b85a97d-3a5686b97f1mr502671f8f.8.1749799008387;
        Fri, 13 Jun 2025 00:16:48 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25e89fsm41966305e9.33.2025.06.13.00.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:16:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] cpufreq: brcmstb-avs: Fully open-code compatible for grepping
Date: Fri, 13 Jun 2025 09:16:44 +0200
Message-ID: <20250613071643.46754-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=ikGB3PaPKDJ3MFxbiuFsbOiaKxZREXTcoX44pbpvZpM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoS9BbtykD5yvYSc3IHLEdjE6QZ5fdc7hdJcQrQ
 XkjcMUBVBCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEvQWwAKCRDBN2bmhouD
 1wyTD/4tuGyG5NOtPnE74wIMfUoYOtAeELKZqjvXWwUylioml49Ac0Qh6ZwPIaOu6U7ixm1CaLX
 cvHcPSpQYap42DayHLhB2urDzc+vx/ZVB5gOf9anqtvnNYoozDRjA8bCA2tXM345DT6pjpMNMpn
 yUtCamRrvJftoe0NPeSghpF/Md58mdCQohDIjUwLwMPdFqMFk33KBSrExBgRauwS+RHh/ftdx7o
 jJBk160pZbXfVhozDuUe4Lf6ldoDXrbIBKIYkHm6v5T2y5hrRn0QyerlUf7tQVPfTcjYpe5wV1w
 PAj+YEWvQ2lA/8hSqsYkjddLpbv/AEVYCK7JhEn6rrbYpKKBs0eB+fyrTq2BSH1N0pjReG7zjEi
 S8jap4jOZ07USJi1POvO9icL5K4I4VKfCaG5Ej4g4nl40AkOkdoZy7B/vP3YDv5wJd9HwB1V0cY
 hajKRVpx4s6zPVO6wUHcbuuXXh9ZrkExPtQ7BrdQGCAeIemdgWO3jM6VQ0DD0Fhl0yYpjnY9I9E
 2wNuPMjx7pzqVMRaMD4KyaOFu9L1tjzgaJThhaFI2KdshNVZs06kT0ImV/2RTSi7KK3mZSvJJoI
 jByr8SOdPhXJOwQKfCO23j8GkJ2o0cVlP6WPS+c3ji0LqqPcPTwUkgpEmk0OXDPLLLizpwUHRsy IcqefU8bvrtJjYQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

It is very useful to find driver implementing compatibles with `git grep
compatible`, so driver should not use defines for that string, even if
this means string will be effectively duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 7b841a086acc..5940d262374f 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -765,7 +765,7 @@ static void brcm_avs_cpufreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id brcm_avs_cpufreq_match[] = {
-	{ .compatible = BRCM_AVS_CPU_DATA },
+	{ .compatible = "brcm,avs-cpu-data-mem" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, brcm_avs_cpufreq_match);
-- 
2.45.2


