Return-Path: <linux-pm+bounces-24993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B73A820C4
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69FF1BA501D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DA325D206;
	Wed,  9 Apr 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IP7Wimv0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0151DE3AA
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190006; cv=none; b=AOZvCpUZzyP4n8mVTjs5WpeeDd1fWdWRIv7CKRgmOzdEPxdQVm5tnjUpCVufW9Rj8U2rFaayCd48+kOXt3zssOxIj198eiUJGs1g6ZHpbdCXYCmAT0A6H8YDNUvNnCNfSKpGWE/+iLEF5LIWcjCsYWb7Pa4p0mkXfuJxbPo1W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190006; c=relaxed/simple;
	bh=w8jM+kjNpQwYUHFIVj+21LsNdXWV4iKMqaSnGVehs7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZPM5dpE937dnzreNZO98NZFTxn0QrGRp7YXcyC1GSHCI5uv0px6mos9525S4z3+aeVFNnnLp3zrKRhg5Bul6NDx5FODCvVVEEx6MtFObVP+nPNpNYKl+aemYQdjlYqZA4PfumyLFO4BAAuSkV1PtmEXPAzmoIakDWqP8agVAVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IP7Wimv0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so4417985a12.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Apr 2025 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744190004; x=1744794804; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BaNms8AAHYU6+Lu110JwWuCHuNcKevGY2uAR6UWGQNE=;
        b=IP7Wimv0+4lMP02bu2jDuBGVXZS7Y0PuCUYtYQeKWoEvcrAeFQRpmnubsCOhcIHL4u
         R9G9YZq5lwvDEMELvAWCQkokl2aS2fKt2BUaQnPXBlaM+GJ2YnbiJw85X9FhLXuWyiMT
         f85gli5YSFazGR4wFm6WTc9hhjR41Pvg6Cey0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744190004; x=1744794804;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaNms8AAHYU6+Lu110JwWuCHuNcKevGY2uAR6UWGQNE=;
        b=mXF6c2lQt5htqHqnPrObWVSE88tMen+yeE0H2Vm08L8HoiBSWEQvpe/CnjvHYpwUHZ
         HVtC5K86OAZcWeNwU3sCoMqqIyEsF5xGPX9PUAfs37YfTjxyDGDwKgB7+XTaQvuP6rAZ
         4yFw7KMG0riQW2m65JOh/YTl0LPEksK7wdWOAMcrvLxM4gbA3xCqmlB5n9KrX/6UqosN
         Z9X9ZchU1BH/8Mh0sR35OUd8v391vyHv8wMnWpsYQflFhVmwkFWrErAk5DHG6o+cI9Rh
         gnHR1boaqwVoH0ei6KbMpOZVQDPHilm7nlZNjgewtdgO8aQfewWJKzskGLy2HNcVDPou
         I31A==
X-Gm-Message-State: AOJu0Ywvolm3gYjWhMclbo6qEEBtVbF9ivcTiVwJKKNJ+do3TGyjiMm0
	HywA28WQmnBZVcUGtcgwAhl6jBk3PG/TuYstRuuTS9vzZlgx6ijU7tiqx67cMg==
X-Gm-Gg: ASbGncuVK4vLQ9c14VCtCMlxOouymVnJme4xMZ0vFxJUok02JuH6AOcFr9nHl5WLl0v
	vCGvhHiIVAjFa9AYD0ZiP1vSY9mSg8RZnvoyMjzd1HHmnj9J/WgxB5ba2tYtjrh33dfHUAIJbMV
	4kQlA3PLHcakBd4LoHS3ZzDY2Hespqdox2Qt4I4tB2rmTfNomtpGqHqu/LlqdpjdiHeriy514e1
	CVQ7g7KmBibdEy1MK4uDJVxrPR1xUOK2MHLpQedgHbzWWdHFnbqhpMfufbQw429DWFxvYRSR0lP
	uz0F5jEawFD5zGt6Cw2n5yk4RgVKoxqZKYOiJxuqSLsFbG5kCyWUt2kE/akHUtezoeqfIR4QD5l
	MuwV7Febc6B2UNxFKe1bxnfK9Kukl
X-Google-Smtp-Source: AGHT+IG2BgqZHSIHI8aYAkVrTJn/SDbhHGgzVIz93kwK2lBJoxcfDzl64PMZYZKZH2NJ1T9ptVPhUw==
X-Received: by 2002:a17:90a:d644:b0:306:b78a:e22d with SMTP id 98e67ed59e1d1-306dbbc2ce6mr2970209a91.20.1744190004299;
        Wed, 09 Apr 2025 02:13:24 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (95.147.221.35.bc.googleusercontent.com. [35.221.147.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10dc40sm1182551a91.9.2025.04.09.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:13:23 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 09 Apr 2025 09:13:11 +0000
Subject: [PATCH] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-temp-v1-1-9a391d8c60fd@chromium.org>
X-B4-Tracking: v=1; b=H4sIACc69mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNL3ZLU3AJds9SkFEPjxBSDlKQUJaDSgqLUtMwKsDHRsbW1AHYO/vd
 WAAAA
X-Change-ID: 20250409-temp-6ebd13ad0dbd
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

When userspace nonblocking reads temperature via sysfs, EAGAIN error
returned by thermal driver will confuse user from the usual meaning of
EAGAIN, the read would block. Change to throw ENODATA instead of EAGAIN
to userspace. Also, ENODATA more accurately reflects that data is not
currently available.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/thermal/thermal_sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..3d1713e053dfb867933d95131f1f2491d2ecd07e 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -40,8 +40,11 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	ret = thermal_zone_get_temp(tz, &temperature);
 
-	if (ret)
+	if (ret) {
+		if (ret == -EAGAIN)
+			return -ENODATA;
 		return ret;
+	}
 
 	return sprintf(buf, "%d\n", temperature);
 }

---
base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
change-id: 20250409-temp-6ebd13ad0dbd

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


