Return-Path: <linux-pm+bounces-33758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0ACB429B9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E953BD1F3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7EC3680AD;
	Wed,  3 Sep 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXhpDnB7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC831354F;
	Wed,  3 Sep 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927267; cv=none; b=EimBVMSBg5pstafDO07Qp4kKEUYTEUz6QEPt7wMQZ/wRvs/Txeiqoe1Xaw3GaAEirqeT5fj5k94QZSsAL5O2EQXFo5btb+ni8vmOIYMWpPATpY/HIpuczNoZO1KtsdDTrjCTj7lA2k9E7Y09ZgCiXNeAbZw+0ogyZ2HWGhRTfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927267; c=relaxed/simple;
	bh=aLD9XsJZLNrGfgU8JkpGpMKsfl8VuYpXTJJHY27rXrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F05iSZhsX7gcutZTxQ8B9NmtE/kdWQqD8ubxjGFr2gI1YFgSYYFoTgSInSkS8nUM7ml8cr5ouKzJCpFNXYMUgEiFQX+ZILPxvDVUhcISSfSGDGXvxYzmlZIaAKA+l15bQhijMRTUT98HYJ9ibhQX/iBWn4qZI/6cwnk1CL0+OUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXhpDnB7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04271cfc3eso30058366b.3;
        Wed, 03 Sep 2025 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927264; x=1757532064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNHasVCS6vOy7hyKo8I4nxHuz9FBhu/ttxTxBrqAOVA=;
        b=QXhpDnB7yrSnR8fjT7taLZEhjgUJYjXZto2jzk7cExMuv4ToVRBnpZKZ4WXUb5IsJH
         +TKCcr1nSX0/gz0ONtQcpKNgpT+C58amrDtNLk2CQP9lXD3BrKVwXph3fJF/Iu2SM9Rk
         e68sTtK7Dat+aLqKZYLeWvM8YOXZ3hQA2UlIn4ShCF/2cyBJe2dMPbMz2cJzK2WlJJiN
         +u+bIVzm7Ail5PKeptVjsP5Z9sC3/BPcCmH+5JMweiiWEQ4FpFx94FNAJDzNBUMUezT+
         vqIugchHskHuCy6p7YU+xatlb2RoeB9G7V1BUn+Gnr07qpLzQyAYOmhjuvgHPXi2W8i+
         A+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927264; x=1757532064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNHasVCS6vOy7hyKo8I4nxHuz9FBhu/ttxTxBrqAOVA=;
        b=lMPjPLfTDnqMT0o7pHVAN84g/TR3mzAvf+gNlnH8QnvYi1Mp3YX8okHQp6ge5Dbar+
         80a5C1P/D9jOKKA/SzUs85JL+6f6x2QPkQne4qn+NRjyIins+79Ixk3N1+8LNCl/EP5A
         l3TRcbfbpB2Xazt1N5VYHvwjPC8K95L/1G45H/z6jAWBPwu5ltwF2jRN4k78uDmSACIR
         PPs36eZx6tOt8sx1jRMZeQntE/kfpzP9tsj1FtX/oSKqMLLNqtXh6AImCh2xYxa4m58O
         J4iCs5rCadkv7rerWNEex/ld4ygeJPcKQWHxbG+TTnEVkwrXaG5CzJyBWkkCzcEW683j
         OwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaH1knEus22S2DW/5g+svzze57X5weNmHDFXYaKmfoiuoEltldfEi3q82LMzsOT/99cQaUFq7KvnZHe4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCvLECWIZjNGnaks02haSrM9iGRRkq0dULIo/G92Mcvo76BblP
	/YTDp7Gswc0PzGk4iGDIlW+oVS+VHlbQBkQTvC01ZDhb2Z1H/MPIfHcJ
X-Gm-Gg: ASbGncvqSpXIehPRWlTFgkKYZpaYMobi2G5bKEbTk+XUb6J6lJI+CcEaFLX/vwMS92j
	imFudTTxOJiFF09oqX2AcHtyrpqP9ty+mJjeVmrReSJ6Ni/Jfth6MFWSuAjXk/80nd/vMDSAw8E
	uRIhMzYNCRAE6eG1qk0k5Siv0ISMAGB0pQ+/iuxQrqDmu9052dYA88Kl8Q3nyYpcAXuPbqH2SMj
	4+l2vIhs3t85ormbyiz0YdwrJ4adQl6Hdf0ua9uVqSGQr/nE0KRugM7ppMlqaPiIJ9zhB0utaAz
	RVtXtkO5IBPcfGQt5ECAuVFEHj4TvvwD9y3WSyaTWqRBGz9cgj7G95vLw+IoC4EQspmtfKMk7PH
	GtIVPaqW6PBNwiYE5WyayeiJnVMUZ8fLVOBul8YhAVUrit1tR9ee9dSymi8vTqs88H6PMlWboQL
	EN56hs
X-Google-Smtp-Source: AGHT+IH/IfylxWan7vzpeNdmYMqbKq3xELh8jCpPztfoP2R7WN0qlSQYqRfou0E0X2xYkvb1AWhhdg==
X-Received: by 2002:a17:907:1c85:b0:ae0:cc5f:88ef with SMTP id a640c23a62f3a-b01d9731c27mr1626762266b.32.1756927264273;
        Wed, 03 Sep 2025 12:21:04 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:5d6b:7d4c:ed7e:88a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0079183496sm1167273966b.13.2025.09.03.12.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:21:03 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] thermal: hwmon: replace deprecated strcpy() with strscpy()
Date: Wed,  3 Sep 2025 21:20:59 +0200
Message-ID: <20250903192059.11353-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy() is deprecated, use strscpy() instead for consistency with thermal
subsystem since this is the only strcpy there.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
Improve the commit msg: add that this is the only strcpy left in thermal subsystem
---
 drivers/thermal/thermal_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 0ecccd4d8556..64cc3ab949fe 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -96,7 +96,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 
 	mutex_lock(&thermal_hwmon_list_lock);
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
-		strcpy(type, tz->type);
+		strscpy(type, tz->type);
 		strreplace(type, '-', '_');
 		if (!strcmp(hwmon->type, type)) {
 			mutex_unlock(&thermal_hwmon_list_lock);
-- 
2.43.0


