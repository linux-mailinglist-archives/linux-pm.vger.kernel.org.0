Return-Path: <linux-pm+bounces-27661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B0AC3F40
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B520118985E2
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447720127B;
	Mon, 26 May 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e4kzRv9X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597381FFC50
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748262083; cv=none; b=OxhF/smrOCP66mwPzqLZUO14pt6TDCoMJmXQ9UGQKLBVx0ttn1sA8hpIfig16fh7BKxv4A9NBTG7oPgPHY9mbodxix25t7EKZ8gaNmD8Lc4V1I/exaff9+HhgPHWRc4/x3HOKkVbPDEJy6xq1bEyyqr7ATmLisk52kaeZQsQG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748262083; c=relaxed/simple;
	bh=OSjenUtGeUxY2QKIW0qhPspnf7oHuTj3PCtjTBlzbp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWeUUfAPftQnxVoB1Ih88ExXDEu2wBsGTugqz3TujbfVxGnr8HJgX9H8xyTES2pwS4kX4mfAOh4tplsAFZBewZAbWDt0N9ByLT12kE7PfZ2gZzGBPCqJvt7IFytxVtVVZmutM0/Ov37UoqY5CI6T1NTXmbZT5pqiEnQhyYz6HEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e4kzRv9X; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad56e993ae9so430364866b.3
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748262077; x=1748866877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=768zz3A5MyltBkQLlSbOf4oJniHEYxMfBQNxunlsy5M=;
        b=e4kzRv9X7YDuVP+psgZDvgW2JfxVPKQjZGqnHmZ9nazMd8PSdws/UwD7htHySuvzd9
         lDDDuEjaJD2+QeOhzmL+T0NmYGm1rPgIdsrqy/0VHiTGK8N7+F5UbKeRT/yulQjQq2f7
         g+1FZXOwttW2qWUoPZKlVmme8oF2sVrT93wJcmwJqdjuzS0LwiCW1T2EkGSDVjt1Ndfh
         RoLazqb5d+nnzkkhmKlotpWHeHFZLuWpvYk/w2+jumB/xaIYPq3WDTsZcxLNDZVeNEnD
         QXIpoptNMDiRNrXpQGhO3pqRJUmhZ9EWGqcVv/JIgDSBFdXLJ5SCbZOzPNMkBs/Kg11F
         iFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748262077; x=1748866877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=768zz3A5MyltBkQLlSbOf4oJniHEYxMfBQNxunlsy5M=;
        b=NwZu63k902rjzE+92A2BtRZTAvZK1X/6fuOsvWU5KdUElxAJDGK2L0OCamfGY3XFMu
         domvchfiZAadK6RxC+QDsMAXRSRBtvZ4w8XXcBO/Qa1yJtUuMguks5yezyJmR9DHvOUF
         h1r7201sjbjBY/4o+xjGDcMWarjThCAHYCBqIB54zr35wUj6OhSoBVSJQENPCs/iYe54
         yD0Wg1PETZMQR/McTV+kTYGj3C+OgC6NHhLrOkbF0Z0ZOOcYy50C1PCURp9KpsD8q153
         91v3votoq1p21JOy+tFI2Xe/nWcU1/ZSLfcMSja+odK9dbzrrlPig9wwsDVYrKV+8NT2
         VFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVocPbCv+rZQmTnk0xeHJnnZjbugAwbJc+LfZeoxH9o19rPg6Dcc8h3AbCR37DRUuD3g6vQ6zj5fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvDfeAVTtxXO+tRLYuW3fLr9KURaT4ZWJ/H48MNA9f3fqScyN
	W5jJdZKFKkHtRl+JsPkTpJQCeJ8LrqowF6Oov6paX2UEbkmpukgk31bitJ15Xr1v2Nk=
X-Gm-Gg: ASbGncseX1n2epgUYoRHe4TSJDGo9Q1qyfgUgSyo9hk6Dti4WC68PVxPMJJ1gqA3eTH
	UsZGkAO5/XJkDIjWARDOyGNGWcKDEvGw0J5Mx+P+ndvgxYQK/d1qkAMKDZBhn6OHqozKTTuN6+6
	SyeVa7O62+upHy4ynHO2QdEbA9ymgS0zaGxkkVS9HWjBFaBAWBw//kbie/dvWg+p4G4gfAK5wd7
	VwbtUUqZ1C7u/qASytoFjnkdW3uYNd+/wX/zhYucrohmkC+xFvNwb7kkZDypVLN+5PP8umsEB9C
	keETKT24Tev8NC195wTURCIGxyFa1WVXF30AflIGqA/tSGzfVD7ojL0uUcVAp7w+U0S9gpgLY3d
	xd8kt
X-Google-Smtp-Source: AGHT+IF/1QayFTF9qsFXVEeDjJ2ecvcZuUY2FjpmdnnRWet2lfUsBrEqZWoEsIXUVBdEMDGEtRJkAg==
X-Received: by 2002:a17:907:8dcb:b0:ad5:1fe4:4d0d with SMTP id a640c23a62f3a-ad85b2065d0mr729565366b.61.1748262077456;
        Mon, 26 May 2025 05:21:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d071c36sm1687630066b.64.2025.05.26.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 05:21:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/2] PM: domains: add devm_pm_domain_attach()
Date: Mon, 26 May 2025 15:20:52 +0300
Message-ID: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

As a result of discussion at [1], series adds the devm_pm_domain_attach()
and uses it in platform bus probe.

Please provide your feedback.

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com

Changes in v2:
- add devm_pm_domain_attach()
- drop the devres grup open/close approach and use the newly added
  devm_pm_domain_attach()

Claudiu Beznea (2):
  PM: domains: Add devres variant for dev_pm_domain_attach()
  driver core: platform: Use devm_pm_domain_attach()

 drivers/base/platform.c     |  8 ++---
 drivers/base/power/common.c | 59 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 +++++
 3 files changed, 69 insertions(+), 6 deletions(-)

-- 
2.43.0


