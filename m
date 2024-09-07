Return-Path: <linux-pm+bounces-13843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42397032E
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 18:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2A3283D6F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA015FA96;
	Sat,  7 Sep 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjJ5ImNA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30FB657;
	Sat,  7 Sep 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727003; cv=none; b=f6+TTXuKbH93JtZgtQ6t4HO9wcZSNcK7XsScpcuD0aO2BsLU4Mre3VfafNtUWB8+VyKSW9VsXh8f5Oe9sNmExrhgnpoOsizLx8Wsl1ciBSXwMLYUytRV37R85hQpaKAe8mNMgXsYlW1qPBIZGrTDCSb/FQPyfCraPbHFmylrfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727003; c=relaxed/simple;
	bh=J2oHil4s5j6fDRPPMOrCwMnX9TKV76ZFuBNLxjM4vo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3JJ35yjyfYPWd2E9A0hoZZjuTt69EgDdBuNnP5hZ8DQDE7YBHgKdRB+Pi2+HNGbKFSBXYCQguZrRcPBVCQ+R3MPL2rlCHyFIrU7AMFvyW7jE5iu7oSIskw8TRj+xwG7u4xnHQPBZlXdjg8Loij7S4iyPbPpIDFjf22bl4t8978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjJ5ImNA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1992804a12.2;
        Sat, 07 Sep 2024 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725727001; x=1726331801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66WiSZsVUBQEEsHoVHWVdIuUou4pZ/NswnAiyCAcZ68=;
        b=SjJ5ImNAEzCvTU/UCo2kJKzwa2K944HEtJmOalHJK2VXDfCmsjewqkJhrJ6cpLiAgx
         qp8D5+LgrAG7mdO00OEcxEFMlPDMK+xu/hK/xe9gvn7oEENtQM3PIMbXrlZzC/q1OHy+
         OVLT7tioBVmXm3+jC4+iZuanmMnRIZ8IPrrc4hWTNuaVaH4tj9TlmwVn79xYukHd8vzj
         RTr8+zbEV0YZv6Z99ek8vLmUReXSucDKlQRbBAUvH/ZszHPErailydrlTZNfLp63XYuA
         /QCN3/141FvkJw24oyqSsFa/okNnl9nz1+XrTbqWpnsDChUN9iQuWdQQJeoGk6/i4YAd
         jz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725727001; x=1726331801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66WiSZsVUBQEEsHoVHWVdIuUou4pZ/NswnAiyCAcZ68=;
        b=GC03V2hD06/O3KUaed1hpBFolAAht+sxiEymcNBRpTc591LplHX5sjf+yxmYhraoVx
         /7495Nd6aQHsI7Jl4AiIqh1WDHY8XrKyHqi1/6A/VGi0v5lLtj2wX1qtkIQ7AEnP9B3H
         +K2ZJ+sxLzkGLDtiCjPeH9sPD9KRSZveqjiNW/kx4FQpwZSlQzJYD94MvDWVlW3Rf+gm
         qeJGQSU5XqSB/bP9hd3BR4npdc5QctIzxI4DPPszaW0NUgxND3dG4MsAr/nieQTIzcLv
         amTE15A4x438vJfV+xQsFcRl+TGOSFl5eNe3Qq2HElAibEOTSFXpyO5oM1qRkVL12zSf
         +mjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnBthm6htdf8neixAJrR4RUwjZCLjwTTyWoMVTgMEallDET6NnbOzF6q2gCyXyVAK68rrY36zuuqH7RM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpiU6ExjhJm7XLaStic7iR4x95KqLhm2b0fXohyXX9QxyCSf7
	j83wTXh5kRymAmFqxcOgxjfn313d0cyvYsalIP+O23tRfzt5P5Vu
X-Google-Smtp-Source: AGHT+IG0BAdsFfZ4BSvpTajwHLdND3K1qnRpWO0OkCWsycd8lHP4SZ9YbPKgNXMRc35W3fybDOb7xg==
X-Received: by 2002:a05:6a21:3a87:b0:1c8:b336:4022 with SMTP id adf61e73a8af0-1cf1d1bf3eemr5790838637.36.1725727000752;
        Sat, 07 Sep 2024 09:36:40 -0700 (PDT)
Received: from fedora.. ([106.219.163.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e59687e2sm1055194b3a.114.2024.09.07.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 09:36:40 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] cpufreq: mediatek: Fix resource leaks on mtk_cpu_create_freq_table() failure
Date: Sat,  7 Sep 2024 22:06:30 +0530
Message-ID: <20240907163630.55704-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mtk_cpu_create_freq_table() fails then there is a potential resource leak because 
memory region is not released and IO memory is not unmapped. 
Added error handling to ensure proper cleanup of all resources on failure, preventing potential leaks.

Fixes: d776790a5536 (cpufreq: mediatek-hw: Fix double devm_remap in hotplug case)

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
It is more of a extension of the above commit as this error handling was missing in that commit.

v2: Fix commit message.
v1: Added error handling.

 drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 8925e096d5b9..3b1303f350ec 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -207,13 +207,15 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	ret = mtk_cpu_create_freq_table(pdev, data);
 	if (ret) {
 		dev_info(dev, "Domain-%d failed to create freq table\n", index);
-		return ret;
+		goto unmap_region;
 	}
 
 	policy->freq_table = data->table;
 	policy->driver_data = data;
 
 	return 0;
+unmap_region:
+	iounmap(base);
 release_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
-- 
2.46.0


