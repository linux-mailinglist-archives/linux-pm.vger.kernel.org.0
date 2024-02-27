Return-Path: <linux-pm+bounces-4415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED6868541
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85101C21FA2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447B17F8;
	Tue, 27 Feb 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3EtBjPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAE15CB;
	Tue, 27 Feb 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995306; cv=none; b=maMytcflrA7LcBeQhyEBjyps3/msuuFN3nFbS+o10ni2D0rYjcqAGRhczPMkMFfQZI9f+B6/56hBQ6beXmiKIj8r4XyUKtMzq31H66TGOCC2TYzZeIfv9tHznaKS+lje8V+0WRlflNsCgEgwHPlnYJ2aWEFHnPn+eYKSEYz6hg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995306; c=relaxed/simple;
	bh=ss8VwZn4a5t6mx/5BWpuy9l0XPO5ja2ql+oKmi1naJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gn6I7LgSjY85MxzJxaPJyXEYVgzlJRHGuqG5EmW2WHWODkrlxelDIPiKHCWdtV+XgvVbHUIMFm/g/CsL4KR/s8YxWWolFiqQwvKsAvpE89pCYhWTswp5lDhxmAj56yFqUy9A71vrt3FBAbwyuMWPCQuEqf05YEfkVRuMHlit/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3EtBjPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965FDC433F1;
	Tue, 27 Feb 2024 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708995305;
	bh=ss8VwZn4a5t6mx/5BWpuy9l0XPO5ja2ql+oKmi1naJg=;
	h=From:Date:Subject:To:Cc:From;
	b=g3EtBjPw9BkQf1JaTfipWe2RSvJN+FjTxpHl8mmlomdAhvj/4Y1I2Le0T24DZkNBe
	 7uk3pXy0MTVHwvHFRzs7JSSUUMXDH+i/wTKyexaAn7wxlGJ9lZJUIPpG8WJoXBdSHu
	 vhIPL0hEmbbIZNyJ/JjsIA7RU/VU2g3JeYNcwTE4wxGeT48sRMl0ehhNGoXR6X72ar
	 0aYHU/vZuK+gX59lsGbNcbxnk8hf0csOhnV2Zafj1V3Y+vYn7hnYbqiWFwCdXRP0BK
	 NXHQOWaDKZJdDbpD35VdzgUQ7AT1fsONlOzG9uJFec+F3sCRXHnOR+v8MmoIrC2u/a
	 MLXdWgVVYvKIg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 26 Feb 2024 17:54:58 -0700
Subject: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOIy3WUC/x2N0QqDMAwAf0XyvEBXO6H7lTFG5xINaC1pJ4r47
 yt7PDjuDsikQhnuzQFKq2RZYoXrpYF+DHEglE9lsMY6Y22HZSSdw4QsG/KiRXjHFKL0GL/zq6i
 kjDf2znjHb9+1UEtJqer/y+N5nj++m9k2dQAAAA==
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, keescook@chromium.org, 
 gustavoars@kernel.org, morbo@google.com, justinstitt@google.com, 
 stanislaw.gruszka@linux.intel.com, linux-pm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ss8VwZn4a5t6mx/5BWpuy9l0XPO5ja2ql+oKmi1naJg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKl3jV6EfCpn4bv2/K1+5c1nAcxxSgyTMxkc86IDc135G
 vZsYrjeUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACYirsHwP07kle3h+3G7nt9R
 Xxc1u6p7a2rBnMfPf16Z5zkrX0R52ylGhrfmh1R3rCtTf/OTYcnvOQa/3ihM7Z07N39DYI9s/2H
 XDDYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
that supports __counted_by() (such as clang-18 and newer), there is a
panic on boot:

  [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0
  [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
  ...
  [    3.039208] Call trace:
  [    3.041643]  __fortify_report+0x5c/0x74
  [    3.045469]  __fortify_panic+0x18/0x20
  [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8

This panic occurs because trips is counted by num_trips but num_trips is
assigned after the call to memcpy(), so the fortify checks think the
buffer size is zero because tz was allocated with kzalloc().

Move the num_trips assignment before the memcpy() to resolve the panic
and ensure that the fortify checks work properly.

Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bb21f78b4bfa..1eabc8ebe27d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
-	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
 	tz->num_trips = num_trips;
+	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);

---
base-commit: a85739c8c6894c3b9ff860e79e91db44cb59bd63
change-id: 20240226-thermal-fix-fortify-panic-num_trips-5f94094fb963

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


