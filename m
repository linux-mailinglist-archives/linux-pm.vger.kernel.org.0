Return-Path: <linux-pm+bounces-10590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2692721C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5601C23E52
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855E1AAE2D;
	Thu,  4 Jul 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTjRO2m6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806071AAE0F
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083144; cv=none; b=uxKC7K8i/HVdE0hgFTIgl++UM4RzwCgUZE9abneDfJ9h3Zgg30HJVbuhqwnuHXm/Oa8n7CugcZyJ5teHItLmM46NxLdXIidqpwv0iAwvdQKIwnAfRrdgcOhIgyAB1XSAsYM/Wg9GhJ6lH8j+QB2AsaD8NWuvgnyarfedxDnz2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083144; c=relaxed/simple;
	bh=msMUHdwmfo/xfcbLPfmoqnDcJZxTp37M9X1aU/HHt64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GWJuVQss3P4si8Ghlf8aqAzcRTqvoQK/qsuElAuw5wjioLMSDxoTBZw0j4q9YhzIn+2vMbnya5xXE9rnEg3kI8T6a739+567YuxkFnNKOX43lUBo6l3+1jh+rF0T9NaVQ2T/CWZoBrav98o6sBy1/Vo5I3EYWDcn8Xqr3rwpj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wTjRO2m6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso2559605e9.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720083140; x=1720687940; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owtkn1JZViROHRyq0OPRHeVCIxCBljvpg/PQP6ulIbQ=;
        b=wTjRO2m6HT7SU/SJcir+JwmX9khT4JEBG8CqXQCeAury5jHUufSIC3VqtiLxVFhZ8M
         /Ol2WqhAJoOhbuMw2VgE7EkcbWU+cD1IjUTETFPrxRYvo3s3S4QS6ZKZrKN2k70Ixa5J
         8ET13de0XYWMdSvvMpk3J7MVuMT8UgeNl3FCRPczXRdlQhsGVR0B/TPnV1HMRBVBK5Wa
         4syTKjN/zwcngejdqqZpV3UMtv8hix7pt1mCnLLf3TXrJZqLVFn4TIsjNvrjHrwbioaK
         9Rsh2gq3HVze2C94f/+MxnSYr9kI4OIzOa+EJQrjF5YPYxy9JUToDThZMRw6r74SJ72+
         RAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720083140; x=1720687940;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owtkn1JZViROHRyq0OPRHeVCIxCBljvpg/PQP6ulIbQ=;
        b=XKYtaLwAU1fdFoIQ+Zt6ccD5F0nQ4zQDiOXhFXaBmx3kUc+PO0OwCRzYQS1d1owRnc
         XzXbzmjp6SQeRHRaUeuYKs2/gMmJ+XOgUB6Ff3IYajms0yS3T+1rAc30AZgTo3cGhdcY
         iRGwYDo2YgZS+smQB+8IUlrHiO8xhxlxg9uoZvX5Wsy8az68X1TOIBmqEDGp+Seq9XuR
         YD+chyqHaZBVIZQk1V0wLGyul7Z1YBZJF85QSmTMROVsSb0BgyFnRqsmQ8/0DcWBK9JM
         tHw410G/wHx5mnmOAyrERs+u6MZzpf2Ye0sQdCKKOQBQYbkfiBfCnnt5YJVV8o7TRE4o
         OJvw==
X-Forwarded-Encrypted: i=1; AJvYcCUfq6RWLF0t4x8CUyny6lQgptCVwD5Mh+lCadAwiNP/+jOfIbqbpO506VSQcrII6ATIoGHQJJRSy+lYBBJ+GIWGHp30Ew/5Yuk=
X-Gm-Message-State: AOJu0Yzw1HegfS7B2T6ZgMce/PhaZWjigKq9EP6WyLUS4h25jn54tQ5M
	6UxnGszVtXwRyHTdWU3TeYemHlNegcsJo2jAREZrthW9i6Q2axlZCJhwNDfBeB0=
X-Google-Smtp-Source: AGHT+IEKfbZg35nXOhYy2lKG9e+Vhb3VIC97OxLgHXyJIZPolH1wsLGFTnb4R/XR/J0+8n9tMHcb1Q==
X-Received: by 2002:a05:600c:6a99:b0:425:68a3:f6e0 with SMTP id 5b1f17b1804b1-4264a3d692cmr7479305e9.9.1720083139646;
        Thu, 04 Jul 2024 01:52:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f23f9sm14773225e9.26.2024.07.04.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:52:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Jul 2024 10:52:08 +0200
Subject: [PATCH] power: supply: core: return -EAGAIN on uninitialized read
 temp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
X-B4-Tracking: v=1; b=H4sIALdihmYC/x2NQQqDMBAAvyJ77kIiNpF+pfQQ7ap7SAybtZWKf
 2/wODDMHFBImAo8mgOEPlx4TRXsrYFxCWkm5HdlaE3bGW861DXziCX2+93glosKhYgT7zgE1Tg
 LKsWM+sNvkITGe+tc7yxNA9RoFqruNXy+zvMPK2zxZYAAAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Rhyland Klein <rklein@nvidia.com>, 
 Anton Vorontsov <cbouatmailru@gmail.com>, Jenny TC <jenny.tc@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=msMUHdwmfo/xfcbLPfmoqnDcJZxTp37M9X1aU/HHt64=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmhmLC3GIAm/IY+flJvbi3VHvb6P9YrFTIq0uMMYEf
 VBSh9ySJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZoZiwgAKCRB33NvayMhJ0U1JD/
 9NO+kScylVLDMfeKXVFP+OUUlVeTPI9AZGbf4DxR5mqKt9zgrQngmQKMv53XR0PkQOHa+VliOslQvV
 vRazmjM5Sr72dd2yMPruHs9hvLCCNB63+W0yU7V13js59lgzuUnOAQs7o/zsqwMHxPPGbkYlmIFHqk
 e6kx+8WM50gNAI7DW1z223hpYE8ed8O9qGOXHIsoNIJHESwi5/6JG4BdwQNXBwm9IovnmMBVVn0Y4e
 pKS8mgFUjxeKuFvQUvXNDQhWmX4eS3vZ5IhJJQV/54hxCdgfQufaaHpuFfcQBxfFWRyA5MZxZewn6t
 DGWSqeeXgjeMu314yqJpA1QTPD8LyKrH+nhfhF0PLuYLpHKgxMhmGnqCpt6/AhQDgXhCvhEy6IuCK2
 onrhCBv4pzj1d+8SGtkL8HHjlBAXaYcVphHtGrCbkRTWMcx98CRMQy8jWkDD7SVnuuV+OTZXPbdthB
 S2q6hfV63oB3XYgqk1jjGpn2/TMd2G5jR0q8QZhm8stzYHpQvnlfqDMwQYxeENL6kMm/Rptrj3nScF
 KA/79i3M97SGCKlS0lBAh7v918HYanXAKbYtdbW9R6DipWUodg6XMwjzt/XFll4+PmQB+XSrYvY78T
 Sz2sJ0qbQR69BYcNwe91BPT2wnE7qCpdCMHF24eJyr7ltLXsnlfztNsn7Tkw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

If the thermal core tries to update the temperature from an
uninitialized power supply, it will swawn the following warning:
thermal thermal_zoneXX: failed to read out thermal zone (-19)

But reading from an uninitialized power supply should not be
considered as a fatal error, but the thermal core expects
the -EAGAIN error to be returned in this particular case.

So convert -ENODEV as -EAGAIN to express the fact that reading
temperature from an uninitialized power supply shouldn't be
a fatal error, but should indicate to the thermal zone it should
retry later.

It notably removes such messages on Qualcomm platforms using the
qcom_battmgr driver spawning warnings until the aDSP firmware
gets up and the battery manager reports valid data.

Link: https://lore.kernel.org/all/2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org/
Fixes: 5bc28b93a36e ("power_supply: power_supply_read_temp only if use_cnt > 0")
Fixes: 3be330bf8860 ("power_supply: Register battery as a thermal zone")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8f6025acd10a..b38bff4dbfc7 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1287,8 +1287,13 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 	WARN_ON(tzd == NULL);
 	psy = thermal_zone_device_priv(tzd);
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
+	/*
+	 * The thermal core expects -EAGAIN as non-fatal error,
+	 * convert -ENODEV as -EAGAIN since -ENODEV is returned
+	 * when a power supply device isn't initialized
+	 */
 	if (ret)
-		return ret;
+		return ret == -ENODEV ? -EAGAIN : ret;
 
 	/* Convert tenths of degree Celsius to milli degree Celsius. */
 	*temp = val.intval * 100;

---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-077166861efb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


