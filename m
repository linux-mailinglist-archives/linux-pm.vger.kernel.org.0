Return-Path: <linux-pm+bounces-19152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1A9EFD16
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFAF28AA95
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB21A7273;
	Thu, 12 Dec 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rlg26fio"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C818732A
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034414; cv=none; b=YEXGSoNJH7YHKjM6icQFPfqi/QNCztC7E62n/7OgEIeO/6SGlG6c79RwUgiGNxY13FVMCmr8Q0brjfjOuU88qveZ8bclGaTqKfKjlAwMLEyG0ht58lAWzn3eNQEJppRYdhnxu4dDZmWo+j8DF70dmKlnYoap71cnvQPVr2RUYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034414; c=relaxed/simple;
	bh=jh8JIzPDcDvaxnMiTYtccygjmk3pmlrbS8sl6s1c7Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHGoDpLx0s6+wFHF+v8CnnR5LM5pxfFmVPhMIDJW88aCbchEke1/uGSRwcaCI/UatJh2Oje47LLSNAn4dbObxgleJXsgLOIpVL1aiVaAD102WAqxOGdMEapooLgxRpxbzQf9nogPzNVq5JPJpJCEg0o/tRRdA83d2ZG7lvnR18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rlg26fio; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283dedso9687735e9.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734034410; x=1734639210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HPyEvm17GBvzoW45zFO/cFfcaMLUtMaXTixIZs2i7U=;
        b=Rlg26fio5M/UJkrm4oUFek0AkK7FXP0mZxskbev2Pf0b/C3k6hY+KcSl0sIi3vrOt6
         geAVwvwGuHM92B6O5PFL0mYwXivojq60RXLPsMW9cl+rFBH9dgauuKFjTrC6bJ5/g3SZ
         X22b1r7KNtNDx+S4G7sRrP8AFk7p3JPRnKRT1M9vsqO5lwRo5CHffoWgPy4/jjqyvMhk
         ppbX4XTj+dCWeUYSJ+XWpjbnoPCsJfpunyExI2z+4gF1MTAe8IsI6R/4Z/H9OVptYBzz
         w4ZvhlktDMtNPbChVFY1eLVP3K7iYy1ZReUJopcUb4RcksGpAzm87Ugm64rlznF0VTEh
         pyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034410; x=1734639210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HPyEvm17GBvzoW45zFO/cFfcaMLUtMaXTixIZs2i7U=;
        b=klTCKvWeVohbwyXbPanE53LFUiOkfUEE8xCtS26nJA/xeZq3DeuTrn3HN040OdTHNv
         9lBpqG8naDv38qRA3iZqdGhzh57l151NA7wYNasj2L259mK2rwV3a8OyBIDBAiYQ3eW2
         o/bFPrINRhHFuC7ErYryqjhBcd9wzwGV+5UoyiHwCbi7Evtt9fa5dS0y2Kgmb3F+8a8l
         ee2OWoVwQZpLyvTOgkXJZc6dr/P2bO7p5MwSqJqfh88bPaUNdrmf2A+lK9UNvzkt2YMC
         PNGi++f+m6juXi7ZTx9xM1wTVsc69vEIALujPXbx5ss3X8wlfU4aVIRR6kCQ/pfBZQ5/
         nmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD+oksILJ/EqK38ac0K+cL0hFwfVjKzrDyUYAbJTJNmVfGq2lY4aoNdHCda+jQVR9OkLSwPfP0og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6/7EYEnvY2rig3IYcxT5/LLWxNytvGT43DMTd9IupEmyNBkK
	7C+gmilOK8t/XtRMYI91Sxj10h0Nej6+oKvoqwVwdr+do5xIQ2cmSMZ9vGJlXw1+Lne1zwJwl7e
	HmymWoA==
X-Gm-Gg: ASbGncuRigRs8+FOiTKlfOna2f7VQn4bs0XM6g7NlgTVv+ro2w3NBgGsbJq7ufyUhGn
	N18Fri2SNG3DHiFihtqjk+LeJHbKKQrjTbBJfzoia+ZtRAxkdKJK+4Le3ZE7/OSKyVAvrVYS4V3
	mhvZ0Sga/FIoK1NuVowQ+W6Qr5CaSuiCaildo/Iz4UUa7p71uoTkIgHrfPZU9V2RsDShZQyXLXG
	rB5gK50jpw8aGid4vwGUoHN0fSGnXbor5hWP31lKPPL/0FYzp9r97rcFXELU7zJ0ngYAqFAgAA8
	ObaiOQA=
X-Google-Smtp-Source: AGHT+IFXQspiqBdmbRT6aNUguvteUfRABjK20wuypAXO3Cy9E2/nEt8aUJ7Kt3q0K7+56mw4GAzNNg==
X-Received: by 2002:a5d:47a8:0:b0:385:ddd2:6ab7 with SMTP id ffacd0b85a97d-387877b9729mr3711969f8f.52.1734034410444;
        Thu, 12 Dec 2024 12:13:30 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e600sm5039931f8f.7.2024.12.12.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:13:29 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/thresholds: Fix uapi header macros leading to a compilation error
Date: Thu, 12 Dec 2024 21:13:10 +0100
Message-ID: <20241212201311.4143196-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros giving the direction of the crossing thresholds use the BIT
macro which is not exported to the userspace. Consequently when an
userspace program includes the header, it fails to compile.

Replace the macros by their litteral to allow the compilation of
userspace program using this header.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/uapi/linux/thermal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index ba8604bdf206..349718c271eb 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -3,8 +3,8 @@
 #define _UAPI_LINUX_THERMAL_H
 
 #define THERMAL_NAME_LENGTH	20
-#define THERMAL_THRESHOLD_WAY_UP	BIT(0)
-#define THERMAL_THRESHOLD_WAY_DOWN	BIT(1)
+#define THERMAL_THRESHOLD_WAY_UP	0x1
+#define THERMAL_THRESHOLD_WAY_DOWN	0x2
 
 enum thermal_device_mode {
 	THERMAL_DEVICE_DISABLED = 0,
-- 
2.43.0


