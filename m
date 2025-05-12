Return-Path: <linux-pm+bounces-27037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B7AB2F2D
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 07:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB9F1715BB
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F372550D3;
	Mon, 12 May 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQGB8xKy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A50535D8
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029212; cv=none; b=e1c6AQ7FPaj4er3VFu6k5iy26Jqv3DpuJWQXP63XE/+vmjwV7cGW9V8MfgBEABZ+SdVwFQo3WD6bapvo/RTeKXCsKRnHNgdAZCb9t63zDipZaHTMYXBGX2m68+YJImw/CJEl5sl6afnGA2iAgqDzJIXsb7vYM/r73rJ2fTfBD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029212; c=relaxed/simple;
	bh=pO/10Sp4w+tIMhMUuC4sGiIHCHnIuB1oYzPtiBR6ENc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQCqdGhgJDJIRrkjFfRpRf8+kfspozeMAajeOlFtgYWR24rfyN+ypM3OFeBqj/gqfYeGLpo56CNFqOYc7OkYVDryw+WnGgiwnRxUclmtdS+yyPfx/nJhmIWyJdKFxMyR0DSgIiMVvXHlQ15SJ7ORlGPnrUga2NO3HYyWZGI17gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MQGB8xKy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4101014b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747029210; x=1747634010; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufZE6FMMhQCPArQT3EihtFY1nQ2Epa4bvOFI1D96UwQ=;
        b=MQGB8xKyZBnFlEdobDdyE6Gdz2uX926Cuc21nNnZ1b/oGxOGX3r/B1I8llxR05wCSu
         ip7pAYMFprF6FqHWGlLFEEREu8kNpU8HJSTE0kpss3BEDLjNrIterpJWrTYM5lNexusm
         eNuaQao1UhU7fLBmaR3zUWK/xw93S+sHvMTJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747029210; x=1747634010;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufZE6FMMhQCPArQT3EihtFY1nQ2Epa4bvOFI1D96UwQ=;
        b=SjNAwXg8okXC5hojoKPrLz1VfZDQZeV6p8SzceQXaPm2XlqCRfeaF93GWjNWjReJmt
         XkDpNbu35hlYfaPodOz/IUj5PdsxrTOhrS3wBJfBiBpsoV6qRWfsw+NEvlKz5fPVnHo2
         GrAGE13QRMv18uEUuHbkLu8rNuuqs6FFgSPDjNJMNQIcoYdTzBeM1Y9XHKKPULnrYlzG
         /V5fZBtW2HkPcGlvAtWFaPrH8zKokvG3Gve2LxT17EKujFIorQ25e0qfAICKGqScwjIQ
         SVpvmjQ7nIv5CI6iw8W9ECfg3108fF2cNqDIy5OfeXZhMGS8ky6bqI6MkujrKdOUYnTf
         BMdg==
X-Gm-Message-State: AOJu0Yx29gJ4KkmpRYU83JRYbMhhgzOLEKIpcuVyg1nvoK8dB+E8CAVk
	/tn9dOxSBvJZTyDKbUWEzH4i+t2lIuFnfRipQ1c8bqr9aJjMLyqGB4/wmKLD3Q==
X-Gm-Gg: ASbGnctTqx80CpUUb0SKpXkZ5DxzLC+kAt/+NBq1GkeaxrmtpCM/cQEnnJgd7joGgh7
	pVT8Zvh5I6VFjSssXkOPo6ifzeecqa9AqqhdgnAhpbZiaJWZHw9PDLg0yvzuHf3yblLMd/vutAy
	hTp19E2xrZ50bMolSCnxfpbz/Ur1CMqYzYE46RmJgjm8hoGpktr85smuscBAow/56m1MSofH6Ld
	QDtACYEfIU2HUCKA4OkGDsW9+dqa/TTa1qaleR4uZRtEQ2e/m/98xj7TF0X2xQpdAvzYwenVVuJ
	pBXiOvKvLVoYUGK2N2YdX8/+XKeAkneq9fUm6gXCg7GW+84Pvxot1ZlGlMhBIL612HTnpyZ7D1m
	BCHXJrMjcF8B+MEXNdxlftmVVGW+pEKndnrtm
X-Google-Smtp-Source: AGHT+IHrVytZGsqVdtC9gSvclI0vKIHM0E3MzRvQ8QYNae0nLWnPWsrQ6Eg2nvny/7pj/15F+cRAbA==
X-Received: by 2002:a05:6a21:32a1:b0:203:bac4:c6d4 with SMTP id adf61e73a8af0-215abc1c54emr19035721637.29.1747029209734;
        Sun, 11 May 2025 22:53:29 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742377050bbsm5364438b3a.27.2025.05.11.22.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 22:53:29 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 12 May 2025 05:52:59 +0000
Subject: [PATCH v2] thermal: sysfs: Return ENODATA instead of EAGAIN for
 reads
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-temp-v2-1-048be58eaaa5@chromium.org>
X-B4-Tracking: v=1; b=H4sIALqMIWgC/13MQQ7CIBCF4as0sxYDVBtx5T1MFy0zLbOgNFCJp
 uHuYpcu/5eXb4dEkSnBvdkhUubEYamhTw1YNywzCcbaoKW+yos0YiO/io5GVO2AEkeEel0jTfw
 +mGdf23HaQvwcala/9Q/ISihhhtYovNlOTviwLgbPL38OcYa+lPIF7mOfJpsAAAA=
X-Change-ID: 20250409-temp-6ebd13ad0dbd
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

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
Changes in v2:
- Modify commit message to make it clear
- Link to v1: https://lore.kernel.org/r/20250409-temp-v1-1-9a391d8c60fd@chromium.org
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
base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
change-id: 20250409-temp-6ebd13ad0dbd

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


