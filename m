Return-Path: <linux-pm+bounces-6202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796B89F410
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D289280EAB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12016130A;
	Wed, 10 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m43+NuQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8315ECC6
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755210; cv=none; b=YDyhy9I2rJ51LIJj9UMml/97UkZ8ppB/gXz1IIekkxsTverhxgHV/QjbotBtlI7q1JoruwOcdLkyA25TNemSzeLMEuKysAKPKwzIXo4PBO3wfxt/VWqhSj2zFCGhft77U2feNGcSJq7JBBQXOB8Ev/1TAvX4NdUpc8ttCA3zl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755210; c=relaxed/simple;
	bh=/Ef9n7M42bFDUPYrt3Pm+LVOM8m6j3u9F5Xbcc3YXkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owBQAwrkDCMAI9FRxcElmwPPFdhWg8zSG4mrc/t3enSrlrKY9sLkeH5SFFi4SXOOSO0qfiQEwJKlXCwTmxBmlVvWSaDxFGy2OKqjrCMR02N1v5WFRBCP/49Of8KFeui2FJs3cNGByzYj5WApswWav3LUqSsMmUECeo4YERs4b2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m43+NuQz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617d25b2bc4so55258497b3.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755208; x=1713360008; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vCFLUGVKui6qsQSyAj3R9uLIpRgi7y3IyyB2kTsm1s=;
        b=m43+NuQzXtdCgS/taAynzP2YeAUb6dU0HSRsT8p1eJAvQ51kwVl1gz2HGOw7kHCUaF
         QMmowTkN2tlEUx2v+mGOtCPMhBU/t2x3dPByj4QoDyJPYJ71SW8cJmEKPUfPl6GKuym+
         35/xcKanaMLdvcAhbb2KXuU1/ugVWMvqqq82DnV+3KSL7XqOl3+4awI8Mqf3FkRcNc8C
         CIp4EsXDC7pqaKpZvv4PaBzwyHsq4hHl6kEsIORnBwzDPyowqhZeGylv/vfh8lIFZ8o7
         zf4cEBLvX7ELRDxmCa+QZBMeJrs06SgeIbdZl4gXavktnPmWdNMlrzXug/QEFfRtFaAk
         QVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755208; x=1713360008;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vCFLUGVKui6qsQSyAj3R9uLIpRgi7y3IyyB2kTsm1s=;
        b=A+O00bIPtLKPEs25Ec87nImE1Pr98YzVeYpFy1CtdfjGdGSsydyGgOpEF+nayADxUD
         7taUM6q8aUstPFXCcWiTYoMtJTCDNjoF4VEcf0Xk+WBmDIPzkz8BbKGPDlpoGfVjbZJm
         qhPjpRnJpRY9ri6HzmFod1vOebwTlE0z2sFLtAgxjJvnIy6EG86uObYr30D+oFwxpeGr
         kvM7A4xvyrUHVKjEccYasN/7XlZkdTdiJufvZFuBBC86jCMIEGLvPilwCAftjH47PlM/
         gRmTzv2yvRg+HxgKT/HL77qBZE5ogLXaD9N4s6cG5iBVBiQMCwse3yXxpHuYpydiaqUV
         yiVw==
X-Gm-Message-State: AOJu0Yx0lPZTswLdYmAH0Ijpckhk1xBFF7hTME1GubNAaaAS5JqsrtmK
	Jqkm/9WVqbiMDbp/9wgZC26HY2B0AmZacgE2tCEaPp7Ht+DlfTr4p1fLsImD
X-Google-Smtp-Source: AGHT+IEBw7I9PJyeWn6v2Ew5YhHyZaAOgNdRhhVhmoPv9rHI9tH2LoCAjTmiNk2uwkd/U7BIgxxzCA==
X-Received: by 2002:a81:7143:0:b0:609:1252:61e2 with SMTP id m64-20020a817143000000b00609125261e2mr2604383ywc.45.1712755208045;
        Wed, 10 Apr 2024 06:20:08 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-b580-a474-89e0-3bb1.inf6.spectrum.com. [2603:9000:9f01:67cf:b580:a474:89e0:3bb1])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dd545000000b006143d243915sm2700864ywd.10.2024.04.10.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:20:07 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Justin Ernst <justin.ernst@hpe.com>,
	Thomas Renninger <trenn@suse.de>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 22/26] tools/power/turbostat: Fix uncore frequency file string
Date: Wed, 10 Apr 2024 09:19:45 -0400
Message-Id: <60add818ab2543b7e4f2bfeaacf2504743c1eb50.1712754901.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712754901.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712754901.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Justin Ernst <justin.ernst@hpe.com>

Running turbostat on a 16 socket HPE Scale-up Compute 3200 (SapphireRapids) fails with:
turbostat: /sys/devices/system/cpu/intel_uncore_frequency/package_010_die_00/current_freq_khz: open failed: No such file or directory

We observe the sysfs uncore frequency directories named:
...
package_09_die_00/
package_10_die_00/
package_11_die_00/
...
package_15_die_00/

The culprit is an incorrect sprintf format string "package_0%d_die_0%d" used
with each instance of reading uncore frequency files. uncore-frequency-common.c
creates the sysfs directory with the format "package_%02d_die_%02d". Once the
package value reaches double digits, the formats diverge.

Change each instance of "package_0%d_die_0%d" to "package_%02d_die_%02d".

[lenb: deleted the probe part of this patch, as it was already fixed]

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e5b6161fef48..016a5c7dc9bf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2939,7 +2939,7 @@ unsigned long long get_uncore_mhz(int package, int die)
 {
 	char path[128];
 
-	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_0%d_die_0%d/current_freq_khz", package,
+	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", package,
 		die);
 
 	return (snapshot_sysfs_counter(path) / 1000);
-- 
2.40.1


