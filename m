Return-Path: <linux-pm+bounces-29158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F8AE1928
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597DC1629F0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC768260589;
	Fri, 20 Jun 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mOGYRu+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11298236442
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416112; cv=none; b=ol06NhUKsgugtoc+ZSVmK3ByHcOI8NXGrty6HGZVwbsrfMRUKYUsUHgS5s14asTH4Qy5feGnxIRU+SlbatYLWF4dk/Z89Fg9dg/atbO42jBUE9r6JhgpsZSMHRLehEyP+SuZTDJjPkuBmtL35qSt9fP//hhQvgenh3CAPCcx4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416112; c=relaxed/simple;
	bh=q7jUaZeCrfpBs43z9Hy7QBXglV4bT2WecERgxgwdQc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JwK+4HI6DeyjQvYWgA2nIvKXqkW5JCSQrwFrqzkzlsg+ED/Qj8wBojBRyX0SDoS6GikOXikOplGABiRbzhq5WQskd478/YEQlagqD6cc9+JHzb5XSYaSYPWNdWqrltouRpM8d5Faxyt2wnG9Pl+vTKC+RhNJXeGjyDOvRrhPTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mOGYRu+B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23508d30142so22801365ad.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750416109; x=1751020909; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfBsCz2FCCDcQNBUcihjSy0xTy3M608ho2jYmxxH2PE=;
        b=mOGYRu+BL9MOqtNolhYvfz9FPpJnt9lK/ETlVNm2UO8Sl9MWlVsfHyZHOzZxc/iNfx
         KYbz5yx17wr9DZ1O1Q50wJ359EMZT4nScuptntpqO8vLKFtKcsh1d2PEcZAixj5XkmMv
         daHUCHwKFZqZuIHQT/tDmTjJpD4B+UsFvWhjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750416109; x=1751020909;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfBsCz2FCCDcQNBUcihjSy0xTy3M608ho2jYmxxH2PE=;
        b=HgB4ydMZVnL0TlaVrjgqU+VjetwfCE5BjjQfxd4TT+Hpa0s//10r5B1mmEGbwBTXMP
         ZRFk9wRUlmoDfJrAISLjn6u6TQc8PiuJ7WKS6ryKyaHDkUrjtUNyL6MjjKc+hwTPcpcR
         IiNCdhZN4TQirWbmjjBwjZujdJlmgPgY0PBoLg6K+o+GH1FoCbtLxfZWS9gaU1+fSEEj
         w7bgrXGwVEv97V0KKsbcbZyJ5PWNc7QozXo+mNPbtXT5rEzK0Mcctlhax14H3AlKdFBi
         4loNhv7wNWBn4zQp75hXGpSCo6keRxtfviGy7XiIKfGwFcfXGcq9/poDieWD0RX/5soQ
         nD1A==
X-Gm-Message-State: AOJu0YyAsAyOnJMFjnrkTnmyqCN3fJMYDU+aQ9Fdep833SGvdEPPUiRC
	IzrQx49KWuSMY7EySI0bj2iT+BKOk8TVEFAAxHct7B6eXL3E9cv//jkXqoup44KBGg==
X-Gm-Gg: ASbGncsXP6Xmi+9Wl1ygOXqiuYWWXaWEHRCUfTr9EzfWoX+iugdIqQ1D2mr63qyHttP
	fbTXI5XVeuk3B21F691l1AgiYbbZw9SouhPJv9fQF5KJdygjVxFxlJznrf5WE6PnR3ULPvrcIDl
	WojENoUR+zck3/pPhSuYggej3Ubx1Osdxh9LM/Z8fJjLscgns2Af6hqQDQm7/U1AjsbpbQyfKNj
	jV7VMFBzlq48QZjvCC89ew7k3aQFHmMclxowJ5zGHpDrryYYfzZW3xO+2y1Fy9lqBUUDmymuIJZ
	pK/zWkF5W6KGYTngLRvc1zJ2hmBe81L5f0icwDyzv1H1qYrr42K5uWBuaIHsQN9A8s3tw00qQfD
	LxB0yhb47yaUtzpjJ6lZB+R1/Q9FB2R8LhBCbnbQnShWcAV3fAx1zlRTPs+e/
X-Google-Smtp-Source: AGHT+IGnMQSZOCLVg5rJlh2wQDEMq63wQi1fyNPC8G0fdeVlnF1TnRsHCW3F6Zyk5iZTU+Ts1fj2OQ==
X-Received: by 2002:a17:902:d581:b0:235:2403:77b6 with SMTP id d9443c01a7336-237d9ad2891mr28004285ad.37.1750416109370;
        Fri, 20 Jun 2025 03:41:49 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (243.106.81.34.bc.googleusercontent.com. [34.81.106.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83936c8sm15444775ad.7.2025.06.20.03.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:41:48 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 20 Jun 2025 10:41:43 +0000
Subject: [PATCH v3] thermal: sysfs: Return ENODATA instead of EAGAIN for
 reads
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-temp-v3-1-6becc6aeb66c@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOY6VWgC/12MQQqDMBBFryKzbkoSjWhXvUfpIjqjzkIjiQ0t4
 t0bpVBw+T7/vRUCeaYAt2wFT5EDuylBfsmgHezUk2BMDFpqIwtZi4XGWZTUoMotSmwQ0nX21PH
 7yDyeiQcOi/OfoxrVvp4CUQklapvXCqu2lB3e28G7kV/j1fke9kbUf88o/fN08mRRNWQqstaak
 7dt2xeFbZ/R0wAAAA==
X-Change-ID: 20250409-temp-6ebd13ad0dbd
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.14.2

According to POSIX spec, EAGAIN returned by read with O_NONBLOCK set
means the read would block. Hence, the common implementation in
nonblocking model will poll the file when the nonblocking read returns
EAGAIN. However, when the target file is thermal zone, this mechanism
will totally malfunction because thermal zone doesn't implement sysfs
notification and thus the poll will never return.

For example, the read in Golang implemnts such method and sometimes
hangs at reading some thermal zones via sysfs.

Change to throw ENODATA instead of EAGAIN to userspace.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v3:
- Refine the control flow and optimize the success case.
- Link to v2: https://lore.kernel.org/r/20250512-temp-v2-1-048be58eaaa5@chromium.org

Changes in v2:
- Modify commit message to make it clear
- Link to v1: https://lore.kernel.org/r/20250409-temp-v1-1-9a391d8c60fd@chromium.org
---
 drivers/thermal/thermal_sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..d80612506a334ab739e7545cdfe984ab4dffab7c 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -40,10 +40,13 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	ret = thermal_zone_get_temp(tz, &temperature);
 
-	if (ret)
-		return ret;
+	if (!ret)
+		return sprintf(buf, "%d\n", temperature);
 
-	return sprintf(buf, "%d\n", temperature);
+	if (ret == -EAGAIN)
+		return -ENODATA;
+
+	return ret;
 }
 
 static ssize_t

---
base-commit: 75f5f23f8787c5e184fcb2fbcd02d8e9317dc5e7
change-id: 20250409-temp-6ebd13ad0dbd

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


