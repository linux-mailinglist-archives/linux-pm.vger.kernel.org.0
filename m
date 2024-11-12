Return-Path: <linux-pm+bounces-17456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECD9C627D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 21:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37B4282046
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C0219CA4;
	Tue, 12 Nov 2024 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTqceyQR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CA214422;
	Tue, 12 Nov 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443080; cv=none; b=SGtcr7e/UtCJK6e2S7hkGQYRoep5TSYdXDCSBt5XjurJ3pFutnd0hBtvYvdASOuoOrS/cI1O/EZOohHzUKmQ4eYQljtr5dXdI4fcNRei3gRPAIkiOwtDIJRrr7o/HJ5/1mhK+TD2KhnhbIZAxz8AXs3uSaRurrnzOMS1Gj9vrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443080; c=relaxed/simple;
	bh=xZw5haos1ld6yv5nzPymcFSveT2KoHF7bDsMCR8H27s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R4L3kc01MSOv7nT14F4V+pgTPIvVs6Afeln9yKP1p/hmoqpwBuiFf70JnGy25XBYcXVBIPwlc3JbD9KBeQQMFreha1ndgkqIynSW1oq8q17a6JmiQ00l34FgTkIhurSUdg433vPDQ9yYtZ9gzbJidLtIpE9yy9ypMaBhK/zMnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTqceyQR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso5611947b3a.3;
        Tue, 12 Nov 2024 12:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731443078; x=1732047878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=270BLjS5HCsb+r1rogOxxK6M3BPUdx0UJy73IXWJm50=;
        b=GTqceyQREIsvcca8GubCebpf7JMeS4pRTLuOacYb90izvZK0I4zLCpk2ma/ZY6F005
         G2zmlNIkYmxPmULs8/5Wz70n7CcjcCfIB9GqG720JJct7jdW8sgD0jhhBQ2igZ3dngFG
         BYFvElDAesIVxos2+H1UfhEmiMHJ77sEbRMBZiLCQyj/z5gdLAlaCtiEhlxXGPkiJ3d7
         GOJHKv+/ss7EMmsC7T+kSeYxff1pRP62MQwLU/5Cuq+9RjBmyzxLvwgYz3bhaZl8SHRO
         755KtOnMilgqxrb2cP0g3WMm5Dj2v019qt1k3QlpP7ST2mYydueur8jr9ugszXXu58Df
         iVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443078; x=1732047878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=270BLjS5HCsb+r1rogOxxK6M3BPUdx0UJy73IXWJm50=;
        b=Oftqw2cPeWfRZ89kbYVxtaqz2ORmV0OOQsBblWT79vBbMSY5WxdgxSNdgbGBkEq4m7
         pTJIKVkLlcwVNHV6j4R3PdsJxW26ZA4tWqm4YiK3IP6FnhU2shyd4hvYzBjruMUJ4WiA
         6HPEXDqsklsw/fVix3Lk28lbRsWe7z8qYgcF2BZhtktNpiHqSRXfNC8o5wvcaN+4t4qv
         0+ROPWW05HcwG2oQIpPhWduTi+3CC4VhJ8DZ3mC5LCquzdtwFyYZa9/iohWzWmRTF9/M
         pHmIGdDl/N93FOhcfllWt200z9xXC55dj4N3Sx/CupcASCzT+jHowqB5jfi6YY2his4F
         ltLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiq5wNjcTucJ14Ym9RP51t5eeyCPXI1U5aVISSRQF6Wx69HqMaVKDhHAzrbaxVTSLb9QjH6+QvKizoA8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaiDnc+azT0KVKcOCRhMM5TQkVv71a3w9NH+bYAFsHMSQRKflo
	RUYJxS+88M6vCfjodJgs74C+uMx2Ib7IdHKj+hJuVKRKTK+apY3X57h43A==
X-Google-Smtp-Source: AGHT+IGF/Lrsf9yOnqhR5tUB5kmgLuT40v7w3nOeMnTmcwXq9wrXw9HgP1p+NoH/8Ew8aUWRdeb7Hw==
X-Received: by 2002:a05:6a21:338a:b0:1db:f07e:8ab5 with SMTP id adf61e73a8af0-1dc22b53668mr25770666637.36.1731443076886;
        Tue, 12 Nov 2024 12:24:36 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:23d:98b3:efff:2469:dece:37c7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f642bedsm10907361a12.67.2024.11.12.12.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:24:36 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] pwdomain: Fix ERR_PTR() dereference in core.c
Date: Wed, 13 Nov 2024 01:54:22 +0530
Message-Id: <20241112202422.17113-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

drivers/pmdomain/core.c:509 genpd_dev_pm_set_performance_state() error:
'genpd' dereferencing possible ERR_PTR()
drivers/pmdomain/core.c:970 genpd_dev_pm_start() error:
'genpd' dereferencing possible ERR_PTR()

The function `dev_to_genpd(dev)` may return an error pointer, and
the code does not check whether it is valid before dereferencing.
This can lead to undefined behavior. To fix this, checks were added
to ensure that `genpd` is not an error pointer before using it.
If an error pointer is encountered, the function returns the error
value using `PTR_ERR(genpd)`.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/pmdomain/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7ed..69dc8471e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -506,6 +506,9 @@ static int genpd_dev_pm_set_performance_state(struct device *dev,
 	struct generic_pm_domain *genpd = dev_to_genpd(dev);
 	int ret = 0;
 
+	if (IS_ERR(genpd))
+		return PTR_ERR(genpd);
+
 	genpd_lock(genpd);
 	if (pm_runtime_suspended(dev)) {
 		dev_gpd_data(dev)->rpm_pstate = state;
@@ -963,6 +966,9 @@ static int genpd_dev_pm_start(struct device *dev)
 {
 	struct generic_pm_domain *genpd = dev_to_genpd(dev);
 
+	if (IS_ERR(genpd))
+		return PTR_ERR(genpd);
+
 	return genpd_start_dev(genpd, dev);
 }
 
-- 
2.34.1


