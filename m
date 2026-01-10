Return-Path: <linux-pm+bounces-40602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF963D0DA82
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2355030184C8
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4A19CD0A;
	Sat, 10 Jan 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZQMrBcE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBD29D26B
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768070384; cv=none; b=YVFPeI+iQ1E9CjNuMY1qv1M/Nh9vhRUAogR1nGqdpqAkld570Iar/HVqhli6pHRWYfmjcs+pNe1TT4vRiY4snk6pDpiv5OAekIo3HCd8EjsaahEC0ABqpoOsVAwk978ZhYt05Unc/tU/eypSwfR3Gz0zzSvTCABo4oo3k2xIJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768070384; c=relaxed/simple;
	bh=tG5b0ZZOYaz9im/C1ae6r3dSOpoMu2nhWOyHQ7Hzi8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U5bZ/feqKWphv9FG7aflevYBCr+6XKZANO9h5hqFo5kzwvD2Jm8z3m9PyP120HzX89u8FYoefm1p5pUme7y6x6AS0jcbdptxWTbbHynx87HD7jkluBIeVxpetAfPNRwzrc5s357VRAIZKg6Px0nWxEB2tQlrmAMsRXmEOwuQFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZQMrBcE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a12ebe4b74so51121125ad.0
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 10:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768070382; x=1768675182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR0H73f2ByWpvfPloeltikT2h54cekN31/SxwfzDu+M=;
        b=UZQMrBcE0UYHIX9cuiHTxnfEBtG1J6yBgkvv60X8jkRlfD6qq0q7XslkChu8oF7SIN
         Utk/5mBm8Su1qjdZ2pvcUPyqP3rw8ZJOycknXDB274FQp5w6/Bg/H6Y3GL8UU4l9CFyL
         ON6PUWoQ8AK9QNfJnizmM0JSmN1PV5QwURVNf/navsLGIs3J8PXCMKAwgkZhRzdQbjUV
         h1/WWu7PXZsOciDGSyu9/MvwMo0IcmrVDTxxbdQwwTobMW67uAOJJ2hXqbNv4uh0YUih
         j3Pv33sx61P6OTaPqeRN6t2Z6exP1d6r3rJJP2WYdVxeJG3XW2kR1iLqMjkn+/wE9I5/
         t61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768070382; x=1768675182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR0H73f2ByWpvfPloeltikT2h54cekN31/SxwfzDu+M=;
        b=tLh7yBIh9bKlYZKFuOdoUYea3FhbxLSqex1R+7KOLIPiDX0GKonRiwNayXYN3rS/kV
         N5fh0I6d/faLhMBdbRYm2aU0ppUbXoU8quSkH0VVc7dhKV2trBRnbS3DvsnfabgoNsME
         n/PwTrkNWym/KEdymg6fjcRrNY+CYw8u6RhNSAnA31oPa9MtfxA1l1QyQMEpoGZifulN
         9eRlQhqVvgVwQMJdEhAXVmLSeF7/ugxuyr8qFwEcPIAHa3X/A8Kfj7KAcH8lkruLvZvX
         v2eW9CfvQIkOwiWh/LhlR2dhfG1YT5HjZIgyVrm2dUCQu7F9nfqcDiEGsO2/g6fvpJx2
         4Lfg==
X-Forwarded-Encrypted: i=1; AJvYcCUYISDycAAir9MvnWqjrBNMUWgiBy/A9SUP42kNnllC1iJaXgVYleWyyVlb7bdx2iQrv1x8mnFj/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzwwZoGdbjSXIfb+6hoD8b3KG6k5Tmun8pqK/qOkd3urn702B
	ZOAzDge5nSYyYW7v3vu8Kb/PN1vHw3vvDw9dUqo+udJT6PIy4gnplKTE
X-Gm-Gg: AY/fxX7mY5pdbuDp+fjbDepW9WiavC/7Mr4zxYgitDbITOIrLjBsy9vtYW2zpwRXjI0
	sAg2xaqUkpxb/lXXuSTtScSXk/Bwg1Bv1uh/4DnZlPgJc6bVHpu0v04wPY8i7dZfGVB2+QxqJ72
	x4pSxECnokHJLWK8nQUitPN5Sd5PvEMjC5YCHu62/9A0tIPfbdZZ3Rw4i8IzwTWQ4BY/ZtZu8sK
	YXsqKCKcZI+3LV6Ak0/Fh8Ge9DePj3mUi/H0UKB+f1zLtFoL9EDr+LwbaANbYkDJmQ9Lf5QIpdB
	0GvJYiFg5gEJIhQe6HJUSUG79fHt37Nm8V+cFKNCiSTDTHsK4AzmaLN4sfAYop8QuzLw+S2EMJz
	pxGhlU0GC+x7e+Jfn9czBD3kYMnby8w0uEQ4eH3gm/kwcjrZTx8hZlcN7eF25SYPEuUJk3d2qaG
	q00uKYKtGdfFFsuWY=
X-Google-Smtp-Source: AGHT+IGLctB334kNIJMaZLh/2zU4QK/Xm0U+jT+dVLv7LNXPNySuzn+HmSYgtPw+snu7mK7rVCV+TA==
X-Received: by 2002:a17:902:dace:b0:294:d953:6ff9 with SMTP id d9443c01a7336-2a3ee49b44dmr147255255ad.47.1768070382289;
        Sat, 10 Jan 2026 10:39:42 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:5089:d5e0:85cd:c96c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48be5sm135015405ad.30.2026.01.10.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 10:39:41 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: daniel.lezcano@kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] thermal: debugfs: Use seq_puts() for constant string output
Date: Sun, 11 Jan 2026 00:08:34 +0530
Message-ID: <20260110183912.372215-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace seq_printf() with seq_puts() when outputting a constant string
without format specifiers in the thermal mitigation debugfs interface.
seq_puts() is more appropriate and efficient as it avoids unnecessary
format string parsing overhead.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/thermal_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 11d34f2a3d9f..11668f5b3c28 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -807,7 +807,7 @@ static int tze_seq_show(struct seq_file *s, void *v)
 	seq_printf(s, ",-Mitigation at %llums, duration%c%llums, max. temp=%dm°C\n",
 		   ktime_to_ms(tze->timestamp), c, duration_ms, tze->max_temp);
 
-	seq_printf(s, "| trip |     type | temp(m°C) | hyst(m°C) | duration(ms) |  avg(m°C) |  min(m°C) |\n");
+	seq_puts(s, "| trip |     type | temp(m°C) | hyst(m°C) | duration(ms) |  avg(m°C) |  min(m°C) |\n");
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
-- 
2.43.0


