Return-Path: <linux-pm+bounces-27399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156AABD3B5
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338401B65FFE
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1693268688;
	Tue, 20 May 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVy0BD+X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096F25DD18;
	Tue, 20 May 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734239; cv=none; b=B1wOmPmwdzvJykuwAZXbrHNGdbtmRNom3wPDC1fSY7Ydv0O/pF8GPs5zbQ6DB1g5A5eBFLJMcDetCz3jfdJCmWd1wY8h7pMDqktcpWmzxjATwBfOvOrfEGorbs96CeuVQe/jrVFjOkJ0JlK8AFFZmzcLQUNkcQ8jh+D69Kvp+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734239; c=relaxed/simple;
	bh=KRC80vXoGGKP5ZAHY2BxEV2sWz7Ool89aoaHqbBCfdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCUuyDikubZ8BXQdWdG+8dIjol0CS0z2cUVUG1JoBjMdWjL1z/hqL1b6SV9ere0P9uGWQE8skn/xpcmGTjeU+sKJvVbtY1KsedDEx3nc9yNNAmu1CzDHKmRCCgWRnr6c/mo8E7C7ONnPXw/RfmNwudP3y4OVzFH55JkB84ZktO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVy0BD+X; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6858647b3a.2;
        Tue, 20 May 2025 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747734237; x=1748339037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72RXTv/sI4vy4urdgBX3zIYwp1p5m2C94ZkpYBDXKgc=;
        b=nVy0BD+XcjFFNPjkzR/AMwwb34w3bkz/v96UDObzPcqTpyzgacpBbX8NKjNpd/Mz9d
         ZqEbS9nADo1JUQDUUIbxy4JYs1jixGzf0wbc05HQ/71wxiqcgjIbq6vmYbqViaooR4vp
         26BK5Saorq3gGinfMBTS8H/UWSblUuQXwMSaBLeK1Dy5UuZG0R9on/YQzsbV/pnYvNjO
         0GDXIkz+/WqUpllJtYFPsHufeKCj4KtuOz0y7+Q0hS2NVo5pdcXpJ52bPPIIJSXcVRT9
         vk39sqFq+yOLcSo2Q+4ecgMTOcIC3OkS3TCqvkzAN0e+UhJ2+/yToPlktAdKpnZ9iFU0
         vqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734237; x=1748339037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72RXTv/sI4vy4urdgBX3zIYwp1p5m2C94ZkpYBDXKgc=;
        b=lkRwRtsKbCTTXy5BDzudLTAJq4Lewdq8DG+ROSVAc9sQL+fK9hzUTxmQZwv7m+4gid
         DwEKb/uJ6+aK1szJuLgz6bf9yHJmCIffWBaCx+1zRadWc7hGf+AwGpPKmUsKX/nnHp3a
         NzXI4VyBnlESv/vezUnnqHaQ3Irc70CC7+u/3gXHJX9fAYdI7y86bjqBd7z4u1aIQcOV
         KO49WfWxaAISvqnG334FfTUrabABKaU+mJ1WwyaEMpWnoM8f2/E1Ikafy9LBDsEG2nQ1
         SVHn1QuqbIC9uMiDZUG7alPjTk/qDBIAynnNw+C6n1D/F9XFVi848wj26oxdhn0CXvl6
         3Fgg==
X-Forwarded-Encrypted: i=1; AJvYcCW9HSk+zXwtJ0+pF2svqCs/cFWAJ1zvK1tWQIqDUs/smMKaO19nX5+kr9udtnaL++cxL2BtGps7kKE=@vger.kernel.org, AJvYcCWGLAr6bxWplqLeWKrwDGxl6WSCY6JkwJ3ZCs+opZ9GfyKaETPd3mUG/D+knS6kf4aVcnTl5sMyiBajVeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kMTjp0v8dtTDK03IkVf/f49sWRxu1j2G+Ghi6m22OXeE5PcK
	MHc3pejZdN9ntGXQ9QZgxYHmKwnoInKx4Vt9Q2PYRBdIQipPFxoV39sj
X-Gm-Gg: ASbGnctxqNR24fb+XFmmUTydxdGcIhZlgi6/taRILuiHM2KbPFJ7krJ/pdVxVWSpg+x
	xxUVyco6YLSpV9qfl/BvgFY0PMST2D4KXKWAxYX72T11qB+nRNWBW+Mu7shhksdJYJ5zFTVxhao
	TN/wDXfCePihlLZ5Wif/UHZaxmf46NDh7Q4dQL2ZkkIRCNgrV/fUzTB3cUV5FPyf0H4RxEUyH8L
	5t60Ub0qe5RlOhIGtFNTn/Ov61OAjRS3mEOSFiaBhRtj9YHctNo577QDCLbUhlliN57IXLZRW7l
	ObdQK1DzGeibaa9ZTfJzd1rTmsK0CI5gCNFydm6zVlhhCNFLMLYjYAI3L1MfQxA5p1ncpb+v5I4
	Ir+ZhP1v2QcbVZA==
X-Google-Smtp-Source: AGHT+IGowChZd0yBQuEnow5mD+xA969bcqL8YkmmtlUyLJOW3JKKttacw6iwp5p0zrT9Yq8ZzAOl4w==
X-Received: by 2002:a05:6a20:3d1c:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-2170ce33ad3mr24484932637.38.1747734237424;
        Tue, 20 May 2025 02:43:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:62fe:9593:f762:39d9:3865:830a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6ffdbsm6559891a12.20.2025.05.20.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:43:57 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v2] cpupower: Implement powercap_set_enabled()
Date: Tue, 20 May 2025 15:13:45 +0530
Message-ID: <20250520094345.97200-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The powercap_set_enabled() function previously returned a dummy value
and was marked with a TODO comment to implement it. This patch implements the 
function by writing the desired mode (0 or 1) to /sys/class/powercap/intel-rapl/enabled

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


