Return-Path: <linux-pm+bounces-26991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F124AB2501
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 20:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5347189D360
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1295274FCC;
	Sat, 10 May 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/4ZNjQG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CA14901B;
	Sat, 10 May 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902868; cv=none; b=blJEBQIGM4I35mP8EA6AnoE24XWipv3YKGVIX+B9d7a4k82UreZj49zI489COJKwENeaITmE5v7RXGcoQRon7/eANhZS8HTKYQcbuvA3tHOHyHuncEh9xKVpXTvafevbskmvsfbDZhs25wbfHfjl1lysKurINE9UkDdxRMYq/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902868; c=relaxed/simple;
	bh=L1j19XD16Pmx2xa/rrGqIBgP7XAqdou4yQFSC/F63nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXHm9vi89vXD9vzeGVxG/m/650KrCoya8Dq5rd+TIhc2eiKg7XDxGdJUkSU8RYA/aCVXzQxgmc5n8HbdD18oQggpVomJVlC5Mdq9PpN2KbKbJLTThDzbbNUYWdsmIyVrYYu/HYTGqHl07DLxkHgqfqkUT3EW/p/BW6d8nhLTfAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/4ZNjQG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af5085f7861so2182312a12.3;
        Sat, 10 May 2025 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902866; x=1747507666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q61TaHYW+ivShFmxukNezPRDLRq+ybo9Om6oxCMvOBo=;
        b=h/4ZNjQGeI0XPnvXdZmSmSgkVmn6bKPHv57oZrXy4SriuhsNXRpDHdAHk008aKai4D
         ONby4KTcVsOpZui9KgMi/N/k4cg2BimZ2+0X7IHKa88mQeylEqWKmj5SlkvZdWXInPvT
         vjfwJ8ZSIwFWyFYKHhi0GiK3DFSaSizhdtCs7MmCY9PML6QIaVpwWm8FOFCIhJYDO32l
         6geDwNoSLzNb/0H616960YdYnsvNBmHPCj28szlY/tOQfuHTBjjkkbGX/ZfB+2r2iLk1
         e4d+vhp8VJwzjWgBgF3HnxpM9djvyyUAXucB4bvXwXLZ7PUgZciMKX0d0Glh1kAlbyOP
         CbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902866; x=1747507666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q61TaHYW+ivShFmxukNezPRDLRq+ybo9Om6oxCMvOBo=;
        b=LX+h2rodQCe5rpfvAQx9W2BZwEtxHfnFgPzcKKltuYwbiSmoT8KZIb6ekLareunFlu
         0xAxowl11ozJux/8kLIWk/M0BXtKfrJlWMtfGt4aoxoWX8xZv9nA13e5e1cdMxvWIxhl
         CiqMlfxa/AmO69pnWoh8pa5wRTvEGiotmltzhl4W8NiHhm9A2CMP09LIbXCwNzvvH/pS
         +iiuJmq7IPNZSjG4Lb99BP6i+/sDsQ1YlSxtb4rkn1D9bPn/EvatNfL0QUn/vzLmVK0A
         DtagmXZrX200HgenCiYE3N0DqNfAnGHQLjpYZoCu0IwcRPQvePnOaGAxZMHgbhsSxpMF
         3pzw==
X-Forwarded-Encrypted: i=1; AJvYcCWVC3fbj7i7K+SJyb5fY5dGynvlwgfyGjjg8K0fEnpRbX9SR7FxOEOjRqkd+p8L6gVBUMw1ieRWCAdvy1E=@vger.kernel.org, AJvYcCXqvHJ55PlrX7pWGnEacQpVSRJUPQrwYE39UeSDa1br4bgY7qkLEafOpTETPbSUga+ZthaT7457fO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCX52MnlUguVOwBzglWtyK2cLz7GGJs02GQw/XM3sPV7qfE9yy
	f9lZHdvjF1jqYLx3uGLYG5h68C6bEeMZsdgS1Cy/7SQofZvCgfNU
X-Gm-Gg: ASbGnctQY40f1De+4+ErkjwNFVvgNNXQz1oKpP2ix+j9gd7abPiuDmIdRv+bCZ+gj+V
	/uRsWyWsQu7mCuQP8g3s+LLpcKjXfYJg0844IcGy1ojfabl/DoR5Li9+PVKGDJ6VSndY9+DvDbQ
	mToNf5Sv8oD3cFj6lYqdehq/3BR+gsOJGc7hE2r1lC0jpzHIXNq5wYzoC37muTDugMkcUH/9QU4
	Z54BhTpGuvY/lRPcWVDg6jv0pmMOoAEs3S1kgZM4YgrkiU28i5/WX2EkUYETz2mQXL40Sk4HckA
	HgfWeCt4XwCpqTkYy9lHdgI1iy+D/VAolFkf82yIeVET3jEWa1h+1zCs/wBAV1R6ZpoT24vrMNP
	4RsU=
X-Google-Smtp-Source: AGHT+IFDX15DHKvx49SFGOI3uN8yupopOlTlzXxH3QBsDKhq46eIZIKSEuAlW0EQtuv21T6o+iDmEQ==
X-Received: by 2002:a17:902:e84d:b0:22e:62cf:498f with SMTP id d9443c01a7336-22fc8e961a1mr125418135ad.38.1746902866378;
        Sat, 10 May 2025 11:47:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:7b7f:bab1:cfed:9805:ea32:5760])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b450sm35797895ad.178.2025.05.10.11.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:47:46 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] tools/powercap: Implement powercap_set_enabled()
Date: Sun, 11 May 2025 00:17:09 +0530
Message-ID: <20250510184709.44935-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The powercap_set_enabled() function previously returned a dummy value
and was marked with a TODO comment. This patch implements the function
by writing the desired mode (0 or 1) to /sys/class/powercap/intel-rapl/enabled

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/power/cpupower/lib/powercap.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e55ef..7947b9809239 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -70,6 +70,22 @@ static int sysfs_get_enabled(char *path, int *mode)
 	return ret;
 }
 
+static int sysfs_set_enabled(const char *path, int mode)
+{
+	int fd;
+	char buf[2] = { mode ? '1' : '0', '\n' };
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return -1;
+
+	ret = write(fd, buf, sizeof(buf));
+	close(fd);
+
+	return ret == sizeof(buf) ? 0 : -1;
+}
+
 int powercap_get_enabled(int *mode)
 {
 	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
@@ -77,12 +93,10 @@ int powercap_get_enabled(int *mode)
 	return sysfs_get_enabled(path, mode);
 }
 
-/*
- * TODO: implement function. Returns dummy 0 for now.
- */
 int powercap_set_enabled(int mode)
 {
-	return 0;
+	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
+	return sysfs_set_enabled(path, mode);
 }
 
 /*
-- 
2.49.0


