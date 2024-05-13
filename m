Return-Path: <linux-pm+bounces-7776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756C08C47B9
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A342868FD
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D776C61;
	Mon, 13 May 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbP8YA6S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFB7580A
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629276; cv=none; b=lRJU+0J9ZtFh87qYr/9iBR2TpYATxq8UB/wDTxaKGzS15xqBFLoOwo2qxYfPUbp6Q+AYOgsIVVqJ/L6ucBhDpChEmRpDfyRrZDwvhyWL9mg9oEF+0vsmZqk5H3FD7rkDjU+PasEzH+GHs1ubZq5eMGpHxsqM7UzjuGbNXqRtLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629276; c=relaxed/simple;
	bh=3ZVh9sHqILep7DYfSMAfVNaTbBLJQ+M9L+1ja88TU8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPWNmNsioDswwUdos64E9MLVQkjc5qxfAVgTDnQn67RHPkKnCdfngcwoUSepY5c7fyXFmB9fnu0H9wMrAtL3YUCaz1AkEOkwPMTBSAezFHeLUPBoa7cNi++konS0FeAsrJAr/nG+sztjBjCSBMKqZ2xA63/NszYt03wmhWs7II0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbP8YA6S; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61df496df01so37255177b3.3
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629274; x=1716234074; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Hdohdn/RiH+d+sV8+sERzwcnXN+3fa467iJE7vvbzQ=;
        b=JbP8YA6S/bTMFKLaiNOo68d7LCcnvV8515bXCUksaG0tSyhQ8hXvelklkUjR884ysL
         0pRJYS/twhxYJMG1MPiqI0zQAnFrRjj5/Agdw2lntFr40mck0qp7tDXoEc0+l19JyYOz
         /uzCbmKRlRdD4BMcPGQZtf/8eei3ioFPVJxHJeqIEhwWHu1so9j1fjhcL0mZQ7eacGQy
         NbULI78wRPPAl6BPpMjCK/qdLdqXL9QDHg1d2XqvNC1XketLpwzrZ49iCDLKh31Qntt1
         uIeP0AQh8o6KDrduEJzxNWjep4wo9Y2WFS3kNH65GyQ0oe+MrOeQ0Iqpa8aS1MnAIwVp
         NS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629274; x=1716234074;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hdohdn/RiH+d+sV8+sERzwcnXN+3fa467iJE7vvbzQ=;
        b=Q1cL/IO1A7bXhyBl47c2XaBAl+VI+2iprtX4qrbgx2RjF1AUfGc9dtrIx7Ckg2zfCI
         ZwyyrRI8ed1TelEffyqWB13b38EVNE2YZ20QgQ332gKIc9kMhzDeh7gPnF/uDw2J61+7
         HaB/0aAbEETKYy7OJkAYnxxNwyab0o/1J4VluRVSqfZ4QJA0eJxZWKFPKQdEFvtX7ZVv
         6oawF4YJ1aNtcpBZYTKcgNyMRCScwqexG/+mI2SPH13Feb3a8ZJvSSMDNQuPQiFpAxR5
         J8FYa/YKx6pNAJpFIyfuVmslePEbbiv5uNYPCOXqhzyGKi7Q6QEkYhQTNF7HOTGzcF2M
         jNBg==
X-Gm-Message-State: AOJu0Yzwvj8t1cEW4hP0P+X6KP5avmf3MbuzoeWIjm2oyUyCU0A5ZY7X
	0BWMqzFhm6wusfHn/C8LbPfMmviNbaT5LZpMtLhJ29iRMt2IMY2+CMu3NQ==
X-Google-Smtp-Source: AGHT+IEklxm+iK1BlGDHQnDLmpq+5soeBaHEVvOlvakdFqGZNz4hZfV5ZsQXlAc6yAX0MBcFPpC/Bw==
X-Received: by 2002:a05:690c:4382:b0:61b:8623:3718 with SMTP id 00721157ae682-622affda7a7mr87642887b3.42.1715629274041;
        Mon, 13 May 2024 12:41:14 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:13 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/15] tools/power turbostat: Replace _Static_assert with BUILD_BUG_ON
Date: Mon, 13 May 2024 15:40:43 -0400
Message-Id: <d3e6f6253895f499b63bac261b81732f9efc4902.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

So it compiles on GCC older than 9.0.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index fadf96934f4e..bd6cb31b7099 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -38,6 +38,7 @@
 #include <stdbool.h>
 #include <assert.h>
 #include <linux/kernel.h>
+#include <linux/build_bug.h>
 
 #define UNUSED(x) (void)(x)
 
@@ -3467,7 +3468,7 @@ int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data
 		}
 	}
 
-	_Static_assert(NUM_RAPL_COUNTERS == 7);
+	BUILD_BUG_ON(NUM_RAPL_COUNTERS != 7);
 	write_rapl_counter(&p->energy_pkg, rci, RAPL_RCI_INDEX_ENERGY_PKG);
 	write_rapl_counter(&p->energy_cores, rci, RAPL_RCI_INDEX_ENERGY_CORES);
 	write_rapl_counter(&p->energy_dram, rci, RAPL_RCI_INDEX_DRAM);
-- 
2.40.1


